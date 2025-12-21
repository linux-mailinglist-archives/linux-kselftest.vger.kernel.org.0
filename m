Return-Path: <linux-kselftest+bounces-47811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF768CD4768
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F733004421
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F131ED8D;
	Sun, 21 Dec 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUepClYs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA13306489;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360623; cv=none; b=BnQ7X9K3c5H+8/TNYAMZoXpvKSHOmUjVcGbw/825042O6KQlCwOhfU45A/Lo1jEBoFvR61SiwQUlM3nqUvAVsQDNojJt1RzRksa72HpQ2+W9dT6T/cOPKxciFc8Mx0XIq58ZZEKApxkz42v9sN4Vb9FaakXmzOM10M6Y91UYEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360623; c=relaxed/simple;
	bh=JtcYQIhQiysygEFTNPNuZGpUQYPoGdM3Vu5VA2utTM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSrdIlvqOi+4ldBLTk4QeXvioWhy9YD96rn54WAm/uiSwrftWHuzR9seJVG/xGCTZ7UPlqlU1rXzwV8k72bAqXzdouxwccU3s/6Yp16PqoKp9cX5/gocCuheKrTHHu7rlarord6GXKeNxCdTz5E0RA89aR9352FJXjsmTuhU8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUepClYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1959C16AAE;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766360622;
	bh=JtcYQIhQiysygEFTNPNuZGpUQYPoGdM3Vu5VA2utTM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WUepClYskE0RIyLlU770AppBvd1jPvz2Zd+t8LqIUez+d3kJJS/QczIhZWjt6DVoB
	 wgfQWkrRdWlCR2imzJ0/P9TmmTmla/KyVKVS10QjGzR6YZTgtAXhutAgsivy2bVxX8
	 HZRETIMMfW6QURpZNVr9v50xxmJCJjFuxRZhY2mGFxUweU/84IU/P6ivBFxB/qCqAH
	 OQIFoeAnrOp93OJIqqBD9t2tfzoDaNBSXmexWLGCFSmiYB4JxzrWsXnQoSO8iLH96h
	 MFLqp5MXLxeYUjc3urzDXu+p+Rr9vRMAn79NdtJtboPf+zmR62dRDUUud/9nF/bY2r
	 /JJbDlr5oH2IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91533E66886;
	Sun, 21 Dec 2025 23:43:42 +0000 (UTC)
From: Peter Hutterer via B4 Relay <devnull+peter.hutterer.who-t.net@kernel.org>
Date: Mon, 22 Dec 2025 09:43:34 +1000
Subject: [PATCH v2 1/4] HID: multitouch: set INPUT_PROP_PRESSUREPAD based
 on Digitizer/Button Type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-wip-hid-pressurepad-v2-1-054ac9689bb7@who-t.net>
References: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
In-Reply-To: <20251222-wip-hid-pressurepad-v2-0-054ac9689bb7@who-t.net>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>, 
 Peter Hutterer <peter.hutterer@who-t.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766360621; l=2040;
 i=peter.hutterer@who-t.net; s=20251222; h=from:subject:message-id;
 bh=dMjDzKSeawsZaA/hN50AyJBSpCTU67tb7j/TTV1AREQ=;
 b=BTVFx0y3GbBgjF0Ne37a5wMKd6c7q0RVpqzBIyXM+0p+CNu1JARK3+Rtta4OVHxmwlR8oJxaZ
 /H7N8K9RNhOA3LEZPn23PoXieS5b9kMwB+MtobwchLj8i2Ud6YWxExS
X-Developer-Key: i=peter.hutterer@who-t.net; a=ed25519;
 pk=QoL66HDbFudb9Xt36p2XxsSohZSHVHesRR9c0pI28a4=
X-Endpoint-Received: by B4 Relay for peter.hutterer@who-t.net/20251222 with
 auth_id=582
X-Original-From: Peter Hutterer <peter.hutterer@who-t.net>
Reply-To: peter.hutterer@who-t.net

From: Peter Hutterer <peter.hutterer@who-t.net>

A Digitizer/Button Type value of 1 indicates the device is a
pressurepad, see
https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-multitouch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 179dc316b4b518d78bdc900d9fd15756c5eba83e..382e6f50c4f7e663af7d028abb8be7cb2e6e7b8e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -81,6 +81,7 @@ MODULE_LICENSE("GPL");
 #define MT_INPUTMODE_TOUCHPAD		0x03
 
 #define MT_BUTTONTYPE_CLICKPAD		0
+#define MT_BUTTONTYPE_PRESSUREPAD	1
 
 enum latency_mode {
 	HID_LATENCY_NORMAL = 0,
@@ -179,6 +180,7 @@ struct mt_device {
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
+	bool is_pressurepad;	/* is this device a pressurepad? */
 	bool is_haptic_touchpad;	/* is this device a haptic touchpad? */
 	bool serial_maybe;	/* need to check for serial protocol */
 
@@ -530,8 +532,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		}
 
 		mt_get_feature(hdev, field->report);
-		if (field->value[usage->usage_index] == MT_BUTTONTYPE_CLICKPAD)
+		switch (field->value[usage->usage_index]) {
+		case MT_BUTTONTYPE_CLICKPAD:
 			td->is_buttonpad = true;
+			break;
+		case MT_BUTTONTYPE_PRESSUREPAD:
+			td->is_pressurepad = true;
+			break;
+		}
 
 		break;
 	case 0xff0000c5:
@@ -1393,6 +1401,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	if (td->is_pressurepad)
+		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 
 	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
 					       BITS_TO_LONGS(td->maxcontacts),

-- 
2.51.1



