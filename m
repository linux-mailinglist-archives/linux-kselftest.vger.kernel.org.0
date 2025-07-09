Return-Path: <linux-kselftest+bounces-36809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A25AFE3A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD23C58326E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECAF284674;
	Wed,  9 Jul 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opWo33Wx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A6283FF8;
	Wed,  9 Jul 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052146; cv=none; b=jzdPIp6uJVf7lwLiTrzabNSZA3rtVpjA+5h5nesNM0VHcfDZrOBE7gc3bbaklFliU2EhdAhQibT9Ta7GcxqrSQlMaO7h+3xlawLUzbi/vQjBOYXqM5SyP14cup1cHtiRF57E616dBvGzhzZhoUD4+yUzSFy86vKzU5jAaDIgsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052146; c=relaxed/simple;
	bh=0YT23cbf3ahbOVyAGk/jynunznrLudOSflLr6hltA4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsCFsC7RmL2lIOCna6DNHV+umRPuAs7zOregaXvB2I6Wv7yA/0azJeI7Lmyh0JHvojpxmtJhY2WVw2gzBqVR7WH98EppWxiWaLC5W7aNJq6LmuXVJVdKSdPaXUq3JGgtRfAXlh4u23/Fk3MWXxjkcRY++WMHZwqeCSREwdDf63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opWo33Wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB3C4CEF5;
	Wed,  9 Jul 2025 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052146;
	bh=0YT23cbf3ahbOVyAGk/jynunznrLudOSflLr6hltA4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=opWo33WxuZOWnsKdWhhLNlpB3tvqAX/cDIbzNNQC9yU9wpzUAehK3fMLkWfnSghjf
	 KPJsa+H+YYA5cTW6XCcD5V6nGvV4MormSHm+HTN1y4Br0M9ZisczBt6B5BlDj9+uIN
	 zpnYXowOlcTjbKeg0ABA4RhRc+n02+i04vuh1F2XZR0G/NjEGi5xtwvYYZHDvsNjQS
	 x/axOxXVNfjwChvmWdGrZXrdIdyv3zlpfH4+RMFt4NEkNcGjEFR+CLmgq3jjsQZ4fG
	 kLhKyB2ZfkNG6aVo92dJeFO3Ikq+HWdQUAbRcgkupfUYlikeOk93FavNfDiLNrGWx6
	 bmmjWQ8++XuIA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 09 Jul 2025 11:08:49 +0200
Subject: [PATCH 1/3] selftests/hid: run ruff format on the python part
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-wip-fix-ci-v1-1-b7df4c271cf8@kernel.org>
References: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
In-Reply-To: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052142; l=24415;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=0YT23cbf3ahbOVyAGk/jynunznrLudOSflLr6hltA4k=;
 b=g/i5omnMCTbU3WtX/CdsZjRerw6YkiHGgx52MZXa0pu0N1dYWgA3fRTA4AoemRifGyvzyr+dK
 WPDANhzRZtPAaLRyRXoXxD+YkQvLvCQvnnKHPo2I6sG0/5RmcUCDhdm
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We aim at syncing with the hid-tools repo on
gitlab.freedesktop.org/libevdev/hid-tools. One of the commits is this
mechanical formatting, so pull it over here so changes are not hidden by
those.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py   |   4 +-
 .../selftests/hid/tests/test_wacom_generic.py      | 436 +++++++++++++++------
 2 files changed, 325 insertions(+), 115 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index a9e2de1e8861b2b1fec0f2a245e9bccee54b9645..52fb22cac91e86f85b00a312895c98e6379f02ad 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -1228,9 +1228,9 @@ class Huion_Kamvas_Pro_19_256c_006b(PenDigitizer):
         pen.current_state = state
 
     def call_input_event(self, report):
-        if report[0] == 0x0a:
+        if report[0] == 0x0A:
             # ensures the original second Eraser usage is null
-            report[1] &= 0xdf
+            report[1] &= 0xDF
 
             # ensures the original last bit is equal to bit 6 (In Range)
             if report[1] & 0x40:
diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index b62c7dba6777f975dd9158f6788a6177307bc9e4..5cbc0cc9308f653b817e54a95f8b53a83782f105 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -892,7 +892,7 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         locations. The value of `t` may be incremented over time to move the
         points along a linear path.
         """
-        return [ self.make_contact(id, t) for id in range(0, n) ]
+        return [self.make_contact(id, t) for id in range(0, n)]
 
     def assert_contact(self, uhdev, evdev, contact_ids, t=0):
         """
@@ -997,12 +997,17 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
 
         assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1) in events
 
-        self.assert_contacts(uhdev, evdev,
-            [ self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = None),
-              self.ContactIds(contact_id = 1, tracking_id = 0, slot_num = 0),
-              self.ContactIds(contact_id = 2, tracking_id = -1, slot_num = None),
-              self.ContactIds(contact_id = 3, tracking_id = 1, slot_num = 1),
-              self.ContactIds(contact_id = 4, tracking_id = -1, slot_num = None) ])
+        self.assert_contacts(
+            uhdev,
+            evdev,
+            [
+                self.ContactIds(contact_id=0, tracking_id=-1, slot_num=None),
+                self.ContactIds(contact_id=1, tracking_id=0, slot_num=0),
+                self.ContactIds(contact_id=2, tracking_id=-1, slot_num=None),
+                self.ContactIds(contact_id=3, tracking_id=1, slot_num=1),
+                self.ContactIds(contact_id=4, tracking_id=-1, slot_num=None),
+            ],
+        )
 
     def confidence_change_assert_playback(self, uhdev, evdev, timeline):
         """
@@ -1026,7 +1031,7 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
             events = uhdev.next_sync_events()
             self.debug_reports(r, uhdev, events)
 
-            ids = [ x[0] for x in state ]
+            ids = [x[0] for x in state]
             self.assert_contacts(uhdev, evdev, ids, t)
 
             t += 1
@@ -1044,27 +1049,68 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         uhdev = self.uhdev
         evdev = uhdev.get_evdev()
 
-        self.confidence_change_assert_playback(uhdev, evdev, [
-            # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # Both fingers confidently in contact
-            [(self.ContactIds(contact_id = 0, tracking_id = 0, slot_num = 0), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=1: Contact 0 == !Down + confident; Contact 1 == Down + confident
-            # First finger looses confidence and clears only the tipswitch flag
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)]
-        ])
+        self.confidence_change_assert_playback(
+            uhdev,
+            evdev,
+            [
+                # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # Both fingers confidently in contact
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=1: Contact 0 == !Down + confident; Contact 1 == Down + confident
+                # First finger looses confidence and clears only the tipswitch flag
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+            ],
+        )
 
     def test_confidence_loss_b(self):
         """
@@ -1079,27 +1125,68 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         uhdev = self.uhdev
         evdev = uhdev.get_evdev()
 
-        self.confidence_change_assert_playback(uhdev, evdev, [
-            # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # Both fingers confidently in contact
-            [(self.ContactIds(contact_id = 0, tracking_id = 0, slot_num = 0), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=1: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger looses confidence and has both flags cleared simultaneously
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)]
-        ])
+        self.confidence_change_assert_playback(
+            uhdev,
+            evdev,
+            [
+                # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # Both fingers confidently in contact
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=1: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger looses confidence and has both flags cleared simultaneously
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+            ],
+        )
 
     def test_confidence_loss_c(self):
         """
@@ -1113,27 +1200,68 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         uhdev = self.uhdev
         evdev = uhdev.get_evdev()
 
-        self.confidence_change_assert_playback(uhdev, evdev, [
-            # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # Both fingers confidently in contact
-            [(self.ContactIds(contact_id = 0, tracking_id = 0, slot_num = 0), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
-            # First finger looses confidence and clears only the confidence flag
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), True, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
-            # First finger has lost confidence and has both flags cleared
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)]
-        ])
+        self.confidence_change_assert_playback(
+            uhdev,
+            evdev,
+            [
+                # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # Both fingers confidently in contact
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
+                # First finger looses confidence and clears only the confidence flag
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        True,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=2: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=3: Contact 0 == !Down + !confident; Contact 1 == Down + confident
+                # First finger has lost confidence and has both flags cleared
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+            ],
+        )
 
     def test_confidence_gain_a(self):
         """
@@ -1144,27 +1272,68 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         uhdev = self.uhdev
         evdev = uhdev.get_evdev()
 
-        self.confidence_change_assert_playback(uhdev, evdev, [
-            # t=0: Contact 0 == Down + !confident; Contact 1 == Down + confident
-            # Only second finger is confidently in contact
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = None), True, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 0, slot_num = 0), True, True)],
-
-            # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
-            # First finger gains confidence
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = None), True, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 0, slot_num = 0), True, True)],
-
-            # t=2: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # First finger remains confident
-            [(self.ContactIds(contact_id = 0, tracking_id = 1, slot_num = 1), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 0, slot_num = 0), True, True)],
-
-            # t=3: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # First finger remains confident
-            [(self.ContactIds(contact_id = 0, tracking_id = 1, slot_num = 1), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 0, slot_num = 0), True, True)]
-        ])
+        self.confidence_change_assert_playback(
+            uhdev,
+            evdev,
+            [
+                # t=0: Contact 0 == Down + !confident; Contact 1 == Down + confident
+                # Only second finger is confidently in contact
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=None),
+                        True,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
+                # First finger gains confidence
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=None),
+                        True,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=2: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # First finger remains confident
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=3: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # First finger remains confident
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                ],
+            ],
+        )
 
     def test_confidence_gain_b(self):
         """
@@ -1175,24 +1344,65 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
         uhdev = self.uhdev
         evdev = uhdev.get_evdev()
 
-        self.confidence_change_assert_playback(uhdev, evdev, [
-            # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # First and second finger confidently in contact
-            [(self.ContactIds(contact_id = 0, tracking_id = 0, slot_num = 0), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
-            # Firtst finger looses confidence
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), True, False),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=2: Contact 0 == Down + confident; Contact 1 == Down + confident
-            # First finger gains confidence
-            [(self.ContactIds(contact_id = 0, tracking_id = 2, slot_num = 0), True, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)],
-
-            # t=3: Contact 0 == !Down + confident; Contact 1 == Down + confident
-            # First finger goes up
-            [(self.ContactIds(contact_id = 0, tracking_id = -1, slot_num = 0), False, True),
-             (self.ContactIds(contact_id = 1, tracking_id = 1, slot_num = 1), True, True)]
-        ])
+        self.confidence_change_assert_playback(
+            uhdev,
+            evdev,
+            [
+                # t=0: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # First and second finger confidently in contact
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=0, slot_num=0),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=1: Contact 0 == Down + !confident; Contact 1 == Down + confident
+                # Firtst finger looses confidence
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        True,
+                        False,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=2: Contact 0 == Down + confident; Contact 1 == Down + confident
+                # First finger gains confidence
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=2, slot_num=0),
+                        True,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+                # t=3: Contact 0 == !Down + confident; Contact 1 == Down + confident
+                # First finger goes up
+                [
+                    (
+                        self.ContactIds(contact_id=0, tracking_id=-1, slot_num=0),
+                        False,
+                        True,
+                    ),
+                    (
+                        self.ContactIds(contact_id=1, tracking_id=1, slot_num=1),
+                        True,
+                        True,
+                    ),
+                ],
+            ],
+        )

-- 
2.49.0


