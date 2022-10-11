Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82C75FA93D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJKAUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJKAUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 20:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD24B0E3;
        Mon, 10 Oct 2022 17:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D212161043;
        Tue, 11 Oct 2022 00:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39293C433D7;
        Tue, 11 Oct 2022 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665447616;
        bh=PsJJ3ZR/5MRXK24Jcz70uo1/GVeJuITGoeiOf0B9Ctg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DTRarO+k9MzB1M3ef0OeOLmdcEP5KNpvdXYA1bkpLRg017CAL7n0Ig8xcRiMiKpM0
         KPRXT5QU5Udy7KSkBypizI9yDKWy+lVfvDhz6FKs4UHT43rnFi6zGp0VF3PBktHagI
         lukP5UuXulNzHyUTiTKJnJQ5laopbyzkTy4zBHPgC68wrP/eRPMB7UVY9Omdl/xH6r
         JlJagEh412NYVQTUkSK1XisP/AG85jMsw355HpiKRP5fCzMGFNJp4rxl2PUJ1Amo6j
         P/4FlK1+WK2U710j9id0e5lrzI1oOciSavOXzU4TQhaw9YDkxO878MTySDi04UOkrr
         g8BFItNa+fYKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D07CE4D00E;
        Tue, 11 Oct 2022 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] Add _opts variant for bpf_*_get_fd_by_id()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166544761611.23458.18371986973168379467.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Oct 2022 00:20:16 +0000
References: <20221006110736.84253-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221006110736.84253-1-roberto.sassu@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com
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

On Thu,  6 Oct 2022 13:07:30 +0200 you wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the _opts variant for bpf_*_get_fd_by_id() functions, to be able to
> pass to the kernel more options, when requesting a fd of an eBPF object.
> 
> Pass the options through a newly introduced structure,
> bpf_get_fd_by_id_opts, which currently contains open_flags (the other two
> members are for compatibility and for padding).
> 
> [...]

Here is the summary with links:
  - [v2,1/6] libbpf: Fix LIBBPF_1.0.0 declaration in libbpf.map
    https://git.kernel.org/bpf/bpf-next/c/7a366da2d2ba
  - [v2,2/6] libbpf: Introduce bpf_get_fd_by_id_opts and bpf_map_get_fd_by_id_opts()
    https://git.kernel.org/bpf/bpf-next/c/243e300563b1
  - [v2,3/6] libbpf: Introduce bpf_prog_get_fd_by_id_opts()
    https://git.kernel.org/bpf/bpf-next/c/8f13f168ea14
  - [v2,4/6] libbpf: Introduce bpf_btf_get_fd_by_id_opts()
    https://git.kernel.org/bpf/bpf-next/c/2ce7cbf2ba71
  - [v2,5/6] libbpf: Introduce bpf_link_get_fd_by_id_opts()
    https://git.kernel.org/bpf/bpf-next/c/97c8f9dd5db8
  - [v2,6/6] selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()
    https://git.kernel.org/bpf/bpf-next/c/a9c7c18b5759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


