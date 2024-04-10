Return-Path: <linux-kselftest+bounces-7581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D492E89FE2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051A31C220E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A361802A9;
	Wed, 10 Apr 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHR97PJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74417BB21;
	Wed, 10 Apr 2024 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769600; cv=none; b=JUEv/MytsM93Xx7xY6CJawH1ZAU7EFwWlb1sYSQ+zs7yjiOq+ym59fhcRGx3+ZXR18iMu+E0YwHQJ5KO07ruev3R92gKJEzyTc2QxZ5pCu3ZxWXRPZ4Eu1HKFjNci3MbM+6ESpAtpbOfVXAWw2RElct5UsZIFlJB47222EmV2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769600; c=relaxed/simple;
	bh=GdMP7KB2AP5WOlPh77qAilvcjUotd4SP3HgqhOGhk04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1GMvMyDiteHUyPckPN017acz0JaJ29WFkySN5l8y2jM+4PAu3Kqp+fqnDnh0mGnuIXcuC7aLG6a3DQQtSehEvYR48VYsTAzGxghCEKDGowo0oVu22YcacpPKs1KerQQo7lehPMYo47qy1cI9ApV/iGzWkHD8VYKuLI5ayU+q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHR97PJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8DEC43390;
	Wed, 10 Apr 2024 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769599;
	bh=GdMP7KB2AP5WOlPh77qAilvcjUotd4SP3HgqhOGhk04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NHR97PJxcAUhKLa24bnkHaq9qFFf66TUNo4ryU6RD3p/YGwsSZSrmj7NYOG4LYum8
	 gm++usv0IBK9fr5YwiaQTAueOo1AJKBmPj3FTxHz98CSpMkPlWfwngsT5r4ZgbVdw/
	 dAmODS0CdD+zURD5IIrc0pxkeHWs10UR6iYnvFfhU+8YGOGY8QWXdrp8rdg6RoW1xI
	 D+gBsCbyrRJ6JeVKlKyQxxIxtV8g8vqK9YmTqJm9MYwQgp7RRZRMc7stzcM+uaeOqz
	 2uv3Vx8UDHUqcMZW+XxcGDqKtPPYXtKzkvnIuFHKbopgzyjwne5HZ5p01ljdX3sWn6
	 Z+rg/ZdMuMh9A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:24 +0200
Subject: [PATCH 04/18] HID: bpf: add in-tree HID-BPF fix for the HP Elite
 Presenter Mouse
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-4-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=2434;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=GdMP7KB2AP5WOlPh77qAilvcjUotd4SP3HgqhOGhk04=;
 b=U/T1pI9MI/OMzR6XqGImiU2o7PCQWHxiVg0f0fMFIJPPTJzQdpLslwe4K71CMB075k1U5KXvI
 Vcr8GX07I1XD5IA1iHr6e6Um0NoRwpaUsoFfStpsPRijfUHT6bhGb3S
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Duplicate of commit 0db117359e47 ("HID: add quirk for 03f0:464a HP Elite
Presenter Mouse"), but in a slightly better way.

This time we actually change the application collection, making clearer
for userspace what the second mouse is.

Note that having both hid-quirks fix and this HID-BPF fix is not a
problem at all.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
new file mode 100644
index 000000000000..3d14bbb6f276
--- /dev/null
+++ b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_HP 0x03F0
+#define PID_ELITE_PRESENTER 0x464A
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, VID_HP, PID_ELITE_PRESENTER)
+);
+
+/*
+ * Already fixed as of commit 0db117359e47 ("HID: add quirk for 03f0:464a
+ * HP Elite Presenter Mouse") in the kernel, but this is a slightly better
+ * fix.
+ *
+ * The HP Elite Presenter Mouse HID Record Descriptor shows
+ * two mice (Report ID 0x1 and 0x2), one keypad (Report ID 0x5),
+ * two Consumer Controls (Report IDs 0x6 and 0x3).
+ * Prior to these fixes it registers one mouse, one keypad
+ * and one Consumer Control, and it was usable only as a
+ * digital laser pointer (one of the two mouses).
+ * We replace the second mouse collection with a pointer collection,
+ * allowing to use the device both as a mouse and a digital laser
+ * pointer.
+ */
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* replace application mouse by application pointer on the second collection */
+	if (data[79] == 0x02)
+		data[79] = 0x01;
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	ctx->retval = ctx->rdesc_size != 264;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


