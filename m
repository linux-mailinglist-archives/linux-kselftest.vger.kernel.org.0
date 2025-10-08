Return-Path: <linux-kselftest+bounces-42879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBDBC564D
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 16:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296884FB14D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDFD29AAEA;
	Wed,  8 Oct 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut11yE86"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453729993A;
	Wed,  8 Oct 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932433; cv=none; b=pmP3BHPaB2OCfXVMx4C6wIdKYukAziFJ6phfhdTEOGMjqH+ihJeDzQEeyYfV44UH6cOPlKZ8JUF++2LyeskXVKbp37/57eE22VdN58OsLHGNLTwEtx3bcvWQWOrbmDDpUQyCtG4ZCF2O9iStjq+dGBrBma2xP1b05soZFWdVD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932433; c=relaxed/simple;
	bh=Uqc/kLJQy55H6bnTrhnxEfGjhf286WP1v2c3zjoMyx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AR3RAYsTcnnYeu2K8tFgfFFW16TH59dCnisNZ2MzTInp5Zd3MWT0bngobx85xJ6DptJ9DRhsvEY1Bq2APUbVm5VHDByX0Dg6tCPQ4eqoB+ot91PjqVqrglxzBDITLk9JDdTbqv2KYW9cWKE5EWtEVox0WLdbMNrJUWi3s2eW0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut11yE86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E490C4CEF5;
	Wed,  8 Oct 2025 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932433;
	bh=Uqc/kLJQy55H6bnTrhnxEfGjhf286WP1v2c3zjoMyx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ut11yE86J8IoE7mxYoqQpkN/v+Pa7sQGTHpeEYCGmj9Ax94Xsklg1TlqDYcM3/toM
	 SxiZugEnzOk+esAum3pVSXxFoNfTovF2c6bGtWfGoh4UoH8CBhjyArrzwQXKyhzDrT
	 SFUwcLhjyXN2AUud9POC+VTa9W09E8cj2VdpoamNJRTUgizzoNQPwtF4LMy8A5QXM9
	 AL+TiWHogfULKJLuOfRJEzQapsrp07nCMP3+UDHX9fIlYvQPFLp7qRRkGivRxLwGub
	 sXaKp0lcWWX3VEV1RIHIzghftn4WFZ1x26Nb9QzfuzPgfIR6Ydffyug3CyxBr3toLS
	 n3PDlfig/9OMw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 Oct 2025 16:06:59 +0200
Subject: [PATCH 2/2] selftests/hid: add tests for missing release on the
 Dell Synaptics
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-fix-sticky-fingers-v1-2-760f1f26fce3@kernel.org>
References: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
In-Reply-To: <20251008-fix-sticky-fingers-v1-0-760f1f26fce3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759932427; l=7534;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Uqc/kLJQy55H6bnTrhnxEfGjhf286WP1v2c3zjoMyx4=;
 b=HM+woDX5bgiVNyXttgO3cJHrrGOPvuveDmdMS5F+Bvl3bKyIdkd+xQAjQDu/UMQGntneuSUTo
 Xix0x1+bJVDCnXEoRmb1Zp9km0UfVChuqKt1jP8zOlRG1KAXrRw5bKJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Add a simple test for the corner case not currently covered by the
sticky fingers quirk. Because it's a corner case test, we only test this
on a couple of devices, not on all of them because the value of adding
the same test over and over is rather moot.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 .../testing/selftests/hid/tests/test_multitouch.py | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
index 5d2ffa3d59777e3cd93d1d7aebabc2a6b7ecb42a..ece0ba8e7d34b75d42245e5936ecf804c46b0846 100644
--- a/tools/testing/selftests/hid/tests/test_multitouch.py
+++ b/tools/testing/selftests/hid/tests/test_multitouch.py
@@ -1752,6 +1752,52 @@ class TestWin8TSConfidence(BaseTest.TestWin8Multitouch):
         assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
 
 
+    @pytest.mark.skip_if_uhdev(
+        lambda uhdev: "Confidence" not in uhdev.fields,
+        "Device not compatible, missing Confidence usage",
+    )
+    def test_mt_confidence_bad_multi_release(self):
+        """Check for the sticky finger being properly detected.
+
+        We first inject 3 fingers, then release only the second.
+        After 100 ms, we should receive a generated event about the
+        2 missing fingers being released.
+        """
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+
+        # send 3 touches
+        t0 = Touch(1, 50, 10)
+        t1 = Touch(2, 150, 100)
+        t2 = Touch(3, 250, 200)
+        r = uhdev.event([t0, t1, t2])
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+
+        # release the second
+        t1.tipswitch = False
+        r = uhdev.event([t1])
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+
+        # only the second is released
+        assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] != -1
+        assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+        assert evdev.slots[2][libevdev.EV_ABS.ABS_MT_TRACKING_ID] != -1
+
+        # wait for the timer to kick in
+        time.sleep(0.2)
+
+        events = uhdev.next_sync_events()
+        self.debug_reports([], uhdev, events)
+
+        # now all 3 fingers are released
+        assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 0) in events
+        assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+        assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+        assert evdev.slots[2][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+
+
 class TestElanXPS9360(BaseTest.TestWin8Multitouch):
     def create_device(self):
         return Digitizer(
@@ -2086,3 +2132,12 @@ class Testsynaptics_06cb_ce08(BaseTest.TestPTP):
             input_info=(BusType.I2C, 0x06CB, 0xCE08),
             rdesc="05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 05 01 09 02 a1 01 85 18 09 01 a1 00 05 09 19 01 29 03 46 00 00 15 00 25 01 75 01 95 03 81 02 95 05 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 06 00 ff 09 02 a1 01 85 20 09 01 a1 00 09 03 15 00 26 ff 00 35 00 46 ff 00 75 08 95 05 81 02 c0 c0 05 0d 09 05 a1 01 85 03 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 f8 04 75 10 55 0e 65 11 09 30 35 00 46 24 04 95 01 81 02 46 30 02 26 a0 02 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 f8 04 75 10 55 0e 65 11 09 30 35 00 46 24 04 95 01 81 02 46 30 02 26 a0 02 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 
 26 f8 04 75 10 55 0e 65 11 09 30 35 00 46 24 04 95 01 81 02 46 30 02 26 a0 02 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 f8 04 75 10 55 0e 65 11 09 30 35 00 46 24 04 95 01 81 02 46 30 02 26 a0 02 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 f8 04 75 10 55 0e 65 11 09 30 35 00 46 24 04 95 01 81 02 46 30 02 26 a0 02 09 31 81 02 c0 05 0d 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81 02 09 54 25 7f 95 01 75 08 81 02 05 09 09 01 25 01 75 01 95 01 81 02 95 07 81 03 05 0d 85 08 09 55 09 59 75 04 95 02 25 0f b1 02 85 0d 09 60 75 01 95 01 15 00 25 01 b1 02 95 07 b1 03 85 07 06 00 ff 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 05 0d 09 0e a1 01 85 04 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1 00 85 06 09 57 09 58 75 01 95 02 25 01 b1 02 95 06 b1 03 c0 c0 06 00 ff 09 01 a
 1 01 85 09 09 02 15 00 26 ff 00 75 08 95 14 91 02 85 0a 09 03 15 00 26 ff 00 75 08 95 14 91 02 85 0b 09 04 15 00 26 ff 00 75 08 95 45 81 02 85 0c 09 05 15 00 26 ff 00 75 08 95 45 81 02 85 0f 09 06 15 00 26 ff 00 75 08 95 03 b1 02 85 0e 09 07 15 00 26 ff 00 75 08 95 01 b1 02 c0",
         )
+
+class Testsynaptics_06cb_ce26(TestWin8TSConfidence):
+    def create_device(self):
+        return PTP(
+            "uhid test synaptics_06cb_ce26",
+            max_contacts=5,
+            input_info=(BusType.I2C, 0x06CB, 0xCE26),
+            rdesc="05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 05 0d 09 05 a1 01 85 03 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 45 05 75 10 55 0e 65 11 09 30 35 00 46 64 04 95 01 81 02 46 a2 02 26 29 03 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 45 05 75 10 55 0e 65 11 09 30 35 00 46 64 04 95 01 81 02 46 a2 02 26 29 03 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 45 05 75 10 55 0e 65 11 09 30 35 00 46 64 04 95 01 81 02 46 a2 02 26 29 03 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 45 05 75 10 55 0e 65 11 09 30 35 00 46 64 
 04 95 01 81 02 46 a2 02 26 29 03 09 31 81 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 95 01 75 03 25 05 09 51 81 02 75 01 95 03 81 03 05 01 15 00 26 45 05 75 10 55 0e 65 11 09 30 35 00 46 64 04 95 01 81 02 46 a2 02 26 29 03 09 31 81 02 c0 05 0d 55 0c 66 01 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81 02 09 54 25 7f 95 01 75 08 81 02 05 09 09 01 25 01 75 01 95 01 81 02 95 07 81 03 05 0d 85 08 09 55 09 59 75 04 95 02 25 0f b1 02 85 0d 09 60 75 01 95 01 15 00 25 01 b1 02 95 07 b1 03 85 07 06 00 ff 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 05 0d 09 0e a1 01 85 04 09 22 a1 02 09 52 15 00 25 0a 75 08 95 01 b1 02 c0 09 22 a1 00 85 06 09 57 09 58 75 01 95 02 25 01 b1 02 95 06 b1 03 c0 c0 06 00 ff 09 01 a1 01 85 09 09 02 15 00 26 ff 00 75 08 95 14 91 02 85 0a 09 03 15 00 26 ff 00 75 08 95 14 91 02 85 0b 09 04 15 00 26 ff 00 75 08 95 3d 81 02 85 0c 09 05 15 00 26 ff 00 75 08 95 3d 81 02 85 0f 09 06 15 00 26 ff 00 75 08 95 03 b1 02 85 0e 09 07 15 00 26 ff 00 7
 5 08 95 01 b1 02 c0",
+        )

-- 
2.51.0


