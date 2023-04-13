Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA516E0D79
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDMMag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDMMad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 08:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98379A5FF;
        Thu, 13 Apr 2023 05:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8DB663DD4;
        Thu, 13 Apr 2023 12:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17A28C433EF;
        Thu, 13 Apr 2023 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681389018;
        bh=dnK2Zkp6F6t3wIz82oZsMbcs6fURxNc2mBwr80iGrjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D0TetbdqW+deWWrRud3FVpWfoZEzAWK4MLn6MQR3i9SlGHrgCqMJB7Ai9hznayYj/
         sf183VagFuzC5pkMUOHhTad5ReuYz5rT3C5ckLBrjtlTIDQQ+lJ5sdACNvGLtKjllb
         Rocxez4El9kHJx9Z+qQ5l4IODw8J6ypZLPZ6KXZBWrVhczB+DlP3IBKOaEEGnFQ5Ro
         Z15FcEP2ly6jr4Ltv3VMZ9h8Zi6b0wDAhbbYsgiVPxj6F+3iGn0VXkuBuMYd0sHkpa
         HUkq6D4ll3eAi+Tofp2acRB9qUBE0vo3k5/3OV2ow8n9GHbhzwfSUnFLLb0/80hm7F
         h1bC32tBi2zCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECBA5C395C5;
        Thu, 13 Apr 2023 12:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix use of uninitialized op_name in
 log tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168138901796.10644.342994766666727920.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 12:30:17 +0000
References: <20230413094740.18041-1-lmb@isovalent.com>
In-Reply-To: <20230413094740.18041-1-lmb@isovalent.com>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Apr 2023 10:47:40 +0100 you wrote:
> One of the test assertions uses an uninitialized op_name, which leads
> to some headscratching if it fails. Use a string constant instead.
> 
> Fixes: b1a7a480a112 ("selftests/bpf: Add fixed vs rotating verifier log tests")
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verifier_log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix use of uninitialized op_name in log tests
    https://git.kernel.org/bpf/bpf-next/c/5a674611d116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


