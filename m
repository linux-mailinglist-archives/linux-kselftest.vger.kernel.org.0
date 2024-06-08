Return-Path: <linux-kselftest+bounces-11471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB79010A6
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DF0B20EFE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39F177990;
	Sat,  8 Jun 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNgjYxGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BC177980;
	Sat,  8 Jun 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837284; cv=none; b=nq88XuWGvkQ+IhnmLsfVL0VFSprm9+fWijWErN9s6BdErVw/Cx7kHbhPth8ZU9T9rP0F4MOdpzdmz4acQyPYJdNdiy/NrcDcV8as0/9ul/fzAwMIjmsQnP5q4oGemRgJ16yHR0OTaZtcz+9OdRyD2FbuRQA18/rdWA0nrFJ189I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837284; c=relaxed/simple;
	bh=SqWBE4A1R6EX1/tAq/E6TPVDDWLh4zwW64KIjuXOJ/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj25ftfI7KN9mKI5xLM7Mm/+hkTx1sH1X9togFpv3rHWieZd2uXhsDV6ZU6rv5y0o8CEd4wNBXkwkXGwdybrF5+y9ew5I36071oVT5V3WN3XYy0+YkOHfNXSImBZewLTO8AWgbVOJwWG/SZuL465z10wAoRvrgNgI9ij/3VbH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNgjYxGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69438C4AF07;
	Sat,  8 Jun 2024 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837284;
	bh=SqWBE4A1R6EX1/tAq/E6TPVDDWLh4zwW64KIjuXOJ/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LNgjYxGAy0lGwbi3PctrZqslXdqHKQWx/1aslH/2ndaf1FcSUhI1t/LKBxGPzKAKb
	 GAQVL+LEA18H08yLc0Fc4ZZQv2k/+O7ZYHtnk7Rz9CnW8eLpcSpGoK60kmGUEq26/e
	 qy6ZIGYHHkaRj3ciANHsSbbzUg7gFetQ+Dt/bT+k/PWxqcqNodCojtKTayQJYY4QO1
	 8AIdOJE9djRaxp0M+nQgi9+0UbhPgS0iGNDifWfDyB9+kFEtFsVOimAFtC10fYaZAQ
	 izsYfilJCCiNlbVvHA4Snr7TqXf9MNf2jQ8hwkhFdn7nJyDFTjzes/5cyCbYvk/sEO
	 EMnNdk40+o1vA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:13 +0200
Subject: [PATCH HID v3 01/16] HID: rename struct hid_bpf_ops into hid_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-1-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=4952;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SqWBE4A1R6EX1/tAq/E6TPVDDWLh4zwW64KIjuXOJ/s=;
 b=Vtd+6fiKrGf5Kv+rkk9gDbM+ZniP5naQNsBcVqEj6wyzmmQzXg/Uxs7c+M8ZTPmalJFP65w/u
 9PcdU+lX/A0BXh9lrYXPvmIC/Kj1sONa7hM1UvMDaMMglOylTsDhuNb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Those operations are the ones from HID, not HID-BPF, and I'd like to
reuse hid_bpf_ops as the user facing struct_ops API.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 22 +++++++++++-----------
 drivers/hid/hid-core.c             |  6 +++---
 include/linux/hid_bpf.h            |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 10289f44d0cc..55c9f82fdef0 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -21,8 +21,8 @@
 #include "hid_bpf_dispatch.h"
 #include "entrypoints/entrypoints.lskel.h"
 
-struct hid_bpf_ops *hid_bpf_ops;
-EXPORT_SYMBOL(hid_bpf_ops);
+struct hid_ops *hid_ops;
+EXPORT_SYMBOL(hid_ops);
 
 /**
  * hid_bpf_device_event - Called whenever an event is coming in from the device
@@ -284,13 +284,13 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 	struct device *dev;
 	int err, fd;
 
-	if (!hid_bpf_ops)
+	if (!hid_ops)
 		return -EINVAL;
 
 	if ((flags & ~HID_BPF_FLAG_MASK))
 		return -EINVAL;
 
-	dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
+	dev = bus_find_device(hid_ops->bus_type, NULL, &hid_id, device_match_id);
 	if (!dev)
 		return -EINVAL;
 
@@ -335,10 +335,10 @@ hid_bpf_allocate_context(unsigned int hid_id)
 	struct hid_bpf_ctx_kern *ctx_kern = NULL;
 	struct device *dev;
 
-	if (!hid_bpf_ops)
+	if (!hid_ops)
 		return NULL;
 
-	dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
+	dev = bus_find_device(hid_ops->bus_type, NULL, &hid_id, device_match_id);
 	if (!dev)
 		return NULL;
 
@@ -386,7 +386,7 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 	u32 report_len;
 
 	/* check arguments */
-	if (!ctx || !hid_bpf_ops || !buf)
+	if (!ctx || !hid_ops || !buf)
 		return -EINVAL;
 
 	switch (rtype) {
@@ -404,7 +404,7 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 	hdev = (struct hid_device *)ctx->hid; /* discard const */
 
 	report_enum = hdev->report_enum + rtype;
-	report = hid_bpf_ops->hid_get_report(report_enum, buf);
+	report = hid_ops->hid_get_report(report_enum, buf);
 	if (!report)
 		return -EINVAL;
 
@@ -459,7 +459,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_bpf_ops->hid_hw_raw_request(hdev,
+	ret = hid_ops->hid_hw_raw_request(hdev,
 					      dma_data[0],
 					      dma_data,
 					      size,
@@ -501,7 +501,7 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_bpf_ops->hid_hw_output_report(hdev,
+	ret = hid_ops->hid_hw_output_report(hdev,
 						dma_data,
 						size);
 
@@ -534,7 +534,7 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 
 	hdev = (struct hid_device *)ctx->hid; /* discard const */
 
-	return hid_bpf_ops->hid_input_report(hdev, type, buf, size, 0);
+	return hid_ops->hid_input_report(hdev, type, buf, size, 0);
 }
 __bpf_kfunc_end_defs();
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b1fa0378e8f4..14bbac432de5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2971,7 +2971,7 @@ int hid_check_keys_pressed(struct hid_device *hid)
 EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 
 #ifdef CONFIG_HID_BPF
-static struct hid_bpf_ops hid_ops = {
+static struct hid_ops __hid_ops = {
 	.hid_get_report = hid_get_report,
 	.hid_hw_raw_request = hid_hw_raw_request,
 	.hid_hw_output_report = hid_hw_output_report,
@@ -2992,7 +2992,7 @@ static int __init hid_init(void)
 	}
 
 #ifdef CONFIG_HID_BPF
-	hid_bpf_ops = &hid_ops;
+	hid_ops = &__hid_ops;
 #endif
 
 	ret = hidraw_init();
@@ -3011,7 +3011,7 @@ static int __init hid_init(void)
 static void __exit hid_exit(void)
 {
 #ifdef CONFIG_HID_BPF
-	hid_bpf_ops = NULL;
+	hid_ops = NULL;
 #endif
 	hid_debug_exit();
 	hidraw_exit();
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index eec2592dec12..a66103618e6e 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -97,7 +97,7 @@ enum hid_bpf_prog_type {
 
 struct hid_report_enum;
 
-struct hid_bpf_ops {
+struct hid_ops {
 	struct hid_report *(*hid_get_report)(struct hid_report_enum *report_enum, const u8 *data);
 	int (*hid_hw_raw_request)(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
@@ -110,7 +110,7 @@ struct hid_bpf_ops {
 	const struct bus_type *bus_type;
 };
 
-extern struct hid_bpf_ops *hid_bpf_ops;
+extern struct hid_ops *hid_ops;
 
 struct hid_bpf_prog_list {
 	u16 prog_idx[HID_BPF_MAX_PROGS_PER_DEV];

-- 
2.44.0


