Return-Path: <linux-kselftest+bounces-18088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C097B2FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B34283B8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3A185939;
	Tue, 17 Sep 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8Vly7DM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD917BEBA;
	Tue, 17 Sep 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590632; cv=none; b=BQRvfJaOiXmIhsYdS3eMgq7nT8LiWDcOUyt2fdqwM+ZspmlMvD4qCBx4Lb8Pc7Hmm2oxhJTBiHjGxypblJPG4+uVJvF+FmAHfuaDxbSab4XwBfYWPAegI4DaIZHwAIbkB3Z4KORrg5htFM9hd8/MIIwCphNM88cWvuNJy2m9Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590632; c=relaxed/simple;
	bh=lQqntmL1ttZKhZMDncdN8GbOYQhtpcwCxUa/bELgZ7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WFj2uWX6x0q5k7y43GZQrLPUDEoUWlVBlpzGR6XzB1vpGfRlf4C66ddLolfNTt5tFoIijiZ8J6u+Lcpkfzm8dj+oxcFzQv6iyAd35D+aNXdtS2AT8+sCORlcOiL4e4SLhpfz1RgDOedaKHVCMXPqohsMd7y5rLm3icnhFG1jAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8Vly7DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F86DC4CEC7;
	Tue, 17 Sep 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590631;
	bh=lQqntmL1ttZKhZMDncdN8GbOYQhtpcwCxUa/bELgZ7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8Vly7DMbQMpC5+BEW3lWDDeCIYAxmVQ9Nd/AqGWWgp0ff1Ti4Zl/N1cqc6E0QK+h
	 6MFHM7DuLMKLyDSi62fB8QrM0COs9cyu4WpVYTVjtq/q5xoKSj8jvutfH8MELthWRH
	 N37om+8jgLA3HVZEGmx3QXXOlocT5IikUzoNPFpFRTVuHXKgI124RlXCgptdz03OnY
	 tqRNWyPQtmGYa7qsvTqM2ulbQJSy9O5EKwyM6ktomEHocn0sP9KlXXtKx0hocVr+BM
	 rj8PGM7AnssTWgl0nvhy5ZrevJJRdQpd/EAX0iOseDIgIwwJ03aDVSB0G5+bnValis
	 KYWkQ62R9e3tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 722603809A80;
	Tue, 17 Sep 2024 16:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: riscv: Allow mmap test to compile on 32-bit
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172659063303.214459.9757060664956145084.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 16:30:33 +0000
References: <20240808-mmap_tests__fixes-v1-1-b1344b642a84@rivosinc.com>
In-Reply-To: <20240808-mmap_tests__fixes-v1-1-b1344b642a84@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 08 Aug 2024 11:41:40 -0700 you wrote:
> Macros needed for 32-bit compilations were hidden behind 64-bit riscv
> ifdefs. Fix the 32-bit compilations by moving macros to allow the
> memory_layout test to run on 32-bit.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 73d05262a2ca ("selftests: riscv: Generalize mm selftests")
> 
> [...]

Here is the summary with links:
  - selftests: riscv: Allow mmap test to compile on 32-bit
    https://git.kernel.org/riscv/c/11c2dbd7f241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



