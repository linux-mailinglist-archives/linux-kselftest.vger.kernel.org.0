Return-Path: <linux-kselftest+bounces-12800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A271C918309
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591462849BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D8186E43;
	Wed, 26 Jun 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YupSo94w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D67186E39;
	Wed, 26 Jun 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409614; cv=none; b=qSbQHyPwqtGELt7ZR5eD2p9Z9YD64X5vpCDiDveXVwa5C/Tih4itFO0wo90E9LF0PNVE5Vl2YPm7PBMD0j3O+fSztxGsKFaf+bCDnqfT5gr72VD3Z/KE8rJ5pdDW1wkxyx5f3yqA+z0kDhwVI0DchIU0tvAfY7ougNtVAcb11uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409614; c=relaxed/simple;
	bh=B5RcoIbutWmEtYXbPfsY1oRwm9bGSb4lgVEA9mGXIHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7a5z7ZhqNLFmSW9PvCHpZcPPy59J8RLDvyEHjdLvoNV0RoTJgAvXhBhNMalUCoMGW1dqBcjHwg9CKW/ZI1RmW4z0FTYWkL9HTNNbQ8a9+lzk4Jj5eb+A0kj4U116YB1X+zXPCXu4jYAFd6HPXuSpbRAcW33MO35fEOTGAO+5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YupSo94w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFB4C4AF0A;
	Wed, 26 Jun 2024 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409614;
	bh=B5RcoIbutWmEtYXbPfsY1oRwm9bGSb4lgVEA9mGXIHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YupSo94w9dMTCVttRtG+nZkRrPO6C77Je1EZLD6PByg7H6+YP0oEpSwmVeAclvrdh
	 OECU3Ow2vCqk6l/QGrd7NUWA035AvzSzPfiJrpk2r2Ghx6OJAgznJLiYXxSwazNrQm
	 bqfmVeGOxa5jrclVd90ZflMNNMhJAdw49hUZMcuHND1OsSognN+/KeptcccbWN38AU
	 OT8+Zuv4Awtlvnlck/6W3kjCAcrMPHqATOh4upQwSjh+0ytgenQJB2fpMHwZPLsJLa
	 zOpEKi4ROg5fds9u3/1w0SfpCis935WxTEeIWh6VQkQpL0TIJHH9Cymbk0L5L6VC63
	 DRkL9cLdoaURA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:25 +0200
Subject: [PATCH HID v2 04/13] HID: bpf: add HID-BPF hooks for
 hid_hw_raw_requests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-4-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=6531;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=B5RcoIbutWmEtYXbPfsY1oRwm9bGSb4lgVEA9mGXIHs=;
 b=ap86IjvdzdO19bJIsBM5btV8JBPEV8eM2lIZmsCe0aR9wqgGDLxjjZ9MI5CLwBFW4XQ8M8Um2
 hEpPQo2xrkoAG/eWRRopfr01NCYxNjH1D7t3WiMrM+Nm3QB4TIJsohZ
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

changes in v2:
- make use of SRCU
---
 drivers/hid/bpf/hid_bpf_dispatch.c   | 37 ++++++++++++++++++++++++++++++++++++
 drivers/hid/bpf/hid_bpf_struct_ops.c |  1 +
 drivers/hid/hid-core.c               |  6 ++++++
 include/linux/hid_bpf.h              | 35 ++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index c026248e3d73..ac98bab4c96d 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -74,6 +74,43 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
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
+	int ret, idx;
+
+	if (rtype >= HID_REPORT_TYPES)
+		return -EINVAL;
+
+	idx = srcu_read_lock(&hdev->bpf.srcu);
+	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
+				 srcu_read_lock_held(&hdev->bpf.srcu)) {
+		if (e->hid_hw_request) {
+			ret = e->hid_hw_request(&ctx_kern.ctx, reportnum, rtype, reqtype, source);
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
+EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
+
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index d34731a1b457..a540a4417174 100644
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
index ad08289752da..16731804c6bd 100644
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
index f93845de5cac..3c01f7f8b6fc 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -130,6 +130,31 @@ struct hid_bpf_ops {
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
@@ -152,6 +177,11 @@ struct hid_bpf {
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
@@ -161,6 +191,11 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
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


