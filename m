Return-Path: <linux-kselftest+bounces-11392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503149008D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA00C1F221E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3D196DA7;
	Fri,  7 Jun 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP16TPHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F81847;
	Fri,  7 Jun 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774112; cv=none; b=LG9MuQ8Lmk1U8Rb+9jXg/iq5f8ap5xPtf3UU9LH14u+/blk7wXuLSBrnL/oo4vb1boZpBgMa+S7YoXYv9Y3zYgAD71wom2oWMCjsjDsoygyMJrE3appUnWjXnDJm6oDjfv4dSZfpd5Ucu3dSqUUE6ee4EDw+WsxyWMRxn4KeQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774112; c=relaxed/simple;
	bh=GElVRuD+0p0S/IMmlhrZvU2cPAkDJYLHz+KKSQ3Dzv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=slZMkeBjsAOkiWNxKTXf7E650Vshh1vslyafeCDIbxjzsjlzZlj2mDNnEcwN3A3aFW+rWh38504FbJFHHR4qwDibbp2k/z1DLqCVVFzhbgcjM3ZpiCLlbwiBvL/Xr9/yktLGYx/pBk+1eYlyQDI6aOaRpqLBA2QvrbqvwTKPQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP16TPHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DF6C2BBFC;
	Fri,  7 Jun 2024 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774112;
	bh=GElVRuD+0p0S/IMmlhrZvU2cPAkDJYLHz+KKSQ3Dzv4=;
	h=From:Subject:Date:To:Cc:From;
	b=rP16TPHTVxqovblcXgQTiDn0IIH+OjnKf/W+Efu2JDFro3i68rGeG7Z+t7JbHHJc0
	 R7Y9NKoknXHhUJ6KWwElFe9CFNopQ+WGyFAHinsF63R0hKZ75TSVhwsNzECEzFWcft
	 O47Pyp1ngRp3eqSuDBf0ITcnat3RG/Ah8RIQmk9R3M5ZA5Z/wp3PzBMrcHrkkVOGpy
	 AFGqe61z3YYc0612lKQPHXvy7szocWqP4D4Bwr0ONfKAbb5pfShOxmO8Ah6ajf1zel
	 z1TyRCDOj/TrEjpnOXZ+7pEp+nsiRuGngxwisL070ZEqnWBtBn/0caMzffqxC/M1JG
	 OoJthb0392hLQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID v2 00/16] HID: convert HID-BPF into using
 bpf_struct_ops
Date: Fri, 07 Jun 2024 17:28:20 +0200
Message-Id: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUnY2YC/22NwQ6CMBBEf4Xs2Rq6UCSePHjQbzCkQbrARkPJF
 omG8O82ePX4ZjJvFggkTAGOyQJCMwf2QwTcJdD09dCRYhcZMMU8NTpTPTt7H1sbJnk1k/VjUJS
 hxhoxN8ZAHI5CLb836Q0u1zNUMew5TF4+29Gst+rnxPKfc9YqVWVTFEXmWjy48vQgGei599JBt
 a7rF2CaTHW6AAAA
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=4712;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=GElVRuD+0p0S/IMmlhrZvU2cPAkDJYLHz+KKSQ3Dzv4=;
 b=+q4XRskmsyQrQvBA78fRG6/EkIyhBx/TqVZc7ewoZNwkh4THHjSeSpeWEJK6gSUx/KnrC53Ay
 +57w6VtRzsFAtEqO40xt2nkrrc8idtf7sGA2xY0fujmG2zSS1OwvKFr
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
 include/linux/hid_bpf.h                            | 125 ++---
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
 32 files changed, 805 insertions(+), 1479 deletions(-)
---
base-commit: 70ec81c2e2b4005465ad0d042e90b36087c36104
change-id: 20240513-hid_bpf_struct_ops-e3212a224555

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


