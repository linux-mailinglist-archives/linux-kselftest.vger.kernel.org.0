Return-Path: <linux-kselftest+bounces-22542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543789D9C1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ADA164A77
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068401D95A9;
	Tue, 26 Nov 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOuYoEUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25041C5799;
	Tue, 26 Nov 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641016; cv=none; b=PbjQqOlzcNqJJ3moavrBTsSK4nqgEty4R7m7ubMWEQcUfs1skboeZpvll8Ono0dWRXq6bKhcpm4thDqBK6hF1jRIqoZXCF3+u3dtc3kIhSQkmwWUoFRh0wFQkmccbQ0SoslIS7d+IA7QVFkHNNvvGm45xG+PDuFedbPgnrmu33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641016; c=relaxed/simple;
	bh=MvAd4gRVH2AxB1g6QxikjUit0eu8/aIb2WGd+Mdae74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c8v4QzKwF2gSmLvcs4ALZEizDC/SJdpP1+1anCi5mOf5mYih6QmWIfdfGQXJBRu52SpmwpduZnRJcnv6lLTWxwYD+8CU7YDs8Bfxgm6E8c+uv2w4N4MuTLikCP784eph+syth+EfOnXDDkNk8a+aacWOGi0eVDCB9FGRItGSDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOuYoEUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF6DC4CECF;
	Tue, 26 Nov 2024 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641016;
	bh=MvAd4gRVH2AxB1g6QxikjUit0eu8/aIb2WGd+Mdae74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IOuYoEUqYJjAP7ZJVrwFf5jBW5DYR1vWxHLzauRCQn6LgOnXmZ4NBAsb2Xty04F5A
	 TKBSle+n3cS65v4vacsPD9aNB19dks9fPHe6HrUEbBowDlxJGzVR7R+4Wm+NLCPbWU
	 KkdQifFl8sLbjoMzEb0J510XZXepc8bbAQ42XR3fVF+z1sDff5dkL81c88peMaXz+k
	 KfyFqzMuGtOeYbkKanO1lt5+oM2j0+1sbYooj7CYbR8uIhjIn9KpQTlbqHsWyrLUfC
	 lMKAmxz/reuBoDCAczLg9MIomedRpj62X2CgXw97nRI2r9GQmy7DG/buPgT2idzbUi
	 obmR3isVTHfMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1B03809A00;
	Tue, 26 Nov 2024 17:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Check for PREEMPTION instead of PREEMPT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173264102952.477780.5683459007751613946.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 17:10:29 +0000
References: <20241119161819.qvEcs-n_@linutronix.de>
In-Reply-To: <20241119161819.qvEcs-n_@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, shuah@kernel.org, tglx@linutronix.de

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Nov 2024 17:18:19 +0100 you wrote:
> CONFIG_PREEMPT is a preemtion model the so called "Low-Latency Desktop".
> A different preemption model is PREEMPT_RT the so called "Real-Time".
> Both implement preemption in kernel and set CONFIG_PREEMPTION.
> There is also the so called "LAZY PREEMPT" which the "Scheduler
> controlled preemption model". Here we have also preemption in the kernel
> the rules are slightly different.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Check for PREEMPTION instead of PREEMPT
    https://git.kernel.org/bpf/bpf/c/6b64128a74eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



