Return-Path: <linux-kselftest+bounces-18745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7699B98BFF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C042848DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8C1C8FBC;
	Tue,  1 Oct 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1MDH09W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB351C7B8A;
	Tue,  1 Oct 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793038; cv=none; b=Mmol2U3sExdO3iizSZFa7e4QY11p48LiT3nHbhzogzA81mLtsEJfDoYEjbuYScPLovagLzPzgXYr1q/9NW6jPy6yUm1Bw/dnDit5xGQK8eoi//mcE7vt9TYDuPfb6nYqWMbBlGuUcYVIbD8Fqce0vVE4Zjaa2zGBbQzKW7ochl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793038; c=relaxed/simple;
	bh=BJURDqA+9kHR/SvAohPi0bq69sWfM74Vsjzf6VM/9sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5hhdGijmvpVyY77RGD2vV52Q+8u8jBjYhkurZ9G088PWN3DeRvPRLj4jCdfshJ8ZCFCqEejbRJgrIE11O1hoeu1UgUUWU2NsLsSYLTKsGi07+puRqyFT9ao/RR9nhKtkgp+gKyhmbh7LylkqBk6+7HTz3ju82/2+R1+vcm1a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1MDH09W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58226C4CECD;
	Tue,  1 Oct 2024 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793038;
	bh=BJURDqA+9kHR/SvAohPi0bq69sWfM74Vsjzf6VM/9sE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S1MDH09W+yroNIfEXQgVJA3ZxAFjz6D8vKLFb+4bMkZzIB4gyr8iDlSdsbqTi6cHx
	 lCTlcuYo1kE6KsbnooUwHaByIBKBN12LqEs5Org7FAMy6B2nbixlbGQR7rctNSm17L
	 K8jBtU0sIpUMcbH06jCaktEGpKH31OXP9noF5LPBJns95bSq6d23GebE8Y3DryPBYu
	 jLe60UIzIojF5h/fhA54MEuzKTWWiwuFpoLqCpwvzwMO0htfAF8ldDQf4GVng9dGH3
	 DaifR5p/uBWIOw1qiT5YEHpg7HX7uD/gYuK4FeYbhuSX+Al/GsXDgkvnYkj3hz6oAN
	 7nhQNHb9lQdww==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 01 Oct 2024 16:30:06 +0200
Subject: [PATCH HID v3 2/9] HID: core: save one kmemdup during .probe()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-hid-bpf-hid-generic-v3-2-2ef1019468df@kernel.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727793031; l=1505;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=BJURDqA+9kHR/SvAohPi0bq69sWfM74Vsjzf6VM/9sE=;
 b=CiFVQJkbMggNbRUHg6yY8sUusPU1QwO4QmSysy/mqGhUviqifJNXwDanOdtL1+/wMJIRBCfIu
 eg53Lj4ZDuIDLK+p9jkBwXN3gVDrTQanaqVq7DaaZk3zjuivbWcMicD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out the first kmemdup is only required for the .report_fixup()
driver callback. There is no need to do two kmemdup() in a row in case
.report_fixup() is not present.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

new in v2
---
 drivers/hid/hid-core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d6bf933623e8..6053e7cdc0c1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1214,7 +1214,7 @@ int hid_open_report(struct hid_device *device)
 	struct hid_item item;
 	unsigned int size;
 	const __u8 *start;
-	__u8 *buf;
+	__u8 *buf = NULL;
 	const __u8 *end;
 	const __u8 *next;
 	int ret;
@@ -1235,14 +1235,18 @@ int hid_open_report(struct hid_device *device)
 		return -ENODEV;
 	size = device->bpf_rsize;
 
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


