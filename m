Return-Path: <linux-kselftest+bounces-7582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369189FE2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651331F22DD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A581802D7;
	Wed, 10 Apr 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFxkdC1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDA1802CF;
	Wed, 10 Apr 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769602; cv=none; b=QfeeRc+UrdrjjKrGVwBGBa2VruYOXWxNsa45UQI8hkc3F/vC6GR0bTkEcfHY60jfSQfHMaExYY7chNK3y1M8eLmAu/wMAZWrRDMRYD83pT5ToBUb5lmilhKiKxjAj2/X0n7ARM+H4GefI9Z21taWYCan1WsU0BDukea2phA3GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769602; c=relaxed/simple;
	bh=3thyF8TXi2zqo/LMZKFE+HSC98gQ0GfLX2rEdsYzQSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=es2o613xR/XUe4PDd2yXtwZN8rwknqhb0RQGo10jsVC2IpOmjwNwEO+Jc79dGia6ZQUQm1GFlaeAlC0rrBD+Q65a7SXAicnM6B5nFT/PYi7PHiAtRRUqcgyOvX/uE4l+b0j6hQrteJ7sUrMLVk5jRzcbzeCWfBVkLaW4M6Fs2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFxkdC1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47940C433A6;
	Wed, 10 Apr 2024 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769601;
	bh=3thyF8TXi2zqo/LMZKFE+HSC98gQ0GfLX2rEdsYzQSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UFxkdC1z/1kzNDFHk/lL9Acl/OWASq+lO3vjVB3EzB5Ae0cx45LgvXiOMccVQtl1g
	 Tb19YvxSbUMzCllxAozmZ6oIyfgOYulnX72u/WiqVadRdNytf6zaS6BXCkHXrgroOe
	 NAs8MSYBwct3e7FYN80+PGP9eBfBURg7C0wr/F7DdT+cn95frKtIz6yww0VKy0/vPx
	 0ok64eLaZ5x1MPHrxeCvgiPgJwRxw/xvq7YkFsir5K6ZP/An66dsWnlJ3WDGUJ19Ic
	 GT8TafZAeQsEbXXJkgSF1elA/k+amsu3smKMJEpUglwecnclSx3Sm6VAqpyx2Uj+XP
	 mhUoHFHXOdOFQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:25 +0200
Subject: [PATCH 05/18] HID: bpf: add in-tree HID-BPF fix for the IOGear
 Kaliber Gaming MMOmentum mouse
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-5-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=2107;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=3thyF8TXi2zqo/LMZKFE+HSC98gQ0GfLX2rEdsYzQSA=;
 b=jhTpFpQs9b6BoaUe/jvmEzLqj2oCWq84Eg42H5tmhv1rdYa6AH3HhdHhdeZUxrxURtkSl3Z/D
 ZsgdHI0Mwr5CcUUp+rPiabsXUHmNlFIerl5uiE74pUhh1Llm9Qr2rAw
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to export more than 5 buttons on this 12 buttons mouse.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
new file mode 100644
index 000000000000..225cbefdbf0e
--- /dev/null
+++ b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_IOGEAR 0x258A /* VID is shared with SinoWealth and Glorious and prob others */
+#define PID_MOMENTUM 0x0027
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_IOGEAR, PID_MOMENTUM)
+);
+
+/*
+ * The IOGear Kaliber Gaming MMOmentum Pro mouse has multiple buttons (12)
+ * but only 5 are accessible out of the box because the report descriptor
+ * marks the other buttons as constants.
+ * We just fix the report descriptor to enable those missing 7 buttons.
+ */
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
+{
+	const u8 offsets[] = {84, 112, 140};
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* if not Keyboard */
+	if (data[3] != 0x06)
+		return 0;
+
+	for (int idx = 0; idx < ARRAY_SIZE(offsets); idx++) {
+		u8 offset = offsets[idx];
+
+		/* if Input (Cnst,Var,Abs) , make it Input (Data,Var,Abs) */
+		if (data[offset] == 0x81 && data[offset + 1] == 0x03)
+			data[offset + 1] = 0x02;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/* only bind to the keyboard interface */
+	ctx->retval = ctx->rdesc_size != 213;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


