Return-Path: <linux-kselftest+bounces-7583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5889FE32
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007AF285025
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020A180A82;
	Wed, 10 Apr 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9eQSxLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFA180A7E;
	Wed, 10 Apr 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769604; cv=none; b=tK7fveV6aMaZkiaissgpdaUd58oGKyCiGkNYYEZB9tqUixLUW9rnSqf+5sDBJb7qCbk190/7PTfn5faHH9fL3/Q5nrsQzUltFLuw2kNg6RRnzdGKIA30QtekH4+rifRms7ZQNkdrOm3RkzqpRJmchev7O4YzbpG2kHSBlPKbUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769604; c=relaxed/simple;
	bh=Yoj6noUuTq4EnBmHonf9P9rn/ehtns8YHs7nJPzafwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfEKpJz1HpRGHV+IYMMryHO8ViERnngPk04C7G4asT6roHtwwOYPl1oiJZlsu72OcdOWMZaKNhHRMhdfmrCXvH9N9ZcLat4LkMEmGRYNMfw+6jHwM44XcQ3KzGKDGwFH8dtFZmK5vkErxX1GQV13nBQboNzwHFGbljeWWANsMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9eQSxLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2869DC433C7;
	Wed, 10 Apr 2024 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769604;
	bh=Yoj6noUuTq4EnBmHonf9P9rn/ehtns8YHs7nJPzafwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9eQSxLhdNWdEtMWNav4mofe8SkyWgP1pMYPbF+I3U2sUWgsZzflKVIKh2h+mbI1t
	 1DqdzwokPNf1OpsJUcQp/3bcoC2bGIQf0HIRp9ZP95dtJrqs4VOAOyLFiSqoaEGMtG
	 oBXSZ4fF0QWLF4Vc55aT9y2AH+gvsAzZx0QOL4//AnfwUbn9RnUk+gR8cZ6SBZaucp
	 Khx3Vzq5vughjpKmLZVGIJ4jeh5FI0whEF0aoeqywTD4r2MqqXrs1PL6dlOvBaCxva
	 Mxim0fexrnXg7Bi70dBPYLxo3IYs58+LhXafSnfy8Yi2LpCVY1Npj6Gi3n9/Tkrvjw
	 uCjG4G+WasCJQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:26 +0200
Subject: [PATCH 06/18] HID: bpf: add in-tree HID-BPF fix for the Wacom
 ArtPen
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-6-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, 
 Jason Gerecke <killertofu@gmail.com>, 
 Aaron Armstrong Skomra <skomra@gmail.com>, 
 Joshua Dickens <Joshua@joshua-dickens.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=6090;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Yoj6noUuTq4EnBmHonf9P9rn/ehtns8YHs7nJPzafwI=;
 b=C1f/9GrCy+9EXmaFbhte0pZlA1FaZiAKvidVtyltMrTPRSCk82OhfG+WRijZhX5tUQi0q/Quq
 MblhKWWSC9mC8F1/u+NGjJiRee+OR2Ji2f0pWRETJR+IjeOP2tuucGv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This pen is compatible with multiple Wacom tablets, but we only add support
for the Intuos Pro 2 M, as this is the one our user reported the bug
against.

We can not generically add all compatible Wacom tablets as we are
writing the offsets by hand.

The point of this HID-BPF program is to work around a firmware limitation
where the pressure is repeated every other report.
Given that we know this will happen, we can change the first new pressure
information with the mean compared to the previous one. This way we
smooth the incoming pressure without losing information.

Cc: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>
Cc: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: Joshua Dickens <Joshua@joshua-dickens.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c | 173 ++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
new file mode 100644
index 000000000000..dc05aa48faa7
--- /dev/null
+++ b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_WACOM		0x056a
+#define ART_PEN_ID		0x0804
+#define PID_INTUOS_PRO_2_M	0x0357
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_WACOM, PID_INTUOS_PRO_2_M)
+);
+
+/*
+ * This filter is here for the Art Pen stylus only:
+ * - when used on some Wacom devices (see the list of attached PIDs), this pen
+ *   reports pressure every other events.
+ * - to solve that, given that we know that the next event will be the same as
+ *   the current one, we can emulate a smoother pressure reporting by reporting
+ *   the mean of the previous value and the current one.
+ *
+ * We are effectively delaying the pressure by one event every other event, but
+ * that's less of an annoyance compared to the chunkiness of the reported data.
+ *
+ * For example, let's assume the following set of events:
+ * <Tip switch 0> <X 0> <Y 0> <Pressure    0 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 1> <Y 1> <Pressure  100 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 2> <Y 2> <Pressure  100 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 3> <Y 3> <Pressure  200 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 4> <Y 4> <Pressure  200 > <Tooltype 0x0804>
+ * <Tip switch 0> <X 5> <Y 5> <Pressure    0 > <Tooltype 0x0804>
+ *
+ * The filter will report:
+ * <Tip switch 0> <X 0> <Y 0> <Pressure    0 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 1> <Y 1> <Pressure * 50*> <Tooltype 0x0804>
+ * <Tip switch 1> <X 2> <Y 2> <Pressure  100 > <Tooltype 0x0804>
+ * <Tip switch 1> <X 3> <Y 3> <Pressure *150*> <Tooltype 0x0804>
+ * <Tip switch 1> <X 4> <Y 4> <Pressure  200 > <Tooltype 0x0804>
+ * <Tip switch 0> <X 5> <Y 5> <Pressure    0 > <Tooltype 0x0804>
+ *
+ */
+
+struct wacom_params {
+	__u16 pid;
+	__u16 rdesc_len;
+	__u8 report_id;
+	__u8 report_len;
+	struct {
+		__u8 tip_switch;
+		__u8 pressure;
+		__u8 tool_type;
+	} offsets;
+};
+
+/*
+ * Multiple device can support the same stylus, so
+ * we need to know which device has which offsets
+ */
+static const struct wacom_params devices[] = {
+	{
+		.pid = PID_INTUOS_PRO_2_M,
+		.rdesc_len = 949,
+		.report_id = 16,
+		.report_len = 27,
+		.offsets = {
+			.tip_switch = 1,
+			.pressure = 8,
+			.tool_type = 25,
+		},
+	},
+};
+
+static struct wacom_params params = { 0 };
+
+/* HID-BPF reports a 64 bytes chunk anyway, so this ensures
+ * the verifier to know we are addressing the memory correctly
+ */
+#define PEN_REPORT_LEN		64
+
+/* only odd frames are modified */
+static bool odd;
+
+static __u16 prev_pressure;
+
+static inline void *get_bits(__u8 *data, unsigned int byte_offset)
+{
+	return data + byte_offset;
+}
+
+static inline __u16 *get_u16(__u8 *data, unsigned int offset)
+{
+	return (__u16 *)get_bits(data, offset);
+}
+
+static inline __u8 *get_u8(__u8 *data, unsigned int offset)
+{
+	return (__u8 *)get_bits(data, offset);
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(artpen_pressure_interpolate, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, PEN_REPORT_LEN /* size */);
+	__u16 *pressure, *tool_type;
+	__u8 *tip_switch;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (data[0] != params.report_id ||
+	    params.offsets.tip_switch >= PEN_REPORT_LEN ||
+	    params.offsets.pressure >= PEN_REPORT_LEN - 1 ||
+	    params.offsets.tool_type >= PEN_REPORT_LEN - 1)
+		return 0; /* invalid report or parameters */
+
+	tool_type = get_u16(data, params.offsets.tool_type);
+	if (*tool_type != ART_PEN_ID)
+		return 0;
+
+	tip_switch = get_u8(data, params.offsets.tip_switch);
+	if ((*tip_switch & 0x01) == 0) {
+		prev_pressure = 0;
+		odd = true;
+		return 0;
+	}
+
+	pressure = get_u16(data, params.offsets.pressure);
+
+	if (odd)
+		*pressure = (*pressure + prev_pressure) / 2;
+
+	prev_pressure = *pressure;
+	odd = !odd;
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	struct hid_bpf_ctx *hid_ctx;
+	__u16 pid;
+	int i;
+
+	/* get a struct hid_device to access the actual pid of the device */
+	hid_ctx = hid_bpf_allocate_context(ctx->hid);
+	if (!hid_ctx) {
+		ctx->retval = -ENODEV;
+		return -1; /* EPERM check */
+	}
+	pid = hid_ctx->hid->product;
+
+	ctx->retval = -EINVAL;
+
+	/* Match the given device with the list of known devices */
+	for (i = 0; i < ARRAY_SIZE(devices); i++) {
+		const struct wacom_params *device = &devices[i];
+
+		if (device->pid == pid && device->rdesc_len == ctx->rdesc_size) {
+			params = *device;
+			ctx->retval = 0;
+		}
+	}
+
+	hid_bpf_release_context(hid_ctx);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


