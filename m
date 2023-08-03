Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51776EDA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjHCPK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjHCPKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85130D7;
        Thu,  3 Aug 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5BC61DF7;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3044BC433CC;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=Bc6FMyBSmmt68PuMIaZe74ztIlwvpCvXEsf9pVqRPi0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BfppFodXQG4Ktb6EhZHIPBqooLi/LExFd7off9h7u0/1W4pQ9qVvRc5SZ1INEMHUN
         2VS8fcJm36U/jhFm8yn5UWmvKG7JjbrYGdYQI7nfHlU3gWmnmF+7gEZocMtj7cu7DB
         RggSpSgAzIyAiaBiyIejkZQ69GJ/pFjs4/nh57C6xZGZVTukIuXpes+p/pncZkx2Kg
         7oJhlYm1ixTLPyDOG9+P8yoMbSgbcb1+eHCICLZI/gJ7eLy8VUnbs/I3GilCUPXXEm
         vTVNH7J/TPTfQXo0OqFLfueipFHFBoxDq52OnIiax8rVNUQs29M27XxkBl6KUH1plM
         zSW1ohwd0tcvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13FAAC43168;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: riscv: Fix compilation error with
 vstate_exec_nolibc.c
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542307.19238.3370956488626231897.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:23 +0000
References: <20230713115829.110421-1-alexghiti@rivosinc.com>
In-Reply-To: <20230713115829.110421-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, shuah@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, andy.chiu@sifive.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jul 2023 13:58:29 +0200 you wrote:
> The following error happens:
> 
> In file included from vstate_exec_nolibc.c:2:
> /usr/include/riscv64-linux-gnu/sys/prctl.h:42:12: error: conflicting types for ‘prctl’; h
> ave ‘int(int, ...)’
>    42 | extern int prctl (int __option, ...) __THROW;
>       |            ^~~~~
> In file included from ./../../../../include/nolibc/nolibc.h:99,
>                  from <command-line>:
> ./../../../../include/nolibc/sys.h:892:5: note: previous definition of ‘prctl’ with type
> ‘int(int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)
> ’
>   892 | int prctl(int option, unsigned long arg2, unsigned long arg3,
>       |     ^~~~~
> 
> [...]

Here is the summary with links:
  - selftests: riscv: Fix compilation error with vstate_exec_nolibc.c
    https://git.kernel.org/riscv/c/25696067202f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


