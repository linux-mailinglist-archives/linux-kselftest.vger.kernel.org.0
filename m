Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0FE69FD87
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBVVKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBVVKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFA1EFF2;
        Wed, 22 Feb 2023 13:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6F85B81896;
        Wed, 22 Feb 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1FADC4339E;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677100217;
        bh=wCQQEMkM7Jx3pn9FFGosm1zRw8TdEwhVF5bmgBxG7Zw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YiGkRhzzZ6Y4QBYUP1zV2oy64eR6ubK7rULwLt0ayty2l01r2/S40q2dbINMjz+dp
         l5PJ/QkEWHWA9o54cMTdNAp68A4fk9PUJm9/NIv2DLqEk8v40w0n6w8sJkraXRP8O2
         YtfJP3C7Jw5LIgx4d/ucY1OTtBKVoBXPCkpLgT4R5eZb6yizRyrPjU8iYQdB/PGuiy
         N3ylqMUK21hpc0hi8yIg4VkLdigDDMLWQHVQIXafMGykroJrUyBQPjaS2s3FGbkfxd
         Hs3iqdoyvCMxvJNZ3Wwq1IuW/i+TqZF9cICWjer+BeWEJAlpAIBBDGLRZhDNcARQz3
         X2OiXYCWa3bzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8460EC395DF;
        Wed, 22 Feb 2023 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix cross compilation with
 CLANG_CROSS_FLAGS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167710021753.10496.8520957116500555540.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Feb 2023 21:10:17 +0000
References: <20230217151832.27784-1-revest@chromium.org>
In-Reply-To: <20230217151832.27784-1-revest@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Feb 2023 16:18:32 +0100 you wrote:
> I cross-compile my BPF selftests with the following command:
> 
> CLANG_CROSS_FLAGS="--target=aarch64-linux-gnu --sysroot=/sysroot/" \
>   make LLVM=1 CC=clang CROSS_COMPILE=aarch64-linux-gnu- SRCARCH=arm64
> 
> (Note the use of CLANG_CROSS_FLAGS to specify a custom sysroot instead
> of letting clang use gcc's default sysroot)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix cross compilation with CLANG_CROSS_FLAGS
    https://git.kernel.org/bpf/bpf-next/c/b539a287baaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


