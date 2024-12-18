Return-Path: <linux-kselftest+bounces-23536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519179F7107
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 00:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373E2188F7E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DA71FD7B1;
	Wed, 18 Dec 2024 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMB95StF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947E19CCEC;
	Wed, 18 Dec 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565081; cv=none; b=I4mObAh5Uz/8WJHj4fjezexar8bkfSG4/kZoQ+f0y0L/MUpbsLoBnAKBL853s4VsCm5SgpVGeFewh36EbxNTcUuQE6U1DUb7tB9OXlyNtKpuDs5zW+IaQryuy7SXUS1dN3HpuiN7qPEilzqFJGcef71bpu8+ofCFhceOVm3XJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565081; c=relaxed/simple;
	bh=TE9MeQggFrUNHk7GnpsPc1qOO621qZHYt6YKXQvYGUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUFcnQ9HasVvhYRx6bQG2VCh7AJ68uSHy46mgS2LED2hmIDRPkWAPwVaNSwabrwBXmtSU+Qqqou6Rg17Nu7bet9yj1m2Qy1qc0VAkmUVavJN578pEdKt6/4cp4yk1Fsjo890fdj230dO6+dCzD6bI57uKadixfKK0u624IgY7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMB95StF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9872C4CECD;
	Wed, 18 Dec 2024 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734565080;
	bh=TE9MeQggFrUNHk7GnpsPc1qOO621qZHYt6YKXQvYGUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMB95StF87lMswBTmoy5w+GFfz3iCmebU4gbeFCJK7sk9+I16C9cplpIYLf0W9Qul
	 QxmbLpIR7/E6R0kf5eKkyEYZx8mBxxIidhrnHdr7M4IeFwaA3J5y2wWv4oQmfmxORv
	 D1j6lmCsAMuKx+jWknHgUh8GEb58788JfHfg1N+UuccR+d6b8ALbB6vzMOTnfrbNpk
	 nrbFqHQ3vUtoVAGtl14Lhqr/MD+oEcAwxAPHEo6k2fp/JS6ZLbq87qH4FknN0j6i1c
	 yDKA9jZ2UNpUbRlqHX4gnIrK03GFSOZ91dNOO2mqCDLBVJi/w2/4kNnX7grOmVIZvb
	 15jS4zu2mRPLw==
Date: Wed, 18 Dec 2024 15:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/11] selftests: net: Add test cases for
 link and peer netns
Message-ID: <20241218153759.672b7014@kernel.org>
In-Reply-To: <20241218130909.2173-12-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
	<20241218130909.2173-12-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 21:09:09 +0800 Xiao Liang wrote:
>  - Add test for creating link in another netns when a link of the same
>    name and ifindex exists in current netns.
>  - Add test to verify that link is created in target netns directly -
>    no link new/del events should be generated in link netns or current
>    netns.
>  - Add test cases to verify that link-netns is set as expected for
>    various drivers and combination of namespace-related parameters.

Nice work!

You need to make sure all the drivers the test is using are enabled by
the selftest kernel config: tools/testing/selftests/net/config

This may be helpful:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
-- 
pw-bot: cr

