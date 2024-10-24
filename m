Return-Path: <linux-kselftest+bounces-20568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F479AEF3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39E01F21107
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A5200111;
	Thu, 24 Oct 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/t23/5a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772B1FF7D1;
	Thu, 24 Oct 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793430; cv=none; b=U0LVRfZgp4ZyTsnOl6GIZqKsSc5Q1N7+H3vu5y+Dd3Be7MJBaSsOV8XB76AkA/5IPVDrxzQYX/5I2ViQgd5z/hzQfnrt+z9pT9tq8DFtgmODEOfgVQDtsDmMfUVrO1kLOgfmL4VAy35lcqMQhPOK/mugPIysotXwY675LyyORHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793430; c=relaxed/simple;
	bh=OqL6FsvcsJdLGD36/xtR504tOLGaOA7KNoONdtMbKik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JMTDsWrPJxH3S4B1lgx4u/3+eggObMotsFdkKHmFjk0xmlfNmpX+HaudEBK61CHeQllhnjuaPGQ8FzYPjXvb/0g07z00qy+Y0dIlpRoHGk2nCxELLljNlnMGgEHZTCDyQWjPGFB6fK7kBG2Xv6UFZDVMBlsgsux0SljiPXc0ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/t23/5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2BBC4CEE4;
	Thu, 24 Oct 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793429;
	bh=OqL6FsvcsJdLGD36/xtR504tOLGaOA7KNoONdtMbKik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/t23/5aQJk/UpUvlVmli0FE+oiCdC08hINCtLKz9be53DDMo9vz4mJBy+7Uu09xw
	 NZa8ElUC6A/JUn73uVbpGHBj0zd5G1rFQgwu5DUfTSODLwtQkTvjFojg6xXbczrpG0
	 XF0O3rO/R31eiqp3xsG2X7eMYbaExpvU0IsnBKZYcQRZEVFMozT7FGyiTfxkDDp/Tx
	 US0+IDURCfOh8XRVNygjqYaMDMOCMQD3M5ULjQqh+pk6SCf6D0Hiu/RAXmA99CD+F+
	 xZXp4V0hz0YbQS+we7+rLuiCtiRLrTqns4V8gmJXGuGyJUTNdItwMSpi3kjr3G7uw8
	 K/kGHgWxAw7Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE304380DBDC;
	Thu, 24 Oct 2024 18:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 0/4] A few fixes for RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979343650.2335128.10301613190246629595.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 18:10:36 +0000
References: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 akpm@linux-foundation.org, shuah@kernel.org, paul.walmsley@sifive.com,
 alex@ghiti.fr, charlie@rivosinc.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhang.lyra@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  8 Oct 2024 17:41:37 +0800 you wrote:
> These patches are all simple fixes with no strong dependency though,
> I hope that making them a patchset will be more convenient for merge.
> 
> The patchset are based on v6.12-rc2.
> 
> Chunyan Zhang (4):
>   riscv: Remove unused GENERATING_ASM_OFFSETS
>   riscv: Remove duplicated GET_RM
>   selftest/mm: Fix typo in virtual_address_range
>   selftests/mm: skip virtual_address_range tests on riscv
> 
> [...]

Here is the summary with links:
  - [V2,1/4] riscv: Remove unused GENERATING_ASM_OFFSETS
    https://git.kernel.org/riscv/c/cb873b28bc2a
  - [V2,2/4] riscv: Remove duplicated GET_RM
    https://git.kernel.org/riscv/c/4c6b61b5d35e
  - [V2,3/4] selftest/mm: Fix typo in virtual_address_range
    (no matching commit)
  - [V2,4/4] selftests/mm: skip virtual_address_range tests on riscv
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



