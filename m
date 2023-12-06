Return-Path: <linux-kselftest+bounces-1270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70287806C7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D0B281984
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764730328;
	Wed,  6 Dec 2023 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsnaotKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541913AEA;
	Wed,  6 Dec 2023 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B92C433C7;
	Wed,  6 Dec 2023 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859579;
	bh=Hif8AQyE2YPxh4c1ifXxoCQdIEAvk7GdDFIcyZbu0Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WsnaotKYKcZ5jyNyBNanqgasEniPy/IK218oEK0mTTJx4IZhwZ8WsB4RfXXX7Mtcp
	 KQA4sKiqnZ5SFFXGlfuxyJ0Xu2xEETjfxzC+MHlzPO6lTz1Nx09ogJMGxTYNHwsx6R
	 0T4fI5Kr+ChGEwCdSr4K/j2LMZbv0C9f3xDJKF+/rAwE+bI5wJNmt2mWh8tCf7QuyJ
	 8la3tRyiT4w/MHYYpU41q9ESjjMu+jiA8zbFrPlMDokrG24Vq9SR/B9IhH9Nq5ySLI
	 gLIm4j4m2b+F8bUYIFCagviAwmjey/W8ihBeezcHXf6xo5aTAnNzVphOsyb78LAfHJ
	 KCummq02Vmt5A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:45:57 +0100
Subject: [PATCH v2 06/15] selftests/hid: tablets: move move_to function to
 PenDigitizer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-6-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=5364;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Hif8AQyE2YPxh4c1ifXxoCQdIEAvk7GdDFIcyZbu0Rg=;
 b=sB4yEgfiYows++yOpiowOjIdzwzmxxx9prSxRmLvJL+ZhD1Z8+3Wai3Ol4MNtCIMp+teVboBa
 Pu4jM341xvcDVgNslAXP6SuRQhajOo/DpUXJ7GVfVF/hwDXUVcgvVmJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We can easily subclass PenDigitizer for introducing firmware bugs when
subclassing Pen is harder.

Move move_to from Pen to PenDigitizer so we get that ability

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 97 ++++++++++++------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index ddf28c245046..27260dc02cc4 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -282,7 +282,7 @@ class Pen(object):
         self._old_values = None
         self.current_state = None
 
-    def _restore(self):
+    def restore(self):
         if self._old_values is not None:
             for i in [
                 "x",
@@ -297,50 +297,8 @@ class Pen(object):
             ]:
                 setattr(self, i, getattr(self._old_values, i))
 
-    def move_to(self, state):
-        # fill in the previous values
-        if self.current_state == PenState.PEN_IS_OUT_OF_RANGE:
-            self._restore()
-
-        print(f"\n  *** pen is moving to {state} ***")
-
-        if state == PenState.PEN_IS_OUT_OF_RANGE:
-            self._old_values = copy.copy(self)
-            self.x = 0
-            self.y = 0
-            self.tipswitch = False
-            self.tippressure = 0
-            self.azimuth = 0
-            self.inrange = False
-            self.width = 0
-            self.height = 0
-            self.invert = False
-            self.eraser = False
-            self.x_tilt = 0
-            self.y_tilt = 0
-            self.twist = 0
-        elif state == PenState.PEN_IS_IN_RANGE:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = False
-            self.eraser = False
-        elif state == PenState.PEN_IS_IN_CONTACT:
-            self.tipswitch = True
-            self.inrange = True
-            self.invert = False
-            self.eraser = False
-        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = True
-            self.eraser = False
-        elif state == PenState.PEN_IS_ERASING:
-            self.tipswitch = False
-            self.inrange = True
-            self.invert = True
-            self.eraser = True
-
-        self.current_state = state
+    def backup(self):
+        self._old_values = copy.copy(self)
 
     def __assert_axis(self, evdev, axis, value):
         if (
@@ -384,6 +342,51 @@ class PenDigitizer(base.UHIDTestDevice):
                     continue
                 self.fields = [f.usage_name for f in r]
 
+    def move_to(self, pen, state):
+        # fill in the previous values
+        if pen.current_state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.restore()
+
+        print(f"\n  *** pen is moving to {state} ***")
+
+        if state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.backup()
+            pen.x = 0
+            pen.y = 0
+            pen.tipswitch = False
+            pen.tippressure = 0
+            pen.azimuth = 0
+            pen.inrange = False
+            pen.width = 0
+            pen.height = 0
+            pen.invert = False
+            pen.eraser = False
+            pen.x_tilt = 0
+            pen.y_tilt = 0
+            pen.twist = 0
+        elif state == PenState.PEN_IS_IN_RANGE:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = False
+        elif state == PenState.PEN_IS_ERASING:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = True
+
+        pen.current_state = state
+
     def event(self, pen):
         rs = []
         r = self.create_report(application=self.cur_application, data=pen)
@@ -462,7 +465,7 @@ class BaseTest:
             cur_state = PenState.PEN_IS_OUT_OF_RANGE
 
             p = Pen(50, 60)
-            p.move_to(PenState.PEN_IS_OUT_OF_RANGE)
+            uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
             events = self.post(uhdev, p)
             self.validate_transitions(cur_state, p, evdev, events)
 
@@ -475,7 +478,7 @@ class BaseTest:
                     events = self.post(uhdev, p)
                     self.validate_transitions(cur_state, p, evdev, events)
                     assert len(events) >= 3  # X, Y, SYN
-                p.move_to(state)
+                uhdev.move_to(p, state)
                 if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1

-- 
2.41.0


