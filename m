Return-Path: <linux-kselftest+bounces-11481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A769010DA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134FBB21AAA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720417C221;
	Sat,  8 Jun 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI76BG4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420817C21A;
	Sat,  8 Jun 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837307; cv=none; b=ov3KX/n54SWcleMV9vVAXv5U11AJz6eP2e/XWH5d+276I2OmeUzunwwTQ69z9sjp8uF5dv7nWJFUAltwn/Eijhihr6TXGIxQvOvnjKYtcVvCvHLst+BmxwXITbSb0c9ZxIRKuRovx+GI+65HMl+4kpQFQTw6ylinnen/d8WJcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837307; c=relaxed/simple;
	bh=Q+Ac2u6IrcunkGq5of0uabcj090YkndfqLEDRr9KTMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8LJ+g8g+RwYd0X5zxvhNW2s1/cV+sV/87xxESifBerbD1Roc5hdPJocrTcggvmCz4qpMhKG2VDaLWY6OaLmaeXWRTrBNExzZBybhs1UGAPbHp/y18DwJeIJFWQgfBYjPgaaj+fomz6034msvVKtJLO6YZNoPcj2sy+7lxX7Fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI76BG4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE19C3277B;
	Sat,  8 Jun 2024 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837307;
	bh=Q+Ac2u6IrcunkGq5of0uabcj090YkndfqLEDRr9KTMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jI76BG4i9uihwm6M7RArAtpS01nQRRfReaJpgG3qp9dXEEFrn3XSuogpEJI2kSe9Q
	 H0bV/0uTW54gDQN7XMQSJ4sTch+kQWww4nBkTHu12HQsP2zwvCE7R7Q2ahaXXFZDTp
	 HNdWZkoGvps+GyZIcGesn3f8ZkjP6fQYM/e1LAta2x8AcxkhmQ6Ld/jBlZF9j00y1s
	 oxoDTxtsVrQHkClynPy/sOtdbKwGqNSWf0FzXKkikWbtX+2V5tm5mTBElwYC3oRr/l
	 MmeV5Pn6iuqFIdpBoPA2xJAN21kqJTYMdh+CcZKNCq9QLM5T8+ZpOAZCsoOsH+cpsL
	 EXr5CsmCrZGdg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:23 +0200
Subject: [PATCH HID v3 11/16] Documentation: HID: add a small blurb on
 udev-hid-bpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-11-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=1825;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Q+Ac2u6IrcunkGq5of0uabcj090YkndfqLEDRr9KTMo=;
 b=+evcf//zew7WoveGul3DJER+y/2Z2upCyb/BJMaE8c2k4StDCEQUWjbiRyNCtXzV4nlXSxKf1
 pm78qDv3d+yCzXPaYgMggUpyNO/p4bb851f/QsZ/qh+GGdonS3XzPip
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is the current decision we took: we don't provide automatic loading
of HID-BPF by the kernel directly, but rely on an external tool for it.

This tool is currently udev-hid-bpf, so let's make people aware of it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 Documentation/hid/hid-bpf.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 456e15097d87..8ae8f49801cb 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -129,6 +129,23 @@ When a BPF program needs to emit input events, it needs to talk with the HID
 protocol, and rely on the HID kernel processing to translate the HID data into
 input events.
 
+In-tree HID-BPF programs and ``udev-hid-bpf``
+=============================================
+
+Official device fixes are shipped in the kernel tree as source in the
+``drivers/hid/bpf/progs`` directory. This allows to add selftests to them in
+``tools/testing/selftests/hid``.
+
+However, the compilation of these objects is not part of a regular kernel compilation
+given that they need an external tool to be loaded. This tool is currently
+`udev-hid-bpf <https://libevdev.pages.freedesktop.org/udev-hid-bpf/index.html>`_.
+
+For convenience, that external repository duplicates the files from here in
+``drivers/hid/bpf/progs`` into its own ``src/bpf/stable`` directory. This allows
+distributions to not have to pull the entire kernel source tree to ship and package
+those HID-BPF fixes. ``udev-hid-bpf`` also has capabilities of handling multiple
+objects files depending on the kernel the user is running.
+
 Available types of programs
 ===========================
 

-- 
2.44.0


