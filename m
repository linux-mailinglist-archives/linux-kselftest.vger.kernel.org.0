Return-Path: <linux-kselftest+bounces-11472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1144F9010AC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F5F1C2161C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75E17837D;
	Sat,  8 Jun 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXnmsuem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C3178371;
	Sat,  8 Jun 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837286; cv=none; b=gvfYFOZpZ7pkIOfB0AjT15xgrxp9bVxKSuSlOwDP/wOBOaVB1AmCC5PK16gBHkgQIO6iIaDxsUtHPOfWp+VhzFXLitqsVmUeLgH5+ogNdu8BgZmUWXGunm1E0pbfFxmXHj9k9I0HrfQkNSwAZsfJ3K2wHsrhAGnhxdYMDNOw/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837286; c=relaxed/simple;
	bh=NoLrJd5sEhcFvxDx8M3VYx3BFl64wagoJzWAatOgIx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en+2f085fsKLNne2OXTzXTgx40m4ftvHfIXHhtaj25TCNLSO3gexUcnPkR5WnaMIgEaTmfZ5RDWiy9EiNeb9uD1HagmzFrYgtJI4Bq5IiB8FXqA9/YN6yrja95TMHJV3O/Mjm5fazZMusL/XKd1lfrKiMOItHvnRGbSXgKlrmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXnmsuem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC037C4AF0A;
	Sat,  8 Jun 2024 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837286;
	bh=NoLrJd5sEhcFvxDx8M3VYx3BFl64wagoJzWAatOgIx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dXnmsuemeQxjAA4XasfeL7d4V576vK9yxYH4lD2T57IacO1Ev49h49Lq328En9EWO
	 2nbAm1ejPl+9ypiKZLFWZE/RLp7s8FHCHiWzSxqRqHC7YEWmerf0zMST++cYHfwo1k
	 xd09XnJ5pzgiBu0lBbLwUiokW/MKd2kcWsjrzPhp2qqMZVzEqYZevN3n8uZB1xoP80
	 UU6oqR1fcnz4+bbUpfp5QXe21TtmefMapoQp2/efNSb3Uf5weVgDebhsEmPax2R2VL
	 wil9b48L2O3gNz9vpwhZTeqHSSPhX6zo1Gsq66PElrS5xWVDoYVdzhXRiIa0MCk8Iz
	 kjQlHrMxTfEFQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:14 +0200
Subject: [PATCH HID v3 02/16] HID: bpf: add hid_get/put_device() helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-2-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=2742;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=NoLrJd5sEhcFvxDx8M3VYx3BFl64wagoJzWAatOgIx8=;
 b=wOSu1fuRpEKlVNqrOkUqe6GzMxDRCQHI/7fp9HQi+CGJSRCuXY6YUIaVXEA31aabzlvHb0mc2
 h65LP1FKmGpBflAOxnsNtjZWHPQ6U1VGePku2hbfX+/pFxFxsz4iTeR
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

no code change, but this way we reduce code duplication and we
can export it later.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

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


