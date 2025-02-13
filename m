Return-Path: <linux-kselftest+bounces-26581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78BA34DC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ABD3AC57B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9A24BC12;
	Thu, 13 Feb 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3Dmp82e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4F24BC04;
	Thu, 13 Feb 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471416; cv=none; b=qtdJQ1kCJkHkaYMgdKUGRifywiiw27Cpm4CIRikU+VjasHCpawaKQorfyBTvmS6zmOJGIEJmaMxCuLqsfZnOA0lo1rDOBdyhTzSEnlONiKgJtfFD0Q6ga9sr5bX+l3qSejmaUZ+/bNLb6MYoj3wLw9SOVq/IzLTQBxGh90osCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471416; c=relaxed/simple;
	bh=ON39bWBP6obgADqKbPUp+DFPNKslG1W5VOxKxDu0CxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rc17WWeaj8kb/zT/10pCPtN43HiCHUX00VIBVWYJSvSPK5hn85q0ZRASEV9fa/1nuA+oLc2fMl+pgrJR3GqcWYRQabaki+MnLQNGoz/++6xRd7UOiuz7TZdehpaCVoDJmys0Awh8rZ8xA0a5LyJJAtC64enlcgHlTTtvlMwUbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3Dmp82e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFB4C4CED1;
	Thu, 13 Feb 2025 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471415;
	bh=ON39bWBP6obgADqKbPUp+DFPNKslG1W5VOxKxDu0CxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q3Dmp82eDjCPua4n+tQAopIgyrBsAYio4ilKnXlDlYdi4+tOiajZ2JxlZMAyfReul
	 qPd8/ovRKwZFmg+oA0DJUp2DvbQX4uyW042cxkTcBfE4/EKXtdEmtxX+ekMmV4x+0v
	 pIzzjGqmQXDD3Ls/sW+lWbZX37ADrOCM3yYqGuY7YLL9fXP3D6seZR9Xy5mS6zs+7O
	 8f6Yxgu4H0UBxFpbPTRVlbgeqG0ng5aE8lSGymDJi9Uz0wqC0e5uiYF2VhlWTtAv94
	 xSX1njbd6pTuGvT9ikmw/E0HKvNA9fI1h/LgTQPuRYG+Ct0dcmDs7flbJCrHmOXPU7
	 o0G+Of6bZ9QeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FEA380CEEF;
	Thu, 13 Feb 2025 18:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] rseq/selftests: Fix riscv rseq_offset_deref_addv inline
 asm
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947144478.1330575.14473914966753905352.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:44 +0000
References: <20250114170721.3613280-1-shorne@gmail.com>
In-Reply-To: <20250114170721.3613280-1-shorne@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 charlie@rivosinc.com, mathieu.desnoyers@efficios.com,
 skhan@linuxfoundation.org, peterz@infradead.org, paulmck@kernel.org,
 boqun.feng@gmail.com, shuah@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 14 Jan 2025 17:07:21 +0000 you wrote:
> When working on OpenRISC support for restartable sequences I noticed
> and fixed these two issues with the riscv support bits.
> 
>  1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
>    passed to the macro.  Fix this by adding 'inc' to the list of macro
>    arguments.
>  2 The inline asm input constraints for 'inc' and 'off' use "er",  The
>    riscv gcc port does not have an "e" constraint, this looks to be
>    copied from the x86 port.  Fix this by just using an "r" constraint.
> 
> [...]

Here is the summary with links:
  - [v2] rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm
    https://git.kernel.org/riscv/c/b6059e2adc1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



