Return-Path: <linux-kselftest+bounces-8132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E28A6D71
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73D22857F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54D12D779;
	Tue, 16 Apr 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGujexKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4E12D1F6;
	Tue, 16 Apr 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276599; cv=none; b=H8Pf3cEObOzoY7Wj+bvG8E3gIWzDVX70L9Zrhe5Y2qRjUl/IWmWet5bYwzL0FH3NAS8qJeFfhgcIcBjUud7M1Mq4JecodoH1eo+HgXSvi33B1J4Laq+MN/KWZz05VzniJASyOCLXYpqMPWcD0H2EDlIUBe1AVLX6vZqpj4xkye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276599; c=relaxed/simple;
	bh=h3EAiS8k3GFGGFgo2wRSlPne8LcZjUCKX5witeCyDvM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mL4G6vE2lmgT+mpI0qKcYwU1lD5astl9/itu59fD1Hto+gamJbAAEJLh7+6I8B7eq50EgfvnYQMxVHeb86bT9gmKq28WKnJXR8P0m/VgvtctZytc2Oqg7mghc/8R1OySdCipBOzt7u6o6FRwVNIPuVCoyJmYsSPOMlWImQ0ugVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGujexKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EE1C113CE;
	Tue, 16 Apr 2024 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276598;
	bh=h3EAiS8k3GFGGFgo2wRSlPne8LcZjUCKX5witeCyDvM=;
	h=From:Subject:Date:To:Cc:From;
	b=EGujexKUOPUPVPwyaQb3ZxoAQrw4k7UIKRXvImLH+eoMVkjuWYH6XGRjpIe8jjTaL
	 H2kf25PXpi2XTpXs4su3kHmYVFu7mCZWwky/Kyf4eUUALBMMJtvyEqEM6eL877V13Q
	 cvd0UyZ6OH6gYg2+v3GMrA0Px9E+eDLVYlckQV93DLDeM1lotiE3Q/9BeL9y9t1it2
	 OmcqIL9hDLos7QLCDFMwQh1QzjE69hCbmek7MWRyTA++BU2SNq7tYSqT9YFERQBxBB
	 Fai058dlwONc1U4bEcIAMp4rf5oubDyC5+zZkcrBQGYW+mB31/T8wucBAqyzEm2drw
	 TD8tWdoyA+Ubg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next 00/18] Introduce bpf_wq
Date: Tue, 16 Apr 2024 16:08:13 +0200
Message-Id: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2GHmYC/x3MSwqAIBRG4a3EHSeoGERbiYgev3UnVholiHtPG
 h74OIkCPCNQVyXyeDjw4UqouqJln9wGwWtp0lIbaZQS82nH9xIW2qBdtbENqODTw3L8Rz0VIxz
 iTUPOH2RPHHxiAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=6695;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=h3EAiS8k3GFGGFgo2wRSlPne8LcZjUCKX5witeCyDvM=;
 b=qVmHrSLTRNWp0lUhOROQK1GPq24YDCzxO4Wpi/6HCszD70RUBJoQqEN+pf4Bkau8xS7z73P9k
 vQHglzFQso5CW76NEqvsaUd3tWZdrZIm0PJO9xnsd4VrjJBmacPeUJb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is a followup of sleepable bpf_timer[0].

When discussing sleepable bpf_timer, it was thought that we should give
a try to bpf_wq, as the 2 APIs are similar but distinct enough to
justify a new one.

So here it is.

I tried to keep as much as possible common code in kernel/bpf/helpers.c
but I couldn't get away with code duplication in kernel/bpf/verifier.c.

This series introduces a basic bpf_wq support:
- creation is supported
- assignment is supported
- running a simple bpf_wq is also supported.

We will probably need to extend the API further with:
- a full delayed_work API (can be piggy backed on top with a correct
  flag)
- bpf_wq_cancel()
- bpf_wq_cancel_sync() (for sleepable programs)
- documentation

But for now, let's focus on what we currently have to see if it's worth
it compared to sleepable bpf_timer.

FWIW, I still have a couple of concerns with this implementation:
- I'm explicitely declaring the async callback as sleepable or not
  (BPF_F_WQ_SLEEPABLE) through a flag. Is it really worth it?
  Or should I just consider that any wq is running in a sleepable
  context?
- bpf_wq_work() access ->prog without protection, but I think this might
  be racing with bpf_wq_set_callback(): if we have the following:

  CPU 0                                     CPU 1
  bpf_wq_set_callback()
  bpf_start()
                                            bpf_wq_work():
                                              prog = cb->prog;

  bpf_wq_set_callback()
    cb->prog = prog;
    bpf_prog_put(prev)
    rcu_assign_ptr(cb->callback_fn,
                   callback_fn);
                                           callback = READ_ONCE(w->cb.callback_fn);

  As I understand callback_fn is fine, prog might be, but we clearly
  have an inconstency between "prog" and "callback_fn" as they can come
  from 2 different bpf_wq_set_callback() calls.

IMO we should protect this by the async->lock, but I'm not sure if
  it's OK or not.

---

For reference, the use cases I have in mind:

---

Basically, I need to be able to defer a HID-BPF program for the
following reasons (from the aforementioned patch):
1. defer an event:
   Sometimes we receive an out of proximity event, but the device can not
   be trusted enough, and we need to ensure that we won't receive another
   one in the following n milliseconds. So we need to wait those n
   milliseconds, and eventually re-inject that event in the stack.

2. inject new events in reaction to one given event:
   We might want to transform one given event into several. This is the
   case for macro keys where a single key press is supposed to send
   a sequence of key presses. But this could also be used to patch a
   faulty behavior, if a device forgets to send a release event.

3. communicate with the device in reaction to one event:
   We might want to communicate back to the device after a given event.
   For example a device might send us an event saying that it came back
   from sleeping state and needs to be re-initialized.

Currently we can achieve that by keeping a userspace program around,
raise a bpf event, and let that userspace program inject the events and
commands.
However, we are just keeping that program alive as a daemon for just
scheduling commands. There is no logic in it, so it doesn't really justify
an actual userspace wakeup. So a kernel workqueue seems simpler to handle.

bpf_timers are currently running in a soft IRQ context, this patch
series implements a sleppable context for them.

Cheers,
Benjamin

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: John Fastabend <john.fastabend@gmail.com>
To: KP Singh <kpsingh@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
To: Hao Luo <haoluo@google.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Mykola Lysenko <mykolal@fb.com>
To: Shuah Khan <shuah@kernel.org>
Cc:  <bpf@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-kselftest@vger.kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

[0] https://lore.kernel.org/all/20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org/

---
Benjamin Tissoires (18):
      bpf: trampoline: export __bpf_prog_enter/exit_recur
      bpf: make timer data struct more generic
      bpf: replace bpf_timer_init with a generic helper
      bpf: replace bpf_timer_set_callback with a generic helper
      bpf: replace bpf_timer_cancel_and_free with a generic helper
      bpf: add support for bpf_wq user type
      tools: sync include/uapi/linux/bpf.h
      bpf: add support for KF_ARG_PTR_TO_WORKQUEUE
      bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps
      selftests/bpf: add bpf_wq tests
      bpf: wq: add bpf_wq_init
      tools: sync include/uapi/linux/bpf.h
      selftests/bpf: wq: add bpf_wq_init() checks
      bpf/verifier: add is_sleepable argument to push_callback_call
      bpf: wq: add bpf_wq_set_callback_impl
      selftests/bpf: add checks for bpf_wq_set_callback()
      bpf: add bpf_wq_start
      selftests/bpf: wq: add bpf_wq_start() checks

 include/linux/bpf.h                                |  17 +-
 include/linux/bpf_verifier.h                       |   1 +
 include/uapi/linux/bpf.h                           |  13 +
 kernel/bpf/arraymap.c                              |  18 +-
 kernel/bpf/btf.c                                   |  17 +
 kernel/bpf/hashtab.c                               |  55 ++-
 kernel/bpf/helpers.c                               | 371 ++++++++++++++++-----
 kernel/bpf/syscall.c                               |  16 +-
 kernel/bpf/trampoline.c                            |   6 +-
 kernel/bpf/verifier.c                              | 195 ++++++++++-
 tools/include/uapi/linux/bpf.h                     |  13 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   7 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |  41 +++
 tools/testing/selftests/bpf/progs/wq.c             | 192 +++++++++++
 tools/testing/selftests/bpf/progs/wq_failures.c    | 197 +++++++++++
 17 files changed, 1052 insertions(+), 113 deletions(-)
---
base-commit: ffa6b26b4d8a0520b78636ca9373ab842cb3b1a8
change-id: 20240411-bpf_wq-fe24e8d24f5e

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


