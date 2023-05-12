Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2096FFE46
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjELBKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 21:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 21:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54A185;
        Thu, 11 May 2023 18:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4003A61901;
        Fri, 12 May 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F742C4339B;
        Fri, 12 May 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683853821;
        bh=O6DIk8+nqvg238LCXy1SDs0FU+DW//DHdImCvTlHupw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X4xYdP2NdAioZg7jHQAvx8lr0+/5LX1hy+aG5ypfIxGFUclLPnOe1q8D+kI7o42Bw
         7jFlIupkXoWX6HCWcgFdXfYNyfFC5hJvQle40i2gRoNunejgPLVWuhrvZSPAJzhPeJ
         7q3g1n31cxZabIT2IeBjPDAUANzu//rb3QGPVX1O1eWhZsmBjUlsXUR4BxX4ejGf/r
         wjyOy3JpOg0kPCK9Jsv5d5p6PBC/4opv5uzKwzSvi6GePwDhxRoVFYgPMVs8iqg6jN
         6bNUqzY9xL23xQ+A4MoDIe/0tu0FXVGZ2M7UsMlYF2u2u3u/8AtnwK0qNgauWQHD3Y
         DgKpNQngkkJJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 753B1E270C4;
        Fri, 12 May 2023 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 0/2] selftests: seg6: make srv6_end_dt4_l3vpn_test more robust
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168385382147.13567.8508818014030321805.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 01:10:21 +0000
References: <20230510111638.12408-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20230510111638.12408-1-andrea.mayer@uniroma2.it>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, ahabdels.dev@gmail.com,
        liuhangbin@gmail.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 May 2023 13:16:36 +0200 you wrote:
> This pachset aims to improve and make more robust the selftests performed to
> check whether SRv6 End.DT4 beahvior works as expected under different system
> configurations.
> Some Linux distributions enable Deduplication Address Detection and Reverse
> Path Filtering mechanisms by default which can interfere with SRv6 End.DT4
> behavior and cause selftests to fail.
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: seg6: disable DAD on IPv6 router cfg for srv6_end_dt4_l3vpn_test
    https://git.kernel.org/netdev/net/c/21a933c79a33
  - [net,2/2] selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_test
    https://git.kernel.org/netdev/net/c/f97b8401e0de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


