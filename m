Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5900B7BB118
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 07:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjJFFKc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 01:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFKb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 01:10:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9925B6
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 22:10:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C02AC433C8;
        Fri,  6 Oct 2023 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696569029;
        bh=I1TyZZvDcgcqxnisZQ7MkHtizAiohWfWVBhg6535P2A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R9j0Hz8dxp0UoBKcCCHrlyBqypyOIyST2TFUqF1rM4zwIfvCcPjZOvOv2ORtbu/Vw
         0Guk1I8/oqJtEPBDJCPUK131pqJ/Y4JtuPmFSLUOPge3L3SrNulnc8toBuWeHy8/xJ
         gd6UQ2K8/PegC8eaol0iRG50uwRtCZsMODs455D3TX0Ko5w0doozYeyuwMBWXVghPO
         E1kpCNw70Cb2Gytl7shjI7VpjKypMyluG5ePXig7Y6r7tKShdLmjBQ97YK/WyV99tC
         lRGMkokBaHiFqlytuZurSVQWkbBPY7Y07tORSIy4t5eVF2jMUzDms6LRhO+xf5/o0h
         BGGMRrztguCuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EBBFE22AE3;
        Fri,  6 Oct 2023 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] cleanups for sockmap_listen
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169656902911.30880.9997812914153027889.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 05:10:29 +0000
References: <cover.1696490003.git.geliang.tang@suse.com>
In-Reply-To: <cover.1696490003.git.geliang.tang@suse.com>
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

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Oct 2023 15:21:50 +0800 you wrote:
> v2:
>  - rename c0/c1 to cli0/cli1, p0/p1 to peer0/perr1 as Daniel suggested.
> 
> Two cleanups for sockmap_listen selftests: enable a kconfig and add a
> new helper.
> 
> Geliang Tang (2):
>   selftests/bpf: Enable CONFIG_VSOCKETS in config
>   selftests/bpf: Add pairs_redir_to_connected helper
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Enable CONFIG_VSOCKETS in config
    https://git.kernel.org/bpf/bpf-next/c/d549854bc58f
  - [bpf-next,v2,2/2] selftests/bpf: Add pairs_redir_to_connected helper
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


