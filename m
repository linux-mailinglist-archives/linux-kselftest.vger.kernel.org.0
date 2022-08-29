Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710625A558A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiH2UaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2UaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 16:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88944A112;
        Mon, 29 Aug 2022 13:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AB3FB81210;
        Mon, 29 Aug 2022 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D94C433B5;
        Mon, 29 Aug 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661805015;
        bh=xc/8j1puoSwt9zF2PJolhLiYAfpQXkR2k48Kr8P2wek=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QseKYkdxZN1gmh6xhBqCJNxati+aAyrGeKQExicbC9P9vhtsf5J1qAV4ZgGiYDeIY
         WghtN3cTQsvsn1vdgpQoK/PqCRXNQZzCOZ200aPCje9dpYJZLbXQVkMitSXPnbphuE
         bBmRJVObRUgPft6yAlCgxQ+77gS9jLyc89+1zBWU62YdvlB+Y9YDIodelbb4NYLG1G
         muxd/6wp1vb6QOwTwCFStGS/9kvteVTR57/PZSdDinUS/X2e5XQbU1YH4ONBhrLs3j
         uk2R+cZFpEHruwNRzglsk6dwgSSNSCSDGhjanvh6qDbaC7ZGcFVdMSh9Lm4BOji+dx
         HNjtmzKVx1xlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29ACBE924D4;
        Mon, 29 Aug 2022 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Fix connect4_prog tcp/socket header type
 conflict
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166180501516.3157.816494875355749007.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 20:30:15 +0000
References: <20220829154710.3870139-1-james.hilliard1@gmail.com>
In-Reply-To: <20220829154710.3870139-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, davemarchevsky@fb.com,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 29 Aug 2022 09:47:09 -0600 you wrote:
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h and sys/socket.h, we can replace both of these includes
> with linux/tcp.h and bpf_tcp_helpers.h to avoid this conflict.
> 
> Fixes the following error:
> In file included from /usr/include/netinet/tcp.h:91,
>                  from progs/connect4_prog.c:11:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/connect4_prog.c:10:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Fix connect4_prog tcp/socket header type conflict
    https://git.kernel.org/bpf/bpf-next/c/2eb680401df6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


