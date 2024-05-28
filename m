Return-Path: <linux-kselftest+bounces-10774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC98D1C4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54222286AED
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195A16E894;
	Tue, 28 May 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th/8RrG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539754273;
	Tue, 28 May 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902116; cv=none; b=cQayZ5OSPN/bLuy9idfrHIvSiiXl020vh+DhIPXlRA8y7jo4CC5LnipqeLTIXPunedkCGiCSMZAbXdZFoApTSIKrdzd3nZXrW0kn5TaHMijzj1mxPJSpoyCM8XL/iXsVcptJHcCzTd3JNpO39qYux0Om7IIG6WjzLorxDE3CQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902116; c=relaxed/simple;
	bh=0Dcn58QocAp13x/HKMAWs8UCUi2lZdKM2fgg3VBlWsI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JyLeSjPK2zG3BLY256Dk4QHhTibSRlo/Xa57OKLc+XIQdhtZnyv2K62AZBRnXyUuV/4DT3wpYn+YeOVlyad6xUFvQK8yVWXEyzz+Km3nUf4sb3EEYwEhkR3WHIZk+vmaqtLWQTYdbDnH5QQheDKFaW3nmpJ6ZelpgurYvIETR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th/8RrG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB60C3277B;
	Tue, 28 May 2024 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902116;
	bh=0Dcn58QocAp13x/HKMAWs8UCUi2lZdKM2fgg3VBlWsI=;
	h=From:Subject:Date:To:Cc:From;
	b=th/8RrG3PUVODqQz0mxOTkhmpMEhIdLqHs2HtYkvimpc5RaRo3dow+yQOXVht6/yI
	 YyznpVreXGaYrk49R8YSZFIzxBEmwot8VoNvMvcoeziCkRHgiEnsuSlGGtbxr7XQZa
	 En2VTzHkn+c/Xz8KdtlyvNgR26B1DmzTo1Ta1sjVKT8iNj3yjAdRLopJagnASkgIv/
	 gV3sjTrjSZphLPEh520IiHt9eGFp8bJPaqwHR2UIUoSWYNRM19ifezE3aKduJWrJKw
	 9cSYtpEViD1eFSdJfB50SRpOMwXkkZSX7m7tZnTa+N2Nx3MACiDIhz2dC2uqlBKvg0
	 zpfTfPqTS4u7A==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH HID 00/13] HID: convert HID-BPF into using bpf_struct_ops
Date: Tue, 28 May 2024 15:14:38 +0200
Message-Id: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7YVWYC/x3MsQ5AMBCA4VeRmzXRo4vZwDOINNThFpoeIpG+u
 8b4Df//glBgEqizFwLdLHzsCTrPwG3jvpLiORmwwKowulQbz3byi5UzXO60hxdFJWocEStjDKT
 QB1r4+ac9tF0DQ4wfWb0XNGkAAAA=
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=4153;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0Dcn58QocAp13x/HKMAWs8UCUi2lZdKM2fgg3VBlWsI=;
 b=5OTc7Q/Kj2wC43pxEQ7g78VU4O61ffAXopWwD3goDMpArfdWtuj8yPL62UFZxePJv1VYf+E1J
 eDTFAFt7z1dCB0A1JjtYwTb17ZU++YK55wRcRBhGMgglxrD3wQF6apa
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
Benjamin Tissoires (13):
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

 Documentation/hid/hid-bpf.rst                      | 162 +++---
 drivers/hid/bpf/Makefile                           |   2 +-
 drivers/hid/bpf/entrypoints/Makefile               |  93 ----
 drivers/hid/bpf/entrypoints/README                 |   4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c      |  25 -
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h    | 248 ---------
 drivers/hid/bpf/hid_bpf_dispatch.c                 | 266 +++-------
 drivers/hid/bpf/hid_bpf_dispatch.h                 |  12 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c                | 565 ---------------------
 drivers/hid/bpf/hid_bpf_struct_ops.c               | 246 +++++++++
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
 include/linux/hid_bpf.h                            | 109 ++--
 samples/hid/Makefile                               |   5 +-
 samples/hid/hid_bpf_attach.bpf.c                   |  18 -
 samples/hid/hid_bpf_attach.h                       |  14 -
 samples/hid/hid_mouse.bpf.c                        |  26 +-
 samples/hid/hid_mouse.c                            |  39 +-
 samples/hid/hid_surface_dial.bpf.c                 |  10 +-
 samples/hid/hid_surface_dial.c                     |  53 +-
 tools/testing/selftests/hid/hid_bpf.c              | 100 +++-
 tools/testing/selftests/hid/progs/hid.c            | 100 +++-
 31 files changed, 744 insertions(+), 1442 deletions(-)
---
base-commit: 70ec81c2e2b4005465ad0d042e90b36087c36104
change-id: 20240513-hid_bpf_struct_ops-e3212a224555

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


