Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE4743D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3OKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF3OK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347A3C0E
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Jun 2023 07:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4942E6174C
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Jun 2023 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5ECDC433C0;
        Fri, 30 Jun 2023 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688134221;
        bh=7CYcR8BA5JgYH65UpytxLCS7BxTnhGd2xR2qkutsLnk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G07+d/045UoBv4V6bxu1Swi4owEqwJFA8JgwLdWjc/n/oplRus+WFOeduwiY53mjE
         83NbcokNzGzLs2Ma5igjQBO0ZenjmKuQOWmy5Z+BWO9+/YBTAI66sEC40jeSEGAvdC
         RvhNFkCC/AsiQM0AEoibmGHJkT9MIDpipi7KpTkl2WqxEby4Fdx2zHjh5bmldJCUDG
         eBuIxRS01P8jOEd55uaDUEH75NTDxCzc2Q/U2i6zuvBJsLy1cvKkJrbU2ulHPGjBeZ
         J9mpvVkzsL8DRWLd64IfJWHm415Z9lZuibtJv5En6oxbO4G9hNIVu1sDOP9lzl8gMh
         sDtnjAYhZ4N7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F52AC561EE;
        Fri, 30 Jun 2023 14:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Fix missing synack in BPF cgroup_skb filters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168813422151.21445.13036199053257466608.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 14:10:21 +0000
References: <20230624014600.576756-1-kuifeng@meta.com>
In-Reply-To: <20230624014600.576756-1-kuifeng@meta.com>
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com, netdev@vger.kernel.org, kuifeng@meta.com
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 23 Jun 2023 18:45:58 -0700 you wrote:
> TCP SYN/ACK packets of connections from processes/sockets outside a
> cgroup on the same host are not received by the cgroup's installed
> cgroup_skb filters.
> 
> There were two BPF cgroup_skb programs attached to a cgroup named
> "my_cgroup".
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] net: bpf: Check SKB ownership against full socket.
    https://git.kernel.org/bpf/bpf-next/c/223f5f79f2ce
  - [bpf-next,v4,2/2] selftests/bpf: Verify that the cgroup_skb filters receive expected packets.
    https://git.kernel.org/bpf/bpf-next/c/539c7e67aa4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


