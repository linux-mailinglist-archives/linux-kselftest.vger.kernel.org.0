Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772EF74B5EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGGRkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGRkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 13:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781D1FE6;
        Fri,  7 Jul 2023 10:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7746261A1D;
        Fri,  7 Jul 2023 17:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD30EC433C9;
        Fri,  7 Jul 2023 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688751621;
        bh=AYVfimEp8+8DulP0DHL5IdruuPSov040P2t3VymNxrU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UOJEeOtvppRTK7L2/gkrGVCDo/9QnmeCrVb/T25qUI2mR9ZninphUmJI7mdl12yYn
         7Ngg9fFHLwZ+8noaYO3JHhEZnB/UqJj39DA4QTV5LCgQFo/qsvv/GQE9wY5RNa0bJ7
         mafUAEOcmP1VNXRNXcFpXGDtrPkmGewdrTndpFVGydD2LcJPckpNxM+IkAiNEyFAYa
         liJm09sQCZ1bR1N3Byv/7pXx4YRvUxdxtM6wAsTjLHKRElDS9e83iZBFk5N68bExkH
         jHgCY9QWBf3NJuYyBM6b5TIAnOKgIML4O/Vtzz/OjLn1xsVbw9RXZFEJM8ynSZp/6P
         vi94LEuxMlTTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A872C59A4C;
        Fri,  7 Jul 2023 17:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Corrected two typos
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168875162162.5278.14612195207224938068.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 17:40:21 +0000
References: <20230707081253.34638-1-luhongfei@vivo.com>
In-Reply-To: <20230707081253.34638-1-luhongfei@vivo.com>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, houtao1@huawei.com, aspsk@isovalent.com,
        wangyufen@huawei.com, zhuyifei@google.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Fri,  7 Jul 2023 16:12:50 +0800 you wrote:
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
> Compared to the previous version, the modifications made are:
> 1. Modified the subject to make it clearer and more accurate
> 2. Newly optimized typo in tcp_hdr_options.c
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Corrected two typos
    https://git.kernel.org/bpf/bpf-next/c/856fe03d9292

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


