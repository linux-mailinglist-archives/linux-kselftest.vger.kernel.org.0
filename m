Return-Path: <linux-kselftest+bounces-20564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C642D9AEEA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FE2B23A1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C760200132;
	Thu, 24 Oct 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFqqJqdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8C200109;
	Thu, 24 Oct 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792233; cv=none; b=R0s9LqCgwR3DDr3C8h1PmnioaModIjxPwuR6uxiq3Bxzx55BcKduUNKejPpCtopv7cKYwnmuCfq0pKWUiBCkhM+cILtiTfEqKOVaZPvOSx2T6G2cgjGIRJsjX/ceB0zrn9PA2W/uxoTx5k9GhMdNL9zuwCCs8AFtn2MDIUdAnnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792233; c=relaxed/simple;
	bh=bGnHyVsk1+n+xRwZo4AwVhT1cavRFamOy1xjbAurCyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwTYTAckG3LbBtSjTEQ4r0Gu9ioDtMp/jNxlqvNxvwSsg9/6qpDTQug7HgBnP+1cstX26EsQ3/woYS7CKWQGgdisHrtHBCaa98BH2Ht9rg58s9KSOmZntoACY98Z9XTi4/8jdAUFtqm4yVZguA9qArcz6iTqzi/n9+C+vTDrOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFqqJqdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B83C4CEE4;
	Thu, 24 Oct 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792233;
	bh=bGnHyVsk1+n+xRwZo4AwVhT1cavRFamOy1xjbAurCyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jFqqJqdI2EoUpRNGF4/UnbxGPxPIGZGl2IUDtZTQV0rId7fpZBmOt9+Hx4ThB/o+o
	 zjTks197XXuPfCWg4ygJcXbMjuR8AbK9vzxgZi0o7pW2Urwj0Td1q/gBKJu2GWJMwb
	 mVW44st6/rUID0wZKp4FGGCQ5Zx9R0Tk7WZ7x8tYbcl1ka/XAn29AD8ixs2mwk4eb8
	 dP3fYleir0Z/XJiPZnTxCuQyghmiD4A41eQ7RRQaT500MFoiLIIQykRKve06pFugw6
	 aVADzWPj2wrF+8jYFEUQbfPtr0//N4yZqsXl2mw6zu7uEgZ0/0QA+yWe1Rb98c8gWD
	 VzmVaNo/XhrPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF38380DBDC;
	Thu, 24 Oct 2024 17:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/10] riscv: Userspace pointer masking and tagged address
 ABI
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979223949.2327357.12698642185375267636.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 17:50:39 +0000
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 catalin.marinas@arm.com, atishp@atishpatra.org,
 linux-kselftest@vger.kernel.org, robh+dt@kernel.org,
 kirill.shutemov@linux.intel.com, shuah@kernel.org,
 devicetree@vger.kernel.org, anup@brainfault.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, kvm-riscv@lists.infradead.org,
 conor@kernel.org, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 eugenis@google.com, charlie@rivosinc.com, krzysztof.kozlowski+dt@linaro.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 16 Oct 2024 13:27:41 -0700 you wrote:
> RISC-V defines three extensions for pointer masking[1]:
>  - Smmpm: configured in M-mode, affects M-mode
>  - Smnpm: configured in M-mode, affects the next lower mode (S or U-mode)
>  - Ssnpm: configured in S-mode, affects the next lower mode (VS, VU, or U-mode)
> 
> This series adds support for configuring Smnpm or Ssnpm (depending on
> which privilege mode the kernel is running in) to allow pointer masking
> in userspace (VU or U-mode), extending the PR_SET_TAGGED_ADDR_CTRL API
> from arm64. Unlike arm64 TBI, userspace pointer masking is not enabled
> by default on RISC-V. Additionally, the tag width (referred to as PMLEN)
> is variable, so userspace needs to ask the kernel for a specific tag
> width, which is interpreted as a lower bound on the number of tag bits.
> 
> [...]

Here is the summary with links:
  - [v5,01/10] dt-bindings: riscv: Add pointer masking ISA extensions
    https://git.kernel.org/riscv/c/8946ad26c0e2
  - [v5,02/10] riscv: Add ISA extension parsing for pointer masking
    https://git.kernel.org/riscv/c/12749546293e
  - [v5,03/10] riscv: Add CSR definitions for pointer masking
    https://git.kernel.org/riscv/c/1edd6226877b
  - [v5,04/10] riscv: Add support for userspace pointer masking
    https://git.kernel.org/riscv/c/871aba681a0d
  - [v5,05/10] riscv: Add support for the tagged address ABI
    https://git.kernel.org/riscv/c/c4d16116bd11
  - [v5,06/10] riscv: Allow ptrace control of the tagged address ABI
    https://git.kernel.org/riscv/c/cebce87fb04e
  - [v5,07/10] riscv: selftests: Add a pointer masking test
    https://git.kernel.org/riscv/c/5e9f1ee1c523
  - [v5,08/10] riscv: hwprobe: Export the Supm ISA extension
    https://git.kernel.org/riscv/c/d250050aae4f
  - [v5,09/10] RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
    https://git.kernel.org/riscv/c/e27f468bcf14
  - [v5,10/10] KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test
    https://git.kernel.org/riscv/c/814779461d84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



