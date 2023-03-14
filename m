Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF226B8A19
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 06:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCNFKU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 01:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCNFKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 01:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615605D89A;
        Mon, 13 Mar 2023 22:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0EB615D5;
        Tue, 14 Mar 2023 05:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49675C4339C;
        Tue, 14 Mar 2023 05:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678770617;
        bh=cE5/+eBhcLUf6U82GCqGZsImd9QRoYP/wn3Bjv9SLKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oIMIAcokfBTRxAcX7A92g0WRno1tTK4xzA68iKpMQmvh2+6bmYlZ1JcC5PfwJ5Hm0
         CpzNxBa8gMsjcHbETRx38RCdm2sbsKVmnoijgHoS8Am+jN/d10wqZgIVgAi3QW3x77
         Nf5zBz2BzF4GCdLw1jl0yv9MM9aq/5CwasZ6uhrW0rxomVCdmjg75ThX1EcF23ru19
         RcEV9I/vt3fU7sGdyTQd3bWElKAIYOFmYbJQ536yYcJ32G8hNYTdh5waQnBqh+mqxZ
         5Q8q5+ahXvPfo1+84b0Z1efTkF3bOmSgz4W5bRcKkVlAUGz015U0tOthHdhSjClYPG
         aJL9ZMDScJ3Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C38DE66CB8;
        Tue, 14 Mar 2023 05:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: use canonical ftrace path
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167877061717.18868.4284758514562021959.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 05:10:17 +0000
References: <20230313205628.1058720-2-zwisler@kernel.org>
In-Reply-To: <20230313205628.1058720-2-zwisler@kernel.org>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, zwisler@google.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, haoluo@google.com,
        jgg@ziepe.ca, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, leon@kernel.org, mark.rutland@arm.com,
        martin.lau@linux.dev, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org, song@kernel.org, sdf@google.com,
        rostedt@goodmis.org, yhs@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mst@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Mar 2023 14:56:27 -0600 you wrote:
> From: Ross Zwisler <zwisler@google.com>
> 
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: use canonical ftrace path
    https://git.kernel.org/bpf/bpf-next/c/27d7fdf06fdb
  - [bpf-next,v4,2/2] selftests/bpf: use canonical ftrace path
    https://git.kernel.org/bpf/bpf-next/c/ab4c15feb2eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


