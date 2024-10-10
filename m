Return-Path: <linux-kselftest+bounces-19417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90208997A36
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B58B22087
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CE2AF07;
	Thu, 10 Oct 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du38NeTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4463D5;
	Thu, 10 Oct 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524425; cv=none; b=QxdrhHQwyX4ntnSseicSxD8E2haSngp6UaIn/db9XO44GFq8QzOJmg5SDYwMMpsI4dxhalHPEhkVPQLvR75Ds5VWvfyncAkHdjPgF22pQSq7L+cZMOWpXODl/wrUzTME0QbehhH72WKGOKH8qH43u6Ul+2JPTmqCNTiaxaguAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524425; c=relaxed/simple;
	bh=xzKv5Lvcq2TpTT/caJDAv3dxGtC+XX9K+KrJi1bm/dA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4qLrIPbx2m0IaFdAdLDP5MisTn0aX+MRU2VCHba+L4yrcKhKhBSFKrBtSKk+AXNV2ITXQ5pDnlIV0e1gkQy1DpHK38kBbZLLHP5OqiYkRH9Kf0xRpD8qsflAkOSd0VlLWQIdsT0U85IuacTXOX31ae+tzbqzEH8pOgyqeUkfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du38NeTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43A1C4CECD;
	Thu, 10 Oct 2024 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728524425;
	bh=xzKv5Lvcq2TpTT/caJDAv3dxGtC+XX9K+KrJi1bm/dA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=du38NeTzI7IOKQLyKS58CzzII34otVvBWS6NcG6nAuzZvE+Kni92BEmEo2JYT69mK
	 C3ipWjNUV2uvsF2gw5Fie4XQcb/P44UMQsX6TEJKyb4gWn6cubAu8EewPS1tVZMQKH
	 bQ6ORmcfLklJT3k//CVlqHQbA/NPEwpvgBfD0hItQ0dz3XI0GL1ONZ/xhKEY++n5rj
	 IOL/jpEI9+lbl1p4ITAn5IMSw47pf1FAef5bwHwXc5Y+gJTfD8Vv/WQ+UsHqB/bcdD
	 o/90AKa55spxnov5OpwxrZCo1WB9bgdB76zXqGXmUFrEE3Hoxkf3Tv9jVx033Qgk07
	 9ZAi0RvuJbzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E853806644;
	Thu, 10 Oct 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix error compiling cgroup_ancestor.c
 with musl libc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852442926.1533554.13846749772507129995.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:40:29 +0000
References: <20241008231232.634047-1-tony.ambardar@gmail.com>
In-Reply-To: <20241008231232.634047-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, alexis.lothore@bootlin.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Oct 2024 16:12:32 -0700 you wrote:
> Existing code calls connect() with a 'struct sockaddr_in6 *' argument
> where a 'struct sockaddr *' argument is declared, yielding compile errors
> when building for mips64el/musl-libc:
> 
> In file included from cgroup_ancestor.c:3:
> cgroup_ancestor.c: In function 'send_datagram':
> cgroup_ancestor.c:38:38: error: passing argument 2 of 'connect' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    38 |         if (!ASSERT_OK(connect(sock, &addr, sizeof(addr)), "connect")) {
>       |                                      ^~~~~
>       |                                      |
>       |                                      struct sockaddr_in6 *
> ./test_progs.h:343:29: note: in definition of macro 'ASSERT_OK'
>   343 |         long long ___res = (res);                                       \
>       |                             ^~~
> In file included from .../netinet/in.h:10,
>                  from .../arpa/inet.h:9,
>                  from ./test_progs.h:17:
> .../sys/socket.h:386:19: note: expected 'const struct sockaddr *' but argument is of type 'struct sockaddr_in6 *'
>   386 | int connect (int, const struct sockaddr *, socklen_t);
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix error compiling cgroup_ancestor.c with musl libc
    https://git.kernel.org/bpf/bpf/c/60f802e2d6e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



