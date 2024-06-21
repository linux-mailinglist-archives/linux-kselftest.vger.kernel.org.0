Return-Path: <linux-kselftest+bounces-12424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC7A911FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E530D28B01D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29D170837;
	Fri, 21 Jun 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3FqJuTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9D170834;
	Fri, 21 Jun 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960204; cv=none; b=m/Fy/MTnFzAWMq7aHn0ejZKcNHt1bf9+7Kg8RNtvXSi9nvlE1OEhnvWiJkrex8mHG59AUNUysXPIMmlhF3a9mO3KfX9Id8HfgR9wjCYWcrIr9w1w7kMZizemmErstZhGIZGqptxHuoSWyslh/IgXlmlJjzWLllWu/CSaVe+n8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960204; c=relaxed/simple;
	bh=+E/6I7TfEYMymkU7gA6I7CtViS0Id/G2eA0GOROrr0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EfnmWB4jCWCyRyQzOiH0Yi92njhP9qIBWgPafKhgxq+CUapgVJJvJWH6fYRAVc50foCoDTIDT+qKwYDMF+L6+5EhvoH/5HCC4n6czzWLM4iiXsR6B3FWvvgAHlACMzb/xCnPYGsnthNr/E7FOdBEyJoBtsDNvC+wu/RhsBAagbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3FqJuTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B113C4AF08;
	Fri, 21 Jun 2024 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960204;
	bh=+E/6I7TfEYMymkU7gA6I7CtViS0Id/G2eA0GOROrr0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O3FqJuThGOWhxX0MJRIK/bvJ8PvJ8p+jgg3Eh9UdjMAkyEDgb+JKvOlN44DMEYzXA
	 p9Vt6kQGPBonrJT9hDReQ91PDhf7xopuZmMeQxysDgx6SoZ1R0a5fRF/TxPFyQNMo6
	 KUMgnI+eA+lWOxUAhLf7Nx+jyLegwLjAC/Oa7Qsqe45lvkusPU6XLc5FKmOj9sqgPC
	 2aEZCcCKf9NVV3lglhgkvLh7PSNLj25nbwCZffZdyYTiuwD02TkW5US1jEoqTcEZ8W
	 jI39dU/3RhqRfcgXC+h4uEU9x91e2djYhAMkeHn9PenlY4nbWnMimggcVLjrpTaqrq
	 0GphixUR9sUgA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:55 +0200
Subject: [PATCH HID 10/12] HID: bpf: allow hid_device_event hooks to inject
 input reports on self
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-10-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=8337;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=+E/6I7TfEYMymkU7gA6I7CtViS0Id/G2eA0GOROrr0U=;
 b=7YtJOvyCn88KzyJ9hqVzWcErnKUq7JU7guPvjcr8BOsvVSYU4GTOdp6ZaccKovh5dhweR3KJX
 gU8I9/Dn6ryDPSEFGxT02H4TLM98uBVjpZYWIOLePgUKEOLAZzkEfBe
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
index 3ab513fba3d2..3ef75be2bd40 100644
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
@@ -484,6 +485,50 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
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
@@ -500,7 +545,6 @@ __bpf_kfunc int
 hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
 		     const size_t buf__sz)
 {
-	size_t size = buf__sz;
 	int ret;
 
 	ret = down_interruptible(&ctx->hid->driver_input_lock);
@@ -508,12 +552,7 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
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
 
@@ -532,6 +571,7 @@ BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_try_input_report)
 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b45d060f68c2..2112ccfb8f24 100644
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
index 1e450d38e239..ad3c564af1ab 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -71,7 +71,7 @@ struct hid_ops {
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt, u64 source,
+				u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
 				bool lock_already_taken);
 	struct module *owner;
 	const struct bus_type *bus_type;
@@ -192,7 +192,7 @@ struct hid_bpf {
 
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
-				  u32 *size, int interrupt, u64 source);
+				  u32 *size, int interrupt, u64 source, bool from_bpf);
 int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 size, enum hid_report_type rtype,
@@ -208,7 +208,7 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
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


