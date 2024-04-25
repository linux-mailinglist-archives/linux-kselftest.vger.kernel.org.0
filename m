Return-Path: <linux-kselftest+bounces-8895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F438B2D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BBA1F21D98
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 23:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367015624D;
	Thu, 25 Apr 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNd/HjNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC9155A5B;
	Thu, 25 Apr 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086032; cv=none; b=Qvvd7sPNubpmqmDPypMTdGeXwnJHN/f12iW2UA/1DQ3w8kQ5dTD6YdqlGpd2v4WyNq+EdgoPOOa1xtOmyO+QinFnPLC4Xjbo6t/ewzuOnWJdcbLwMeSla+wBmU5Y0zORKAm/fHbflE+TBwK64KvSLq3yq8BAkY9WxUUyLBeEA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086032; c=relaxed/simple;
	bh=D8k06gnsNVMRGTY9SPsw6z9e/n7ev10N005gew8GPJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHbX5u7XLRwRCdjXja3NzGZrza1p2BpAUbOMJsF6F8FdqE6RlZd2DbnYo1q06vz+XuixUHMczcF2TVYrmJW+qTp6bYXlhRX40UARAxQT6wgVm9nLKO8qoQMPE3NjqlZpf0kS6uzYC0I2zkbb9UPHmYKOKPFUfPrTPo20n74EwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNd/HjNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCDD7C2BD11;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714086031;
	bh=D8k06gnsNVMRGTY9SPsw6z9e/n7ev10N005gew8GPJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNd/HjNR/1Te60bNVBgQcAnpWBWzfg7bb5NEuteLpBWJKlP+ByjhJ9INjWMb6g3Dv
	 LJY2K7mqA6hshg1ZxNiumMtbcFEqWsZ6XwdentsDMp9ESQIFfvmJASU2GfBWQ9YHN8
	 CEFPOdiUwE+2zEgeW6PD/HSQr+SXuxVuz5ytKYw0bgQNeCw1fgtZzIFktG/ZRcyOiA
	 vf82m3WFWwVTRP0DNdryNzDUZpQMGf4MKxlF3qxHxyT0R5nPbOwW2PbVeYav3U6cOB
	 2dseTEtIXMshBhduqoGp9OvXbZlSwbt/ssVXTxoF7ttNKFbbgofjgqYl5rQ6OWik+w
	 XfGILvaMWOA0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C89D4CF21C0;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/9] Support Zve32[xf] and Zve64[xfd] Vector
 subextensions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171408603081.8761.8620733679475942661.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 23:00:30 +0000
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 heiko@sntech.de, guoren@kernel.org, conor@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, evan@rivosinc.com,
 cleger@rivosinc.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 palmer@rivosinc.com, vincent.chen@sifive.com, greentime.hu@sifive.com,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, j.granados@samsung.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 12 Apr 2024 14:48:56 +0800 you wrote:
> The series composes of two parts. The first part provides a quick fix for
> the issue on a recent thread[1]. The issue happens when a platform has
> ununified vector register length across multiple cores. Specifically,
> patch 1 adds a comment at a callsite of riscv_setup_vsize to clarify how
> vlenb is observed by the system. Patch 2 fixes the issue by failing the
> boot process of a secondary core if vlenb mismatches.
> 
> [...]

Here is the summary with links:
  - [v4,1/9] riscv: vector: add a comment when calling riscv_setup_vsize()
    (no matching commit)
  - [v4,2/9] riscv: smp: fail booting up smp if inconsistent vlen is detected
    (no matching commit)
  - [v4,3/9] riscv: cpufeature: call match_isa_ext() for single-letter extensions
    (no matching commit)
  - [v4,4/9] riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
    (no matching commit)
  - [v4,5/9] dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
    (no matching commit)
  - [v4,6/9] riscv: hwprobe: add zve Vector subextensions into hwprobe interface
    (no matching commit)
  - [v4,7/9] riscv: vector: adjust minimum Vector requirement to ZVE32X
    (no matching commit)
  - [v4,8/9] hwprobe: fix integer promotion in RISCV_HWPROBE_EXT macro
    https://git.kernel.org/riscv/c/5ea6764d9095
  - [v4,9/9] selftest: run vector prctl test for ZVE32X
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



