Return-Path: <linux-kselftest+bounces-26545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39116A33FFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899D93A1F28
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C323F41F;
	Thu, 13 Feb 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ya6MJo1+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875923F404;
	Thu, 13 Feb 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452391; cv=none; b=jS/9L3kR4bT2Jem/kXRlrzRyj9uOnuoMQR383lCGsaWFGnOe855Iffy530ydy611dzLT+ajJEyQabL2YQZvU124y6XACf4FP7STZ7WNX9jelL0UGljRHpUykOMN2XMQFNDWydSPb6S0jvlxgTiO8WCjhNSyr6qV6tmMP4VtFVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452391; c=relaxed/simple;
	bh=PvUJQvv0TMN/p/W8luAL2yKuJITHxoGDlOUMOvpwRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpSVx3aUV/X4faqUIR/5lhh+SkLI+8zC/vqo5A6QjustFzs5JUidFcCzQqGg61voA2fIvH9t5J+VM8rs+8ZCEnPLxPctqtEis4u6IRiN5R5ro5LK1mzJWku3SQv9qAmdqCEJtE9s/VGff3+6R7fYMbhj6qoVp96Db6HU1D6uQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ya6MJo1+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=66QIH
	tabSwT83zWqMY4rhDRSp8xEydswNS2skmyxGQo=; b=Ya6MJo1+Hta8EhIiqARyu
	VrCAEgkjLpJA/61r2t6+Q9yuJhWmehP1mLWVL8B8oKqBpQJq30/1L6B5N7VAyxTn
	uVP1tHSKifWmX3/osXHNmOx9tAbafgZ9/2IXVBbc9QibZnMK0XorcTth3tZZtOi6
	+6OQ75FYN351xcyUeDbgts=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3N8qv761nJPMJMA--.27324S2;
	Thu, 13 Feb 2025 21:12:17 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix array bounds error with may_goto and add selftest
Date: Thu, 13 Feb 2025 21:12:11 +0800
Message-ID: <20250213131214.164982-1-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8qv761nJPMJMA--.27324S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy7WF47Gr18WFW7XF47Jwb_yoW5Xw18pF
	WxJr15GF4kXr17Ar17AF4UGF15tws7AayUJr4xXr15Z3W5WFyUXr18G3yUXFn8GrWUZF1S
	ya4DW34kKw18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziYFAPUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwHyp2et7vcY+gAAsq

Syzbot caught an array out-of-bounds bug [1]. It turns out that when the
BPF program runs through do_misc_fixups(), it allocates an extra 8 bytes
on the call stack, which eventually causes stack_depth to exceed 512.

I was able to reproduce this issue probabilistically by enabling
CONFIG_UBSAN=y and disabling CONFIG_BPF_JIT_ALWAYS_ON with the selfttest
I provide in second patch(although it doesn't happen every time - I didn't
dig deeper into why UBSAN behaves this way).

Furthermore, if I set /proc/sys/net/core/bpf_jit_enable to 0 to disable
the jit, a panic occurs, and the reason is the same, that bpf_func is
assigned an incorrect address.

[---[ end trace ]---
[Oops: general protection fault, probably for non-canonical address
0x100f0e0e0d090808: 0000 [#1] PREEMPT SMP NOPTI
[Tainted: [W]=WARN, [O]=OOT_MODULE
[RIP: 0010:bpf_test_run+0x1d2/0x360
[RSP: 0018:ffffafc7955178a0 EFLAGS: 00010246
[RAX: 100f0e0e0d090808 RBX: ffff8e9fdb2c4100 RCX: 0000000000000018
[RDX: 00000000002b5b18 RSI: ffffafc780497048 RDI: ffff8ea04d601700
[RBP: ffffafc780497000 R08: ffffafc795517a0c R09: 0000000000000000
[R10: 0000000000000000 R11: fefefefefefefeff R12: ffff8ea04d601700
[R13: ffffafc795517928 R14: ffffafc795517928 R15: 0000000000000000
[CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[CR2: 00007f181c064648 CR3: 00000001aa2be003 CR4: 0000000000770ef0
[DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[PKRU: 55555554
[Call Trace:
[ <TASK>
[ ? die_addr+0x36/0x90
[ ? exc_general_protection+0x237/0x430
[ ? asm_exc_general_protection+0x26/0x30
[ ? bpf_test_run+0x1d2/0x360
[ ? bpf_test_run+0x10d/0x360
[ ? __link_object+0x12a/0x1e0
[ ? slab_build_skb+0x23/0x130
[ ? kmem_cache_alloc_noprof+0x2ea/0x3f0
[ ? sk_prot_alloc+0xc2/0x120
[ bpf_prog_test_run_skb+0x21b/0x590
[ __sys_bpf+0x340/0xa80
[ __x64_sys_bpf+0x1e/0x30

---
v1 -> v2:
Directly reject loading programs with a stack size greater than 512 when
jit disabled.(Suggested by Alexei Starovoitov)
https://lore.kernel.org/bpf/20250212135251.85487-1-mrpre@163.com/T/#u

---
Jiayuan Chen (3):
  bpf: Fix array bounds error with may_goto
  selftests/bpf: Allow the program to select specific modes for testing
  selftests/bpf: Add selftest for may_goto

 kernel/bpf/core.c                             | 18 +++++--
 kernel/bpf/verifier.c                         |  7 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  2 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 50 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 27 ++++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

-- 
2.47.1


