Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FB7A0458
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjINMud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjINMub (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 08:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1F1FD9;
        Thu, 14 Sep 2023 05:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8BA4C433CB;
        Thu, 14 Sep 2023 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694695827;
        bh=TMjV6+bwe3vJb7gXPII+PE+nTcdt7ZxTl2b7WdEsK1k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pyHJ9QrlbwpiTunl1V3mw4XYCOct1HMqY7QD/YwJTIZ0srvS/6E4QcmQfUOMOKHcT
         6Xxz9ZkxFNahPpOOmCOIPs5Wl57rSH6rFkWtNb2gakCc1Tg6pmgmCbv6OGnzV13p13
         DPytoH9Vuc8jQQWTGJn+amdgvNZLArdupbhceALtH1rxEw5jeeqrH4/rjJvEhTViL5
         r8axKoYdg8843ZzQB5tRXPHKEY/r8OLGt89xQWu35b21Cs6Mn7tBpFprC6MgGfuNkk
         ih22v51TpOXgRKPAnC93QuT2zIwRoQHQZq+MpufU141eX5iGIVrn3Yyajjte0bTw5Y
         i+jSvrPqghBLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB5AE1C280;
        Thu, 14 Sep 2023 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] Revert "selftests/bpf: Add selftest for allow_ptr_leaks"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169469582682.11653.11057987072443096277.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Sep 2023 12:50:26 +0000
References: <20230913122514.89078-1-gerhorst@amazon.de>
In-Reply-To: <20230913122514.89078-1-gerhorst@amazon.de>
To:     Luis Gerhorst <gerhorst@amazon.de>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        laoar.shao@gmail.com, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yonghong.song@linux.dev, mykolal@fb.com,
        shuah@kernel.org, iii@linux.ibm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerhorst@cs.fau.de
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 13 Sep 2023 12:25:15 +0000 you wrote:
> This reverts commit 0072e3624b463636c842ad8e261f1dc91deb8c78.
> 
> The test tests behavior which can not be permitted because of Spectre
> v1. See the following commit
> 
>   Revert "bpf: Fix issue in verifying allow_ptr_leaks"
> 
> [...]

Here is the summary with links:
  - [1/3] Revert "selftests/bpf: Add selftest for allow_ptr_leaks"
    https://git.kernel.org/bpf/bpf/c/cc7a599ca30f
  - [2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
    https://git.kernel.org/bpf/bpf/c/45f2aaba1079
  - [3/3] selftests/bpf: Add selftest for packet-pointer Spectre v1 gadget
    https://git.kernel.org/bpf/bpf/c/fc7274e42d14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


