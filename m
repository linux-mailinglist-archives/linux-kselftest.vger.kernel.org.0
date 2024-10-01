Return-Path: <linux-kselftest+bounces-18743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBB98BFF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717901C23DC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4F1C6F5E;
	Tue,  1 Oct 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMOflocR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEF1A4F0D;
	Tue,  1 Oct 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793034; cv=none; b=nk/n258f67bycjtwg62BAS3zSLuzjBWyJBv7Y6Kjs2buwmHwRt4ilL6/148Tbb30Se0VSQQk3JSiJA8mG/EMO0EPoUevk6K4k47EIWbTaMMXJmAOKxckrh9OFsIaugwP0i7Ehoe2uRDevJ3/7vlSug+E7s0Bqvgd+DK3zg4xWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793034; c=relaxed/simple;
	bh=nGvYMRuh7zWFI6VcJ1HEzDn8S8Ie85YQyayn0q6e0wA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bUKH8mSOuFah9DU+9ERLKIYAqwypE/x3Khz8E/+AXPeiREyzlHw7+SFhkK5WjU3ipUJzSFme83UQCmGtDyKqvgOOWrB4OgZpZYgPA/1uB2z46swwE4TtOqI7GcixYUVDKRLOE0CDBvSApEPebnq7P4cOYnxxQq0x54WlDpgFfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMOflocR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DC4C4CEC6;
	Tue,  1 Oct 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793033;
	bh=nGvYMRuh7zWFI6VcJ1HEzDn8S8Ie85YQyayn0q6e0wA=;
	h=From:Subject:Date:To:Cc:From;
	b=RMOflocR27fAPoPNikaQQqiyPFUktpj1l7yvZEjGUShbQXcLh10UHGxC/dPm/rfAg
	 gXg+rs4ov6fasC1w0uPWfwQBR2XrtNYW+jLE1kos42OlYv7pvUldKBz6XP5/OIOZFQ
	 /bTMuLUG8K99wKb6BPtOD9bAOsuwPQnFRJPzqFq4ltLHGcA9uv+0cBhXBpg2pJ/sAJ
	 hSZgy0mOKdztCf0LSU8ac63p19OFpSGUaSW1vJ/Tvy9r6YaOrUJiD2dyKprcuxqAOx
	 1ccBokXZdWDmjqRfGDlfi+Cop/EQLxySoyA4d5JaOiU4MEYHuxyoEYQtX++ROMnG6m
	 f0XBoxNhbZZZw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID v3 0/9] HID: bpf: add a new hook to control hid-generic
Date: Tue, 01 Oct 2024 16:30:04 +0200
Message-Id: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwH/GYC/23NwQ6CMAwG4FchPTuzDYbMkwcP+gzGA7AOGs0gm
 1k0hHd32UkTTs3f5v+6QEBPGOBYLOAxUqDJpVDuCujH1g3IyKQMksuKN1KzkQzrZpvngC61e1Y
 LddBWdUpXClJz9mjpndUbXK5nuKflSOE1+U/+FEU+ZVTzchONgnGmlRCtqlUnTXt6oHf43E9+y
 GCUP4jg24hMCG9KY3vRaNSHP2Rd1y8dzFnJAQEAAA==
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=4175;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=nGvYMRuh7zWFI6VcJ1HEzDn8S8Ie85YQyayn0q6e0wA=;
 b=Qj28gsmtXPhAagUhfKkQqh5Hd7LFduYqBUKvzE+46XVGZZAYocJHJ7KWnoK/+Lb3yKoG9/4wN
 QN/VbeCsnN7D+T/v3uS7Df8pUFPDJdMHPOfrE3o2cp6/zXARcrSF/GI
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

This series aims at tackling this problem:
- first, we promote hid_bpf_report_descriptor_fixup to be called before
  any driver is even matched for the device
- then we allow hdev->quirks to be written during report_fixup and add a
  new quirk to force hid-core to ignore any non hid-generic driver.

Basically, it means that when we insert a BPF program to fix a device,
we can force hid-generic to handle the device, and thus preventing
any other kernel driver to tamper with our device.

This branch is on top of the for-6.12/upstream-fixes branch of hid.git.

[0] https://gitlab.freedesktop.org/libinput/libinput/-/issues/1014

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- dropped the last 2 patches with hid-input control, as I'm not 100%
  sure of it
- changed the first patch to avoid a double free on cleanup of a device
  when a HID-BPF program was attached
- kept Peter's rev-by for all but patches 1 and 6
- Link to v2: https://lore.kernel.org/r/20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org

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
Benjamin Tissoires (9):
      HID: bpf: move HID-BPF report descriptor fixup earlier
      HID: core: save one kmemdup during .probe()
      HID: core: remove one more kmemdup on .probe()
      HID: bpf: allow write access to quirks field in struct hid_device
      selftests/hid: add dependency on hid_common.h
      selftests/hid: cleanup C tests by adding a common struct uhid_device
      selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
      HID: add per device quirk to force bind to hid-generic
      selftests/hid: add test for assigning a given device to hid-generic

 drivers/hid/bpf/hid_bpf_dispatch.c                 |   9 +-
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   1 +
 drivers/hid/hid-core.c                             |  84 +++++++++---
 drivers/hid/hid-generic.c                          |   3 +
 include/linux/hid.h                                |  20 +--
 include/linux/hid_bpf.h                            |  11 +-
 tools/testing/selftests/hid/Makefile               |   2 +-
 tools/testing/selftests/hid/hid_bpf.c              | 151 ++++++++++++++-------
 tools/testing/selftests/hid/hid_common.h           | 112 ++++++++++-----
 tools/testing/selftests/hid/hidraw.c               |  36 ++---
 tools/testing/selftests/hid/progs/hid.c            |  12 ++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   6 +-
 12 files changed, 296 insertions(+), 151 deletions(-)
---
base-commit: acd5f76fd5292c91628e04da83e8b78c986cfa2b
change-id: 20240829-hid-bpf-hid-generic-61579f5b5945

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


