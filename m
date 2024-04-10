Return-Path: <linux-kselftest+bounces-7577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB989FE22
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7B1F22375
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728217BB15;
	Wed, 10 Apr 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw3NnDtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934917BB0F;
	Wed, 10 Apr 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769592; cv=none; b=YBq0gznoXVn8+86nuPAMkmvBKS7YMrnY4BwOVZkiNU01rIypuo42GcTMF210Eg7eNzHq1A2s22j0mxU/UO3j7xUzMSlBFkWzWIUrFQjFbSYPuRey9D9tyzXvLPqtNn2hXq7GiKFSiNVQb9tcmIYzlRMEt9oHqRRm1KztTI8Eab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769592; c=relaxed/simple;
	bh=6Hn8w2/tHxyjB+9DMsHB0GAVTOXeeu71uZLUXMLz+MY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=psRrZHwwR2EBbb1mO2/6+T4AistI3S+bmKUiOP7HrNbIt1A0vrpkS6bYxQ73+WKPBCxBqoVSb5j0qpRRHNSAIvBpedYt2FuyyKMjZ1ehDeTMPlpN83iIz/dZbX/xpwrvFQ+3ccBToBb3xl+HCfPLUiwZ6MFUM0JrkjPhpxg3yZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw3NnDtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCBAC433C7;
	Wed, 10 Apr 2024 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769592;
	bh=6Hn8w2/tHxyjB+9DMsHB0GAVTOXeeu71uZLUXMLz+MY=;
	h=From:Subject:Date:To:Cc:From;
	b=Iw3NnDtIMq//xAo9OFKaD7T0kj/vRBXn46OJrE2/476IYB5LXdw1GgrE5R/jwUk8b
	 AFwoxuJ1n0D/+s0eaInUMLzW1ZRy+CJ7DiaN0Xuz0FbAAzLwQXX6yOVdSDu/37PtGJ
	 gxq9mAq498bsN9wlIvV4fqx5O4DI7os0SgVK01Z1UUX9U8H8ZiZaAtzp2YRqqeGk/0
	 YjKVDQOYm3sPznflP+a9c3achXJ3ZxQppeUtiWYoF4tcI5ozxhPki1874EfZUo+XT+
	 SFagDUVXJaMWqq919jYg5J4Ui7ly6AWR8cKU0sjDF8p9IvJWsNtfY9exW7b315SBbH
	 ThQyM9LW6jUVw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 00/18] HID: Include current HID-BPF fixes in tree
Date: Wed, 10 Apr 2024 19:19:20 +0200
Message-Id: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjKFmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3aSCtPji/NKi5NRi3aRUwzTjZDND82TTVCWgjoKi1LTMCrBp0bG
 1tQDcwZGFXQAAAA==
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Martin Sivak <mars@montik.net>, 
 Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, 
 Aaron Armstrong Skomra <skomra@gmail.com>, 
 Joshua Dickens <Joshua@joshua-dickens.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=4998;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=6Hn8w2/tHxyjB+9DMsHB0GAVTOXeeu71uZLUXMLz+MY=;
 b=4u3UJmMlfDaLYKJ4I0Ma//8KMyyoUN8KeH2/6JvseMZ2t+tHYRFsk4AWtNKrHvabriBx/1hlA
 H6sKRtFR2hzCXXOgazQhJqLwQ+Y+58hzd8P+YpnxD6KMjePxVfckorN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When I introduced HID-BPF, I mentioned that we should ship the HID-BPF
programs in the kernel when they are fixes so that everybody can benefit
from them.

I tried multiple times to do so but I was confronted to a tough problem:
how can I make the kernel load them automatically?

I went over a few solutions, but it always came down to something either
ugly, or either not satisfying (like forcing `bpftool` to be compiled
first, or not being able to insert them as a module).

OTOH, I was working with Peter on `udev-hid-bpf`[0] as a proof of
concept on how a minimal loader should look like. This allowed me to
experiment on the BPF files and how they should look like.

And after further thoughts, I realized that `udev-hid-bpf` could very
well be the `kmod load` that we currently have:
- the kernel handles the device normally
- a udev event is emitted
- a udev rule fires `udev-hid-bpf` and load the appropriate HID-BPF
  file(s) based on the modalias

Given that most HID devices are supposed to work to a minimal level when
connected without any driver, this makes the whole HID-BPF programs nice
to have but not critical. We can then postpone the HID-BPF loading when
userspace is ready.

Working with HID-BPF is also a much better user experience for end users
(as I predicted). All they have to do is to go to the `udev-hid-bpf`
project, fetch an artifact from the MR that concerns them, run
`install.sh` (no compilation required), and their devices are fixed
(minus some back and forth when the HID-BPF program needs some changes).

So I already have that loader available, and it works well enough for
our users. But the missing point was still how to "upstream" those BPF
fixes?

That's where this patch series comes in: we simply store the fixes in
the kernel under `drivers/hid/bpf/progs`, provide a way to compile them,
but also add tests for them in the selftests dir.

Once a program is accepted here, for convenience, the same program will
move from a "testing" directory to a "stable" directory on
`udev-hid-bpf`. This way, distributions don't need to follow when there
is a new program added here, they can just ship the "stable" ones from
`udev-hid-bpf`.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

[0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/

---
Benjamin Tissoires (18):
      HID: do not assume HAT Switch logical max < 8
      HID: bpf: add first in-tree HID-BPF fix for the XPPen Artist 24
      HID: bpf: add in-tree HID-BPF fix for the XPPen Artist 16
      HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
      HID: bpf: add in-tree HID-BPF fix for the IOGear Kaliber Gaming MMOmentum mouse
      HID: bpf: add in-tree HID-BPF fix for the Wacom ArtPen
      HID: bpf: add in-tree HID-BPF fix for the XBox Elite 2 over Bluetooth
      HID: bpf: add in-tree HID-BPF fix for the Huion Kamvas Pro 19
      HID: bpf: add in-tree HID-BPF fix for the Raptor Mach 2
      selftests/hid: import base_device.py from hid-tools
      selftests/hid: add support for HID-BPF pre-loading before starting a test
      selftests/hid: tablets: reduce the number of pen state
      selftests/hid: tablets: add a couple of XP-PEN tablets
      selftests/hid: tablets: also check for XP-Pen offset correction
      selftests/hid: add Huion Kamvas Pro 19 tests
      selftests/hid: import base_gamepad.py from hid-tools
      selftests/hid: move the gamepads definitions in the test file
      selftests/hid: add tests for the Raptor Mach 2 joystick

 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c  | 185 ++++++
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c    |  58 ++
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c   | 290 +++++++++
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  |  59 ++
 drivers/hid/bpf/progs/Makefile                     |  91 +++
 .../hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c    | 133 ++++
 drivers/hid/bpf/progs/README                       | 102 +++
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c          | 173 +++++
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c        | 229 +++++++
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c | 274 ++++++++
 drivers/hid/bpf/progs/hid_bpf.h                    |  15 +
 drivers/hid/bpf/progs/hid_bpf_helpers.h            | 170 +++++
 include/linux/hid.h                                |   6 +-
 tools/testing/selftests/hid/tests/base.py          |  87 ++-
 tools/testing/selftests/hid/tests/base_device.py   | 421 ++++++++++++
 tools/testing/selftests/hid/tests/base_gamepad.py  | 238 +++++++
 tools/testing/selftests/hid/tests/test_gamepad.py  | 457 ++++++++++++-
 tools/testing/selftests/hid/tests/test_tablet.py   | 723 +++++++++++++++------
 18 files changed, 3507 insertions(+), 204 deletions(-)
---
base-commit: 3e78a6c0d3e02e4cf881dc84c5127e9990f939d6
change-id: 20240328-bpf_sources-be1f3c617c5e

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


