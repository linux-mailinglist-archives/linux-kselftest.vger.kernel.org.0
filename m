Return-Path: <linux-kselftest+bounces-12807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327691832D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6801F214AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9EC18A943;
	Wed, 26 Jun 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFY3prtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6618A935;
	Wed, 26 Jun 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409631; cv=none; b=F7y19zPwQd+4kt9Q3kRBYiiMj0reaOmyESzp9i6VSAP3GcguHBfb1MfwlqgsTuOPlL9lVbAcejzDij/BBvR6pSrBVDl/nN75OzDG7YJx4bG40fj/etmsX6+Al89W9mtHUZ4Up9t/MomqWgxIVrCKvYzH6ceovTeQ+0ed2u5b4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409631; c=relaxed/simple;
	bh=hyfLdKibLMSyU1dBbJDQVjZCoODwC6YGKovbqR6PglA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMs0Fb97/Nf6yDLX7m3DV4ilu5OK/nSechOFS0o7ZoukJR90qmCnhyKjotoNn4EC/wN1pTUyS8MtsyCxShTn4sCarbzXUnzOzN7qyKg8rlgN2R9xCZpbTTfBXOdSJrroorTRL+vehR3EmQAaWIih8z9o+fkeknGs1wF5VSyYlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFY3prtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843D4C32789;
	Wed, 26 Jun 2024 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409630;
	bh=hyfLdKibLMSyU1dBbJDQVjZCoODwC6YGKovbqR6PglA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CFY3prtF1kVwvW5ygB4BQ9HytpUPjuxL/LiM8IB8TgfO304gbZ7TUEmV5ZO6xr1CE
	 T/hY98O6Shqs0U5vMc81mb/hiK9ELoimFj6lOkgemudbc3geWBa3Q9179htJBFncdy
	 mLP7hZx6ESALLadgm0tngm12LFRdkX3EWlt61ayBbXs1goNnirizia7/NAewjy+tQ6
	 a38vlI218Sc8+UVBBL1v5NCB7+YXojCS4rTaoj40E7Me9UQJDndGXcEjTfl8uPKMWi
	 z5bHhXzmk3IgukM+YRuADAod2/g70OAFGRsbf+8uap6wSQhCc8HUrdvCmVzVD+R3nE
	 13Vu+wtOzcEFw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:32 +0200
Subject: [PATCH HID v2 11/13] HID: bpf: allow hid_device_event hooks to
 inject input reports on self
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-11-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=8364;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=hyfLdKibLMSyU1dBbJDQVjZCoODwC6YGKovbqR6PglA=;
 b=4nq40RQYWfU9QD8TJ/y5+gtnU30IuWvlup3ZU+fqs3pHkQD0yjaQBe6mHc1TQweBUZPfwOjjU
 6RJVgfE4QU9DCvA+d6TBzA3wMKo85x9h6KoqUyDrktfDDNW58Ck/rat
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is the same logic than hid_hw_raw_request or hid_hw_output_report:
we can allow hid_bpf_try_input_report to be called from a hook on
hid_input_report if we ensure that the call can not be made twice in a
row.

There is one extra subtlety in which there is a lock in hid_input_report.
But given that we can detect if we are already in the hook, we can notify
hid_input_report to not take the lock. This is done by checking if
ctx_kern data is valid or null, and if it is equal to the dedicated
incoming data buffer.

In order to have more control on whether the lock needs to be taken or not
we introduce a new kfunc for it: hid_bpf_try_input_report()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 Documentation/hid/hid-bpf.rst      |  2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c | 56 ++++++++++++++++++++++++++++++++------
 drivers/hid/hid-core.c             |  5 ++--
 include/linux/hid_bpf.h            |  6 ++--
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 8ae8f49801cb..5939eeafb361 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -202,7 +202,7 @@ Available API that can be used in syscall HID-BPF programs or in sleepable HID-B
 -------------------------------------------------------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :identifiers: hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
+   :identifiers: hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_try_input_report hid_bpf_allocate_context hid_bpf_release_context
 
 General overview of a HID-BPF program
 =====================================
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 1fb321545db0..60d12fcd28bd 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -24,7 +24,7 @@ EXPORT_SYMBOL(hid_ops);
 
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
-			      u32 *size, int interrupt, u64 source)
+			      u32 *size, int interrupt, u64 source, bool from_bpf)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
@@ -33,6 +33,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 			.size = *size,
 		},
 		.data = hdev->bpf.device_data,
+		.from_bpf = from_bpf,
 	};
 	struct hid_bpf_ops *e;
 	int ret;
@@ -486,6 +487,50 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	return ret;
 }
 
+static int
+__hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
+		       size_t size, bool lock_already_taken)
+{
+	struct hid_bpf_ctx_kern *ctx_kern;
+	int ret;
+
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+	if (ctx_kern->from_bpf)
+		return -EDEADLOCK;
+
+	/* check arguments */
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
+	if (ret)
+		return ret;
+
+	return hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (__u64)ctx, true,
+					 lock_already_taken);
+}
+
+/**
+ * hid_bpf_try_input_report - Inject a HID report in the kernel from a HID device
+ *
+ * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_context()
+ * @type: the type of the report (%HID_INPUT_REPORT, %HID_FEATURE_REPORT, %HID_OUTPUT_REPORT)
+ * @buf: a %PTR_TO_MEM buffer
+ * @buf__sz: the size of the data to transfer
+ *
+ * Returns %0 on success, a negative error code otherwise. This function will immediately
+ * fail if the device is not available, thus can be safely used in IRQ context.
+ */
+__bpf_kfunc int
+hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
+			 const size_t buf__sz)
+{
+	struct hid_bpf_ctx_kern *ctx_kern;
+	bool from_hid_event_hook;
+
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+	from_hid_event_hook = ctx_kern->data && ctx_kern->data == ctx->hid->bpf.device_data;
+
+	return __hid_bpf_input_report(ctx, type, buf, buf__sz, from_hid_event_hook);
+}
+
 /**
  * hid_bpf_input_report - Inject a HID report in the kernel from a HID device
  *
@@ -502,7 +547,6 @@ __bpf_kfunc int
 hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
 		     const size_t buf__sz)
 {
-	size_t size = buf__sz;
 	int ret;
 
 	ret = down_interruptible(&ctx->hid->driver_input_lock);
@@ -510,12 +554,7 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 		return ret;
 
 	/* check arguments */
-	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
-	if (ret)
-		return ret;
-
-	ret = hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (__u64)ctx,
-					true /* lock_already_taken */);
+	ret = __hid_bpf_input_report(ctx, type, buf, buf__sz, true /* lock_already_taken */);
 
 	up(&ctx->hid->driver_input_lock);
 
@@ -534,6 +573,7 @@ BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_try_input_report)
 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e9b5f44683fd..52a75afe3e7d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2027,7 +2027,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
 
 static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
-			      u8 *data, u32 size, int interrupt, u64 source,
+			      u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
 			      bool lock_already_taken)
 {
 	struct hid_report_enum *report_enum;
@@ -2053,7 +2053,7 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
-	data = dispatch_hid_bpf_device_event(hid, type, data, &size, interrupt, source);
+	data = dispatch_hid_bpf_device_event(hid, type, data, &size, interrupt, source, from_bpf);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto unlock;
@@ -2105,6 +2105,7 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 		     int interrupt)
 {
 	return __hid_input_report(hid, type, data, size, interrupt, 0,
+				  false, /* from_bpf */
 				  false /* lock_already_taken */);
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 7f04353d09e9..93546ee7677a 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -72,7 +72,7 @@ struct hid_ops {
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt, u64 source,
+				u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
 				bool lock_already_taken);
 	struct module *owner;
 	const struct bus_type *bus_type;
@@ -195,7 +195,7 @@ struct hid_bpf {
 
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
-				  u32 *size, int interrupt, u64 source);
+				  u32 *size, int interrupt, u64 source, bool from_bpf);
 int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 size, enum hid_report_type rtype,
@@ -211,7 +211,7 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
 						u8 *data, u32 *size, int interrupt,
-						u64 source) { return data; }
+						u64 source, bool from_bpf) { return data; }
 static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						unsigned char reportnum, u8 *buf,
 						u32 size, enum hid_report_type rtype,

-- 
2.44.0


