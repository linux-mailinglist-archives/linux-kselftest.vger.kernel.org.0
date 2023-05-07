Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236826F9520
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 May 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEGAAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 May 2023 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGAAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 May 2023 20:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43E14355;
        Sat,  6 May 2023 17:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 809C0612F2;
        Sun,  7 May 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7433C4339B;
        Sun,  7 May 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683417620;
        bh=EYWEM6o7wbF3/QheBJOmYtWD/MteDRvbuh7QTpPK59E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=URdPYTB2z1OAwWZ/wrLCR4k0ip7/HDClRnEeNJiqhWoGJUHpWHjxop6pg6ufzO4Yb
         FXp+987Z86hSUF61Qp57yM33F7I76sXbIEMXc2m1tpRY6qOzQA4xafNx3jCBPESNp7
         dAwMhnDoKjakok6GjJLFTdC/RIIcu+6wmi4xhkcgVcsGux1lMVonOSWzHqdwSaM4T0
         sO9cVCpHvrwkSsvJC5f8MewaH5yObiP1OnIUyYJc3Dy7NQ79vvLUARhWoGXqfh+wFQ
         ESlZB2+P9oNE3tqLoPz1NSlJXvJyOfzECBl/0TzXh1VoyHJFMzmQp2KMFgfh1PlyUq
         Am3H7/IJ8rnTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4ACBC395FD;
        Sun,  7 May 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] Dynptr Verifier Adjustments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168341762073.15595.436910654395923794.git-patchwork-notify@kernel.org>
Date:   Sun, 07 May 2023 00:00:20 +0000
References: <20230506013134.2492210-1-drosen@google.com>
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        corbet@lwn.net, joannelkoong@gmail.com, mykolal@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri,  5 May 2023 18:31:29 -0700 you wrote:
> These patches relax a few verifier requirements around dynptrs.
> Patches 1-3 are unchanged from v2, apart from rebasing
> Patch 4 is the same as in v1, see
> https://lore.kernel.org/bpf/CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com/
> Patch 5 adds a test for the change in Patch 4
> 
> Daniel Rosenberg (5):
>   bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
>   selftests/bpf: Test allowing NULL buffer in dynptr slice
>   selftests/bpf: Check overflow in optional buffer
>   bpf: verifier: Accept dynptr mem as mem in helpers
>   selftests/bpf: Accept mem from dynptr in helper funcs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
    https://git.kernel.org/bpf/bpf-next/c/3bda08b63670
  - [bpf-next,v3,2/5] selftests/bpf: Test allowing NULL buffer in dynptr slice
    https://git.kernel.org/bpf/bpf-next/c/1ce33b6c846f
  - [bpf-next,v3,3/5] selftests/bpf: Check overflow in optional buffer
    https://git.kernel.org/bpf/bpf-next/c/3881fdfed21f
  - [bpf-next,v3,4/5] bpf: verifier: Accept dynptr mem as mem in helpers
    https://git.kernel.org/bpf/bpf-next/c/2012c867c800
  - [bpf-next,v3,5/5] selftests/bpf: Accept mem from dynptr in helper funcs
    https://git.kernel.org/bpf/bpf-next/c/798e48fc28fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


