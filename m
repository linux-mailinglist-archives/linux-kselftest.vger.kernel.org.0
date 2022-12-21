Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5108652A6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 01:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiLUAUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Dec 2022 19:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiLUAUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Dec 2022 19:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16161D0F9;
        Tue, 20 Dec 2022 16:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58D76B81ACC;
        Wed, 21 Dec 2022 00:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A345C43398;
        Wed, 21 Dec 2022 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671582016;
        bh=NGZKT5JgyDeHmjzNMFLfbkZlWq0g+q9VEW8jP0w7yPg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JyYpZLGj2FQj9P1yo+uw+px1Amlbltt0JRMhEBqHp6OhD5kAdXzbjY6cLzN1gXXyX
         kBVEm+rKGuClw9R6gILdczQz8Sj1X8dDWvobRmhkdh/6rH3wWZ6NwEiF5qK6onOOd1
         b4+4C2nXXPqoo8A86kpywA9y/Cq+evx+uKSyLKYB5KnV+vIQFo2TNvfv0IlO67MiwI
         u/p8CCzKxwOk8u02WvEHkaveiPyYWFqIfmYuskCvmXK975ZwvZcBGrK+LSHykMCuq8
         yCgreYgUXG8gRinvhi5Bi/ZQyFYv3Dpqf+fSw9PETC1+nqQfV5ebLTITwc2eCors/6
         wR+8SbSA2+HbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7052C395E0;
        Wed, 21 Dec 2022 00:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] bpftool: improve error handing for missing .BTF
 section
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167158201594.10746.1700906742257656233.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Dec 2022 00:20:15 +0000
References: <20221217223509.88254-1-changbin.du@gmail.com>
In-Reply-To: <20221217223509.88254-1-changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, shuah@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mykolal@fb.com, linux-perf-users@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 18 Dec 2022 06:35:07 +0800 you wrote:
> Display error message for missing ".BTF" section and clean up empty
> vmlinux.h file.
> 
> v3:
>  - fix typo and make error message consistent. (Andrii Nakryiko)
>  - split out perf change.
> v2:
>  - remove vmlinux specific error info.
>  - use builtin target .DELETE_ON_ERROR: to delete empty vmlinux.h
> 
> [...]

Here is the summary with links:
  - [v3,1/2] libbpf: show error info about missing ".BTF" section
    https://git.kernel.org/bpf/bpf-next/c/e6b4e1d759d3
  - [v3,2/2] bpf: makefiles: do not generate empty vmlinux.h
    https://git.kernel.org/bpf/bpf-next/c/e7f0d5cdd023

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


