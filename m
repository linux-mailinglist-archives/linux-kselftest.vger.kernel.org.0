Return-Path: <linux-kselftest+bounces-31935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0580AA1C52
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E389A40F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119582690C4;
	Tue, 29 Apr 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyhtJ7Nm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEA264609;
	Tue, 29 Apr 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959190; cv=none; b=K3RG49PeAGb63felAMpphnJSi/eSKgio+4K5YERVJeQCO/SImawUOJK8bgVIxE2gZIcGPNSYo8+vjhRvh1Xy1JLz5TqQ/Pvh6UIqqt4IpqApiC8A4pqvqiMI8Oiur+8lmf9fkVr7/0rwgGagsopokbqdjoIPIfsX6fdfSQEuCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959190; c=relaxed/simple;
	bh=nh6SiTlzkqiohzyI8QV40hgo95dZh4RW/NcHkb5NukE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gbMo6oLdIMxr07Jz6XgLloGyHJpkwda0PtWnLcf1bRU23gtWL5VLyw9ShVrlDqLsfFteJNOOIRsDyaWo6V5wW18KlKK0c4085nup6jWB88B8iosg13yTfT/Htc0Qkpibi7VHFE8Rc9GoDqg6Q34wzG/kIcJF/adjgBgAiAny0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyhtJ7Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464A4C4CEE3;
	Tue, 29 Apr 2025 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745959189;
	bh=nh6SiTlzkqiohzyI8QV40hgo95dZh4RW/NcHkb5NukE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PyhtJ7Nmp09ovrj+4obeXcXUvml+hidjsw1VQTmr0xHRkHkAwQrw7QQwT1r3Q+O92
	 RXa2pY7Njsq9FEuE7nQQQ/IsI2mw2dcHX2Qvv08GizFDtqEjlczmESxxnPd0N/t6cI
	 /LaIO+P1BgmAU1k6X+F/df4yywevW92U+G/DMplIlXmIcr21kqoJi8erBN6/55j16s
	 hXnixoVTU0VoyCD8V8OVN9fTPudSlQW3ss3y3AQ4JRMjzuXO6WBeOaqM3+5GUOwFuF
	 1r51Y2yAusv0Lq2wEKvkzjP5vsiMIstjYua6r5ZbTU7AZJLf8SnzAoZoMXlxkpRYiF
	 1ZtKa9SE/cLVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F613822D4E;
	Tue, 29 Apr 2025 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix kmem_cache iterator draining
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595922826.1790446.8715018652440001501.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 20:40:28 +0000
References: <20250428180256.1482899-1-tjmercier@google.com>
In-Reply-To: <20250428180256.1482899-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, namhyung@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 28 Apr 2025 18:02:54 +0000 you wrote:
> The closing parentheses around the read syscall is misplaced, causing
> single byte reads from the iterator instead of buf sized reads. While
> the end result is the same, many more read calls than necessary are
> performed.
> 
> $ tools/testing/selftests/bpf/vmtest.sh  "./test_progs -t kmem_cache_iter"
> 145/1   kmem_cache_iter/check_task_struct:OK
> 145/2   kmem_cache_iter/check_slabinfo:OK
> 145/3   kmem_cache_iter/open_coded_iter:OK
> 145     kmem_cache_iter:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix kmem_cache iterator draining
    https://git.kernel.org/bpf/bpf-next/c/38d976c32d85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



