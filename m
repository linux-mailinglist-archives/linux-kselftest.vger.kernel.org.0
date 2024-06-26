Return-Path: <linux-kselftest+bounces-12803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B691831B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D455A1F2138F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79454187563;
	Wed, 26 Jun 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN7FQoUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBE18413A;
	Wed, 26 Jun 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409621; cv=none; b=RF4C4Z1zk6g6MW96lguGWuGj19fQIPx5r0Ox5bSDvhvuE/sEIL275LRS5J7EEvTaTEkWpTo+5HWUg/tyxwi4CleSUouzQGsrh1eKq3Td594IHud8dePvV4Jg066gzQ/jy1E+znIthhWhhzQ5SG7O4eC89hOOF36T8t9A0AoTuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409621; c=relaxed/simple;
	bh=/dnMGIJskf4JLzZSF124XaWtykOIOK/lC5HMHqdtbmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o79D5e1tj6ZjfbBlIWbcCC1kYF8KsZz/3yHKPmiHKQh0WCabXPPhrY9eG8HZz0h8+4tq85eCS9HfklQJesWB91rHNrCMlhxDsVX6X2pmOmT8tgOiY86zQwWYE8wOjSer78vMa97urO4nNbGSiQhB0F7ukvzm0tlSswfxZj4edMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN7FQoUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399CBC32782;
	Wed, 26 Jun 2024 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409621;
	bh=/dnMGIJskf4JLzZSF124XaWtykOIOK/lC5HMHqdtbmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FN7FQoUCKH9Q5AlWlKUsbAXMQdfUm6nrsQ6dXpsG9dB4YlvmPj3IznFHlc4XcItd5
	 KmbjSlfef7jZt9NnoMeLaFgyy4KxHHY+7Kyv1mf1N+bRHnVz7mAUG143CKmlDvb9nk
	 nyRC1eExdPZrqVEAYLTNZqDHUPrgOZbtGbWcmBjfUkJHDirDe4Y5/KEmJjHQ8aL5Fj
	 HnT/TKol1q61OBj9kzgT9EyGQqI2m4bKreJtmrZrxuie5x3mQ7rqYYphbJ+1vIylcA
	 I3X1qht0KJtBeR1AmiFD0Pf0p+fM3mpiCQvmIO2ic4YOfKn7idDfpe0E2MBq4zObh5
	 bfEKIhR01e2Qg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:28 +0200
Subject: [PATCH HID v2 07/13] HID: bpf: add HID-BPF hooks for
 hid_hw_output_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-7-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=8779;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/dnMGIJskf4JLzZSF124XaWtykOIOK/lC5HMHqdtbmw=;
 b=kXsZuXqLU2YmSFoWMhhe3049AwraRfQIA2qqlSeQPQL397Jx2GB8g/Aajklpfp9udfXuyUBWO
 PrIc5bXf2XtBpKrE/VjrF53zoVn7HDLmcYZUBKOlyni6EVPCgC6w57h
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Same story than hid_hw_raw_requests:

This allows to intercept and prevent or change the behavior of
hid_hw_output_report() from a bpf program.

The intent is to solve a couple of use case:
  - firewalling a HID device: a firewall can monitor who opens the hidraw
    nodes and then prevent or allow access to write operations on that
    hidraw node.
  - change the behavior of a device and emulate a new HID feature request

The hook is allowed to be run as sleepable so it can itself call
hid_hw_output_report(), which allows to "convert" one feature request into
another or even call the feature request on a different HID device on the
same physical device.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- make use of SRCU
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 38 ++++++++++++++++++++++++++++++++----
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               | 10 ++++++++--
 drivers/hid/hidraw.c                 |  2 +-
 include/linux/hid.h                  |  3 ++-
 include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
 6 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 80c6787195f7..49f261054418 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -112,6 +112,39 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
 
+int dispatch_hid_bpf_output_report(struct hid_device *hdev,
+				   __u8 *buf, u32 size, __u64 source,
+				   bool from_bpf)
+{
+	struct hid_bpf_ctx_kern ctx_kern = {
+		.ctx = {
+			.hid = hdev,
+			.allocated_size = size,
+			.size = size,
+		},
+		.data = buf,
+		.from_bpf = from_bpf,
+	};
+	struct hid_bpf_ops *e;
+	int ret, idx;
+
+	idx = srcu_read_lock(&hdev->bpf.srcu);
+	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
+				 srcu_read_lock_held(&hdev->bpf.srcu)) {
+		if (e->hid_hw_output_report) {
+			ret = e->hid_hw_output_report(&ctx_kern.ctx, source);
+			if (ret)
+				goto out;
+		}
+	}
+	ret = 0;
+
+out:
+	srcu_read_unlock(&hdev->bpf.srcu, idx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dispatch_hid_bpf_output_report);
+
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
@@ -442,10 +475,7 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	if (!dma_data)
 		return -ENOMEM;
 
-	ret = hid_ops->hid_hw_output_report(hdev,
-						dma_data,
-						size,
-						(__u64)ctx);
+	ret = hid_ops->hid_hw_output_report(hdev, dma_data, size, (__u64)ctx, true);
 
 	kfree(dma_data);
 	return ret;
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index a540a4417174..37d2f8e2413a 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -45,6 +45,7 @@ static int hid_bpf_ops_check_member(const struct btf_type *t,
 	switch (moff) {
 	case offsetof(struct hid_bpf_ops, hid_rdesc_fixup):
 	case offsetof(struct hid_bpf_ops, hid_hw_request):
+	case offsetof(struct hid_bpf_ops, hid_hw_output_report):
 		break;
 	default:
 		if (prog->sleepable)
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2038ba08eaa1..bb6f334f05bd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2445,9 +2445,11 @@ int hid_hw_raw_request(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(hid_hw_raw_request);
 
-int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source)
+int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source,
+			   bool from_bpf)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+	int ret;
 
 	if (hdev->ll_driver->max_buffer_size)
 		max_buffer_size = hdev->ll_driver->max_buffer_size;
@@ -2455,6 +2457,10 @@ int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64
 	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
+	ret = dispatch_hid_bpf_output_report(hdev, buf, len, source, from_bpf);
+	if (ret)
+		return ret;
+
 	if (hdev->ll_driver->output_report)
 		return hdev->ll_driver->output_report(hdev, buf, len);
 
@@ -2472,7 +2478,7 @@ int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64
  */
 int hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len)
 {
-	return __hid_hw_output_report(hdev, buf, len, 0);
+	return __hid_hw_output_report(hdev, buf, len, 0, false);
 }
 EXPORT_SYMBOL_GPL(hid_hw_output_report);
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 4ba3131de614..c2396916cdaa 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -140,7 +140,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 	if ((report_type == HID_OUTPUT_REPORT) &&
 	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
-		ret = __hid_hw_output_report(dev, buf, count, (__u64)file);
+		ret = __hid_hw_output_report(dev, buf, count, (__u64)file, false);
 		/*
 		 * compatibility with old implementation of USB-HID and I2C-HID:
 		 * if the device does not support receiving output reports,
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 24d0d7c0bd33..1533c9dcd3a6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1130,7 +1130,8 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
 			 __u64 source, bool from_bpf);
-int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source);
+int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source,
+			   bool from_bpf);
 int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype,
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 088c94b6d8ec..f35508a73067 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -70,7 +70,7 @@ struct hid_ops {
 				  enum hid_class_request reqtype,
 				  __u64 source, bool from_bpf);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
-				    __u64 source);
+				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
 				u8 *data, u32 size, int interrupt, u64 source);
 	struct module *owner;
@@ -154,6 +154,24 @@ struct hid_bpf_ops {
 			       enum hid_report_type rtype, enum hid_class_request reqtype,
 			       __u64 source);
 
+	/**
+	 * @hid_hw_output_report: called whenever a hid_hw_output_report() call is emitted
+	 * on the HID device
+	 *
+	 * It has the following arguments:
+	 *
+	 * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
+	 * ``source``: a u64 referring to a uniq but identifiable source. If %0, the
+	 *             kernel itself emitted that call. For hidraw, ``source`` is set
+	 *             to the associated ``struct file *``.
+	 *
+	 * Return: %0 to keep processing the request by hid-core; any other value
+	 * stops hid-core from processing that event. A positive value should be
+	 * returned with the number of bytes written to the device; a negative error
+	 * code interrupts the processing of this call.
+	 */
+	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, __u64 source);
+
 
 	/* private: do not show up in the docs */
 	struct hid_device *hdev;
@@ -182,6 +200,8 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  u32 size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
 				  __u64 source, bool from_bpf);
+int dispatch_hid_bpf_output_report(struct hid_device *hdev, __u8 *buf, u32 size,
+				   __u64 source, bool from_bpf);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -196,6 +216,8 @@ static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						u32 size, enum hid_report_type rtype,
 						enum hid_class_request reqtype,
 						u64 source, bool from_bpf) { return 0; }
+static inline int dispatch_hid_bpf_output_report(struct hid_device *hdev, __u8 *buf, u32 size,
+						 __u64 source, bool from_bpf) { return 0; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


