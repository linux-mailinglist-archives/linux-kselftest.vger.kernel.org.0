Return-Path: <linux-kselftest+bounces-30883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E76A8A2DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27CF166EF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445D207A3A;
	Tue, 15 Apr 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYa4JyTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A72DFA29;
	Tue, 15 Apr 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731311; cv=none; b=KZOPttbzMyeca0Rvq62Y/B2E9/VZrYE/K5XrGCq47yuEJxIDka4bKhVzwaMWAN4gVFHVc12v7dUAC1tTXMOCuu6ekgDt9NcBtXrbLTi12dCOSpyRQIDtYRT4xcyLwLuQuBGH5QpiQ3rD9m6ANu4eQGXZ3yOegD/GxUMgcEw2K6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731311; c=relaxed/simple;
	bh=z3awKsfQhHqS7FsFGRtKTtKJdDGWwliVe/DBvRf1HG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzHV3Hi363/lc0JIyhMp7kPldprYtbjzFysmxyJSvOrYeOyHJpDaq67hlum6ftOuwRXRWXIArjHbi5qMsNkJCBuRPkjUiHlXXZXXeenAFWqAvCl0RRzxhEG+2IzQl/ILroBaMTqTJ9/RXaYKv+SGDVwzh26EeAjeGTOc4kHi1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYa4JyTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14CC4CEEB;
	Tue, 15 Apr 2025 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731310;
	bh=z3awKsfQhHqS7FsFGRtKTtKJdDGWwliVe/DBvRf1HG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RYa4JyTF1G9dK4c9HZn+UsC7lVQJuadnPCczswFQrSN0vIYU0rICn4JMKU8dDzAZ7
	 gCNyjzzr5sTLvLeB9OIvD+jyyDZcAI9nnUbiWXm5SqURTpbGpi68ykFJpqWU+odOly
	 NWpAnsy+T/7wlN6QqOqQn+AXuMiFW8n7ccwt1tnj05U9wROMhh35FVJK6/okC8fmmr
	 E3JznvGqTbl2Ns8j0vryyASmviMeFiYCE3geoY1i11Zs+5MB71DJIrE07nRqmwcCDK
	 kTx4U94cr9vVNhxAWPNTm/bo5REvsVf+U98sx3vLxDIue7/HGIEHMxvI5hbF6hZ1e7
	 sZY4MvZ4qszKA==
Date: Tue, 15 Apr 2025 08:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
 <jhs@mojatatu.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, vidhi_goel <vidhi_goel@apple.com>
Subject: Re: [PATCH v11 net-next 0/5] DUALPI2 patch
Message-ID: <20250415083508.3ea899bc@kernel.org>
In-Reply-To: <PAXPR07MB798477409AF023CAC191C70CA3B22@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
	<20250415075814.5b182f04@kernel.org>
	<PAXPR07MB798477409AF023CAC191C70CA3B22@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 15:05:29 +0000 Chia-Yu Chang (Nokia) wrote:
> > 24 hours means 24 hours, not 23, especially when you're reposting
> > because your previous version did not build!
> > 
> > Our infra is severely behind on testing, such sloppiness is
> > impacting our ability to process patches :|  
> 
> Really sorry for submitting within 23 hours.
> 
> Shall I resubmit such v11 after another 24 hours again? Or shall I
> submit now?

No, no. Let's give people a chance to review v11.

I'm just asking you to be more careful next time. You may also want 
to consider posting via a different SMTP server. Your first attempt 
at the v3 posting of the TCP patches is still trickling thru to the 
list. Not sure what happened there..

