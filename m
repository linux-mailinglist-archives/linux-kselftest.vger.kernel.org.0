Return-Path: <linux-kselftest+bounces-11250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65048FD08E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC30FB24A97
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D717BCA;
	Wed,  5 Jun 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpIQlPN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AD17559;
	Wed,  5 Jun 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596633; cv=none; b=g2F7e2kkTNjuKtegm5vhp8V5/CNd0lpsNgwSeuZL2PbJMwROMG9BliHpLDB3Z2bq2/EG4NPcHMSZbIVunlRDHoRwl2LbOPMrLjxZEl5dW1m5GPYW53JOzufbWE2UBCRVBwEnirowiX+oXwZOQTUEOOlrsuI2Saozex0P/uVliuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596633; c=relaxed/simple;
	bh=UAGR9QnDd/41AzrEWFL4+jkhr/ZCBaiQbiOH3HOBB/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpGcii4eM2oXBvTSJqqPXGmTxbh3Cl2/03l5ZC9q5I4A1ogu2VbDiEh8sZUZRvr7bwwNAFg0qMexj+b4K4tROge2byUDmoIJlBxEbHBdOnM86N6+g5/8UqtoXQNQ7p54osV5bpTi+cg+W9O+49Hf+B/85Rn3BeDTMaefpGBpiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpIQlPN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91976C32782;
	Wed,  5 Jun 2024 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717596632;
	bh=UAGR9QnDd/41AzrEWFL4+jkhr/ZCBaiQbiOH3HOBB/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MpIQlPN5wugTeCpN79pjIFioDuHkCQ3Uqo7ZKSzAu3HaBG2SaiuW9Ao6lw0IBK6tJ
	 qDK2SDXT47L2jstsG81CFjQqPy86xdJFmjc3xgtampCsL6dakhKSESYKuQdJX+Gc/j
	 ye+oZGcjBV0DYFJpdEfMe9zPcEFnuybYoNaJjwDNC2Z3UpEGNkGktNy2HBL+vfhwEi
	 PGollhc2ATqG6cnbf5UNhOg5uX4eudfknjQiExMzwhPk1iSeLHOPBZSDgB3s5/Whnu
	 yGEibjkfImlj1X6lKmpyWLXnZZBrEwsyXHHsDoh8BSyx7+AKRqoggPpp4yR3cU/cuw
	 WWls8/euaummA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 754F4D3E996;
	Wed,  5 Jun 2024 14:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/8] Support Zve32[xf] and Zve64[xfd] Vector
 subextensions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171759663247.19543.9794299623549255607.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 14:10:32 +0000
References: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
In-Reply-To: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 heiko@sntech.de, guoren@kernel.org, conor@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, evan@rivosinc.com,
 cleger@rivosinc.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 palmer@rivosinc.com, vincent.chen@sifive.com, greentime.hu@sifive.com,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cuiyunhui@bytedance.com,
 j.granados@samsung.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 10 May 2024 00:26:50 +0800 you wrote:
> The series composes of two parts. The first part Specifically,
> patch 1 adds a comment at a callsite of riscv_setup_vsize to clarify how
> vlenb is observed by the system. Patch 2 fixes the issue by failing the
> boot process of a secondary core if vlenb mismatches.
> 
> Here is the organization of the series:
>  - Patch 1, 2 provide a fix for mismatching vlen problem [1]. The
>    solution is to fail secondary cores if their vlenb is not the same as
>    the boot core.
>  - Patch 3 is a cleanup for introducing ZVE* Vector subextensions. It
>    gives the obsolete ISA parser the ability to expand ISA extensions for
>    sigle letter extensions.
>  - Patch 4, 5, 6 introduce Zve32x, Zve32f, Zve64x, Zve64f, Zve64d for isa
>    parsing and hwprobe, and document about it.
>  - Patch 7 makes has_vector() check against ZVE32X instead of V, so most
>    userspace Vector supports will be available for bare ZVE32X.
>  - Patch 8 updates the prctl test so that it runs on ZVE32X.
> 
> [...]

Here is the summary with links:
  - [v5,1/8] riscv: vector: add a comment when calling riscv_setup_vsize()
    https://git.kernel.org/riscv/c/77afe3e514b8
  - [v5,2/8] riscv: smp: fail booting up smp if inconsistent vlen is detected
    https://git.kernel.org/riscv/c/38a94c46660f
  - [v5,3/8] riscv: cpufeature: call match_isa_ext() for single-letter extensions
    https://git.kernel.org/riscv/c/98a5700dfaec
  - [v5,4/8] dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
    https://git.kernel.org/riscv/c/037df2966afc
  - [v5,5/8] riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
    https://git.kernel.org/riscv/c/1e7483542bf8
  - [v5,6/8] riscv: hwprobe: add zve Vector subextensions into hwprobe interface
    https://git.kernel.org/riscv/c/de8f8282a969
  - [v5,7/8] riscv: vector: adjust minimum Vector requirement to ZVE32X
    https://git.kernel.org/riscv/c/ac295b67422d
  - [v5,8/8] selftest: run vector prctl test for ZVE32X
    https://git.kernel.org/riscv/c/edc96a2b4c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



