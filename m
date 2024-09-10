Return-Path: <linux-kselftest+bounces-17589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF80973A3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B2F1F22367
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05790199FBA;
	Tue, 10 Sep 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYOlfhS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30B199952;
	Tue, 10 Sep 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979432; cv=none; b=b1VKqM6QRTTEd7DR5vPig2DHb2fteHzr/w6rLgLyI5SC21kyZlONmuFf6MPCMl55rUNy93tuUI7tylgaOIiHBQCcpXcPtA1E4ZXPFU5bwhdnPmgz3AdOy6DxJZPXEXi7qJpeLw46RLLLCZPVdPDjZLLleadiRvhuimeVJg2EIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979432; c=relaxed/simple;
	bh=w2GuvfapADWngezjPqhaRKjXMs8AxDtj7AKQPZiO04o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRjnyZ9/n9lDbncTZmCjft4YGsSROHk4HB/1h1UVzaEHih3ohQWVUrO66CkAeR4zR+djGKLjCAQGK7nypQ8lilA7YEex9F0MiowtpAdeLcghdSpgspceKD7lx8idwsYXRyHspLDevCmjv2JO14tKLWSjUmqqA1eZdiD/uUazvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYOlfhS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A845DC4CEC4;
	Tue, 10 Sep 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979432;
	bh=w2GuvfapADWngezjPqhaRKjXMs8AxDtj7AKQPZiO04o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYOlfhS2sa+fLm8PS0MOo5NQJ7R20BEKib5MJhHATx65nQs54O1eIN/2bKh3/qHKd
	 qXZ5LneshTX8P4KhgRdOGaTp9ph+y/CRMQ0r9btqf2sUpY06b882Z929BhB2pkTC4p
	 BAahp9O7GqQoUSihQOtl3NAJ/ZYlaqC81rIt2uNlHidTWBBDbPoqGynD652PUWTdLA
	 C2o28083hoczGWII9SsZ1x1ofJko7lRZmDvixuCRdQKKgE/ItqlgEczLbY6Mu5rNf3
	 xHjA+FS9Ptsj3HZx8cGbsu/ZnaUPB8QCGvoEAV83jMcmFWdjkdiR1a13VJ27aFQKjQ
	 /FAlZse1O0m+Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:37 +0900
Subject: [PATCH HID v2 01/11] HID: bpf: move HID-BPF report descriptor
 fixup earlier
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-1-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=7588;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=w2GuvfapADWngezjPqhaRKjXMs8AxDtj7AKQPZiO04o=;
 b=agec0rI0QU0hVLvpvSXvLP9nPKm6u6c+g2P0Ec0M9MCueLCNyStIERaq4dGic+T4JCsiNwtXq
 Bl473uUW1I/B4rMfAuh4gszoLuHMCUW3Sn8RZejb1pgj0o5NyvN0TNb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Currently, hid_bpf_rdesc_fixup() is called once the match between the
HID device and the driver is done. This can be problematic in case
the driver selected by the kernel would change the report descriptor
after the fact.

To give a chance for hid_bpf_rdesc_fixup() to provide hints on to how
to select a dedicated driver or not, move the call to that BPF hook
earlier in the .probe() process, when we get the first match.

However, this means that we might get called more than once (typically
once for hid-generic, and once for hid-vendor-specific). So we store the
result of HID-BPF fixup in struct hid_device. If that new value is NULL,
we need to use ->dev_rdesc.

In order to not grow struct hid_device, some fields are re-ordered. This
was the output of pahole for the first 128 bytes:
struct hid_device {
	__u8 *                     dev_rdesc;            /*     0     8 */
	unsigned int               dev_rsize;            /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	__u8 *                     rdesc;                /*    16     8 */
	unsigned int               rsize;                /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	struct hid_collection *    collection;           /*    32     8 */
	unsigned int               collection_size;      /*    40     4 */
	unsigned int               maxcollection;        /*    44     4 */
	unsigned int               maxapplication;       /*    48     4 */
	__u16                      bus;                  /*    52     2 */
	__u16                      group;                /*    54     2 */
	__u32                      vendor;               /*    56     4 */
	__u32                      product;              /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	__u32                      version;              /*    64     4 */
	enum hid_type              type;                 /*    68     4 */
	unsigned int               country;              /*    72     4 */

	/* XXX 4 bytes hole, try to pack */

	struct hid_report_enum     report_enum[3];       /*    80  6216 */

Basically, we got three holes of 4 bytes. We can reorder things a little
and makes those 3 holes a continuous 12 bytes hole, which can be replaced
by the new pointer and the new unsigned int we need.

In terms of code allocation, when not using HID-BPF, we are back to kernel
v6.2 in hid_open_report(). These multiple kmemdup() calls will be fixed
in a later commit.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c |  8 ++++++--
 drivers/hid/hid-core.c             | 17 +++++++++++++----
 include/linux/hid.h                | 18 ++++++++++--------
 include/linux/hid_bpf.h            |  9 ++-------
 4 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 8420c227e21b..58839c125fba 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -183,7 +183,7 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned
 
  ignore_bpf:
 	kfree(ctx_kern.data);
-	return kmemdup(rdesc, *size, GFP_KERNEL);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
 
@@ -260,8 +260,12 @@ int hid_bpf_allocate_event_data(struct hid_device *hdev)
 
 int hid_bpf_reconnect(struct hid_device *hdev)
 {
-	if (!test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
+	if (!test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status)) {
+		kfree(hdev->bpf_rdesc);
+		hdev->bpf_rdesc = NULL;
+		hdev->bpf_rsize = 0;
 		return device_reprobe(&hdev->dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 311069588321..a5f5415571cb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -708,6 +708,7 @@ void hiddev_free(struct kref *ref)
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
+	kfree(hid->bpf_rdesc);
 	kfree(hid);
 }
 
@@ -1221,13 +1222,12 @@ int hid_open_report(struct hid_device *device)
 	if (WARN_ON(device->status & HID_STAT_PARSED))
 		return -EBUSY;
 
-	start = device->dev_rdesc;
+	start = device->bpf_rdesc ? device->bpf_rdesc : device->dev_rdesc;
+	size = device->bpf_rsize;
 	if (WARN_ON(!start))
 		return -ENODEV;
-	size = device->dev_rsize;
 
-	/* call_hid_bpf_rdesc_fixup() ensures we work on a copy of rdesc */
-	buf = call_hid_bpf_rdesc_fixup(device, start, &size);
+	buf = kmemdup(start, size, GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
@@ -2659,6 +2659,12 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	const struct hid_device_id *id;
 	int ret;
 
+	if (!hdev->bpf_rsize) {
+		hdev->bpf_rsize = hdev->dev_rsize;
+		hdev->bpf_rdesc = call_hid_bpf_rdesc_fixup(hdev, hdev->dev_rdesc,
+							   &hdev->bpf_rsize);
+	}
+
 	if (!hid_check_device_match(hdev, hdrv, &id))
 		return -ENODEV;
 
@@ -2916,8 +2922,11 @@ static void hid_remove_device(struct hid_device *hdev)
 		hdev->status &= ~HID_STAT_ADDED;
 	}
 	kfree(hdev->dev_rdesc);
+	kfree(hdev->bpf_rdesc);
 	hdev->dev_rdesc = NULL;
+	hdev->bpf_rdesc = NULL;
 	hdev->dev_rsize = 0;
+	hdev->bpf_rsize = 0;
 }
 
 /**
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3a998fa3812d..d41fa18f1e03 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -599,15 +599,17 @@ enum hid_battery_status {
 struct hid_driver;
 struct hid_ll_driver;
 
-struct hid_device {							/* device report descriptor */
-	const __u8 *dev_rdesc;
-	unsigned dev_rsize;
-	const __u8 *rdesc;
-	unsigned rsize;
+struct hid_device {
+	const __u8 *dev_rdesc;						/* device report descriptor */
+	const __u8 *bpf_rdesc;						/* bpf modified report descriptor, if any */
+	const __u8 *rdesc;						/* currently used report descriptor */
+	unsigned int dev_rsize;
+	unsigned int bpf_rsize;
+	unsigned int rsize;
+	unsigned int collection_size;					/* Number of allocated hid_collections */
 	struct hid_collection *collection;				/* List of HID collections */
-	unsigned collection_size;					/* Number of allocated hid_collections */
-	unsigned maxcollection;						/* Number of parsed collections */
-	unsigned maxapplication;					/* Number of applications */
+	unsigned int maxcollection;						/* Number of parsed collections */
+	unsigned int maxapplication;					/* Number of applications */
 	__u16 bus;							/* BUS ID */
 	__u16 group;							/* Report group */
 	__u32 vendor;							/* Vendor ID */
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 6a47223e6460..0290833544c8 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -228,13 +228,8 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
 static inline int hid_bpf_device_init(struct hid_device *hid) { return 0; }
-/*
- * This specialized allocator has to be a macro for its allocations to be
- * accounted separately (to have a separate alloc_tag). The typecast is
- * intentional to enforce typesafety.
- */
-#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size)	\
-		((u8 *)kmemdup(_rdesc, *(_size), GFP_KERNEL))
+static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc,
+					   unsigned int *size) { return NULL; }
 
 #endif /* CONFIG_HID_BPF */
 

-- 
2.46.0


