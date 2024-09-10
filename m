Return-Path: <linux-kselftest+bounces-17596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D61973A60
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0DD282CBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F761A2851;
	Tue, 10 Sep 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaY1qsuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A2199937;
	Tue, 10 Sep 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979448; cv=none; b=oRiKzjWliz1xBMNTQ8bo+6zYs2JXuL5iUMiZpn6g7Hg9lAYvKy+7ahk4I9IfUY64Z4yftIALTgwFH+VUZrT7hf/iuNyY+EpYcDBSTsFiz1240KngGgBu0xHgqD9WheoauVQMaV0tg+cdpRFP3dHu7njDEUGlyDFQzFWmB3qwGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979448; c=relaxed/simple;
	bh=cekMYo1ojSfea+jvGvXqY7LovIV5+3t1/k3FCtBa3rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZkmha6XhcBpm8SjwV0ezzFQgtvcaGJGcXVY6URJcc5MnT2oMfb6fLa5/nSTRImcH+ZUynBB3EXOg7yXeVH6lvfxZ40mSV6mwIe5GoI4udLprzD2RfKtGFyg/W2MwOhgln6u9fwZv99gREAiwSO6YjJXpMnZXRyb3j9QYK8BmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaY1qsuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7510C4CECF;
	Tue, 10 Sep 2024 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979447;
	bh=cekMYo1ojSfea+jvGvXqY7LovIV5+3t1/k3FCtBa3rU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EaY1qsuTfUXevsNMoVjb+DLUymG43u5h51cGmJy+9mCyQi34drzWawR8LrjLYnvJr
	 TBaaF3sjqm0hYz/HnrOTCDa6TZsyhCLQnvruZTFz/diHSwlnLz1iintPE6WILdiOxc
	 JUPIhCyDQfnDPmXWv4cDOZL8njbxOyjeWaVq7IxdeGFIMjcFxi8/TdkXPYVTe+uW0W
	 DHmJ2iU59mpfVLE5Wp0FeVaVYwyRP/j955uhOzcrpo/mrwS+UcBuV9DAY/SImc1I/B
	 1j7DOTi7JmsIVGJKr5X2g6xNvyE6vwiqOSkdBJKnVzSyGBsTQuRPBqlibbseX6W8Xt
	 cDFNZqoQMUmOA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:44 +0900
Subject: [PATCH HID v2 08/11] HID: add per device quirk to force bind to
 hid-generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-8-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=2708;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cekMYo1ojSfea+jvGvXqY7LovIV5+3t1/k3FCtBa3rU=;
 b=5P1N3bSR8ds90Ae+puqheLFiVErJaoZEHQBC9qRZvGVrSKlWqGvfvWLBO/ctgSRVqV6k7QRLV
 qMiW1a3SG0BCCUdN/GNi+XXXXLHh2ELjfGJ70wzyDYvgzearsZiVCMN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We already have the possibility to force not binding to hid-generic and
rely on a dedicated driver, but we couldn't do the other way around.

This is useful for BPF programs where we are fixing the report descriptor
and the events, but want to avoid a specialized driver to come after BPF
which would unwind everything that is done there.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- rely on hdev->quirks for that instead of a new struct for hid_driver
---
 drivers/hid/hid-core.c    | 5 +++--
 drivers/hid/hid-generic.c | 3 +++
 include/linux/hid.h       | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 37e52759a931..bf63e2819baf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2665,9 +2665,10 @@ static bool hid_check_device_match(struct hid_device *hdev,
 	/*
 	 * hid-generic implements .match(), so we must be dealing with a
 	 * different HID driver here, and can simply check if
-	 * hid_ignore_special_drivers is set or not.
+	 * hid_ignore_special_drivers or HID_QUIRK_IGNORE_SPECIAL_DRIVER
+	 * are set or not.
 	 */
-	return !hid_ignore_special_drivers;
+	return !hid_ignore_special_drivers && !(hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER);
 }
 
 static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index f9db991d3c5a..88882c1bfffe 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -40,6 +40,9 @@ static bool hid_generic_match(struct hid_device *hdev,
 	if (ignore_special_driver)
 		return true;
 
+	if (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
+		return true;
+
 	if (hdev->quirks & HID_QUIRK_HAVE_SPECIAL_DRIVER)
 		return false;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index d41fa18f1e03..b3a9586363c9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -359,6 +359,7 @@ struct hid_item {
  * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
  * | @HID_QUIRK_HAVE_SPECIAL_DRIVER:
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
+ * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -384,6 +385,7 @@ struct hid_item {
 #define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
 #define HID_QUIRK_NOINVERT			BIT(21)
+#define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)

-- 
2.46.0


