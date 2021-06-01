Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9011397383
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jun 2021 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhFAMuK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Jun 2021 08:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhFAMuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Jun 2021 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622551708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZcGsUjeM17DF8Y23KBJIyU7YsG9IgMqzsnjGbIxDCQ=;
        b=Q/moUeo6M/BbZ7qAD35vpCx5dh0fq4AUF/sY1tHMOaGPc0xOzotLEoMtTeCLri1EdhzjZW
        eMclWtzhjrnf+Q9ZNu5oji3vXB5Syx0HvBwcimbNn+PGSSccfXkO7ucNh5M61Qp9nGFX3S
        HbTc8I1yA3zs/JqwoxSCMzbu821W+iw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-3pnhcHYbNzmPJv5PGbdeoQ-1; Tue, 01 Jun 2021 08:48:27 -0400
X-MC-Unique: 3pnhcHYbNzmPJv5PGbdeoQ-1
Received: by mail-ed1-f72.google.com with SMTP id h23-20020aa7c5d70000b029038fed7b27d5so1455486eds.21
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jun 2021 05:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lZcGsUjeM17DF8Y23KBJIyU7YsG9IgMqzsnjGbIxDCQ=;
        b=KdqSFT29jIFtfLhWl1edfwptBzrJW6Go4H3mvqZ+je3V//5OF8GNWYZT3cUgEZY6+L
         U0pVNE0Qf/V+dl/6POQib81RUZ54Gg/nF4bO9KJN51t1QFLz71+OtItJq+m8Gd2nGAj0
         mLpZEYwmolKC6lnohheSNvDkkBeOBAdobh42L5xSIVo0URN4RX0PsZmQG3f1nA1vPoll
         d3yTfrcTzJlCZREKmnUoWUGwitCkJUNtTop9ONYke59/dLeDo4QjFJmW/ApvzueTqjyx
         GiCn+K11JGAK6rlh9c6UfsrZkqANO+cC7bsWTmRWHpZKrGICXr+BEbu43dd+NrPqSoYw
         WV+A==
X-Gm-Message-State: AOAM5322kwl3eV861sYe3ICP4m+2ljidSz34o0bOaZhw7gL3SE72zyWE
        qa35UhVXSR1bi+iqc6daWzz211NYBgSjSnEwwXJoFd7rgTDap2LP3Bua6HnZi+zmQDbseiYciSZ
        3Y0hOKFTMsJc1YqL/g8msEPnobl7Z
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr32858518edb.104.1622551706240;
        Tue, 01 Jun 2021 05:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT4o9fCef8iJstNGh0eh3PY+VROINQBqI1ea71IgfXv5FOIRwxrDjTd1abug9x7HPjelh/Vg==
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr32858494edb.104.1622551706099;
        Tue, 01 Jun 2021 05:48:26 -0700 (PDT)
Received: from localhost (net-188-218-12-178.cust.vodafonedsl.it. [188.218.12.178])
        by smtp.gmail.com with ESMTPSA id k21sm7216391ejp.23.2021.06.01.05.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:48:25 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:48:24 +0200
From:   Davide Caratti <dcaratti@redhat.com>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net/sched: act_vlan: No dump for unset
 priority
Message-ID: <YLYsmMw9x2kXLIpk@dcaratti.users.ipa.redhat.com>
References: <20210530114052.16483-1-boris.sukholitko@broadcom.com>
 <20210530114052.16483-3-boris.sukholitko@broadcom.com>
 <20210531222136.26670598@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20210601123510.GA3940@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601123510.GA3940@builder>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 01, 2021 at 03:35:10PM +0300, Boris Sukholitko wrote:
> Hi Jacub,
> 
> On Mon, May 31, 2021 at 10:21:36PM -0700, Jakub Kicinski wrote:
> > On Sun, 30 May 2021 14:40:51 +0300 Boris Sukholitko wrote:
> > > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c

[...]

> > > @@ -362,10 +362,19 @@ static int tcf_vlan_search(struct net *net, struct tc_action **a, u32 index)
> > >  
> > >  static size_t tcf_vlan_get_fill_size(const struct tc_action *act)
> > >  {
> > > -	return nla_total_size(sizeof(struct tc_vlan))
> > > +	struct tcf_vlan *v = to_vlan(act);
> > > +	struct tcf_vlan_params *p;
> > > +	size_t ret = nla_total_size(sizeof(struct tc_vlan))
> > >  		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_ID */
> > > -		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_PROTOCOL */
> > > -		+ nla_total_size(sizeof(u8)); /* TCA_VLAN_PUSH_VLAN_PRIORITY */
> > > +		+ nla_total_size(sizeof(u16)); /* TCA_VLAN_PUSH_VLAN_PROTOCOL */
> > > +
> > > +	spin_lock_bh(&v->tcf_lock);
> > > +	p = rcu_dereference_protected(v->vlan_p, lockdep_is_held(&v->tcf_lock));
> > > +	if (p->tcfv_push_prio_exists)
> > > +		ret += nla_total_size(sizeof(u8)); /* TCA_VLAN_PUSH_VLAN_PRIORITY */
> > > +	spin_unlock_bh(&v->tcf_lock);
> > 
> > This jumps out a little bit - if we need to take this lock to inspect
> > tcf_vlan_params, then I infer its value may change. And if it may
> > change what guarantees it doesn't change between calculating the skb
> > length and dumping?
> > 
> > It's common practice to calculate the max skb len required when
> > attributes are this small.
> > 
> 
> I believe you are right.

ouch, that's my fault actually - it's true, TC rules can be
modified and dumped at the same time. Then the only thing we can
do is to account for TCA_VLAN_PUSH_VLAN_PRIORITY even if we will not
fill it.

thanks for spotting this,
-- 
davide


