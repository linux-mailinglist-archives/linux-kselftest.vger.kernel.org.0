Return-Path: <linux-kselftest+bounces-48992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7575D225AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F744300CF10
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 04:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097D2BEFE4;
	Thu, 15 Jan 2026 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5VlrzLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC16EEA8;
	Thu, 15 Jan 2026 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450295; cv=none; b=o8otknYNqX9qR+qcLUfwS/8iqbZNgFJN4VsliboE8I/2I+D9LXFW84JIJzPQ8hI/0NFWc+MPBjYWu2BMKSmRGkt4Asf1rf6mEinTHpm1a15okprFlJ3a8Q250nNU6qjtm6JF/mdX8YNMueCfR5AaxtNErkcXsPDVeHJWAL0iTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450295; c=relaxed/simple;
	bh=bVEzf1YEsVmAfpl4RGUDHiheNnPIShSLYxhFE64NKhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TATyXte5zLB1NuLf2PUBMVIkP/DXs1c7rnZeV2mu8gEry8nPQQyIP43FYmwD4pdZB1He9N/PejWobECT5ch0D7zYHfJ8vLA467bJoGHhQDcrB0u/c5rXELkgzCtW/a3bVHzPxz5cyE99XO397A+/I/JFWmXQldJISlACw1eTy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5VlrzLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D57C116D0;
	Thu, 15 Jan 2026 04:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768450295;
	bh=bVEzf1YEsVmAfpl4RGUDHiheNnPIShSLYxhFE64NKhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G5VlrzLxRqLvfO0lhVUQKX8RVuAclYZ5DXQW7V6v8UY1VB+zXZ0jOoOWx2dE4JBlR
	 YmuFXwgwKHpEcP2Mgf9iRNx/qHDFcIrxg2DXAVoNdvJRU6+8dFIDFa9XIEl3L1Etpu
	 iXoVBMS36ls72qM3pQwkzYGvdAYIdPx5ooQcBReJpU133MXyakTc889hjeo0EMd/co
	 ldHtVOlAVKgstTehtAEfbsdRXPTtxUbCh+h0TcxBF5v1gQNcEEodAx6pnTNNjQwRp/
	 hHqHkqWJRgBrlBYKWDqTyAC+5nM1c22pJZn5nfMoySkYLoba9cjTB1caGm9WEw7Tqt
	 rSSTlg480f5gw==
Date: Wed, 14 Jan 2026 20:11:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
 <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
 <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: Re: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Message-ID: <20260114201133.710abe3c@kernel.org>
In-Reply-To: <PAXPR07MB7984E23DB685074239202CA8A38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
	<20260114151346.734001ac@kernel.org>
	<PAXPR07MB7984E23DB685074239202CA8A38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 23:25:59 +0000 Chia-Yu Chang (Nokia) wrote:
> > Missing your own SoB on the patch, but also -- are these supposed to pass without the kernel patches? Without going back to check Paolo's message my understanding was that you'd repost this as patch 15 of the kernel series.
> > 
> > On the packetdrill side -- is PR #61 the code we need merged?
> > Doesn't seem like it. Could you please clean that part up and start the review process?  
> 
> Thanks, I will add my own SoB in the next version.
> This patch can NOT pass without the last kernel patch; shall I merge
> this series into that kernel series? If yes, I will submit v8 on that
> series and add this patch as the last one.

Yes, please.

> On the packetdrill, the used packetdrill is commit
> 6f2116af6b7e1936a53e80ab31b77f74abda1aaa of the branch:
> https://github.com/minuscat/packetdrill_accecn Shall I create PR? Or
> above info is ok for merging into packetdrill.

Please create a PR and let's give Neal a couple of days to look thru it.
We don't need the packetdrill side to be fully merged upstream but
I'd love some indication that it's not going to take long because
we need to manually manage the packetdrill build if it's not upstream.

