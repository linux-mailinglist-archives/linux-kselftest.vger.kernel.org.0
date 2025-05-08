Return-Path: <linux-kselftest+bounces-32663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E601AB00B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F07B2815
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A5279914;
	Thu,  8 May 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejoa2BEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BD78F32;
	Thu,  8 May 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723088; cv=none; b=dyk1s5KnHd3JQfw3BzvCvYS61kMxqr4b0hZCPJ9BiZuSZuFXUu1Esa+X0eMTbwJAh9daJsfKxKgG68b/NEYKX+FKMr/FXQvBAtdJXiJoedV0jX+bzwo+7nFj3El6a9YRmt+AWHbIEsDD4zKGqGGNviuiuAie6yPLdXM6/ykNINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723088; c=relaxed/simple;
	bh=0k+Wh6+uCGMO9uLN2T6ncyytOn1upByjcEkNa1fx1r4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fx6EYjdXLDLoJ9GyJn2Ncsdu3CkRMzepRlErVY+pTHGr7SRU3pJ+Swu6splZDwQxchVG1j/k3LscO2t16XnFGuRiXwHP2uQupvXQj2SiRkiEE2jFTI6Nlms18aRwI76pLt+HUaBnhEudHNK74atGyfNy2V4boIQB+JC3G3bVXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejoa2BEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56570C4CEE7;
	Thu,  8 May 2025 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746723088;
	bh=0k+Wh6+uCGMO9uLN2T6ncyytOn1upByjcEkNa1fx1r4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ejoa2BEdUlP1DbdY+j6d/ljdnXRtQ1JbuAIfWusXbXKwEX2fAuyovjXR4W6Ae76iB
	 K38V/ZVWGLbXs1xCy6gk+awFa54Rf1FxM+pA7SEMwyHQdjtXBLBBIsRZKr310lDAbR
	 kihI2OY/f3f/wrzvZj0R1ayWyPLh/OnpZT6MIEcooHaLQJaWUQYK2jHBGZSaoEIV7K
	 B3FHNQPprAa9LUrjKJhEoMbJkMusxLL7mUsQK/cIgq3Pf7lpskw8TxB/nBUsU9oE6Y
	 FfCfGnvoHs8lEhvhnxA+Nje7AMklgjO2s9qIJzoSlO/Liq3TqHGc8te/hGkPFfXQ0X
	 adn+WSXQ/Dlgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34016380AA70;
	Thu,  8 May 2025 16:52:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] riscv: misaligned: fix interruptible context and add
 tests
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174672312700.2976395.88758017141795080.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 16:52:07 +0000
References: <20250422162324.956065-1-cleger@rivosinc.com>
In-Reply-To: <20250422162324.956065-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, shuah@kernel.org,
 ajones@ventanamicro.com, samuel.holland@sifive.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 22 Apr 2025 18:23:07 +0200 you wrote:
> This series fixes misaligned access handling when in non interruptible
> context by reenabling interrupts when possible. A previous commit
> changed raw_copy_from_user() with copy_from_user() which enables page
> faulting and thus can sleep. While correct, a warning is now triggered
> due to being called in an invalid context (sleeping in
> non-interruptible). This series fixes that problem by factorizing
> misaligned load/store entry in a single function than reenables
> interrupt if the interrupted context had interrupts enabled.
> In order for misaligned handling problems to be caught sooner, add a
> kselftest for all the currently supported instructions .
> 
> [...]

Here is the summary with links:
  - [v2,1/5] riscv: misaligned: factorize trap handling
    (no matching commit)
  - [v2,2/5] riscv: misaligned: enable IRQs while handling misaligned accesses
    https://git.kernel.org/riscv/c/453805f0a28f
  - [v2,3/5] riscv: misaligned: use get_user() instead of __get_user()
    https://git.kernel.org/riscv/c/897e8aece3c8
  - [v2,4/5] Documentation/sysctl: add riscv to unaligned-trap supported archs
    (no matching commit)
  - [v2,5/5] selftests: riscv: add misaligned access testing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



