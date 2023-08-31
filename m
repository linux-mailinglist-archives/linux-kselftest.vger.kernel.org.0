Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30778F40A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbjHaUam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjHaUal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 16:30:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D910F4;
        Thu, 31 Aug 2023 13:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0969B823C2;
        Thu, 31 Aug 2023 20:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D5ADC433CA;
        Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513823;
        bh=pqDP+zEjFuzOiOs+tgYZ2bf6Znca1Xga7yBy0aQPi+Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ooVFYbMxXlHYHm4YaqNS1xoSE9JBmMv8jqfJKHpQZIO6cDiE3SZrJ2aXUX6wnNDRD
         eQvkSy5aBlXCzLl/ATveA1MahYzTx4L2vVR0o3WhoKUdYgN8uKfAqjaPm7g3144mf9
         LkclpeW72riSzwlZ2ZlS2b0upGgf6IKGC5hm2hLPmqusx1YFJDQruep/MKu8jnnpRc
         POfwMFqDjDcOb/4hdhpyc2G5q2Mfl7NDR2qezaRZppw4u72nbuy0yQphcsvLtuBOTe
         LNaa74fo9QWQxdAHDGrC8DOpzMVr6VhMreUk/CCZN7Ambaq4iCIcP2aPImHxTJslcg
         8aDq6hMNektfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 617A1E29F33;
        Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Include build flavors for install
 target
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169351382339.13181.6255269847761617623.git-patchwork-notify@kernel.org>
Date:   Thu, 31 Aug 2023 20:30:23 +0000
References: <20230831162954.111485-1-bjorn@kernel.org>
In-Reply-To: <20230831162954.111485-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bjorn@rivosinc.com,
        ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 31 Aug 2023 18:29:54 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When using the "install" or targets depending on install,
> e.g. "gen_tar", the BPF machine flavors weren't included.
> 
> A command like:
>   | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
>   |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
>   |    -C tools/testing/selftests gen_tar
> would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Include build flavors for install target
    https://git.kernel.org/bpf/bpf/c/be8e754cbfac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


