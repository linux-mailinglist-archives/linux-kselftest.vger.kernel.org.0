Return-Path: <linux-kselftest+bounces-16990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D8968BB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FA71C224A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07631A304C;
	Mon,  2 Sep 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmdtUR/s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0711A2627;
	Mon,  2 Sep 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293699; cv=none; b=CrN/FX25dHSaZG/NOb3ZzDkizLBbfXQ18dnsrGCQjtfYM6fueL5Fwm4AJZSgWI+5C0hHn1MuNDnDZBUnMHPS95wiLcEUomlfPm9KKncJ7xxLT5xl5NBP8ExXaEDSGAIVAaWY4HjntnXUIgzdArls3kaL5AThD05SHKqdNmgVP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293699; c=relaxed/simple;
	bh=2YXvs+4h6EtwgTDIiHH+k7lx3bBCvlfhGPYD9djhnD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CP3Ya+3QXzPDouXaFE8gv7k7+pR41um0joK35bEj3gyPAART9X+WRXouhqHWtxYs/WkMrw4a9ypG04MRx3DoR90unyqk7otHRHChS11xz8tqlT81DBQS7KFnDYMubPXcdKAT+yH6Qh7/xJx+QjyMID8Bkv70sqSHoF8yE+WbKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmdtUR/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE5EC4CEC2;
	Mon,  2 Sep 2024 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293699;
	bh=2YXvs+4h6EtwgTDIiHH+k7lx3bBCvlfhGPYD9djhnD0=;
	h=From:Subject:Date:To:Cc:From;
	b=WmdtUR/sRt9/rVHTFsg3tdydOMs9g8cytn2zASvD9jPODXG+5JOY7usGel9zF2JTi
	 623n5c12xkpGvF6S2Z/VdrkH+Gd3rEEb3kcO+f85ezNd4wqY7z7GOa/ZL8l8/oYeF+
	 hPnEtWVizk6kdKLqVaWBbnkWIUV6ne2ec8+gZ5LLh449cYWyHQkhZC0pYeDV9nlh8+
	 bKv2zCmc/Cb1SpeYpRcNT1LHez628sVPc/4ocYxubo4UW1l/ZIJTxFMsVDWhE7hJxu
	 rrUgf1Q7uDtrDpzYyvJViuPrDCK1CZsOx822PArRbjtdYJbmiZaTG/4cJQuwMTrpO4
	 PLJbXWK/IfonQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID 0/7] HID: bpf: add a new hook to control hid-generic
Date: Tue, 03 Sep 2024 01:14:30 +0900
Message-Id: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbk1WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3YzMFN2kgjQwnZ6aB9SdrGtmaGpumWaaZGppYqoE1FlQlJqWWQE
 2NVrJw9NFKba2FgCCMG3zagAAAA==
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=4061;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=2YXvs+4h6EtwgTDIiHH+k7lx3bBCvlfhGPYD9djhnD0=;
 b=m0iCZE1dHV9g7xwZtqTLCsu7pk2cVmrdyeFbjmCJtVCjK/kAT3HuOJA8z1AzYZAj2AajwbxRV
 1y3XyKrSD+UAkxR7DdC0smgCXARau1kShwLKgxc77dGNa7NyQnAe3oG
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is a slight change from the fundamentals of HID-BPF.
In theory, HID-BPF is abstract to the kernel itself, and makes
only changes at the HID level (through report descriptors or
events emitted to/from the device).

However, we have seen a few use cases where HID-BPF might interact with
the running kernel when the target device is already handled by a
specific device.

For example, the XP-Pen/Huion/UC-Logic tablets are handled by
hid-uclogic but this driver is also doing a report descriptor fixup
without checking if the device has already been fixed by HID-BPF.

In the same way, another recent example[0] was when a cheap foot pedal is
used and tricks iPhones and Windows machines by presenting itself as a
known Apple wireless keyboard. The problem is that this fake keyboard is
not presenting a compatible report descriptor and hid-core merges all
device nodes together making libinput ignore the keyboard part for
historical reasons.

Last, there has been a long standing request to allow to disable the
input part of a given gamepad while SDL or Steam opens the device
through hidraw.

This series aims at tackling both of these problems:
- first we had a new hook `hid_bpf_driver_probe` which allows the BPF
  program to decide if the curently probed driver should be used or not
- then this same hook can also change the ->driver_data of the struct
  hid_device_id argument, and we teach hid-generic to use that field as
  the connect mask.

Basically, it means that when we insert a BPF program to fix a device,
we can force hid-generic to handle the device, and thus preventing
any other kernel driver to tamper with our device. We can also
selectively decide to export the hidraw or input nodes when using
hid-generic.

In the SDL/Steam use case, this would means that the gaming application
will load one BPF program per input device it wants to open through
hidraw, that BPF program reassigns the input device to hid-generic and
disables hid-input, then it can open the new hidraw node.
Once that program terminates, the BPF program is removed (either
automatically because no-one has the fd of the links open, or manually
by SDL/Steam), and the normal driver rebinds to the HID device,
restoring full input functionality.

This branch is on top of the for-6.12/hidraw branch of hid.git, mainly
because that branch saw some selftests/hid changes.

[0] https://gitlab.freedesktop.org/libinput/libinput/-/issues/1014

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (7):
      selftests/hid: add dependency on hid_common.h
      selftests/hid: cleanup C tests by adding a common struct uhid_device
      selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
      HID: bpf: allow BPF programs to force using hid-generic
      selftests/hid: add test for assigning a given device to hid-generic
      HID: bpf: Allow to control the connect mask of hid-generic from BPF
      selftests/hid: add test to disable hid-input

 Documentation/hid/hid-bpf.rst                      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |  31 ++++
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   4 +
 drivers/hid/hid-core.c                             |  18 +-
 drivers/hid/hid-generic.c                          |   5 +-
 include/linux/hid_bpf.h                            |  40 ++++
 tools/testing/selftests/hid/Makefile               |   2 +-
 tools/testing/selftests/hid/hid_bpf.c              | 205 ++++++++++++++++-----
 tools/testing/selftests/hid/hid_common.h           | 112 +++++++----
 tools/testing/selftests/hid/hidraw.c               |  36 +---
 tools/testing/selftests/hid/progs/hid.c            |  31 ++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   4 +
 12 files changed, 372 insertions(+), 118 deletions(-)
---
base-commit: 321f7798cfb8d834ae0ed0d467c8bf46804243f9
change-id: 20240829-hid-bpf-hid-generic-61579f5b5945

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


