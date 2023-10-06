Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C713B7BBED1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJFSkc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjJFSkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 14:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B7BE
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 11:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48DA8C433C7;
        Fri,  6 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696617630;
        bh=HYapKJMwFkDh55pZuS5u3momjlscFEB+q9C3waeD1so=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ho1T3NtHL5pABzFyPdjJEIlYRfLF2Rh/englAlVj0hCMGxfZfhzPb40V+Swtu9N8j
         u/hCaTj8i5/NOdKJnRLDLvAf8LO9TjWJlbppv0P/xYjYzTb59zJDsI9QikChWuUIeE
         c+rKh75IpJItewgijvy9LaFwY5TMUzY6YWfze/IlxklnYKrpdpEM7zWGwlVNxFZx/6
         IRpyZXfwWF2yujfnC1Ebps67EyqgsTX7mtRg2qFuqdDOMe9l0k9aoOy9eqC/2eeVmu
         HwhNy5MgPmrFDxfq2LiUDHg/IXxzc6ht43+pz9GIICvqhP5xy6fnxWmqDdxIhi62z4
         uU3+ek5/Dslvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AE2EC41671;
        Fri,  6 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add pairs_redir_to_connected
 helper
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169661763016.20394.6643518221099866402.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 18:40:30 +0000
References: <54bb28dcf764e7d4227ab160883931d2173f4f3d.1696588133.git.geliang.tang@suse.com>
In-Reply-To: <54bb28dcf764e7d4227ab160883931d2173f4f3d.1696588133.git.geliang.tang@suse.com>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  6 Oct 2023 18:32:16 +0800 you wrote:
> Extract duplicate code from these four functions
> 
>  unix_redir_to_connected()
>  udp_redir_to_connected()
>  inet_unix_redir_to_connected()
>  unix_inet_redir_to_connected()
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Add pairs_redir_to_connected helper
    https://git.kernel.org/bpf/bpf-next/c/fdd11c14c33b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


