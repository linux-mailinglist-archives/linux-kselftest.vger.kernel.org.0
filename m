Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400B633E203
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 00:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCPXUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 19:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhCPXUI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 19:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A9AA64F8F;
        Tue, 16 Mar 2021 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615936808;
        bh=wfEOXNTyOS3Hobw58SdBRnuuQFxA1RRmGR5sVmylEps=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p/bg2ZvxTqQ67Eaj5klpFFzzrPI3dFFtzIvFe2mIyoZbfoLqJU4tNrGvEfPIBgmtg
         0ea3ctiNtLX0muG1JJX5i8b+zy02UUltkHezQ8dZDyyqlcdvqaSMHVwGbRQj2yOVjQ
         L8Vp7ihYfhWhJFG2clHJgeq87STgr/TriKo5FnAjwW76advwAnsNcas1WrsvDY0ObA
         ZSOD2w5BFY6NwqzxEpDDq1nPBPbd70dJ2qyo0uM6cLGCYMbgJco5cFs3hj7R7eH5ag
         cDGN+1MSaRKap7+TCwzu8Td4fPIxhiUh+qtcVyjCvC8krjGCM0eSuEjzP6+Ep5w9iX
         JvLkpumYetKcw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6E89260997;
        Tue, 16 Mar 2021 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf/get_cgroup_id: Use nanosleep() syscall instead
 of sleep()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161593680844.26790.7552741944574465101.git-patchwork-notify@kernel.org>
Date:   Tue, 16 Mar 2021 23:20:08 +0000
References: <20210316153048.136447-1-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20210316153048.136447-1-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     ast@kernel.org, shuah@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 16 Mar 2021 21:00:48 +0530 you wrote:
> Glibc sleep() switched to clock_nanosleep() from nanosleep(),
> thus syscalls:sys_enter_nanosleep tracepoint is not hitting
> which is causing testcase failure. Instead of depending on
> glibc sleep(), call nanosleep() systemcall directly.
> 
> Before:
>   # ./get_cgroup_id_user
>   ...
>   main:FAIL:compare_cgroup_id kern cgid 0 user cgid 483
> 
> [...]

Here is the summary with links:
  - selftests/bpf/get_cgroup_id: Use nanosleep() syscall instead of sleep()
    https://git.kernel.org/bpf/bpf-next/c/56901d483bf1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


