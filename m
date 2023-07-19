Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA9759BB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGSRA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGSRAZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 13:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4831733;
        Wed, 19 Jul 2023 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99298617AF;
        Wed, 19 Jul 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA02C433C9;
        Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689786022;
        bh=jDn5IGHs7brrjKaFQgz63KV3eL86oT3xJ5oW4yJx5qg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vOb4sVElmfjTaUnC9i43y3lWwIrGj82pz3mD3n2TmGJ9Pqp+DWvlwObmgTp0d23jr
         nmoqi+c/4J9g50qgosDegUBmM59VXC7ye/mGQZ/hZ1leAmpkGSYqNpfpRJdH7b45jy
         HCbtuSLJDhTsZKDQSXzbQ91Bx46xhzApX3WRt4cK5kkp1NVOr5HuXgiGtkAjuEnLzc
         RYHsXY0K3/wq2hnvmytR1gam7UoUfFQ4sMGuIdE7Msd980MfEdZ2+GfLET4GGrmQmG
         hYUY45pN5IC1YjFD289Aed2wOSZ/CkQlZ8zTTZuxtMZl+V0mrqRGeVaBMHZfqzW6Hf
         eAQj/nme+e4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9787FE22AE1;
        Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] allow bpf_map_sum_elem_count for all program
 types
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168978602261.22183.7368489912510631673.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 17:00:22 +0000
References: <20230719092952.41202-1-aspsk@isovalent.com>
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, houtao1@huawei.com, joe@isovalent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 09:29:48 +0000 you wrote:
> This series is a follow up to the recent change [1] which added
> per-cpu insert/delete statistics for maps. The bpf_map_sum_elem_count
> kfunc presented in the original series was only available to tracing
> programs, so let's make it available to all.
> 
> The first patch makes types listed in the reg2btf_ids[] array to be
> considered trusted by kfuncs.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: consider types listed in reg2btf_ids as trusted
    https://git.kernel.org/bpf/bpf-next/c/831deb2976de
  - [v2,bpf-next,2/4] bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
    https://git.kernel.org/bpf/bpf-next/c/5ba190c29cf9
  - [v2,bpf-next,3/4] bpf: make an argument const in the bpf_map_sum_elem_count kfunc
    https://git.kernel.org/bpf/bpf-next/c/9c29804961c1
  - [v2,bpf-next,4/4] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
    https://git.kernel.org/bpf/bpf-next/c/72829b1c1f16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


