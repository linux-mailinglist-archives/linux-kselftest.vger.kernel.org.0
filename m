Return-Path: <linux-kselftest+bounces-12805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFB918325
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296BC1F21ABF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A3188CDF;
	Wed, 26 Jun 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1iIM+PM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B3188CD4;
	Wed, 26 Jun 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409626; cv=none; b=lTPb9zC2gXM7wXfidHsNyOd9MGB8v7oU4xZDWoZkznB4VmgpTqXFod2IAA3/bhPfsl53guAWP4AQN3sQ4ErAtzDR2KyicTsATlLJHK8UCCjaMJDzoWfyHKc0U+zVr0agVXWmnu+bYdFpMzykDVk998k6RUM9tg9YWuqZK8R0bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409626; c=relaxed/simple;
	bh=A2KCTEHkQRa2jGrLaI9zdebQtOmt6mnuu33Vw1F99vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E52kK8+7ZutQaejVAcskPSyzOhEBqMi3u9rvFJ40OPUBqul3izg/MABhHRLFmH1KplFtISrzN3y19VtDSxQ0AiJQc6oLi0SP2pAkcq1yGvYmTEugomfbritRfI8NxJYlyPiumdhxR/MkLAZnfPyznMVh6hEvjBbHVZF9v4j8TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1iIM+PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0FC116B1;
	Wed, 26 Jun 2024 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409625;
	bh=A2KCTEHkQRa2jGrLaI9zdebQtOmt6mnuu33Vw1F99vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G1iIM+PMTzQtipisU3iHDAUZqLafiSBY7fJdNvknSLvl940g0fA1aBrgn4+71Q5AG
	 FV2u7Zn6Xr7pKwQU485OPbRZ4Nun25dRg7oRIZhY6rL2m+lewgmcq8JRhRHNFu8Ylo
	 TFIzAOt6mTaUV11hwyPvVQVAuIk6NcI683REexQXIf+KC1HmtqtVVcByWmTxDkly1b
	 6vOg6BlMpG4N4glNTp4j3QBd9CEL51wjWJAe1sQ/gDg+WuEpxHwo7iZ7eogyQ3p9iB
	 qVg50dcbHLWsdPkKWjJGH8Ef53jaOTKgUrLR6KpL5uCRSl0dnN2atmOphZXfJ8Xd8m
	 vkyQnpHBKPo/A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:30 +0200
Subject: [PATCH HID v2 09/13] HID: bpf: make hid_bpf_input_report() sleep
 until the device is ready
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-9-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=4622;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=A2KCTEHkQRa2jGrLaI9zdebQtOmt6mnuu33Vw1F99vc=;
 b=Kj5Z+7cYlb/8qx5JsqopPbaBVUwokNlne88tubvAAQGc2cu0AUIi2HkdsWFQjH0/iJEDx3klz
 0W5pK+5LFBABwwQeKOraN0PDxae7JFn2kMP9fLY1yUNOPM18P5CaFVa
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid_bpf_input_report() is already marked to be used in sleepable context
only. So instead of hammering with timers the device to hopefully get
an available slot where the device is not sending events, we can make
that kfunc wait for the current event to be terminated before it goes in.

This allows to work with the following pseudo code:

in struct_ops/hid_device_event:
  - schedule a bpf_wq, which calls hid_bpf_input_report()
  - once this struct_ops function terminates, hid_bpf_input_report()
    immediately starts before the next event

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 16 ++++++++++++----
 drivers/hid/hid-core.c             | 16 ++++++++++++----
 include/linux/hid_bpf.h            |  3 ++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 0aab49a2b869..1fb321545db0 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -494,24 +494,32 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
  * @buf: a %PTR_TO_MEM buffer
  * @buf__sz: the size of the data to transfer
  *
- * Returns %0 on success, a negative error code otherwise.
+ * Returns %0 on success, a negative error code otherwise. This function will wait for the
+ * device to be available before injecting the event, thus needs to be called in sleepable
+ * context.
  */
 __bpf_kfunc int
 hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
 		     const size_t buf__sz)
 {
-	struct hid_device *hdev;
 	size_t size = buf__sz;
 	int ret;
 
+	ret = down_interruptible(&ctx->hid->driver_input_lock);
+	if (ret)
+		return ret;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
 	if (ret)
 		return ret;
 
-	hdev = (struct hid_device *)ctx->hid; /* discard const */
+	ret = hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (__u64)ctx,
+					true /* lock_already_taken */);
+
+	up(&ctx->hid->driver_input_lock);
 
-	return hid_ops->hid_input_report(hdev, type, buf, size, 0, (__u64)ctx);
+	return ret;
 }
 __bpf_kfunc_end_defs();
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bb6f334f05bd..e9b5f44683fd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2027,7 +2027,8 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
 
 static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
-			      u8 *data, u32 size, int interrupt, u64 source)
+			      u8 *data, u32 size, int interrupt, u64 source,
+			      bool lock_already_taken)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
@@ -2037,8 +2038,13 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	if (!hid)
 		return -ENODEV;
 
-	if (down_trylock(&hid->driver_input_lock))
+	ret = down_trylock(&hid->driver_input_lock);
+	if (lock_already_taken && !ret) {
+		up(&hid->driver_input_lock);
+		return -EINVAL;
+	} else if (!lock_already_taken && ret) {
 		return -EBUSY;
+	}
 
 	if (!hid->driver) {
 		ret = -ENODEV;
@@ -2079,7 +2085,8 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	ret = hid_report_raw_event(hid, type, data, size, interrupt);
 
 unlock:
-	up(&hid->driver_input_lock);
+	if (!lock_already_taken)
+		up(&hid->driver_input_lock);
 	return ret;
 }
 
@@ -2097,7 +2104,8 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt)
 {
-	return __hid_input_report(hid, type, data, size, interrupt, 0);
+	return __hid_input_report(hid, type, data, size, interrupt, 0,
+				  false /* lock_already_taken */);
 }
 EXPORT_SYMBOL_GPL(hid_input_report);
 
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index f35508a73067..7f04353d09e9 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -72,7 +72,8 @@ struct hid_ops {
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt, u64 source);
+				u8 *data, u32 size, int interrupt, u64 source,
+				bool lock_already_taken);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };

-- 
2.44.0


