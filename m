Return-Path: <linux-kselftest+bounces-36887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E3AFF388
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279621C8209F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FB253F1B;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efx+q2Us"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BD2475CD;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094971; cv=none; b=XAdTrRVrcvslcc+BRAzlirtv/7dF+U/6I64NlHC2qnLqk1g15acSuvsB81udpTuKuMNWihbUh2vSOpJNCLeg4rxhoHzitykboB87T5M6EfLNznpQvHVFX7LMNyhRUjAE73k2LsfMgCBScfFeRKJwW9PCQGlorjERSqXeFSKb7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094971; c=relaxed/simple;
	bh=pz3pBvfitbhG43xpIqCvKn71bLPwyOhnAD7pSZhuaLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDqWiRFBxRM17yFdIvXA/7pLcApeIkMMEJuxkBvCwuo0pgAlx2p5e431ODR/2mAXmmDpEc6PE6qVAASgXITncYw8HhFFNzJcr3d2YJP20Y0TlEF7yvHZmxnKM2fYrYUkr9g97w9ZcVB1tMFC1i8q5FibDZgcLGSNf9XGE+y2LJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efx+q2Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E467DC4CEEF;
	Wed,  9 Jul 2025 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094970;
	bh=pz3pBvfitbhG43xpIqCvKn71bLPwyOhnAD7pSZhuaLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efx+q2UsT7+6kUkU7nF3bkSrEW2iGIF4HkT/MPU5kPIZv8btyqMwYcGsbsZPkml/U
	 V2tsQ3E/+DIm+P55mixMZZGByeYNUbzxMEjb9ggC3mt49OxnB4/cM1JVKxFlkjCEPS
	 4SITDEnq0XxKlAVlBdarhlWjQ0flffrH2fB64XlUVcYYBJOiQPRKe3mF0lt6XgGM16
	 WYbvSGCrUt/Kt4CUAWzrsM4/ED3zz1a31UiTZDx9tPJlzZzaV4INh6X07qOFMrozCi
	 Y/m19P1OtvtizupKnm0sjOOLdZKnolq6T2fPsI9sCl4rA+3mAWnWD1+5IgaYcRQBkl
	 8EmJlAudxhNEg==
Date: Wed, 9 Jul 2025 14:02:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "alok.a.tiwari@oracle.com"
 <alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
 <pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
 <xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
 <jhs@mojatatu.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v21 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250709140248.71603931@kernel.org>
In-Reply-To: <PAXPR07MB7984DEEC5D4DEF626359C2ECA349A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
	<20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
	<13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
	<PAXPR07MB798488E0305080CE891E8286A34EA@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250708173038.46d25979@kernel.org>
	<PAXPR07MB7984DEEC5D4DEF626359C2ECA349A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 08:17:08 +0000 Chia-Yu Chang (Nokia) wrote:
> Thanks for clarification, then I will add one extra "int opt_flag = 0" and set the flag (e.g., opt_flag += 1 << TCA_DUALPI2_LIMIT).
> 
> At the end will return an error message if no flag is set, like below example:
> 
> if (!opt_flag) {
>         sch_tree_unlock(sch);
>         NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are empty");
>         return -EINVAL;
> }
> 
> Or is there any other suggested ways to do it, please let me know, thanks.

You don't have to track each option. I think it's enough to check if
the option nest is empty:

-	if (!opt) {
+	if (!opt || !nla_len(opt)) {

