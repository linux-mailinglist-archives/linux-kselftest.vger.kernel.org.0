Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AFB72A2D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFITIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFITIs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 15:08:48 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98D3592
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 12:08:44 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5D694880E86
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 19:08:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E032F880438
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 19:08:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686337723; a=rsa-sha256;
        cv=none;
        b=ay6dyk2EbmN+LgJNHq+rDdQAqlAb/Ku+95YEnUFMbcxnRblGmHtVB7ejvABUzbD5TYcYjH
        AIKQcXrH833K/6Vf4+iC3vWNQwEefKBa/EJZAQv+g3E6uHTa6Vq2FmP2Rg3SQ/HnojnR17
        qrO14PevN7cpvItvbq8a2/wsfgjhegFMWkF1cNszywhW+/33XtKaC79voa7CBgGOZ26Mg0
        0MlhRbrpsD2Fm87hPBeWFAwl77h97xPDlc2jLtEm1aWVZFCb3n7Z1OdGGQQIVooAQoi3rI
        7gzyqvH+erHOZhCWVH7agVw/Kl/w4wsntlUa3fLJROO21MXw55l9/GLc6zu1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686337723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2nNow2I8rLN3tJXCsR747RgqkV/4isKDgV+FcS8d6j8=;
        b=zClrJBzRueeyN3FJ3srlYnvszsZAWam4tTq6eVGSwIyphfuBcYcP2Ae9vticliOrXYShFl
        ++bQBvuVHSLfTKsdrlcp2ce3se07LA4PGwtRYQ3rF0GrEBQQv6rxK20Nj1DXjke4rkizKm
        5xyrL1K8Rs7m6f+eCSVlIilYrrRyU73XVd5Ml0jro/F9KfEGaUTkMkIiyNRyR25QWXU6il
        qMKdh2aPiubljWgihyZlipFYXwrh3ugh2MWwAVBGzTDq9LMR07lFBehdS0ERryi9MZmQNx
        j16VzbjkUlvyhHWITj2kIqFjnRyNDo61b5FJLxWx39Q1XHFf6Um/96mTev9q0g==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-f796t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Illegal: 3eed74e465a6354e_1686337724154_3337885336
X-MC-Loop-Signature: 1686337724154:3216176774
X-MC-Ingress-Time: 1686337724154
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.17 (trex/6.8.1);
        Fri, 09 Jun 2023 19:08:44 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4Qd9bb1FT8zf1
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686337723;
        bh=2nNow2I8rLN3tJXCsR747RgqkV/4isKDgV+FcS8d6j8=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=KZ8kwd5ujdrmc6Lh0F4xmEJZg729c3yoWrDOSTNwQYh8LnSw3C/1otscsorjI7moO
         +nnF3+osvg+el56tgjXW7fkXHR+T5Toxh+EYUZhKXGWa+LKBtGawadToqLYOhgrWj3
         wX2FuYhfz7GmmSPw/tEkh9vvRVfFUrzslvNvyIO4=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 12:08:42 -0700
Date:   Fri, 9 Jun 2023 12:08:42 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram
 extables
Message-ID: <20230609190842.GA2012@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
 <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
 <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 09, 2023 at 11:15:18AM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 8, 2023 at 5:11 PM Krister Johansen <kjlx@templeofstupid.com> wrote:
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> > +{
> > +       *(volatile long *)ret;
> > +       *(volatile int *)&ret->f_mode;
> > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > +       return 0;
> > +}
> > +
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
> > +{
> > +       *(volatile long *)ret;
> > +       *(volatile int *)&ret->f_mode;
> > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > +       return 0;
> > +}
> > +
> > +SEC("fexit/bpf_testmod_return_ptr")
> > +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
> > +{
> > +       *(volatile long *)ret;
> > +       *(volatile int *)&ret->f_mode;
> > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > +       return 0;
> > +}
> 
> What is the point of attaching 3 the same progs to the same hook?
> One would be enough to test it, no?

I thought so too, initially.  However, when I went to move this from the
original test case I submitted to the selftest, I found it was fairly
inconsistent about reproducing the problem with a single program.  I
believe this is because the kallsyms are stored in a binary tree, and
the prog and func[0] are identical.  Depending on where the item is
placed, the func[0] with the extable can sometimes be looked up instead
of the prog without.

Yonghong requested that I make note of this in the patch commit message.
I'll make sure that's included in the next version I send out.

> In other news...
> Looks like this test is triggering a bug on s390.

Not sure if this is worth mentioning, but when I run with
panic_on_oops=0 to capture the stack, I'm seeing some additional
warnings that follow the bpf bug.  Is any of this of interest?

   BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1132, name: test_progs
   preempt_count: 0, expected: 0
   RCU nest depth: 2, expected: 0
   INFO: lockdep is turned off.
   CPU: 0 PID: 1132 Comm: test_progs Tainted: G      D    OE      6.4.0-rc3+ #2
   Call Trace:
    <TASK>
    dump_stack_lvl+0x63/0x90
    dump_stack+0x14/0x20
    __might_resched+0x21d/0x230
    __might_sleep+0x45/0x70
    exit_signals+0x35/0x200
    do_exit+0xc6/0x920
    ? rewind_stack_and_make_dead+0x17/0x20
    ? make_task_dead+0xbe/0x140
    ? make_task_dead+0xbe/0x140
    make_task_dead+0x88/0x140
    rewind_stack_and_make_dead+0x17/0x20
   RIP: 0033:0x7fb5da00a392
   Code: ac 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb be 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
   RSP: 002b:00007ffc5b3cab68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
   RAX: ffffffffffffffda RBX: 000055bee7b8b100 RCX: 00007fb5da00a392
   RDX: 00000000000001c8 RSI: 0000000000000000 RDI: 0000000000000009
   RBP: 00007ffc5b3caba0 R08: 0000000000000000 R09: 0000000000000037
   R10: 000055bee7b8c2a7 R11: 0000000000000246 R12: 000055bee78f1f60
   R13: 00007ffc5b3cae90 R14: 0000000000000000 R15: 0000000000000000
    </TASK>
   ------------[ cut here ]------------
   Voluntary context switch within RCU read-side critical section!
   WARNING: CPU: 0 PID: 1132 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x4c0/0x5f0
   Modules linked in: bpf_testmod(OE) nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common intel_uncore_frequency_common ppdev nfit crct10dif_pclmul crc32_pclmul psmouse ghash_clmulni_intel sha512_ssse3 aesni_intel parport_pc crypto_simd cryptd input_leds parport rapl ena i2c_piix4 mac_hid serio_raw ramoops reed_solomon pstore_blk drm pstore_zone efi_pstore autofs4 [last unloaded: bpf_testmod(OE)]
   CPU: 0 PID: 1132 Comm: test_progs Tainted: G      D W  OE      6.4.0-rc3+ #2
   RIP: 0010:rcu_note_context_switch+0x4c0/0x5f0
   Code: fb ff ff 0f 0b e9 e0 fb ff ff e8 4b dd e3 ff a8 04 75 b5 0f 0b eb b1 c6 05 e4 03 a4 02 01 48 c7 c7 45 4a a1 ab e8 c0 e2 f1 ff <0f> 0b e9 f7 fb ff ff 0f 0b 45 84 f6 0f 84 d6 fb ff ff e9 e7 fb ff
   RSP: 0018:ffffb30c4291f9a8 EFLAGS: 00010046
   RAX: 4599311900096300 RBX: ffff92e644bf2a40 RCX: 0000000000000027
   RDX: 0000000000000000 RSI: ffffb30c4291f830 RDI: ffff92e95ee21948
   RBP: ffffb30c4291f9f8 R08: 0000000000000000 R09: ffffb30c4291f7d0
   R10: 00000000fffeffff R11: c0000000fffeffff R12: ffff92e95ee36680
   R13: ffffb30c4291fc58 R14: 0000000000000000 R15: 0000000000000000
   FS:  0000000000000000(0000) GS:ffff92e95ee00000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000000000000000c CR3: 000000000d25e001 CR4: 00000000007706f0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   PKRU: 55555554
   Call Trace:
    <TASK>
    ? lock_release+0x46/0x330
    __schedule+0x173/0x1730
    ? trace_hardirqs_on+0x56/0xb0
    ? irqentry_exit+0x72/0xa0
    ? sysvec_irq_work+0x4a/0x90
    ? asm_sysvec_irq_work+0x1f/0x30
    schedule+0x6f/0xc0
    schedule_timeout+0x35/0x110
    ? native_write_msr+0xe/0x40
    ? __pfx_schedule_timeout+0x10/0x10
    ? trace_hardirqs_on+0x56/0xb0
    ? __pfx_schedule_timeout+0x10/0x10
    do_wait_for_common+0xe9/0x170
    ? __pfx_schedule_timeout+0x10/0x10
    ? __pfx_call_rcu+0x10/0x10
    wait_for_completion+0x53/0x70
    __wait_rcu_gp+0x12f/0x150
    synchronize_rcu_tasks_rude+0x67/0xc0
    ? __pfx_wakeme_after_rcu+0x10/0x10
    ? mutex_unlock+0x16/0x20
    ? __pfx_call_rcu_tasks_rude+0x10/0x10
    ftrace_shutdown+0x1ea/0x290
    ? 0xffffffffc04b8000
    unregister_ftrace_function+0x30/0x190
    ? 0xffffffffc04b8000
    ? 0xffffffffc04b8000
    unregister_ftrace_direct+0x51/0xf0
    ? __pfx_bpf_testmod_return_ptr+0x10/0x10 [bpf_testmod]
    ? 0xffffffffc04b8000
    bpf_trampoline_update+0x273/0x6d0
    bpf_trampoline_unlink_prog+0xb4/0x110
    bpf_tracing_link_release+0x1d/0x50
    bpf_link_put+0xd0/0x100
    bpf_link_release+0x19/0x30
    __fput+0x107/0x250
    ____fput+0x12/0x20
    task_work_run+0x89/0xd0
    do_exit+0x263/0x920
    ? make_task_dead+0xbe/0x140
    ? make_task_dead+0xbe/0x140
    make_task_dead+0x88/0x140
    rewind_stack_and_make_dead+0x17/0x20
   RIP: 0033:0x7fb5da00a392
   Code: Unable to access opcode bytes at 0x7fb5da00a368.
   RSP: 002b:00007ffc5b3cab68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
   RAX: ffffffffffffffda RBX: 000055bee7b8b100 RCX: 00007fb5da00a392
   RDX: 00000000000001c8 RSI: 0000000000000000 RDI: 0000000000000009
   RBP: 00007ffc5b3caba0 R08: 0000000000000000 R09: 0000000000000037
   R10: 000055bee7b8c2a7 R11: 0000000000000246 R12: 000055bee78f1f60
   R13: 00007ffc5b3cae90 R14: 0000000000000000 R15: 0000000000000000
    </TASK>
   irq event stamp: 62970
   hardirqs last  enabled at (62969): [<ffffffffab1e14ba>] syscall_enter_from_user_mode+0x2a/0x1e0
   hardirqs last disabled at (62970): [<ffffffffab1e0bb1>] exc_page_fault+0x41/0x210
   softirqs last  enabled at (62912): [<ffffffffaa2e2ae2>] bpf_link_settle+0x32/0x50
   softirqs last disabled at (62910): [<ffffffffaa2e2acd>] bpf_link_settle+0x1d/0x50
   ---[ end trace 0000000000000000 ]---

-K
