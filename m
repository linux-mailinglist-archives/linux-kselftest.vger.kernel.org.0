Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0900861A4DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKDWwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiKDWwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 18:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179543AD5;
        Fri,  4 Nov 2022 15:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919CB62361;
        Fri,  4 Nov 2022 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6731C433B5;
        Fri,  4 Nov 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667602215;
        bh=fA8aiQw4jlIUqRMgCixxIHpvXhT2q5L1pCsZsa7GlHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SKt18paJ4ZdIFIcISrUZw0+aMBrHjZsG4PXE9Kot4R2UvbX0CEAV1E3QOMyucc9LX
         XEjtCVhxPOlCsRS4LqaGvIMmCWGVACT7ApMFFdC/QEr9tvJ1ddlLm3yXLU1IjxZ/tn
         S2Ud9MsKhDG32E4T1xJVzWKacCaJwo9HtVy4jJeC/sqVRvMvoPNFXkevcXkEF8E1Nr
         0uij/MBvqgPt8X5akWiA33SRTkCPQqW7Q0x+dMTQPDL25UYwSELba1v9bY+xD4ZHto
         p94g9puUa10Mhl29znpS6h6fz3w426B60znQVNY6LCL2/9AsKfuOBEk7lrzcbhA4aq
         uyzGZWsEBB/dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA20E270FB;
        Fri,  4 Nov 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: cgroup_helpers.c: Fix strncpy()
 fortify warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166760221576.27361.8207434405001811248.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Nov 2022 22:50:15 +0000
References: <tencent_469D8AF32BD56816A29981BED06E96D22506@qq.com>
In-Reply-To: <tencent_469D8AF32BD56816A29981BED06E96D22506@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, david.laight@aculab.com,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  4 Nov 2022 09:27:54 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Copy libbpf_strlcpy() from libbpf_internal.h to bpf_util.h, and rename it
> to bpf_strlcpy(), then replace selftests strncpy()/libbpf_strlcpy() with
> bpf_strlcpy(), fix compile warning.
> 
> The libbpf_internal.h header cannot be used directly here, because
> references to cgroup_helpers.c in samples/bpf will generate compilation
> errors. We also can't add libbpf_strlcpy() directly to bpf_util.h,
> because the definition of libbpf_strlcpy() in libbpf_internal.h is
> duplicated. In order not to modify the libbpf code, add a new function
> bpf_strlcpy() to selftests bpf_util.h.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: cgroup_helpers.c: Fix strncpy() fortify warning
    https://git.kernel.org/bpf/bpf-next/c/b3c09fdca113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


