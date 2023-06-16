Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DAE7326A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 07:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbjFPFan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 01:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbjFPFa1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 01:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAAE2D6A;
        Thu, 15 Jun 2023 22:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CD561DA9;
        Fri, 16 Jun 2023 05:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6EF4C433C9;
        Fri, 16 Jun 2023 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686893423;
        bh=r4MmrsvbionKD2QAyPaftFnsfjcVFtcE4wKGX9A+nyg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rbNYM5iOqMZwA0fvSJKEHMPeMs+wOHMqX03lVuV5evWb2i2XECQKFLGniibVI3duN
         IDRY9QXhQMJDO+DCS8HUZX8xAZSLz7i+tanQTlnpTgMtU14oIT43oTJNCcVA1ra1fS
         U6RhX8GciNo+dzkPNx7ZlVizYl/mesE15VxoD4CQpfi8DHnYpXVN2Rs2J9zp9safBK
         jPOZRsxPgS79jGir7MfDyV5JLUFVqI1pKvJaI3RHEtrEi+AK++Qr7fHCPew2eD1p7p
         AwSOumVYrRQGyB1mFUb6FTjI2gOfMn/Y3NpFE4CTzilYmTj7+1K8By9HdWNQwVq1+F
         aZKJEosZCpOmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C50DCC3274B;
        Fri, 16 Jun 2023 05:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Check if FIPS mode is enabled when running selftests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168689342279.5522.4120374614331476094.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 05:30:22 +0000
References: <20230613123222.631897-1-magali.lemes@canonical.com>
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
To:     Magali Lemes <magali.lemes@canonical.com>
Cc:     davem@davemloft.net, dsahern@gmail.com, edumazet@google.com,
        keescook@chromium.org, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, tianjia.zhang@linux.alibaba.com,
        vfedorenko@novek.ru, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

On Tue, 13 Jun 2023 09:32:18 -0300 you wrote:
> Some test cases from net/tls, net/fcnal-test and net/vrf-xfrm-tests
> that rely on cryptographic functions to work and use non-compliant FIPS
> algorithms fail in FIPS mode.
> 
> In order to allow these tests to pass in a wider set of kernels,
>  - for net/tls, skip the test variants that use the ChaCha20-Poly1305
> and SM4 algorithms, when FIPS mode is enabled;
>  - for net/fcnal-test, skip the MD5 tests, when FIPS mode is enabled;
>  - for net/vrf-xfrm-tests, replace the algorithms that are not
> FIPS-compliant with compliant ones.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] selftests/harness: allow tests to be skipped during setup
    https://git.kernel.org/netdev/net/c/372b304c1e51
  - [v4,2/4] selftests: net: tls: check if FIPS mode is enabled
    https://git.kernel.org/netdev/net/c/d113c395c67b
  - [v4,3/4] selftests: net: vrf-xfrm-tests: change authentication and encryption algos
    https://git.kernel.org/netdev/net/c/cb43c60e64ca
  - [v4,4/4] selftests: net: fcnal-test: check if FIPS mode is enabled
    https://git.kernel.org/netdev/net/c/d7a2fc1437f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


