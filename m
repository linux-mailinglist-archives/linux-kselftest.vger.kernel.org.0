Return-Path: <linux-kselftest+bounces-8533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266988ABA6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420FE1C21303
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242914A98;
	Sat, 20 Apr 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZcnaI8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255DD53C;
	Sat, 20 Apr 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604163; cv=none; b=bYsb1sUFdY6XSmy6SeoAM4kjzyoCYWkQO7EnP+I/O0YfmhEV8XsrFXYx2NfZXLFO0V6wpHhsyzEIKlur1D2iFkrHUgD2S1fD9zo7iJFqxokqnE6Z3XsHnZl5oi25Rox+gErFVh3/Y5UBU0b/1gY8qAA7E4vEtfJOB9QwQIEjBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604163; c=relaxed/simple;
	bh=lMNd04PH70VJ8BbtsBjx5/0JyR5iGBUmUVGPD2gWB3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UEq+KbldaofAhEHbY5M8JEgZYaUzOIGyJz9lX4xf+PaNEsDl5Fg4rZV0C9u7Iaglov/D4/aOkHebnt5fTtgsTSsEUUIPrj60N8FOaZ75ioztIxAb+UoWylKBMkL+8S/OleAFR30E73i2U+gm4l03ZBdJSqbnh7Kz0pBpvxA89ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZcnaI8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B1C072AA;
	Sat, 20 Apr 2024 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604163;
	bh=lMNd04PH70VJ8BbtsBjx5/0JyR5iGBUmUVGPD2gWB3g=;
	h=From:Subject:Date:To:Cc:From;
	b=nZcnaI8Pfr55oXswnzJSscsNDJr3Whs52+KLMhI6vGsuUUIdzxSyfNuquM+GCBf2E
	 yF9gWnX+sWbERSOdSWcqIusH57Pqq4tCm1m+xKp1debpDRGIrhNryJhk+M50p+nQ7B
	 +B7tvQ0UY8ki2LGSzBBaT4VgTnz86cul0hnMoNxt4i9r4y2Er0sDwznTr8z3dKrbTf
	 PZRJHeEAqGx0Wzgvu/qSgf9fezS/v+dRtC6oh6IXib4kWt1nP06jHoCjE5H9fMrQNN
	 29o4lCSIFhTGBwi4FYRugKGk33JNyvH+iejzsbCp9gnvvtIBDfu3VCjHllC8ca5ZZp
	 0KcwRlQOw5rGw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next v2 00/16] Introduce bpf_wq
Date: Sat, 20 Apr 2024 11:09:00 +0200
Message-Id: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACyGI2YC/zWNQQrCMBBFr1JmbSQZYmhdeQ8pou2kDUraTkqsl
 NzdEHT5+I/3dwjEjgKcqx2Yogtu8hnwUEE33v1AwvWZASVqqZUSj9ne3ouwhJrqHrU9EWR5ZrJ
 uK6ErZEd42lZo8zK6sE78KQ9Rlf0XM/9YVEKKriFjZIO21nh5Ent6HSceoE0pfQFpe9T0pwAAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=5498;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lMNd04PH70VJ8BbtsBjx5/0JyR5iGBUmUVGPD2gWB3g=;
 b=nsie3dbPHMSelr+XPU9LC7QMIXUaQ4hJnLXU7F80ksmlItwtBxX76oQAqNNkfBSMcQ8uXw8Qk
 r6dOLzoYCKFCMH1wW7WeboIkfi2oIVPvIdlg4MqtNl3iBW4qjDFzQcA
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
- bpf_wq_cancel() <- apparently not, this is shooting ourself in the
  foot
- bpf_wq_cancel_sync() (for sleepable programs)
- documentation

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
Changes in v2:
- took previous review into account
- mainly dropped BPF_F_WQ_SLEEPABLE
- Link to v1: https://lore.kernel.org/r/20240416-bpf_wq-v1-0-c9e66092f842@kernel.org

---
Benjamin Tissoires (16):
      bpf: make timer data struct more generic
      bpf: replace bpf_timer_init with a generic helper
      bpf: replace bpf_timer_set_callback with a generic helper
      bpf: replace bpf_timer_cancel_and_free with a generic helper
      bpf: add support for bpf_wq user type
      tools: sync include/uapi/linux/bpf.h
      bpf: verifier: bail out if the argument is not a map
      bpf: add support for KF_ARG_PTR_TO_WORKQUEUE
      bpf: allow struct bpf_wq to be embedded in arraymaps and hashmaps
      selftests/bpf: add bpf_wq tests
      bpf: wq: add bpf_wq_init
      selftests/bpf: wq: add bpf_wq_init() checks
      bpf: wq: add bpf_wq_set_callback_impl
      selftests/bpf: add checks for bpf_wq_set_callback()
      bpf: add bpf_wq_start
      selftests/bpf: wq: add bpf_wq_start() checks

 include/linux/bpf.h                                |  13 +-
 include/linux/bpf_verifier.h                       |   1 +
 include/uapi/linux/bpf.h                           |   4 +
 kernel/bpf/arraymap.c                              |  18 +-
 kernel/bpf/btf.c                                   |  17 +
 kernel/bpf/hashtab.c                               |  55 +++-
 kernel/bpf/helpers.c                               | 348 ++++++++++++++++-----
 kernel/bpf/syscall.c                               |  15 +-
 kernel/bpf/verifier.c                              | 154 ++++++++-
 tools/include/uapi/linux/bpf.h                     |   4 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   7 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |  41 +++
 tools/testing/selftests/bpf/progs/wq.c             | 186 +++++++++++
 tools/testing/selftests/bpf/progs/wq_failures.c    | 144 +++++++++
 16 files changed, 910 insertions(+), 103 deletions(-)
---
base-commit: ffa6b26b4d8a0520b78636ca9373ab842cb3b1a8
change-id: 20240411-bpf_wq-fe24e8d24f5e

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


