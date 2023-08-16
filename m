Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1881577DA47
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjHPGKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 02:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbjHPGKY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 02:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D084B213A
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 23:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 649B56498B
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C413AC433BA;
        Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692166221;
        bh=Uw8bTVFIBNZcxW+KxD6j2IfyOEvIwjpoIZwuxS/bQwY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FUEPhoQ6BnLEBWxEAlOK2b35sOck++bagDPDWDDbqfnNOYLb01cM4DJuIBnK4Tnh5
         jk8GyAKx0NhsCA6YZDUhb92SjXoKODsJQX6n90ap+rnqsJRqaWkuMElfg4EnVPiocR
         Fbjhj9ONjneBLttYkwIm7gfidZjbaZp5ZD4k+dEkrcKubFZ+Z5uFo29Owe3JbUDJeK
         1E4PZCPm61Gxuzp1KsRSjPxF2UR/C85nJllpnaYDt4jRgjfFW3j1A5Unqp6cU3HA0O
         wM4J/zTHruK3LF6YZ1ZiWPehdFBBOw+2K5q5ibsoU37Po4Pf3yoCg8c5jIKnP3Ul2E
         igPGGD/B12uEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE7BBC39562;
        Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: bonding: remove redundant delete action
 of device link1_1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169216622171.7878.6507698004399073444.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 06:10:21 +0000
References: <20230812084036.1834188-1-shaozhengchao@huawei.com>
In-Reply-To: <20230812084036.1834188-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 12 Aug 2023 16:40:36 +0800 you wrote:
> When run command "ip netns delete client", device link1_1 has been
> deleted. So, it is no need to delete link1_1 again. Remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: bonding: remove redundant delete action of device link1_1
    https://git.kernel.org/netdev/net-next/c/e56e220d73ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


