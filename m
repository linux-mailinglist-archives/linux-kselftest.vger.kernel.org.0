Return-Path: <linux-kselftest+bounces-45976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7AC6E87D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22D54F0F47
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABA35B13E;
	Wed, 19 Nov 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTR4tjqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651635B13D;
	Wed, 19 Nov 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555448; cv=none; b=cK+CEFklceSpwQ7Y6HcOhsFH0RBYohtqbNCarCv7zeajTOF27jTqyGj3nuUNRm12wdMusMJ7bx0+/l35WngRzgQhAG8BAQmcypg608LM0m1Q7Kef34ZFCAl/LBzbWrq6U6oNR1HCSCeYh/7xt1uBbBIkvWJOpgi6lfltrrlRxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555448; c=relaxed/simple;
	bh=iq0aV4T0WOF/GPJMcgiZ3VSc1pc95Da3JcgV1XIC52s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lhg5ollR+dJmiLeU5mlqrswMTS9vKWTRHqtmqir8uke7/fBTt0jd6grPVdnfgmCFz5vtPbBG9WXFhV4SClYDEQ0FGWZ4Vip3HJn4LicRFN2dHEgopuP+M3+E93/NGycNcMwyuR627WLTvYNMNRNqbYQB1NhUGy3vfBVknXjaFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTR4tjqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F5C2BC87;
	Wed, 19 Nov 2025 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763555448;
	bh=iq0aV4T0WOF/GPJMcgiZ3VSc1pc95Da3JcgV1XIC52s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cTR4tjqKmovQNZkhiVH1FAAPSplCdmELsgvip0m3tByybYUT+MQuKC46su0r+Ha6C
	 MJBaX5Ee/m3MTJw/rsKlbOTYJvkWV5icGJGMgVWujVgLORwBO9t2M8iLzByyE/YK/N
	 u9aKcYvrByLMeGaDmBeuCxwbbD6KDsxGj2xjCpdF4UgSv9IM+waZFVeALsVbXX3K88
	 MVJ8FcaEDVlxJEWZax49/gBUF5QYxUYD9J5sLoZb+3Y/x0BgjwqxVSp/B4BfkJRroB
	 e2eYirnwVYleh93YD9j6xB6haWoaGfntyNsJmva+9nTBKgUAxkuoF/ubocq2RXA0GX
	 v+0HfL+MhWODQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE35380AA40;
	Wed, 19 Nov 2025 12:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Optimize the allocation of vector regset
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176355541326.758643.4317027962321955415.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 12:30:13 +0000
References: <20251013091318.467864-1-yongxuan.wang@sifive.com>
In-Reply-To: <20251013091318.467864-1-yongxuan.wang@sifive.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, andybnac@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Mon, 13 Oct 2025 17:12:30 +0800 you wrote:
> The vector regset uses the maximum possible vlenb 8192 to allocate a
> 2^18 bytes buffer to copy the vector register. But most platforms
> don’t support the largest vlenb.
> 
> The regset has 2 users, ptrace syscall and coredump. When handling the
> PTRACE_GETREGSET requests from ptrace syscall, Linux will prepare a
> kernel buffer which size is min(user buffer size, limit). A malicious
> user process might overwhelm a memory-constrainted system when the
> buffer limit is very large. The coredump uses regset_get_alloc() to
> get the context of vector register. But this API allocates buffer
> before checking whether the target process uses vector extension, this
> wastes time to prepare a large memory buffer.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: ptrace: Optimize the allocation of vector regset
    https://git.kernel.org/riscv/c/f8e257e4d549
  - [v2,2/2] selftests: riscv: Add test for the Vector ptrace interface
    https://git.kernel.org/riscv/c/92678c40038b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



