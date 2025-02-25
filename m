Return-Path: <linux-kselftest+bounces-27426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4BBA43B76
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E078164407
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE872267B75;
	Tue, 25 Feb 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ/Rsx96"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A7267B6B;
	Tue, 25 Feb 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478795; cv=none; b=hR8Bp8j0IgYzvbqJclR3UsMDCbHaq1KZ81VC6bSOMAmXi4GBm6RyTvckzmVhQoPhweY0oAr9/oqt4nyjBzd7eX27p7a7T0sp3qqzRaZRmEb8MZpSsLn9zifsgfdSpRyBSQ17bFkeV03AFaojGf/1F0adxtRQKTMq4udJmTS9XsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478795; c=relaxed/simple;
	bh=S2p1coh8t/8MP/cC8KJGLasv7aSJ6xKz0yMiltQG9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2CpmxALCD+kUg9ZBR1zjzTvlLJLEemdxHqnMaA+51PlLBjGtJw1uswqCMThxUBZxOig5BlAZ3ApcVkoiedTwdsgSn4MQW7sJjaDq12NhYPflsAn2j+IFZARkRmsPV162q0YoOsqOiVkk4UvAxQGs/YkwgtMSOasP3CI2CEj6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ/Rsx96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF61BC4CEDD;
	Tue, 25 Feb 2025 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478795;
	bh=S2p1coh8t/8MP/cC8KJGLasv7aSJ6xKz0yMiltQG9OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQ/Rsx96PgJU2GRYgrByzO5VYEPvZPHjs5OMErfEYRyyvtlY8wVpvgCtJ7SnoC7nJ
	 jm1j29UNcwH76KN82PMm7FMaFaURTa5waO9QDlpcNTBzO869IfRmFmTyj1k924vRw2
	 9ret6n3MdiLlx9eH9IXiqEBOpCM97e2bG1LN+Mpd+zNIVRoaLn/o6EkJg0mMQrrHm4
	 63Nt9pc4mlC8/isc9dMnkO4vdRHp/f5nPr3N+E9c/XvVgMDJsH8A0pN1obPGXF166u
	 7oyl1xXOfHHiKYnwJxw7myZKRdk5j3lJpFdkb9Lpe8pmnwgpZbpM21ccX7DlPo1HQj
	 wJgMDGNSzgidA==
Date: Tue, 25 Feb 2025 10:19:50 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/7] netconsole: prefix CPU_NR sysdata feature
 with SYSDATA_
Message-ID: <20250225101950.GN1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-1-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-1-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:06AM -0800, Breno Leitao wrote:
> Rename the CPU_NR enum value to SYSDATA_CPU_NR to establish a consistent
> naming convention for sysdata features. This change prepares for
> upcoming additions to the sysdata feature set by clearly grouping
> related features under the SYSDATA prefix.
> 
> This change is purely cosmetic and does not modify any functionality.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


