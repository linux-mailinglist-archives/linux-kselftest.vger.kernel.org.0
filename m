Return-Path: <linux-kselftest+bounces-42878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8980BC5623
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162AD3E48FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F78C296BDE;
	Wed,  8 Oct 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG+EKJMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64328B407;
	Wed,  8 Oct 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932432; cv=none; b=DdleXJuMs+MRN7yta2XNy1szjBKaKhJLSIQDCAcIpecCsxlJ69XnaGJu3HUEm064mfKNoPhj4fGjfTBhe4QF5QytUwbP4aqNHaDQnA43M9AjI4INZXnErfzslUZuKPN4x2UT93vMZ8bCLBqqZSN16KI6hePOFisHyg4h69NBKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932432; c=relaxed/simple;
	bh=8/6WonwVUK28ZDpzUjC7vuBo+6VbQAZcnla9obkGu5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0BY0dlq0K7x0ZhV9dYi23bI75z/GcaVsG47MopRNayDMFCAJ20HXl/hZxBapX8CAxZfVnDj88nUbCbssJLTqPflu3K0S9q41eHjnmHMMd4t0LGrNLKinAkADbR9u9mt+IkzXS62X3Its9dQs0hixxbXXrMXgOW7f23NUdgb1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG+EKJMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19051C4CEFF;
	Wed,  8 Oct 2025 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932431;
	bh=8/6WonwVUK28ZDpzUjC7vuBo+6VbQAZcnla9obkGu5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hG+EKJMjAGZw0DovquxOGJBOg9Q0kXIAl0YDQldqJrlgA7ydTqEGFoe83sF6qI2wP
	 gK07NhReYcnYPK3foD9tVU4jx6BUdWupO1Bl/DcMJpZVDQWgGGsGqEsxhj8E/XmfOs
	 L8E/jC4stEBOCPXcYDFtQb2NM9B52UIfELAKwn2SquWj2xWX8U1LeCkv/xoVb+tBpU
	 eJZUN1e5Fya6nAs8nAykrosoirHtuzj7IZqOv8wnSPuh1Mv6VqB+avRv/OPkFFQb97
	 koWovfgTA4AfmxQE5goJ7j5mp6e5XR7Ej64/H9PHmEZFfD4pBsQUjxL5v90VDN7bna
	 VZ0+RY9j8jRQg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 Oct 2025 16:06:58 +0200
Subject: [PATCH 1/2] HID: multitouch: fix sticky fingers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-fix-sticky-fingers-v1-1-760f1f26fce3@kernel.org>
References: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
In-Reply-To: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759932427; l=4325;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8/6WonwVUK28ZDpzUjC7vuBo+6VbQAZcnla9obkGu5s=;
 b=GhMjybiqnJlkmfjF6TNlMyBlxCF8o8lWhA6oHJUZyLPJbvQ7mR6TlyYI3fcuPvTtUFOb03WvX
 TzIFAffUJztAqSJ98fM36kVIjYdLKF+0rWtZjB6rxwY/Q29dks843O7
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The sticky fingers quirk (MT_QUIRK_STICKY_FINGERS) was only considering
the case when slots were not released during the last report.
This can be problematic if the firmware forgets to release a finger
while others are still present.

This was observed on the Synaptics DLL0945 touchpad found on the Dell
XPS 9310 and the Dell Inspiron 5406.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-multitouch.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2879e65cf303b1456311ac06115adda5a78a2600..e1a5c7f3a25132094ed643910337474025852b22 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -94,9 +94,8 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -172,7 +171,11 @@ struct mt_device {
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
+					 * first 8 bits are reserved for keeping the slot
+					 * states, this is fine because we only support up
+					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
@@ -986,6 +989,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1019,12 +1023,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 	app->left_button_state = 0;
 	if (td->is_haptic_touchpad)
 		hid_haptic_pressure_reset(td->haptic);
-
-	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
-		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	else
-		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_compute_timestamp(struct mt_application *app, __s32 value)
@@ -1202,7 +1200,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1337,7 +1337,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1813,6 +1813,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1835,7 +1836,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }

-- 
2.51.0


