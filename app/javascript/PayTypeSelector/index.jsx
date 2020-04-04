import React, {useState} from 'react'
import PayTypeCustomComponent from './PayTypeCustomComponent'

const PayTypeSelector  = () => {
  const [selectedPayType, setSelectedPayType] = useState(null)
  console.log(selectedPayType)

  const onPayTypeSelected = (event) => {
    setSelectedPayType(event.target.value)
  }

  return (
    <div className="field">
      <label htmlFor="order_pay_type">Pay type</label>
      <select onChange={onPayTypeSelected} name="order[pay_type]">
        <option value="">{I18n.t("orders.form.pay_prompt_html")}</option>
        <option value="Check">{I18n.t("orders.form.pay_types.check")}</option>
        <option value="Credit card">{I18n.t("orders.form.pay_types.credit_card")} card</option>
        <option value="Purchase order">{I18n.t("orders.form.pay_types.purchase_order")} order</option>
      </select>
      <PayTypeCustomComponent payType={selectedPayType}/>
    </div>
  )
}

export default PayTypeSelector