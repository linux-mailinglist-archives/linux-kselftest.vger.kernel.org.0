Return-Path: <linux-kselftest+bounces-17588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D510973A39
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CE11C24B16
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E0196C6C;
	Tue, 10 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz1zV4gw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E119597F;
	Tue, 10 Sep 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979430; cv=none; b=VDlK6wFHjxosCTm7BcCCZtM6dVEUNFSGAiUkgJPLYtbKRj/+FW7QGHhrjPziqu/uVzEKRph15L3tq1gs35JlaiTMzig73vQqkbFPfEIVM8/UwgMK5lbJ5xS/2IJkC/nkSnJvrD9jBsOuK63ZDWDnzW3AB4/JhcKcYyLttvXiNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979430; c=relaxed/simple;
	bh=odqAjkq4xYv9Ptm4wueHT0g6brChF+Ie68WJOCsQGoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q+0huvFF1JS+yjcvcKzPKKTrwgeXUzUT5FMCeYESX5Rv59jOPV9G/Gu8a0lem40rRXVf7t4qU/JirH0DuP4KXiNf6aBOrmeCsjSmfQ52xm4guC1pwG2dPVbWl2re6496QM76cmOLWeHIWWJc4A2w9bno2eB6jAFPnZfTjQBNECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz1zV4gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837C8C4CED0;
	Tue, 10 Sep 2024 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979430;
	bh=odqAjkq4xYv9Ptm4wueHT0g6brChF+Ie68WJOCsQGoo=;
	h=From:Subject:Date:To:Cc:From;
	b=Oz1zV4gwoVCRGURux3DjCviOB4c2AMjh9Bpe46QgaW0QGQcP3v7qPFvaFCUcC5oi2
	 aAeAqEmRtyUZKIrtEWnw0uB+zuObcIRpqMLSMv9QybT7hI8Q8gDG425XkuC9ERu4WK
	 VS3xWtpWhz3J6ES6Oaim/nrTLWFDSDxUd7UhTSEjwdamVzMyiQlcCE4nqKvvzOTyhL
	 qJrFuSL9ia/mR3NoY18gyzAlaRViqnsXRaTPAcBysvzlyZs+V953nrVzj6O8M+rgre
	 FurwXa2fjs1lfOLWBCT7XRegOLldVv7dl5b0SvnOgKXVABnekSAAuNQVpzJybRN/Uo
	 ANvsKHonP8DNA==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID v2 00/11] HID: bpf: add a new hook to control
 hid-generic
Date: Tue, 10 Sep 2024 23:43:36 +0900
Message-Id: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhb4GYC/22NvQ7CMBCDX6W6maAk9AphYmCAZ0Ad+nNtT6CkS
 lAEqvLuRJmZLNvy5w0CeaYA52oDT5EDO5uN3lUwLJ2dSfCYPWipa3nSRiw8in6dis5k83oQjcK
 jmbBHUyPk5epp4k+hPuB2v0Kbw4XD2/lveYqqVAVq5OEvNCohhUGlOmyw12N3eZK39No7P0ObU
 voB1uJqprwAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=4808;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=odqAjkq4xYv9Ptm4wueHT0g6brChF+Ie68WJOCsQGoo=;
 b=ilZMdUQr/msKvr6WZIKCbO+MMux0RDMSI65MfDhc/W39o4TFUOBumbo8zel1CCZRkshyURXkb
 /RvKMEg+kqJAIGqgBzg99uOj3ykafzzRB1qxPtCW8Lxksn976mmzSku
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

This branch is on top of the for-6.12/hidraw and for-6.12/constify-rdesc
branches of hid.git, mainly because those branch would conflict otherwise.

[0] https://gitlab.freedesktop.org/libinput/libinput/-/issues/1014

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v2:
- Refactored the API to not use a new hook but hid_bpf_rdesc_fixup
  instead
- Some cleanups in hid-core.c probe() device to not kmemdup multiple
  time the report descriptor when it's not required
- I'm still not 100% sure the HID_QUIRK_IGNORE_HIDINPUT is that
  required, but I can not think of anything else at the moment to
  temporary disable any driver input device.
- Link to v1: https://lore.kernel.org/r/20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org

---
Benjamin Tissoires (11):
      HID: bpf: move HID-BPF report descriptor fixup earlier
      HID: core: save one kmemdup during .probe()
      HID: core: remove one more kmemdup on .probe()
      HID: bpf: allow write access to quirks field in struct hid_device
      selftests/hid: add dependency on hid_common.h
      selftests/hid: cleanup C tests by adding a common struct uhid_device
      selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
      HID: add per device quirk to force bind to hid-generic
      selftests/hid: add test for assigning a given device to hid-generic
      HID: add quirk to prevent hid-input to be used
      selftests/hid: add test to disable hid-input

 drivers/hid/bpf/hid_bpf_dispatch.c                 |   8 +-
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   1 +
 drivers/hid/hid-core.c                             |  72 ++++++--
 drivers/hid/hid-generic.c                          |   3 +
 include/linux/hid.h                                |  22 ++-
 include/linux/hid_bpf.h                            |   9 +-
 tools/testing/selftests/hid/Makefile               |   2 +-
 tools/testing/selftests/hid/hid_bpf.c              | 205 ++++++++++++++++-----
 tools/testing/selftests/hid/hid_common.h           | 112 +++++++----
 tools/testing/selftests/hid/hidraw.c               |  36 +---
 tools/testing/selftests/hid/progs/hid.c            |  13 ++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   7 +-
 12 files changed, 343 insertions(+), 147 deletions(-)
---
base-commit: e1370d5de7b755600df050979e19fbcd625fb4c6
change-id: 20240829-hid-bpf-hid-generic-61579f5b5945

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


