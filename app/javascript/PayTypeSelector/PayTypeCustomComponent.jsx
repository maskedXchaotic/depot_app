import React from 'react'

const CheckPayType = () => (
  <div>
    <div className="field">
      <label htmlFor="order_routing_number">Routing #</label>
      <input type="password" name="order[routing_number]" id="order_routing_number" />
    </div>
    <div className="field">
      <label htmlFor="order_account_number">Account #</label>
      <input type="text" name="order[account_number]" id="order_account_number" />
    </div>
  </div>
)

const CreditCardPayType = () => (
  <div>
    <div className="field">
      <label htmlFor="order_credit_card_number">CC #</label>
      <input type="password" name="order[credit_card_number]" id="order_credit_card_number" />
    </div>
    <div className="field">
      <label htmlFor="order_expiration_date">Expiry</label>
      <input type="text" name="order[expiration_date]" id="order_expiration_date" size="9" placeholder="e.g. 03/19" />
    </div>
  </div>
)

const PurchaseOrderPayType = () => (
  <div>
    <div className="field">
      <label htmlFor="order_po_number">PO #</label>
      <input type="password" name="order[po_number]" id="order_po_number" />
    </div>
  </div>
)

const PayTypeCustomComponent = ({payType})  => {
  if(payType == 'Check') {
    return <CheckPayType />
  }
  else if(payType == 'Credit card') {
    return <CreditCardPayType />
  }
  else if(payType == 'Purchase order') {
    return <PurchaseOrderPayType />
  }
  else {
    return (<div></div>)
  }
}

export default PayTypeCustomComponent