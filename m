Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216F5A4FE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiH2PKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiH2PKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027181C90A;
        Mon, 29 Aug 2022 08:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C0A61124;
        Mon, 29 Aug 2022 15:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB7B6C433D7;
        Mon, 29 Aug 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661785813;
        bh=8DV5Al8uoRA23fJEzAcTio890uhpNVpl6xlcOCvBmOk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WFM/Ps2NBtafeEoYeYpmBQHEE68FMJRCQRfmcUxLmd+UFR+tLTseqXe7oezu+7Emf
         49O8nJxUTM5nF/wdgumB7C57b4ybNwnlRHSSpkyLnUi24TyJOTbbUEttLHCWhKTqas
         8LHUdbSXXa3OoSG+pdXIWTjnZum4JNy/c/7MVC4eJYCTGwovm5dQJVF1rxMqq4AY5p
         VcSyF7di044RkRrwXLy/enF9gn1dCfw8S2HJtywEkeRc3TCBzWbZZj8Zt/mAVXFYJC
         mKsbFDFZHOfQ4kCJ4GhdypbfZhyB6uR8Cb4G/37EQ2KKiqfoGm0ayO1rvw7sVzm4Tj
         ttmSULO+s18sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B991DE924D4;
        Mon, 29 Aug 2022 15:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Fix bind{4,6} tcp/socket header type
 conflict
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166178581375.25237.2019041652775863863.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 15:10:13 +0000
References: <20220826052925.980431-1-james.hilliard1@gmail.com>
In-Reply-To: <20220826052925.980431-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org,
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

On Thu, 25 Aug 2022 23:29:22 -0600 you wrote:
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h with sys/socket.h, we can remove these as they are not
> actually needed.
> 
> Fixes errors like:
> In file included from /usr/include/netinet/tcp.h:91,
>                  from progs/bind4_prog.c:10:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
    https://git.kernel.org/bpf/bpf-next/c/3721359d3907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


