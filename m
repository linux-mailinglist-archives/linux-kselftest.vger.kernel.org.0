Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2D7B8E37
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 22:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjJDUkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJDUkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 16:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3889B;
        Wed,  4 Oct 2023 13:40:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3EAC433C9;
        Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696452028;
        bh=f2fF4KyVL+tXFaEf7vQScf7IfzEATIaUoOk5l4h8FiI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kf6hXVPcX37XY/EN5HgPArGFomT2FdPTwal6hLk6IxxAGggpsaEO0/NypURvL70z7
         LAw1SyZ2AXVfjQvWV68tMOUgaaGUjjbFFj3VLkl92Ah6qUFEt8tZgbtOODMNUdWCQ8
         lqw/VvKXwTdxqJITTmr6SNOxiZudX79bwpxLmzbZT+DWDUWtnxBhtf9DykUXwoDbX7
         js8jH28g8tOwBTvx918Fm5vVZAtswEjp4iKovfxhk/E686FwWPGhmOcSTztGTfu8Rv
         6nCMSd09Tn7jZytQz0kNUcFJDo34XIdjyFTnWmKgpwWjO8cUJLtRSM/Uh7nT2dwMZt
         GhJWXz8buv5AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09201E632D6;
        Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645202802.14504.10210722670650849429.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 20:40:28 +0000
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        mykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        bjorn@rivosinc.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, samitolvanen@google.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Oct 2023 13:09:02 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.
> 
> Note that there's an outstanding fix [1] for ftrace syscall tracing
> which is also a fallout from the commit above.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] libbpf: Fix syscall access arguments on riscv
    https://git.kernel.org/bpf/bpf-next/c/8a412c5c1cd6
  - [bpf,2/3] selftests/bpf: Define SYS_PREFIX for riscv
    https://git.kernel.org/bpf/bpf-next/c/0f2692ee4324
  - [bpf,3/3] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
    https://git.kernel.org/bpf/bpf-next/c/b55b775f0316

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


