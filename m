Return-Path: <linux-kselftest+bounces-36110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC880AEE239
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC397AD1D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28928FFCD;
	Mon, 30 Jun 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioyQ5V7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E128FABA;
	Mon, 30 Jun 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296432; cv=none; b=INgF6Of2MbNC2SYwhmRd6A1/esMmjc5wNvyUcBwRrH0d9OD25yDbNdqTeZBfxmkmQ94grOWkyb/8og50RP7dFyK4STASuuDg5/OdN+VLS1jbKto7MYY79+cVMsCHaP4oqrVbIJ+yv0eA8a5lAgfXFQ60pL9ma+RYuexGiy6OCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296432; c=relaxed/simple;
	bh=o8tOuhd+OpL1cIInVhjPeCY5JXANds12HcZjna7/oD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKEFuJn1To/wPx54WXlVgs2stL4eS2bDgTAXfVDfsa6CL5PJxlNiTUnWWyEbYzEyY6wHmRuycKMhcRgxTBNC8jwb+uMu/p/9cJx1pXUlomJfn8U/AAAB0S4rXcMxEpa8542Te1aKk2aLd9jOd0H8XpvdRnfxMnOe3iODTdzNh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioyQ5V7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D8AC4CEE3;
	Mon, 30 Jun 2025 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296431;
	bh=o8tOuhd+OpL1cIInVhjPeCY5JXANds12HcZjna7/oD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ioyQ5V7m/6ApNiJjWe6Sut1mFufXBJgTef4rjukEzHcB1EycXqjfBF/pk+gvmi5S0
	 XdVm10Mx+ZCnGS38OLuUB2rydwNugHBMlPnhibhQxsTKg4iwkPiauee5D/8hqewnSK
	 jHm1AXYwB4LEdo4urEoTLVNSNvlbXe8wPpgjxgg2RvLlO5/GV0bDnGMeQeX7YNbM6z
	 FIamvKPZsMfLMRNxuFWQjnaKituk9U26mZpo20yo7bIBXGlzEYNTfPRzetA4OB/dzc
	 DRUrgWHKy40v04lZZPb1xA/3WTCF5lTqg3tuHcCDth3c0yrs/Usc3STYfX7j6hv1IJ
	 H+gPN4YvOB25w==
Date: Mon, 30 Jun 2025 08:13:49 -0700
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
Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250630081349.4c9d7976@kernel.org>
In-Reply-To: <PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 22:49:24 +0000 Chia-Yu Chang (Nokia) wrote:
> > I don't get the reason for all these WRITE_ONCE()s.
> > You lock the qdisc to make modifications, right?
> > And the block under which I'm responding is performing two dependent writes, one to ->step_in_packets and the other to ->step_thresh a change which is definitely not atomic..  
> 
> Thanks again for other comments again, and I will take actions in the next version.
> 
> As there is only one step marking in L-queue, so we still need two
> WRITE_ONCE even two attributes (one for threshold in packets and one
> in time) are used.
> 
> When applying the step marking, we need to know either the
> computation is based on the sojourn time or queue length.

Let me ask again - why do you use WRITE_ONCE() at all if 
the modification takes the qdisc lock? Which reader are
you afraid of racing with?

