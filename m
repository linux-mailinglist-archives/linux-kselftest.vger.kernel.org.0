Return-Path: <linux-kselftest+bounces-1279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1E806C92
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F4AB20D9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261230343;
	Wed,  6 Dec 2023 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4lUvbTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C313AEA;
	Wed,  6 Dec 2023 10:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0018CC43391;
	Wed,  6 Dec 2023 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859597;
	bh=brjJ96URjS/De2F/QMe4Vwb6nXSvrFhFcqR+W+FmdYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4lUvbTgHVGmEJWPwZ5TfYMQuF+8+bjlb0IDYH2Dmj0E8ZMhJHuYMK+ouzUobW29t
	 o7sidpF+vyC4nDWy5QwxcxOmmoY97SMaYS6ZktBOTgUXFE+DKl6Dk4XB2NknRYP2Vf
	 xpLrLkD7+qvB0zjb4yqol0yRyy+7h/nHM22TdqXLAo5Fw9ZbigDjcflmRMa7aCvett
	 +6cvgXqcWP2z5N+0HWfEtcw7HJyetqM9iFFRQkFmRu6aaNhqTfuCJmpFUXl9b/FmzB
	 nRcAQqxGoKTFo6jBOS3BBzPIeO6OpJ0eqF4HiDRIYedg58s7T3v2N6JxoFvRl7r4Tz
	 zgd5UifDqDEaA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:46:06 +0100
Subject: [PATCH v2 15/15] selftests/hid: fix ruff linter complains
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-15-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=2505;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=brjJ96URjS/De2F/QMe4Vwb6nXSvrFhFcqR+W+FmdYU=;
 b=tdJcMhy7Ay4dczYmS/vEywZYeugyRtvPySkGrsTjVqjJfg1eQ7HmsabSTrrYmeotZMcpy+eco
 ZNIAuLH/1gUDWZva7HhwohRisMlNN6WYKaYM+Xn2CRPdapO3zgpXec3
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

rename ambiguous variables l, r, and m, and ignore the return values
of uhdev.get_evdev() and uhdev.get_slot()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 tools/testing/selftests/hid/tests/test_mouse.py         | 14 +++++++-------
 tools/testing/selftests/hid/tests/test_wacom_generic.py |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_mouse.py b/tools/testing/selftests/hid/tests/test_mouse.py
index fd2ba62e783a..66daf7e5975c 100644
--- a/tools/testing/selftests/hid/tests/test_mouse.py
+++ b/tools/testing/selftests/hid/tests/test_mouse.py
@@ -52,13 +52,13 @@ class BaseMouse(base.UHIDTestDevice):
         :param reportID: the numeric report ID for this report, if needed
         """
         if buttons is not None:
-            l, r, m = buttons
-            if l is not None:
-                self.left = l
-            if r is not None:
-                self.right = r
-            if m is not None:
-                self.middle = m
+            left, right, middle = buttons
+            if left is not None:
+                self.left = left
+            if right is not None:
+                self.right = right
+            if middle is not None:
+                self.middle = middle
         left = self.left
         right = self.right
         middle = self.middle
diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index f92fe8e02c1b..49186a27467e 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -909,7 +909,7 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         Ensure that the confidence bit being set to false should not result in a touch event.
         """
         uhdev = self.uhdev
-        evdev = uhdev.get_evdev()
+        _evdev = uhdev.get_evdev()
 
         t0 = test_multitouch.Touch(1, 50, 100)
         t0.confidence = False
@@ -917,6 +917,6 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         events = uhdev.next_sync_events()
         self.debug_reports(r, uhdev, events)
 
-        slot = self.get_slot(uhdev, t0, 0)
+        _slot = self.get_slot(uhdev, t0, 0)
 
-        assert not events
\ No newline at end of file
+        assert not events

-- 
2.41.0


