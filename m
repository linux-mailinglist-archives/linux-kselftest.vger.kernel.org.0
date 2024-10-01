Return-Path: <linux-kselftest+bounces-18746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D998BFFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45751284D6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179E1C9B76;
	Tue,  1 Oct 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD9heVYL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB91C9B67;
	Tue,  1 Oct 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793040; cv=none; b=KnzOQt1cBN82xuhNqGNMird+5wggnaoPMU5innsXAAnHM5I5Keq7OFR0NymPGsuKK0WB/bB5dIFZOVOWhtRJAXCpqA8Pdp/65C5JdySb8skaUipGnWSv46Pb9JeiYaZ1Wdud9dxxW3koySS+KixD96b6agB7imSAqXFpSC6NW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793040; c=relaxed/simple;
	bh=BHYSNYgX8pUz6K6rRtEk1le3e4BVn69IDcbXBU2DJJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmUvVgXho1W2SSlxLNs41XfUiiP/qLNxJ/PWiI65tqBFrYgq7N2oQWzcwlp4ZoTh90cmHC6ZmZ2kdYM0Ao8/VCwTgtUv83lbOEg6kIDa4DS+PHZJ6dW61QrgxDvzDy/ZcCwBgaSZ4iGxs+hcJMVzBNt5huVbB3yOlLoiRqsUs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD9heVYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673EEC4CEC6;
	Tue,  1 Oct 2024 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793040;
	bh=BHYSNYgX8pUz6K6rRtEk1le3e4BVn69IDcbXBU2DJJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rD9heVYLaZQZy4Xq0uK86Yqz+VV103/W+Xa1Pf/9/uID9IJFIic0tuilgmwvKjhMW
	 iS86Z91ndcBLoiGscaJdW6CU0bZbvPgAHfN4V5kvifrVedMoQOsfXSiP03qcNCio4w
	 OkxyssvqDW9K9me9exE0lZhd0anMCf1BfBWpscAVVZiu9tnU2RGQKVey8+83+tb77u
	 wl32pqTGEusPbUdOQaJR5wR2BZ9YrqJPJgIxWxfpyRWNwhEFUtlHPAiTgBXdYnbu9T
	 Rk5Dp1dOgzQwQ6a+OxIXOQpiDWwmMEwJPiqv5VwJvlXAMC4+UVhWUs/yHAR+7TUyDK
	 sQMcguAxTxJhw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 01 Oct 2024 16:30:07 +0200
Subject: [PATCH HID v3 3/9] HID: core: remove one more kmemdup on .probe()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-hid-bpf-hid-generic-v3-3-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=2360;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=BHYSNYgX8pUz6K6rRtEk1le3e4BVn69IDcbXBU2DJJY=;
 b=QWtTy0ip2hP71iFIlzFP0MnqdWgsoM2e25eP8ptwlw17BMh9v1oszbPJEAoUfrQWcVsMQnXMQ
 z/HlwW1fgcGCi15vFJkJf3tv379gjDJQFslnXEKidpDxos3I7scZwv+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

That last kmemdup while opening the report descriptor was required to
have a common kfree() on it.

Move that kmemdup in the only special case it's required (if there is a
.report_fixup()), and add a more elaborated check before freeing
hdev->rdesc, to avoid a double free.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

new in v2
---
 drivers/hid/hid-core.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6053e7cdc0c1..b0a22e173502 100644
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
 
@@ -1214,7 +1221,6 @@ int hid_open_report(struct hid_device *device)
 	struct hid_item item;
 	unsigned int size;
 	const __u8 *start;
-	__u8 *buf = NULL;
 	const __u8 *end;
 	const __u8 *next;
 	int ret;
@@ -1241,17 +1247,23 @@ int hid_open_report(struct hid_device *device)
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


