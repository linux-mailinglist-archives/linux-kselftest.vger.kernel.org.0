Return-Path: <linux-kselftest+bounces-37870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F6B0EFCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C664A7B24D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88D28C2A2;
	Wed, 23 Jul 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqO3BtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5428C5DE;
	Wed, 23 Jul 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266473; cv=none; b=iCQzpaG88Wbm9l0aVgUq1cizGAhiF1GnfNI4H46weVr+0uTmPFzyjcS2J3AtlUH/jglEMgX4w/EnNsBYlfArhsH9/+aK4HIk3XpqTWxGeg+Deatn/UtQGEqn+yADAM2Tdsvd8kccQ0cjvjf2MUiliZcsgN69KJUUOttz9q3iIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266473; c=relaxed/simple;
	bh=DCYNcGOnoipFp5qeRNoTGN+oBlg7O5HSR1iAcWEd6C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+P3YTovycsQ8y7pHWiw1iNBYUqRJHfO32PnPclF0IyjV3K25tt9mPdPvFcUuIPcprWwnTLHJBL7q3rSLypioEYI5kQXvzbOjewaIt0B2mlgWNIWijxt4wc1EPelh9L255bZFO8rSpNLAtjG3vIN8ibKruO/D6Ypuc+PXZWVEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPqO3BtN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso53197775ad.0;
        Wed, 23 Jul 2025 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753266471; x=1753871271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rm3XRCn+Di3N/rWanYn9EVpo3gmry4TW5aKLBEAX3Jg=;
        b=jPqO3BtNeygxJZFpHtrsKHnyqjE3PYkW5MXJzL1GGTV3WNMEtpfCN/npBWymjIOedH
         XggRYXesCcu+sNwIKIqPukHZCEywnZBTeB32AUmb/VdXUxaZvtw5QQ9TBW1+DenlEGNA
         Nx17+9HO6SHL1jeJ1prGNZ2V4MLNj6uE+mRvq2wTu3K016Q7bDwNGqELo1mpllALp6L+
         FZvR3X2Ls0dQ69RW+eh2aiD4+SRGIA7kfbfdqqO4SW6MiCtXeO0yizjnHin1R0B84LlC
         MhZ2BSVlwxozZobIiQOcIcgss2gNiMR+TKWNAycnxuhNbjGQX9hQYKeVan+PEhwcKApx
         /Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266471; x=1753871271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm3XRCn+Di3N/rWanYn9EVpo3gmry4TW5aKLBEAX3Jg=;
        b=p6u7CIiiF63u0W4uvwDyCwl6zBm5nfppg+htefwN7NlqfxURJchB4VzjpSHrMfO8wy
         5YJqn3ZD2IMJ/LwuV5owZdy09zlDUcIW7oI5edSpZjj6faudVHAXgNbPG6yy4+wZbFHD
         YRA+Oyrs5rgVXbXuYZSv+0AJ4eO/YBCWaIpNsU7NND0qBO77S8bF9l5N67MNxzWTQL+L
         hgbRD8TZwlDwhwElVbDcUi03EyMBBOeiRHwWeho/Wm03Y7vFy/91+oxnCcTMd7wQsgrz
         sf3UvlA0IfIrrUbF76OR3jZlVPv3XOBsBBmDllSWvJUU25/wXUxaqWMrfEEoKEhwmTSx
         YyvA==
X-Forwarded-Encrypted: i=1; AJvYcCX/qEQRpLlQe2h8HwU09NIderc0czHDL8pW4pXJXzgYeQO6CwhUlOiokZG11pbO6bUaZqJR0yL7Uicxq3U=@vger.kernel.org, AJvYcCXRJOA8nv/k4UpLxRIqdYF5YKtFN93llsva5KSutZc6TdYCLWRrFe5kYbxgH+RYFEEO4JN0sjG6DJHcU8lz5/4s@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4gM59Okv6hnlChF9pg/tvTqnBPtVqD2q7z6KXuG3El0wJBX1
	m1wNcDh3Qspoe2uVsfQVDlU4ZYctkOQS/F4G0Bmlm9k0OTdWY2NP93uqBDrxOPaD
X-Gm-Gg: ASbGncvy38r22JK1xYjsUggquobFbx7DPyrdfkJfwwVjXzLlhRNsqv8MgA2VG24CAFk
	UvWzAyKY67NKoHAGUXVe+jzbNAa7dFAewZfIyChhroeLt5PuxXfPw0EkyM5K3F1zp7H/06aKVD3
	JTKG1ebjb5auMPD4ajdWxyEqwJh6dupyLBSQH1rPq96tx+S+OcwLmvhHm1Uug/W2EPfCQQkI3a1
	S00/2PjARcIGwFU/wqLSaZIAVGBz42x5R7ZVq2wPbeGN3DBDLxdxsLYEmlsQ3qDVCHfe+hHSDL6
	nIwVB0Tp+d66RZbeQaEs7UJg78GNlFjZGycEOtpaNvmeobg5itispsRLBr6S6r4nGRzH7d3SqtY
	UZYoNcrbLsZd4fHDqshr/AmIrRvI=
X-Google-Smtp-Source: AGHT+IG5HdX1lhvkl+xukOzoouzn1VYzVj1xDr6rM5FYHWRSYf6xU0iUA5bPyHyxvghqOr4crhkXxA==
X-Received: by 2002:a17:902:fc43:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-23f98140225mr34938205ad.5.1753266470585;
        Wed, 23 Jul 2025 03:27:50 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b49ecsm93180095ad.98.2025.07.23.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:27:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:27:42 +0000
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
Message-ID: <aIC5HrE9js_YtSCB@fedora>
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

Hi Jay,

I did some investigation and testing. In addition to your previous change,
we also need to initialize the partner's state to 0 in ad_initialize_port_tmpl().
Otherwise, the check:
```
!(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)
```
in ad_periodic_machine() will fail even when the actor is in passive mode.

Also, the line:
```
port->partner_oper.port_state |= LACP_STATE_LACP_ACTIVITY;
```
in ad_rx_machine() should be removed, since we can't assume the partner is in
active mode. [1]

With these two changes, we can ensure:
1. In passive mode, the actor will not send LACPDU before receiving any LACPDU from the partner.
2. Once it receives the partner’s LACPDU, it will start sending periodic LACPDUs as expected.

Do you agree with making these changes? If so, I can post a patch for your review.

[1] IEEE 8021AX-2020, Figure 6-14—LACP Receive state diagram, the AD_RX_EXPIRED
statue should be
```
Partner_Oper_Port_State.Synchronization = FALSE;
Partner_Oper_Port_State.Short_Timeout = TRUE;
Actor_Oper_Port_State.Expired = TRUE;
LACP_currentWhile = Short_Timeout_Time;
```

Thanks,
Hangbin

