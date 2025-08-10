Return-Path: <linux-kselftest+bounces-38647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08225B1FC30
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 23:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CEC7AA826
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFD222CBD8;
	Sun, 10 Aug 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCOBV3tU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0F22A4DA;
	Sun, 10 Aug 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860330; cv=none; b=uW36EKXhKW9z07HIja324++MX0a7yHazWhVColsBFwdTIbTJR/2yheTxB2yYUlV2HjT877jxU8aNTLUZM1O3cvkNKsQVdL5+RFqaiRn+yhsfgDSa2ZAlVQo+Q9+NzRrAkL31+Xyp6s3zO/nXoQwF/yWUeZOJ9ukhdh05iVyxoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860330; c=relaxed/simple;
	bh=PTB+y1bea+X0pwle+Qsb0krCZI4wJwkr28qnyuTl7j4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hczlwUowThmGaIIQa6Vt6qpx34/PL/cHbhQOygSaAvDu48nmIPqFqH/fQ9n9EX+P9Lg6RTtBynxT4wDoLLugNrRYJiUm9pUQG0CpDHNA4z1vIkmv6ZXtNfhE22Ao9C/6kDeQV4y7/fk5j8LkrYpBexGx8B5TCG+0YwYWAl4HaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCOBV3tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF676C4CEEB;
	Sun, 10 Aug 2025 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860329;
	bh=PTB+y1bea+X0pwle+Qsb0krCZI4wJwkr28qnyuTl7j4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HCOBV3tU+ctjdX3pY3Zg/0pvMsfqNnXGmHLBwd4NcMVjVEH7cvRnVceivTVzUTBgz
	 iBywCPbd901UmslM78Hnuk/eTpHS6/f3sLyf9xPRghxH/2C+4EPHmKaK3TU1y8G/SD
	 2LZGbg4pzBNtyw7wRgsvYlW0+yX8/zcykqfhKvNIWp878PjsojxBNWCh5PKt5A4KoZ
	 LQ8F53gT97pNeIvGJtMveQduZsLP39bJ9M6pBSMzg1LErA9A75yivHXsm8MZHlMgbc
	 tG9XSvaRQ5XBE9KczEQP5WOF5MlpsjN04vNY4GNEFA7Y6xVuMV9vlzvKe/2lUu0GBk
	 cXiQT6eCpZTTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1539D0C2B;
	Sun, 10 Aug 2025 21:12:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/13] stackleak: Support Clang stack depth tracking
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034248.1221929.3658503475425874388.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:22 +0000
References: <20250717231756.make.423-kees@kernel.org>
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de, mingo@kernel.org,
 gustavoars@kernel.org, hch@lst.de, andreyknvl@gmail.com,
 ryabinin.a.a@gmail.com, ardb@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, nicolas.schier@linux.dev, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Thu, 17 Jul 2025 16:25:05 -0700 you wrote:
> v3:
>   - split up and drop __init vs inline patches that went via arch trees
>   - apply feedback about preferring __init to __always_inline
>   - incorporate Ritesh Harjani's patch for __init cleanups in powerpc
>   - wider build testing on older compilers
>  v2: https://lore.kernel.org/lkml/20250523043251.it.550-kees@kernel.org/
>  v1: https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/
> 
> [...]

Here is the summary with links:
  - [v3,01/13] stackleak: Rename STACKLEAK to KSTACK_ERASE
    (no matching commit)
  - [v3,02/13] stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
    (no matching commit)
  - [v3,03/13] stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
    (no matching commit)
  - [v3,04/13] x86: Handle KCOV __init vs inline mismatches
    (no matching commit)
  - [v3,05/13] arm: Handle KCOV __init vs inline mismatches
    (no matching commit)
  - [v3,06/13] arm64: Handle KCOV __init vs inline mismatches
    https://git.kernel.org/riscv/c/65c430906eff
  - [v3,07/13] s390: Handle KCOV __init vs inline mismatches
    https://git.kernel.org/riscv/c/c64d6be1a6f8
  - [v3,08/13] powerpc/mm/book3s64: Move kfence and debug_pagealloc related calls to __init section
    https://git.kernel.org/riscv/c/645d1b666498
  - [v3,09/13] mips: Handle KCOV __init vs inline mismatch
    https://git.kernel.org/riscv/c/d01daf9d95c9
  - [v3,10/13] init.h: Disable sanitizer coverage for __init and __head
    https://git.kernel.org/riscv/c/381a38ea53d2
  - [v3,11/13] kstack_erase: Support Clang stack depth tracking
    (no matching commit)
  - [v3,12/13] configs/hardening: Enable CONFIG_KSTACK_ERASE
    https://git.kernel.org/riscv/c/4c56d9f7e75e
  - [v3,13/13] configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON
    https://git.kernel.org/riscv/c/437641a72d0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



