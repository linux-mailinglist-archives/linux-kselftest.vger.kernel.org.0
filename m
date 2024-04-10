Return-Path: <linux-kselftest+bounces-7584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159B89FE38
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CED1C209DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A13181305;
	Wed, 10 Apr 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mws/LfwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9B17BB35;
	Wed, 10 Apr 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769606; cv=none; b=aZB6w8KgGQCoKx7YDBspWBkSsZmyI7Q6Y2jN8vUW5p/FCOazn5/FD7v5jw964MniKpqlnzUoo38XAnF2DxI9J0eBHftij9u28uo8nGY1DNMUYNlk34xKDXg1+sqzlhZdetEFCJy4j+s7Mt8zZrpdB1MRIDE2tB/DPa3qyM8x9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769606; c=relaxed/simple;
	bh=mq8w9/K/Sl7DZY0oXlSjvNqLLVrS7oIZqMQViPZfSHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JaSabdBar1+rnrmLrNL7Kc6P6fyY7OVHptr2vVib2PMlE28rDSPv8r5vQ3MOzK8hQRFKnLBlhVDubmQ6MiK8uTXpE0FfUTqp8yrES8sLf2qjoDwaO5VqIkALSXbb4c96pjUI+uaENoRtvlkAK6DmUsjDjtxBgifEJ6tXHPU66mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mws/LfwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF273C43390;
	Wed, 10 Apr 2024 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769606;
	bh=mq8w9/K/Sl7DZY0oXlSjvNqLLVrS7oIZqMQViPZfSHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mws/LfwHPUZZ7FmTP1Q3Wd/TkrvwHjSjz63xKq8sEId8PClMp/iHSc+WMAbCq27sg
	 jL/PD62EiX3kOgANAoxJR+hWqp7OitRirGYIt3zOGsN9JOjrf30ChqKVQu/kHOnllX
	 gdbb19Ww42bkAQm6sMn+7zakYDbTc7REPgVV8biRsD0hzI5D0wMNi5VOE6Vai5FeHb
	 KuCiZlTGbXINWfPU/mDRv2iQirhUt7Q/5A4MmEvf+hzdQ1WHWqHs250+P4HeFCZrs/
	 YlOeXxvji/QoYX9+wXayNYBlVuDBJ0RGnBjsUOmh4w5Zlu6GAVi5KH8+nbFoLY66fy
	 +7YSLohwJtY6g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:27 +0200
Subject: [PATCH 07/18] HID: bpf: add in-tree HID-BPF fix for the XBox Elite
 2 over Bluetooth
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-7-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=7141;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mq8w9/K/Sl7DZY0oXlSjvNqLLVrS7oIZqMQViPZfSHA=;
 b=7u6J/OWJsFXHD4r5Q32U0BSTuGvSzRlLTRyYnu2FwfVF8FMDwLb61+SiKG8O783m7NG6Y/pg9
 nsLPDa593e1DVAj97IOdJ2aabTbUoSiDv/zToWagaLWe3E75kC3Yd71
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When using the XBox Wireless Controller Elite 2 over Bluetooth,
the device exports the paddle on the back of the device as a single
bitfield value of usage "Assign Selection".

The kernel doesn't process those usages properly and report KEY_UNKNOWN
for it.

SDL doesn't know how to interprete that KEY_UNKNOWN and thus ignores the
paddles.

Given that over USB the kernel uses BTN_TRIGGER_HAPPY[5-8], we
can tweak the report descriptor to make the kernel interprete it properly:
- we need an application collection of gamepad (so we have to close the
  current Consumer Control one)
- we need to change the usage to be buttons from 0x15 to 0x18

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 .../hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c    | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
new file mode 100644
index 000000000000..c04abecab8ee
--- /dev/null
+++ b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_MICROSOFT 0x045e
+#define PID_XBOX_ELITE_2 0x0b22
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, VID_MICROSOFT, PID_XBOX_ELITE_2)
+);
+
+/*
+ * When using the XBox Wireless Controller Elite 2 over Bluetooth,
+ * the device exports the paddle on the back of the device as a single
+ * bitfield value of usage "Assign Selection".
+ *
+ * The kernel doesn't process those usages properly and report KEY_UNKNOWN
+ * for it.
+ *
+ * SDL doesn't know how to interprete that KEY_UNKNOWN and thus ignores the paddles.
+ *
+ * Given that over USB the kernel uses BTN_TRIGGER_HAPPY[5-8], we
+ * can tweak the report descriptor to make the kernel interprete it properly:
+ * - we need an application collection of gamepad (so we have to close the current
+ *   Consumer Control one)
+ * - we need to change the usage to be buttons from 0x15 to 0x18
+ */
+
+#define OFFSET_ASSIGN_SELECTION		211
+#define ORIGINAL_RDESC_SIZE		464
+
+const __u8 rdesc_assign_selection[] = {
+	0x0a, 0x99, 0x00,              //   Usage (Media Select Security)     211
+	0x15, 0x00,                    //   Logical Minimum (0)               214
+	0x26, 0xff, 0x00,              //   Logical Maximum (255)             216
+	0x95, 0x01,                    //   Report Count (1)                  219
+	0x75, 0x04,                    //   Report Size (4)                   221
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              223
+	0x15, 0x00,                    //   Logical Minimum (0)               225
+	0x25, 0x00,                    //   Logical Maximum (0)               227
+	0x95, 0x01,                    //   Report Count (1)                  229
+	0x75, 0x04,                    //   Report Size (4)                   231
+	0x81, 0x03,                    //   Input (Cnst,Var,Abs)              233
+	0x0a, 0x81, 0x00,              //   Usage (Assign Selection)          235
+	0x15, 0x00,                    //   Logical Minimum (0)               238
+	0x26, 0xff, 0x00,              //   Logical Maximum (255)             240
+	0x95, 0x01,                    //   Report Count (1)                  243
+	0x75, 0x04,                    //   Report Size (4)                   245
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              247
+};
+
+/*
+ * we replace the above report descriptor extract
+ * with the one below.
+ * To make things equal in size, we take out a larger
+ * portion than just the "Assign Selection" range, because
+ * we need to insert a new application collection to force
+ * the kernel to use BTN_TRIGGER_HAPPY[4-7].
+ */
+const __u8 fixed_rdesc_assign_selection[] = {
+	0x0a, 0x99, 0x00,              //   Usage (Media Select Security)     211
+	0x15, 0x00,                    //   Logical Minimum (0)               214
+	0x26, 0xff, 0x00,              //   Logical Maximum (255)             216
+	0x95, 0x01,                    //   Report Count (1)                  219
+	0x75, 0x04,                    //   Report Size (4)                   221
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              223
+	/* 0x15, 0x00, */              //   Logical Minimum (0)               ignored
+	0x25, 0x01,                    //   Logical Maximum (1)               225
+	0x95, 0x04,                    //   Report Count (4)                  227
+	0x75, 0x01,                    //   Report Size (1)                   229
+	0x81, 0x03,                    //   Input (Cnst,Var,Abs)              231
+	0xc0,                          //  End Collection                     233
+	0x05, 0x01,                    //  Usage Page (Generic Desktop)       234
+	0x0a, 0x05, 0x00,              //  Usage (Game Pad)                   236
+	0xa1, 0x01,                    //  Collection (Application)           239
+	0x05, 0x09,                    //   Usage Page (Button)               241
+	0x19, 0x15,                    //   Usage Minimum (21)                243
+	0x29, 0x18,                    //   Usage Maximum (24)                245
+	/* 0x15, 0x00, */              //  Logical Minimum (0)                ignored
+	/* 0x25, 0x01, */              //  Logical Maximum (1)                ignored
+	/* 0x95, 0x01, */              //  Report Size (1)                    ignored
+	/* 0x75, 0x04, */              //  Report Count (4)                   ignored
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              247
+};
+
+_Static_assert(sizeof(rdesc_assign_selection) == sizeof(fixed_rdesc_assign_selection),
+	       "Rdesc and fixed rdesc of different size");
+_Static_assert(sizeof(rdesc_assign_selection) + OFFSET_ASSIGN_SELECTION < ORIGINAL_RDESC_SIZE,
+	       "Rdesc at given offset is too big");
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* Check that the device is compatible */
+	if (__builtin_memcmp(data + OFFSET_ASSIGN_SELECTION,
+			     rdesc_assign_selection,
+			     sizeof(rdesc_assign_selection)))
+		return 0;
+
+	__builtin_memcpy(data + OFFSET_ASSIGN_SELECTION,
+			 fixed_rdesc_assign_selection,
+			 sizeof(fixed_rdesc_assign_selection));
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/* only bind to the keyboard interface */
+	ctx->retval = ctx->rdesc_size != ORIGINAL_RDESC_SIZE;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	if (__builtin_memcmp(ctx->rdesc + OFFSET_ASSIGN_SELECTION,
+			     rdesc_assign_selection,
+			     sizeof(rdesc_assign_selection)))
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


