Return-Path: <linux-kselftest+bounces-12420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A5911FA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB06B2210C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8F16F82F;
	Fri, 21 Jun 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn0wEPw+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584316F29F;
	Fri, 21 Jun 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960195; cv=none; b=F/fsOxYzzkCChNhCOJaovAj97k7pSJlkrVhCPD4Y0/TKtos8Lin9uSwTriOCef2VRH7zK2fBcXumjEnELugo2QDa65QmF3jtph3m4iJVRrrhcpzr94jZBrlerB1iOcUAxaWvq/f4kG//2b552qvp1zUEtZ9e64VhzncdZYxEK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960195; c=relaxed/simple;
	bh=JiKAdKFDZbn+4Mk7WQIyo9I38Zbpy7zp3+6aI6igqbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lk77+9dG5ZY+sTuR0BUx+5ILwRX+6QCA9g5bPtLdoGcdrzjNyjauFSIPjB0gfWTt3MLZzgOCIBH+g15ss/kuZN+hPJ3DZlU32GUOKpPMNMh/pmsjQhoVM+sVVsDWnyJKFVXnWLKvtj7qVqnxzUe673BYvV+I8EkcfaF6XgP76p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn0wEPw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B1FC4AF08;
	Fri, 21 Jun 2024 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960194;
	bh=JiKAdKFDZbn+4Mk7WQIyo9I38Zbpy7zp3+6aI6igqbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sn0wEPw+HCs/deCxPnFMHmQfGM5PGkQQJoE8QLJ5BNzdV5YdqARbUNnmeGUD/TjIF
	 finOTKNMxxV13JDHvo4uWGD85KDQaJ009bIEPi/zcpYEPp1kAosza20l2cOPPsxrr7
	 Cdwe08HS/FdBzpmjuGH1QDj21ERulTb2tdGs+0zz4glqCqvaC8F09RkQmMt/XIXjTw
	 CAiFDrbIrAww8fqWrhR8SkXNiH/2BS/TPZKSPIxPzeT+XpMHYfBN0DmKlFAQ7o8uR1
	 IpmBkou5rh9HIX+vnoJ3QoeY3vSNLNtzFPUy/x6PcWDYz5NRr6DyNzSYihqrspKf4F
	 OmNMWjKGxHryQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:51 +0200
Subject: [PATCH HID 06/12] HID: bpf: add HID-BPF hooks for
 hid_hw_output_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-6-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=8890;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JiKAdKFDZbn+4Mk7WQIyo9I38Zbpy7zp3+6aI6igqbA=;
 b=A40eBbux7mjTHkaBaSi0kYGAPwOUzKuJ8sApL1yg1JZUYSyV9Ab2gjVuLrKbeJXnexw57KXWn
 ttYAlTrfh3/D8yc6ilZLLKT/ArsdZc6fDLiAF+1D5LEioC4QPlFHm2T
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

Here checkpatch complains about:
WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code

However, we are jumping in BPF code, so I think this is correct, but I'd
like to have the opinion on the BPF folks.
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++++----
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               | 10 ++++++++--
 drivers/hid/hidraw.c                 |  2 +-
 include/linux/hid.h                  |  3 ++-
 include/linux/hid_bpf.h              | 24 ++++++++++++++++++++++-
 6 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 8d6e08b7c42f..2a29a0625a3b 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -111,6 +111,38 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
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
+	int ret;
+
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
+		if (e->hid_hw_output_report) {
+			ret = e->hid_hw_output_report(&ctx_kern.ctx, source);
+			if (ret)
+				goto out;
+		}
+	}
+	ret = 0;
+
+out:
+	rcu_read_unlock_trace();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dispatch_hid_bpf_output_report);
+
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
@@ -441,10 +473,7 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
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
index 93c824ba6a65..71143a65a99c 100644
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
index 0164aacf07ac..5a5fa4a32cbc 100644
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
index bb6cc5c7c705..3872c6fac62b 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -69,7 +69,7 @@ struct hid_ops {
 				  enum hid_class_request reqtype,
 				  __u64 source, bool from_bpf);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
-				    __u64 source);
+				    __u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
 				u8 *data, u32 size, int interrupt, u64 source);
 	struct module *owner;
@@ -152,6 +152,24 @@ struct hid_bpf_ops {
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
@@ -179,6 +197,8 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  u32 size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
 				  __u64 source, bool from_bpf);
+int dispatch_hid_bpf_output_report(struct hid_device *hdev, __u8 *buf, u32 size,
+				   __u64 source, bool from_bpf);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -193,6 +213,8 @@ static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
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


