Return-Path: <linux-kselftest+bounces-31-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF77E8DBD
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 01:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889071F20F55
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51917EA;
	Sun, 12 Nov 2023 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgpBSE+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8F15D1;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E392C433CC;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699750546;
	bh=BudbliKklZT1nMXLsYFQyB+Pk18EUouJG6KZUqc8uyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qgpBSE+z2PM5zIUQ4ZiQ42U4qfNh/mK+G0UjLlwezYzovO7Hv0r3U4c2k0cyQdJYu
	 2tpvqEdQc/11Ql3RizpG4raIDOskXMIAUvBKTtjTHuZBVqO64Ai4BwQvtxiuGP7GE0
	 CQmDP5c7hXu//cf4WJPIWVVxlHFlXjFtikp2paYREnbtSZEzC4aaPYEiSS3SYENmbA
	 8Um9rkkzACTUm8CXhr7u/rIYQ204eiVoJlZZJPnezsmOLIDxlNAQc1kpIVDVmquMV2
	 HIxQgf86TrDBy4GYf8wHAQCmg3P0oq4N21BCiACjV24ts57a55XSwDkPCJQzoigyop
	 H7y/eALJS/dlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CE26E0008B;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/6] KVM RISC-V Conditional Operations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169975054631.11360.10958982747975281844.git-patchwork-notify@kernel.org>
Date: Sun, 12 Nov 2023 00:55:46 +0000
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com,
 atishp@atishpatra.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 conor@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 shuah@kernel.org, ajones@ventanamicro.com, mchitale@ventanamicro.com,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue,  3 Oct 2023 09:22:20 +0530 you wrote:
> This series extends KVM RISC-V to allow Guest/VM discover and use
> conditional operations related ISA extensions (namely XVentanaCondOps
> and Zicond).
> 
> To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops_v1
> branch at: https://github.com/avpatel/kvmtool.git
> 
> [...]

Here is the summary with links:
  - [v3,1/6] dt-bindings: riscv: Add Zicond extension entry
    https://git.kernel.org/riscv/c/00c6f39c8247
  - [v3,2/6] RISC-V: Detect Zicond from ISA string
    https://git.kernel.org/riscv/c/662a601aa355
  - [v3,3/6] RISC-V: KVM: Allow Zicond extension for Guest/VM
    https://git.kernel.org/riscv/c/df68f4d8cb49
  - [v3,4/6] KVM: riscv: selftests: Add senvcfg register to get-reg-list test
    https://git.kernel.org/riscv/c/4d554e0226e6
  - [v3,5/6] KVM: riscv: selftests: Add smstateen registers to get-reg-list test
    https://git.kernel.org/riscv/c/e1a8db0c9a0e
  - [v3,6/6] KVM: riscv: selftests: Add condops extensions to get-reg-list test
    https://git.kernel.org/riscv/c/2b3f2b78ec93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



