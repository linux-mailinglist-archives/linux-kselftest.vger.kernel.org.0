Return-Path: <linux-kselftest+bounces-7376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F7889B9BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C99F1F21230
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18062C68C;
	Mon,  8 Apr 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4E9K6Pr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AC381AA;
	Mon,  8 Apr 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563791; cv=none; b=JCTVTr2S0qhjzcDh4aBGDVkuTTwYxX0Ms1zH7dN4bUA/49xaanAu4sxZAODaO8kfisj18Wj561Ae1YMc8E+U0jkWqLM3hieoW3DTQE1U5OebqgG1FMdsdZlBYi6pW1Mr9jDeiu0TRdiAjFD3JCytRuU6IGaFwKEpAq6q1JE/IrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563791; c=relaxed/simple;
	bh=opoiP/Rbs+qNBZARkVbOAqI4I6o0EeLA/hNQduTWd+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DuKCrpPWI4Y38rO9xus8BonWVmnVdiCpxnufHpEx2CMYYouBUZrNtSevhEI1mGMpuRgbg5xY2fzKSe3qBiaXHrMdY+R1zl9okWqY9WF4qnP8/cNxWGmmsFSuFlQUX0mjfH+bS19grEJf63iVkJaCWpQ0f5aN1954cBRo52A4mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4E9K6Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B087C433F1;
	Mon,  8 Apr 2024 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563791;
	bh=opoiP/Rbs+qNBZARkVbOAqI4I6o0EeLA/hNQduTWd+M=;
	h=From:Subject:Date:To:Cc:From;
	b=o4E9K6Pr1sSZu7Q9snc9oekJ5JLvoH/H3Q7O+/mCHpRM7HY422mZg7Av47VJ5SyM4
	 VpA0eAHHmujovdaFp/j2SaNxm5hU0jpMDnrEmkwayoCihH2RKTFb8fqw3XdWd/OWar
	 x1ad5+rLtBQp6yfZcS4kvOchRjVBgF5UX3wQvifkM485Krhd5547KuxAEnruBr0Uyy
	 KvcIrnj4fBDI4xZDomfNA4DXxK5XmgrVc+Q5V7zTJSJ6x7mLLw/roHqh8yZOX1qJgm
	 p6p4XICtFQArZWJkkXzo/C4WYzy7mQJB9QLMk/3c8PWUszVADlHltg47ZeJJGSL0yz
	 kKTGLKXwGllFw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC bpf-next v6 0/6] sleepable bpf_timer (was: allow
 HID-BPF to do device IOs)
Date: Mon, 08 Apr 2024 10:09:25 +0200
Message-Id: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADamE2YC/23QzWrDMAwH8FcpPs/DViwn2Wkw2AP0Onbwh9KYh
 iQ4xbSUvPucMFhGcvwL6SehJ5soBprY2+nJIqUwhaHPQb+cmGtNfyEefM4MBCgBAnkbPLdjw6e
 OaDS2I+6EBC0aX0unWJ4bIzXhvppf7Pz5sdSWiZ7uN/adQxum2xAf684k17Zfvj7gk+SCK+eqG
 i0ab/37lWJP3esQLyuXYENIdURAJrBEbQWqEtSeKDYEyCOiyIRsbFFWzuhCyB2h/ohCHv0pqeU
 KjVUDqARqtSNwQwAcEbhcUdautFiTMeYfMc/zD6BWpgLQAQAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=5180;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=opoiP/Rbs+qNBZARkVbOAqI4I6o0EeLA/hNQduTWd+M=;
 b=DmSpZ5TNjcfhuBTdcxC3bYuZ6RRZ/C8vn1jSU2NZtn4ezrBoy6p8M9BvEsarXWB7hFDQfhkJR
 WsqBjmeliW7Ab+hL/I7o/+0rpNEPskjQ/eiNNmDSoulugHqJZUuVdGD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

New version of the sleepable bpf_timer code.

I'm posting this as this is the result of the previous review, so we can
have a baseline to compare to.

The plan is now to introduce a new user API struct bpf_wq, as the timer
API working on softIRQ seems to be quite far away from a wq.

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
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: <bpf@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-kselftest@vger.kernel.org>

---
Changes in v6:
- Use of a workqueue to clean up sleepable timers
- integrated Kumar's patch instead of mine
- Link to v5: https://lore.kernel.org/r/20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org

Changes in v5:
- took various reviews into account
- rewrote the tests to be separated to not have a uggly include
- Link to v4: https://lore.kernel.org/r/20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org

Changes in v4:
- dropped the HID changes, they can go independently from bpf-core
- addressed Alexei's and Eduard's remarks
- added selftests
- Link to v3: https://lore.kernel.org/r/20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org

Changes in v3:
- fixed the crash from v2
- changed the API to have only BPF_F_TIMER_SLEEPABLE for
  bpf_timer_start()
- split the new kfuncs/verifier patch into several sub-patches, for
  easier reviews
- Link to v2: https://lore.kernel.org/r/20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org

Changes in v2:
- make use of bpf_timer (and dropped the custom HID handling)
- implemented bpf_timer_set_sleepable_cb as a kfunc
- still not implemented global subprogs
- no sleepable bpf_timer selftests yet
- Link to v1: https://lore.kernel.org/r/20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org

---
Benjamin Tissoires (5):
      bpf/helpers: introduce sleepable bpf_timers
      bpf/helpers: introduce bpf_timer_set_sleepable_cb() kfunc
      bpf/helpers: mark the callback of bpf_timer_set_sleepable_cb() as sleepable
      tools: sync include/uapi/linux/bpf.h
      selftests/bpf: add sleepable timer tests

Kumar Kartikeya Dwivedi (1):
      bpf: Add support for KF_ARG_PTR_TO_TIMER

 include/linux/bpf_verifier.h                       |   1 +
 include/uapi/linux/bpf.h                           |  13 ++
 kernel/bpf/helpers.c                               | 202 ++++++++++++++++---
 kernel/bpf/verifier.c                              |  98 +++++++++-
 tools/include/uapi/linux/bpf.h                     |  20 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |  34 ++++
 .../testing/selftests/bpf/progs/timer_sleepable.c  | 213 +++++++++++++++++++++
 10 files changed, 553 insertions(+), 39 deletions(-)
---
base-commit: 61df575632d6b39213f47810c441bddbd87c3606
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


