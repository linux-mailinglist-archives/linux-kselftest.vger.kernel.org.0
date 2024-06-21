Return-Path: <linux-kselftest+bounces-12417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D613911F91
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B141F1F24386
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7916EBF3;
	Fri, 21 Jun 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPF6+Ec2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D316EBE9;
	Fri, 21 Jun 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960188; cv=none; b=Og9jiUqVMdwgBkzrlmiJeTgvbe5+S3R38UVKL1Za8vF2em+Yo62Ct/pj75fFlAhWBAPfRYqYHHT9AkxULDiyuCMfPhSquKLeL7rOdiaFGa658cQBaNTWlYpkYAMl8t3pcsEEDzw5tBCtfcJoOHfG4v+yeJVGwyUNjTpbrS0kAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960188; c=relaxed/simple;
	bh=O9hPnjs5dSyuQDOqlP/aa60idJ0IdzqSPtbD/Na1VdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Se3KULKueexsVuamq5gq2vh/qkhoemaKAaSPLUCxKnysFg+NfSdPE8qkvSm8ZY4jXKkpONRow11yobzhA6Dsy+1Miw8IyYNc7g4AYAfO3lNcnvX8pvUETMj8YziZ3KPuJzh7mGZWiKS4mxE57cV41y3XEq9eblKYivw7dNNTx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPF6+Ec2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A1C4AF0B;
	Fri, 21 Jun 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960187;
	bh=O9hPnjs5dSyuQDOqlP/aa60idJ0IdzqSPtbD/Na1VdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XPF6+Ec20awPss0oSnV5fXrWyjMt3piKAekngxywmcgzcjyxjltG3mQXcjuCho7B+
	 0qQBsGVWNgGyJyER+GU01Qfr+9nLaC2qISnZB8pFJDFQQbZcctHDE0VZzRhAiwOhJy
	 K868JnqNLLxjyckObsSlNa4OR5NUVJn2gzVaYy7EOIq+cNSywIHgn8Y7THl0sKMM4W
	 9rs4pRuhC6bA3gW/vBxldrmt6b24vXvwhrVKQqsNpT6YZASzxFsodt6ER6WQyI2Egu
	 W20yGUb4TtUlPE/Ap3/BrJZsCpYSj156NxDbZ9CG4SRMYrR/qfCofgSG4WRv9C04bu
	 XyfIFMUROETUQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:48 +0200
Subject: [PATCH HID 03/12] HID: bpf: add HID-BPF hooks for
 hid_hw_raw_requests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-3-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=6643;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=O9hPnjs5dSyuQDOqlP/aa60idJ0IdzqSPtbD/Na1VdA=;
 b=ddPzX2Dd+mKcb4hvJaRn+4E0KtsZ5pBgGVWZsNqBHJXIPYY6AE2n1KrPkpzg1ObtoMO1kJgw3
 OUNTXbPLU36CYj00jnLdaAgIyxacngqebbSgH3tqkO0qh/s8mrfJ4zd
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows to intercept and prevent or change the behavior of
hid_hw_raw_request() from a bpf program.

The intent is to solve a couple of use case:
- firewalling a HID device: a firewall can monitor who opens the hidraw
  nodes and then prevent or allow access to write operations on that
  hidraw node.
- change the behavior of a device and emulate a new HID feature request

The hook is allowed to be run as sleepable so it can itself call
hid_bpf_hw_request(), which allows to "convert" one feature request into
another or even call the feature request on a different HID device on the
same physical device.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

Here checkpatch complains about:
WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code

However, we are jumping in BPF code, so I think this is correct, but I'd
like to have the opinion on the BPF folks.
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 36 ++++++++++++++++++++++++++++++++++++
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               |  6 ++++++
 include/linux/hid_bpf.h              | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 2df31decaac3..813b53119b85 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -74,6 +74,42 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
 
+int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+				  unsigned char reportnum, u8 *buf,
+				  u32 size, enum hid_report_type rtype,
+				  enum hid_class_request reqtype,
+				  u64 source)
+{
+	struct hid_bpf_ctx_kern ctx_kern = {
+		.ctx = {
+			.hid = hdev,
+			.allocated_size = size,
+			.size = size,
+		},
+		.data = buf,
+	};
+	struct hid_bpf_ops *e;
+	int ret;
+
+	if (rtype >= HID_REPORT_TYPES)
+		return -EINVAL;
+
+	rcu_read_lock_trace();
+	list_for_each_entry_rcu(e, &hdev->bpf.prog_list, list) {
+		if (e->hid_hw_request) {
+			ret = e->hid_hw_request(&ctx_kern.ctx, reportnum, rtype, reqtype, source);
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
+EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
+
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 8063db1c8d62..93c824ba6a65 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -44,6 +44,7 @@ static int hid_bpf_ops_check_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct hid_bpf_ops, hid_rdesc_fixup):
+	case offsetof(struct hid_bpf_ops, hid_hw_request):
 		break;
 	default:
 		if (prog->sleepable)
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0775a32f5272..d839cfdf1624 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2406,6 +2406,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 __u64 source)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
+	int ret;
 
 	if (hdev->ll_driver->max_buffer_size)
 		max_buffer_size = hdev->ll_driver->max_buffer_size;
@@ -2413,6 +2414,11 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 	if (len < 1 || len > max_buffer_size || !buf)
 		return -EINVAL;
 
+	ret = dispatch_hid_bpf_raw_requests(hdev, reportnum, buf, len, rtype,
+					    reqtype, source);
+	if (ret)
+		return ret;
+
 	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
 					    rtype, reqtype);
 }
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index b88fa2df9f2c..5c3f179dc2ab 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -128,6 +128,31 @@ struct hid_bpf_ops {
 	 */
 	int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);
 
+	/**
+	 * @hid_hw_request: called whenever a hid_hw_raw_request() call is emitted
+	 * on the HID device
+	 *
+	 * It has the following arguments:
+	 *
+	 * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
+	 * ``reportnum``: the report number, as in hid_hw_raw_request()
+	 * ``rtype``: the report type (``HID_INPUT_REPORT``, ``HID_FEATURE_REPORT``,
+	 *            ``HID_OUTPUT_REPORT``)
+	 * ``reqtype``: the request
+	 * ``source``: a u64 referring to a uniq but identifiable source. If %0, the
+	 *             kernel itself emitted that call. For hidraw, ``source`` is set
+	 *             to the associated ``struct file *``.
+	 *
+	 * Return: %0 to keep processing the request by hid-core; any other value
+	 * stops hid-core from processing that event. A positive value should be
+	 * returned with the number of bytes returned in the incoming buffer; a
+	 * negative error code interrupts the processing of this call.
+	 */
+	int (*hid_hw_request)(struct hid_bpf_ctx *ctx, unsigned char reportnum,
+			       enum hid_report_type rtype, enum hid_class_request reqtype,
+			       __u64 source);
+
+
 	/* private: do not show up in the docs */
 	struct hid_device *hdev;
 };
@@ -149,6 +174,11 @@ struct hid_bpf {
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
 				  u32 *size, int interrupt, u64 source);
+int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+				  unsigned char reportnum, __u8 *buf,
+				  u32 size, enum hid_report_type rtype,
+				  enum hid_class_request reqtype,
+				  __u64 source);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -158,6 +188,11 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
 						u8 *data, u32 *size, int interrupt,
 						u64 source) { return data; }
+static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
+						unsigned char reportnum, u8 *buf,
+						u32 size, enum hid_report_type rtype,
+						enum hid_class_request reqtype,
+						u64 source) { return 0; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


