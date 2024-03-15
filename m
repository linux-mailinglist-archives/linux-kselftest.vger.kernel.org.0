Return-Path: <linux-kselftest+bounces-6356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3C187CF38
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC161F233E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11A3D3A1;
	Fri, 15 Mar 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J34MSr1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150243D0CA;
	Fri, 15 Mar 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513893; cv=none; b=bNC9HHatI7sGuFvDsTbYpCS1sNdNr+xtGRgu3KpDuWuzerl6lW6yNdxZX/QnUjeARZERQJE/kDhktz+2pNECyoZ2+S885X8PgRg1Inwj0EWoCGpyhOXNgALDy3EL6+C2v2yyf3sDSr2l7+C5fFlK45dIfA0mkjmJA/xEatkC1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513893; c=relaxed/simple;
	bh=zq66QKtjnXJ4Qer6GMlak1OP/mCYAo+o7m/hoYuei0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ss2HjfHokVXmNTpKklr1AxZcUPVWAD2X/6LIYxwneiUI4NSpf8g4kEQAkgcLn3jBhpEv9AQCcP2YblLJ3w5vQIynr7/EUqdeDB4YR93t6oT44f0NpeMH1TnR6mS26JWMYzbMwCyEgiyohPlqOWR4gMfL8aZbIPPGIk3NazhMrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J34MSr1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD460C32784;
	Fri, 15 Mar 2024 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513892;
	bh=zq66QKtjnXJ4Qer6GMlak1OP/mCYAo+o7m/hoYuei0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J34MSr1pP1mHZVnp9Lcni2ceQKxT/azQc7edzymyCKZWwb+iyL9g/IbNuRZ9cRSTr
	 4uvW1zWQjyTYBZ45BGwAKxjrfI10xQ3DAxmWzqKMUR62TvZnaKstIBYShyWqfLsQKL
	 sAVdgf5FIhvy9rD/P+4aNl/ch97Qx6uSYJ5YDYUcvmw4d0D0Xwir6i8yXscoo5g+8c
	 83a54CSetuS7vQEzkGtyDT2/SjdoROVowWQEPFdfV4s2q5CXfjcDtPBnrMfu98p+NK
	 RZDL7gjEtHj0X/napdKvs3rdz2jRuhOUNqQDeOICcPFi96Vk/tplNnchsFPvYYSoCx
	 ZC4mAAUJF8CAQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:44:39 +0100
Subject: [PATCH v4 2/7] HID: bpf: export hid_hw_output_report as a BPF
 kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=6547;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=zq66QKtjnXJ4Qer6GMlak1OP/mCYAo+o7m/hoYuei0o=;
 b=cnsXrVOWz3Ti0W+sZSx3G5daPohvB0026JiATxm4hhzvVmUdHLCYCkiOQsBV1hXVie570p1Qs
 uapkg6Jf4TjCyslK3XpaTmDXttpMnNK9/FnCL6tPmTAiM1Mo7wTjy6p
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We currently only export hid_hw_raw_request() as a BPF kfunc.
However, some devices require an explicit write on the Output Report
instead of the use of the control channel.

So also export hid_hw_output_report to BPF

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v4

no changes in v3

no changes in v2
---
 Documentation/hid/hid-bpf.rst      |   2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c | 112 +++++++++++++++++++++++++++----------
 drivers/hid/hid-core.c             |   1 +
 include/linux/hid_bpf.h            |   1 +
 4 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 4fad83a6ebc3..a575004d9025 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -179,7 +179,7 @@ Available API that can be used in syscall HID-BPF programs:
 -----------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_allocate_context hid_bpf_release_context
+   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_allocate_context hid_bpf_release_context
 
 General overview of a HID-BPF program
 =====================================
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 52abb27426f4..a5b88b491b80 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -376,6 +376,46 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 	put_device(&hid->dev);
 }
 
+static int
+__hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
+			  enum hid_report_type rtype)
+{
+	struct hid_report_enum *report_enum;
+	struct hid_report *report;
+	struct hid_device *hdev;
+	u32 report_len;
+
+	/* check arguments */
+	if (!ctx || !hid_bpf_ops || !buf)
+		return -EINVAL;
+
+	switch (rtype) {
+	case HID_INPUT_REPORT:
+	case HID_OUTPUT_REPORT:
+	case HID_FEATURE_REPORT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (*buf__sz < 1)
+		return -EINVAL;
+
+	hdev = (struct hid_device *)ctx->hid; /* discard const */
+
+	report_enum = hdev->report_enum + rtype;
+	report = hid_bpf_ops->hid_get_report(report_enum, buf);
+	if (!report)
+		return -EINVAL;
+
+	report_len = hid_report_len(report);
+
+	if (*buf__sz > report_len)
+		*buf__sz = report_len;
+
+	return 0;
+}
+
 /**
  * hid_bpf_hw_request - Communicate with a HID device
  *
@@ -392,24 +432,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		   enum hid_report_type rtype, enum hid_class_request reqtype)
 {
 	struct hid_device *hdev;
-	struct hid_report *report;
-	struct hid_report_enum *report_enum;
+	size_t size = buf__sz;
 	u8 *dma_data;
-	u32 report_len;
 	int ret;
 
 	/* check arguments */
-	if (!ctx || !hid_bpf_ops || !buf)
-		return -EINVAL;
-
-	switch (rtype) {
-	case HID_INPUT_REPORT:
-	case HID_OUTPUT_REPORT:
-	case HID_FEATURE_REPORT:
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype);
+	if (ret)
+		return ret;
 
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
@@ -423,29 +453,16 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		return -EINVAL;
 	}
 
-	if (buf__sz < 1)
-		return -EINVAL;
-
 	hdev = (struct hid_device *)ctx->hid; /* discard const */
 
-	report_enum = hdev->report_enum + rtype;
-	report = hid_bpf_ops->hid_get_report(report_enum, buf);
-	if (!report)
-		return -EINVAL;
-
-	report_len = hid_report_len(report);
-
-	if (buf__sz > report_len)
-		buf__sz = report_len;
-
-	dma_data = kmemdup(buf, buf__sz, GFP_KERNEL);
+	dma_data = kmemdup(buf, size, GFP_KERNEL);
 	if (!dma_data)
 		return -ENOMEM;
 
 	ret = hid_bpf_ops->hid_hw_raw_request(hdev,
 					      dma_data[0],
 					      dma_data,
-					      buf__sz,
+					      size,
 					      rtype,
 					      reqtype);
 
@@ -455,6 +472,42 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	kfree(dma_data);
 	return ret;
 }
+
+/**
+ * hid_bpf_hw_output_report - Send an output report to a HID device
+ *
+ * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_context()
+ * @buf: a %PTR_TO_MEM buffer
+ * @buf__sz: the size of the data to transfer
+ *
+ * @returns the number of bytes transferred on success, a negative error code otherwise.
+ */
+__bpf_kfunc int
+hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
+{
+	struct hid_device *hdev;
+	size_t size = buf__sz;
+	u8 *dma_data;
+	int ret;
+
+	/* check arguments */
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT);
+	if (ret)
+		return ret;
+
+	hdev = (struct hid_device *)ctx->hid; /* discard const */
+
+	dma_data = kmemdup(buf, size, GFP_KERNEL);
+	if (!dma_data)
+		return -ENOMEM;
+
+	ret = hid_bpf_ops->hid_hw_output_report(hdev,
+						dma_data,
+						size);
+
+	kfree(dma_data);
+	return ret;
+}
 __bpf_kfunc_end_defs();
 
 /*
@@ -488,6 +541,7 @@ BTF_ID_FLAGS(func, hid_bpf_attach_prog)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index de7a477d6665..1243595890ba 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2974,6 +2974,7 @@ EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 static struct hid_bpf_ops hid_ops = {
 	.hid_get_report = hid_get_report,
 	.hid_hw_raw_request = hid_hw_raw_request,
+	.hid_hw_output_report = hid_hw_output_report,
 	.owner = THIS_MODULE,
 	.bus_type = &hid_bus_type,
 };
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 7118ac28d468..5c7ff93dc73e 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -103,6 +103,7 @@ struct hid_bpf_ops {
 				  unsigned char reportnum, __u8 *buf,
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype);
+	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };

-- 
2.44.0


