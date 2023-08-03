Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F976EDA3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjHCPK3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjHCPK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E1E72;
        Thu,  3 Aug 2023 08:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 459FE61DFB;
        Thu,  3 Aug 2023 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39847C43391;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=rwDIFv77BAjDPgTGsAuvfs6MDAuQX+PvCep8Kuvqk10=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V19xny6v+lTe4Y2krcepgAQFdQhA3wsyYARuV4dC2w8dD9Ni8UjadQje8c/4ouIAd
         DFKVDlDKVVJxtg8Zwj/1dIjqvyCXa/nrgQQPFyXjJb+uaq8BINYOZ/b3sqTtO2OClQ
         ApttD0LzIGx7h9uYVJQf4nvSwyFJfk1bqkSrEb+4XZ06H3EQ4GI7gyQ2bcIwlOm7a+
         D3t0Iupgr3ZdrG/LXBbqzv8Ihu3f9AXxxmneJw1RKHZY+CaAVdZzqEJ0Z5RGJuzQik
         3Bd+Wq2AbbUtKGXK8EVGoubfNiHuOI2o2iYw84JBPLxeRR5V75A4hs/wIuZeuY1OMg
         rByjSGNTz/lrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F57EC595C1;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/riscv: fix potential build failure during the
 "emit_tests" step
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542311.19238.11249347839219210996.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:23 +0000
References: <20230712193514.740033-1-jhubbard@nvidia.com>
In-Reply-To: <20230712193514.740033-1-jhubbard@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        anders.roxell@linaro.org, ajones@ventanamicro.com,
        andy.chiu@sifive.com, evan@rivosinc.com, hughd@google.com,
        usama.anjum@collabora.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, panqinglin2020@iscas.ac.cn,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 12 Jul 2023 12:35:14 -0700 you wrote:
> The riscv selftests (which were modeled after the arm64 selftests) are
> improperly declaring the "emit_tests" target to depend upon the "all"
> target. This approach, when combined with commit 9fc96c7c19df
> ("selftests: error out if kernel header files are not yet built"), has
> caused build failures [1] on arm64, and is likely to cause similar
> failures for riscv.
> 
> [...]

Here is the summary with links:
  - selftests/riscv: fix potential build failure during the "emit_tests" step
    https://git.kernel.org/riscv/c/8c82d2bf5944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


