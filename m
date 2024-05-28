Return-Path: <linux-kselftest+bounces-10775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3AD8D1C4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111F0286BED
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10316F273;
	Tue, 28 May 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQpQptQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657A16F26D;
	Tue, 28 May 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902118; cv=none; b=RenYQa4+hsoBP2yNSD8yF1rJbG3e1op744DuiHeezQO/IYkn0F+IH2EFaDQCFooaQdhIoy0+7jq1RBFwWfM1EiSZx50uRpJf397pSdvDM34PUbWsySaoZ0thnBgAB2AdXiLYQnhLu9ngwb6hh1aH3wFsNn8ntOwuo0D+af7qIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902118; c=relaxed/simple;
	bh=qjh548Ed99ribfGzmhee9KtCOpFpgKgwNHDsKsVMZ2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBeoZzDaA5wwdnXGAQSE475q8MGd1zwurC5ZIzurh450IP873O7tPgr0a6azVsXEOJvTu32JR3RAGXW3c2fCRt9Y2E88H+CEqTyciz7zV0gn3dLwciRHPgbjnJGOkmdsqtr2ugSfAoEB5E/7YMNehKSL5AXbNBQtI4J8xJOq6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQpQptQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE53C32782;
	Tue, 28 May 2024 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902118;
	bh=qjh548Ed99ribfGzmhee9KtCOpFpgKgwNHDsKsVMZ2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pQpQptQv9MrWTl3Z8WwqNILsEgxJXmuPYP7wvRCN0nx8QKRJ+nbkZfrkOFjM3fsuL
	 WkAlzU/pHAKBNCUNLzr7XBqVPckrpg/+gd4mEyhTfRxgrto1ArhxRCBJSMbad1wRSH
	 TaTE0fR5dI82DDvJzhBkCtWaSxLfhbmjeWucEBG0uQmNROBCbqeP29bgOI8YyjOBZn
	 hpTlZ21X91/l9N/GXHNpfxbqBqB8R69bkEVrzMQBskMB3Q0ztg84vnaol33Fl7BWnA
	 7FWTD5/XuRGX8Fln/SJoR1eA9N7sOV++yMR+QIsS7gh24y9Li6GparAGlyCJOHNtB4
	 lyispOTTlhSyg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:39 +0200
Subject: [PATCH HID 01/13] HID: rename struct hid_bpf_ops into hid_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-1-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=4905;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qjh548Ed99ribfGzmhee9KtCOpFpgKgwNHDsKsVMZ2E=;
 b=Oo/12hPcmAyPOG2YIYuV5Ne6Mk1J/N4KezsSZ9g/H1gkEepx7MOydLSfCa4Q1RWBuj7FZuluM
 VcaoejiYtzjAqiwDT1RPPYaou5X5eQP4UApnDYpnjNdP0DClXkUH5jI
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Those operations are the ones from HID, not HID-BPF, and I'd like to
reuse hid_bpf_ops as the user facing struct_ops API.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


