Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725CD77BE60
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHNQum (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjHNQuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 12:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165DD2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 09:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710BF63996
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D57C433C8;
        Mon, 14 Aug 2023 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692031821;
        bh=gSw/rfK9rDCtWo7WJkWyrukDQU0jwq/A2F5w8MfrBus=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O9McTadFqOMin6HMc6AShKjk8QWnWyoSYH7Cw+jVgrkCQxS4LhyRZI/Gtewddlkag
         HqD3zUmESWc+BL9NiNCDDoZ/LqDDGZoezSK4B9cpzJnOuHtjfj7JX8+ZQ9jF4EaKkM
         I52kUB4h4zXQQOT6GPhdHqSCmK0mdqnan1utbBa/JhaPnBK7R7Qu6K4In4LkE/l8sn
         FXOOOgNGUJOP49CMUfq/7eto5vZCdsHLZabeMHA8p0sl0JiyD0s23bjtIVpuVG6h2p
         U6retJlTW5cVxn3SQ9eKyGtezSp1P2arXo0gjECIOdlyXml/WueaI5OTfTJDpe7GcD
         +TU6FyDfBoVEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A55F7E93B37;
        Mon, 14 Aug 2023 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test
 script
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169203182167.3806.17645689182437041748.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 16:50:21 +0000
References: <20230814030727.3010390-1-zouyipeng@huawei.com>
In-Reply-To: <20230814030727.3010390-1-zouyipeng@huawei.com>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.ne, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, toke@redhat.com
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

On Mon, 14 Aug 2023 11:07:27 +0800 you wrote:
> [root@localhost bpf]# ./benchs/run_bench_rename.sh
> base      :    0.819 ± 0.012M/s
> kprobe    :    0.538 ± 0.009M/s
> kretprobe :    0.503 ± 0.004M/s
> rawtp     :    0.779 ± 0.020M/s
> fentry    :    0.726 ± 0.007M/s
> fexit     :    0.691 ± 0.007M/s
> benchmark 'rename-fmodret' not found
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test script
    https://git.kernel.org/bpf/bpf-next/c/83a89c4b6ae9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


