Return-Path: <linux-kselftest+bounces-4663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC1854FDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0D1C2936E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7F785938;
	Wed, 14 Feb 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWwirUt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEC839FD;
	Wed, 14 Feb 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931162; cv=none; b=dUrnqtDrOyzuggarR8Qp7ynL/il+H8hsWFanyvsyIfXZMtpGb2B00y110PWBwWwC4KscGrFlt9fqX31sH5seyOQo8YxrsWvBHsLGsS4J1at08v9RwvMI/bhPk34A6uhpPsHxLK50KEdEAlenpaHxIXvrBVnF21V0O6vFIhTB7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931162; c=relaxed/simple;
	bh=F43OnIh2rY49uodQcvLEcVEao1kg8gYHNVa0IY0wmEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSrL6VmE1p4jkStHEDHmzA8RG0X618rkuSjwIU8ucVZQBH+SK0YbTfihZZXtF4k1F/ReyfxnKtDZw3JXSy+GdN+KwCH58L/S9IF4hY4CrxqPWgZf9jD0jV4fGjVJVbNqWNFYn2ij6FcLnMHoSmmLDb9YAICx8gjOWXrv3kLDwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWwirUt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19019C43390;
	Wed, 14 Feb 2024 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931162;
	bh=F43OnIh2rY49uodQcvLEcVEao1kg8gYHNVa0IY0wmEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rWwirUt1cgtXJksBNvsqHTO6dZFKiuox4F+JS6fr+OTAPntJpdztWShNuDVef4D8+
	 1yFUjDGNwq35RlXuNEkV2abFuETi0oq5krfRnhYCcJX2LT0EYA662SPefgFbOL2FoM
	 oDwboprdH9wgbpgdotLjlQYTdUSRoKED9DkE1Lqi6M4x0HKo9vZ1sQbvhLr/hIE878
	 lTrlmTWPDEubq/rBaQ+VbLZyJBE/kN5l+ZNKws68Sf1DJxogTIAOI9gxV+Gi4ye2bq
	 u0uSkm7TX7VEAdGipIHhSSLgaY2x5spvNF8OA+fIKlApHFbm29OLVcbG0oettZ7y5b
	 MacsE45b1BcQQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:34 +0100
Subject: [PATCH RFC bpf-next v2 05/10] HID: bpf: export
 hid_hw_output_report as a BPF kfunc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-5-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=6507;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=F43OnIh2rY49uodQcvLEcVEao1kg8gYHNVa0IY0wmEg=;
 b=NOYZNeGqrOaGbIV6Bzq3s0T6oiR949jv9BwmZE0/hNIWzYdcaL9xWjE9oAPWANsttqQkkn/GW
 dX6WWCUj9LfAVanQCmkdoc3RKi8e3QY88gVDrAKAWlkguB1chwHqSee
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We currently only export hid_hw_raw_request() as a BPF kfunc.
However, some devices require an explicit write on the Output Report
instead of the use of the control channel.

So also export hid_hw_output_report to BPF

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
2.43.0


