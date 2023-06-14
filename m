Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07872F33C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjFNDu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbjFNDuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 23:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4C10FE
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 20:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC7B63D43
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 03:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1823EC433CC;
        Wed, 14 Jun 2023 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686714622;
        bh=kwMRYXkuWmggGRz82SguwJ3azvlmOneNI3FH5Meh8v0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MP42FaDDIweDOctj5xT06STy3N2pknfgzFIGzFgPEku9f9iSFZXWWK86xvn77bPr/
         Hvalo9LD6omM0y9uitiZc+dTA7gvY93w8oE1rwL+sLJdSEtqdWsPUMd1wgKxeITpuZ
         H0UaJ4MYQbg18oP9WzWhely0GLc3ZVOmyDFrUQ+zidsOjbbPXgClZ8szIJ6jen7F9J
         ledqlJ7PUT65ThEegjL6wCno/uMRS62JxA3BVyT9OzA80pKTEGQfHDAsTcDNNHq/+d
         FKdUg6NSFGEp1Oe0o5+W+Mj36CEwTctAtOOry22bU1frow7mWT5HBPcLlGhRVmzHkd
         P3POSnULeTuuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDBFFC2BBFC;
        Wed, 14 Jun 2023 03:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Fix small bugs and annoyances in tc-testing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168671462196.18215.15524979692740732010.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Jun 2023 03:50:21 +0000
References: <20230612075712.2861848-1-vladbu@nvidia.com>
In-Reply-To: <20230612075712.2861848-1-vladbu@nvidia.com>
To:     Vlad Buslov <vladbu@nvidia.com>
Cc:     pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
        shuah@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, marcelo.leitner@gmail.com,
        shaozhengchao@huawei.com, victor@mojatatu.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jun 2023 09:57:08 +0200 you wrote:
> Vlad Buslov (4):
>   selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.
>   selftests/tc-testing: Fix Error: failed to find target LOG
>   selftests/tc-testing: Fix SFB db test
>   selftests/tc-testing: Remove configs that no longer exist
> 
>  tools/testing/selftests/tc-testing/config                   | 6 +-----
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json | 4 ++--
>  tools/testing/selftests/tc-testing/tdc.sh                   | 1 +
>  3 files changed, 4 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net,1/4] selftests/tc-testing: Fix Error: Specified qdisc kind is unknown.
    https://git.kernel.org/netdev/net/c/aef6e908b542
  - [net,2/4] selftests/tc-testing: Fix Error: failed to find target LOG
    https://git.kernel.org/netdev/net/c/b849c566ee9c
  - [net,3/4] selftests/tc-testing: Fix SFB db test
    https://git.kernel.org/netdev/net/c/b39d8c41c7a8
  - [net,4/4] selftests/tc-testing: Remove configs that no longer exist
    https://git.kernel.org/netdev/net/c/11b8b2e70a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


