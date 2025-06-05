Return-Path: <linux-kselftest+bounces-34351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DFACE7C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 03:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A49189240F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F854AEE2;
	Thu,  5 Jun 2025 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAUmGJwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B33209;
	Thu,  5 Jun 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749087000; cv=none; b=U44KKZyTJldJSJWuvuIAcvNyAo7hgOCgSP69G1xGAgzCkO1Wm4ggBSUqK/FispDpSLUON/KMrbS3GfpPK7wNn4AHAT+JnApGxwy1EQCR5KmGb3FS6QtsQ4VUbraluKlNYIvO9pLG7/CGThgprZjlOO125c++fQbojFIdORljQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749087000; c=relaxed/simple;
	bh=oBRR0U72ZWaszWIIDxHCBlFYwKXTGXUi/Puz8CELYE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yk2ZmRtZQgWzPca1tC8Sl4RxmvrRv2mvDr9waRxnYugeZiL6fYj5Q2CQu4QRcd43cqbPUolkCcJpVau53U3XulE4kocG0hVuFXCfqSKkPURnTNpkLHaxwNh5ct3muB7LtYYEDQe6Y2AI1aL7uU7FtdYK3i7cO6cGwYbHC+I1ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAUmGJwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6C4C4CEE4;
	Thu,  5 Jun 2025 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749086999;
	bh=oBRR0U72ZWaszWIIDxHCBlFYwKXTGXUi/Puz8CELYE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WAUmGJwHqQPtGkL6BxJp/lZ6BFMHW2rR5SSx1vKYpiYv35GufWZAXhYdfIoADeXjD
	 CGOegwiqaNxX4DBQ9Bed4vlObt4tMM8L1BRG7/4YtwTRMVRfPYTel1RiWIRdJKDoTJ
	 ko1zekAV8LuRiArTZETLi/h9pc9sHbqAH7eIiAEaCJK4ktXv40J3H/oZgA4Q73MiJe
	 7PzT1m/d6yNJ7nJCPQothhNEI48BHa3hfwg2axJaIl0spw9Hmt9/Go1fykE+2FK3WT
	 GtkfoEyQwDCfXvvJlEVD8DBOLQe0svrAJuPGs0J7ngslXyAQeHTaGdhcNkbvNVGaex
	 AXAJbqSuAGr6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC338111E5;
	Thu,  5 Jun 2025 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/14] riscv: add SBI FWFT misaligned exception
 delegation
 support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174908703175.2529829.13116744092084054612.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 01:30:31 +0000
References: <20250523101932.1594077-1-cleger@rivosinc.com>
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org,
 shuah@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 samuel.holland@sifive.com, ajones@ventanamicro.com, debug@rivosinc.com,
 charlie@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Fri, 23 May 2025 12:19:17 +0200 you wrote:
> The SBI Firmware Feature extension allows the S-mode to request some
> specific features (either hardware or software) to be enabled. This
> series uses this extension to request misaligned access exception
> delegation to S-mode in order to let the kernel handle it. It also adds
> support for the KVM FWFT SBI extension based on the misaligned access
> handling infrastructure.
> 
> [...]

Here is the summary with links:
  - [v8,01/14] riscv: sbi: add Firmware Feature (FWFT) SBI extensions definitions
    https://git.kernel.org/riscv/c/cf8651f7319d
  - [v8,02/14] riscv: sbi: remove useless parenthesis
    https://git.kernel.org/riscv/c/a7cd450f0e06
  - [v8,03/14] riscv: sbi: add new SBI error mappings
    https://git.kernel.org/riscv/c/99cf5b7c7387
  - [v8,04/14] riscv: sbi: add FWFT extension interface
    https://git.kernel.org/riscv/c/6d6d0641dcfa
  - [v8,05/14] riscv: sbi: add SBI FWFT extension calls
    https://git.kernel.org/riscv/c/c4a50db1e173
  - [v8,06/14] riscv: misaligned: request misaligned exception from SBI
    https://git.kernel.org/riscv/c/cf5a8abc6560
  - [v8,07/14] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
    https://git.kernel.org/riscv/c/9f9f6fdd1dc6
  - [v8,08/14] riscv: misaligned: declare misaligned_access_speed under CONFIG_RISCV_MISALIGNED
    https://git.kernel.org/riscv/c/1317045a7d6f
  - [v8,09/14] riscv: misaligned: move emulated access uniformity check in a function
    https://git.kernel.org/riscv/c/4eaaa65e3012
  - [v8,10/14] riscv: misaligned: add a function to check misalign trap delegability
    https://git.kernel.org/riscv/c/7977448bf374
  - [v8,11/14] RISC-V: KVM: add SBI extension init()/deinit() functions
    (no matching commit)
  - [v8,12/14] RISC-V: KVM: add SBI extension reset callback
    (no matching commit)
  - [v8,13/14] RISC-V: KVM: add support for FWFT SBI extension
    (no matching commit)
  - [v8,14/14] RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



