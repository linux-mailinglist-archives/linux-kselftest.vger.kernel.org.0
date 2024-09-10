Return-Path: <linux-kselftest+bounces-17591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FD973A48
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69BB1C24C5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711119DF85;
	Tue, 10 Sep 2024 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONK6tnE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D719ABAB;
	Tue, 10 Sep 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979436; cv=none; b=t/qWAgPtahClTxpBPDn70TgtmRgzwNfnrpTnUG3ktInh7W7aeMLT9phzbNpsMT2CSdmbUzLF/K8pVMjj6rzGvRyoKHF+DwJWoTkiezpOwTuJBnm74iUfAclh/aPcX4FOB1jfrzRjbEPf59hbZz1Y8/3wjgir4ypEzNot309nCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979436; c=relaxed/simple;
	bh=8ktPfzBt6ih236F5v0U2BPIw8M4SjLXm76j3JdVJj8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z15ooOlKrl9j2RtFshu8SgVBvMhEDam7oTtordfsSDyR3tgH2MdETnJZtcHX4smAEGZfmbMDe6kyBOWRLL+2D8RR0anJVCuog4eVgRm4JPHmeIOURUnPOygyCq/v1NxWborsYBbrCKJF/XPSrkElGQwTxqagWFt7h5PkcK+rx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONK6tnE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB431C4CED0;
	Tue, 10 Sep 2024 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979436;
	bh=8ktPfzBt6ih236F5v0U2BPIw8M4SjLXm76j3JdVJj8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ONK6tnE8nqgbJIU2yJ5xJbPAkSq1Wtim7WQn4Eks/QBzEyGuSkXqjrBqxkZH1gNqr
	 2hfNs0ZABZl9eK4o0Uazikq3iEc7oSZ61z37wEjy+9U5C9Qya9J/CskVVrKN5D9Lct
	 0yG1j7WsbV7mQbdjPQg4AYK+oNOwAiKzd0YlZwiAfHlqFDQH4TWOY+dhnEOQXID8yr
	 2Out4bg8r7bCUvw8YA7M32mVOGvruI4Lf2Vd4fhphnfNM3NKETj9MfzfLJ5AVaxuJa
	 Jo3Y50QdHYtWCtG3UTkVZF/8yiRHjC87YG7z0Lg+VnyyImEq9OknySrQkOGfA1ifgq
	 pEYrLLAOtBQCg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:39 +0900
Subject: [PATCH HID v2 03/11] HID: core: remove one more kmemdup on
 .probe()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-3-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=2284;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8ktPfzBt6ih236F5v0U2BPIw8M4SjLXm76j3JdVJj8M=;
 b=zXJ1whlSNOnhHWGHdrRFTCSgVa1H7tFvYXlnGwJ1z+gWdtW5BeQMnAr8dm3L21tdJjrtVMNpQ
 a1sV3MgyzGICy+rElYyIhvYUjZbBRr2SpdwmSh7Uu+VvuDdrtvC9AVK
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

That last kmemdup while opening the report descriptor was required to
have a common kfree() on it.

Move that kmemdup in the only special case it's required (if there is a
.report_fixup()), and add a more elaborated check before freeing
hdev->rdesc, to avoid a double free.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/hid-core.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 172746a082f9..2b70a12a2135 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -685,7 +685,14 @@ static void hid_close_report(struct hid_device *device)
 		INIT_LIST_HEAD(&report_enum->report_list);
 	}
 
-	kfree(device->rdesc);
+	/*
+	 * If the HID driver had a rdesc_fixup() callback, dev->rdesc
+	 * will be allocated by hid-core and needs to be freed.
+	 * Otherwise, it is either equal to dev_rdesc or bpf_rdesc, in
+	 * which cases it'll be freed later on device removal or destroy.
+	 */
+	if (device->rdesc != device->dev_rdesc && device->rdesc != device->bpf_rdesc)
+		kfree(device->rdesc);
 	device->rdesc = NULL;
 	device->rsize = 0;
 
@@ -1206,7 +1213,6 @@ int hid_open_report(struct hid_device *device)
 	struct hid_item item;
 	unsigned int size;
 	const __u8 *start;
-	__u8 *buf = NULL;
 	const __u8 *end;
 	const __u8 *next;
 	int ret;
@@ -1233,17 +1239,23 @@ int hid_open_report(struct hid_device *device)
 		 * on a copy of our report descriptor so it can
 		 * change it.
 		 */
-		buf = kmemdup(start, size, GFP_KERNEL);
+		__u8 *buf = kmemdup(start, size, GFP_KERNEL);
+
 		if (buf == NULL)
 			return -ENOMEM;
 
 		start = device->driver->report_fixup(device, buf, &size);
-	}
 
-	start = kmemdup(start, size, GFP_KERNEL);
-	kfree(buf);
-	if (start == NULL)
-		return -ENOMEM;
+		/*
+		 * The second kmemdup is required in case report_fixup() returns
+		 * a static read-only memory, but we have no idea if that memory
+		 * needs to be cleaned up or not at the end.
+		 */
+		start = kmemdup(start, size, GFP_KERNEL);
+		kfree(buf);
+		if (start == NULL)
+			return -ENOMEM;
+	}
 
 	device->rdesc = start;
 	device->rsize = size;

-- 
2.46.0


