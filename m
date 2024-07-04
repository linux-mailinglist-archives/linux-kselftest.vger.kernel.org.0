Return-Path: <linux-kselftest+bounces-13201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96519276E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 15:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BAC1F23821
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692041AE87F;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paZrJQyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FB1AE848;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098657; cv=none; b=Wh9HcWg0uyI/3uKSfcnIMTMclN0+nb8VbC30yw6fktl+rnHO3733cCsp00XI/EvzJr9waGeiuIFXOu2OUeLWi1lAmuKL6bxin9KgvyHkg4J0o85l0lE5ZwT3dixW+LbZD42xnEfaDJU8X3LRy4AYXYUgseasJKvKNj3T3WUVfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098657; c=relaxed/simple;
	bh=LgXnJFsYyRvjaEK1ntPm88fL7Wm+lyk5mTRJwn5WJdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swGvLiif/eJiSOgzak0tQ218pmikXRlh50OYjNcr0byIjlzEZpMjFMBSAdmT7aa37pEbbLiYjtJ6S/zNfWlAzhWRtusXtoq4vUiGjtmYQ2CEl+b5RWNgwiqjCSWWErb2pubRndqge027TqN9CW9iPkFBYRTPsbSOfePvAQos+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paZrJQyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6BDBC4AF0D;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098656;
	bh=LgXnJFsYyRvjaEK1ntPm88fL7Wm+lyk5mTRJwn5WJdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=paZrJQyAWMUf3S9qd1u1maQM6otdP/Ej229Xc/6APRWTyHd9CYXxmXvkow2LijCvB
	 xwXJUdLqcAM6e00HmrI8z+OpimD6hTFvVEQ2QH1kMmDAvuR/kVpGGWbvXObh28F4I+
	 HngTCDSU9HlYOh4j1BNg4tVHE8By8lZGQkdhD2D9kFmv0YmdWK6Pqa0NM8Cww2vFsU
	 LB+IwQVV4liBIt9A2TiXD3dOgmaSNr+06FKfTZzPS0wgDGCVlBraKVRjKLSN9WHybI
	 b/TqoPHrOYhLEirInV5azf06QiqZ41gVT0NKy4j6iRFwNg49nHpvTH4IxSJ+FgwVtI
	 MlPMDBOyElgBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4DE3C43614;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: selftests: Fix vsetivli args for clang
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172009865679.17306.1065674073385433619.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:10:56 +0000
References: <20240702-fix_sigreturn_test-v1-1-485f88a80612@rivosinc.com>
In-Reply-To: <20240702-fix_sigreturn_test-v1-1-485f88a80612@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, andy.chiu@sifive.com, bjorn@rivosinc.com,
 palmer@rivosinc.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 02 Jul 2024 18:54:48 -0700 you wrote:
> Clang does not support implicit LMUL in the vset* instruction sequences.
> Introduce an explicit LMUL in the vsetivli instruction.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 9d5328eeb185 ("riscv: selftests: Add signal handling vector tests")
> ---
> There is one more error that occurs when the test cases for riscv are
> compiled with llvm:
> 
> [...]

Here is the summary with links:
  - riscv: selftests: Fix vsetivli args for clang
    https://git.kernel.org/riscv/c/3582ce0d7ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



