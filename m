Return-Path: <linux-kselftest+bounces-13006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5491DF8F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C011C214D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EF15AAB8;
	Mon,  1 Jul 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxVssHLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB915A87C;
	Mon,  1 Jul 2024 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837614; cv=none; b=bEysZRbod8lT5E1tEkyYYmluoimmF+/xA4h1Oc4yyTQPDmnh7o71IroPp+zPIdHjwKk/Wmfx3eeKhMgagjdKRrnQJDMtbuMS7SZJpyZOLTNQaTLu36fFmvbleC2gt5AhG0fR6fVsBtCT+wupJdZvJUToJ9S/Pmb8jI/poe8Ilig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837614; c=relaxed/simple;
	bh=d7yH9YfAsU8Sr3Uu3uIuiYCXGouIBOJuEfxMH6XTfb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9rA+pabUEX/8PtZu6Qw5OpWxtq1vgRJOeTRlXcPFK7uoRRXk54W3U7MWgxaLdhvKtsVOcnD5T2r3iDcUzxOLcU8CxcFaR3K7vdnTqXfHRpOdgpKVkFl2mInkp19M0gOz02U5SWVn+0RtsM3ZVI3Xlzpyj1eVewx3T/L2OIHPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxVssHLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6BFC2BD10;
	Mon,  1 Jul 2024 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837613;
	bh=d7yH9YfAsU8Sr3Uu3uIuiYCXGouIBOJuEfxMH6XTfb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OxVssHLsOOJFr4MH5RlMpbyjO/kIYmyjM4THraM6JKXAHLo5b9Nx+4MqnXSpYh4qf
	 jsBF+XQapwHA9P+hBo29hlQrkPZlPN4iiuVJFkmtqUKOdXpH0ru5cApTiGv9hZrZC9
	 HMY76uW/iSO8NTrKTE/DSGFQ3CcgBP+uO6KGZEP+cKbB1LjiOiXonnxn3vJqQTBXm5
	 T6WSOuqEOBKNa4fnZhBVubWFo3b+nzjG4UGDPBsOxrxZZe3n17OvrV6ZjGjlIO5BTI
	 IaGnOkVtLNDNO2tBPOz0uzBIxQcLJQqNgjXgTSJY2zg8WcBeri6eRZ+O2dAyJMYmQ0
	 MRnCrNN1/lCkg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 01 Jul 2024 14:39:52 +0200
Subject: [PATCH v2 4/4] HID: bpf: doc fixes for hid_hw_request() hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-fix-cki-v2-4-20564e2e1393@kernel.org>
References: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
In-Reply-To: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719837604; l=3801;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=d7yH9YfAsU8Sr3Uu3uIuiYCXGouIBOJuEfxMH6XTfb0=;
 b=lRVwyNBjOsfEBiiJ7w+xL007jid0rN15OF9+h9R5Zm5GHE/IgWBsYSaY+iq4VfC0o3D6EvH9u
 4L0zR1wYq3wBN4Kof28tK6Gp81Z0IZICq9vY06Pwdggu5CyKO1rP5wz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We had the following errors while doing make htmldocs:

Documentation/hid/hid-bpf:185: include/linux/hid_bpf.h:167:
	ERROR: Unexpected indentation.

Also ensure consistency with the rest of the __u64 vs u64.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 9286675a2aed ("HID: bpf: add HID-BPF hooks for hid_hw_output_report")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c |  2 +-
 include/linux/hid_bpf.h            | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index a36e680399fe..a272a086c950 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -115,7 +115,7 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_raw_requests);
 
 int dispatch_hid_bpf_output_report(struct hid_device *hdev,
-				   __u8 *buf, u32 size, __u64 source,
+				   __u8 *buf, u32 size, u64 source,
 				   bool from_bpf)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index c30c31b79419..9ca96fc90449 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -138,6 +138,7 @@ struct hid_bpf_ops {
 	 * It has the following arguments:
 	 *
 	 * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
+	 *
 	 * ``reportnum``: the report number, as in hid_hw_raw_request()
 	 *
 	 * ``rtype``: the report type (``HID_INPUT_REPORT``, ``HID_FEATURE_REPORT``,
@@ -165,16 +166,17 @@ struct hid_bpf_ops {
 	 * It has the following arguments:
 	 *
 	 * ``ctx``: The HID-BPF context as &struct hid_bpf_ctx
+	 *
 	 * ``source``: a u64 referring to a uniq but identifiable source. If %0, the
-	 *             kernel itself emitted that call. For hidraw, ``source`` is set
-	 *             to the associated ``struct file *``.
+	 * kernel itself emitted that call. For hidraw, ``source`` is set
+	 * to the associated ``struct file *``.
 	 *
 	 * Return: %0 to keep processing the request by hid-core; any other value
 	 * stops hid-core from processing that event. A positive value should be
 	 * returned with the number of bytes written to the device; a negative error
 	 * code interrupts the processing of this call.
 	 */
-	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, __u64 source);
+	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, u64 source);
 
 
 	/* private: do not show up in the docs */
@@ -203,9 +205,9 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 size, enum hid_report_type rtype,
 				  enum hid_class_request reqtype,
-				  __u64 source, bool from_bpf);
+				  u64 source, bool from_bpf);
 int dispatch_hid_bpf_output_report(struct hid_device *hdev, __u8 *buf, u32 size,
-				   __u64 source, bool from_bpf);
+				   u64 source, bool from_bpf);
 int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
@@ -221,7 +223,7 @@ static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						enum hid_class_request reqtype,
 						u64 source, bool from_bpf) { return 0; }
 static inline int dispatch_hid_bpf_output_report(struct hid_device *hdev, __u8 *buf, u32 size,
-						 __u64 source, bool from_bpf) { return 0; }
+						 u64 source, bool from_bpf) { return 0; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}

-- 
2.44.0


