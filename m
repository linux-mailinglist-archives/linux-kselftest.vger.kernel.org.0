Return-Path: <linux-kselftest+bounces-37501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D623FB08E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A05585482
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BF2EBDCD;
	Thu, 17 Jul 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOKwqE/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F92EBB9C;
	Thu, 17 Jul 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759537; cv=none; b=mOUGAhhfMFAG0fWxwi//qQSa2M/ee3gwiI05BKfWONXvECXyWFh/6A42hpNowd8newDHPvOv+CYYKtI+4Afr3eamoUZuYvapJAPcy20w+GAp/eLD3skTwiL3SGZYcbxy5NfZMB7aPedJbOFOOJSt7PsxcIbh9wa2J+MatYMCqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759537; c=relaxed/simple;
	bh=3LZrO8vMbZGyvhhgv5vG1/Sq/nO68bbrkYJu5hEQK7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9xupcb2mip/7u+6MIFU+TIn8+QRPcqNOgt0cYWpslAPpkgJDv8WTlacaLSgix4NsrPp3CJ3oqasIWR3NecKFSszMDd95iHIeJQ+E3NR2+0Optx1n7TSYyRhp1lLE/l45JrSvKrF04r+XRec/Cl6svmoCjBWvB+KRfwXyG4Sqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOKwqE/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7C6C4CEE3;
	Thu, 17 Jul 2025 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759536;
	bh=3LZrO8vMbZGyvhhgv5vG1/Sq/nO68bbrkYJu5hEQK7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOKwqE/2h5EFdBOAmtOVUSOX3H2z6iexUQiJezwDubzkhywnXGSiu5F13luHO4Wfy
	 SIBWiVlR8nAve0P5sd4efmvlOZzkYnKL2bzlch5xxTXm+52//uOLBfOv+yXcVLo7am
	 R8ZqIg6U4ZlfHKuaLZWytk/es0olcHLT1AS/7qAyPPWfahBjIXMBi81eklTWONf7KU
	 zhhap/qXBGrJWxa5tsr948p2A0FleTkvtJkJflShL3Bt+mV2LTaWNA0nkHRpbBQbX5
	 wdNmkCM1ZUvb83ebbnSjbqgRUZEMdLwu6RLcNFAluo6neHcY2ze9AJKSVG7ToJphTO
	 tQ+3yxPa0Ub+g==
Date: Thu, 17 Jul 2025 06:38:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
 "pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
 <horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
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
Subject: Re: [PATCH v23 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250717063854.52ea7371@kernel.org>
In-Reply-To: <PAXPR07MB7984AFFA35DA43805C02E542A351A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
	<20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
	<20250716164547.6d415024@kernel.org>
	<PAXPR07MB7984AFFA35DA43805C02E542A351A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 07:16:21 +0000 Chia-Yu Chang (Nokia) wrote:
> Thanks for feedback.
> May I ask is it fine if I put the enum like below?
> 
> enum tc_dualpi2_drop_overload {
>        TC_DUALPI2_DROP_OVERLOAD_OVERFLOW = 0,
>        TC_DUALPI2_DROP_OVERLOAD_DROP = 1,
>        __TCA_DUALPI2_DROP_OVERLOAD_MAX,
> };
> #define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)

Missed the TCA_ on the max entry and define?

> enum tc_dualpi2_drop_early {
>        TC_DUALPI2_DROP_EARLY_DROP_DEQUEUE = 0,
>        TC_DUALPI2_DROP_EARLY_DROP_ENQUEUE = 1,
>        __TCA_DUALPI2_DROP_EARLY_MAX,
> };
> #define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
> 
> enum tc_dualpi2_ecn_mask {
>        TC_DUALPI2_ECN_MASK_L4S_ECT = 1,
>        TC_DUALPI2_ECN_MASK_CLA_ECT = 2,
>        TC_DUALPI2_ECN_MASK_ANY_ECT = 3,
>        __TCA_DUALPI2_ECN_MASK_MAX,
> };
> #define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
> 
> enum tc_dualpi2_split_gso {
>        TC_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO = 0,
>        TC_DUALPI2_SPLIT_GSO_SPLIT_GSO = 1,
>        __TCA_DUALPI2_SPLIT_GSO_MAX,
> };
> #define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)
>  
>  
> And shall such change also been applied to Dualpi2 attributes below?
> As these are more attribute-like, so I assume no.

Correct, these stay as they are.

