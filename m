Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1C7DBE2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjJ3Qm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjJ3Qm2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 12:42:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F539E;
        Mon, 30 Oct 2023 09:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002DEC433C8;
        Mon, 30 Oct 2023 16:42:24 +0000 (UTC)
Date:   Mon, 30 Oct 2023 12:42:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Mark Brown <broonie@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: selftests: user_events: ftrace_test - RIP:
 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
Message-ID: <20231030124223.4e4ddeb8@gandalf.local.home>
In-Reply-To: <20231030163102.GA1853-beaub@linux.microsoft.com>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
        <20231027192011.GA436-beaub@linux.microsoft.com>
        <20231027183640.2529ab68@gandalf.local.home>
        <20231027223344.3854ac1f@rorschach.local.home>
        <20231030163102.GA1853-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 30 Oct 2023 09:31:02 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> I applied both [1][2] patches, and I no longer get any panics. However,

Great! Can I add "Tested-by" from you on those patches?

> I still get the splat about the trace_array_put when running
> user_event's ftrace selftest:
> 
> [   26.665931] ------------[ cut here ]------------
> [   26.666663] WARNING: CPU: 12 PID: 291 at kernel/trace/trace.c:516 tracing_release_file_tr+0x46/0x50
> [   26.667470] Modules linked in:
> [   26.667808] CPU: 12 PID: 291 Comm: ftrace_test Not tainted 6.6.0-rc7-next-20231026 #3
> [   26.668665] RIP: 0010:tracing_release_file_tr+0x46/0x50
> [   26.669093] Code: d1 03 01 8b 83 c0 1e 00 00 85 c0 74 1d 83 e8 01 48 c7 c7 80 5b ef bc 89 83 c0 1e 00 00 e8 f2 b5 03 01 31 c0 5b e9 75 ee 27 01 <0f> 0b eb df 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
> [   26.670580] RSP: 0018:ffffb6ef858ffee8 EFLAGS: 00010246
> [   26.671128] RAX: 0000000000000000 RBX: ffff9d7ae2364058 RCX: 0000000000000000
> [   26.671793] RDX: 0000000000000000 RSI: ffffffffbcb6b38b RDI: 00000000ffffffff
> [   26.672444] RBP: ffff9d7ac3e72200 R08: 0000000000000000 R09: 0000000000000000
> [   26.673072] R10: ffffb6ef858ffee8 R11: ffffffffbb28526f R12: 00000000000f801f
> [   26.673705] R13: ffff9d7b661a2020 R14: ffff9d7ac6057728 R15: 0000000000000000
> [   26.674339] FS:  00007fa852fa6740(0000) GS:ffff9d81a6300000(0000) knlGS:0000000000000000
> [   26.674978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.675506] CR2: 00007fa852c2a250 CR3: 0000000105d92001 CR4: 0000000000370eb0
> [   26.676142] Call Trace:
> [   26.676357]  <TASK>
> [   26.676572]  ? __warn+0x7f/0x160
> [   26.677092]  ? tracing_release_file_tr+0x46/0x50
> [   26.677540]  ? report_bug+0x1c3/0x1d0
> [   26.677871]  ? handle_bug+0x3c/0x70
> [   26.678196]  ? exc_invalid_op+0x14/0x70
> [   26.678520]  ? asm_exc_invalid_op+0x16/0x20
> [   26.678845]  ? tracing_release_file_tr+0x1f/0x50
> [   26.679268]  ? tracing_release_file_tr+0x46/0x50
> [   26.679691]  ? tracing_release_file_tr+0x1f/0x50
> [   26.680105]  __fput+0xab/0x300
> [   26.680437]  __x64_sys_close+0x38/0x80

Hmm, this doesn't tell me much. Let me go play with the user_event self
tests.

Thanks Beau!

-- Steve


> [   26.680757]  do_syscall_64+0x41/0xf0
> [   26.681329]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   26.681784] RIP: 0033:0x7fa852d15157
> [   26.682126] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 83 b8 f7 ff
> [   26.684255] RSP: 002b:00007ffd226914f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [   26.684939] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa852d15157
> [   26.685602] RDX: 0000000000000002 RSI: 0000560ad54567d4 RDI: 0000000000000005
> [   26.686257] RBP: 00007ffd22691520 R08: 0000000000000000 R09: 00007fa852fa6740
> [   26.686877] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd22691758
> [   26.687480] R13: 0000560ad5455ae7 R14: 0000560ad5458c38 R15: 00007fa8530d4040
> [   26.688107]  </TASK>
> [   26.688315] irq event stamp: 1361
> [   26.688618] hardirqs last  enabled at (1369): [<ffffffffbb1d7f49>] console_unlock+0x109/0x130
> [   26.689339] hardirqs last disabled at (1376): [<ffffffffbb1d7f2e>] console_unlock+0xee/0x130
> [   26.690062] softirqs last  enabled at (1272): [<ffffffffbb14ba2a>] irq_exit_rcu+0x8a/0xe0
> [   26.690774] softirqs last disabled at (1267): [<ffffffffbb14ba2a>] irq_exit_rcu+0x8a/0xe0
> [   26.691620] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> -Beau
> 
> 1. https://lore.kernel.org/linux-trace-kernel/20231030115018.25399dbd@gandalf.local.home/
> 2. https://lore.kernel.org/linux-trace-kernel/20231028164650.4f5ea18a@rorschach.local.home/

