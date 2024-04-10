Return-Path: <linux-kselftest+bounces-7589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137889FE4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4705285468
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DA181D1D;
	Wed, 10 Apr 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH6y6g7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F44181D19;
	Wed, 10 Apr 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769616; cv=none; b=F549auH/I0INfauc6hiivzoJEA5ddRaa5U/X22Kc0TG/xp6xLZfI2q5QrN89h77z6wHSXjjqyW754Z1j2I0MoE48IES/AsjAr8ETc/mgssPVj4n6KXzYtf5DqBBlRRiWQ89FHLxO/C0rOuv1Nv1nSCVsMHHHncbHmNYkD76yN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769616; c=relaxed/simple;
	bh=o7rFwp+LxU5iuTsW+OL7909j23iSbmm85+cUyDXhNaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEoT06fQe4bJB7CGESe05M01k2SpJ24ENcJ3AhNmO7VaAE6EsN5AM/bA/PYbMGeyAQrItgzfjovzMuh17kkFXgLCAoDA8fpehW5wjn5rceYy4Y/fUlvQN5bZPda2TCIEf9ggkjgIUH6UaLK+hBQCtRJ4uDGw2/ZnJek+ba+IG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH6y6g7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1823CC43394;
	Wed, 10 Apr 2024 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769615;
	bh=o7rFwp+LxU5iuTsW+OL7909j23iSbmm85+cUyDXhNaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tH6y6g7F+XUok4ibtHpTJSALNEQwUL3j4Mfu1Q2UectpsbvTcYdZ7e6LsEqIxsprw
	 fzQE59HjgEchRAvEEMKP853zXxrN/sYNI6NHFsBhcbPcuDCeKIXIa4LhJ/NM/C28bC
	 Vk1Bq1hXvoMwqfVPcr5oYzGwhITsH2GCVqXsM+OlPvEzZ6jWces0uBcmAkiJMU6iqU
	 Jmqqeb29ZWQQWwAFEQkEa71G9Y5oWMNYInqAbAJ/8fkVGVY0dmzaaV3BE1umfdLxOC
	 q/hHwwyw/8eY/YW7fTAK3wbwDlDatxROQ6xdVvxvw/9KJrstrzjOgeE4N6sAA5pBXy
	 go4k2bLDBIfXg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:32 +0200
Subject: [PATCH 12/18] selftests/hid: tablets: reduce the number of pen
 state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-12-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=22185;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=o7rFwp+LxU5iuTsW+OL7909j23iSbmm85+cUyDXhNaE=;
 b=t8fmW5bq1Him9BGv7agFyfh6sspCqir2ETCVuUJiRhUvng126egDSzBY/u0P3aEVmjTP6MJ8m
 HvlUJPOEde8A0qnDSRg8IQHR+3GLUQ+inVoeXhGuPHB2Wr4v4Tf4/K1
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

All the *_WITH*BUTTON states were almost identical except for the
button itself.

I need to add a new device with a third button, and adding a bunch of
states is going to be quite cumbersome.

So convert the `button` parameter of PenState as a boolean, and store
which button is the target as an argument to all functions that need it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 272 +++++++----------------
 1 file changed, 81 insertions(+), 191 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 903f19f7cbe9..df1134e5713c 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -44,58 +44,28 @@ class PenState(Enum):
     We extend it with the various buttons when we need to check them.
     """
 
-    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None, None
-    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN, None
-    PEN_IS_IN_RANGE_WITH_BUTTON = BtnTouch.UP, ToolType.PEN, BtnPressed.PRIMARY_PRESSED
-    PEN_IS_IN_RANGE_WITH_SECOND_BUTTON = (
-        BtnTouch.UP,
-        ToolType.PEN,
-        BtnPressed.SECONDARY_PRESSED,
-    )
-    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN, None
-    PEN_IS_IN_CONTACT_WITH_BUTTON = (
-        BtnTouch.DOWN,
-        ToolType.PEN,
-        BtnPressed.PRIMARY_PRESSED,
-    )
-    PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON = (
-        BtnTouch.DOWN,
-        ToolType.PEN,
-        BtnPressed.SECONDARY_PRESSED,
-    )
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER, None
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON = (
-        BtnTouch.UP,
-        ToolType.RUBBER,
-        BtnPressed.PRIMARY_PRESSED,
-    )
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_SECOND_BUTTON = (
-        BtnTouch.UP,
-        ToolType.RUBBER,
-        BtnPressed.SECONDARY_PRESSED,
-    )
-    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER, None
-    PEN_IS_ERASING_WITH_BUTTON = (
-        BtnTouch.DOWN,
-        ToolType.RUBBER,
-        BtnPressed.PRIMARY_PRESSED,
-    )
-    PEN_IS_ERASING_WITH_SECOND_BUTTON = (
-        BtnTouch.DOWN,
-        ToolType.RUBBER,
-        BtnPressed.SECONDARY_PRESSED,
-    )
-
-    def __init__(self, touch: BtnTouch, tool: Optional[ToolType], button: Optional[BtnPressed]):
+    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None, False
+    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN, False
+    PEN_IS_IN_RANGE_WITH_BUTTON = BtnTouch.UP, ToolType.PEN, True
+    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN, False
+    PEN_IS_IN_CONTACT_WITH_BUTTON = BtnTouch.DOWN, ToolType.PEN, True
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER, False
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON = BtnTouch.UP, ToolType.RUBBER, True
+    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER, False
+    PEN_IS_ERASING_WITH_BUTTON = BtnTouch.DOWN, ToolType.RUBBER, True
+
+    def __init__(
+        self, touch: BtnTouch, tool: Optional[ToolType], button: Optional[bool]
+    ):
         self.touch = touch  # type: ignore
         self.tool = tool  # type: ignore
         self.button = button  # type: ignore
 
     @classmethod
-    def from_evdev(cls, evdev) -> "PenState":
+    def from_evdev(cls, evdev, test_button) -> "PenState":
         touch = BtnTouch(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
         tool = None
-        button = None
+        button = False
         if (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
@@ -112,19 +82,20 @@ class PenState(Enum):
         ):
             raise ValueError("2 tools are not allowed")
 
-        # we take only the highest button in account
-        for b in [libevdev.EV_KEY.BTN_STYLUS, libevdev.EV_KEY.BTN_STYLUS2]:
-            if bool(evdev.value[b]):
-                button = BtnPressed(b)
+        # we take only the provided button into account
+        if test_button is not None:
+            button = bool(evdev.value[test_button.value])
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after
         if tool is None:
-            button = None
+            button = False
 
         return cls((touch, tool, button))  # type: ignore
 
-    def apply(self, events: List[libevdev.InputEvent], strict: bool) -> "PenState":
+    def apply(
+        self, events: List[libevdev.InputEvent], strict: bool, test_button: BtnPressed
+    ) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
             raise ValueError("EV_SYN is in the event sequence")
         touch = self.touch
@@ -148,19 +119,16 @@ class PenState(Enum):
                     raise ValueError(f"duplicated BTN_TOOL_* in {events}")
                 tool_found = True
                 tool = ToolType(ev.code) if ev.value else None
-            elif ev in (
-                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS),
-                libevdev.InputEvent(libevdev.EV_KEY.BTN_STYLUS2),
-            ):
+            elif test_button is not None and ev in (test_button.value,):
                 if button_found:
                     raise ValueError(f"duplicated BTN_STYLUS* in {events}")
                 button_found = True
-                button = BtnPressed(ev.code) if ev.value else None
+                button = bool(ev.value)
 
         # the kernel tends to insert an EV_SYN once removing the tool, so
         # the button will be released after
         if tool is None:
-            button = None
+            button = False
 
         new_state = PenState((touch, tool, button))  # type: ignore
         if strict:
@@ -183,11 +151,9 @@ class PenState(Enum):
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
                 PenState.PEN_IS_IN_CONTACT,
                 PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_ERASING,
             )
 
@@ -195,7 +161,6 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_CONTACT,
             )
@@ -204,7 +169,6 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_IN_CONTACT,
                 PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE,
             )
 
@@ -236,21 +200,6 @@ class PenState(Enum):
                 PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
             )
 
-        if self == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
-            return (
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_OUT_OF_RANGE,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-            )
-
-        if self == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
-            return (
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-            )
-
         return tuple()
 
     def historically_tolerated_transitions(self) -> Tuple["PenState", ...]:
@@ -263,11 +212,9 @@ class PenState(Enum):
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
                 PenState.PEN_IS_IN_CONTACT,
                 PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_ERASING,
             )
 
@@ -275,7 +222,6 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_OUT_OF_RANGE,
                 PenState.PEN_IS_IN_CONTACT,
             )
@@ -284,7 +230,6 @@ class PenState(Enum):
             return (
                 PenState.PEN_IS_IN_CONTACT,
                 PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
                 PenState.PEN_IS_IN_RANGE,
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
@@ -319,22 +264,6 @@ class PenState(Enum):
                 PenState.PEN_IS_OUT_OF_RANGE,
             )
 
-        if self == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
-            return (
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_OUT_OF_RANGE,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-            )
-
-        if self == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
-            return (
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_OUT_OF_RANGE,
-            )
-
         return tuple()
 
     @staticmethod
@@ -402,9 +331,9 @@ class PenState(Enum):
         }
 
     @staticmethod
-    def legal_transitions_with_primary_button() -> Dict[str, Tuple["PenState", ...]]:
+    def legal_transitions_with_button() -> Dict[str, Tuple["PenState", ...]]:
         """We revisit the Windows Pen Implementation state machine:
-        we now have a primary button.
+        we now have a button.
         """
         return {
             "hover-button": (PenState.PEN_IS_IN_RANGE_WITH_BUTTON,),
@@ -450,56 +379,6 @@ class PenState(Enum):
             ),
         }
 
-    @staticmethod
-    def legal_transitions_with_secondary_button() -> Dict[str, Tuple["PenState", ...]]:
-        """We revisit the Windows Pen Implementation state machine:
-        we now have a secondary button.
-        Note: we don't looks for 2 buttons interactions.
-        """
-        return {
-            "hover-button": (PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,),
-            "hover-button -> out-of-range": (
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_OUT_OF_RANGE,
-            ),
-            "in-range -> button-press": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-            ),
-            "in-range -> button-press -> button-release": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE,
-            ),
-            "in-range -> touch -> button-press -> button-release": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_CONTACT,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT,
-            ),
-            "in-range -> touch -> button-press -> release -> button-release": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_CONTACT,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE,
-            ),
-            "in-range -> button-press -> touch -> release -> button-release": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_RANGE,
-            ),
-            "in-range -> button-press -> touch -> button-release -> release": (
-                PenState.PEN_IS_IN_RANGE,
-                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
-                PenState.PEN_IS_IN_CONTACT,
-                PenState.PEN_IS_IN_RANGE,
-            ),
-        }
-
     @staticmethod
     def tolerated_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is not adhering to the Windows Pen Implementation state machine
@@ -616,10 +495,21 @@ class Pen(object):
             evdev.value[axis] == value
         ), f"assert evdev.value[{axis}] ({evdev.value[axis]}) != {value}"
 
-    def assert_expected_input_events(self, evdev):
+    def assert_expected_input_events(self, evdev, button):
         assert evdev.value[libevdev.EV_ABS.ABS_X] == self.x
         assert evdev.value[libevdev.EV_ABS.ABS_Y] == self.y
-        assert self.current_state == PenState.from_evdev(evdev)
+
+        # assert no other buttons than the tested ones are set
+        buttons = [
+            BtnPressed.PRIMARY_PRESSED,
+            BtnPressed.SECONDARY_PRESSED,
+        ]
+        if button is not None:
+            buttons.remove(button)
+        for b in buttons:
+            assert evdev.value[b.value] is None or evdev.value[b.value] == False
+
+        assert self.current_state == PenState.from_evdev(evdev, button)
 
 
 class PenDigitizer(base.UHIDTestDevice):
@@ -647,7 +537,7 @@ class PenDigitizer(base.UHIDTestDevice):
                     continue
                 self.fields = [f.usage_name for f in r]
 
-    def move_to(self, pen, state):
+    def move_to(self, pen, state, button):
         # fill in the previous values
         if pen.current_state == PenState.PEN_IS_OUT_OF_RANGE:
             pen.restore()
@@ -690,29 +580,17 @@ class PenDigitizer(base.UHIDTestDevice):
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
-            pen.barrelswitch = True
-            pen.secondarybarrelswitch = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.secondarybarrelswitch = button == BtnPressed.SECONDARY_PRESSED
         elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
             pen.tipswitch = True
             pen.inrange = True
             pen.invert = False
             pen.eraser = False
-            pen.barrelswitch = True
-            pen.secondarybarrelswitch = False
-        elif state == PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON:
-            pen.tipswitch = False
-            pen.inrange = True
-            pen.invert = False
-            pen.eraser = False
-            pen.barrelswitch = False
-            pen.secondarybarrelswitch = True
-        elif state == PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON:
-            pen.tipswitch = True
-            pen.inrange = True
-            pen.invert = False
-            pen.eraser = False
-            pen.barrelswitch = False
-            pen.secondarybarrelswitch = True
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.secondarybarrelswitch = button == BtnPressed.SECONDARY_PRESSED
         elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
             pen.tipswitch = False
             pen.inrange = True
@@ -730,7 +608,7 @@ class PenDigitizer(base.UHIDTestDevice):
 
         pen.current_state = state
 
-    def event(self, pen):
+    def event(self, pen, button):
         rs = []
         r = self.create_report(application=self.cur_application, data=pen)
         self.call_input_event(r)
@@ -771,17 +649,17 @@ class BaseTest:
         def create_device(self):
             raise Exception("please reimplement me in subclasses")
 
-        def post(self, uhdev, pen):
-            r = uhdev.event(pen)
+        def post(self, uhdev, pen, test_button):
+            r = uhdev.event(pen, test_button)
             events = uhdev.next_sync_events()
             self.debug_reports(r, uhdev, events)
             return events
 
         def validate_transitions(
-            self, from_state, pen, evdev, events, allow_intermediate_states
+            self, from_state, pen, evdev, events, allow_intermediate_states, button
         ):
             # check that the final state is correct
-            pen.assert_expected_input_events(evdev)
+            pen.assert_expected_input_events(evdev, button)
 
             state = from_state
 
@@ -794,12 +672,14 @@ class BaseTest:
                 events = events[idx + 1 :]
 
                 # now check for a valid transition
-                state = state.apply(sync_events, not allow_intermediate_states)
+                state = state.apply(sync_events, not allow_intermediate_states, button)
 
             if events:
-                state = state.apply(sync_events, not allow_intermediate_states)
+                state = state.apply(sync_events, not allow_intermediate_states, button)
 
-        def _test_states(self, state_list, scribble, allow_intermediate_states):
+        def _test_states(
+            self, state_list, scribble, allow_intermediate_states, button=None
+        ):
             """Internal method to test against a list of
             transition between states.
             state_list is a list of PenState objects
@@ -812,10 +692,10 @@ class BaseTest:
             cur_state = PenState.PEN_IS_OUT_OF_RANGE
 
             p = Pen(50, 60)
-            uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
-            events = self.post(uhdev, p)
+            uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE, button)
+            events = self.post(uhdev, p, button)
             self.validate_transitions(
-                cur_state, p, evdev, events, allow_intermediate_states
+                cur_state, p, evdev, events, allow_intermediate_states, button
             )
 
             cur_state = p.current_state
@@ -824,18 +704,18 @@ class BaseTest:
                 if scribble and cur_state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1
-                    events = self.post(uhdev, p)
+                    events = self.post(uhdev, p, button)
                     self.validate_transitions(
-                        cur_state, p, evdev, events, allow_intermediate_states
+                        cur_state, p, evdev, events, allow_intermediate_states, button
                     )
                     assert len(events) >= 3  # X, Y, SYN
-                uhdev.move_to(p, state)
+                uhdev.move_to(p, state, button)
                 if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1
-                events = self.post(uhdev, p)
+                events = self.post(uhdev, p, button)
                 self.validate_transitions(
-                    cur_state, p, evdev, events, allow_intermediate_states
+                    cur_state, p, evdev, events, allow_intermediate_states, button
                 )
                 cur_state = p.current_state
 
@@ -874,12 +754,17 @@ class BaseTest:
             "state_list",
             [
                 pytest.param(v, id=k)
-                for k, v in PenState.legal_transitions_with_primary_button().items()
+                for k, v in PenState.legal_transitions_with_button().items()
             ],
         )
         def test_valid_primary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the primary button."""
-            self._test_states(state_list, scribble, allow_intermediate_states=False)
+            self._test_states(
+                state_list,
+                scribble,
+                allow_intermediate_states=False,
+                button=BtnPressed.PRIMARY_PRESSED,
+            )
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
@@ -890,12 +775,17 @@ class BaseTest:
             "state_list",
             [
                 pytest.param(v, id=k)
-                for k, v in PenState.legal_transitions_with_secondary_button().items()
+                for k, v in PenState.legal_transitions_with_button().items()
             ],
         )
         def test_valid_secondary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the secondary button."""
-            self._test_states(state_list, scribble, allow_intermediate_states=False)
+            self._test_states(
+                state_list,
+                scribble,
+                allow_intermediate_states=False,
+                button=BtnPressed.SECONDARY_PRESSED,
+            )
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -956,7 +846,7 @@ class BaseTest:
 
 
 class GXTP_pen(PenDigitizer):
-    def event(self, pen):
+    def event(self, pen, test_button):
         if not hasattr(self, "prev_tip_state"):
             self.prev_tip_state = False
 
@@ -977,7 +867,7 @@ class GXTP_pen(PenDigitizer):
         if pen.eraser:
             internal_pen.invert = False
 
-        return super().event(internal_pen)
+        return super().event(internal_pen, test_button)
 
 
 class USIPen(PenDigitizer):

-- 
2.44.0


