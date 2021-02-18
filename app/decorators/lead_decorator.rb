class LeadDecorator < Draper::Decorator
    delegate_all
    
    def tags
        Tag.joins(:leads_tags).where('leads_tags.lead_id = ?', lead.id)
    end
end
  