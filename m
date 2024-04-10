Return-Path: <linux-kselftest+bounces-7567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7189F9C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D62B289BE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3B15F311;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6qW9O7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0915EFC7;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758833; cv=none; b=RwkWwtc1enitIETdl9S/ynoDk5nQZAJs/JKpqizYopLxD/QV5JUONEWpMIxZTPAaHhucqqJXCfCFlCruxSSevpWnWIhHb+lvVDPsfg1iYL/ksBJrEOZmlEeRISHxwT8cqf47SvuAGwbrxJTQuuYLLlqGrBe4bhck/6M2mZjpkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758833; c=relaxed/simple;
	bh=4Kz3l5iBTcMk71coylVCtzT5pq2n7AmkPTmE+6qrX0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dsVALtPVZQi7v2ZYgeU+j0MJvDaiXHWJnkTFWRrGwo01r1N9q0GAYGDUjHZqfENmJ5eob4lIdI0K3AL5qtg/oGaPiax1rKkLnW2XXWORr9kTZzke/e92dOJZsNepOGZUU55Gq4GGffB+W7f7iVeP44BGgF42GMkMy8oQfx19/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6qW9O7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73D93C43399;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758833;
	bh=4Kz3l5iBTcMk71coylVCtzT5pq2n7AmkPTmE+6qrX0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B6qW9O7swP1wL84j3tLl3/lG+g8s/TCOA3SmRdcgQUwOvWQWxz5khRwK/tuIWnnjr
	 jH1eIOvAhhTzYmC4BTtxd2G89aiJd6ZoI/MVIFR2U9qSposi/TCbEWiDqOG75y38OW
	 FeNh/I4NybWZfbuC3Rtae438WkNoD59lJn67idghpWQZsj2G4sXghad1EHZpMmgBo+
	 VDTeNGg+tJecTiOkThtU5PXxmg9YWprKhCeyn5tLI6JX9AsaY7PbkTwHguohOLt5hM
	 YCIPficYT31yX65nnmtisdLu4ke3e47RiYqQuVzd5OXMmHkug7a8UNa2ba80V6pyBw
	 3lu3dSC9a5OrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 675D6CF21C7;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: sud_test: return correct emulated syscall value
 on RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275883341.18495.6912537160519241189.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:20:33 +0000
References: <20231206134438.473166-1-cleger@rivosinc.com>
In-Reply-To: <20231206134438.473166-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de, shuah@kernel.org,
 krisman@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, palmer@rivosinc.com, bjorn@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  6 Dec 2023 14:44:37 +0100 you wrote:
> Currently, the sud_test expects the emulated syscall to return the
> emulated syscall number. This assumption only works on architectures
> were the syscall calling convention use the same register for syscall
> number/syscall return value. This is not the case for RISC-V and thus
> the return value must be also emulated using the provided ucontext.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftests: sud_test: return correct emulated syscall value on RISC-V
    https://git.kernel.org/riscv/c/bac292e849d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



