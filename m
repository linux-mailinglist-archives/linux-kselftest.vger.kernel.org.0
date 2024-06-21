Return-Path: <linux-kselftest+bounces-12418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B1911F9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B90CB216A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA216F0C1;
	Fri, 21 Jun 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjyDmqng"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3F16EC18;
	Fri, 21 Jun 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960190; cv=none; b=eAwqZwVH3ukYUmV2qUwDkp/Wd/JvpJ3LvNsliFeNQ9nfUycYGsCsLgIk450YOFAE61f3giBnUsXC3bYIG1006MfRhpwFFR8/Jnm73UCrFyYPbF+k1LynyLhxOroGCtfxFHVmrGcG1wA4ElwhSs47PBGlrV93VX4cHtmvZyAM5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960190; c=relaxed/simple;
	bh=jcA+2Z3raZKxtFNoUtwuCvwREePdwHAuySvY5QwK/9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZzx+4PZBObx52MNUMpeF9NgPbblHARVGRYWWwq4DLpdGSeH4d+gx4m6y6vAZRPK8Zgaot8bvXWtJTZ1SIL8ivVJk6S2sMoL44AYuKxarewfgj+oPnli/gNmhH9nCZvlRA2d2d5YJLaZwClFRzVCAg5lUnIrZ9ycZgSjX8rUHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjyDmqng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD1C4AF09;
	Fri, 21 Jun 2024 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960190;
	bh=jcA+2Z3raZKxtFNoUtwuCvwREePdwHAuySvY5QwK/9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjyDmqngGzS+vDi4w9ZoawEdhZWpyCTmItcXreyWoE3jwSzMVlB/C8VtSpk/md+RE
	 hmCdzxLkoSSItlI/rFOXeSWQK5xZ5Zqkk11MPMYeV9VWzePpJ+WICEtev0ySKFq4Wx
	 DgNc5UZwvorjKlc5U0t0Q2aPsyuMT323t9u+5THB3fd+dCFniJEFTXzHxoJ+hKun8h
	 jEQuIlAaZZ7QqguNNcs9rx/ZvR2RU22OKorPQX3e7FF0bAUFO0yoB7Vn7E4QT+Azto
	 Rjm7xlqOQhi/H+YeygrqCKY7fxl8IhPY09jSO6a7O64FuplrF07hrGIZw+bWld8c5K
	 Ca6VemXocUSjQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:49 +0200
Subject: [PATCH HID 04/12] HID: bpf: prevent infinite recursions with
 hid_hw_raw_requests hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-4-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=7282;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=jcA+2Z3raZKxtFNoUtwuCvwREePdwHAuySvY5QwK/9g=;
 b=ycUsc493nmUZv+CCkayUS45UJtIHcOAU22dGyIbskBqiZnSjY0sOqHpn7asHcUxan+FyN+7++
 qnEmmxMqupKCbCLaoJ1ZJNia9QDWm/hBPzm/M3Vmr9CCIsQb3sozkzg
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When we attach a sleepable hook to hid_hw_raw_requests, we can (and in
many cases should) call ourself hid_bpf_raw_request(), to actually fetch
data from the device itself.

However, this means that we might enter an infinite loop between
hid_hw_raw_requests hooks and hid_bpf_hw_request() call.

To prevent that, if a hid_bpf_hw_request() call is emitted, we prevent
any new call of this kfunc by storing the information in the context.
This way we can always trace/monitor/filter the incoming bpf requests,
while preventing those loops to happen.

I don't think exposing "from_bpf" is very interesting because while
writing such a bpf program, you need to match at least the report number
and/or the source of the call. So a blind "if there is a
hid_hw_raw_request() call, I'm emitting another one" makes no real
sense.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 12 ++++++++++--
 drivers/hid/bpf/hid_bpf_dispatch.h |  1 +
 drivers/hid/hid-core.c             |  6 +++---
 drivers/hid/hidraw.c               |  4 ++--
 include/linux/hid.h                |  2 +-
 include/linux/hid_bpf.h            |  6 +++---
 6 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 813b53119b85..8d6e08b7c42f 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -78,7 +78,7 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, u8 *buf,
 				  u32 size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  u64 source)
+				  u64 source, bool from_bpf)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
@@ -87,6 +87,7 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 			.size = size,
 		},
 		.data = buf,
+		.from_bpf = from_bpf,
 	};
 	struct hid_bpf_ops *e;
 	int ret;
@@ -362,11 +363,17 @@ __bpf_kfunc int
 hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		   enum hid_report_type rtype, enum hid_class_request reqtype)
 {
+	struct hid_bpf_ctx_kern *ctx_kern;
 	struct hid_device *hdev;
 	size_t size = buf__sz;
 	u8 *dma_data;
 	int ret;
 
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+
+	if (ctx_kern->from_bpf)
+		return -EDEADLOCK;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype);
 	if (ret)
@@ -396,7 +403,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      size,
 					      rtype,
 					      reqtype,
-					      (__u64)ctx);
+					      (__u64)ctx,
+					      true); /* prevent infinite recursions */
 
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index 835e6f69f479..44c6ea22233f 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -8,6 +8,7 @@
 struct hid_bpf_ctx_kern {
 	struct hid_bpf_ctx ctx;
 	u8 *data;
+	bool from_bpf;
 };
 
 struct hid_device *hid_get_device(unsigned int hid_id);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d839cfdf1624..0164aacf07ac 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2403,7 +2403,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 unsigned char reportnum, __u8 *buf,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
-			 __u64 source)
+			 __u64 source, bool from_bpf)
 {
 	unsigned int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	int ret;
@@ -2415,7 +2415,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 		return -EINVAL;
 
 	ret = dispatch_hid_bpf_raw_requests(hdev, reportnum, buf, len, rtype,
-					    reqtype, source);
+					    reqtype, source, from_bpf);
 	if (ret)
 		return ret;
 
@@ -2441,7 +2441,7 @@ int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
 		       size_t len, enum hid_report_type rtype, enum hid_class_request reqtype)
 {
-	return __hid_hw_raw_request(hdev, reportnum, buf, len, rtype, reqtype, 0);
+	return __hid_hw_raw_request(hdev, reportnum, buf, len, rtype, reqtype, 0, false);
 }
 EXPORT_SYMBOL_GPL(hid_hw_raw_request);
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6d2a6d38e42a..4ba3131de614 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -151,7 +151,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	}
 
 	ret = __hid_hw_raw_request(dev, buf[0], buf, count, report_type,
-				   HID_REQ_SET_REPORT, (__u64)file);
+				   HID_REQ_SET_REPORT, (__u64)file, false);
 
 out_free:
 	kfree(buf);
@@ -228,7 +228,7 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	ret = __hid_hw_raw_request(dev, report_number, buf, count, report_type,
-				   HID_REQ_GET_REPORT, (__u64)file);
+				   HID_REQ_GET_REPORT, (__u64)file, false);
 
 	if (ret < 0)
 		goto out_free;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dac2804b4562..24d0d7c0bd33 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1129,7 +1129,7 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 			 unsigned char reportnum, __u8 *buf,
 			 size_t len, enum hid_report_type rtype,
 			 enum hid_class_request reqtype,
-			 __u64 source);
+			 __u64 source, bool from_bpf);
 int __hid_hw_output_report(struct hid_device *hdev, __u8 *buf, size_t len, __u64 source);
 int hid_hw_raw_request(struct hid_device *hdev,
 		       unsigned char reportnum, __u8 *buf,
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 5c3f179dc2ab..bb6cc5c7c705 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -67,7 +67,7 @@ struct hid_ops {
 				  unsigned char reportnum, __u8 *buf,
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source);
+				  __u64 source, bool from_bpf);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    __u64 source);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
@@ -178,7 +178,7 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source);
+				  __u64 source, bool from_bpf);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -192,7 +192,7 @@ static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						unsigned char reportnum, u8 *buf,
 						u32 size, enum hid_report_type rtype,
 						enum hid_class_request reqtype,
-						u64 source) { return 0; }
+						u64 source, bool from_bpf) { return 0; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


