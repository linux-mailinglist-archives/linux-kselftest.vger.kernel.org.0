Return-Path: <linux-kselftest+bounces-4413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B384F5CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31A81C22865
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0645381B9;
	Fri,  9 Feb 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja+L/hzC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8568381AB;
	Fri,  9 Feb 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485219; cv=none; b=p/AKrvuV5VRGfU5saNa35Dghvmgpv6O6KEoN+AQOn1cNLjIzTpHefihxIsOKhjAOPK1fZIT4g2HX9mFGrWPY8KoxVKGYFHJCZhNKn/QnmdDUWRK0y24DTVbM68SoyMmakPMiZb6xwhJuejymiv59pMq5QFCgxbA5tj3nniDi4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485219; c=relaxed/simple;
	bh=8IX2N2h65z8bAcntZCj/CAlG/Kp2DF4kgs8uNZri5rg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/dber8vxEh7StB6WI3GCyP3BalP4vpp6qsxsrRZ2PGdGREjLtGfCDYPkJoYM/kSYK65aC5cmwJBuST61krO5ZL3rS8ME2osgAN0rBiZEYB2YDGZGW4ZcPFc+74DlhLpHxDFd/hCRdRGUGoOhDk3W7EibsF2hX4UwYKg0AiHICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja+L/hzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B602C433C7;
	Fri,  9 Feb 2024 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485219;
	bh=8IX2N2h65z8bAcntZCj/CAlG/Kp2DF4kgs8uNZri5rg=;
	h=From:Subject:Date:To:Cc:From;
	b=ja+L/hzC1LhZBlrmM4uSiseYZKw3elOp9LutP91aZ2IRGM7kXCjziuciAfT3Eb7Xu
	 YJFxgXOGcBw2/0RfZJSoEmKezeIzmaX9jXczqkVRZppvOn6FTi+9S0SUnDbme37WCz
	 Ghn1XsGVI1bjoxyFPFibKmBaZLqwFiT0YD86LWHk2+tf+NR1j08cFwfNEbbAG29VS3
	 BoU1AQoBRa6EuClA9yS53p3vFJRZkKsSHs9qvr+JBe2fNWzDQJmw0chXsiCTC8sk4p
	 /vFTTNpLgEP617DbdY+Njo4NJiTB7XNZmmnbFLYR96pqyxC1RKevmVPjRtP0YIn/sp
	 oaj5NVc1tN3HQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
Date: Fri, 09 Feb 2024 14:26:36 +0100
Message-Id: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwoxmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNT3YzMFN2kgjTd4pzU1ILEpJxU3WQDQyMzg7QUS8NkEyWgvoKi1LT
 MCrCZ0UpBbs4gMZCOvNSKEqXY2loAhthL/3QAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=3730;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8IX2N2h65z8bAcntZCj/CAlG/Kp2DF4kgs8uNZri5rg=;
 b=TCPa9wsHuck9jcfAEgJA+AsKZL2j14DUUlj25PGn+fAsD2pTBhbWY+KbtXIb0qv1Mgn+GoDRh
 9HGArX7yzA7AwFOb9w+2R6/ll4PrNhZDstlPVIgbADE5w47blYykXFm
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

[Putting this as a RFC because I'm pretty sure I'm not doing the things
correctly at the BPF level.]
[Also using bpf-next as the base tree as there will be conflicting
changes otherwise]

Ideally I'd like to have something similar to bpf_timers, but not
in soft IRQ context. So I'm emulating this with a sleepable
bpf_tail_call() (see "HID: bpf: allow to defer work in a delayed
workqueue").

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

Besides the "this is insane to reimplement the wheel", the other part I'm
not sure is whether we can say that BPF maps of type prog_array and of
type queue/stack can be used in sleepable context.
I don't see any warning when running the test programs, but that's probably
not a guarantee I'm doing the things properly :)

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (9):
      bpf: allow more maps in sleepable bpf programs
      HID: bpf/dispatch: regroup kfuncs definitions
      HID: bpf: export hid_hw_output_report as a BPF kfunc
      selftests/hid: Add test for hid_bpf_hw_output_report
      HID: bpf: allow to inject HID event from BPF
      selftests/hid: add tests for hid_bpf_input_report
      HID: bpf: allow to defer work in a delayed workqueue
      selftests/hid: add test for hid_bpf_schedule_delayed_work
      selftests/hid: add another set of delayed work tests

 Documentation/hid/hid-bpf.rst                      |  26 +-
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c      |   8 +
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h    | 236 +++++++++------
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 315 ++++++++++++++++-----
 drivers/hid/bpf/hid_bpf_jmp_table.c                |  34 ++-
 drivers/hid/hid-core.c                             |   2 +
 include/linux/hid_bpf.h                            |  10 +
 kernel/bpf/verifier.c                              |   3 +
 tools/testing/selftests/hid/hid_bpf.c              | 286 ++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 205 ++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   8 +
 11 files changed, 962 insertions(+), 171 deletions(-)
---
base-commit: 4f7a05917237b006ceae760507b3d15305769ade
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


