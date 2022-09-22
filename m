Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE2D5E57CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIVBK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIVBKY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8535DFD0;
        Wed, 21 Sep 2022 18:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83493B83392;
        Thu, 22 Sep 2022 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20EC3C433D6;
        Thu, 22 Sep 2022 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809020;
        bh=nqwrahPpEmqU9hoaAGBy+tCno5ccXCf26SD5Ui4kgPM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jePXvIRYDT0m7r4OsYVfB2YAEaLMQrqxgMi/n8LO3QgVR1KvV+lb2vAy4Otn62VUp
         qUtTjZGbCS7by8bmqNxSKFxAWwJZ8Pmgj0zbGNin/4raaK/7Yx+AE3l4gaZ/QRqM5s
         Aet8Wn9fnlmW4+BSrrUki7NAlq0zwenepZIbtTNVWcM0a0i6Di/jEfB/+pWN3GPGuQ
         JWA7IN0w0DZ8v/WXTNLoxabMFskk4o9QEdSwEPO1hbX4ahxKXjoJyUOeGfxx+J5F6B
         oRFJZxTkui2E86fATwbXo4LpGqQsNrTXwTL/xcyNycESxvYVH7Fiptz68Uj8Obb242
         iqGFZSOONILhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0B21E4D03F;
        Thu, 22 Sep 2022 01:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v18 02/13] btf: Export bpf_dynptr definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380901998.22214.18015919305656352830.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:19 +0000
References: <20220919142754.626564-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220919142754.626564-1-roberto.sassu@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jarkko@kernel.org, jmorris@namei.org,
        joannelkoong@gmail.com, john.fastabend@gmail.com, jolsa@kernel.org,
        keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com, rostedt@goodmis.org,
        sdf@google.com, serge@hallyn.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
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
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Sep 2022 16:27:54 +0200 you wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> eBPF dynamic pointers is a new feature recently added to upstream. It binds
> together a pointer to a memory area and its size. The internal kernel
> structure bpf_dynptr_kern is not accessible by eBPF programs in user space.
> They instead see bpf_dynptr, which is then translated to the internal
> kernel structure by the eBPF verifier.
> 
> [...]

Here is the summary with links:
  - [v18,02/13] btf: Export bpf_dynptr definition
    https://git.kernel.org/bpf/bpf-next/c/00f146413ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


