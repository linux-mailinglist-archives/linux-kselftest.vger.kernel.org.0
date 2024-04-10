Return-Path: <linux-kselftest+bounces-7580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7389FE2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BDC2855F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA317F39D;
	Wed, 10 Apr 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQdOpSnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689C17F37A;
	Wed, 10 Apr 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769598; cv=none; b=nmGHHhGv0gUeVrZOELmWnuJ4UJlOFqEwSapUO/mo3QM9u/74r5qpu8/c6naaeXwjW2phQPXNKEBrbazFq3g8pep7UfrevyOT6YKXdopse6tYwmDYAZUAZCxVmQmUDYmfX/Du3zUL9qlaFzm5dS+ICtKjNgjKNvGu0h3ix3ioIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769598; c=relaxed/simple;
	bh=W29a1hCohS/gyp1nsAMz6TYmQs533xWczThWwbjEjU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGEeXMOG8a7lO9RH14Kmbs+eZNEEKHZeUGg7mWmzDf2aJUHmy6k8SFMn3bOgxBtNmxE5o0ipeiSnGL9DYkR/q8SfgFv5Jw4SwXeWlwxy0lbjIX97uFAsaIL5PaPgecKUlQN0QSqu24/1Erh00fSwIFwhyqetEIeawnExhDHt06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQdOpSnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68949C433F1;
	Wed, 10 Apr 2024 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769598;
	bh=W29a1hCohS/gyp1nsAMz6TYmQs533xWczThWwbjEjU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JQdOpSnmS823gyd70Tv4QWMXCjbNbEf4fE+WGQQZhn79sHIbXMlSeGP6Cliy5v/mg
	 VwMtIARmyRvrbZY8jjMwyOc0eo+N/LGcGDI5zDmWIyPtJmHh/16AlCWJ3Qw0Fy/kM4
	 T1ELQCDnj5Q79Te2Um/nNf/ZKk6idRmNu/LDmhN3Fp3ZPB1+qXVUJ2ZmYPAtp1Cw6l
	 7EbnG30JoTbLuiM6IGS8O4RemxHRd2c0lPuF8dig8Bu+ozXR4OItGIWsdO4fU5Xq8+
	 6xNYfQvKXjAd4r3aCDaMhS9zj20DUwm3rjRShPeMGFD79s+4eJ4gxWWMASoeUamvKn
	 WtTOKzfj5cmtg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:23 +0200
Subject: [PATCH 03/18] HID: bpf: add in-tree HID-BPF fix for the XPPen
 Artist 16
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-3-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Martin Sivak <mars@montik.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=13125;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=W29a1hCohS/gyp1nsAMz6TYmQs533xWczThWwbjEjU4=;
 b=AZKy9wvROvQhIcMtPugqXwldrw+ELC+v7Iz+fQJehXe1zP384h0tNnxtDgxynO/06t+kNDkoA
 YzngU7914mMCnwt0DZmEXuA48vcKp5qbeNW2DQYkGAPeGy7vNYoJ2hI
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Same problem than the Artist 24: the second button on the pen is treated
like an eraser.
But the problem is even worse this time. There is an actual eraser at
the tail of the pen.

The compensation of the coordinates was done by Martin

Signed-off-by: Martin Sivak <mars@montik.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c | 274 +++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
new file mode 100644
index 000000000000..65ef10036126
--- /dev/null
+++ b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_UGEE 0x28BD /* VID is shared with SinoWealth and Glorious and prob others */
+#define PID_ARTIST_PRO14_GEN2 0x095A
+#define PID_ARTIST_PRO16_GEN2 0x095B
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_UGEE, PID_ARTIST_PRO14_GEN2),
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_UGEE, PID_ARTIST_PRO16_GEN2)
+);
+
+/*
+ * We need to amend the report descriptor for the following:
+ * - the device reports Eraser instead of using Secondary Barrel Switch
+ * - when the eraser button is pressed and the stylus is touching the tablet,
+ *   the device sends Tip Switch instead of sending Eraser
+ *
+ * This descriptor uses physical dimensions of the 16" device.
+ */
+static const __u8 fixed_rdesc[] = {
+	0x05, 0x0d,                    // Usage Page (Digitizers)             0
+	0x09, 0x02,                    // Usage (Pen)                         2
+	0xa1, 0x01,                    // Collection (Application)            4
+	0x85, 0x07,                    //  Report ID (7)                      6
+	0x09, 0x20,                    //  Usage (Stylus)                     8
+	0xa1, 0x00,                    //  Collection (Physical)              10
+	0x09, 0x42,                    //   Usage (Tip Switch)                12
+	0x09, 0x44,                    //   Usage (Barrel Switch)             14
+	0x09, 0x5a,                    //   Usage (Secondary Barrel Switch)   16  /* changed from 0x45 (Eraser) to 0x5a (Secondary Barrel Switch) */
+	0x09, 0x3c,                    //   Usage (Invert)                    18
+	0x09, 0x45,                    //   Usage (Eraser)                    16  /* created over a padding bit at offset 29-33 */
+	0x15, 0x00,                    //   Logical Minimum (0)               20
+	0x25, 0x01,                    //   Logical Maximum (1)               22
+	0x75, 0x01,                    //   Report Size (1)                   24
+	0x95, 0x05,                    //   Report Count (5)                  26  /* changed from 4 to 5 */
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              28
+	0x09, 0x32,                    //   Usage (In Range)                  34
+	0x15, 0x00,                    //   Logical Minimum (0)               36
+	0x25, 0x01,                    //   Logical Maximum (1)               38
+	0x95, 0x01,                    //   Report Count (1)                  40
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              42
+	0x95, 0x02,                    //   Report Count (2)                  44
+	0x81, 0x03,                    //   Input (Cnst,Var,Abs)              46
+	0x75, 0x10,                    //   Report Size (16)                  48
+	0x95, 0x01,                    //   Report Count (1)                  50
+	0x35, 0x00,                    //   Physical Minimum (0)              52
+	0xa4,                          //   Push                              54
+	0x05, 0x01,                    //   Usage Page (Generic Desktop)      55
+	0x09, 0x30,                    //   Usage (X)                         57
+	0x65, 0x13,                    //   Unit (EnglishLinear: in)          59
+	0x55, 0x0d,                    //   Unit Exponent (-3)                61
+	0x46, 0xff, 0x34,              //   Physical Maximum (13567)          63
+	0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           66
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              69
+	0x09, 0x31,                    //   Usage (Y)                         71
+	0x46, 0x20, 0x21,              //   Physical Maximum (8480)           73
+	0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           76
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              79
+	0xb4,                          //   Pop                               81
+	0x09, 0x30,                    //   Usage (Tip Pressure)              82
+	0x45, 0x00,                    //   Physical Maximum (0)              84
+	0x26, 0xff, 0x3f,              //   Logical Maximum (16383)           86
+	0x81, 0x42,                    //   Input (Data,Var,Abs,Null)         89
+	0x09, 0x3d,                    //   Usage (X Tilt)                    91
+	0x15, 0x81,                    //   Logical Minimum (-127)            93
+	0x25, 0x7f,                    //   Logical Maximum (127)             95
+	0x75, 0x08,                    //   Report Size (8)                   97
+	0x95, 0x01,                    //   Report Count (1)                  99
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              101
+	0x09, 0x3e,                    //   Usage (Y Tilt)                    103
+	0x15, 0x81,                    //   Logical Minimum (-127)            105
+	0x25, 0x7f,                    //   Logical Maximum (127)             107
+	0x81, 0x02,                    //   Input (Data,Var,Abs)              109
+	0xc0,                          //  End Collection                     111
+	0xc0,                          // End Collection                      112
+};
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_fix_rdesc_xppen_artistpro16gen2, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	__builtin_memcpy(data, fixed_rdesc, sizeof(fixed_rdesc));
+
+	/* Fix the Physical maximum values for different sizes of the device
+	 * The 14" screen device descriptor size is 11.874" x 7.421"
+	 */
+	if (hctx->hid->product == PID_ARTIST_PRO14_GEN2) {
+		data[63] = 0x2e;
+		data[62] = 0x62;
+		data[73] = 0x1c;
+		data[72] = 0xfd;
+	}
+
+	return sizeof(fixed_rdesc);
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(xppen_16_fix_eraser, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if ((data[1] & 0x29) != 0x29) /* tip switch=1 invert=1 inrange=1 */
+		return 0;
+
+	/* xor bits 0,3 and 4: convert Tip Switch + Invert into Eraser only */
+	data[1] ^= 0x19;
+
+	return 0;
+}
+
+/*
+ * Static coordinate offset table based on positive only angles
+ * Two tables are needed, because the logical coordinates are scaled
+ *
+ * The table can be generated by Python like this:
+ * >>> full_scale = 11.874 # the display width/height in inches
+ * >>> tip_height = 0.055677699 # the center of the pen coil distance from screen in inch (empirical)
+ * >>> h = tip_height * (32767 / full_scale) # height of the coil in logical coordinates
+ * >>> [round(h*math.sin(math.radians(d))) for d in range(0, 128)]
+ * [0, 13, 26, ....]
+ */
+
+/* 14" inch screen 11.874" x 7.421" */
+static const __u16 angle_offsets_horizontal_14[128] = {
+	0, 3, 5, 8, 11, 13, 16, 19, 21, 24, 27, 29, 32, 35, 37, 40, 42, 45, 47, 50, 53,
+	55, 58, 60, 62, 65, 67, 70, 72, 74, 77, 79, 81, 84, 86, 88, 90, 92, 95, 97, 99,
+	101, 103, 105, 107, 109, 111, 112, 114, 116, 118, 119, 121, 123, 124, 126, 127,
+	129, 130, 132, 133, 134, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146,
+	147, 148, 148, 149, 150, 150, 151, 151, 152, 152, 153, 153, 153, 153, 153, 154,
+	154, 154, 154, 154, 153, 153, 153, 153, 153, 152, 152, 151, 151, 150, 150, 149,
+	148, 148, 147, 146, 145, 144, 143, 142, 141, 140, 139, 138, 137, 136, 134, 133,
+	132, 130, 129, 127, 126, 124, 123
+};
+static const __u16 angle_offsets_vertical_14[128] = {
+	0, 4, 9, 13, 17, 21, 26, 30, 34, 38, 43, 47, 51, 55, 59, 64, 68, 72, 76, 80, 84,
+	88, 92, 96, 100, 104, 108, 112, 115, 119, 123, 127, 130, 134, 137, 141, 145, 148,
+	151, 155, 158, 161, 165, 168, 171, 174, 177, 180, 183, 186, 188, 191, 194, 196,
+	199, 201, 204, 206, 208, 211, 213, 215, 217, 219, 221, 223, 225, 226, 228, 230,
+	231, 232, 234, 235, 236, 237, 239, 240, 240, 241, 242, 243, 243, 244, 244, 245,
+	245, 246, 246, 246, 246, 246, 246, 246, 245, 245, 244, 244, 243, 243, 242, 241,
+	240, 240, 239, 237, 236, 235, 234, 232, 231, 230, 228, 226, 225, 223, 221, 219,
+	217, 215, 213, 211, 208, 206, 204, 201, 199, 196
+};
+
+/* 16" inch screen 13.567" x 8.480" */
+static const __u16 angle_offsets_horizontal_16[128] = {
+	0, 2, 5, 7, 9, 12, 14, 16, 19, 21, 23, 26, 28, 30, 33, 35, 37, 39, 42, 44, 46, 48,
+	50, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 86, 88, 90,
+	92, 93, 95, 97, 98, 100, 101, 103, 105, 106, 107, 109, 110, 111, 113, 114, 115,
+	116, 118, 119, 120, 121, 122, 123, 124, 125, 126, 126, 127, 128, 129, 129, 130,
+	130, 131, 132, 132, 132, 133, 133, 133, 134, 134, 134, 134, 134, 134, 134, 134,
+	134, 134, 134, 134, 134, 133, 133, 133, 132, 132, 132, 131, 130, 130, 129, 129,
+	128, 127, 126, 126, 125, 124, 123, 122, 121, 120, 119, 118, 116, 115, 114, 113,
+	111, 110, 109, 107
+};
+static const __u16 angle_offsets_vertical_16[128] = {
+	0, 4, 8, 11, 15, 19, 22, 26, 30, 34, 37, 41, 45, 48, 52, 56, 59, 63, 66, 70, 74,
+	77, 81, 84, 88, 91, 94, 98, 101, 104, 108, 111, 114, 117, 120, 123, 126, 129, 132,
+	135, 138, 141, 144, 147, 149, 152, 155, 157, 160, 162, 165, 167, 170, 172, 174,
+	176, 178, 180, 182, 184, 186, 188, 190, 192, 193, 195, 197, 198, 199, 201, 202,
+	203, 205, 206, 207, 208, 209, 210, 210, 211, 212, 212, 213, 214, 214, 214, 215,
+	215, 215, 215, 215, 215, 215, 215, 215, 214, 214, 214, 213, 212, 212, 211, 210,
+	210, 209, 208, 207, 206, 205, 203, 202, 201, 199, 198, 197, 195, 193, 192, 190,
+	188, 186, 184, 182, 180, 178, 176, 174, 172
+};
+
+static void compensate_coordinates_by_tilt(__u8 *data, const __u8 idx,
+		const __s8 tilt, const __u16 (*compensation_table)[128])
+{
+	__u16 coords = data[idx+1];
+
+	coords <<= 8;
+	coords += data[idx];
+
+	__u8 direction = tilt > 0 ? 0 : 1; /* Positive tilt means we need to subtract the compensation (vs. negative angle where we need to add) */
+	__u8 angle = tilt > 0 ? tilt : -tilt;
+
+	if (angle > 127)
+		return;
+
+	__u16 compensation = (*compensation_table)[angle];
+
+	if (direction == 0) {
+		coords = (coords > compensation) ? coords - compensation : 0;
+	} else {
+		const __u16 logical_maximum = 32767;
+		__u16 max = logical_maximum - compensation;
+
+		coords = (coords < max) ? coords + compensation : logical_maximum;
+	}
+
+	data[idx] = coords & 0xff;
+	data[idx+1] = coords >> 8;
+}
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(xppen_16_fix_angle_offset, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/*
+	 * Compensate X and Y offset caused by tilt.
+	 *
+	 * The magnetic center moves when the pen is tilted, because the coil
+	 * is not touching the screen.
+	 *
+	 * a (tilt angle)
+	 * |  /... h (coil distance from tip)
+	 * | /
+	 * |/______
+	 *         |x (position offset)
+	 *
+	 * x = sin a * h
+	 *
+	 * Subtract the offset from the coordinates. Use the precomputed table!
+	 *
+	 * bytes 0   - report id
+	 *       1   - buttons
+	 *       2-3 - X coords (logical)
+	 *       4-5 - Y coords
+	 *       6-7 - pressure (ignore)
+	 *       8   - tilt X
+	 *       9   - tilt Y
+	 */
+
+	__s8 tilt_x = (__s8) data[8];
+	__s8 tilt_y = (__s8) data[9];
+
+	if (hctx->hid->product == PID_ARTIST_PRO14_GEN2) {
+		compensate_coordinates_by_tilt(data, 2, tilt_x, &angle_offsets_horizontal_14);
+		compensate_coordinates_by_tilt(data, 4, tilt_y, &angle_offsets_vertical_14);
+	} else if (hctx->hid->product == PID_ARTIST_PRO16_GEN2) {
+		compensate_coordinates_by_tilt(data, 2, tilt_x, &angle_offsets_horizontal_16);
+		compensate_coordinates_by_tilt(data, 4, tilt_y, &angle_offsets_vertical_16);
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/*
+	 * The device exports 3 interfaces.
+	 */
+	ctx->retval = ctx->rdesc_size != 113;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	/* ensure the kernel isn't fixed already */
+	if (ctx->rdesc[17] != 0x45) /* Eraser */
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


