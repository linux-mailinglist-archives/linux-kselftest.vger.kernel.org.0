Return-Path: <linux-kselftest+bounces-3953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D187284628D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E52F1F23F30
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD53CF65;
	Thu,  1 Feb 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK2iXzj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178D3D0A6;
	Thu,  1 Feb 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822519; cv=none; b=aegEyfgxBKHEWZkk3C9B8yAD3RvWohVm4Z5mih/2sIzFP2rk3CcEccbRry7FyJPEW36L906zYvUPx/x9TycHRXHtNO3QhuQ0zlZ/pJs4/TkkrkaBHd4MnlNaxyebWbq0V8OMoiwrY/Q9Hqd1nmSes3G42FMBfoW7KCSr0AtxZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822519; c=relaxed/simple;
	bh=8eF13XVgFUOAgGUl/pZoMhTgoS3Fz8iRTZX8gIbpk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy927RSNxQWYASBD98y8U9o3lchx04Jc2oYVysEl50T7Bmv8n3PRIUxPlkJLRcxOV/gdKc+FQiGHE4uxw4IjmfzuIbGoNb+2xYxJ+0zSA/QIMA7NToI7dt4j5BeGyu42H2buTWh0myKf1yANmbqiu4YoB/vducJdE7udfGMPnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK2iXzj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B59C433F1;
	Thu,  1 Feb 2024 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822518;
	bh=8eF13XVgFUOAgGUl/pZoMhTgoS3Fz8iRTZX8gIbpk/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CK2iXzj2E6jeI12AKEWFpVw3JXaMdUpDgO332orpB1+lbGVpHBagzPoFrdJBboNP2
	 S/loPLPwtZy7jFvBZNU7JuJ4ERyZXN9hOnkJ5uEHT2LnHz++TY+Zoj7iCQxxr6QQk6
	 mEU6t6hcjX3qLoI7AyGMyEYWAd4I80lVnwO/11Zkq4LgLA/ME+weiK3EPOFcRnguUS
	 fyrRlNc0ut8UYSz9CwoPF0piV3aiIWrOmfoRGdAUgvwN/Zs6SyU4ZJRmabcKwdcRlj
	 gX8WCSpTcA/XprbdA0jicA1A1XFhTSa5SqAvBB/GI/nkHveg6+j10nnnq4AEx7ljUL
	 eTqSwNS1/SHjg==
Date: Thu, 1 Feb 2024 13:21:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Message-ID: <20240201132153.4d68f45e@kernel.org>
In-Reply-To: <e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
	<20240131163630.31309ee0@kernel.org>
	<e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 00:50:46 +0000 Dmitry Safonov wrote:
> Please, let me know if there will be other issues with tcp-ao tests :)
> 
> Going to work on tracepoints and some other TCP-AO stuff for net-next.

Since you're being nice and helpful I figured I'll try testing TCP-AO
with debug options enabled :) (kernel/configs/debug.config and
kernel/configs/x86_debug.config included), that slows things down 
and causes a bit of flakiness in unsigned-md5-* tests:

https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao

This has links to outputs:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-tcp-ao-dbg&pass=0

If it's a timing thing - FWIW we started exporting
KSFT_MACHINE_SLOW=yes on the slow runners.

