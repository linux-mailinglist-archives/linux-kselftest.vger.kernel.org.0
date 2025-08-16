Return-Path: <linux-kselftest+bounces-39156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120FB29014
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89C6567363
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF252D3A80;
	Sat, 16 Aug 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVthTd69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161D15C15F;
	Sat, 16 Aug 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368835; cv=none; b=akhHc9V2p/nZ5drpnKO1BDbGb0GXnnVT+KmVzrp/Mriz9NXlVvbEjeg+DoARTAFRhh58Ej+MuBbSZBxbKMDMtQWpYUoGeV1ceU1OHzPsGa+2qzi8TVjB6SrR9ESw9zxJOIuC4zhHRSU2v43wFa3W1Cw5lv2YCDuOpwX9mfTR0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368835; c=relaxed/simple;
	bh=wsEBIuxySBNX56S3ZSXmQYy+ySJQlVUn2tu0BS9YA5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIp+MYMTpdEuj9Xih8H5LRGa1W1W30MDCe6q9DGf5w9X++ngbisfpdUQyZ5M5k5XA9TDg1zJpEekpV8riLIBcgwLV5iKUZ3L5sgB5NsiStID76fFh4FV7IvvrhQbH6HBEgBJ5vkyP5vZxVPtETGpaowwia7W0hLWXXC/STptj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVthTd69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C23AC4CEEF;
	Sat, 16 Aug 2025 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755368834;
	bh=wsEBIuxySBNX56S3ZSXmQYy+ySJQlVUn2tu0BS9YA5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVthTd69DKN4Ajoa/pVqLz8TngOJEgqMqHLIhWZpFKacImhptnl4Cw9WfVBuozJm7
	 8dJ/CmyMdYAfrK5BjNE3QZQ+kp/NouJAJoaAc4JVzDSVIKDYT/PfBhLiq9HIoH8sqH
	 42mZBe4s31RJ2RKJMuKzW6PcfJShafnClQt6KnP1F7YAhPZ7zKjajBvcFBSXMDQ/if
	 c1zDe66l0FOYxTEOYQ/5erImI5yYi0l5/4s7gpvnY8Pw6JAb8dF1BR7BgpaQiifq6s
	 c1V3Jl2arY0s2NRn2T2uhacyzLfrEWWeJgMBBUA0W3uHH4eAmIXo/kLWNGUM7lwO+c
	 lXg8hsEN2tMHw==
Date: Sat, 16 Aug 2025 11:27:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah
 Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, zhenwei pi
 <pizhenwei@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>,
 stable@vger.kernel.org, Thomas Dreibholz <dreibh@simula.no>
Subject: Re: [PATCH net 0/8] mptcp: misc fixes for v6.17-rc
Message-ID: <20250816112712.209644c8@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 19:28:18 +0200 Matthieu Baerts (NGI0) wrote:
> Here are various fixes:
> 
> - Patch 1: Better handling SKB extension allocation failures. A fix for
>   v5.7.
> 
> - Patches 2, 3: Avoid resetting MPTCP limits when flushing MPTCP
>   endpoints. With a validation in the selftests. Fixes for v5.7.
> 
> - Patches 4, 5, 6: Disallow '0' as ADD_ADDR retransmission timeout.
>   With a preparation patch, and a validation in the selftests. Fixes for
>   v5.11.
> 
> - Patches 8, 9: Fix C23 extension warnings in the selftests, spotted by
>   GCC. Fixes for v6.16.

userspace_pm.sh which hasn't flaked in 1000 runs has flaked last night,
with this series applied:
https://netdev-3.bots.linux.dev/vmksft-mptcp/results/255941/8-userspace-pm-sh/
Looks unrelated but also quite strange?

