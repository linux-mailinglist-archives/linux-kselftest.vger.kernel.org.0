Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32557992DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbjIHXk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIHXk1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E5133;
        Fri,  8 Sep 2023 16:40:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C8C7C433CA;
        Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694216423;
        bh=EYy6dm59NBJFJSkKgAVVKliFV8RPPvIRF78A5HR9JTk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dx3rPf0MzkZsWXLUkXWew2LJ5W//xr3SYY86QyC8Rgn0pdWc/lcZgXiIXqdsmqF+V
         +57Bz+3Un50MNepPyimHkPA0JvqP7f8jXAEvEqetFgvYvBdSx5JmMV5ydu0RsXG6T8
         pVk2AbMW/0XCPRhqSPr1SRsqYflSbM/clfQOewEMTs3O0X9XWNVpn9djmG0y83osd1
         yL3+9xWwoR4SBzCb8Mr7eBjctL96kKBgi3To4SlUvEBr4Pflsk1zTxS5c/nwFkSqus
         WNtBDOYKj5MLEl46UPF+QHba6kYPteVoM0uaFVoXYtO22WXhM0l3z3rzKFzUCJSP1q
         kNkKzqdvlElmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CAFFF1D6A9;
        Fri,  8 Sep 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/2] selftests/bpf: Optimize kallsyms cache
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169421642337.339.11184428489042288950.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Sep 2023 23:40:23 +0000
References: <tencent_FA47B711AB0DEC843EB3362E6355505ED509@qq.com>
In-Reply-To: <tencent_FA47B711AB0DEC843EB3362E6355505ED509@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
        rongtao@cestc.cn, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        laoar.shao@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Sep 2023 09:59:12 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> We need to optimize the kallsyms cache, including optimizations for the
> number of symbols limit, and, some test cases add new kernel symbols
> (such as testmods) and we need to refresh kallsyms (reload or refresh).
> 
> Rong Tao (2):
>   selftests/bpf: trace_helpers.c: optimize kallsyms cache
>   selftests/bpf: trace_helpers.c: Add a global ksyms initialization
>     mutex
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
    https://git.kernel.org/bpf/bpf-next/c/c698eaebdf47
  - [bpf-next,v12,2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
    https://git.kernel.org/bpf/bpf-next/c/a28b1ba25934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


