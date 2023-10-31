Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42187DC398
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 01:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjJaA1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjJaA1Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 20:27:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F5BD107;
        Mon, 30 Oct 2023 17:27:13 -0700 (PDT)
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.121])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E1A620B74C0;
        Mon, 30 Oct 2023 17:27:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E1A620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698712032;
        bh=q60ZjWMoN+FEaOuKxFntu1K/hFrnVp8kapWs3j8soLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loPO6COvAognMuUC/tlUAEuZMGQceD/G0hRf50YvtoHXE6ncj5H2WKkBZ58rfz/Db
         It3DK6aQll/56gTSZMVzhlpKmeHIxSeohGQhdkN8K44XRzO/dLzaCV8W8qHDCGTD65
         AEZBCr9Huqbkne1J27+ADocK6+Kg79p4bsT8Bf9c=
Date:   Tue, 31 Oct 2023 00:27:07 +0000
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20231031002707.GA107-beaub@linux.microsoft.com>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
 <20231027192011.GA436-beaub@linux.microsoft.com>
 <20231027183640.2529ab68@gandalf.local.home>
 <20231027223344.3854ac1f@rorschach.local.home>
 <20231030163102.GA1853-beaub@linux.microsoft.com>
 <20231030124223.4e4ddeb8@gandalf.local.home>
 <20231030173151.0631169b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030173151.0631169b@gandalf.local.home>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 30, 2023 at 05:31:51PM -0400, Steven Rostedt wrote:
> On Mon, 30 Oct 2023 12:42:23 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > I still get the splat about the trace_array_put when running
> > > user_event's ftrace selftest:
> > > 
> > > [   26.665931] ------------[ cut here ]------------
> > > [   26.666663] WARNING: CPU: 12 PID: 291 at kernel/trace/trace.c:516 tracing_release_file_tr+0x46/0x50
> > > [   26.667470] Modules linked in:
> > > [   26.667808] CPU: 12 PID: 291 Comm: ftrace_test Not tainted 6.6.0-rc7-next-20231026 #3
> > > [   26.668665] RIP: 0010:tracing_release_file_tr+0x46/0x50
> > > [   26.669093] Code: d1 03 01 8b 83 c0 1e 00 00 85 c0 74 1d 83 e8 01 48 c7 c7 80 5b ef bc 89 83 c0 1e 00 00 e8 f2 b5 03 01 31 c0 5b e9 75 ee 27 01 <0f> 0b eb df 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
> > > [   26.670580] RSP: 0018:ffffb6ef858ffee8 EFLAGS: 00010246
> > > [   26.671128] RAX: 0000000000000000 RBX: ffff9d7ae2364058 RCX: 0000000000000000
> > > [   26.671793] RDX: 0000000000000000 RSI: ffffffffbcb6b38b RDI: 00000000ffffffff
> > > [   26.672444] RBP: ffff9d7ac3e72200 R08: 0000000000000000 R09: 0000000000000000
> > > [   26.673072] R10: ffffb6ef858ffee8 R11: ffffffffbb28526f R12: 00000000000f801f
> > > [   26.673705] R13: ffff9d7b661a2020 R14: ffff9d7ac6057728 R15: 0000000000000000
> > > [   26.674339] FS:  00007fa852fa6740(0000) GS:ffff9d81a6300000(0000) knlGS:0000000000000000
> > > [   26.674978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   26.675506] CR2: 00007fa852c2a250 CR3: 0000000105d92001 CR4: 0000000000370eb0
> > > [   26.676142] Call Trace:
> > > [   26.676357]  <TASK>
> > > [   26.676572]  ? __warn+0x7f/0x160
> > > [   26.677092]  ? tracing_release_file_tr+0x46/0x50
> > > [   26.677540]  ? report_bug+0x1c3/0x1d0
> > > [   26.677871]  ? handle_bug+0x3c/0x70
> > > [   26.678196]  ? exc_invalid_op+0x14/0x70
> > > [   26.678520]  ? asm_exc_invalid_op+0x16/0x20
> > > [   26.678845]  ? tracing_release_file_tr+0x1f/0x50
> > > [   26.679268]  ? tracing_release_file_tr+0x46/0x50
> > > [   26.679691]  ? tracing_release_file_tr+0x1f/0x50
> > > [   26.680105]  __fput+0xab/0x300
> > > [   26.680437]  __x64_sys_close+0x38/0x80  
> > 
> > Hmm, this doesn't tell me much. Let me go play with the user_event self
> > tests.
> 
> I added a bunch of printk()s and I'm thinking there's a race in user event
> (or dynamic event) code.
> 

I did as well, however, I don't see how user events would be involved
other than allowing a trace_remove_event_call() with open enable fds?

I believe the scenario is open the enable file and keep the fd open.

While the fd is open to the enable file, call trace_remove_event_call().

If trace_remove_event_call() is called for an event with a tr->ref > 0,
should it fail or work? (It currently works without issue.)

Should writes to the fd still work after the event it is related to has
been removed?

I don't see how user_events could prevent this, it seems
trace_remove_event_call() should fail if files for it are still open?

Thanks,
-Beau

> I put a printk in the open, write and release call to record the filp and
> the file in the open and this is what I hit:
> 
> [   32.603954] open ffff8d05488bf000 file=ffff8d0484f7a688
> [   32.607026] write ffff8d05488bf000
> [   32.608829] update file = ffff8d0484f7a688
> [   32.610100] update tr = ffffffffb2bebda0
> [   32.622203] write ffff8d05488bf000
> [   32.623231] update file = ffff8d0484f7a688
> [   32.624397] update tr = ffffffffb2bebda0
> [   32.625975] call delayed destroy
> [   32.627241] open ffff8d048510fc00 file=ffff8d0484f7a688
> 
> Another open with a different filp, but has the same file pointer (which is
> the meta data that matches the eventfs files, but not part of eventfs).
> 
> [   32.628720] release ffff8d048510fc00
> 
> Only one release is called and then we call:
> 
> [   32.630785] Remove event call ffff8d04809d7c58
> 
> The above "Remove event call" came from user_event_set_call_visible()
> 
> 	if (visible) {
> 		printk("show event call %px\n", &user->call);
> 		ret = trace_add_event_call(&user->call);
> 	} else {
> 		printk("Remove event call %px\n", &user->call);
> 		ret = trace_remove_event_call(&user->call);
> 	}
> 
> Where trace_remove_event_call() calls:
> 
>    probe_remove_event_call() {
>       __trace_remove_event_call() {
>          event_remove() {
>             remove_event_from_tracers() {
>                remove_event_file_dir() {
>                   remove_event_file_dir() {
>                      kmem_cache_free(file_cachep, file);
> 
> That is, call->file is freed at this point. Now any access to the file
> pointer is going to be garbage, which a write to enable will cause.
> 
> So I see it is freed without seeing a release called.
> 
> [   32.632323] Removing __test_event
> 
> The above is the dentry being released (unlinked).
> 
> [   32.633618] Removing enable
> [   32.634453] Removing user_events
> [   32.634948] write ffff8d05488bf000
> 
> Another write is happening to the user event file (it may have been
> unlinked, but the release was never called, so it is still valid.
> 
> [   32.636440] update file = ffff8d0484f7a688
> [   32.637685] update tr = dc64cc323d943921
> 
> The above is the file pointer that we freed, and you can see the file->tr
> is now garbage.
> 
> [   32.638827] general protection fault, probably for non-canonical address 0xdc64cc323d9457f9: 0000 [#1] PREEMPT SMP PTI
> [   32.641712] CPU: 4 PID: 911 Comm: ftrace_test Not tainted 6.6.0-rc4-test-00024-gd402dc722a1b-dirty #158
> [   32.644220] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   32.646717] RIP: 0010:tracing_update_buffers+0x19/0x50
> [   32.648133] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 55 31 f6 31 ed 53 48 89 fb 48 c7 c7 e0 bc be b2 e8 d7 b6 cb 00 <80> bb d8 1e 00 00 00 74 15 48 c7 c7 e0 bc be b2 e8 42 9f cb 00 89
> [   32.653125] RSP: 0018:ffffb7b34172be20 EFLAGS: 00010246
> [   32.654573] RAX: 0000000000000000 RBX: dc64cc323d943921 RCX: 0000000000000000
> [   32.656503] RDX: 0000000000000000 RSI: ffffffffb1e09128 RDI: ffffffffb1e09128
> [   32.658445] RBP: 0000000000000000 R08: 000000000000002f R09: 0000000000000000
> [   32.660378] R10: ffffb7b34172be20 R11: 0000000000000001 R12: ffffb7b34172bf08
> [   32.662322] R13: ffff8d0484f7a688 R14: ffffb7b34172bf08 R15: 0000000000000000
> [   32.664249] FS:  00007f1769a10740(0000) GS:ffff8d05f7c00000(0000) knlGS:0000000000000000
> [   32.666438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.668009] CR2: 000055c0cd72fc70 CR3: 000000010e3c6003 CR4: 0000000000170ee0
> [   32.669954] Call Trace:
> [   32.670653]  <TASK>
> [   32.671263]  ? die_addr+0x36/0x90
> [   32.672203]  ? exc_general_protection+0x236/0x4a0
> [   32.673521]  ? asm_exc_general_protection+0x26/0x30
> [   32.674872]  ? __mutex_lock+0x1c8/0xb40
> [   32.675942]  ? __mutex_lock+0x1c8/0xb40
> [   32.677009]  ? tracing_update_buffers+0x19/0x50
> [   32.678259]  event_enable_write+0xb4/0x140
> [   32.679311]  vfs_write+0xf2/0x530
> [   32.680172]  ? find_held_lock+0x2b/0x80
> [   32.681159]  ? _raw_spin_unlock+0x2d/0x50
> [   32.682711]  ? rcu_is_watching+0x11/0x50
> [   32.684159]  ? _raw_spin_unlock+0x2d/0x50
> [   32.685642]  ? trace_preempt_on+0x78/0x80
> [   32.687027]  ksys_write+0x75/0x100
> [   32.688257]  do_syscall_64+0x3f/0xc0
> [   32.689561]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   32.691048] RIP: 0033:0x7f1769b0ab00
> 
> Note, I think I can simplify some of the code (but not fix this bug) by
> letting the dput free the eventfs_inode as well (I think that is required).
> But the above looks to be a bug in the implementation of user_events.
> 
> -- Steve
