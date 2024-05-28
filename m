Return-Path: <linux-kselftest+bounces-10776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19C8D1C5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2184EB25104
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FA16F827;
	Tue, 28 May 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8NUf+Zs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239016F29D;
	Tue, 28 May 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902121; cv=none; b=ZmXFTPJDiv0mkO7ds7L0fSBqTLohtQ8Mpl7woZVkgdCc1FlaomWxkBsx8xUjTLPvGGC+j5cDFGbW5o7oHwBr8/qmZzYT4vIB/zkR3JrMxff4OH3+5L8Nub/ClY0pwMIMnrE73KWTIrrcw7eqmI1n/21Lc8Gcr1kFBmznn6eZEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902121; c=relaxed/simple;
	bh=k80jRINwHvZ+mA1/CvTlz56wthVn4z/bRY+1lsX1KzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyKsAVNilRuIERNs99VmguRpPIqyRd71jYkVHnY4JO3Bi8x61ngK+5ZooxABymYy5lvbobUnrpExIldEeZ0n0BXDHln51NUjDkik146qzHzz/OWaesUQRog8DuCGAOzYiMp9MWfIUlX9cecoL82Q5jh+o8LjwmqCLJp/TbUA9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8NUf+Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C3C3277B;
	Tue, 28 May 2024 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902120;
	bh=k80jRINwHvZ+mA1/CvTlz56wthVn4z/bRY+1lsX1KzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V8NUf+Zsi674sw6wYZL9QuUQf+E7UyMjXl3DcAS6jna6nOfMGU+soB5ZERHM7EecA
	 wAidV2q5Ukf/2aNATUIxA3+yaDZFSbEdHupnyHl6lxjmmP78roVvO/wiijCaXpJjpj
	 BDW5RejcYZY/QDN2cCLorjUZ34d/bVaJN52hp9WCadzEj4srAaIB6/WVEUmqWmQXfH
	 QHGayUj/+osSIKt6J33AklHCBuSaNDqPnVMiqQhmQor1peFTg3HfWO90JhYPCohu4a
	 wXVLTR+eT3rwY1C29S9Ey9NPUn46KMU2T/XY5IyV6dzePOomNcECTmEnzrJi7I2cAn
	 bR2XoifIsWYng==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:40 +0200
Subject: [PATCH HID 02/13] HID: bpf: add hid_get/put_device() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-2-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=2695;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=k80jRINwHvZ+mA1/CvTlz56wthVn4z/bRY+1lsX1KzU=;
 b=90be5r6MEoEoF60gANLPDX5MDwZJfIpGWtFtxLfi59aAdNfzmOc4bFQOLMtHkYiD2wnXw7gxc
 W8sLognaXowCD0DvLaF9yCjCE6RzMSEF7WVmWCD8NShhwYa8YEJ4lsA
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

no code change, but this way we reduce code duplication and we
can export it later.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 47 ++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 55c9f82fdef0..c8bb79ce2354 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -150,6 +150,25 @@ static int device_match_id(struct device *dev, const void *id)
 	return hdev->id == *(int *)id;
 }
 
+static struct hid_device *hid_get_device(unsigned int hid_id)
+{
+	struct device *dev;
+
+	if (!hid_ops)
+		return ERR_PTR(-EINVAL);
+
+	dev = bus_find_device(hid_ops->bus_type, NULL, &hid_id, device_match_id);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	return to_hid_device(dev);
+}
+
+static void hid_put_device(struct hid_device *hid)
+{
+	put_device(&hid->dev);
+}
+
 static int __hid_bpf_allocate_data(struct hid_device *hdev, u8 **data, u32 *size)
 {
 	u8 *alloc_data;
@@ -281,20 +300,14 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 {
 	struct hid_device *hdev;
 	struct bpf_prog *prog;
-	struct device *dev;
 	int err, fd;
 
-	if (!hid_ops)
-		return -EINVAL;
-
 	if ((flags & ~HID_BPF_FLAG_MASK))
 		return -EINVAL;
 
-	dev = bus_find_device(hid_ops->bus_type, NULL, &hid_id, device_match_id);
-	if (!dev)
-		return -EINVAL;
-
-	hdev = to_hid_device(dev);
+	hdev = hid_get_device(hid_id);
+	if (IS_ERR(hdev))
+		return PTR_ERR(hdev);
 
 	/*
 	 * take a ref on the prog itself, it will be released
@@ -317,7 +330,7 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
  out_prog_put:
 	bpf_prog_put(prog);
  out_dev_put:
-	put_device(dev);
+	hid_put_device(hdev);
 	return err;
 }
 
@@ -333,20 +346,14 @@ hid_bpf_allocate_context(unsigned int hid_id)
 {
 	struct hid_device *hdev;
 	struct hid_bpf_ctx_kern *ctx_kern = NULL;
-	struct device *dev;
-
-	if (!hid_ops)
-		return NULL;
 
-	dev = bus_find_device(hid_ops->bus_type, NULL, &hid_id, device_match_id);
-	if (!dev)
+	hdev = hid_get_device(hid_id);
+	if (IS_ERR(hdev))
 		return NULL;
 
-	hdev = to_hid_device(dev);
-
 	ctx_kern = kzalloc(sizeof(*ctx_kern), GFP_KERNEL);
 	if (!ctx_kern) {
-		put_device(dev);
+		hid_put_device(hdev);
 		return NULL;
 	}
 
@@ -373,7 +380,7 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 	kfree(ctx_kern);
 
 	/* get_device() is called by bus_find_device() */
-	put_device(&hid->dev);
+	hid_put_device(hid);
 }
 
 static int

-- 
2.44.0


