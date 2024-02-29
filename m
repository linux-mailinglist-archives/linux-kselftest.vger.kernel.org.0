Return-Path: <linux-kselftest+bounces-5596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93B86C068
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 06:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0161F23CD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480233BBDC;
	Thu, 29 Feb 2024 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e99Yr3X+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BA3BBD8;
	Thu, 29 Feb 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185904; cv=none; b=AGuiX1zUJf4kOpStggU87UQlz8dYxdgRRPYYEbuvB0sdL2CkyAm6bKS50jNTf0bma+7Rkih2SyO+zQv1yLFSchGi3NLw5/f9FiH1kxCBrkduCquF0a81KLOlApeJwl1tmPk+ZyKBrhPl6eG9rj9hb+jR8aB5DIl7g6oz9ASSBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185904; c=relaxed/simple;
	bh=Z26zjpOE6rOE4nsLrLh3bCa2g0SlC8yPzMNdx2MtcR8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l92YROLMFPfFQ7ONbIQuJb9CyEU7TKdiRIStZ9BHhFcrgVm8ZkvZS9itdQHz9hGVqQyX6zA4DannjLpZU58+q7Eps27Ou7RkbQ1w1+vZLbOkfdy8vyiqp0sArVsXSNImi4BabNOlBAgmFa7cvzYyjoIxmyci15UWuCP59P4DGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e99Yr3X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE0EC433C7;
	Thu, 29 Feb 2024 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709185903;
	bh=Z26zjpOE6rOE4nsLrLh3bCa2g0SlC8yPzMNdx2MtcR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e99Yr3X+OCxivuLdFRf46eTUUAWjBHmN4roziwuUD0gSbRF+KtaYb4AiQukjExdmK
	 k6l1MmZHg9OVkMH7oCByy4yS7ZW2ljGdIQPX0e7sUsawgFpJPHoEiIX3cjWbCzZdxV
	 NkEAu+Nn4T4fyIwyxxurpI6s5gQ+bqIZl6xm939jwxFdyubjGjLxBYwhfEi8X66feH
	 9Ji3DK7FNwfLqwBnRjb8wbFJWyOdxlkwobHxobe/4Ajsn+tjxWHgt+Uw5f+Rry1SsD
	 may1YSpnPp3wMbL03/hl27gRMWV0exPMZw28bCq1Ppi/3kIPZge5U764ETchr1ijWF
	 TnoMjX4szl6kQ==
Date: Thu, 29 Feb 2024 14:51:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-Id: <20240229145139.a215085c44add62302463312@kernel.org>
In-Reply-To: <Zd9eBn2FTQzYyg7L@krava>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 17:23:34 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Feb 26, 2024 at 12:57:53PM +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is version 2 series of patches to support accessing function entry data
> > from function *return* probes (including kretprobe and fprobe-exit event).
> > 
> > In this version, I added another cleanup [4/7], updated README[5/7], added
> > testcases[6/7] and updated document[7/7].
> > 
> > This allows us to access the results of some functions, which returns the
> > error code and its results are passed via function parameter, such as an
> > structure-initialization function.
> > 
> > For example, vfs_open() will link the file structure to the inode and update
> > mode. Thus we can trace that changes.
> > 
> >  # echo 'f vfs_open mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
> >  # echo 'f vfs_open%return mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events 
> >  # echo 1 > events/fprobes/enable 
> >  # cat trace
> >               sh-131     [006] ...1.  1945.714346: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x2 inode=0x0
> >               sh-131     [006] ...1.  1945.714358: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4d801e inode=0xffff888008470168
> >              cat-143     [007] ...1.  1945.717949: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
> >              cat-143     [007] ...1.  1945.717956: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4a801d inode=0xffff888005f78d28
> >              cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
> >              cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8
> 
> hi,
> I hit a crash while playing with this, by runnning:
> 
>   # echo 'f vfs_read%return $arg*' >> dynamic_events
>   # echo 1 > events/fprobes/enable 

Thanks for reporting! But I can not reproduce it.
Can you share your kconfig?

> 
> jirka
> 
> 
> ---
> [   86.805519][  T712] general protection fault, probably for non-canonical address 0xef01a20a8bd21200: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   86.807259][  T712] CPU: 0 PID: 712 Comm: cat Not tainted 6.8.0-rc5+ #432 b8184d32457f2dd20b7178757a1fce97b3f847e2
> [   86.808417][  T712] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [   86.809294][  T712] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.809930][  T712] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.811727][  T712] RSP: 0018:ffffc90001e0bdf8 EFLAGS: 00010286
> [   86.812316][  T712] RAX: ffffc90001e0bef0 RBX: ffff8881775999a0 RCX: ffffc90001e0be40
> [   86.813106][  T712] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888177599990
> [   86.813881][  T712] RBP: ffff8881775999a0 R08: 0000000000000000 R09: ffff88810246af00
> [   86.814626][  T712] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81545129
> [   86.815357][  T712] R13: ef01a20a8bd21200 R14: ffffc90001e0bee8 R15: ffffc90001e0be40
> [   86.816114][  T712] FS:  00007f22d7c1f740(0000) GS:ffff88846ce00000(0000) knlGS:0000000000000000
> [   86.816885][  T712] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.817455][  T712] CR2: 00007f22d7b9c000 CR3: 0000000176918001 CR4: 0000000000770ef0
> [   86.818221][  T712] PKRU: 55555554
> [   86.818579][  T712] Call Trace:
> [   86.818900][  T712]  <TASK>
> [   86.819194][  T712]  ? die_addr+0x32/0x80
> [   86.819583][  T712]  ? exc_general_protection+0x276/0x4d0
> [   86.820079][  T712]  ? asm_exc_general_protection+0x22/0x30
> [   86.820600][  T712]  ? ksys_read+0x69/0xf0
> [   86.821022][  T712]  ? ksys_read+0x69/0xf0
> [   86.821422][  T712]  ? rethook_trampoline_handler+0x8e/0x200
> [   86.821984][  T712]  ? rethook_trampoline_handler+0x91/0x200
> [   86.822539][  T712]  arch_rethook_trampoline_callback+0x36/0x50
> [   86.823097][  T712]  arch_rethook_trampoline+0x2c/0x60
> [   86.823584][  T712]  ? ksys_read+0x69/0xf0
> [   86.823962][  T712]  osnoise_arch_unregister+0x210/0x210
> [   86.824463][  T712]  do_syscall_64+0x87/0x1b0
> [   86.824910][  T712]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   86.825418][  T712] RIP: 0033:0x7f22d7d230b1
> [   86.825859][  T712] Code: d5 fe ff ff 55 48 8d 3d 25 47 0a 00 48 89 e5 e8 b5 18 02 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d 2d b5 0d 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
> [   86.827635][  T712] RSP: 002b:00007fffdaaef668 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   86.828355][  T712] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f22d7d230b1
> [   86.829017][  T712] RDX: 0000000000020000 RSI: 00007f22d7b9c000 RDI: 0000000000000003
> [   86.829710][  T712] RBP: 00007fffdaaef690 R08: 00000000ffffffff R09: 0000000000000000
> [   86.831165][  T712] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
> [   86.831910][  T712] R13: 00007f22d7b9c000 R14: 0000000000000003 R15: 0000000000000000
> [   86.832691][  T712]  </TASK>
> [   86.833016][  T712] Modules linked in: intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
> [   86.835078][  T634] general protection fault, probably for non-canonical address 0x440038d965baf00: 0000 [#2] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   86.835196][  T712] ---[ end trace 0000000000000000 ]---
> [   86.835943][  T634] CPU: 3 PID: 634 Comm: sshd Tainted: G      D            6.8.0-rc5+ #432 b8184d32457f2dd20b7178757a1fce97b3f847e2
> [   86.835946][  T634] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [   86.835947][  T634] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.835952][  T634] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.836363][  T712] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.837090][  T634] RSP: 0018:ffffc90001d3bdf8 EFLAGS: 00010206
> [   86.837776][  T712] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.838205][  T634] 
> [   86.839488][  T712] RSP: 0018:ffffc90001e0bdf8 EFLAGS: 00010286
> [   86.839890][  T634] RAX: ffffc90001d3bef0 RBX: ffff888176cbbaa0 RCX: ffffc90001d3be40
> [   86.840239][  T712] 
> [   86.840240][  T712] RAX: ffffc90001e0bef0 RBX: ffff8881775999a0 RCX: ffffc90001e0be40
> [   86.841309][  T634] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888176cbba90
> [   86.841311][  T634] RBP: ffff888176cbbaa0 R08: 0000000000000001 R09: 0000000000000000
> [   86.841312][  T634] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff81545129
> [   86.841313][  T634] R13: 0440038d965baf00 R14: ffffc90001d3bee8 R15: ffffc90001d3be40
> [   86.841314][  T634] FS:  00007f1ddf838940(0000) GS:ffff88846da00000(0000) knlGS:0000000000000000
> [   86.841316][  T634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.841477][  T712] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888177599990
> [   86.841800][  T634] CR2: 0000559fb5f9f000 CR3: 0000000176e2e004 CR4: 0000000000770ef0
> [   86.842308][  T712] RBP: ffff8881775999a0 R08: 0000000000000000 R09: ffff88810246af00
> [   86.842456][  T634] PKRU: 55555554
> [   86.842458][  T634] Call Trace:
> [   86.842459][  T634]  <TASK>
> [   86.842462][  T634]  ? die_addr+0x32/0x80
> [   86.842978][  T712] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81545129
> [   86.843508][  T634]  ? exc_general_protection+0x276/0x4d0
> [   86.843516][  T634]  ? asm_exc_general_protection+0x22/0x30
> [   86.844002][  T712] R13: ef01a20a8bd21200 R14: ffffc90001e0bee8 R15: ffffc90001e0be40
> [   86.844004][  T712] FS:  00007f22d7c1f740(0000) GS:ffff88846ce00000(0000) knlGS:0000000000000000
> [   86.844503][  T634]  ? ksys_read+0x69/0xf0
> [   86.844507][  T634]  ? ksys_read+0x69/0xf0
> [   86.844510][  T634]  ? rethook_trampoline_handler+0x8e/0x200
> [   86.845033][  T712] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.845677][  T634]  ? rethook_trampoline_handler+0x91/0x200
> [   86.845680][  T634]  arch_rethook_trampoline_callback+0x36/0x50
> [   86.845684][  T634]  arch_rethook_trampoline+0x2c/0x60
> [   86.846111][  T712] CR2: 00007f22d7b9c000 CR3: 0000000176918001 CR4: 0000000000770ef0
> [   86.846674][  T634]  ? ksys_read+0x69/0xf0
> [   86.846679][  T634]  osnoise_arch_unregister+0x210/0x210
> [   86.847213][  T712] PKRU: 55555554
> [   86.847648][  T634]  do_syscall_64+0x87/0x1b0
> [   86.847653][  T634]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   86.847868][  T712] note: cat[712] exited with preempt_count 1
> [   86.848096][  T634] RIP: 0033:0x7f1ddfc4a0b1
> [   86.869351][  T634] Code: d5 fe ff ff 55 48 8d 3d 25 47 0a 00 48 89 e5 e8 b5 18 02 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d 2d b5 0d 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
> [   86.871186][  T634] RSP: 002b:00007fffdd061ae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   86.871995][  T634] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f1ddfc4a0b1
> [   86.872785][  T634] RDX: 0000000000008000 RSI: 000055bbb41e37b0 RDI: 000000000000000c
> [   86.873553][  T634] RBP: 00007fffdd061b50 R08: 0000000000000000 R09: 0000000000000000
> [   86.874320][  T634] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> [   86.874960][  T634] R13: 0000000000000000 R14: 000055bbb4172840 R15: 000000000000000c
> [   86.875670][  T634]  </TASK>
> [   86.875964][  T634] Modules linked in: intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
> [   86.877814][  T634] ---[ end trace 0000000000000000 ]---
> [   86.877991][  T450] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [   86.878210][  T634] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.878217][  T634] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.878219][  T634] RSP: 0018:ffffc90001e0bdf8 EFLAGS: 00010286
> [   86.878221][  T634] RAX: ffffc90001e0bef0 RBX: ffff8881775999a0 RCX: ffffc90001e0be40
> [   86.878222][  T634] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888177599990
> [   86.878224][  T634] RBP: ffff8881775999a0 R08: 0000000000000000 R09: ffff88810246af00
> [   86.878225][  T634] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81545129
> [   86.878226][  T634] R13: ef01a20a8bd21200 R14: ffffc90001e0bee8 R15: ffffc90001e0be40
> [   86.878227][  T634] FS:  00007f1ddf838940(0000) GS:ffff88846da00000(0000) knlGS:0000000000000000
> [   86.878228][  T634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.878230][  T634] CR2: 0000559fb5f9f000 CR3: 0000000176e2e004 CR4: 0000000000770ef0
> [   86.878233][  T634] PKRU: 55555554
> [   86.878235][  T634] note: sshd[634] exited with preempt_count 1
> [   86.888492][  T450] BUG: unable to handle page fault for address: ffffc90001cdff58
> [   86.889266][  T450] #PF: supervisor instruction fetch in kernel mode
> [   86.889914][  T450] #PF: error_code(0x0011) - permissions violation
> [   86.891248][  T450] PGD 100000067 P4D 100000067 PUD 102a49067 PMD 10b3ee067 PTE 8000000109295163
> [   86.892032][  T450] Oops: 0011 [#3] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   86.892560][  T450] CPU: 1 PID: 450 Comm: systemd-journal Tainted: G      D            6.8.0-rc5+ #432 b8184d32457f2dd20b7178757a1fce97b3f847e2
> [   86.893758][  T450] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [   86.894542][  T450] RIP: 0010:0xffffc90001cdff58
> [   86.894964][  T450] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e6 00 60 82 ff ff ff ff <00> 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   86.896519][  T450] RSP: 0018:ffffc90000b13df0 EFLAGS: 00010282
> [   86.897004][  T450] RAX: ffffc90001cdfef0 RBX: ffff88817759a8a0 RCX: ffffc90000b13e40
> [   86.897672][  T450] RDX: ffffffff81545129 RSI: ffffffffffffffff RDI: ffff88817759a890
> [   86.898341][  T450] RBP: ffff88817759a8a0 R08: 0000000000000001 R09: ffff888102b2c470
> [   86.899143][  T450] R10: ffffc90000b13e58 R11: ffffffff83976548 R12: ffffffff81545129
> [   86.899871][  T450] R13: ffffc90001cdff58 R14: ffffc90000b13ee8 R15: ffffc90000b13e40
> [   86.900547][  T450] FS:  00007f20a7635940(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
> [   86.901259][  T450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.901773][  T450] CR2: ffffc90001cdff58 CR3: 0000000176a7a003 CR4: 0000000000770ef0
> [   86.902411][  T450] PKRU: 55555554
> [   86.902722][  T450] Call Trace:
> [   86.903009][  T450]  <TASK>
> [   86.903271][  T450]  ? __die+0x1f/0x70
> [   86.903613][  T450]  ? page_fault_oops+0x176/0x4d0
> [   86.904126][  T450]  ? exc_page_fault+0x16c/0x250
> [   86.904614][  T450]  ? asm_exc_page_fault+0x22/0x30
> [   86.905140][  T450]  ? ksys_read+0x69/0xf0
> [   86.905615][  T450]  ? ksys_read+0x69/0xf0
> [   86.906053][  T450]  ? rethook_trampoline_handler+0x91/0x200
> [   86.906643][  T450]  ? arch_rethook_trampoline_callback+0x36/0x50
> [   86.907271][  T450]  ? arch_rethook_trampoline+0x2c/0x60
> [   86.907845][  T450]  ? ksys_read+0x69/0xf0
> [   86.908300][  T450]  ? osnoise_arch_unregister+0x210/0x210
> [   86.908781][  T450]  ? do_syscall_64+0x87/0x1b0
> [   86.909186][  T450]  ? entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   86.909681][  T450]  </TASK>
> [   86.909959][  T450] Modules linked in: intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
> [   86.911681][  T450] CR2: ffffc90001cdff58
> [   86.912108][  T450] ---[ end trace 0000000000000000 ]---
> [   86.912674][  T450] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.913232][  T450] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.914702][  T450] RSP: 0018:ffffc90001e0bdf8 EFLAGS: 00010286
> [   86.915196][  T450] RAX: ffffc90001e0bef0 RBX: ffff8881775999a0 RCX: ffffc90001e0be40
> [   86.915853][  T450] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888177599990
> [   86.916644][  T450] RBP: ffff8881775999a0 R08: 0000000000000000 R09: ffff88810246af00
> [   86.917449][  T450] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81545129
> [   86.918238][  T450] R13: ef01a20a8bd21200 R14: ffffc90001e0bee8 R15: ffffc90001e0be40
> [   86.919043][  T450] FS:  00007f20a7635940(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
> [   86.919906][  T450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.921265][  T450] CR2: ffffc90001cdff58 CR3: 0000000176a7a003 CR4: 0000000000770ef0
> [   86.921972][  T450] PKRU: 55555554
> [   86.922365][  T450] note: systemd-journal[450] exited with irqs disabled
> [   86.923076][  T450] note: systemd-journal[450] exited with preempt_count 1
> [   86.927597][   T47] audit: type=1106 audit(1709132147.391:266): pid=619 uid=0 auid=1000 ses=1 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 msg='op=PAM:session_close grantors=pam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_umask,pam_lastlog acct="jolsa" exe="/usr/sbin/sshd" hostname=192.168.122.1 addr=192.168.122.1 terminal=ssh res=success'
> [   86.928777][  T450] systemd-journal (450) used greatest stack depth: 11424 bytes left
> [   86.929578][    T1] general protection fault, probably for non-canonical address 0xd4f06e07d9d64800: 0000 [#4] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   86.929582][    T1] CPU: 2 PID: 1 Comm: systemd Tainted: G      D            6.8.0-rc5+ #432 b8184d32457f2dd20b7178757a1fce97b3f847e2
> [   86.929584][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [   86.929586][    T1] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.929591][    T1] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.929592][    T1] RSP: 0018:ffffc90000013df8 EFLAGS: 00010286
> [   86.929594][    T1] RAX: ffffc90000013ef0 RBX: ffff888177598aa0 RCX: ffffc90000013e40
> [   86.929595][    T1] RDX: ffffffff81545129 RSI: 0000000000000010 RDI: ffff888177598a90
> [   86.929596][    T1] RBP: ffff888177598aa0 R08: 0000000000000010 R09: ffff888175005750
> [   86.929597][    T1] R10: 0000000000000000 R11: ffffc90000013dd8 R12: ffffffff81545129
> [   86.929598][    T1] R13: d4f06e07d9d64800 R14: ffffc90000013ee8 R15: ffffc90000013e40
> [   86.929599][    T1] FS:  00007f0ec5012940(0000) GS:ffff88846d600000(0000) knlGS:0000000000000000
> [   86.929600][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.929601][    T1] CR2: 00005595e83bf5b0 CR3: 000000010805e001 CR4: 0000000000770ef0
> [   86.929604][    T1] PKRU: 55555554
> [   86.929605][    T1] Call Trace:
> [   86.929606][    T1]  <TASK>
> [   86.929606][    T1]  ? die_addr+0x32/0x80
> [   86.929610][    T1]  ? exc_general_protection+0x276/0x4d0
> [   86.929616][    T1]  ? asm_exc_general_protection+0x22/0x30
> [   86.929621][    T1]  ? ksys_read+0x69/0xf0
> [   86.929624][    T1]  ? ksys_read+0x69/0xf0
> [   86.929627][    T1]  ? rethook_trampoline_handler+0x8e/0x200
> [   86.929629][    T1]  ? rethook_trampoline_handler+0x91/0x200
> [   86.929631][    T1]  arch_rethook_trampoline_callback+0x36/0x50
> [   86.929635][    T1]  arch_rethook_trampoline+0x2c/0x60
> [   86.929639][    T1]  ? ksys_read+0x69/0xf0
> [   86.929640][    T1]  osnoise_arch_unregister+0x210/0x210
> [   86.929643][    T1]  do_syscall_64+0x87/0x1b0
> [   86.929645][    T1]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   86.929647][    T1] RIP: 0033:0x7f0ec49230ea
> [   86.929653][    T1] Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 e8 79 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 42 7a f8 ff 48 8b
> [   86.929655][    T1] RSP: 002b:00007ffead1dc7a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   86.929656][    T1] RAX: ffffffffffffffda RBX: 00005625bff4efe0 RCX: 00007f0ec49230ea
> [   86.929657][    T1] RDX: 0000000000000400 RSI: 00005625bfeda010 RDI: 0000000000000019
> [   86.929658][    T1] RBP: 00007ffead1dc7c0 R08: 0000000000000000 R09: 0000000000000001
> [   86.929659][    T1] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f0ec49f3660
> [   86.929659][    T1] R13: 00007f0ec50127d0 R14: 0000000000000a68 R15: 00007f0ec49f2d60
> [   86.929663][    T1]  </TASK>
> [   86.929663][    T1] Modules linked in: intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
> [   86.929676][    T1] ---[ end trace 0000000000000000 ]---
> [   86.929677][    T1] RIP: 0010:rethook_trampoline_handler+0x8e/0x200
> [   86.929679][    T1] Code: 5e 20 00 48 8b a8 c8 2a 00 00 48 85 ed 75 2f e9 8b 00 00 00 4d 85 ed 74 17 48 8b 45 08 48 8d 7d f0 4c 89 f9 4c 89 e2 48 8b 30 <41> ff d5 0f 1f 00 48 39 dd 74 6a 48 8b 6d 00 48 85 ed 74 61 4c 39
> [   86.929680][    T1] RSP: 0018:ffffc90001e0bdf8 EFLAGS: 00010286
> [   86.929681][    T1] RAX: ffffc90001e0bef0 RBX: ffff8881775999a0 RCX: ffffc90001e0be40
> [   86.929682][    T1] RDX: ffffffff81545129 RSI: 0000000000000000 RDI: ffff888177599990
> [   86.929683][    T1] RBP: ffff8881775999a0 R08: 0000000000000000 R09: ffff88810246af00
> [   86.929684][    T1] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81545129
> [   86.929685][    T1] R13: ef01a20a8bd21200 R14: ffffc90001e0bee8 R15: ffffc90001e0be40
> [   86.929686][    T1] FS:  00007f0ec5012940(0000) GS:ffff88846d600000(0000) knlGS:0000000000000000
> [   86.929687][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.929688][    T1] CR2: 00005595e83bf5b0 CR3: 000000010805e001 CR4: 0000000000770ef0
> [   86.929688][    T1] PKRU: 55555554
> [   86.929689][    T1] note: systemd[1] exited with preempt_count 1
> [   86.929692][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   86.929992][    T1] Kernel Offset: disabled


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

