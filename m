Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281F659A6C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiHSTuV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350778AbiHSTuS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 15:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E63D9D50;
        Fri, 19 Aug 2022 12:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1E761662;
        Fri, 19 Aug 2022 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A60B3C433D7;
        Fri, 19 Aug 2022 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660938615;
        bh=LAjuJGvkE8Z2C6wwzs8qNrfSrFH7nv0QtOWOjNoYOcg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NCkw5me/r0alD75rVsN75X6pnJs+KYrZeeSgVg/0yKThN8DcTHxiEIBVCKXRdKuX5
         Xz8RP6dpXXGc8k1fYIzQDoae3A95pPJk8LXNCLJjyzcQH1UJpV6h/9U8/sU2Z1NJIq
         m/RDr1YVHpADYwXVW4W6D0669xoaHOXSRWZB88pyeghuJdZvaK4omoJNnGkzbk/r3/
         ngMzRmg0aa7z0exJUJ5GhKe0D48EYqinUC+jbmIagySW50Pmx8Dm+iZltk7WAhDHS5
         qgyJfsYFsPlbhc1LVX6GCIhZXtuOnAQZDJ5NdTyJUrZzXpL/tAzcnKaoQ4m/gxbtzJ
         WDPBxzZ+EN61g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F400E2A05E;
        Fri, 19 Aug 2022 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][V2][next] selftests/bpf: Fix spelling mistake "succesful"
 (kfunc_call.c)
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166093861551.5341.18369741765265253800.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Aug 2022 19:50:15 +0000
References: <20220817213242.101277-1-colin.i.king@gmail.com>
In-Reply-To: <20220817213242.101277-1-colin.i.king@gmail.com>
To:     Colin King (gmail) <colin.i.king@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Aug 2022 22:32:42 +0100 you wrote:
> There is a spelling mistake in an ASSERT_OK literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: change subject line as per Mykola Lysenko's recommendation
> ---
>  tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [V2,next] selftests/bpf: Fix spelling mistake "succesful" (kfunc_call.c)
    https://git.kernel.org/bpf/bpf-next/c/e918cd231ee6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


