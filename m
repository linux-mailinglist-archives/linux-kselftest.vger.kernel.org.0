Return-Path: <linux-kselftest+bounces-13004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D071E91DF8A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6437A1F22474
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC1159571;
	Mon,  1 Jul 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+fjQr7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42050159565;
	Mon,  1 Jul 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837610; cv=none; b=VgDDqOCiUfYffDRMjcQ6aqg6B+gK/GBTpbb8eKPHPB167MzPsGlMpGSnw7WV63OOlhPGxj/Tvt7v1HR7/BBPM9z4U0rH0JeEsa8J5Xs8b+LlUtbMl7itCIWZJF/A5/n06R1hImuaLrn1df0akfJ0xffWoeMRSX//FjG+OnjHzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837610; c=relaxed/simple;
	bh=iOxhyuU9QfzIG4uPwnRgWtiT/F3Zt8W9e7IATvEoCU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrMCNy4OgXM0XXqmtwXZ+Tx603mV2PnX25MaA3N+5E+8TuhgbfJLeJT/11Q5YSdqSfkytZLk83H+bje7HjYv6iiDBJbYFDq4OCymhz4ePwvmYlYmTUCNnAo66qFc0wtujkS0Bt/272L6yvlTjppduEBRm2Cx7j9Z05wqIL73tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+fjQr7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66301C32786;
	Mon,  1 Jul 2024 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837610;
	bh=iOxhyuU9QfzIG4uPwnRgWtiT/F3Zt8W9e7IATvEoCU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+fjQr7Ii+Yt7clCrrB/+9ySa71DHLF4PrtaBEIsTL1jXczGOEPLn9C1bHeePHP8A
	 moniVQlOaZSlGOgdD9f/0OgK6GC6VXvocWLMaPMEaZWzan5r5UIIH2kPI0Bica1Qb9
	 LnQFLyrbHXtESYYEiQCRr0GX0e2ey5l/TZ2bcM9NV9mm4Iut021JpT2N8UTFdfGRsz
	 Px9SRJkjpIs94IQleo6ZrTAC/ml5F8t1DG94fGpqwTbPoOv5ZHUqHew0PM4lZlB9z4
	 CkGpQKDsuhKaIA21pulq6FX0szr14Vhsv5o4f8kWPr8ifWT5clZroWPuuHn7FJIa4L
	 RKXMoq6rOC6hw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 01 Jul 2024 14:39:50 +0200
Subject: [PATCH v2 2/4] HID: bpf: fix gcc warning and unify __u64 into u64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-fix-cki-v2-2-20564e2e1393@kernel.org>
References: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
In-Reply-To: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>, 
 Mirsad Todorovac <mtodorovac69@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719837604; l=6307;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=iOxhyuU9QfzIG4uPwnRgWtiT/F3Zt8W9e7IATvEoCU4=;
 b=7ro7EdXJyjokBu4HziFpwoHVqZNkoTI43I9nfeVLyNTbbyuDvypzw1CcQmu3/UidI4nZ4hUOv
 ekqdrpDiSccDBnxhJAYMNid2UOORbKMy64jnvGymE8rjO9p46TT5aw/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I've got multiple reports of:
error: cast from pointer to integer of different size
[-Werror=pointer-to-int-cast].

Let's use the same trick than kernel/bpf/helpers.c to shut up that warning.

Even if we were on an architecture with addresses on more than 64 bits,
this isn't much of an issue as the address is not used as a pointer,
but as an hash and the caller is not supposed to go back to the kernel
address ever.

And while we change those, make sure we use u64 instead of __u64 for
consistency

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406280633.OPB5uIFj-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202406282304.UydSVncq-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202406282242.Fk738zzy-lkp@intel.com/
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Fixes: 67eccf151d76 ("HID: add source argument to HID low level functions")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 6 +++---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 +-
 drivers/hid/hid-core.c               | 4 ++--
 drivers/hid/hidraw.c                 | 6 +++---
 include/linux/hid_bpf.h              | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 23daf94510bb..a36e680399fe 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -440,7 +440,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      size,
 					      rtype,
 					      reqtype,
-					      (__u64)ctx,
+					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
 	if (ret > 0)
@@ -483,7 +483,7 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_ops->hid_hw_output_report(hdev, dma_data, size, (__u64)ctx, true);
+	ret = hid_ops->hid_hw_output_report(hdev, dma_data, size, (u64)(long)ctx, true);
 
 	kfree(dma_data);
 	return ret;
@@ -505,7 +505,7 @@ __hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *b
 	if (ret)
 		return ret;
 
-	return hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (__u64)ctx, true,
+	return hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (u64)(long)ctx, true,
 					 lock_already_taken);
 }
 
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 37d2f8e2413a..b03b44ad3458 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -261,7 +261,7 @@ static void hid_bpf_unreg(void *kdata)
 	hid_put_device(hdev);
 }
 
-static int __hid_bpf_device_event(struct hid_bpf_ctx *ctx, enum hid_report_type type, __u64 source)
+static int __hid_bpf_device_event(struct hid_bpf_ctx *ctx, enum hid_report_type type, u64 source)
 {
 	return 0;
 }
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 52a75afe3e7d..0f797dab975b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2412,7 +2412,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 unsigned char reportnum, __u8 *buf,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
-			 __u64 source, bool from_bpf)
+			 u64 source, bool from_bpf)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	int ret;
@@ -2454,7 +2454,7 @@ int hid_hw_raw_request(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_hw_raw_request);
 
-int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source,
+int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, u64 source,
 			   bool from_bpf)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index c2396916cdaa..716294e40e8a 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -140,7 +140,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 	if ((report_type == HID_OUTPUT_REPORT) &&
 	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
-		ret = __hid_hw_output_report(dev, buf, count, (__u64)file, false);
+		ret = __hid_hw_output_report(dev, buf, count, (u64)(long)file, false);
 		/*
 		 * compatibility with old implementation of USB-HID and I2C-HID:
 		 * if the device does not support receiving output reports,
@@ -151,7 +151,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	}
 
 	ret = __hid_hw_raw_request(dev, buf[0], buf, count, report_type,
-				   HID_REQ_SET_REPORT, (__u64)file, false);
+				   HID_REQ_SET_REPORT, (u64)(long)file, false);
 
 out_free:
 	kfree(buf);
@@ -228,7 +228,7 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	ret = __hid_hw_raw_request(dev, report_number, buf, count, report_type,
-				   HID_REQ_GET_REPORT, (__u64)file, false);
+				   HID_REQ_GET_REPORT, (u64)(long)file, false);
 
 	if (ret < 0)
 		goto out_free;
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 93546ee7677a..3f6584014311 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -68,9 +68,9 @@ struct hid_ops {
 				  unsigned char reportnum, __u8 *buf,
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source, bool from_bpf);
+				  u64 source, bool from_bpf);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
-				    __u64 source, bool from_bpf);
+				    u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
 				u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
 				bool lock_already_taken);
@@ -115,7 +115,7 @@ struct hid_bpf_ops {
 	 * Context: Interrupt context.
 	 */
 	int (*hid_device_event)(struct hid_bpf_ctx *ctx, enum hid_report_type report_type,
-				__u64 source);
+				u64 source);
 
 	/**
 	 * @hid_rdesc_fixup: called when the probe function parses the report descriptor

-- 
2.44.0


