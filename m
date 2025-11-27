Return-Path: <linux-kselftest+bounces-46649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96116C8EB27
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 15:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F714E6EAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6333328E4;
	Thu, 27 Nov 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQK4mbrl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F71D63E4
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252428; cv=none; b=DLOQ2TzimrroTNEQVISnbSOvRVmVpLFRZtLDzVg5ZiIHaA7MeXunq1oZVp54dL787p5kjdmbgjt494YxfynR7GQ8PSmC+//cCUrWNTjCPQaL9KFRvynpC6ExlMlzyZeuEYGWq6xTXypSs1AdTIMA/ljlhJdtGGdxYVZWihIsNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252428; c=relaxed/simple;
	bh=3YaEeSGT0snneRk+B8EbdhwZJcVaSY2egnEaaOi5AWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7yiEfDYpShzHGZOzqiIvr9ZfIz0Q7VrW/WH/E+mlhCAtPBZFcD3pcu+GNuKwuO0faGBWb+0n0ToQQ5ImfUvj0Gzg5zcEOchW9U+8X+XDE2VAQb+7Vm0R88AAZ/py7dmLnspn1/L6AoLkcD4Oi8zFgr/LRWz/q1AyWFcg1pWplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQK4mbrl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-298144fb9bcso9225415ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764252426; x=1764857226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eve1REN8C3l7kFw7Kbj6Cz9UJfeGMQAUMgDhfygGvvo=;
        b=RQK4mbrl6Fh1dTfdjUn7r1xwQ1PWGFMYTrAA+ooU8fm/mji0O0JUAEnVbvL/7YSmWc
         +J/OHgO6jClMqVkBGPoYqt+ggWo+RVho/4F3wrR7mcCT6i8b/4WFE3aS3hJT+p+M1d1U
         ImD0082EcUnlfiVvHANc0HyeNCK7/agUoYDtjqz9oL48YMaxnpcVibajSyE7j2MWzf71
         WHyRMZw2OhvavPsDaVtF5vrKUk/D6oJTnY1sPgpOFWvUFOnFQEFQr+9W0BdHuINGmwK/
         iBVUQLuGjO5RNlZOLpIXZIvdL7B56APahxYYb3r12XI4gCCJWqakADjz7NTDlkx6lzeU
         CUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764252426; x=1764857226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eve1REN8C3l7kFw7Kbj6Cz9UJfeGMQAUMgDhfygGvvo=;
        b=FddgyxNqJne74NdKknLq6idyBFssFEZakYxQqBC3GK1QLvxBZVmrFksaxaVJNxxEdp
         yENktFQ2v1ZZZm3qENXQLI+nlV41M6TIT47+luY/HWEL2C+DVXeWtO+YHogLPLJJNhiA
         nG9sOvbvO++t+/roHvD4qohxGtUHh6fcMhBnVGL0Bs3EQXnJH7dx4q2hdN1QQPR6JUuf
         ctVdpr3YXA2lGfNSQphD6KEb2Ip7syvlUigVAgiYs+DOPOiqYWw4vVc9rSyNf5egA2zv
         aUalXBGuSHaU3NFZ95f0i/I05JOivV6oXrKqyDPHWERaMZc6oaEyhTOB6K1z52boCUxJ
         PMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCURaCRGVDdYb3/cW71y3dPX9Q4oPn5IxaPX0XXAXF6dzq5xbrgyQaAQnu+lBxGoco464rvZsYx3Z+hkGFPG3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKU8k0sMOXs9wZ2I8crnwKMghpPNBtJboB77E/tqknve6c4Tj
	0zrjpSItwvsCCW/DxnXoSpJIPV7h6eDgSfJIspPSCmX4ooTPIj0iYwU8
X-Gm-Gg: ASbGncuTA/qArqtvy1xgm5f5RtXtQCZhb60vHjHtqsIXjXbxt0IXrUu9tSQZ4oQSv/I
	9PR8vR5ogj0KVztF1CoyqzoN60OgFQqrzVdzqhywWREMup19vMjvWYYVwRigU5nKEy2Jm3sLzUv
	02QGF+tjZ/m/+/VYDeMIzzfulXxKLGKBC/Evc+/JQG6/4iK1M1/AHxVgFNLgaLz8f/hwvij/8tu
	xbSd/acVHyWxQAGRFgO1FQen4gq49YieQTNI/1H1oNlpNb/3wzTuNUKaVHtHYz6lEENtyJcEX/r
	g5D2Reo+BoSH2CH9yeCUshO5Rbn7HkNCdjN7xfCNJ9xifMab3SpE+DOcsDv8m54Kh89LVeewYtn
	Ygrve6iLCA6pdv1sM4h+HvpVvs2yPcqd4xHdCn4x3htwXNghuRVJeV67bJqbtdVF8GYY3cNtL7M
	FrGrPibjl9VV0+WhY=
X-Google-Smtp-Source: AGHT+IFac80e56eHkntDV3lvtTMHLc5fgcb5rchmzu9icjljFyagEYl3DcnwFXSoN8HsGBMklV4qug==
X-Received: by 2002:a17:903:1acf:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-29baafa939fmr116801365ad.22.1764252426366;
        Thu, 27 Nov 2025 06:07:06 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4497e7sm19937465ad.36.2025.11.27.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:07:05 -0800 (PST)
Date: Thu, 27 Nov 2025 14:06:58 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
Message-ID: <aShbAp7RZo8sfq2C@fedora>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
 <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com>

On Thu, Nov 27, 2025 at 11:36:43AM +0100, Paolo Abeni wrote:
> On 11/24/25 5:33 AM, Hangbin Liu wrote:
> > The current ad_churn_machine implementation only transitions the
> > actor/partner churn state to churned or none after the churn timer expires.
> > However, IEEE 802.1AX-2014 specifies that a port should enter the none
> > state immediately once the actor’s port state enters synchronization.
> > 
> > Another issue is that if the churn timer expires while the churn machine is
> > not in the monitor state (e.g. already in churn), the state may remain
> > stuck indefinitely with no further transitions. This becomes visible in
> > multi-aggregator scenarios. For example:
> > 
> > Ports 1 and 2 are in aggregator 1 (active)
> > Ports 3 and 4 are in aggregator 2 (backup)
> > 
> > Ports 1 and 2 should be in none
> > Ports 3 and 4 should be in churned
> > 
> > If a failover occurs due to port 2 link down/up, aggregator 2 becomes active.
> > Under the current implementation, the resulting states may look like:
> > 
> > agg 1 (backup): port 1 -> none, port 2 -> churned
> > agg 2 (active): ports 3,4 keep in churned.
> > 
> > The root cause is that ad_churn_machine() only clears the
> > AD_PORT_CHURNED flag and starts a timer. When a churned port becomes active,
> > its RX state becomes AD_RX_CURRENT, preventing the churn flag from being set
> > again, leaving no way to retrigger the timer. Fixing this solely in
> > ad_rx_machine() is insufficient.
> > 
> > This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
> > (Figures 6-23 and 6-24), ensuring correct churn detection, state transitions,
> > and timer behavior. With new implementation, there is no need to set
> > AD_PORT_CHURNED in ad_rx_machine().
> 
> I think this change is too invasive at this point of the cycle. I think
> it should be moved to the next one or even to net-next.

Sure, I can move it to net-next

> > @@ -1365,39 +1361,107 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
> >   * ad_churn_machine - handle port churn's state machine
> >   * @port: the port we're looking at
> >   *
> > + * IEEE 802.1AX-2014 Figure 6-23 - Actor Churn Detection machine state diagram
> > + *
> > + *                                                     BEGIN || (! port_enabled)
> > + *                                                               |
> > + *                                      (3)                (1)   v
> > + *   +----------------------+     ActorPort.Sync     +-------------------------+
> > + *   |    NO_ACTOR_CHURN    | <--------------------- |   ACTOR_CHURN_MONITOR   |
> > + *   |======================|                        |=========================|
> > + *   | actor_churn = FALSE; |    ! ActorPort.Sync    | actor_churn = FALSE;    |
> > + *   |                      | ---------------------> | Start actor_churn_timer |
> > + *   +----------------------+           (4)          +-------------------------+
> > + *             ^                                                 |
> > + *             |                                                 |
> > + *             |                                      actor_churn_timer expired
> > + *             |                                                 |
> > + *       ActorPort.Sync                                          |  (2)
> > + *             |              +--------------------+             |
> > + *        (3)  |              |   ACTOR_CHURN      |             |
> > + *             |              |====================|             |
> > + *             +------------- | actor_churn = True | <-----------+
> > + *                            |                    |
> > + *                            +--------------------+
> > + *
> > + * Similar for the Figure 6-24 - Partner Churn Detection machine state diagram
> >   */
> >  static void ad_churn_machine(struct port *port)
> >  {
> > -	if (port->sm_vars & AD_PORT_CHURNED) {
> > +	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
> > +	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
> > +	bool partner_churned = port->sm_vars & AD_PORT_PARTNER_CHURN;
> > +	bool actor_churned = port->sm_vars & AD_PORT_ACTOR_CHURN;
> > +
> > +	/* ---- 1. begin or port not enabled ---- */
> > +	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
> >  		port->sm_vars &= ~AD_PORT_CHURNED;
> > +
> >  		port->sm_churn_actor_state = AD_CHURN_MONITOR;
> >  		port->sm_churn_partner_state = AD_CHURN_MONITOR;
> > +
> >  		port->sm_churn_actor_timer_counter =
> >  			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
> >  		port->sm_churn_partner_timer_counter =
> > -			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> > +			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> > +
> 
> Please avoid white-space changes only, or if you are going to target
> net-next, move them to a pre-req patch.

OK, what's pre-req patch?

> 
> >  		return;
> >  	}
> > -	if (port->sm_churn_actor_timer_counter &&
> > -	    !(--port->sm_churn_actor_timer_counter) &&
> > -	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
> > -		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
> > +
> > +	if (port->sm_churn_actor_timer_counter)
> > +		port->sm_churn_actor_timer_counter--;
> > +
> > +	if (port->sm_churn_partner_timer_counter)
> > +		port->sm_churn_partner_timer_counter--;
> > +
> > +	/* ---- 2. timer expired, enter CHURN ---- */
> > +	if (port->sm_churn_actor_state == AD_CHURN_MONITOR &&
> > +	    !actor_churned && !port->sm_churn_actor_timer_counter) {
> > +		port->sm_vars |= AD_PORT_ACTOR_CHURN;
> > +		port->sm_churn_actor_state = AD_CHURN;
> > +		port->churn_actor_count++;
> > +		actor_churned = true;
> > +	}
> > +
> > +	if (port->sm_churn_partner_state == AD_CHURN_MONITOR &&
> > +	    !partner_churned && !port->sm_churn_partner_timer_counter) {
> > +		port->sm_vars |= AD_PORT_PARTNER_CHURN;
> > +		port->sm_churn_partner_state = AD_CHURN;
> > +		port->churn_partner_count++;
> > +		partner_churned = true;
> > +	}
> > +
> > +	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
> > +	if ((port->sm_churn_actor_state == AD_CHURN_MONITOR && !actor_churned) ||
> > +	    (port->sm_churn_actor_state == AD_CHURN && actor_churned)) {
> 
> Is this                                             ^^^^^^^^^^^^^^^^
> 
> test needed ? I *think* the state machine `actor_churned == true` when
> `sm_churn_actor_state == AD_CHURN`

Yeah... We don't need this in theory.

> 
> > +		if (actor_synced) {
> > +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
> >  			port->sm_churn_actor_state = AD_NO_CHURN;
> > -		} else {
> > -			port->churn_actor_count++;
> > -			port->sm_churn_actor_state = AD_CHURN;
> > +			actor_churned = false;
> >  		}
> 
> I think this part is not described by the state diagram above?!?

This part is about path (3), port in monitor or churn, and actor is in sync.
Then move to state no_churn.

Do you mean port->sm_vars &= ~AD_PORT_ACTOR_CHURN is not described?
Hmm, maybe we don't need this after re-organise.


> 
> >  	}
> > -	if (port->sm_churn_partner_timer_counter &&
> > -	    !(--port->sm_churn_partner_timer_counter) &&
> > -	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
> > -		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
> > +
> > +	if ((port->sm_churn_partner_state == AD_CHURN_MONITOR && !partner_churned) ||
> > +	    (port->sm_churn_partner_state == AD_CHURN && partner_churned)) {
> > +		if (partner_synced) {
> > +			port->sm_vars &= ~AD_PORT_PARTNER_CHURN;
> >  			port->sm_churn_partner_state = AD_NO_CHURN;
> > -		} else {
> > -			port->churn_partner_count++;
> > -			port->sm_churn_partner_state = AD_CHURN;
> > +			partner_churned = false;
> >  		}
> 
> Possibly move this `if` block in a separate helper and reuse for both
> partner and actor.

OK, let me try.

> 
> >  	}
> > +
> > +	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
> > +	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_churned && !actor_synced) {
> > +		port->sm_churn_actor_state = AD_CHURN_MONITOR;
> > +		port->sm_churn_actor_timer_counter =
> > +			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
> 
> Should this clear sm_vars & AD_PORT_ACTOR_CHURN, too?

Yes, or we can just remove AD_PORT_ACTOR_CHURN as I said above.

Thanks
Hangbin

