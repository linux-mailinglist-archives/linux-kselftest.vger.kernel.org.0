Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D604D6D27FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjCaSk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjCaSkZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 14:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B5F23B49;
        Fri, 31 Mar 2023 11:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F32B62B45;
        Fri, 31 Mar 2023 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89109C4339B;
        Fri, 31 Mar 2023 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680288018;
        bh=TeiPgG/Ac++b/fUfLweTsTZbOpAdJsIOEZbjjLeegfY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GCdJiW2xyd1XErg5bi9MEQyRwRu+vg63PB1fNHhogAt12ifffAVj/z2Fbm4PAZn0e
         rXockBLm+Z122BZ2VhvwxFMnVSYebHfGoRP68hqKZY6YIjQjYNk5tHl9UUqyPMzccQ
         8VC+uyoqqGtdayLcke/glNEYVDjpkPAN0gOjwS4Wzqzhln6VNQlKgdoixbwm1MIhM/
         p0JoRXutKi6NtAs17yTk6E5pkLCRAwFOg0WPKTWy2Cb4LMOm7NEzgXYc4VogsjCwmR
         ZzitmtxM182ZiO9+2+14LDVV7XP9Ue9Mhi9R/TNde4Xtfko1lW/NyNgkFTTU9XDJMa
         w+hirzYHJkG1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D6FBC73FE2;
        Fri, 31 Mar 2023 18:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix conflicts with built-in functions
 in bench_local_storage_create
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168028801844.10530.9317186144237248044.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 18:40:18 +0000
References: <20230331075848.1642814-1-james.hilliard1@gmail.com>
In-Reply-To: <20230331075848.1642814-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@kernel.org, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 31 Mar 2023 01:58:42 -0600 you wrote:
> The fork function in gcc is considered a built in function due to
> being used by libgcov when building with gnu extensions.
> 
> Rename fork to sched_process_fork to prevent this conflict.
> 
> See details:
> https://github.com/gcc-mirror/gcc/commit/d1c38823924506d389ca58d02926ace21bdf82fa
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82457
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix conflicts with built-in functions in bench_local_storage_create
    https://git.kernel.org/bpf/bpf-next/c/9af0f555ae4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


