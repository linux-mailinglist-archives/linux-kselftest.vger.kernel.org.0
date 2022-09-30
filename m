Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5D5F15D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 00:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiI3WKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiI3WKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88416612C;
        Fri, 30 Sep 2022 15:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63EECB82A4E;
        Fri, 30 Sep 2022 22:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B4FBC433D6;
        Fri, 30 Sep 2022 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575816;
        bh=boq1adV3v7czYDdvsiNNB+DcHejVYZg49b8utNbjG7U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ac4/sGRk0ooX/FZ6e5s74h3+JG4E9dRVF1p1LuBwUGsi/mSkm6EXUkaHGuJT4w82O
         HQvF+hYsowmadEy6s1cCDMWzo+2DaL4SknhXPgR0cfg1BLNyqpX7PAqw1CnPS+t2hh
         rGIJgUZcRmoZW6VeTqu+cOoog+EBGp2TLQcEHFprtUEsd9TMga/Lg/DmYWkqripDem
         VNenx6FiL/UjKdCDTDwQBxXDIiY1KEPL+vHpx0y9DFVD2p/sXSTvW8k+UYEHqdGdx+
         /nmkkG5H3WtuNPqcstImVmD09SSYoHVH6I5mbMuR2r4TOROGUjYyv/tyrHVsm+GoZm
         ilONQwqGV54oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03751E50D64;
        Fri, 30 Sep 2022 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix spelling mistake "unpriviledged" ->
 "unprivileged"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166457581601.30660.11490951795183636093.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Sep 2022 22:10:16 +0000
References: <20220928221555.67873-1-colin.i.king@gmail.com>
In-Reply-To: <20220928221555.67873-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Sep 2022 23:15:55 +0100 you wrote:
> There a couple of spelling mistakes, one in a literal string and one
> in a comment. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/calls.c   | 2 +-
>  tools/testing/selftests/bpf/verifier/var_off.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - selftests/bpf: Fix spelling mistake "unpriviledged" -> "unprivileged"
    https://git.kernel.org/bpf/bpf-next/c/2efcf695bfc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


