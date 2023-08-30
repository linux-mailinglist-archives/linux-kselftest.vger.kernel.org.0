Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43578DAD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjH3ShM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbjH3NUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC48CD6;
        Wed, 30 Aug 2023 06:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC40062000;
        Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B455FC433AB;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=7gwrtueLyswihMZE2JPWq840cyLUSNmg9lpfnOQrhcA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e6k88Cc/TU9FsjqPbaaGCT3TAzQdnDwcDOCQJGAriL1cZQXOG4+kR1DdXkS48R6M7
         Qxba6cHLNS3Ao3zXNddcWauycZsPvdoqu4L5M8bJ9ssjb33I78NaKVtyMgVwOyz9gY
         a4/QeqIQ0Jq03INtemWCeDpxp7083w0LCObbld2ORbGY3WB67LDE0OmdVU6VaI5Mpz
         n/nXRXvpdXcRG31hJitTpXeVjEqGZJetn0ueGsKq/0gPfvIQOm5DHGzIAjep9bnQGj
         HOsRt/kTDI6PA54ysAZ1ss0laEbbCqT53KBmN2Xt72Pjo0djq7zRkp85DfC+IRtz/s
         kdicHPHCKDg3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C9A9E49FAF;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163463.19859.14293662814940071934.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230809232218.849726-1-charlie@rivosinc.com>
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  9 Aug 2023 16:22:00 -0700 you wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. Users can now select a
> desired address space using a non-zero hint address to mmap. Previously,
> requesting the default address space from mmap by passing zero as the hint
> address would result in using the largest address space possible. Some
> applications depend on empty bits in the virtual address space, like Go and
> Java, so this patch provides more flexibility for application developers.
> 
> [...]

Here is the summary with links:
  - [v10,1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
    https://git.kernel.org/riscv/c/add2cc6b6515
  - [v10,2/4] RISC-V: mm: Add tests for RISC-V mm
    https://git.kernel.org/riscv/c/4d0c04eac0c2
  - [v10,3/4] RISC-V: mm: Update pgtable comment documentation
    https://git.kernel.org/riscv/c/26eee2bfc477
  - [v10,4/4] RISC-V: mm: Document mmap changes
    https://git.kernel.org/riscv/c/7998abe69d3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


