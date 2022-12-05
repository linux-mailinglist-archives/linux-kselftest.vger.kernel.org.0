Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15A56421D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 04:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiLEDKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Dec 2022 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLEDKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Dec 2022 22:10:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739271117D;
        Sun,  4 Dec 2022 19:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03BAD60F5D;
        Mon,  5 Dec 2022 03:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 479CEC433B5;
        Mon,  5 Dec 2022 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670209815;
        bh=8tpw7re3hFWHkvW2OlAHhRmWfS5oSK+QnRPoMz5gqPg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SdR1dAhAulFSkroNnkkA3ZbtnMGji4OrRMO1Gg0RQOSZotZsYN0gTYAdegLC7BH/e
         wEEOZarSUDPqRE+DKNbatOVf4b1H2XYrD5Vuv/J6f3GrEtzIgXLM0MK6P7Tdq8CjWR
         H+DzYmM2KSMCvw8gzPsluwNqeXLIZhiFrr8KuBNPI1ejiecR0F4IjNdSDcf06X2YFF
         4M6LdxjyWEanM+Pdo5ViE2tG7xvWHVNRao1b6lpQUxjpiC50MgUHQXwFm1nBP6cT1E
         X7dNdnkRwU5H4nfzDdI319D5eJ9TN4EwgoVEyfmm9/rLMHfNZfLQqW8PIAOgpi6B/g
         2f1U9IUPFfhEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D67E270CF;
        Mon,  5 Dec 2022 03:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix conflicts with built-in
 functions in bpf_iter_ksym
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167020981514.9466.9589871832936994836.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 03:10:15 +0000
References: <20221203010847.2191265-1-james.hilliard1@gmail.com>
In-Reply-To: <20221203010847.2191265-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, alan.maguire@oracle.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Dec 2022 18:08:44 -0700 you wrote:
> Both tolower and toupper are built in c functions, we should not
> redefine them as this can result in a build error.
> 
> Fixes the following errors:
> progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
>    10 | static inline char tolower(char c)
>       |                    ^~~~~~~
> progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
>     4 | #include <bpf/bpf_helpers.h>
>   +++ |+#include <ctype.h>
>     5 |
> progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
>    17 | static inline char toupper(char c)
>       |                    ^~~~~~~
> progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
    https://git.kernel.org/bpf/bpf-next/c/ab0350c743d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


