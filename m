Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5382F5902
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 04:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhANDLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 22:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbhANDLZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 22:11:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C848B2389B;
        Thu, 14 Jan 2021 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610593808;
        bh=S668cCj4fETsQeEe9cTKRejO/WRsuE92yCik1z6NkBM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MM2ZN3vxoqQ9ITlcNrGNo48hXx4eUWPLVvoZxy2Rc2YYbbhyeQZzc7Ndjc5i5hwsq
         PuqP8/IXPD8j6C1rWkKH5EVoan33Ua0njq64rFtPDoQtQC6NC3COFqSUnddXE74oB7
         0wazS5Se6oqnZ/molCDUC6revjZw388u1kxe9t+gWV80VO9zkktcUv9LjYgPVRh6RV
         LHSife85c7BLbq9SF4IhJTr8f4FtcSQ3xO81Uo60A8XB7tyC7eNFXhD5M2dB67rkLM
         y0MDq8oYcfHbw/GBzw9tW++NymXrXXwyo0ja8T5PIhOirBdDgpuUrU2Ry55wMLbddB
         e8ufNb+H0JWhA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id B940B60105;
        Thu, 14 Jan 2021 03:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] selftests/bpf: Some build fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161059380875.28478.11223446599120917979.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Jan 2021 03:10:08 +0000
References: <20210113163319.1516382-1-jean-philippe@linaro.org>
In-Reply-To: <20210113163319.1516382-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf@vger.kernel.org, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 13 Jan 2021 17:33:15 +0100 you wrote:
> A few fixes for cross-building the sefltests out of tree. This will
> enable wider automated testing on various Arm hardware.
> 
> Changes since v1 [1]:
> * Use wildcard in patch 5
> * Move the MAKE_DIRS declaration in patch 1
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] selftests/bpf: Enable cross-building
    https://git.kernel.org/bpf/bpf-next/c/de11ae4f56fd
  - [bpf-next,v2,2/5] selftests/bpf: Fix out-of-tree build
    https://git.kernel.org/bpf/bpf-next/c/5837cedef6f3
  - [bpf-next,v2,3/5] selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
    https://git.kernel.org/bpf/bpf-next/c/d6ac8cad50f0
  - [bpf-next,v2,4/5] selftests/bpf: Fix installation of urandom_read
    https://git.kernel.org/bpf/bpf-next/c/ca1e846711a8
  - [bpf-next,v2,5/5] selftests/bpf: Install btf_dump test cases
    https://git.kernel.org/bpf/bpf-next/c/b8d1cbef2ea4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


