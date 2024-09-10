Return-Path: <linux-kselftest+bounces-17598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF200973A69
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7984E1F2333B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5D1A38D6;
	Tue, 10 Sep 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/KI7iwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3841A38CF;
	Tue, 10 Sep 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979452; cv=none; b=I7ZO25FzCJ+t6piaju/QcBCZFzND4YuKgSYW5k9RSjz9AV+n/aiYW+KOeVPe4i/Seay19rJEiGB1vw+5CSC4yuC7syV5mS3D71AjqK34+SzYvx2LzJjausSEjGf753SOGdA3JBkY9qrjtIzxcdX7ouHve3J+ApbasWh2dCHi9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979452; c=relaxed/simple;
	bh=9dyQnVWhgspQ6LB9IUnWrlJkGheZruF2s/Ba5yr7S1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=US+H/cwi52qWta8UzacEDXCwBIldNDxzeE0x464bvitCS1kdYJeDLpxdLuqUKiljJNoOpElIfurlvTC5QMxaZmiO/a5F2NDvAEotxrjU0liMj5xXcftndtnKnBzKdRSEN4eE7Ti97HleDmr2PEqc2pudPFHHgtOi4ZoTXWSN8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/KI7iwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1302BC4CEC3;
	Tue, 10 Sep 2024 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979451;
	bh=9dyQnVWhgspQ6LB9IUnWrlJkGheZruF2s/Ba5yr7S1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d/KI7iwAD7NGTrhWlbp1VbZQwLj3yYaTsJt4cDG1p8t4yfyxRiBqMSmFbjfLSbIdn
	 N7QkDYNkP1D4tbToGK8cxVraZ3PTsRvY28yi/9BshIeqOZvhoqMhy9SUB1rwI1PKOx
	 e+eZN9xO4gDpJg7NA3tpyl5E48ph+J5d6buz2jal/IW6x//fWc0HBbCw0pKrfK9hFt
	 DTofOiYwpiMp9zKndTDcCbM05cmsPfU6QM9KmPwX4F27PQDy3uiC2T+wLWc94PsM/l
	 WvD7GNFYGcXMwgXG19OHoYmvQbJbHc605w5NgbQKLkY7dOM3feD2pBUz6x9hk7cAeu
	 dH/4Pj1tols5w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:46 +0900
Subject: [PATCH HID v2 10/11] HID: add quirk to prevent hid-input to be
 used
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-10-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=2228;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9dyQnVWhgspQ6LB9IUnWrlJkGheZruF2s/Ba5yr7S1s=;
 b=gY6clRpXriioBX5njKmURCqoN1D1JzNxSjAENynzdjftIEW+qaTluKr1VV4vMaUjSnKscL7XC
 HnDDG6V28PzAOm2zcyVf4G/xCCkasJySvjvzxTV/vH7HNTyZtFvSziw
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is useful when you want to handle the device entirely from BPF
without exposing the automatic input nodes.

This is useful in case we want to have a third party program that directly
talks to the hidraw node and we don't want regular input events to be
emitted. This third party program can load a BPF program that instructs
hid-generic to rebind on the device with hidraw only and then open the
hidraw node itself.

When the application is closed, the BPF program is unloaded and the normal
driver takes back the control of the device.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- rely on hdev->quirks instead of a new struct
---
 drivers/hid/hid-core.c | 2 ++
 include/linux/hid.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bf63e2819baf..35cefd7167aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2217,6 +2217,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		connect_mask |= (HID_CONNECT_HIDDEV_FORCE | HID_CONNECT_HIDDEV);
 	if (hdev->quirks & HID_QUIRK_HIDINPUT_FORCE)
 		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
+	if (hdev->quirks & HID_QUIRK_IGNORE_HIDINPUT)
+		connect_mask &= ~HID_CONNECT_HIDINPUT;
 	if (hdev->bus != BUS_USB)
 		connect_mask &= ~HID_CONNECT_HIDDEV;
 	if (hid_hiddev(hdev))
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b3a9586363c9..b6bad03649f6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -360,6 +360,7 @@ struct hid_item {
  * | @HID_QUIRK_HAVE_SPECIAL_DRIVER:
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
  * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
+ * | @HID_QUIRK_IGNORE_HIDINPUT
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -386,6 +387,7 @@ struct hid_item {
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
 #define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
+#define HID_QUIRK_IGNORE_HIDINPUT		BIT(23)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)

-- 
2.46.0


