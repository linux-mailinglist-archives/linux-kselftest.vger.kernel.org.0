Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A65A31B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHZWKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiHZWKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 18:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938DD99EE;
        Fri, 26 Aug 2022 15:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00593617F0;
        Fri, 26 Aug 2022 22:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 404A9C433D6;
        Fri, 26 Aug 2022 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661551814;
        bh=YQJzifCHZ33M31Ukg9rhui6shZihD7lu/Hp2d2JhdpI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hw4IVIQ/2ox2WCWOyuG4xvLYGyXCqNKEE49Tz4+nDSyMwLBwbbQN8F4KNLsGnWL9j
         47ZjJzkYz9RVLU4H1gVCeEsq4feYhwJkFNRCDwW3gXWHuXS1CvXsp8igFFrknN82yt
         prVkWRWGBuvLqHOf4A3GTg5Nq7brWBZGH3iqXkH+O8e2v6UyS2HaBhyAryQsZbIdOh
         WiZt1byLeg5sZTA/4hCoh/5nWfQFSOQNYH9MZYyD+GAWNHdXy7lEKlN9YugYH56UPY
         bYl0G/Yp/9T4kk6t128UgkZe1Q6xjp+BphoWfjeGVaRgvtVpPvWyRYeTMTQe3KlyYS
         6mAtN3RhsnK/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2283DE2A040;
        Fri, 26 Aug 2022 22:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix type conflict in test_tc_dtime
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166155181413.1305.3411544113325822300.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Aug 2022 22:10:14 +0000
References: <20220826050703.869571-1-james.hilliard1@gmail.com>
In-Reply-To: <20220826050703.869571-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, davem@davemloft.net,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <kafai@fb.com>:

On Thu, 25 Aug 2022 23:06:59 -0600 you wrote:
> The sys/socket.h header isn't required to build test_tc_dtime and may
> cause a type conflict.
> 
> Fixes the following error:
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/test_tc_dtime.c:18:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: error: conflicting types for 'int8_t'; have '__int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> In file included from progs/test_tc_dtime.c:5:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'char'}
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: conflicting types for 'int64_t'; have '__int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long int'}
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/test_tc_dtime.o] Error 1
> 
> [...]

Here is the summary with links:
  - selftests/bpf: fix type conflict in test_tc_dtime
    https://git.kernel.org/bpf/bpf-next/c/ab9ac19c4d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


