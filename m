Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CE792E0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjIES7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjIES7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 14:59:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EDE1B6;
        Tue,  5 Sep 2023 11:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16D23CE128B;
        Tue,  5 Sep 2023 16:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F9C433C7;
        Tue,  5 Sep 2023 16:24:42 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:25:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-ID: <20230905122500.700c75ec@gandalf.local.home>
In-Reply-To: <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
        <20230710183741.78f04c68@gandalf.local.home>
        <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 5 Sep 2023 20:54:40 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Hi, Steve, Ajay,
> 
> After this patch and run this testcase, I got an use-after-free report
> by KASAN. Short log see [1], full logs see attach "panic.log".
> 
> And by simple bisect, I found it may be introduced by:
> 
>    27152bceea1d ("eventfs: Move tracing/events to eventfs")
> 
> Link: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
> 
> [1]
> # ./ftracetest test.d/instances/instance-event.tc
> === Ftrace unit tests ===
> [1] Test creation and deletion of trace instances while setting an 
> event[   89.472397] 
> ==================================================================
> [   89.475053] BUG: KASAN: slab-use-after-free in 
> __ftrace_event_enable_disable+0x1b/0x3a0
> [   89.480039] Read of size 8 at addr ffff88814f5b2690 by task 
> ftracetest/392
> [   89.483906]
> [   89.484560] CPU: 10 PID: 392 Comm: ftracetest Tainted: G        W 
>       6.5.0+ #127
> [   89.487033] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   89.489751] Call Trace:
> [   89.490315]  <TASK>
> [   89.490817]  dump_stack_lvl+0x4b/0x80
> [   89.491570]  print_report+0xd0/0x620
> [   89.492296]  ? __virt_addr_valid+0xf9/0x180
> [   89.493134]  ? __ftrace_event_enable_disable+0x1b/0x3a0
> [   89.494151]  kasan_report+0xb6/0xf0
> [   89.494881]  ? __ftrace_event_enable_disable+0x1b/0x3a0
> [   89.495878]  __ftrace_event_enable_disable+0x1b/0x3a0
> [   89.496805]  event_enable_write+0x109/0x170
> [   89.497631]  ? __pfx_event_enable_write+0x10/0x10
> [   89.498618]  ? __pfx_bpf_lsm_file_permission+0x10/0x10
> [   89.499659]  ? security_file_permission+0x51/0x2d0
> [   89.500604]  vfs_write+0x175/0x670
> [   89.501385]  ? __pfx_vfs_write+0x10/0x10
> [   89.502246]  ? __pfx__raw_spin_lock+0x10/0x10
> [   89.503187]  ? expand_files+0x9b/0x330
> [   89.504011]  ? __pfx_expand_files+0x10/0x10
> [   89.504898]  ? set_close_on_exec+0x7b/0xe0
> [   89.505782]  ? __fget_light+0xae/0x1e0
> [   89.506615]  ? _raw_spin_lock+0x85/0xe0
> [   89.507989]  ksys_write+0xbd/0x160
> [   89.509302]  ? __pfx_ksys_write+0x10/0x10
> [   89.510493]  ? dnotify_flush+0x38/0x220
> [   89.511654]  ? fpregs_assert_state_consistent+0x5a/0x70
> [   89.513297]  ? exit_to_user_mode_prepare+0x32/0x110
> [   89.514692]  do_syscall_64+0x3f/0x90
> [   89.515516]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

I wonder if this is related to:

  https://lore.kernel.org/all/202309050916.58201dc6-oliver.sang@intel.com/

Which I'm currently debugging.

-- Steve
