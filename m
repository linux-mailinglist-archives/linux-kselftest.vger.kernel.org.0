Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12707A8368
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjITNaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjITNae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:30:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2FA9;
        Wed, 20 Sep 2023 06:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E5FBC433C9;
        Wed, 20 Sep 2023 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216628;
        bh=KIFyhvlk0M/PhlpCsj4uMTv2n1j5avTPP9lbTgWA73g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q9CxtV8Svu0x4lh2xBlRSZre3K5SzUtfWB67H2RQ0of/p/HNoG0yYBWNLhIU2PoRP
         zmSc4y5HAkvJGqANaJhnmI+0fiRQSuI5QSE7/ceU4XegVEn5+pr39Ao26S1dJzS0Wy
         QrxmRf+EW4LO0SzgjlE16qc358KjDjtGPwqwR+d+zpfbEAcNpw4TpbjwOh+M9Nmdwl
         Kc13U1kGxHuLWs1s3ovlbGG7MTruZ/Ghvgz3seNwChOltZ/2gPtQ4xDqdkRyfOBgso
         tjasSaFZJtWqR1s/5jNxQZ5riKyicHbslU3mMVKaR+UKpFuFAHI/mBq1c75Hd4eLJL
         0uS3pZih2r0jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A47AC4166E;
        Wed, 20 Sep 2023 13:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: kselftests: Fix mm build by removing testcases
 subdirectory
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169521662823.29772.7940523167721652862.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 13:30:28 +0000
References: <20230915100113.13131-1-alexghiti@rivosinc.com>
In-Reply-To: <20230915100113.13131-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, shuah@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, charlie@rivosinc.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 15 Sep 2023 12:01:13 +0200 you wrote:
> kselftests fails to build because the mm/testcases subdirectory is not
> created and then the compiler fails to output the binary there.
> 
> So fix this by simply removing this subdirectory which is not very
> useful.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: kselftests: Fix mm build by removing testcases subdirectory
    https://git.kernel.org/riscv/c/b06fab003ae1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


