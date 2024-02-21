Return-Path: <linux-kselftest+bounces-5183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE66F85E2FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C121F25565
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0981759;
	Wed, 21 Feb 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7VmYAdG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAB81727;
	Wed, 21 Feb 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532724; cv=none; b=K/jUXswQUCWXaQjKeJBwViS+IUb5iFI/Gs6Y8QCJVDuWa8SB3yXtI8pJHDtf7deRLeD0B8JKfD+vs4m+W6bg8iT6XFI4YuadsSQkOfm0adbldIm75TrJ/4cs+PeERqzGsntqdjUn6PzM9iwBni7kp4PUzPV6feFuuF8rzIRnS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532724; c=relaxed/simple;
	bh=zRZq7ktIelCZZWJLLT8Fm+ahdGyQ/siOzgpKQQJWNz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d3YN/IojyFSgXJZ5RnxXUjIPTw86u5bf619adr7O5JQpF0FeF3YyeUhsfmBYJwE2H1MpYkefTYrgf90GuUvG9LYsHQn9Ji0jYp68//FzPZbjH0wXdamz2kJacN12ezFOKKiNKfP8u6fltL7daMaBsNri056lVVJ8APaf3tne/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7VmYAdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EFDC433C7;
	Wed, 21 Feb 2024 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532724;
	bh=zRZq7ktIelCZZWJLLT8Fm+ahdGyQ/siOzgpKQQJWNz8=;
	h=From:Subject:Date:To:Cc:From;
	b=J7VmYAdGn2jUz4zfl8Q1nrvAFDCMu33mXMDJumE3auykorUG6ptw9I3uoM8F2Xxu9
	 ywwCB8q72c/PkSEpeHZB7+M1tG2lhQzH7wkvHR01yKaQk6SITWhmBp2rmTHQQs8Yi4
	 rUDZAJpRSORoiIz7PXIHmAEBGp+tKw1P4d0xIATwQI+21JZ/wIz+Yh538GFbA3rC2w
	 UPpuz0NdZGYrcenQ47c5qLvx6EGVdre+ob3iXI1Vd4e5slKW4gbSwkqd4OeCR7yldu
	 xGF7jb20SvqRkTLVZlGKp0kmZTj9/q8izfV0I2wgzeXGwLAKQk4YaLlZDWBCcOLYe4
	 aBB+MPE1O5U9g==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC bpf-next v3 00/16] sleepable bpf_timer (was: allow
 HID-BPF to do device IOs)
Date: Wed, 21 Feb 2024 17:25:16 +0100
Message-Id: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwj1mUC/23NQQrCMBAF0KvIrI0kMWmtK0HwAG7FRZNM22BJS
 1JCpfTupsWFQpf/M//NBAG9xQDn3QQeow22cykc9zvQTelqJNakDJxyQTmVpLGGqL4ioUXsS9U
 i0ZTxjFamYFpA2vUeKzuu5gPut+vSLQuH4wDPFBobhs6/15+RrWdfvtjgIyOUCK1PhVSyNMpcX
 ugdtofO1ysX+Q/BxBbBEyFzmSkqRc7FPzHP8wc3GdM5BwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=5588;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=zRZq7ktIelCZZWJLLT8Fm+ahdGyQ/siOzgpKQQJWNz8=;
 b=Syk9/ZSBxBEt26q6j5DdxWU1oXWH+kMI3/GAMo63FMLAWFUnwvT3WuDR4vVGJe2WRI69d3JDF
 mwgq7Sp08fFAN9VvpswTg23wXbBgheQFqyl+trA1lwwGax8ra3jMQI1
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

[Partly a RFC/formal submission: there are still FIXMEs in the code]
[Also using bpf-next as the base tree for HID changes as there will
be conflicting changes otherwise, so I'm personaly fine for the HID
commits to go through bpf-next]

IMO, patches 1-3 and 9-14 are ready to go, rest is still pending review.

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
Benjamin Tissoires (16):
      bpf/verifier: allow more maps in sleepable bpf programs
      bpf/verifier: introduce in_sleepable() helper
      bpf/verifier: add is_async_callback_calling_insn() helper
      bpf/helpers: introduce sleepable bpf_timers
      bpf/verifier: add bpf_timer as a kfunc capable type
      bpf/helpers: introduce bpf_timer_set_sleepable_cb() kfunc
      bpf/helpers: mark the callback of bpf_timer_set_sleepable_cb() as sleepable
      bpf/verifier: do_misc_fixups for is_bpf_timer_set_sleepable_cb_kfunc
      HID: bpf/dispatch: regroup kfuncs definitions
      HID: bpf: export hid_hw_output_report as a BPF kfunc
      selftests/hid: Add test for hid_bpf_hw_output_report
      HID: bpf: allow to inject HID event from BPF
      selftests/hid: add tests for hid_bpf_input_report
      HID: bpf: allow to use bpf_timer_set_sleepable_cb() in tracing callbacks.
      selftests/hid: add test for bpf_timer
      selftests/hid: add KASAN to the VM tests

 Documentation/hid/hid-bpf.rst                      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 232 ++++++++++++++-------
 drivers/hid/hid-core.c                             |   2 +
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/hid_bpf.h                            |   3 +
 include/uapi/linux/bpf.h                           |   4 +
 kernel/bpf/helpers.c                               | 140 +++++++++++--
 kernel/bpf/verifier.c                              | 114 ++++++++--
 tools/testing/selftests/hid/config.common          |   1 +
 tools/testing/selftests/hid/hid_bpf.c              | 195 ++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 198 ++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   8 +
 12 files changed, 795 insertions(+), 106 deletions(-)
---
base-commit: 5c331823b3fc52ffd27524bf5b7e0d137114f470
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


