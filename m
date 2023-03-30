Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789546CF840
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 02:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjC3AaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC3AaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 20:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED755A5;
        Wed, 29 Mar 2023 17:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0BB8B8256D;
        Thu, 30 Mar 2023 00:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99EF3C433EF;
        Thu, 30 Mar 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680136220;
        bh=rYX5KrGsN2FXZ+mvHlfw+uaOveTqSbav54tP5gyv0B0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aVUH+kQqbokoHdH1r85mEZ8vn1DpOLT4U6nrZg3iSnVSVCOpl2K1yv37t1OCdzuWk
         r382aBtAfbeVvdimdeKXnz0RuqFSCWtl1NPHxVfH5Wck+mbIkETY053V2QA2CPe+Ag
         o5kpNvFphmvhJzMnpvexdnC6oa9mr1eGMrY/kV2Ch4fiMyjbNX0ZxAAC2+rdD+OG9m
         pGfoHFGz09Q3vH09sYze+I2bq4F3mxp+LEaEXJwRG34A9A9+zlmCNP5ASzCdQ5FJJv
         ctO1ISiASiPWVCHf+CLW5CmPHhXH7Zrd2qxPjCP48FxAvjaMo7weFiQd5f+wOEFa/A
         pBF+eq5MfZHug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79480E50D76;
        Thu, 30 Mar 2023 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Rewrite two infinite loops in
 bound check cases
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168013622048.690.18146519678649692656.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 00:30:20 +0000
References: <20230329011048.1721937-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230329011048.1721937-1-xukuohai@huaweicloud.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 Mar 2023 21:10:48 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> The two infinite loops in bound check cases added by commit
> 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
> increased the execution time of test_verifier from about 6 seconds to
> about 9 seconds. Rewrite these two infinite loops to finite loops to get
> rid of this extra time cost.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Rewrite two infinite loops in bound check cases
    https://git.kernel.org/bpf/bpf-next/c/4ca13d1002f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


