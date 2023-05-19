Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEE709117
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjESIAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjESIAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 04:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630810F;
        Fri, 19 May 2023 01:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B067E654B4;
        Fri, 19 May 2023 08:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D569C433AE;
        Fri, 19 May 2023 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684483221;
        bh=TDR/scnjzukq+dLtHX6t1WC2zHG2+M9GmFkzYORuBB0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QG1QdB90nnAtdVeZaog2Pf7rW4+4xuI0sH1gCNUWr3sX1dMXMnSoEP7iIDc7HcB/R
         LIA7lKP8+WTuRXqcguT+h8Mkzm2RYbqCZCjtjkjXTfL1kJu2FI1MsfdQVkqYslwUKb
         /pygi7q71tbBnwKQPHfMIdBrWG6uBmCNyMt4m0c7hnA1qJN88s9+9HPq3QSMLm5d7D
         JUBByUFbuCAWSm9VIAgcOTNiRf9KdCQEhsAqvlZ2HlvdFO3QISkIDj0XDd+GDNHAOV
         cYUqf5S8dQcwke2BDZKyuhRBWsMP+m+ZAN0vel4iEhX811qCcitvZ2Qw3uX8DLK9t5
         zjK6RIg/aub1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4CFFE21EFA;
        Fri, 19 May 2023 08:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net] selftests: fib_tests: mute cleanup error message
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168448322092.32188.11445831777854335044.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 08:00:20 +0000
References: <20230518043759.28477-1-po-hsu.lin@canonical.com>
In-Reply-To: <20230518043759.28477-1-po-hsu.lin@canonical.com>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, roxana.nicolescu@canonical.com,
        shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 May 2023 12:37:59 +0800 you wrote:
> In the end of the test, there will be an error message induced by the
> `ip netns del ns1` command in cleanup()
> 
>   Tests passed: 201
>   Tests failed:   0
>   Cannot remove namespace file "/run/netns/ns1": No such file or directory
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net] selftests: fib_tests: mute cleanup error message
    https://git.kernel.org/netdev/net/c/d226b1df3619

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


