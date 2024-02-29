Return-Path: <linux-kselftest+bounces-5598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF086C0E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 07:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC4C1F23982
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 06:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA844C8C;
	Thu, 29 Feb 2024 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa5uX/5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EF50A78;
	Thu, 29 Feb 2024 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188740; cv=none; b=FtLY9H4B1TLdOumwLBdXvnL+J/YNhgDTluDCzBFWoA329M1sZhnkfsDzHIHSgl2xfow4b8BwlwttqhHo4sIZ20wt9vVWc64QIBAsD+kfsUJXYBE0olD0P/Q/02giIT7Uy/RlDUqnvkEJI6TJ8CLgLiHpsy4ybBVEhL+JtGaPLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188740; c=relaxed/simple;
	bh=cfh98lsnK1WA24iz8Eoegn/HEuWd+0TrFqTV/dJ6qbA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JtqQ85uiA52x9XWSIk3/XJPZhMxIPwToC6R07FEO1StAlbFguiBfatwe4spOXMW15XReoDw2cTbneGTPnJiFrn/ZRu2MrJIz3hL04WgLUACZZVWKGP0C6UikVoy1Djwn3beSUCzcWOHamxW26E4d3Ci0PIKDwtFuNqSKM+vbu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa5uX/5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D02C433F1;
	Thu, 29 Feb 2024 06:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709188740;
	bh=cfh98lsnK1WA24iz8Eoegn/HEuWd+0TrFqTV/dJ6qbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sa5uX/5L0fo+9Xu4rwU36fBtU3OqtGH71/qOtqqJ6XyZrV71FtwYXIHJ8WUSJqdDj
	 gd/pZAU0+epjdcjKLR771mYZbVUrf5BzsPE5wBu2b5Y29N14X/PcS7yphvWyFuu+JQ
	 zyJdsqLIHXyQSx2PFZHdTBdK2SfghMc3+08UFJAS9+SSADAsL3jnoeHssoyscRNynZ
	 4wii49o7xSJSDrx0NHv2wTVyNMXOQO23MnazuB6SaZjRnugWDEuU6sBXWA/tEuD+VB
	 x6Bx88vlC1dTVpSgQ5JOY8NKlNcCXlx83iE4UtTayWE113TLVezg8gvh+i4KBGjQx0
	 aI8rfRWHDiTdg==
Date: Thu, 29 Feb 2024 15:38:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-Id: <20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
In-Reply-To: <20240229145139.a215085c44add62302463312@kernel.org>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
	<20240229145139.a215085c44add62302463312@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 14:51:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 28 Feb 2024 17:23:34 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Mon, Feb 26, 2024 at 12:57:53PM +0900, Masami Hiramatsu (Google) wrote:
> > > Hi,
> > > 
> > > Here is version 2 series of patches to support accessing function entry data
> > > from function *return* probes (including kretprobe and fprobe-exit event).
> > > 
> > > In this version, I added another cleanup [4/7], updated README[5/7], added
> > > testcases[6/7] and updated document[7/7].
> > > 
> > > This allows us to access the results of some functions, which returns the
> > > error code and its results are passed via function parameter, such as an
> > > structure-initialization function.
> > > 
> > > For example, vfs_open() will link the file structure to the inode and update
> > > mode. Thus we can trace that changes.
> > > 
> > >  # echo 'f vfs_open mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
> > >  # echo 'f vfs_open%return mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events 
> > >  # echo 1 > events/fprobes/enable 
> > >  # cat trace
> > >               sh-131     [006] ...1.  1945.714346: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x2 inode=0x0
> > >               sh-131     [006] ...1.  1945.714358: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4d801e inode=0xffff888008470168
> > >              cat-143     [007] ...1.  1945.717949: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
> > >              cat-143     [007] ...1.  1945.717956: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4a801d inode=0xffff888005f78d28
> > >              cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
> > >              cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8
> > 
> > hi,
> > I hit a crash while playing with this, by runnning:
> > 
> >   # echo 'f vfs_read%return $arg*' >> dynamic_events
> >   # echo 1 > events/fprobes/enable 
> 
> Thanks for reporting! But I can not reproduce it.
> Can you share your kconfig?

No problem, I could reproduce it.

/sys/kernel/tracing # echo 'f vfs_read%return $arg* $retval' >> dynamic_events 
/sys/kernel/tracing # echo 1 > events/fprobes/enable 
/sys/kernel/tracing # 
/sys/kernel/tracing # [   67.709725] general protection fault, maybe for address 0xffffc9000047bef8: 0000 [#1] PREEMPT SMP PTI
[   67.714672] CPU: 5 PID: 132 Comm: sh Tainted: G                 N 6.8.0-rc5-00007-gd5e41e4cee7e #149
[   67.716491] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   67.718036] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
[   67.719087] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 44 00 00 e8 01 00 00 00 cc 4c 89 2c 24 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 44 00 00
[   67.722314] RSP: 0018:ffffc9000047bdf0 EFLAGS: 00010286
[   67.723251] RAX: ffffc9000047bef8 RBX: ffff8880073258e0 RCX: ffffc9000047be48
[   67.724704] RDX: ffffffff813aba09 RSI: 0000000000000000 RDI: ffff8880073258d0
[   67.725840] RBP: ffff8880073258e0 R08: 0000000000000000 R09: ffff888005053648
[   67.727017] R10: ffff888008452388 R11: 0000000000000001 R12: ffffffff813aba09
[   67.728107] R13: 9c73d7ba3660c600 R14: ffffc9000047bef0 R15: ffffc9000047be48
[   67.729630] FS:  000000000115d8c0(0000) GS:ffff88807d940000(0000) knlGS:0000000000000000
[   67.731231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.732285] CR2: 00000000005a2319 CR3: 0000000005ad6000 CR4: 00000000000006b0
[   67.733502] Call Trace:
[   67.734013]  <TASK>
[   67.734504]  ? die_addr+0x37/0x90
[   67.735307]  ? exc_general_protection+0x1ac/0x3f0
[   67.736158]  ? asm_exc_general_protection+0x26/0x30
[   67.736984]  ? ksys_read+0x69/0xf0
[   67.737559]  ? ksys_read+0x69/0xf0
[   67.738142]  ? __x86_indirect_thunk_r13+0xa/0x20
[   67.739160]  ? rethook_trampoline_handler+0x95/0x200
[   67.739919]  ? arch_rethook_trampoline_callback+0x3a/0x50
[   67.740665]  ? arch_rethook_trampoline+0x2c/0x60
[   67.741362]  ? ksys_read+0x69/0xf0
[   67.741980]  ? trace_clock_x86_tsc+0x20/0x20
[   67.742662]  ? do_syscall_64+0xcc/0x1e0
[   67.743289]  ? entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   67.744620]  </TASK>
[   67.745044] Modules linked in:
[   67.745559] ---[ end trace 0000000000000000 ]---
[   67.746221] RIP: 0010:__x86_indirect_thunk_r13+0xa/0x20
[   67.746927] Code: e8 01 00 00 00 cc 4c 89 24 24 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 44 00 00 e8 01 00 00 00 cc 4c 89 2c 24 <c3> cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 0f 1f 44 00 00
[   67.749176] RSP: 0018:ffffc9000047bdf0 EFLAGS: 00010286
[   67.749835] RAX: ffffc9000047bef8 RBX: ffff8880073258e0 RCX: ffffc9000047be48
[   67.750687] RDX: ffffffff813aba09 RSI: 0000000000000000 RDI: ffff8880073258d0
[   67.751880] RBP: ffff8880073258e0 R08: 0000000000000000 R09: ffff888005053648
[   67.752810] R10: ffff888008452388 R11: 0000000000000001 R12: ffffffff813aba09
[   67.753721] R13: 9c73d7ba3660c600 R14: ffffc9000047bef0 R15: ffffc9000047be48
[   67.754554] FS:  000000000115d8c0(0000) GS:ffff88807d940000(0000) knlGS:0000000000000000
[   67.755568] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.756278] CR2: 00000000005a2319 CR3: 0000000005ad6000 CR4: 00000000000006b0
[   67.757089] Kernel panic - not syncing: Fatal exception
[   67.757917] Kernel Offset: disabled
[   67.758404] ---[ end Kernel panic - not syncing: Fatal exception ]---

Hmm, this seems arch_rethook_trampoline caused the issue.

And curiously, it depends on the number of stored data.

OK:
/sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3' >> dynamic_events 
/sys/kernel/tracing # echo 1 > events/fprobes/enable 

NG:
/sys/kernel/tracing # echo 'f vfs_read%return $arg1 $arg2 $arg3 $arg4' >> dynamic_events 
/sys/kernel/tracing # echo 1 > events/fprobes/enable 

I also confirmed that on 'vfs_write' caused the same result. 3 arguments(24 bytes) is OK,
but 4 arguments (32bytes) is NG.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

