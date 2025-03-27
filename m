Return-Path: <linux-kselftest+bounces-29852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56584A72933
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1774C189EDB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 03:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179C1DF74B;
	Thu, 27 Mar 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4aZQfYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C431DF724;
	Thu, 27 Mar 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045862; cv=none; b=ck1vJ3JoRuslkuSH7OQivv0N7o3VYJU656Uq7tghymQE4FMsPeZJ3CtNIaWUv1KtXvhOaqFEvMhy7iSo1X8qpKnUkLSMfPp4qMs6v/A7PgRPgrGR1+hDdrndbZ9pyWF/fdcTiYEq/CgqH10cAq936fFwLca3zJiQETdX/32hWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045862; c=relaxed/simple;
	bh=YtxfKvSWv2/a1oAlKoiwHfzUaB8Ez36lv4AOkIm9qzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mDP6G8qhaKEu9fai+N0XQJK6euybNmovmrOBDFXSIvZV4cxkA2opcJjhfM2j9Zjf5xPEgF/uNN3Dt9o/VOCcznr1eB1unqxZniNlInHjDdl3JjQafye6w9LemxV3Nq1iNayiDQ3t30ePIsk0Zf4STmIVOD04L/nRv8Xw+IroP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4aZQfYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B2DC4CEEA;
	Thu, 27 Mar 2025 03:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743045861;
	bh=YtxfKvSWv2/a1oAlKoiwHfzUaB8Ez36lv4AOkIm9qzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G4aZQfYorl84c7rtvXXeCrzOmQpcx1lxEh7LOWAGryMmz8GUzjWtlRlQg9+qKFbVT
	 rMQGjkH0KqeQ4vqQ07mPh7mnV1LSgNcttx92HBTwhFVKk0K/GrlqUB3qVs3RDQs1/r
	 JXpn4Azp+jgBwCUQkF3KEDnm7p/aZapz2rzytNqSpafGSCZwqHZa/zUJ8J/DVb7uLX
	 Cmz392YazAeoRLijed1VTQ/i6ssahkQ8RnsatM/9hab8/dP9CNDGVuvb8Sgi8BBcr0
	 jAO+0ALvyK8X8YV53DV2Drwr7DW/qtCY/buqAsIPhXXdRyT8SUvxa86b3hbx8pcrgv
	 QFrsc70/eal5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD1380AAFD;
	Thu, 27 Mar 2025 03:24:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/3] Enable Zicbom in usermode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174304589800.1549280.3544562224305376378.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 03:24:58 +0000
References: <20250226063206.71216-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250226063206.71216-1-cuiyunhui@bytedance.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
 alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
 charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com,
 conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, samuel.holland@sifive.com, shuah@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Wed, 26 Feb 2025 14:32:03 +0800 you wrote:
> v1/v2:
> There is only the first patch: RISC-V: Enable cbo.clean/flush in usermode,
> which mainly removes the enabling of cbo.inval in user mode.
> 
> v3:
> Add the functionality of Expose Zicbom and selftests for Zicbom.
> 
> [...]

Here is the summary with links:
  - [v7,1/3] RISC-V: Enable cbo.clean/flush in usermode
    https://git.kernel.org/riscv/c/de70b532f91b
  - [v7,2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
    https://git.kernel.org/riscv/c/eb1003970940
  - [v7,3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
    https://git.kernel.org/riscv/c/36dec9e44805

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



