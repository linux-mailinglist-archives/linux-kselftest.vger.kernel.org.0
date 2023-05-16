Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738C704FB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjEPNpA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjEPNo7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 09:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA0527D;
        Tue, 16 May 2023 06:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A207962D8A;
        Tue, 16 May 2023 13:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F690C433EF;
        Tue, 16 May 2023 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684244695;
        bh=Kc4UDWZqFktIdi1DCD/O416Zm6tX8Fx011gBD1KfKa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrfgKMIa0swCsAsINez8dyJNlienqHZK/6EYJUaA4nsToQQMDD9jA1cS95X3NZnlr
         VA2/HT3tP84uoZB2oHU5TTVnzV681cuc9MM7M0Kdc5ELMlJV0tiuyS4s4RMkZYHmGZ
         1qfLlBDjb3NBd2gwKLvgoF21jyTwAYZOpM3tQtf+XmtUtS+/8KD8La+7tPaQqNt7A7
         +DX36S5C2UmXEG+R9Zh1opi0gV2XK8eprI74qL4UbY4RairVTa0xAeBga4gpXVn79L
         O8Sqyr7GTdNoWTMY3futkvbcetWv44WLGr95vj/nbj62ba6PffUmrgNcsFgZKdGcOs
         3t9JjmQy7WlfA==
Date:   Tue, 16 May 2023 14:44:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, broonie@kernel.org
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <20230516134447.GB30894@willie-the-truck>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Naresh,

On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> Following kernel BUG noticed while running selftests arm64 fp-stress
> running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.

Is there a known-good build so that we could attempt a bisection?

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> # selftests: arm64: fp-stress
> # TAP version 13
> # 1..80
> # # 8 CPUs, 3 SVE VLs, 3 SME VLs, SME2 absent
> # # Will run for 10s
> ...
> 
> # # ZA-VL-32-4: PID: 1091
> # # [  263.834190]
> ==================================================================
> [  263.834270] BUG: KFENCE: memory corruption in fpsimd_release_task+0x28/0x50
> [  263.834270]
> ZA-V[  263.834419] Corrupted memory at 0x00000000d9c0a375 [ ! ! ! ! !
> ! . . . . . . . . . . ] (in kfence-#158):
> L-64-[  263.834929]  fpsimd_release_task+0x28/0x50
> [  263.835074]  arch_release_task_struct+0x1c/0x30
> [  263.835221]  __put_task_struct+0x164/0x220
> [  263.835336]  delayed_put_task_struct+0x60/0x128
> 4: [  263.835484]  rcu_core+0x318/0x950
> [  263.835632]  rcu_core_si+0x1c/0x30
> [  263.835770]  __do_softirq+0x110/0x3d8
> Stre[  263.835874]  run_ksoftirqd+0x40/0xe0
> [  263.835994]  smpboot_thread_fn+0x1d0/0x260
> [  263.836105]  kthread+0xec/0x190
> [  263.836221]  ret_from_fork+0x10/0x20
> [  263.836342]
> ami[  263.836393] kfence-#158: 0x00000000c8819329-0x000000009e00cc22,
> size=546, cache=kmalloc-1k
> [  263.836393]
> [  263.836527] allocated by task 1112 on cpu 5 at 252.422888s:
> [  263.836697]  do_sme_acc+0xa8/0x230
> ng m[  263.836821]  el0_sme_acc+0x40/0xa0
> [  263.836966]  el0t_64_sync_handler+0xa8/0xf0
> [  263.837114]  el0t_64_sync+0x190/0x198

Mark -- given that this is an SME allocation, please can you take a look?
I think the implication of the kfence report is that we're writing beyond
the end of 'task->thread.sme_state' at some point and corrupting the
redzone.

There are two reports here, so hopefully it's not too hard to repro.

Will
