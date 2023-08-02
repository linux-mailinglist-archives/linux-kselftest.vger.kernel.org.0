Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6476D9BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHBVk0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHBVkZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E71BF6;
        Wed,  2 Aug 2023 14:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF7B61B32;
        Wed,  2 Aug 2023 21:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58895C433C7;
        Wed,  2 Aug 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012423;
        bh=NLSSRe4RVRV0fKoewTCaMcbMjSsMEN9rztajQMsWR2U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=esycnZjyO0VbjW17K3U6sGAkEzCF+dRNGe4hD+KeQ4ImP+IQhHmvmvZARPoH+XNXs
         MsCJMYgKdRrUTCV208xUdg08KulgKKbrc3fsyZTKZ1+1VEuE6r9kGDo0xwSDqnKdrj
         2qhT2/evFQwN6oEo35S4duyZOiZNfG10og3yRd++S4qFSVeIGPzG7m8Z96N6Tcmh3Q
         FiWvXpGSdxVML/QTjDej3Kyisy3yOvURBAqz//gfdCTSDKAb+Ct9u7hxHe7IwQl2Fl
         L4YNh9BYpo/1Kc1DmFQacYkWHxfXiM9osnaneUzRAmEhZUetyh8chL5LAJd9rTGXfs
         HN0lvuxv5kRbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37263E270D3;
        Wed,  2 Aug 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] bpf,
 xdp: Add tracepoint to xdp attaching failure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169101242321.7476.5572550064226640292.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:40:23 +0000
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
In-Reply-To: <20230801142621.7925-1-hffilwlqm@gmail.com>
To:     Leon Hwang <hffilwlqm@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hawk@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
        tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Aug 2023 22:26:19 +0800 you wrote:
> This series introduces a new tracepoint in bpf_xdp_link_attach(). By
> this tracepoint, error message will be captured when error happens in
> dev_xdp_attach(), e.g. invalid attaching flags.
> 
> v4 -> v5:
> * Initialise the extack variable.
> * Fix code style issue of variable declaration lines.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf, xdp: Add tracepoint to xdp attaching failure
    https://git.kernel.org/bpf/bpf-next/c/bf4ea1d0b2cb
  - [bpf-next,v5,2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
    https://git.kernel.org/bpf/bpf-next/c/7fedbf32fcc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


