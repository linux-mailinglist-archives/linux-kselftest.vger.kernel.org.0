Return-Path: <linux-kselftest+bounces-6354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F887CF2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047BF1C226CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FD376FA;
	Fri, 15 Mar 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU2C5nCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD31B597;
	Fri, 15 Mar 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513888; cv=none; b=OAgtxraozI/QDuQyxLPcNEZiVOie2Vz2XtSM7hdL+KPaHEmrrr+DsLyKouX5e1fCr4UCdc5LiPJKTp0CslpREt1/M3XymmeWtm4NX/wexrxGcU6Jvczp/j7+Wqp49GPw50odvL4n0H8MlFgouPT1cUXMrBdHQXp1s6+gVXbI3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513888; c=relaxed/simple;
	bh=K8NWyhLyI7nRKaKmhQDbTOy488CAWQLbY3vLJLDYOc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GnSmJq/sIhcjeD2Js9Z5QwDnff0rAMMR5ExhlIEzzJaDcJI0Xxm3oBoYd112hUgd1oAMunElPYYnsOYoISyilHsgvWubKiFUow5oF0b65NHCd5//HGdXbKVnDp/RwwIPCH5WmvyA/MC36GzpaVHbN/cVNLoGuORUMdm4nEasEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU2C5nCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4F7C433F1;
	Fri, 15 Mar 2024 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513888;
	bh=K8NWyhLyI7nRKaKmhQDbTOy488CAWQLbY3vLJLDYOc0=;
	h=From:Subject:Date:To:Cc:From;
	b=HU2C5nCF6c4nwBT0gMcjfhHmQiQDU29BSRJzYexzexgZ417Z0+EvBqdIFSrMjFEdy
	 ue5hp1v651tQ4eed/8lAdpgcmkO3aQvHCla1RJ9Tq7iPDv/ORJkHlB4MFCZgUwSqjf
	 JFsXFJsDkeKgFEQ6o/AoAHV9SUe85aUxy04zjOlx42KjTt4yQO8zIwZBlyQ5JSGLFu
	 iZCqfPli146OqKTQl1ZCxTvfTTXbUPQfnO1FA1zy8Cnf3bVlspcYssn2VQ95/BFik1
	 tHFgevsH4OJ4F7vkjfTvTBkS00vM1B6izBPtgVy5tyr2dD/vdwhA8MYBTv2rkyPiXn
	 JKxiG26ppkkcw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v4 0/7] Extend HID-BPF kfuncs (was: allow HID-BPF to do
 device IOs)
Date: Fri, 15 Mar 2024 15:44:37 +0100
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVe9GUC/x3MPQqAMAxA4atIZgNRK4pXEQfbJpqlSos/IN7d4
 vgN7z2QOConGIoHIp+adAsZpizArXNYGNVnQ021oaYyaA2u6tHugoEvlCO4hOyEWk8sfUeQ0z2
 y6P1vx+l9P61PTHRmAAAA
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=4344;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=K8NWyhLyI7nRKaKmhQDbTOy488CAWQLbY3vLJLDYOc0=;
 b=qkR2hKngdkomUDhM6rdvCvhO/34xBRaRLKunbKjNjkYVE7bjvSK0263RoYcUiMNopa/SxbqcZ
 fC6zXMSjT0QCTq3hRsnNF1Wjv7t7JLJZn9MYbrc2P5izarRhupCmvbq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

New version of the sleepable bpf_timer code, without BPF changes, as
they can now go through the HID tree independantly:

https://lore.kernel.org/all/20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org/

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

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc:  <linux-input@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <bpf@vger.kernel.org>
Cc:  <linux-doc@vger.kernel.org>
Cc:  <linux-kselftest@vger.kernel.org>

---
Changes in v4:
- dropped the BPF changes, they can go independently in bpf-core
- dropped the HID-BPF integration tests with the sleppable timers,
  I'll re-add them once both series (this and sleepable timers) are
  merged
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
Benjamin Tissoires (7):
      HID: bpf/dispatch: regroup kfuncs definitions
      HID: bpf: export hid_hw_output_report as a BPF kfunc
      selftests/hid: add KASAN to the VM tests
      selftests/hid: Add test for hid_bpf_hw_output_report
      HID: bpf: allow to inject HID event from BPF
      selftests/hid: add tests for hid_bpf_input_report
      HID: bpf: allow to use bpf_timer_set_sleepable_cb() in tracing callbacks.

 Documentation/hid/hid-bpf.rst                      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 226 ++++++++++++++-------
 drivers/hid/hid-core.c                             |   2 +
 include/linux/hid_bpf.h                            |   3 +
 tools/testing/selftests/hid/config.common          |   1 +
 tools/testing/selftests/hid/hid_bpf.c              | 112 +++++++++-
 tools/testing/selftests/hid/progs/hid.c            |  46 +++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   6 +
 8 files changed, 324 insertions(+), 74 deletions(-)
---
base-commit: 3e78a6c0d3e02e4cf881dc84c5127e9990f939d6
change-id: 20240314-b4-hid-bpf-new-funcs-ecf05d0ef870

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


