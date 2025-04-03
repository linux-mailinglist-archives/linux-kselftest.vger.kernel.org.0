Return-Path: <linux-kselftest+bounces-30072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD36A7A7C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0F1891AB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F979251795;
	Thu,  3 Apr 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciE/kNK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2F25178D;
	Thu,  3 Apr 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697201; cv=none; b=AH+EROHW/fwzvuOmnQJNKFLKHjAUN6qofIARQIhsa8i6QCjybwq1584FQYBHv9Ag39fCdvMfmArU2UfH249qJG1DQO4NtfGGALNn6hzkogqy6xi3FQHkrinBvmj5/droNj2t2q4eb4Viv01PP3279ZdDxkBkcpSY3nYWNmESOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697201; c=relaxed/simple;
	bh=j/Zw1Us83CYLMh45YX1P1HpPGlpHRPs3sHFliCIKkXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KtiZPA+BTkHD7b8TzVOD80SU66nXcYYh+zkhwIGXS5qL5VI0EVoAfis+vQpa54hMtpYtBECI82EiUYNOu645cy3zfZG/x+E2jpNLWSWSk2vZmZz/S/YtmQIAcGwaKST6RQ1d7t7RXMBU5N+OpUuXGnXLxr34wdPxA1SAS5dGSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciE/kNK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CA2C4CEEB;
	Thu,  3 Apr 2025 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697200;
	bh=j/Zw1Us83CYLMh45YX1P1HpPGlpHRPs3sHFliCIKkXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ciE/kNK4XWjcVK1j+oCSiVf1OBJ9HzSBIf2Hk9xjTMiNznLTc5BnwMm5nMhSB3eeM
	 dvyTPj8chqr/oWJMadaBcEpwFj2HjJu6jf5jEzS5vAQCW5bVJbYvW7HtvK6QbCEI4S
	 odc4NG9Z0XyXmPgWNWRCa9gWjL2rbXGlGL15S/JFErhUPRxyxHQokqhIljMFn51qAf
	 n9pCsOp2+89eiORD45yciDJmHcLzWB2hTqBjL0a3rbmoE16C/0JEZwPFrwJ/ZhiBLA
	 hlGlkFqB2rrBLDs4EYfqzfUKbpIH8zinEC87Nuk+MklnNxSMCMYwjXvoOHmNeVA6x0
	 f4UolNqzcRc9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB361380664C;
	Thu,  3 Apr 2025 16:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: riscv: fix v_exec_initval_nolibc.c
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174369723749.2563936.8850444880196164283.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 16:20:37 +0000
References: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
In-Reply-To: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 alex@ghiti.fr, charlie@rivosinc.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Thu, 06 Mar 2025 20:49:27 +0100 you wrote:
> Vector registers are zero initialized by the kernel. Stop accepting
> "all ones" as a clean value.
> 
> Note that this was not working as expected given that
> 	value == 0xff
> can be assumed to be always false by the compiler as value's range is
> [-128, 127]. Both GCC (-Wtype-limits) and clang
> (-Wtautological-constant-out-of-range-compare) warn about this.
> 
> [...]

Here is the summary with links:
  - [v2] selftests: riscv: fix v_exec_initval_nolibc.c
    https://git.kernel.org/riscv/c/79ba5c1c7767

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



