Return-Path: <linux-kselftest+bounces-41521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1ACB58430
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E892A246C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC72D0C7F;
	Mon, 15 Sep 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1bU2KrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420B285CA4;
	Mon, 15 Sep 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959211; cv=none; b=MCaKf6ztCIf12P1uuBv52LlhWo2B/WXMk8kOJVliarVtyCM3QxX2P2vfSB3lNuNvtoUFA+gZmAhvCekgFSgQ91T9l8QrY/+GsLI+rC9he9rYgWciIV0aZMk9KoD1zjy2oesaowXMKimjmtx2XQeWKZAU0PHqa9U8iN01HcBXgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959211; c=relaxed/simple;
	bh=FhILZZNjVfzBMHP8WjQbm5ZWTJiyXx/i30Gl2iWGyCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMF3sfNtNqbXI7AEPnv6yfpKJLMNlfsqZU2wES/WtTZ+72NjKKMYZabFW0kcd0AbvZ/kPARlAEc6Du6YWppMfjeNfKWKH/Cazr2f7BSoRD2azSp7W0nvf6HppxCP0ij+ObyJS4go9iY/ycT3oPARKXdMYTdru4N+jQF3uKPRHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1bU2KrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA93BC4CEF1;
	Mon, 15 Sep 2025 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959210;
	bh=FhILZZNjVfzBMHP8WjQbm5ZWTJiyXx/i30Gl2iWGyCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W1bU2KrRqCK+kBHXPM6DcKCbQDCRG4hjdZ2bxK8/zntd/d2i7cxmrpB441m45pfBv
	 SiHAVKuKbUFj3bGilknKkiv/4iSrdAdlk8qO55kYd0RMWO7JmSk8RQ6nH3nBWFdJMu
	 SJE6zSw/kaGL4xh1IJ+kF5bgQRaOj/prEKfUOMNV5nLofN+QZp6YeeLKQsl56ix50F
	 RXlulrjk4pYFJwMj2Vg9oEjvBimTBUQOplHg7JMk7gpKF/EdF3CUxBRVGVpukmU+g/
	 kzqDipA9n0meEelwotAaZhKlVhnJXGzlPM3gVeKTcUZpyZ/ja/C5K5l30WeHIWzQCe
	 dvh7BW5rhqt6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BBD39D0C18;
	Mon, 15 Sep 2025 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix arena_spin_lock selftest
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795921200.78773.13315204192011588017.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 18:00:12 +0000
References: <20250913091337.1841916-1-skb99@linux.ibm.com>
In-Reply-To: <20250913091337.1841916-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, sachinpb@linux.ibm.com,
 venkat88@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, iii@linux.ibm.com,
 shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 13 Sep 2025 14:43:37 +0530 you wrote:
> For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
> the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.
> (eg - incase of powerpc default value for CONFIG_NR_CPUS is 8192)
> 
> The selftest is skipped incase bpf program returns EOPNOTSUPP,
> with a descriptive message logged.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: Fix arena_spin_lock selftest failure
    https://git.kernel.org/bpf/bpf-next/c/a9d4e9f0e871

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



