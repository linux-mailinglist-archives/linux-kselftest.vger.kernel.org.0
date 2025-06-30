Return-Path: <linux-kselftest+bounces-36131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D6AEEB00
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 01:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2762217524D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061725C82D;
	Mon, 30 Jun 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgNu55Fl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2125B1FC;
	Mon, 30 Jun 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751326991; cv=none; b=UYFrb1IuEIFGo5ymnfwgbQPbSyKzikQcsUuHD8VQb2FO3gyeNo683Pgs3KPtFxRPIJE+Lp/uvlNSRKTgW4dIYO/nkXMgK465dt+hD5Cq8tXVUoqqZkXQD/jRYdLJQMH/7D5HrODgKrrWa9qsdQVlzDJo0/mTE5lGNCzyKq3Jcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751326991; c=relaxed/simple;
	bh=z2pyI1MGiNQCqmI8ox9qC+8jJG78zwYkgfVG5ZSxqac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+ytxvfvudanDnBDne8NMOoh7qPVLNkd3ADDi/grQWG8Li8FMRFzK5BaYZ1m2TPFMbNBVRtiATAmDffVAxsqrmfB/B+QCZ6pRatuCuRcYZgH5Fks0yTB1hrfQGJrdvSSx8oFT2ZLyX5b5eQHOGN+P+HWXQ/Pnh+g5AU9ofx0XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgNu55Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E802C4CEE3;
	Mon, 30 Jun 2025 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751326991;
	bh=z2pyI1MGiNQCqmI8ox9qC+8jJG78zwYkgfVG5ZSxqac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LgNu55FlvR+lfc2TfQXzguVYRMqOr5vi+EwfzF3V/O82wZY4mmySK/UNiEDyN7ND+
	 NniQ/5xnBU3HKEkdurGGz1nBZJ8oZ+6eIhw/usHYZVt1ZdWzso/roLaCOOBsnFyDBi
	 +hACKK31PcCFzDJCU5Qnm0FmXEH7HtCiyvLfLQ1gZ80BB/Kw179KjFZc8047RalZrh
	 0+jKJL+ltuyecnSYJ9kY4Qa2RMGBDoyxMAOv656oMMWCErUZznhXxFyDppRMAPdgfl
	 jyMV4Ac0pi11lK7Yc0+HpugRhuwai5mXnYIjjdKV8tihn4WIk4Dy2RjWDYGUjkI9zY
	 4xg8MopnbmCOg==
Date: Mon, 30 Jun 2025 16:43:09 -0700
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
Message-ID: <20250630164309.724b9ba1@kernel.org>
In-Reply-To: <PAXPR07MB798410A4142386C43B2E0B1DA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081349.4c9d7976@kernel.org>
	<PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630092316.031b29d8@kernel.org>
	<PAXPR07MB798410A4142386C43B2E0B1DA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 17:04:56 +0000 Chia-Yu Chang (Nokia) wrote:
> > > This still needs 2 WRITE_ONCE even "step_thresh" (NLA_U32) and 
> > > "step_in_packtes" (NLA_FLAG) are replaced with "step_pkt_thresh"
> > > (NLA_U32) and "step_time_thresh" (NLA_U32) - which was proposed in my 
> > > another email.  
> > 
> > If you don't understand the question - ask for clarifications :/  
> 
> You are right.
> 
> Could you elaborate on the orignal comment "And the block under which
> I'm responding is performing two dependent writes, one to
> ->step_in_packets and the other to ->step_thresh a change which is
> definitely not atomic.."?
> 
> I don't see we access the same atomic variable multiple times in a
> single expression, the 2 WRITE_ONCE() are in different expressions.
> 
> And, in the last WRITE_ONCE(), what we access are local variables:
> "step_pkt" "step_th", will it create problem?

Not really a problem, but what I'm saying is that I don't understand
why all the writes are sprinkled with WRITE_ONCE(). You take

	sch_tree_lock(sch);

to block data path and the control path is under rtnl_lock. So why the
WRITE_ONCE()? WRITE_ONCE() is used to annotate writes which can be read
concurrently without holding relevant locks.

