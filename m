Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FCE7669EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjG1KKc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjG1KK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 06:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2812D64;
        Fri, 28 Jul 2023 03:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A916620A7;
        Fri, 28 Jul 2023 10:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F690C433C8;
        Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690539024;
        bh=GFD7yQTW1E+U5yucY34yXq1bDEXUfFmL7ocQylgukHQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l8STCjesLUUCibFf0oaoLRIugxQiP1GVNA3MeXPArWQot6O+NuNhBhpH716yGsSiU
         jB2xphIxzTWAtjhFAkeBiRIC8hZgzHal6QNLB8rQyNTz5lhuW9YOAWApf8L8hd6MwH
         ViEcTJ5/cWWxv6H0PavoLGnQBtfEi4o34AiqB0yEw53OORCKU85RmQSJn/E6rE1Xhx
         hA1KILLmyk3iRPZnzuskDBDv1ORlFWn8Ra08fjVOzGB5j6BHjFEcKA3KPTHlO/FpCL
         tgcVv0ST3g+UmiQ1vdC71BbwumSn4R3ygI0poD8bkuaU/jAC+af77MXaD6ZaV8jbLj
         rRA6O0e1bPtRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44C46E21ECC;
        Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests/ptp: Add support for new timestamp
 IOCTLs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169053902427.13986.1880918301983575939.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 10:10:24 +0000
References: <cover.1690321709.git.alex.maftei@amd.com>
In-Reply-To: <cover.1690321709.git.alex.maftei@amd.com>
To:     Alex Maftei <alex.maftei@amd.com>
Cc:     richardcochran@gmail.com, shuah@kernel.org, rrameshbabu@nvidia.com,
        davem@davemloft.net, kuba@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jul 2023 22:53:32 +0100 you wrote:
> PTP_SYS_OFFSET_EXTENDED was added in November 2018 in
> 361800876f80 (" ptp: add PTP_SYS_OFFSET_EXTENDED ioctl")
> and PTP_SYS_OFFSET_PRECISE was added in February 2016 in
> 719f1aa4a671 ("ptp: Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping")
> 
> The PTP selftest code is lacking support for these two IOCTLS.
> This short series of patches adds support for them.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
    https://git.kernel.org/netdev/net-next/c/c8ba75c4eb84
  - [net-next,v2,2/2] selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE
    https://git.kernel.org/netdev/net-next/c/3cf119ad5dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


