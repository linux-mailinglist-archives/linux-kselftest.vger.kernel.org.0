Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D86A4B86
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjB0TuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 14:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0TuV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 14:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75C23C6F;
        Mon, 27 Feb 2023 11:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4507BB80D9A;
        Mon, 27 Feb 2023 19:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6C8AC4339C;
        Mon, 27 Feb 2023 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677527417;
        bh=lKFcvEtIcSmjm5Rgotyf8NEeyKWAtt2iEvljqX6yX4M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j7VfAh5vjIUDzHs1dPVBU0Bvcagl3w7NtGpKOI6DjOVXt3vyFiEnpcxwSrcoEq8y1
         9kegsrJ2Qni3OoeuIdSRZt0yWAeVnbXcP1DQ9nvuvQkx8vHrsVa9gGEb8dlDXTIc9H
         MT/eDkol5xKm47LmvPwdfX1D2H85xX6DcM9h4cbvZ2YYRX/5a5tdjP/XG77dTNFWmb
         BUiCMu/J34Si7bUKg/SIzTenYF0H9t+x84hOWI73hyFAqbqfgKYNjG032XpSM9aSv3
         TVJglS2L0AtIOo9pO0Z6FqDsJxXVpzvaHOY7DucULULHNiUlK9wuz5DUHE0C3/hVKz
         gqNFTaR9ZYHEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DBA9E1CF31;
        Mon, 27 Feb 2023 19:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix compilation errors: assign a
 value to a constant
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167752741762.17622.17095700621282527889.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 19:50:17 +0000
References: <tencent_CB281722B3C1BD504C16CDE586CACC2BE706@qq.com>
In-Reply-To: <tencent_CB281722B3C1BD504C16CDE586CACC2BE706@qq.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 24 Feb 2023 23:10:02 +0800 you wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit bc292ab00f6c("mm: introduce vma->vm_flags wrapper functions")
> turns the vm_flags into a const variable.
> 
> Added bpf_find_vma test in commit f108662b27c9("selftests/bpf: Add tests
> for bpf_find_vma") to assign values to variables that declare const in
> find_vma_fail1.c programs, which is an error to the compiler and does not
> test BPF verifiers. It is better to replace 'const vm_flags_t vm_flags'
> with 'unsigned long vm_start' for testing.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix compilation errors: assign a value to a constant
    https://git.kernel.org/bpf/bpf-next/c/11e456cae91e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


