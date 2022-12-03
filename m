Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4164144D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 06:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiLCFab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Dec 2022 00:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiLCFaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Dec 2022 00:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBB12AA2;
        Fri,  2 Dec 2022 21:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53746B82370;
        Sat,  3 Dec 2022 05:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F103EC4347C;
        Sat,  3 Dec 2022 05:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670045418;
        bh=s1waNa3vCwL0xP0/Yg4UcOosAUbptVsY5b5bK4ThrKs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LZ1Wsj39kcJfR0ZtW3EsUUbdYibmYOf5VMAvyDxsLXDnbGlbXcZHS3lAtelm3E1gz
         t34jjY81UwKWXotm8o/nCzK+yK7le6URkAsfb/qSb7fiw+EIH+D05mxVQ8K/Xuo7a9
         qIMC+oHP9aL0XNHEGug+BDecIJ0mi2gBT2znaN1sUWI4IhnP46MpJ4/rO0Hbk+m0AC
         m6eWFjT1e8Wo9zujke2QW1Owh12fgIXHHwYK9QhLePFz0mxVkLUDoGpj6r6OmATX9T
         9E5DAR6FNugOdoQRn+x93eZIcH2CAkKWi51bPo8p13LksWF+2BzN+ESvYpdM3/TWGx
         p1WWb3zl1YXbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF62EE29F3F;
        Sat,  3 Dec 2022 05:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rtnetlink: correct xfrm policy rule in
 kci_test_ipsec_offload
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167004541784.20517.11410642183932124615.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Dec 2022 05:30:17 +0000
References: <20221201082246.14131-1-shaozhengchao@huawei.com>
In-Reply-To: <20221201082246.14131-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, shannon.nelson@oracle.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 1 Dec 2022 16:22:46 +0800 you wrote:
> When testing in kci_test_ipsec_offload, srcip is configured as $dstip,
> it should add xfrm policy rule in instead of out.
> The test result of this patch is as follows:
> PASS: ipsec_offload
> 
> Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: rtnetlink: correct xfrm policy rule in kci_test_ipsec_offload
    https://git.kernel.org/netdev/net/c/85a0506c0733

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


