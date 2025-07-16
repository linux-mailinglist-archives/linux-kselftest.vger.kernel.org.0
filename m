Return-Path: <linux-kselftest+bounces-37412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81159B0726E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921213A41C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA02F234D;
	Wed, 16 Jul 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz0B7jlF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA281E1A17;
	Wed, 16 Jul 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660096; cv=none; b=C/tY48rFd245VnYwCoZGs0b9iAJRYPQ8Z9p1eBcMyu/hWegPur0x1l/yZ8dmj6KfmuDpKbjjIpOcPByX5Ji9pi3Wmz1Wzn0eHzb3T3tEolUiAaMQzrCk1vRbbwBSEngh6/B0IBRFkAovySKVmm8KEPv4WTmJmCTex+exxkVXgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660096; c=relaxed/simple;
	bh=F1e3od86GWp18tAJQqHphAbdUx2CQFKA8BOYukDggbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP2Os6TTvuovBO+I4k6XIfQF8kf5E9jcLupkBe2F74ZTcIUTfgbQPtnjghWLtMFOQ3PLF9n7rUbRa4U9ziMUA1LOArLxRsrbWaE0RCTyQtlhhM86w+MtBhl9a82Doiu9B46fiy2eiEqhUCDD0kir5Fn1JcyjQtXyISNKd1537M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz0B7jlF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b350704f506so619671a12.0;
        Wed, 16 Jul 2025 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752660094; x=1753264894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBVUcNuqA3qfhYBvm1KQnYeeoyTvAgFUysKMSPuuX/Q=;
        b=Hz0B7jlF8p5QPLuBB4wuFQXTD5rgKk6S9HfDiBjLrYX1+3ky7aSEwpguajasNP7wJW
         aRLQvHGL6ATq5g5Yy6BvJ20D05OYCOknzWELeas1XBs3ajdibMMy4IeumZ9BEi1UaFAj
         ssviTigb0bJReOzPIzCPGe7g3+jIstoFbe3HeEn22uNJlHlwOEsCZRdGs24LTAnpI5Kl
         UyPvs6VX+lLkx80w3aEzmKxg+dspoUzXFjJqfKIl6uZJwUmQmwVH+/OIorXmaWQZaYnF
         yAJOSbAMaZTxLwnk2ukBVhhsSHYfc4V3lfRetotS3aSPOg2EWvy7Nr0VeJtogojDHddw
         zhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660094; x=1753264894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBVUcNuqA3qfhYBvm1KQnYeeoyTvAgFUysKMSPuuX/Q=;
        b=EQD+dj+MgsDKpJi/bDnq/+IOhp7RJX5GkGPyHw496xW+cpjZvRT7W+OmXxBakSG3J1
         df3+jxFHliPPtPDDS5nDiRTC21ic6a6NJkN4yi9dEaNPw6ef5APHpXapits2U04Frrgv
         NEwEo+dQo45Ci0Wbu0n8RMrxBqzK+rRqrD34TceFN4Xfld3EwjSRcC8pqGyFz2UrBu/p
         bk6csCO3GP2lgorEeFzEasSc0PBg8BICmDHNb10Bd42uD5U6yWW3Yv+NaJFbJDc/xDKI
         /PvA+cpk0YV8r6eG+ho84X+nCVWQZZImVrOmE8pFI+3Wh+pLv8ttD6KNkj4DlIZlgMr7
         ChZA==
X-Forwarded-Encrypted: i=1; AJvYcCUXphPenjlfUup8gDpxj7op2VxmHq0CXfPGNC0gi+jeGZV+HRbv7LRGDuzED5miNbsoa8eW35KyJ6ujszpO+G19@vger.kernel.org, AJvYcCXMZWZZ83kvu5yNLzpWHW68kEthziks4fRSIi9PgaQ9geVFAo4akVVZFw7vu57Lj+gO4zKvcnqTIbY6Af8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBTIn3+vm2aqGHrs/YrletB66PYqHYRUlNb+NIZ0jvRcqGVQ6
	Ekg+2H4vkDboCNgVpqpL/oD7O0AX9o0S2IxPkVupj3HLTuwRtRuaCdbl
X-Gm-Gg: ASbGncvOIcw+Hqf/uvxlTonlGVukvZvL+BnyDt32pYOfNTmncV7FAe7NR/FiHmCROUA
	wPaPfPwOGo4LEyf2syFGnemHuiEI++hjP5b6PiT2VhaRBEWYLlC9r23T7YF2oGv3OCq2vqoLvOI
	lyNH10kOHWFm8Wke6WPNU4mUx/fTooqENcJSiZQOIE7IBgvbGmTB1nC7ww5qtEMdiKI/s+uSvc+
	Q23EyBJiw4qNcOP6F7AWh1Q6+bvUQeuB8RSvXwA7sEuH4yhG3kwtHSbspAV9ugK9rSWZLWl46wW
	gaz2i4FRs9yMJvadT623L98PEM9IWvqYGxzHBoELxQmkX5dPnvAdIliTbyPF+6yQy9L3RoAHxRa
	9SjQWlXT973fNjTT+iDUghGQkX8A=
X-Google-Smtp-Source: AGHT+IGu0vl7a8IpcxbiAM6bYbghrCeBRJAqOGsujg3WsE9DK32zJWSkRhUg70YdqcXoa6xfK+v+pg==
X-Received: by 2002:a17:903:1205:b0:234:7837:91de with SMTP id d9443c01a7336-23e1a4e4086mr103843035ad.26.1752660093710;
        Wed, 16 Jul 2025 03:01:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe727e33sm13665636a12.68.2025.07.16.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:01:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:01:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: update ntt to true in passive mode
Message-ID: <aHd4ddc1YzeT1lN3@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-2-liuhangbin@gmail.com>
 <765825.1752639589@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <765825.1752639589@famine>

On Tue, Jul 15, 2025 at 09:19:49PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >When lacp_active is set to off, the bond operates in passive mode, meaning it
> >will only "speak when spoken to." However, the current kernel implementation
> >only sends an LACPDU in response when the partner's state changes.
> >
> >In this situation, once LACP negotiation succeeds, the actor stops sending
> >LACPDUs until the partner times out and sends an "expired" LACPDU.
> >This leads to endless LACP state flapping.
> 
> 	From the above, I suspect our implementation isn't compliant to
> the standard.  Per IEEE 802.1AX-2014 6.4.1 LACP design elements:
> 
> c)	Active or passive participation in LACP is controlled by
> 	LACP_Activity, an administrative control associated with each
> 	Aggregation Port, that can take the value Active LACP or Passive
> 	LACP. Passive LACP indicates the Aggregation Port’s preference
> 	for not transmitting LACPDUs unless its Partner’s control value
> 	is Active LACP (i.e., a preference not to speak unless spoken
> 	to). Active LACP indicates the Aggregation Port’s preference to

OK, so this means the passive side should start sending LACPDUs when receive
passive actor's LACPDUs, with the slow/fast rate based on partner's rate?

Hmm, then when we should stop sending LACPDUs? After
port->sm_mux_state == AD_MUX_DETACHED ?

> 	participate in the protocol regardless of the Partner’s control
> 	value (i.e., a preference to speak regardless).
> 
> d)	Periodic transmission of LACPDUs occurs if the LACP_Activity
> 	control of either the Actor or the Partner is Active LACP. These
> 	periodic transmissions will occur at either a slow or fast
> 	transmission rate depending upon the expressed LACP_Timeout
> 	preference (Long Timeout or Short Timeout) of the Partner
> 	System.
> 
> 	Which, in summary, means that if either end (actor or partner)
> has LACP_Activity set, both ends must send periodic LACPDUs at the rate
> specified by their respective partner's LACP_Timeout rate.
> 
> >To avoid this, we need update ntt to true once received an LACPDU from the
> >partner, ensuring an immediate reply. With this fix, the link becomes stable
> >in most cases, except for one specific scenario:
> >
> >Actor: lacp_active=off, lacp_rate=slow
> >Partner: lacp_active=on, lacp_rate=fast
> >
> >In this case, the partner expects frequent LACPDUs (every 1 second), but the
> >actor only responds after receiving an LACPDU, which, in this setup, the
> >partner sends every 30 seconds due to the actor's lacp_rate=slow. By the time
> >the actor replies, the partner has already timed out and sent an "expired"
> >LACPDU.
> 
> 	Presuming that I'm correct that we're not implementing 6.4.1 d),
> above, correctly, then I don't think this is a proper fix, as it kind of
> band-aids over the problem a bit.
> 
> 	Looking at the code, I suspect the problem revolves around the
> "lacp_active" check in ad_periodic_machine():
> 
> static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
> {
> 	periodic_states_t last_state;
> 
> 	/* keep current state machine state to compare later if it was changed */
> 	last_state = port->sm_periodic_state;
> 
> 	/* check if port was reinitialized */
> 	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
> 	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
> 	    !bond_params->lacp_active) {
> 		port->sm_periodic_state = AD_NO_PERIODIC;
> 	}
> 
> 	In the above, because all the tests are chained with ||, the
> lacp_active test overrides the two correct-looking
> LACP_STATE_LACP_ACTIVITY tests.
> 
> 	It looks like ad_initialize_port() always sets
> LACP_STATE_LACP_ACTIVITY in the port->actor_oper_port_state, and nothing
> ever clears it.
> 
> 	Thinking out loud, perhaps this could be fixed by
> 
> 	a) remove the test of bond_params->lacp_active here, and,
> 
> 	b) The lacp_active option setting controls whether LACP_ACTIVITY
> is set in port->actor_oper_port_state.
> 
> 	Thoughts?

As the upper question. When should we stop sending the LACPDUs?

Thanks
Hangbin

