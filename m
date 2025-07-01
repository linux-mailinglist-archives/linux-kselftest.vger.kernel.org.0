Return-Path: <linux-kselftest+bounces-36227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC6AF06FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A54A1C04B3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7742609D6;
	Tue,  1 Jul 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc5qO9Bq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CC34CF5;
	Tue,  1 Jul 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412656; cv=none; b=oN6MhnjJ5GAo5j2i0lqHXlrjx7cU4v8NlFEsh+4P3ub4Rr9ZL2hLrl/zDNQxBWTHlSWilJOVYzHifBk0/Ak+LGa+MAdBNe0DIzdievKvbzlYPtXsfTYoLzT99esxIPBwr9NHwjEKgZ5DYp8jTj7DF3bNaTMY3CxmiQ13+dMRyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412656; c=relaxed/simple;
	bh=TY30PNu4AlL/QLy4cmWva9DbUS7ZxnqGZwrQEcvuy6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhA+QRWk8d6nAc9AHliZvcGSSWEALq6ElXniLAA6qIqJkO2tbiKs08H4gsOZbQkyBEM3+90nW2KlQtNxlgw9Pkx/OO81oazhhQ+C5roqJUcJ1P2vlO2iqRVc1k0pHDE4HAqSm+w7+/sVu3izkmpkIwWIvUNDsLx/zuhF/Ka750U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc5qO9Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A29CC4CEEB;
	Tue,  1 Jul 2025 23:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751412655;
	bh=TY30PNu4AlL/QLy4cmWva9DbUS7ZxnqGZwrQEcvuy6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pc5qO9BqzG7/Kr+h7c5Gt2NgW8DtB+3JlU8uIqcgj3aZjF/9YZYuoTLW+Wn3GeqTi
	 QAkiC9pwMjszkg7hy2wT5X+TEE2Kz5zDg7ztLbodjujEcS+UQAAIR3b/uD4SKJDhWr
	 8+wKtimjbiZ9Ch3izTjsbEivm7fTnd4bY6AlTrbbF3ntAIoVAswlS8v6N/UitLq9nj
	 NRMcrsG7WNPQUIo1NmQuSSyJDmrz4yNMxQgyJSSbUJUqWyexwmi1IZQXVYRUui1WOf
	 sPsG7XG5cEAuTvjthlzDSz8sWhPJJfFhcVHT/Um57Io2XUlql7PCSAdTw4iHewc5I1
	 F1efeHT6+IoMQ==
Date: Tue, 1 Jul 2025 16:30:53 -0700
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
Message-ID: <20250701163053.22113645@kernel.org>
In-Reply-To: <PAXPR07MB798432A7A8B078F2619EB8F8A341A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081349.4c9d7976@kernel.org>
	<PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630092316.031b29d8@kernel.org>
	<PAXPR07MB798410A4142386C43B2E0B1DA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630164309.724b9ba1@kernel.org>
	<PAXPR07MB798432A7A8B078F2619EB8F8A341A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 05:41:53 +0000 Chia-Yu Chang (Nokia) wrote:
> > > I don't see we access the same atomic variable multiple times in a 
> > > single expression, the 2 WRITE_ONCE() are in different expressions.
> > >
> > > And, in the last WRITE_ONCE(), what we access are local variables:
> > > "step_pkt" "step_th", will it create problem?  
> > 
> > Not really a problem, but what I'm saying is that I don't understand why all the writes are sprinkled with WRITE_ONCE(). You take
> > 
> >         sch_tree_lock(sch);
> > 
> > to block data path and the control path is under rtnl_lock. So why the WRITE_ONCE()? WRITE_ONCE() is used to annotate writes which can be read concurrently without holding relevant locks.  
> 
> This follows series https://lore.kernel.org/netdev/20240415132054.3822230-1-edumazet@google.com/ to use READ_ONCE in dual2_dump() and WRITE_ONCE in dualpi2_change.
> 
> And because of one previous chnage request (https://lore.kernel.org/all/26f2f366-aa14-4879-978a-58d46f9d83a4@redhat.com/) to split single dualpi2.c into 3 patches, so you can find them in the 2nd patch of this series.
> 
> What I can do is either move these WRITE_ONCE also to the next patch or merge these patches.
> 
> I would prefer the first approach to make it still 3 patches, any other suggestion?

I see. With the change to use two separate fields for packets and time 
I think this should be fine. We will hopefully report one or the other,
but not one misinterpreted as the other.

