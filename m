Return-Path: <linux-kselftest+bounces-832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E237FDB47
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380021C20A43
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE1381C6;
	Wed, 29 Nov 2023 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkeJh43T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808D374FA;
	Wed, 29 Nov 2023 15:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4FFC433CB;
	Wed, 29 Nov 2023 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271519;
	bh=uqWfmCl2vZTNBGQW3I2y+s3kBWYZ2gqQvlfYZ2vvT24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RkeJh43TIojQnFOoY4jFFa2st09sE+PdhPqWNeVh/X/msl9+70cCLeVMUeAX8vuOG
	 DecouLITgSvjFe3OUx5fVvAowgTy6gsQzUNxso5bSQ8L3PJRGwL3kU/5DU4/5pCBhj
	 yZOMBzgV3Pq6+XaZSCzgJpmR5VvdWAgvlLwZD/eEX5sFPNIkCYhz14WdgcY5Vw1fIv
	 mnypRXDmRI3yEWn9TawdwzzLNyyz6WHfl0Yd3zPhuH8qzWud2f8rVgfJKT/829TE6J
	 VsFsmfaNAyPoo0QyuqSIeuPB7wcGar/keQg2Q2BOHT1uWWn72S+atqxa+3LbGjQJxX
	 3+TLxilJN33rw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:34 +0100
Subject: [PATCH 09/12] selftests/hid: tablets: add variants of states with
 buttons
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-9-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=11152;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=uqWfmCl2vZTNBGQW3I2y+s3kBWYZ2gqQvlfYZ2vvT24=;
 b=7yIyysCibofBZjqn46A2ADLyBatKwXq0y/QHWgBWB8QcYlPDNni4VuDB2fJmvOL0NV4hgdYSS
 eqFgz11FF0vDEWRrkz0Ig9ABCir9m8sBa26D2iNC7zIHFZSAJdCxFJe
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that there are transitions that are unlikely to happen:
for example, having both the tip switch and a button being changed
at the same time (in the same report) would require either a very talented
and precise user or a very bad hardware with a very low sampling rate.

So instead of manually building the button test by hand and forgetting
about some cases, let's reuse the state machine and transitions we have.

This patch only adds the states and the valid transitions. The actual
tests will be replaced later.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 170 +++++++++++++++++++++--
 1 file changed, 157 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 83f6501fe984..80269d1a0f0a 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -21,22 +21,66 @@ logger = logging.getLogger("hidtools.test.tablet")
 class PenState(Enum):
     """Pen states according to Microsoft reference:
     https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
-    """
 
-    PEN_IS_OUT_OF_RANGE = (False, None)
-    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER)
-    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER)
+    We extend it with the various buttons when we need to check them.
+    """
 
-    def __init__(self, touch, tool):
+    PEN_IS_OUT_OF_RANGE = (False, None, None)
+    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN, None)
+    PEN_IS_IN_RANGE_WITH_BUTTON = (
+        False,
+        libevdev.EV_KEY.BTN_TOOL_PEN,
+        libevdev.EV_KEY.BTN_STYLUS,
+    )
+    PEN_IS_IN_RANGE_WITH_SECOND_BUTTON = (
+        False,
+        libevdev.EV_KEY.BTN_TOOL_PEN,
+        libevdev.EV_KEY.BTN_STYLUS2,
+    )
+    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN, None)
+    PEN_IS_IN_CONTACT_WITH_BUTTON = (
+        True,
+        libevdev.EV_KEY.BTN_TOOL_PEN,
+        libevdev.EV_KEY.BTN_STYLUS,
+    )
+    PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON = (
+        True,
+        libevdev.EV_KEY.BTN_TOOL_PEN,
+        libevdev.EV_KEY.BTN_STYLUS2,
+    )
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER, None)
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON = (
+        False,
+        libevdev.EV_KEY.BTN_TOOL_RUBBER,
+        libevdev.EV_KEY.BTN_STYLUS,
+    )
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_SECOND_BUTTON = (
+        False,
+        libevdev.EV_KEY.BTN_TOOL_RUBBER,
+        libevdev.EV_KEY.BTN_STYLUS2,
+    )
+    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER, None)
+    PEN_IS_ERASING_WITH_BUTTON = (
+        True,
+        libevdev.EV_KEY.BTN_TOOL_RUBBER,
+        libevdev.EV_KEY.BTN_STYLUS,
+    )
+    PEN_IS_ERASING_WITH_SECOND_BUTTON = (
+        True,
+        libevdev.EV_KEY.BTN_TOOL_RUBBER,
+        libevdev.EV_KEY.BTN_STYLUS2,
+    )
+
+    def __init__(self, touch, tool, button):
         self.touch = touch
         self.tool = tool
+        self.button = button
 
     @classmethod
     def from_evdev(cls, evdev) -> "PenState":
         touch = bool(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
         tool = None
+        button = None
         if (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
@@ -53,7 +97,17 @@ class PenState(Enum):
         ):
             raise ValueError("2 tools are not allowed")
 
-        return cls((touch, tool))
+        # we take only the highest button in account
+        for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
+            if bool(evdev.value[b]):
+                button = b
+
+        # the kernel tends to insert an EV_SYN once removing the tool, so
+        # the button will be released after
+        if tool is None:
+            button = None
+
+        return cls((touch, tool, button))
 
     def apply(self, events) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
@@ -62,6 +116,8 @@ class PenState(Enum):
         touch_found = False
         tool = self.tool
         tool_found = False
+        button = self.button
+        button_found = False
 
         for ev in events:
             if ev == libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH):
@@ -76,12 +132,22 @@ class PenState(Enum):
                 if tool_found:
                     raise ValueError(f"duplicated BTN_TOOL_* in {events}")
                 tool_found = True
-                if ev.value:
-                    tool = ev.code
-                else:
-                    tool = None
+                tool = ev.code if ev.value else None
+            elif ev in (
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS),
+                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2),
+            ):
+                if button_found:
+                    raise ValueError(f"duplicated BTN_STYLUS* in {events}")
+                button_found = True
+                button = ev.code if ev.value else None
 
-        new_state = PenState((touch, tool))
+        # the kernel tends to insert an EV_SYN once removing the tool, so
+        # the button will be released after
+        if tool is None:
+            button = None
+
+        new_state = PenState((touch, tool, button))
         assert (
             new_state in self.valid_transitions()
         ), f"moving from {self} to {new_state} is forbidden"
@@ -97,14 +163,20 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
                 PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_ERASING,
             )
 
         if self == PenState.PEN_IS_IN_RANGE:
             return (
                 PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_CONTACT,
             )
@@ -112,6 +184,8 @@ class PenState(Enum):
         if self == PenState.PEN_IS_IN_CONTACT:
             return (
                 PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
@@ -130,6 +204,38 @@ class PenState(Enum):
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
 
+        if self == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            return (
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
+            return (
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+            )
+
         return tuple()
 
     @staticmethod
@@ -364,26 +470,64 @@ class PenDigitizer(base.UHIDTestDevice):
             pen.xtilt = 0
             pen.ytilt = 0
             pen.twist = 0
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_IN_RANGE:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_IN_CONTACT:
             pen.tipswitch = True
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = True
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = True
+            pen.secondarybarrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = True
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = True
         elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = True
             pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
         elif state == PenState.PEN_IS_ERASING:
             pen.tipswitch = False
             pen.inrange = True
             pen.invert = False
             pen.eraser = True
+            pen.barrelswitch = False
+            pen.secondarybarrelswitch = False
 
         pen.current_state = state
 

-- 
2.41.0


