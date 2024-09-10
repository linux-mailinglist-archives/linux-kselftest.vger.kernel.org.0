Return-Path: <linux-kselftest+bounces-17590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB31973A41
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D643F1F213CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B819ABC4;
	Tue, 10 Sep 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbIswF3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28119ABB6;
	Tue, 10 Sep 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979435; cv=none; b=VxLQiZWwM6+eeeFEWsUdIkvoFUP3DHB6lpUvL0Z6Gte3C/SNHRmmUGWrsnx8dKkByED0lViv3qC1yoC1MDf1ihxA/+ByMESFPue+LJmjD2dC1/xs7rcdynT3bLzkNZB3O8elgZpkSRDHf1ZDmiVrjpis3IA+RbiaRZIXKxRL0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979435; c=relaxed/simple;
	bh=8Rv7wHGS5vnx8vrFXpuXccJrUODHQOZZwz7abDTtL1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c02/3cCjwVDH40qGeXoDqBVXykhKyH2qqSIq+t2Z2FYIxV17h4oNrsv44mZjJionjNWWz+nHIhz/xE3l7VkWlBrfpNsODGp99APGw5XWawnIaBsC6cnscGk/k98hwrQEHcum8Il7ncwA5f2YemwX87IwCWPymyT5Hn/M3c5LtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbIswF3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA90DC4CECD;
	Tue, 10 Sep 2024 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979434;
	bh=8Rv7wHGS5vnx8vrFXpuXccJrUODHQOZZwz7abDTtL1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nbIswF3RwCl57bL6Bt07Dr2YJ3pPLFxXZxMdp8Lpb837Z5XKNgOQz1sebIUyi2rl2
	 2zRfXVRZID+X7LerA3Pc9uXmD3tJsjnzJyBeJ/rhJx1jH1F3udgF+Cv0Kf9tbOAfKR
	 hsABs1tKRvBoot+IU/Hut3n4uM3E0hpwvhlV8Jw4vdhyM0vVQHsVJ1TFl0vE8mxDSt
	 9r6W07Fk4W8LgtawXyf2VNCwZkybzOzXacYurNwaR/WtJ21XJSUqTDBY7fThTIqfWa
	 8tMsylbEMPtW2nnoDVaXqn94Ri57TN1g6BDjv/Dg46/jcWaxzdfLPXkdBpyVk2c4AU
	 SFdVf8iJARZ4w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:38 +0900
Subject: [PATCH HID v2 02/11] HID: core: save one kmemdup during .probe()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-2-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=1424;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8Rv7wHGS5vnx8vrFXpuXccJrUODHQOZZwz7abDTtL1w=;
 b=h9Sdeen8uG5RlGASV0hN9wRWgXmQw8z5HNVcL/zvvgetMiG/cvF2VjrPn/OV33cwj7x4qSVpe
 HodTtFpOazUDtxOcJTY+fv4sk6EqXgYPtBw8MSYWn4AVhy/laVKnexJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out the first kmemdup is only required for the .report_fixup()
driver callback. There is no need to do two kmemdup() in a raw in case
.report_fixup() is not present.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 drivers/hid/hid-core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5f5415571cb..172746a082f9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1206,7 +1206,7 @@ int hid_open_report(struct hid_device *device)
 	struct hid_item item;
 	unsigned int size;
 	const __u8 *start;
-	__u8 *buf;
+	__u8 *buf = NULL;
 	const __u8 *end;
 	const __u8 *next;
 	int ret;
@@ -1227,14 +1227,18 @@ int hid_open_report(struct hid_device *device)
 	if (WARN_ON(!start))
 		return -ENODEV;
 
-	buf = kmemdup(start, size, GFP_KERNEL);
-	if (buf == NULL)
-		return -ENOMEM;
+	if (device->driver->report_fixup) {
+		/*
+		 * device->driver->report_fixup() needs to work
+		 * on a copy of our report descriptor so it can
+		 * change it.
+		 */
+		buf = kmemdup(start, size, GFP_KERNEL);
+		if (buf == NULL)
+			return -ENOMEM;
 
-	if (device->driver->report_fixup)
 		start = device->driver->report_fixup(device, buf, &size);
-	else
-		start = buf;
+	}
 
 	start = kmemdup(start, size, GFP_KERNEL);
 	kfree(buf);

-- 
2.46.0


