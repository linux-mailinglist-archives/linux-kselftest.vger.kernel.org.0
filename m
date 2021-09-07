Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE71402BCE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbhIGPbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 11:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233172AbhIGPbM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 11:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A18B7610D0;
        Tue,  7 Sep 2021 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631028605;
        bh=mzYm6Lw/6AMufYDWYgeyAyu58bC9n/R+MgibZUETcyA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o2CxejOoU2W5ejc2fEuPyKVeFk6bPthYORmtfil5S0+0cdZ/cp5nsKmrBXRBza74c
         qKBGAhu49rDYAd3V7m0D4CjOgNC8uCsyLdrAaJDL4lMVg5xq44LI4KfJ8Ivbzw/k4W
         eLU/wPZasGJwjVzPzMjpHTsCA1fAHQk1T+3SIARhDGjG4qjJc7sYYFa3ec3dVNLrxT
         +ou564WJgl3UcGtwqzIrh2/UTsvdwqAcXr73jc24Rx0baQK5+uQn8gPttTlQpkbKXP
         2KC/lcodFDhuWZg2pWwhNRxoErKN5cX2kTJqzPn4v2gj+4K0CdabyDUY4PVm+cajmf
         /JaVL53aaLbJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 939E160A38;
        Tue,  7 Sep 2021 15:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build of task_pt_regs test for
 arm64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163102860559.11849.11862203994349641299.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Sep 2021 15:30:05 +0000
References: <20210906163635.302307-1-jean-philippe@linaro.org>
In-Reply-To: <20210906163635.302307-1-jean-philippe@linaro.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, andrii.nakryiko@gmail.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon,  6 Sep 2021 17:36:38 +0100 you wrote:
> struct pt_regs is not exported to userspace on all archs. arm64 and s390
> export "user_pt_regs" instead, which causes build failure at the moment:
> 
>   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
>   struct pt_regs current_regs = {};
> 
> Instead of using pt_regs from ptrace.h, use the larger kernel struct
> from vmlinux.h directly. Since the test runner task_pt_regs.c does not
> have access to the kernel struct definition, copy it into a char array.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix build of task_pt_regs test for arm64
    https://git.kernel.org/bpf/bpf/c/3a029e1f3d6e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


