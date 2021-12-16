Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01829477DA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 21:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbhLPUcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 15:32:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40088 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbhLPUcO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 15:32:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D21EB82624;
        Thu, 16 Dec 2021 20:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE18EC36AE9;
        Thu, 16 Dec 2021 20:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639686731;
        bh=zT9WV47/0e2xRPX0gLcyz8Kq/cN7/ZubHmNCQS8JMOQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WfI02qypBzDkJBqKZ4AHzzCD1uK+ub+p5VaHOXmP+GBc1qbo99/3rqJd9tt905G4x
         nBBww+EZ+R4wS20yZaYof1Ax8R8fWx9/8zwJ8wqFO0kKlrwj8Ptz7xFG6SXEMY66U7
         ubqnjCHIj34XRUa/NnXLVml7VpNWPgoZgdl3r0pyW9I6/44qIqN8iSjVnlDbva6ylc
         +/s4+T5Jtsm8rDi+riE1PTwfjsAWsjIr0U6uEth8Av3D5fGi40YrVvnHb7hpqHabge
         yI3U6W5qrAD8G1RNSwc5nmzU2C6x0L42bGqWssXljoDNb2Am/62m57qwqL8MntYLzu
         RVWvVhcz3LZOA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C053060A39;
        Thu, 16 Dec 2021 20:32:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/6] tools/bpf: Enable cross-building with clang
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163968673178.4272.6690035910193012947.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Dec 2021 20:32:11 +0000
References: <20211216163842.829836-1-jean-philippe@linaro.org>
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 16 Dec 2021 16:38:37 +0000 you wrote:
> Since v1 [1], I added Quentin's acks and applied Andrii's suggestions:
> * Pass CFLAGS to libbpf link in patch 3
> * Substitute CLANG_CROSS_FLAGS whole in HOST_CFLAGS to avoid accidents,
>   patch 4
> 
> Add support for cross-building BPF tools and selftests with clang, by
> passing LLVM=1 or CC=clang to make, as well as CROSS_COMPILE. A single
> clang toolchain can generate binaries for multiple architectures, so
> instead of having prefixes such as aarch64-linux-gnu-gcc, clang uses the
> -target parameter: `clang -target aarch64-linux-gnu'.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] tools: Help cross-building with clang
    https://git.kernel.org/bpf/bpf-next/c/cebdb7374577
  - [bpf-next,v2,2/6] tools/resolve_btfids: Support cross-building the kernel with clang
    https://git.kernel.org/bpf/bpf-next/c/bf1be903461a
  - [bpf-next,v2,3/6] tools/libbpf: Enable cross-building with clang
    https://git.kernel.org/bpf/bpf-next/c/4980beb4cda2
  - [bpf-next,v2,4/6] bpftool: Enable cross-building with clang
    https://git.kernel.org/bpf/bpf-next/c/bdadbb44c90a
  - [bpf-next,v2,5/6] tools/runqslower: Enable cross-building with clang
    https://git.kernel.org/bpf/bpf-next/c/bb7b75e860ee
  - [bpf-next,v2,6/6] selftests/bpf: Enable cross-building with clang
    https://git.kernel.org/bpf/bpf-next/c/ea79020a2d9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


