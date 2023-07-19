Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EEC7589D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGSABt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGSABs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 20:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB41BE7;
        Tue, 18 Jul 2023 17:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E91B6159F;
        Wed, 19 Jul 2023 00:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6929C433C9;
        Wed, 19 Jul 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689724821;
        bh=qxxeeH4BpVPJRWJ4+RBZAoXm54CuQ1BuSkX6X7QPBno=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aM26f95NosLZkRBrJfElkigefJKCG4RGcGm7yoQa0kV402AWkNwxeOcvbA5zBw1nu
         LH8/v9SpSyraWj2UFraGByiTEAsRpdyNSfxBjcKwf2yisrg1rf+ffy1cE5ivVwkUhL
         KCi1B5rnO8iIy5XRlANVrw5nNvzm4c7/6i12TsYvFy0QaR4PsXQlbG8PSZ5HSDf8MQ
         sd+99fC9x5txVMyehtWqt5b+s4l6E1kWLYCqTRNR/oQ0v188B61pnv/5N8Q76OlOsm
         Rif0k4UoJyFDOkm065tfBNTz4lEy/PdHz33ZoNduRd+mOmg4urmNR/1cWh3WhxrTv6
         Bssl9fiykT76w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A7C8E22AE4;
        Wed, 19 Jul 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: tc: increase timeout and add missing
 kconfig
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168972482162.23822.8375282604196078031.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 00:00:21 +0000
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        shuah@kernel.org, keescook@chromium.org, davem@davemloft.net,
        paulb@mellanox.com, marcelo.leitner@gmail.com,
        mptcp@lists.linux.dev, pctammela@mojatatu.com,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 23:16:43 +0200 you wrote:
> When looking for something else in LKFT reports [1], I noticed that the
> TC selftest ended with a timeout error:
> 
>   not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> 
> I also noticed most of the tests were skipped because the "teardown
> stage" did not complete successfully. It was due to missing kconfig.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: tc: set timeout to 15 minutes
    https://git.kernel.org/netdev/net/c/fda05798c22a
  - [net,2/3] selftests: tc: add 'ct' action kconfig dep
    https://git.kernel.org/netdev/net/c/719b4774a8cb
  - [net,3/3] selftests: tc: add ConnTrack procfs kconfig
    https://git.kernel.org/netdev/net/c/031c99e71fed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


