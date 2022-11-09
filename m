Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF66623550
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 22:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIVBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 16:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKIVBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 16:01:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFB31DC4;
        Wed,  9 Nov 2022 13:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 346E361CF3;
        Wed,  9 Nov 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77E90C433D6;
        Wed,  9 Nov 2022 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668027615;
        bh=YnYnG33WUJGPL+XZx0SlUCTlC7LDUUGpSuhxT4Cxz7s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XEWi6q9l/eyzfk+IIUzt6Gfz8EKp3r7UmjiUHfmVj5mSucQPZl22DK2nMS7OrCEYC
         +7smGYnD5syCjO3LkCONt+0UfESXziwJQ0ST5u9HNmAepF5bEE7PLOsG14rLc8YHqH
         htFPCbkxAUo1w6YpMXaIZqWl2MpuagRV7TMjhO76J/qBukmNALDikDbgbS/4IU+jLM
         t8MJKT1YjJQ+d+8woke7cjRlOlYoVol6j5eegtVCIxXV5nwR7NHz9JGn1dHlRK48x4
         aLw6eui6LSiIqmrdn0TIg+FbZMySmD3NV5WPS8M93dsRxg0CC0EzxKV36FHEqGIii2
         DnVXpBObqhejA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A9FC395F6;
        Wed,  9 Nov 2022 21:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix test_progs compilation failure in 32-bit
 arch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166802761535.23951.11996164309163589980.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Nov 2022 21:00:15 +0000
References: <20221108015857.132457-1-yangjihong1@huawei.com>
In-Reply-To: <20221108015857.132457-1-yangjihong1@huawei.com>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, sunyucong@gmail.com, bpf@vger.kernel.org,
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

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 8 Nov 2022 09:58:57 +0800 you wrote:
> test_progs fails to be compiled in the 32-bit arch, log is as follows:
> 
>   test_progs.c:1013:52: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1013 |                 sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
>         |                                                  ~~^
>         |                                                    |
>         |                                                    long int
>         |                                                  %d
>    1014 |                         strlen(msg->test_log.log_buf),
>         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                         |
>         |                         size_t {aka unsigned int}
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix test_progs compilation failure in 32-bit arch
    https://git.kernel.org/bpf/bpf/c/5704bc7e8991

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


