Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599271F97D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 07:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjFBFAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 01:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjFBFAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 01:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEBF137
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 22:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C81564C42
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 05:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE17EC433EF;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685682020;
        bh=+0YnzVPdvfQsJB2IuBvdw3uDqzNe7nGlUfPDVvc5UBg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a8xpx63iAQKFimh6//rF1YQg63ucpL6/jE0B2luM+zu+4jNvwNFsZtgcZj0zBmO5+
         Ksyg/nItb0PWwQfUZUv40zyvzvGvOK0lwbIdTWLMd7IsXfSjqdc8XvIAqPMuD59PBr
         oyqL4v3Qv7wO/yQsedSX2cUzCDG39iy4XcZsTHn/sraZiDKK4gh+XVdwL8NSuQ3ucc
         /CL0bm5Ilnj1w0gg6aiDOaANyF0xs92cFZlURtuOLYEgq0cIXomqnVciFDhY2HATVE
         PPiuHaSjgnJTbNu0Xq3I5/YXXSD5p96tASJ7O6JXYPLnqWrefab5gWXnuLfnjXbtD8
         vQjejlw5uJrFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2746E29F3E;
        Fri,  2 Jun 2023 05:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] selftests/tc-testing: replace mq with invalid
 parent ID
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168568202066.24823.18027233483936915493.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 05:00:20 +0000
References: <20230601012250.52738-1-shaozhengchao@huawei.com>
In-Reply-To: <20230601012250.52738-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        shuah@kernel.org, kuba@kernel.org, victor@mojatatu.com,
        peilin.ye@bytedance.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, pctammela@mojatatu.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 1 Jun 2023 09:22:50 +0800 you wrote:
> The test case shown in [1] triggers the kernel to access the null pointer.
> Therefore, add related test cases to mq.
> The test results are as follows:
> 
> ./tdc.py -e 0531
> 1..1
> ok 1 0531 - Replace mq with invalid parent ID
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/tc-testing: replace mq with invalid parent ID
    https://git.kernel.org/netdev/net-next/c/a395b8d1c7c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


