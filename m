Return-Path: <linux-kselftest+bounces-6346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982487CED4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5429A1C20B94
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A53717C;
	Fri, 15 Mar 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+PdkJOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B833A1B5;
	Fri, 15 Mar 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512978; cv=none; b=PLzeHHptjIKeiKzoYkLCxCRop2a5AruwWRwKIAgPrnYI8Vgr5ocBP0OJEhL5iNykUL3S7KjcHP6Le/q+jnlQdfqOtT+ZhLaRPP3EVK6Ub5sw8YHQ1ok7ptFHHa0AOqJhYtSapwHenjUNHeC7mFhy/wdX8jPdTpoGXvc2OjSSr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512978; c=relaxed/simple;
	bh=1ba924wm8H+J/VP0musS5De3pBR+nFdLLCYlvLpXQLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J9/d1xJtvVa41HWAm5N0eRyTEAo07ah7k+kbwlHtLPpQLkqXvrdnBTLXONZ8JrLlKtiPtScJTXx5Fxm8zdPoaWCRROs/35Q6gXS2tRhV8kYotLhB/o6Y2AE6lMGrkEWdFmDaQP/zAOIvyxUz3Nu1MfgpPp6OQGB1y4PC56U7wXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+PdkJOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD84C43394;
	Fri, 15 Mar 2024 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512977;
	bh=1ba924wm8H+J/VP0musS5De3pBR+nFdLLCYlvLpXQLI=;
	h=From:Subject:Date:To:Cc:From;
	b=M+PdkJOPfSmxj4+10sBOVzWow9lG4Iv598TfMtzagZf45HoQ8j694v7UKhzRD8vuw
	 BXgqmrRsuouIyuoulDx5/KsGx3vfP30xGIhfVXMyKyDETwueUlLzRtsX/dZD9zk1LK
	 338w1U28n0tm0en7Ero4tnCHOJompXKTDk1ww9pbDQwqvqQGdmnQmh1+FCAH3yLzQh
	 l89v4ZSvTUg2OLXyVqUPV+eP3ypvdPKbnq1nwWiy8fb6ohoGJtZyK3uKN7kG1pv7/W
	 CoVoMlQWK3euuNRl4+nhdiPRVMVLA+La7wsJo5PN7+CbWNutCNI3xQM5DZmUPt3x+9
	 YJF6d6jMbJKHQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next v4 0/6] sleepable bpf_timer (was: allow HID-BPF to
 do device IOs)
Date: Fri, 15 Mar 2024 15:29:24 +0100
Message-Id: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERb9GUC/23Nyw7CIBAF0F8xrMUAhT5c+R/GBY+hJTa0gaapa
 frvInFRY5c3d+6ZFUUIDiK6nlYUYHbRDT4Ffj4h3UnfAnYmZcQI44QRgTtnsBotjj3AKFUPWBP
 KSmJNQzVHaTcGsG7J5h19Tj0sE3qkpnNxGsIrP5tp7r9uc+DOFBPMta4boYQ0ytyeEDz0lyG0m
 ZvZjqD8iGCJEJUoFRG8YvyfKHYEo0dEkQhqVVHVWpYFoT/Etm1vMnf260MBAAA=
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710512973; l=4636;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=1ba924wm8H+J/VP0musS5De3pBR+nFdLLCYlvLpXQLI=;
 b=sav/9qNPwA9ZtLUXSrg5FXA4Oawm7aJRfq4uJaFqM3sVlqdMgezCd0eTAETobBNwbkmfs7Z9B
 e2w7pupjnijCHXLDnAO2X9HN+MJ2kvH8cKfhz4rv7f99Nhq8uMbaRQZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

New version of the sleepable bpf_timer code, without the HID changes, as
they can now go through the HID tree independantly.

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
Cc:  <bpf@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-kselftest@vger.kernel.org>

---
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
Benjamin Tissoires (6):
      bpf/helpers: introduce sleepable bpf_timers
      bpf/verifier: add bpf_timer as a kfunc capable type
      bpf/helpers: introduce bpf_timer_set_sleepable_cb() kfunc
      bpf/helpers: mark the callback of bpf_timer_set_sleepable_cb() as sleepable
      tools: sync include/uapi/linux/bpf.h
      selftests/bpf: add sleepable timer tests

 include/linux/bpf_verifier.h                       |   1 +
 include/uapi/linux/bpf.h                           |   4 +
 kernel/bpf/helpers.c                               | 132 ++++++++++++++++++++-
 kernel/bpf/verifier.c                              |  92 +++++++++++++-
 tools/include/uapi/linux/bpf.h                     |   4 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   4 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |   1 +
 tools/testing/selftests/bpf/progs/timer.c          |  40 ++++++-
 tools/testing/selftests/bpf/progs/timer_failure.c  | 114 +++++++++++++++++-
 11 files changed, 387 insertions(+), 11 deletions(-)
---
base-commit: 9187210eee7d87eea37b45ea93454a88681894a4
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


