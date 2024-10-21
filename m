Return-Path: <linux-kselftest+bounces-20314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805369A9139
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4110F28130D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D81E1C08;
	Mon, 21 Oct 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzBLfEpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3441EB56;
	Mon, 21 Oct 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542627; cv=none; b=UGfmg3CFpZrGq+WxFbt9FWY1tEfTEnZWeY6O/6DkIczPe4DcaShuyeTrwrqL81soBptEAqzhuRPXy7HCiXnRj26gVDhHzVeDX17tj8AWhBuf8ceZLngAgaqsn88bDW1Yi+fFd3W7wmeCw5IRzaoo3PrPajOgynEukByCWGNgMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542627; c=relaxed/simple;
	bh=f55I7hd3ZiDA+5Y7mFK+JVZSZYjx/4SOQmu/HusdAhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrjhwQYtsl2Z987gbpbdp5mKBTUzPiDktsd6M83Ge+aUw5IBYwDFxf7AqKBjnC9Of04SNCGEGmdkWDk0HRdQF62dOos+C4Z/zTJ8/lkNIPCusrUZCpDvQ5J9Y5rqGhntj5MIBFzPqSiIPqZSY3PeRmtIsNh2H1wkjkgFhcTUFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzBLfEpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30078C4CEC3;
	Mon, 21 Oct 2024 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729542627;
	bh=f55I7hd3ZiDA+5Y7mFK+JVZSZYjx/4SOQmu/HusdAhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzBLfEply1VfM1c/EMcxcqVHjYsFbQy8bivKJPi/rP7sS0vwVGINdpeIwf/xnupDn
	 U5Osj37LFibM+uKcUoKNhluhHDEwDNdNSgvR0fZcIl/VqvZBGBixV+potQXkF+4ccY
	 N7qGMfj/AiCkx3VeT5iFpevFemPTapI1vPT2pNtzPzuakB08MUGh8cMV0Svacfncui
	 Br5HXCA2MU3bKYA8lNLgIg9OnfEmrnAkBqOCFfZBUU0Ni1z8KJvNL/0rmhRWMmJqWx
	 wPnL2AcqDtGhlvTNd1WkQ1oyh8RqPKKkG8G9SMihDrg31q6P+gJqoITEGB6GfUaPWT
	 HRbgZU6FWkScw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7125C3809A8A;
	Mon, 21 Oct 2024 20:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: integrate
 test_tcp_check_syncookie.sh into test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172954263326.435868.3133928698828501979.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 20:30:33 +0000
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 lorenz.bauer@isovalent.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun, 20 Oct 2024 21:22:52 +0200 you wrote:
> Hello,
> this series aims to bring test_tcp_check_syncookie.sh scope into
> test_progs to make sure that the corresponding tests are also run
> automatically in CI. This script tests for bpf_tcp_{gen,check}_syncookie
> and bpf_skc_lookup_tcp, in different contexts (ipv4, v6 or dual, and
> with tc and xdp programs).
> Some other tests like btf_skc_cls_ingress have some overlapping tests with
> test_tcp_check_syncookie.sh, so this series moves the missing bits from
> test_tcp_check_syncookie.sh into btf_skc_cls_ingress, which is already
> integrated into test_progs.
> - the first three commits bring some minor improvements to
>   btf_skc_cls_ingress without changing its testing scope
> - fourth and fifth commits bring test_tcp_check_syncookie.sh features
>   into btf_skc_cls_ingress
> - last commit removes test_tcp_check_syncookie.sh
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] selftests/bpf: factorize conn and syncookies tests in a single runner
    https://git.kernel.org/bpf/bpf-next/c/6414b3e5d5d4
  - [bpf-next,v2,2/6] selftests/bpf: add missing ns cleanups in btf_skc_cls_ingress
    https://git.kernel.org/bpf/bpf-next/c/0335dd6b5a4c
  - [bpf-next,v2,3/6] selftests/bpf: get rid of global vars in btf_skc_cls_ingress
    https://git.kernel.org/bpf/bpf-next/c/0da0a75cf649
  - [bpf-next,v2,4/6] selftests/bpf: add ipv4 and dual ipv4/ipv6 support in btf_skc_cls_ingress
    https://git.kernel.org/bpf/bpf-next/c/8a5cd9860235
  - [bpf-next,v2,5/6] selftests/bpf: test MSS value returned with bpf_tcp_gen_syncookie
    https://git.kernel.org/bpf/bpf-next/c/3845ce74777e
  - [bpf-next,v2,6/6] selftests/bpf: remove test_tcp_check_syncookie
    https://git.kernel.org/bpf/bpf-next/c/c3566ee6c66c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



