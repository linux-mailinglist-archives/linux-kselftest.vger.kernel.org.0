Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3D44EE43
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhKLVC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 16:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235576AbhKLVC6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 16:02:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E75360231;
        Fri, 12 Nov 2021 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636750807;
        bh=ag2Tdmm/lYDghBFg1BWUUWn+s7sh3z1VhWqDjuapc7c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S7oweAo++rAisUn0dOr0NO0Kpk6+ZKSVWYBrJoZqcgHxCAupOfazpkJwM7+rzV1Pm
         pxlQVr90JSQAM02EhvSFlWvMswjvk1tDDbMUNGzQ9isLCJPAY+hTjBdDpLPky2iLRz
         HdrXJsnUYi3U15EeOZw7e4W9Gmx+c4bxxq7pTzWLL6R4e0NobEVBW7EECtynrw0Slx
         BbuSY7zmT7wd/LX29Ms+6mRxq78Ms2mecz3jzp053jQWHsF3m9yo2PnV0VXmb6Un6G
         282HuU9Ql9JIqtq5dGsDe8gahCOrGedtEEw5j6m1NRlN4gEI337RnVdcsykYKG6ALR
         PGmZOQL0LeBOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 71D48609F8;
        Fri, 12 Nov 2021 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163675080746.17861.4035490534028049921.git-patchwork-notify@kernel.org>
Date:   Fri, 12 Nov 2021 21:00:07 +0000
References: <20211112155128.565680-1-jean-philippe@linaro.org>
In-Reply-To: <20211112155128.565680-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 12 Nov 2021 15:51:30 +0000 you wrote:
> Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> building") uses the target libbpf to build the host bpftool, which
> doesn't work when cross-building:
> 
>   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
>   ...
>     LINK    /tmp/runqslower/bpftool/bpftool
>   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
>   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
>   collect2: error: ld returned 1 exit status
> 
> [...]

Here is the summary with links:
  - [bpf] tools/runqslower: Fix cross-build
    https://git.kernel.org/bpf/bpf/c/c9213bcf2fe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


