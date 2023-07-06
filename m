Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84874A58E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGFVKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGFVKb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 17:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D071BC9;
        Thu,  6 Jul 2023 14:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA3A6119F;
        Thu,  6 Jul 2023 21:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62168C433CA;
        Thu,  6 Jul 2023 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688677829;
        bh=r0kK6Q/5EIs8ECrWV3m193nP6zDw8DILs2c7Ih39kOA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lpoM5kp+XBh8FPwCD+3OLJgCWtExHyKo2Ezck5g/mkCSFGxOLt5ZjdCPrB9TL8vBG
         8lBilZvmjnpnPJoNmOaO7rmOosKvee5fAGW6GDPIQte++EB0ejwPkfXE0+jHus5peO
         5rLfa7FQJdu/BvJWtjJopfwKgkPoNX4+Esc47r/svBVAcMQmexQ8N/xPg3Swb7nMZ/
         fZEmRZcK5F5I2k+1UYe8USSzEwmPpaeNCSXCM+KqV1bwePy4eYa9ThLlxgETPGNJXT
         /lLB39c4c37h02GWle2ak3mSbFFmn/fqwYLVR0h/A/R/fq26I3jRlH2vkON2HgPBCZ
         stgnEMr+YfSww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EBCEE5381B;
        Thu,  6 Jul 2023 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168867782925.19494.7717001810373235391.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 21:10:29 +0000
References: <20230706142228.1128452-1-bjorn@kernel.org>
In-Reply-To: <20230706142228.1128452-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, bjorn@rivosinc.com, ast@kernel.org,
        daniel@iogearbox.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  6 Jul 2023 16:22:28 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
> buffer overrun if the number of syms on the system is larger than
> MAX_SYMS.
> 
> Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
> the maximum is reached.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Bump and validate MAX_SYMS
    https://git.kernel.org/bpf/bpf-next/c/e76a014334a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


