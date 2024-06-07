Return-Path: <linux-kselftest+bounces-11394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE569008E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F3128D322
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78240199EA0;
	Fri,  7 Jun 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km3XZlQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDC199E98;
	Fri,  7 Jun 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774117; cv=none; b=BbCWImmRFo9N8HfkWkNSXBxpY4FOT7SWsAs23lfTn5PpIWlSdLSkhaKFBuRnGl8mep6iHjFnrmAg/AddFvqFA5xwwyJrbxLiApRW7/qwPQBmxR9TSl8QNCppHv/X3/71bEmRYfzHlzDXQ+Fyx4ZELk3dQNsYAkOaqsnY3jvxdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774117; c=relaxed/simple;
	bh=/R7kYdkB8bgtpMVTXS+2jlG8Z27/TD1w+IJxULW99sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEdf+hsPU96UUIwZhZ9tSBcvIiZn+91VQCH2SLG7Otfb6IKDTF6cL5w7nGYj51E+DOSH3PZ8PWsRqxG97lzyRLWOKgLU5gt/icR2HnZQy17WfhidvYlOSNFD698y7/Ov4ikY+cHIhwu58JSz6YKYSe7lWxJSEPz8W7Y4c4f+hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km3XZlQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B5CC4AF07;
	Fri,  7 Jun 2024 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774116;
	bh=/R7kYdkB8bgtpMVTXS+2jlG8Z27/TD1w+IJxULW99sM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Km3XZlQD5bFY059Zy/DQc6YvK6QaIC1qBmRVjP6npae1yV/hXa1nxob9eZxcmSAHU
	 TjEHvAtm7nqRCo3zcYH1F+Ln4pNDkc37M2L2YGlI+ACuOstgEDHEX0UhUW2v6yKQUd
	 j34tv2SXrgF4ULYLc4RzC8p+/WLfAl8j/Re7BztOvqCR3759jTlQ1MgdTgXcU5+WNf
	 TF41L/RJURsqLVLjVDCcdmEeTwuR2CInAKx999T2p2bVf5FzYEO1mDBMGGU9GaeT+x
	 ruCXpuoMlVvFfUqpdSZY53CDdwCCbo+dEUo8uO1cRkPpIYVh0sbCbp8iAeCRZj0kqY
	 fUwEsqBXCT9DA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:22 +0200
Subject: [PATCH HID v2 02/16] HID: bpf: add hid_get/put_device() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-2-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=2722;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=/R7kYdkB8bgtpMVTXS+2jlG8Z27/TD1w+IJxULW99sM=;
 b=GVk2LoaP8ORGRh4w4xTOl6sBH9nMzRxXJHN0EOT7odpSU3zjIBkTQcF/8h1aQKUR0c4i15HR1
 RjLFfdkSCeOAsTo48QiCgPBCXREXvEtSMC3jH+F1d0jFiiP7sONC4tJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

no code change, but this way we reduce code duplication and we
can export it later.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


