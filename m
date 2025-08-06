Return-Path: <linux-kselftest+bounces-38397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC73B1CA7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 19:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC76017B9A4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD812BEC2B;
	Wed,  6 Aug 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU0qYDom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DC2BE7AF;
	Wed,  6 Aug 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500538; cv=none; b=GeAcJPyIvO49vZyKmu4v5yycjo6nTOgQyJzoXZCAmdsffgRtcVsD77lmwnWQ8x6CbQO9cY/Uk7eHJkEBE2wGTTdCZ2JxJ4mDFBjpwaTRgHnT8Kt16YeM0fFfzyJNGO1a2XM0zO1l2M9l4Ml/WC36KKXGOsZga/MN+lP9bR2XcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500538; c=relaxed/simple;
	bh=FPoVB0luhGfr8VKdsLri9XQZP3N4vDq2w8LU1u6LXNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MQdt4XXXFmdQ5N3YHVjARIGITNoAtNPQMptpe1gwLQRxTyeOollIK2jgJbRYbaHTiPWq7JFqxZM0FvT9Nymh3ksUeEvJdO7iZTK/R4Bc+skt+Or2uaizU0losY65zv6apUwf1dKIDYdMOj1Utml0qMQJSLbc2LoxZbvR2jy+6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU0qYDom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61418C4CEE7;
	Wed,  6 Aug 2025 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500538;
	bh=FPoVB0luhGfr8VKdsLri9XQZP3N4vDq2w8LU1u6LXNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nU0qYDomgCEqLecBnU6y/6JYF3o+P9LYhK81l0Bz+eK0Vuutbwm7DhbRsD+j7ZiYM
	 i8Mps8BULf3Pi9AHuTpABndJJ7z3R5CwOxoqHkj5TWn0yaMgtH7EiMGXOnuDu0Hp2L
	 J/Qp9nLzQSwQR2JOevAy4zAGUZjZ/0OFhWeQuEFtnGPIzywqyUHFa3RfUtxFufDTW4
	 ai4Yp1XK9LMRlw90BbbLI/uuxsT2rVtXpRQj5RVlv3+Njxsb68d3BbiLJtsD+PZS72
	 /oU2t67t/2/AjgcBe/yKP4v5f9xUXQz7w1nXBxWtfTkLa+J/fm0WXFARoqXzAPEgCH
	 G85ztmKqq6V4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB4383BF63;
	Wed,  6 Aug 2025 17:15:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] selftests: riscv: add misaligned access testing
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450055200.2863135.7169449906797738792.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:52 +0000
References: <20250711131925.112485-1-cleger@rivosinc.com>
In-Reply-To: <20250711131925.112485-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, shuah@kernel.org, alex@ghiti.fr, schwab@suse.de

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Fri, 11 Jul 2025 13:19:24 +0000 you wrote:
> This selftest tests all the currently emulated instructions (except for
> the RV32 compressed ones which are left as a future exercise for a RV32
> user). For the FPU instructions, all the FPU registers are tested.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> 
> [...]

Here is the summary with links:
  - [v5] selftests: riscv: add misaligned access testing
    https://git.kernel.org/riscv/c/bf6594367a92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



