Return-Path: <linux-kselftest+bounces-10596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BD8CC9E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C286B21A65
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B814C5BF;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/Re7Mcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92B7F7D3;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=fQppHZIhdS8YgGtF0AwR5XcB/fdnd3RbcBzxShMRB3NJqpfyqrRZwntFQ8s9l5mlkb4L17EUuJmycpFFYyTbyNkV91vCOpTFBvINUN8gkd2vpYch+WbjG3ojhkQXPMPO8t9/eg3yb67mJWebrt/rkU0mHSNriK1mrPJ8Rt6z+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=twsR8G5WscdioqUmw9Xs22RKtQ4/tW93gBPGJtFfYeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B7xNrXmE/LGDSJuF58FgcX2//wLOwg2VSyl0EaOTJ0Cs8eApY0FVg6EaNKbxxk7APPeet5wxXp+hfSynLEFL4by/kMUYVW6h2K9h6TcRBUgrUARWYPdgil3q54kdlNlFJdAuvIYx5Zzp2LKX23HaocOXcZVDLZCNH8TX0D4D09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/Re7Mcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E10EC32781;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=twsR8G5WscdioqUmw9Xs22RKtQ4/tW93gBPGJtFfYeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/Re7Mcmf44ueE641qccxRstYMzUWUuLPF6G6uAihMTBn8k6uC8HXzNMOeVTxJLXr
	 57ZSUx8tMD8oL8OH5yaO6fWkLlCcpyMg2J7h05jZF+MxFQZV4F8oV8YOVOiwcqi2Cx
	 uq64ewRhX5oZg/Ac4FdduTh/SBcSFf14lQD4fvtaKfUNd+bUXaAUKEtLGdHzTPbmBX
	 D85/yR8ZD9I5FEUrSlbknVz2BOR55UBRr+Q6BG+lcT6TFNMS7MGCVHyuObyBujs0ru
	 BlFA/LVO0xgFBIdNQy//4zTL6s13+BKA/Fqs2j+9P86nFc5baicTdBiiqKgTWUQNzh
	 MDiSasTEpCBcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 790BDC4361A;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: selftests: Add hwprobe binaries to .gitignore
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190748.9409.11788212835891535911.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
In-Reply-To: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ajones@ventanamicro.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 25 Apr 2024 12:58:03 -0700 you wrote:
> The cbo and which-cpu hwprobe selftests leave their artifacts in the
> kernel tree and end up being tracked by git. Add the binaries to the
> hwprobe selftest .gitignore so this no longer happens.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
> Fixes: ef7d6abb2cf5 ("RISC-V: selftests: Add which-cpus hwprobe test")
> 
> [...]

Here is the summary with links:
  - riscv: selftests: Add hwprobe binaries to .gitignore
    https://git.kernel.org/riscv/c/b1f4ad94cd12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



