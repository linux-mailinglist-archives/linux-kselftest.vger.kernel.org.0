Return-Path: <linux-kselftest+bounces-24507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2AA10FBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E9F18808C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1E207A23;
	Tue, 14 Jan 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grbEg9HZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523A2063FF;
	Tue, 14 Jan 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878620; cv=none; b=GDQCwT6udBfnwd0QyW7R4Q1c1gy7QgDoWervTVaQf4NypVR4qKNh88zPfRpMIj53lcZpFvULiCn18Gs9wd1fYVYDBi6cLHrvVOrYaI6CIWYB1Tm5+VUNqMYUx1uz8Ds/a/Pyi28xXrfs+W0ELLR8PNRVqcCaoH1KMhWMF341Fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878620; c=relaxed/simple;
	bh=D/SHSgsiMa7Rb7nwePwpbtlLjnB91paCMmxG3twAM0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9IKEpiklcKGHSrrYpC4aX2FuGbg+CmQoTi08MWb15D31z+W1wsema2fIHl9jwqqe0C0oEp5B/dSIabfgQOtq8SqNgDld+II+N+E7khgAZSX3Hwa8TGRFGHOHTIW7Qk/DxtKyI6PQiym+Rpsvwq1eMd42m/Z/ZMqdwtuizf3wZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grbEg9HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B0CC4CEDD;
	Tue, 14 Jan 2025 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878620;
	bh=D/SHSgsiMa7Rb7nwePwpbtlLjnB91paCMmxG3twAM0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=grbEg9HZFr7ic23HcKgcX38W0WpdUNeWm4A4ldc8lnNCc4kCFJSoldtNdzPcBUnIT
	 7NwtszrgHzsaVarRiraZlO6HmxshtdEevhYBwMSo9zg1QsIib3uo5ycjgzJFyv/lUz
	 JFDv3EMZ4N5THpqFqQEhfrnLgRcd84xPn16L79BpEg0ZCa0BXEi2CCzX3cyt6drOW7
	 ecIdI8mC1ePpRFXm0wtGwjFEzZnzea4UbXGz5KpsSvssGkioBLfk+pQfztcNLah1Yf
	 rpJBKCpayU2M0q4R83tRFHRsDyIRU4BJ8358WWuordQdjjmGsbexqAwOQRUwVj98SC
	 TP7rs4DvGmksg==
Message-ID: <5e2058ea-2292-4403-a7b9-ace4b21dc9c1@kernel.org>
Date: Tue, 14 Jan 2025 19:16:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/3] selftests: mptcp: Fix various issues in main_loop
Content-Language: en-GB
To: Cong Liu <liucong2@kylinos.cn>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "'David S . Miller'"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250113085228.121778-1-liucong2@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250113085228.121778-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cong Liu,

On 13/01/2025 09:52, Cong Liu wrote:
> Fix several issues in the mptcp connect test's main_loop function.
> 
>  - Fix a bug where the wrong file descriptor was being checked for errors
>  - Fix the input file descriptor lifecycle in the reconnection loop to
>    prevent use of invalid fd
>  - Add proper resource cleanup in error paths

Thank you for these fixes!

Please note that when sending patches to the Netdev mailing list, it is
asked to follow some specific rules, e.g.

- designate your patch to a tree - [PATCH net] or [PATCH net-next]
- for fixes the Fixes: tag is required, regardless of the tree

https://docs.kernel.org/process/maintainer-netdev.html

If I'm not mistaken, it looks like you have here fixes for net, and the
Fixes tag is missing.

Do you mind sending a v2 with this being fixed please? Because these
fixes are not urgent, do you mind sending them only to the MPTCP ML for
the moment, and not to the other ones (and no other people in CC).

> Cong Liu (3):
>   selftests: mptcp: Fix incorrect file descriptor check in main_loop
>   selftests: mptcp: Fix input fd lifecycle in reconnection loop
>   selftests: mptcp: Clean up resources properly in main_loop
> 
>  .../selftests/net/mptcp/mptcp_connect.c        | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd

Note that this base-commit doesn't seem to exist. Because of that, our
MPTCP CI was not able to automatically apply this commit.

Talking about our CI, it looks like that 'mptcp_connect' now crashes in
some cases with:

  free(): double free detected in tcache 2

Do you mind checking this please?

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/12751035845

pw-bot: cr

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


