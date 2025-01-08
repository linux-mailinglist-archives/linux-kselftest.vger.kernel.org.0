Return-Path: <linux-kselftest+bounces-24073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E85A0643A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 19:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA95E1679B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C51F8F0A;
	Wed,  8 Jan 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMLPCBxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CB15853B;
	Wed,  8 Jan 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360446; cv=none; b=Eey/ShrFByL4kQR3R8zl2u0v/1iDZV5CotJFWgoaSMNw5ttjVm/4h2s4K6DLp20l2UCa6Dal01qKUu9bupybper+Rc1rTSp4oTCpn0v/eVhes/H3jKDUT4cBotiuh/Gf4wpBOsCkq/tGPLYLt/IUslcKL1UtgYTxVTOnQKujTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360446; c=relaxed/simple;
	bh=q6+aG3vfylT8FjOjczPsjWU9/3/Zl6eXZowl2wc5e70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOsm/Hw/DqHWkIS8q1MVNM4WoFmtOgi1QkGYXIJktkwtO+aQ3ReXPILDBAkFwthsDaVFLP65tplPIEDsNqP8yFbEdpMebDiUsVVERS1ERYjXEPhKbQ6AoO5H+vOVBp2r31oNSsfIiAhG09f7DqSRBcyhojA+K98UWAtqSmrX2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMLPCBxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD61C4CED3;
	Wed,  8 Jan 2025 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736360446;
	bh=q6+aG3vfylT8FjOjczPsjWU9/3/Zl6eXZowl2wc5e70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WMLPCBxVq2PB87kBc4QyF2TX7pldv+33KbA7HOLURDyJ9VZJonDyqAN+79PSTPmqS
	 CXWX+8zx3dsMzcz3QECPZIEh+oQI9FCvcdvr6fZdBJcj2K+zKjBEEZyVleVvrls/cW
	 f9qFLSHRonp6VwSIeulTIlIqLqRxRJ7R0jqb6OOVBl+BOaO39akAiUCYfjAe/gDPif
	 rI24RAPvQT1g8U9Lqqrtn55PUvTmHBYK4TyPMLYBJQxaD9S5aeRPzZmkWvFjrcJv93
	 Xz6jCUo/VGRKcFCA62HBaZ15Wn+K1FjUIBRz7H+QuAS+ZmB+tlnDzJvE8a+O0Wj5fW
	 V6eCEsxd9z4Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB39D380A965;
	Wed,  8 Jan 2025 18:21:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] riscv: selftests: Fix warnings pointer masking test
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173636046749.736486.2528657694526835016.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 18:21:07 +0000
References: <20241211-fix_warnings_pointer_masking_tests-v6-1-c7ae708fbd2f@rivosinc.com>
In-Reply-To: <20241211-fix_warnings_pointer_masking_tests-v6-1-c7ae708fbd2f@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, samuel.holland@sifive.com,
 ajones@ventanamicro.com, alex@ghiti.fr, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, palmer@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 11 Dec 2024 23:01:43 -0800 you wrote:
> When compiling the pointer masking tests with -Wall this warning
> is present:
> 
> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   203 |         pwrite(fd, &value, 1, 0); |
>       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> ignoring return value of ‘pwrite’ declared with attribute
> ‘warn_unused_result’ [-Wunused-result]
>   208 |         pwrite(fd, &value, 1, 0);
> 
> [...]

Here is the summary with links:
  - [v6] riscv: selftests: Fix warnings pointer masking test
    https://git.kernel.org/riscv/c/498d5b14db8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



