Return-Path: <linux-kselftest+bounces-6493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801B886F23
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FBBB21A64
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9063A4AEEA;
	Fri, 22 Mar 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZJKC1A3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7C4AEC3;
	Fri, 22 Mar 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119397; cv=none; b=WyqP529zbylFAe4PqOHOtVyLF46U7iFGYSk9DqRHZ1dmw1Gv06rtfNwD272OEylJCjhhVWrOCUB1dKnnCxDRg50auEtu0j5IP+u3rAaVcwBgrH/EltcxxZVtMe8f8U4npImC35SXkyzFamX+UqUyhR38gvmy5xVmCGWHbQWqXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119397; c=relaxed/simple;
	bh=B3+9hbrYbOgrf7SwvZDCmpmOCm9dH1xA1Os15FGm0f8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eJHXfFkKoUWzhyjQmwtrwNY9/LkSbYkZwkq2DolkRtoMrNY1mSJ0tkUvvPznKtFCtbBIKiRig+9EizqXzw8I1ihCjxThfATraBxiBgdim561arpwkKwiicP84KX4hKlKDnDiOYKtEiPQbM09Z9rC4LrPNgwHbiCbF9/eAix4cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZJKC1A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ABEC433C7;
	Fri, 22 Mar 2024 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119396;
	bh=B3+9hbrYbOgrf7SwvZDCmpmOCm9dH1xA1Os15FGm0f8=;
	h=From:Subject:Date:To:Cc:From;
	b=VZJKC1A3CVm0OJ8xGSmhf7SSk8nzq4ItyPvudRWKQcAsbfP2kX2NCu8epX4eQ1qfS
	 4V/psdDu2COTE58DgYi7ogHeR7OZutZrKv+sSEj4iAWkKilXihB76XauZP0wKo+4qo
	 zusumbbZEdXVhIU8RYTLU93TVE3iAtarIOfyjAs/Elmdv0sFuomZwGIqufgCrJ78dA
	 kz7qh/r7xIoxGp/rPgQ58a3dDYE5PFAee/UgEnkd3xuJkbLvyB7xkpFI+jpBpFzctp
	 oE5DVLpSw5uf0qL1E6O5MpKylJQ2c2ysEMuVybKVlFRoObF6CFaU0mG+Au1FIImiLU
	 vD7po2W+E+BXQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH bpf-next v5 0/6] sleepable bpf_timer (was: allow HID-BPF to
 do device IOs)
Date: Fri, 22 Mar 2024 15:56:20 +0100
Message-Id: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWc/WUC/23QzWrDMAwH8FcpPs/FH5KT7LT3KDvEttyYhSTYx
 bSUvPvcMFhLc/wj6SehO8uUImX2ebizRCXmOE814MeBuaGfzsSjr5kpoUAogXyIntsl8DwSLb0
 diTshlRHBd9IBq3NLohCvm3lij9aJrhf2XStDzJc53bZlRW71P7fbcYvkgoNzbYcWe2/91w+li
 cbjnM4bV9QTIWGPUJXABo0VCI2Cd0I/EUruEboSMljdtK43Wsg3Av4JLfceVOBxhcE2KASBBl6
 IdV1/AZNDiR2GAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711119393; l=4779;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=B3+9hbrYbOgrf7SwvZDCmpmOCm9dH1xA1Os15FGm0f8=;
 b=N//ErnQ5quS/WeDbzudW1FZYPPK5FPfZ7IXc5QPNWx7ktW2p/aZcx+abWc1UC0QMDIoLZgln+
 yWLKHjBtDREDMg+mMrYuQLaSUzLs8gO86c5qoxqUd6C8VUbZBfagj8h
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

New version of the sleepable bpf_timer code, without the HID changes, as
they can now go through the HID tree indepandantly.

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
Benjamin Tissoires (6):
      bpf/helpers: introduce sleepable bpf_timers
      bpf/verifier: add bpf_timer as a kfunc capable type
      bpf/helpers: introduce bpf_timer_set_sleepable_cb() kfunc
      bpf/helpers: mark the callback of bpf_timer_set_sleepable_cb() as sleepable
      tools: sync include/uapi/linux/bpf.h
      selftests/bpf: add sleepable timer tests

 include/linux/bpf_verifier.h                       |   1 +
 include/uapi/linux/bpf.h                           |   4 +
 kernel/bpf/helpers.c                               | 132 ++++++++++++++-
 kernel/bpf/verifier.c                              |  96 ++++++++++-
 tools/include/uapi/linux/bpf.h                     |   4 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |  34 ++++
 .../testing/selftests/bpf/progs/timer_sleepable.c  | 185 +++++++++++++++++++++
 10 files changed, 458 insertions(+), 9 deletions(-)
---
base-commit: 9187210eee7d87eea37b45ea93454a88681894a4
change-id: 20240205-hid-bpf-sleepable-c01260fd91c4

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


