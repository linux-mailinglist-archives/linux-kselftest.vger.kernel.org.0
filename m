Return-Path: <linux-kselftest+bounces-36116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D858AEE47C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3FB440CC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7628FFD2;
	Mon, 30 Jun 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPkMwsUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC121D3D2;
	Mon, 30 Jun 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300598; cv=none; b=m/xO8QO1W3LCG0XRIuvsUp/dmnI1OVFu8J9ybFQzzP/4ZEmsuzGAOh6qB15uexmWYoVI+sJsrhhURfTzW/XrK1D6WSIQWo/3OoFLJ7OBgXoz9GOC+nNQUZWUn1XsVk2ZS96sNLKTpse/aPxmpm/vScM908Emge1UL2dJyjAEyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300598; c=relaxed/simple;
	bh=kQ1SiFVfFedINnEo+Jo+aRMbJjKdNp+MrAhRtYlIOR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InjEZxsq1/lXWTZ4YYEJ6RThHmqlbH7FO+0G8zj9xMHBnaJK73Jh+cEmNC2q2zyqlkncn8+BUeL9CGP9wcGF0PY2plyCKGmV/K2fhlj6u5IZpXcdoclJR6M/ZGPpo9oAkOgBTAP+hXFk3PmEjyn7BZemmL7kzGGjT+NFvGPvp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPkMwsUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE55C4CEE3;
	Mon, 30 Jun 2025 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751300598;
	bh=kQ1SiFVfFedINnEo+Jo+aRMbJjKdNp+MrAhRtYlIOR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WPkMwsUP1sca8xIJbRXsWaCBBuWarcgjSDldQoZUuxtXrVqz4OvJKMeJDDdyL97RW
	 CrBVVxetFkFcFU4PqkpOaSb6RlTYz1A9AkY71PaJgD+OpiyaKkIsyCRqkVGioJT/j0
	 WwdTlmlMHFIODj4O/STfeqtqSuAkHwhT4FyFimhJfF3xGh0P7AimcSnwzFZZ3RfNQU
	 i9bSymgYp48YGJQZgQoNAAfRFZsCRFrWQ1nedUOJmbKHq5NKHK3w7zPbLKcPHra8fu
	 OSppi4AnzHX1Hnlb/04WkiRRgQchX+a8rW4C7oz9bg8KrH2QmaNjNGqlkrng7jJ72G
	 CcA6aksrKJtng==
Date: Mon, 30 Jun 2025 09:23:16 -0700
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
Message-ID: <20250630092316.031b29d8@kernel.org>
In-Reply-To: <PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081349.4c9d7976@kernel.org>
	<PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 15:51:11 +0000 Chia-Yu Chang (Nokia) wrote:
> > > Thanks again for other comments again, and I will take actions in the next version.
> > >
> > > As there is only one step marking in L-queue, so we still need two 
> > > WRITE_ONCE even two attributes (one for threshold in packets and one 
> > > in time) are used.
> > >
> > > When applying the step marking, we need to know either the computation 
> > > is based on the sojourn time or queue length.  
> > 
> > Let me ask again - why do you use WRITE_ONCE() at all if the
> > modification takes the qdisc lock? Which reader are you afraid of
> > racing with?  
> 
> This still needs 2 WRITE_ONCE even "step_thresh" (NLA_U32) and
> "step_in_packtes" (NLA_FLAG) are replaced with "step_pkt_thresh"
> (NLA_U32) and "step_time_thresh" (NLA_U32) - which was proposed in my
> another email.

If you don't understand the question - ask for clarifications :/

