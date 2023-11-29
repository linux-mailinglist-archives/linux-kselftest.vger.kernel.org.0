Return-Path: <linux-kselftest+bounces-835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A57FDB4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A91C20B5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820238DE9;
	Wed, 29 Nov 2023 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed7X4MpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989E249F4;
	Wed, 29 Nov 2023 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52208C433CC;
	Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271524;
	bh=atlZM4BJ8KQy+D392AjQoHShz//qiSp1cvnKJCX3Ivs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ed7X4MpL7h2Q0Nb/a0ndUZr30juQivEfGEe6E21vXmMTPGZ2xplKy4MaLCYkCxZU+
	 gnH35MT9kzRGFlDeWXhU2/CVsR4nk5Z4ck4wmy6gLw/oOs9ot6Q1K9BtjOZCd9onzd
	 X/ohJXRAH6CZ8GfmWJnJpxXRq1LWaxTwVsNtamisj/dGW9ueqEBoqQqtdKBVZA2TrF
	 xZsUbZAdKs3uYvkg9uvsIDPnSZHBrm+8i03t+HSMxRxv5yN5kVy2jy+rUBesHG9TzZ
	 uEG3GJEmJo7urvpgAUzWJd5f+dg494BQ7fAwKe+gaG0EEpgHh6vO8NjfK0xGbVoF9y
	 A1RQSbr7fdKVw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:37 +0100
Subject: [PATCH 12/12] selftests/hid: tablets: be stricter for some
 transitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-12-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=11244;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=atlZM4BJ8KQy+D392AjQoHShz//qiSp1cvnKJCX3Ivs=;
 b=fU6Sr1TqdI77cJF2Qb3FLZAa85LpecFESZGpPsUjHNBON0dpLDRrEuBbVN+unTfuN8vAUY9a/
 kxSicQAgrhGBSQtF+XeAGGGd1zoz2UgjRXX/FCy6I9ZCMg2vcK3nbQY
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

To accommodate for legacy devices, we rely on the last state of a
transition to be valid:
for example when we test PEN_IS_OUT_OF_RANGE to PEN_IS_IN_CONTACT,
any "normal" device that reports an InRange bit would insert a
PEN_IS_IN_RANGE state between the 2.

This is of course valid, but this solution prevents to detect false
releases emitted by some firmware:
when pressing an "eraser mode" button, they might send an extra
PEN_IS_OUT_OF_RANGE that we may want to filter.

So define 2 sets of transitions: one that is the ideal behavior, and
one that is OK, it won't break user space, but we have serious doubts
if we are doing the right thing. And depending on the test, either
ask only for valid transitions, or tolerate weird ones.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 122 +++++++++++++++++++----
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index f24cf2e168a4..625dd9dcb935 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -109,7 +109,7 @@ class PenState(Enum):
 
         return cls((touch, tool, button))
 
-    def apply(self, events) -> "PenState":
+    def apply(self, events, strict) -> "PenState":
         if libevdev.EV_SYN.SYN_REPORT in events:
             raise ValueError("EV_SYN is in the event sequence")
         touch = self.touch
@@ -148,13 +148,97 @@ class PenState(Enum):
             button = None
 
         new_state = PenState((touch, tool, button))
-        assert (
-            new_state in self.valid_transitions()
-        ), f"moving from {self} to {new_state} is forbidden"
+        if strict:
+            assert (
+                new_state in self.valid_transitions()
+            ), f"moving from {self} to {new_state} is forbidden"
+        else:
+            assert (
+                new_state in self.historical_tolerated_transitions()
+            ), f"moving from {self} to {new_state} is forbidden"
 
         return new_state
 
     def valid_transitions(self) -> Tuple["PenState", ...]:
+        """Following the state machine in the URL above.
+
+        Note that those transitions are from the evdev point of view, not HID"""
+        if self == PenState.PEN_IS_OUT_OF_RANGE:
+            return (
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_ERASING,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE:
+            return (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+            )
+
+        if self == PenState.PEN_IS_IN_CONTACT:
+            return (
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            )
+
+        if self == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            return (
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+                PenState.PEN_IS_OUT_OF_RANGE,
+                PenState.PEN_IS_ERASING,
+            )
+
+        if self == PenState.PEN_IS_ERASING:
+            return (
+                PenState.PEN_IS_ERASING,
+                PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+            )
+
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
+            )
+
+        return tuple()
+
+    def historical_tolerated_transitions(self) -> Tuple["PenState", ...]:
         """Following the state machine in the URL above, with a couple of addition
         for skipping the in-range state, due to historical reasons.
 
@@ -678,10 +762,12 @@ class BaseTest:
             self.debug_reports(r, uhdev, events)
             return events
 
-        def validate_transitions(self, from_state, pen, evdev, events):
+        def validate_transitions(self, from_state, pen, evdev, events, allow_intermediate_states):
             # check that the final state is correct
             pen.assert_expected_input_events(evdev)
 
+            state = from_state
+
             # check that the transitions are valid
             sync_events = []
             while libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT) in events:
@@ -691,12 +777,12 @@ class BaseTest:
                 events = events[idx + 1 :]
 
                 # now check for a valid transition
-                from_state = from_state.apply(sync_events)
+                state = state.apply(sync_events, not allow_intermediate_states)
 
             if events:
-                from_state = from_state.apply(sync_events)
+                state = state.apply(sync_events, not allow_intermediate_states)
 
-        def _test_states(self, state_list, scribble):
+        def _test_states(self, state_list, scribble, allow_intermediate_states):
             """Internal method to test against a list of
             transition between states.
             state_list is a list of PenState objects
@@ -711,7 +797,7 @@ class BaseTest:
             p = Pen(50, 60)
             uhdev.move_to(p, PenState.PEN_IS_OUT_OF_RANGE)
             events = self.post(uhdev, p)
-            self.validate_transitions(cur_state, p, evdev, events)
+            self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
 
             cur_state = p.current_state
 
@@ -720,14 +806,14 @@ class BaseTest:
                     p.x += 1
                     p.y -= 1
                     events = self.post(uhdev, p)
-                    self.validate_transitions(cur_state, p, evdev, events)
+                    self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
                     assert len(events) >= 3  # X, Y, SYN
                 uhdev.move_to(p, state)
                 if scribble and state != PenState.PEN_IS_OUT_OF_RANGE:
                     p.x += 1
                     p.y -= 1
                 events = self.post(uhdev, p)
-                self.validate_transitions(cur_state, p, evdev, events)
+                self.validate_transitions(cur_state, p, evdev, events, allow_intermediate_states)
                 cur_state = p.current_state
 
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
@@ -740,7 +826,7 @@ class BaseTest:
             we don't have Invert nor Erase bits, so just move in/out-of-range or proximity.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, False)
 
         @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
         @pytest.mark.parametrize(
@@ -754,7 +840,7 @@ class BaseTest:
             """This is not adhering to the Windows Pen Implementation state machine
             but we should expect the kernel to behave properly, mostly for historical
             reasons."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, True)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Barrel Switch" not in uhdev.fields,
@@ -770,7 +856,7 @@ class BaseTest:
         )
         def test_valid_primary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the primary button."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
@@ -786,7 +872,7 @@ class BaseTest:
         )
         def test_valid_secondary_button_pen_states(self, state_list, scribble):
             """Rework the transition state machine by adding the secondary button."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -806,7 +892,7 @@ class BaseTest:
             to erase.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, False)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -826,7 +912,7 @@ class BaseTest:
             to erase.
             https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
             """
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, True)
 
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
@@ -843,7 +929,7 @@ class BaseTest:
             For example, a pen that has the eraser button might wobble between
             touching and erasing if the tablet doesn't enforce the Windows
             state machine."""
-            self._test_states(state_list, scribble)
+            self._test_states(state_list, scribble, True)
 
 
 class GXTP_pen(PenDigitizer):

-- 
2.41.0


