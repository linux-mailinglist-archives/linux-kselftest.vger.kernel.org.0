Return-Path: <linux-kselftest+bounces-11470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C09010A1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C231C21698
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35014EC53;
	Sat,  8 Jun 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH1p/iri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702B14286;
	Sat,  8 Jun 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837282; cv=none; b=WKD/1ZOWj78d4S2bBNgPAlIsBglqoTHJtReZrwOC7zxCbUT+Il7H3151AXYKTHeL02t30rpR1lTNBouUeuHv7tOyTTnEcgLswqqJZYfr0G1iUKlmVyxx920yRggrol5WMKCBwVc5VD57+Il4ErGj1zLzDTCfHii0Qa128rC0Zvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837282; c=relaxed/simple;
	bh=1/f02kDBw63jQMXEE2MyvrNXy9Fmrvsga5uyBueYldU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VJW6X5TPYxdr4j0bV/mTR4dRSg9WIlHI4/BZF7VCo7ua6H9yUc5ksACzw16jqFsfP6knKrnzkUQTqAFkAQznlWd6lTxSaz33z4DDx7dKFDhoEjqHOu8YOkbpBKJjC3284G7Q98W47vto40dzNVucfhKQ/x0S8palH/3JOAv7+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH1p/iri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E931CC2BD11;
	Sat,  8 Jun 2024 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837282;
	bh=1/f02kDBw63jQMXEE2MyvrNXy9Fmrvsga5uyBueYldU=;
	h=From:Subject:Date:To:Cc:From;
	b=hH1p/irimyi6Aj8+wOmhstheuhfSQ3HXxSHL/C82sJETZiZW77Ng+spiOtlHkKje3
	 Yd9tgYpPUbhe+VGLSeJNF2gG8x4iAJ6Wy/yMY4I9WzHVNklgx26KpJpCk6fhZAH4rO
	 XHrzQKQA1jSjINJ5cnMJRQ5bpMhR0FkmNarwqwcl2ZdTJ4PVUsgehGc0NIk9Yy+OI1
	 c2dzrbfS3Cav5wBDy6XcFjIDOK3+Z4662XWEanY45HVrMFaoip2dRzsVCTx4ZmiICw
	 8B4j1JOT56EMMbt2HNWl+UGMgz7qyvaiK+NtkFbOpM7Dew6Raq2vg8bJiqbeVuIzUn
	 pBMMt5e8S9oGw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID v3 00/16] HID: convert HID-BPF into using
 bpf_struct_ops
Date: Sat, 08 Jun 2024 11:01:12 +0200
Message-Id: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgdZGYC/23NQQ6CMBAF0KuQrq0pU1rQlQsXegZjCNIpNBpKW
 mw0hLvb1IUxYfnnZ96fiUdn0JN9NhOHwXhjhxj4JiNt3wwdUqNiJsCgYCLntDeqvo269pN7tlN
 tR0+RQw4NQCGEIPFxdKjNK6EXcjofyTUee+Mn695pKOSp+ppQrZkhp4xWrZSSKw2lqg53dAM+t
 tZ1yQvwMyQrVw2IBtc7oQvFAHbwZyzL8gETBKvu/gAAAA==
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=4865;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=1/f02kDBw63jQMXEE2MyvrNXy9Fmrvsga5uyBueYldU=;
 b=WYrQH5UV88GmVipTdAZc3S7c0BkQKr494z3iEGoXNbpCnBRmEByfWsmN4fjuPtYo3Nz5PiwPz
 +cJFmmeI30ACDzALB/OnLLVNPfntXCi43L0dAEtzNaK4RetlkO8SGoB
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The purpose of this series is to rethink how HID-BPF is invoked.
Currently it implies a jmp table, a prog fd bpf_map, a preloaded tracing
bpf program and a lot of manual work for handling the bpf program
lifetime and addition/removal.

OTOH, bpf_struct_ops take care of most of the bpf handling leaving us
with a simple list of ops pointers, and we can directly call the
struct_ops program from the kernel as a regular function.

The net gain right now is in term of code simplicity and lines of code
removal (though is an API breakage), but udev-hid-bpf is able to handle
such breakages.

In the near future, we will be able to extend the HID-BPF struct_ops
with entrypoints for hid_hw_raw_request() and hid_hw_output_report(),
allowing for covering all of the initial use cases:
- firewalling a HID device
- fixing all of the HID device interactions (not just device events as
  it is right now).

The matching user-space loader (udev-hid-bpf) MR is at
https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/86

I'll put it out of draft once this is merged.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- took Alexei's review into account
- Link to v2: https://lore.kernel.org/r/20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org

Changes in v2:
- drop HID_BPF_FLAGS enum and use BPF_F_BEFORE instead
- fix .init_members to not open code member->offset
- allow struct hid_device to be writeable from HID-BPF for its name,
  uniq and phys
- Link to v1: https://lore.kernel.org/r/20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org

---
Benjamin Tissoires (16):
      HID: rename struct hid_bpf_ops into hid_ops
      HID: bpf: add hid_get/put_device() helpers
      HID: bpf: implement HID-BPF through bpf_struct_ops
      selftests/hid: convert the hid_bpf selftests with struct_ops
      HID: samples: convert the 2 HID-BPF samples into struct_ops
      HID: bpf: add defines for HID-BPF SEC in in-tree bpf fixes
      HID: bpf: convert in-tree fixes into struct_ops
      HID: bpf: remove tracing HID-BPF capability
      selftests/hid: add subprog call test
      Documentation: HID: amend HID-BPF for struct_ops
      Documentation: HID: add a small blurb on udev-hid-bpf
      HID: bpf: Artist24: remove unused variable
      HID: bpf: error on warnings when compiling bpf objects
      bpf: allow bpf helpers to be used into HID-BPF struct_ops
      HID: bpf: rework hid_bpf_ops_btf_struct_access
      HID: bpf: make part of struct hid_device writable

 Documentation/hid/hid-bpf.rst                      | 173 ++++---
 drivers/hid/bpf/Makefile                           |   2 +-
 drivers/hid/bpf/entrypoints/Makefile               |  93 ----
 drivers/hid/bpf/entrypoints/README                 |   4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c      |  25 -
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h    | 248 ---------
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 266 +++-------
 drivers/hid/bpf/hid_bpf_dispatch.h                 |  12 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c                | 565 ---------------------
 drivers/hid/bpf/hid_bpf_struct_ops.c               | 298 +++++++++++
 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c  |   9 +-
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c    |   6 +-
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c   |   9 +-
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  |   6 +-
 drivers/hid/bpf/progs/Makefile                     |   2 +-
 .../hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c    |   6 +-
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c          |   6 +-
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c        |  10 +-
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c |  24 +-
 drivers/hid/bpf/progs/hid_bpf.h                    |   5 +
 drivers/hid/hid-core.c                             |   6 +-
 include/linux/hid_bpf.h                            | 119 +++--
 samples/hid/Makefile                               |   5 +-
 samples/hid/hid_bpf_attach.bpf.c                   |  18 -
 samples/hid/hid_bpf_attach.h                       |  14 -
 samples/hid/hid_mouse.bpf.c                        |  26 +-
 samples/hid/hid_mouse.c                            |  39 +-
 samples/hid/hid_surface_dial.bpf.c                 |  10 +-
 samples/hid/hid_surface_dial.c                     |  53 +-
 tools/testing/selftests/hid/hid_bpf.c              | 100 +++-
 tools/testing/selftests/hid/progs/hid.c            | 100 +++-
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  19 +-
 32 files changed, 800 insertions(+), 1478 deletions(-)
---
base-commit: 70ec81c2e2b4005465ad0d042e90b36087c36104
change-id: 20240513-hid_bpf_struct_ops-e3212a224555

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


