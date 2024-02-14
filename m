Return-Path: <linux-kselftest+bounces-4658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5CF854FBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13CE1C21752
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64B47D418;
	Wed, 14 Feb 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx0HSkx1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1126A002;
	Wed, 14 Feb 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931140; cv=none; b=csKW+ARMcoAXc+oCedrNqXyhvQ7Ca2iy6jWHXGExPHG1s7o+qeZVe2NmepQ2c/fpJv0O5pxbfwpKWVLHmaxi7nKgsEDfcbCvkKO6cYtQxUPJ6li729CU05cUhuGhrP86P9S/C9mgrFFWXwsOiS+uSCsg5O3KEz7l+bsDnlc2RuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931140; c=relaxed/simple;
	bh=l4jPudJnwEihlvPPrQPrGvmbzUPliLgvg6nSOC6YQe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jROi+tTVeAd1zRaWhbBEJBxYv/btedw4zs9Z+z184UhiKxj5MxM1a9r+uKq3UxHbvGYAMMhj+qyA5BAEr+uY7bJHCD7LNLmFAw7nu1LpF2sYZ9r0XA979eNoKLDVVkyM6dSNmj69mexwp7Huk4Rl4kaH5NYNtHOUYHTdY5EeKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx0HSkx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A79C433F1;
	Wed, 14 Feb 2024 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931140;
	bh=l4jPudJnwEihlvPPrQPrGvmbzUPliLgvg6nSOC6YQe0=;
	h=From:Subject:Date:To:Cc:From;
	b=hx0HSkx1O1vfzja/tcyeZbnl6f8DBH6HsvtBo3ONzOetV9It+308217dhB44DWKtj
	 185FjCFdmK4w50Q/Fodsi68L4Fzq2BbLu8VCWU/WBn5Wj62Qw9ytHq53Xa8s3BZS0I
	 +NVewubwnkk+oH7tKIog+zZDjKF2k0lSfburOYaN4ClYy9K0umRFBp7WjCkbze9CXU
	 L76vSRCcAVrO1RjrasfJd3lJdqtd+iIL/36BM4xsNB6KbYTqezPlesT6IV6YZpUN8z
	 KJAeRmL6EN9ZeCFbkeIGFW86Jundzi80P3xleNLsmhR4lCaWaLrcODAwze5HYhzffX
	 KhqgKoNs1do4w==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC bpf-next v2 00/10] allow HID-BPF to do device IOs
Date: Wed, 14 Feb 2024 18:18:29 +0100
Message-Id: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOX1zGUC/22NzQqDMBCEX0X23C1J0FJ7Kgh9gF6Lh/ysulSiJ
 CIW8d0bpccev2HmmxUiBaYIt2yFQDNHHnwCdcrAdtq3hOwSgxIqF0oU2LFDMzYYe6JRm57QCqk
 uonGltDmk3Rio4eVwvuD5qPZsX3haJqgTdBynIXyOz1ketZ++/KOfJQrMrb2WhSm0M+7+puCpP
 w+hhXrbti9T1WMxxAAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=4831;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=l4jPudJnwEihlvPPrQPrGvmbzUPliLgvg6nSOC6YQe0=;
 b=hDh4ILe9/u3jIkDCjyvSuvoJvM06QQCqlwjQWjY8/CM4pM6y+4TuGu4kVCvcawjJhIlrsZ1Ea
 vihnZbrsM5AAHQJuhsj1rOE9w9lWKerP8iZ7fltXljCYW50rWrsGdZ8
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

[Still a RFC: there are a lot of FIXMEs in the code, and
calling the sleepable timer cb actually crashes.]
[Also using bpf-next as the base tree as there will be conflicting
changes otherwise]

This is crashing, and I have a few questions in the code (look for all
of the FIXMEs), so sending this now before I become insane :)

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

The other part I'm not sure is whether we can say that BPF maps of type
queue/stack can be used in sleepable context.
I don't see any warning when running the test programs, but that's probably
not a guarantee I'm doing the things properly :)

Cheers,
Benjamin

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: KP Singh <kpsingh@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
To: Hao Luo <haoluo@google.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuah@kernel.org>
Cc:  <bpf@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-input@vger.kernel.org>
Cc:  <linux-doc@vger.kernel.org>
Cc:  <linux-kselftest@vger.kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---
Changes in v2:
- make use of bpf_timer (and dropped the custom HID handling)
- implemented bpf_timer_set_sleepable_cb as a kfunc
- still not implemented global subprogs
- no sleepable bpf_timer selftests yet
- Link to v1: https://lore.kernel.org/r/20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org

---
Benjamin Tissoires (10):
      bpf/verifier: introduce in_sleepable() helper
      bpf/helpers: introduce sleepable timers
      bpf/verifier: allow more maps in sleepable bpf programs
      HID: bpf/dispatch: regroup kfuncs definitions
      HID: bpf: export hid_hw_output_report as a BPF kfunc
      selftests/hid: Add test for hid_bpf_hw_output_report
      HID: bpf: allow to inject HID event from BPF
      selftests/hid: add tests for hid_bpf_input_report
      HID: bpf: allow to use bpf_timer_set_sleepable_cb() in tracing callbacks.
      selftests/hid: add test for bpf_timer

 Documentation/hid/hid-bpf.rst                      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 232 ++++++++++++++-------
 drivers/hid/hid-core.c                             |   2 +
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/hid_bpf.h                            |   3 +
 include/uapi/linux/bpf.h                           |  12 ++
 kernel/bpf/helpers.c                               | 105 +++++++++-
 kernel/bpf/verifier.c                              |  91 +++++++-
 tools/testing/selftests/hid/hid_bpf.c              | 195 ++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 198 ++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   8 +
 11 files changed, 756 insertions(+), 94 deletions(-)
---
base-commit: 4f7a05917237b006ceae760507b3d15305769ade
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


