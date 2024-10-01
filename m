Return-Path: <linux-kselftest+bounces-18744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9898BFF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53C61F26DD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DD1C7B97;
	Tue,  1 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYaYFoxF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C71C6F7E;
	Tue,  1 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793036; cv=none; b=qwC9hfEcgrn2Tt7qtsLHy9IkjFaYvcqaH7TwrKg2J1BX/tzGyLsoWjETfRUvVND8wl6kp5rQ1B1y5KVtrJHm2dskVrqBZttHut5EADa/0VxPJqHCt1YPcXn4t10N8R1fbzEpN+MH/tehF0DbmatgHEUPHcfjnK0AD7q1Wixyyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793036; c=relaxed/simple;
	bh=quTeQfcYupJVJt0hX7vqPPMZokG65wuGpHlzqqZgOW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3IQPohPOZ5V1Ch4asngyKDfwBmS2mDgCnHNTZRrrTt7Pl+zfnSdDCYGfy5ezcqncUXwZyvonRCeUkzodtGKg4Z+Bkdb7vnhEBBkVH73N/H5xsW/g0sE7XGoCLeUqeRkBdr2CgNANfeRFVbockyw6CeQbDycN5NdZr7Xrrnj7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYaYFoxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4987DC4CED2;
	Tue,  1 Oct 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793035;
	bh=quTeQfcYupJVJt0hX7vqPPMZokG65wuGpHlzqqZgOW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IYaYFoxFDT1SgtLQY1IoK0i+/wOygB+q/Zbuy92PqjRDDaDOGpf0Tg7LYV/HZZLVB
	 C3NBOFG9obbyFDMAcri0dKMjTGtoVA+P2PFLxVQM/9MoaRN3xB6SXDEmwCGXn9k9/E
	 Qt0CS8jqYRLO73ZVEBxG8ycKYBPdnAa2eiAkJ5A3fDng49Qieq5qbxOVsBXAaEDvnM
	 lpUhWpSkNXIDMrOJm0oh6S2DEfWKxp0Aft7bnImCwVGqPzghggnXIU+q85KF54K70I
	 JGlm8ar0+4iI8+Q2ujlWK+8AEN5ZOQOER/N5SiEKoWspLk4KAjS4zxDtcdFvNiuAoW
	 JoSQdHbHd5EsQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 01 Oct 2024 16:30:05 +0200
Subject: [PATCH HID v3 1/9] HID: bpf: move HID-BPF report descriptor fixup
 earlier
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-hid-bpf-hid-generic-v3-1-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=9574;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=quTeQfcYupJVJt0hX7vqPPMZokG65wuGpHlzqqZgOW4=;
 b=V1h1PsFSdpnz9PJcT3JY2c5XKoJgEi+XDDL2BCycuNNgDhf7i05pa4whMyCxBR2Rd7a64bezo
 uO0vQcPLUrOD0btG83padhuww+jR+4mhS7BtrM+zVbNoOapCcVS3arY
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
result of HID-BPF fixup in struct hid_device. Basically, this means that
->bpf_rdesc can replace ->dev_rdesc when it was used in the code.

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

changes in v3:
- consider ->bpf_rdesc the new ->dev_rdesc to simplify the logic
- add a new inline hid_free_bpf_rdesc() to ensure we don't double free
  ->dev_rdesc

new in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c |  9 ++++++---
 drivers/hid/hid-core.c             | 30 ++++++++++++++++++++++++++----
 include/linux/hid.h                | 18 ++++++++++--------
 include/linux/hid_bpf.h            | 11 +++--------
 4 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 8420c227e21b..961b7f35aa67 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -148,7 +148,7 @@ int dispatch_hid_bpf_output_report(struct hid_device *hdev,
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_output_report);
 
-u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size)
+const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size)
 {
 	int ret;
 	struct hid_bpf_ctx_kern ctx_kern = {
@@ -183,7 +183,7 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned
 
  ignore_bpf:
 	kfree(ctx_kern.data);
-	return kmemdup(rdesc, *size, GFP_KERNEL);
+	return rdesc;
 }
 EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
 
@@ -260,8 +260,11 @@ int hid_bpf_allocate_event_data(struct hid_device *hdev)
 
 int hid_bpf_reconnect(struct hid_device *hdev)
 {
-	if (!test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
+	if (!test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status)) {
+		/* trigger call to call_hid_bpf_rdesc_fixup() during the next probe */
+		hdev->bpf_rsize = 0;
 		return device_reprobe(&hdev->dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 30de92d0bf0f..d6bf933623e8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -698,6 +698,14 @@ static void hid_close_report(struct hid_device *device)
 	device->status &= ~HID_STAT_PARSED;
 }
 
+static inline void hid_free_bpf_rdesc(struct hid_device *hdev)
+{
+	/* bpf_rdesc is either equal to dev_rdesc or allocated by call_hid_bpf_rdesc_fixup() */
+	if (hdev->bpf_rdesc != hdev->dev_rdesc)
+		kfree(hdev->bpf_rdesc);
+	hdev->bpf_rdesc = NULL;
+}
+
 /*
  * Free a device structure, all reports, and all fields.
  */
@@ -707,6 +715,7 @@ void hiddev_free(struct kref *ref)
 	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
+	hid_free_bpf_rdesc(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
@@ -1221,13 +1230,12 @@ int hid_open_report(struct hid_device *device)
 	if (WARN_ON(device->status & HID_STAT_PARSED))
 		return -EBUSY;
 
-	start = device->dev_rdesc;
+	start = device->bpf_rdesc;
 	if (WARN_ON(!start))
 		return -ENODEV;
-	size = device->dev_rsize;
+	size = device->bpf_rsize;
 
-	/* call_hid_bpf_rdesc_fixup() ensures we work on a copy of rdesc */
-	buf = call_hid_bpf_rdesc_fixup(device, start, &size);
+	buf = kmemdup(start, size, GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
@@ -2684,6 +2692,18 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	const struct hid_device_id *id;
 	int ret;
 
+	if (!hdev->bpf_rsize) {
+		/* in case a bpf program gets detached, we need to free the old one */
+		hid_free_bpf_rdesc(hdev);
+
+		/* keep this around so we know we called it once */
+		hdev->bpf_rsize = hdev->dev_rsize;
+
+		/* call_hid_bpf_rdesc_fixup will always return a valid pointer */
+		hdev->bpf_rdesc = call_hid_bpf_rdesc_fixup(hdev, hdev->dev_rdesc,
+							   &hdev->bpf_rsize);
+	}
+
 	if (!hid_check_device_match(hdev, hdrv, &id))
 		return -ENODEV;
 
@@ -2940,9 +2960,11 @@ static void hid_remove_device(struct hid_device *hdev)
 		hid_debug_unregister(hdev);
 		hdev->status &= ~HID_STAT_ADDED;
 	}
+	hid_free_bpf_rdesc(hdev);
 	kfree(hdev->dev_rdesc);
 	hdev->dev_rdesc = NULL;
 	hdev->dev_rsize = 0;
+	hdev->bpf_rsize = 0;
 }
 
 /**
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 121d5b8bc867..ff58b5ceb62e 100644
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
index 6a47223e6460..a6876ab29004 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -212,7 +212,7 @@ int hid_bpf_connect_device(struct hid_device *hdev);
 void hid_bpf_disconnect_device(struct hid_device *hdev);
 void hid_bpf_destroy_device(struct hid_device *hid);
 int hid_bpf_device_init(struct hid_device *hid);
-u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size);
+const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
 						u8 *data, u32 *size, int interrupt,
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
+static inline const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc,
+						 unsigned int *size) { return rdesc; }
 
 #endif /* CONFIG_HID_BPF */
 

-- 
2.46.0


