Return-Path: <linux-kselftest+bounces-7592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989C89FE58
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6E81C22DD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E9184114;
	Wed, 10 Apr 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChRgLV/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46218410E;
	Wed, 10 Apr 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769621; cv=none; b=B/fDUuVf4vElzGr6tATw0MIbN/0RWamBda1UFoCCF1SxySdKRYAdhlNKUhP85/44ONgeaNXxAPSI0XMVWAYbcEYvhJvZC+okC9nhy7a4WC8Auqb+Mjn025FxLkkOY3AeGzCT1rwFzLZo2MKGIaFvn6TK8/9r5cJiPg0ISXYJWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769621; c=relaxed/simple;
	bh=eaLwUsiQhpQncjBh/ztlPTIcfYgIUqDIhIkdSA2ETsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqwMtHHMPRe+vcLQ095RJP7tz9BsS0B3ghctaUgXg7UgTcrE2lIntcYZTkI9YWTuWFTEpSzi0ox53eXnnTs7a+1JsysYuo+LQoLk4ri81XsFBpKr7okNnw6k+AG8EUHjVyEAXWZhM0d9P09w4mykmwtKyu2668genCHqee8yPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChRgLV/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13BBC433F1;
	Wed, 10 Apr 2024 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769621;
	bh=eaLwUsiQhpQncjBh/ztlPTIcfYgIUqDIhIkdSA2ETsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ChRgLV/XXqOfsManXmpzISiU8OXVGG4rOzmaJqu7v9tCp5BWYKb8MGMmYVGjni4pF
	 quh8OIFLb7/lFEFmg3030zVfTq1beFOPsIf6gZY7DqRyPFOp2tzrny/yHm+DdJ6HH7
	 ZepAqOJnqeOxekFEFOttekv9s5eOU5j/Vrej8WnSs+kLI+uYzTDbx+4FLsMXqndD5M
	 xL4xFyR4226tYoEOvIEf02yxYaSpYe25ZPnEdxC/cWgUM87F8H3MlW5/SGiP1aTidg
	 BgWveen/cfEXzism8OJhKeRFcXNBtQexr9qBrDeximF6DFzMv+/l0PDk7C9Tx5+L7v
	 ij3eKX81HTijQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:35 +0200
Subject: [PATCH 15/18] selftests/hid: add Huion Kamvas Pro 19 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-15-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=10625;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eaLwUsiQhpQncjBh/ztlPTIcfYgIUqDIhIkdSA2ETsI=;
 b=uaDzjxfKQp+tnA6PU81GkZASASb1SYj7VRkDTzPILKuSkE2bfYbDEX+ILc4sy8Gwy4g1j69em
 oqxPjKx3M5NBOhD9r/eA/myIaygaB8oC5dJfJvoNXWQcLymqN7Hy/LA
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This tablets gets a lot of things wrong:
- the secondary button is reported through Secondary Tip Switch
- the third button is reported through Invert

We need to add some out of proximity intermediate state when moving
back and forth with the eraser mode as it can only be triggered by
physically returning the pen, meaning that the tolerated transitions
can never happen.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 191 +++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index ae0eda9cd3d8..a9e2de1e8861 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -35,6 +35,7 @@ class BtnPressed(Enum):
 
     PRIMARY_PRESSED = libevdev.EV_KEY.BTN_STYLUS
     SECONDARY_PRESSED = libevdev.EV_KEY.BTN_STYLUS2
+    THIRD_PRESSED = libevdev.EV_KEY.BTN_STYLUS3
 
 
 class PenState(Enum):
@@ -503,6 +504,7 @@ class Pen(object):
         buttons = [
             BtnPressed.PRIMARY_PRESSED,
             BtnPressed.SECONDARY_PRESSED,
+            BtnPressed.THIRD_PRESSED,
         ]
         if button is not None:
             buttons.remove(button)
@@ -787,6 +789,27 @@ class BaseTest:
                 button=BtnPressed.SECONDARY_PRESSED,
             )
 
+        @pytest.mark.skip_if_uhdev(
+            lambda uhdev: "Third Barrel Switch" not in uhdev.fields,
+            "Device not compatible, missing Third Barrel Switch usage",
+        )
+        @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
+        @pytest.mark.parametrize(
+            "state_list",
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.legal_transitions_with_button().items()
+            ],
+        )
+        def test_valid_third_button_pen_states(self, state_list, scribble):
+            """Rework the transition state machine by adding the secondary button."""
+            self._test_states(
+                state_list,
+                scribble,
+                allow_intermediate_states=False,
+                button=BtnPressed.THIRD_PRESSED,
+            )
+
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
             "Device not compatible, missing Invert usage",
@@ -1111,6 +1134,163 @@ class XPPen_Artist24_28bd_093a(PenDigitizer):
         return rs
 
 
+class Huion_Kamvas_Pro_19_256c_006b(PenDigitizer):
+    """
+    Pen that reports secondary barrel switch through secondary TipSwtich
+    and 3rd button through Invert
+    """
+
+    def __init__(
+        self,
+        name,
+        rdesc_str=None,
+        rdesc=None,
+        application="Stylus",
+        physical=None,
+        input_info=(BusType.USB, 0x256C, 0x006B),
+        evdev_name_suffix=None,
+    ):
+        super().__init__(
+            name, rdesc_str, rdesc, application, physical, input_info, evdev_name_suffix
+        )
+        self.fields.append("Secondary Barrel Switch")
+        self.fields.append("Third Barrel Switch")
+        self.previous_state = PenState.PEN_IS_OUT_OF_RANGE
+
+    def move_to(self, pen, state, button, debug=True):
+        # fill in the previous values
+        if pen.current_state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.restore()
+
+        if debug:
+            print(f"\n  *** pen is moving to {state} ***")
+
+        if state == PenState.PEN_IS_OUT_OF_RANGE:
+            pen.backup()
+            pen.tipswitch = False
+            pen.tippressure = 0
+            pen.azimuth = 0
+            pen.inrange = False
+            pen.width = 0
+            pen.height = 0
+            pen.invert = False
+            pen.eraser = False
+            pen.xtilt = 0
+            pen.ytilt = 0
+            pen.twist = 0
+            pen.barrelswitch = False
+            pen.secondarytipswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarytipswitch = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarytipswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.eraser = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.secondarytipswitch = button == BtnPressed.SECONDARY_PRESSED
+            pen.invert = button == BtnPressed.THIRD_PRESSED
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.eraser = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.secondarytipswitch = button == BtnPressed.SECONDARY_PRESSED
+            pen.invert = button == BtnPressed.THIRD_PRESSED
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = False
+            pen.barrelswitch = False
+            pen.secondarytipswitch = False
+        elif state == PenState.PEN_IS_ERASING:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = True
+            pen.barrelswitch = False
+            pen.secondarytipswitch = False
+
+        pen.current_state = state
+
+    def call_input_event(self, report):
+        if report[0] == 0x0a:
+            # ensures the original second Eraser usage is null
+            report[1] &= 0xdf
+
+            # ensures the original last bit is equal to bit 6 (In Range)
+            if report[1] & 0x40:
+                report[1] |= 0x80
+
+        super().call_input_event(report)
+
+    def send_intermediate_state(self, pen, state, test_button):
+        intermediate_pen = copy.copy(pen)
+        self.move_to(intermediate_pen, state, test_button, debug=False)
+        return super().event(intermediate_pen, test_button)
+
+    def event(self, pen, button):
+        rs = []
+
+        # it's not possible to go between eraser mode or not without
+        # going out-of-prox: the eraser mode is activated by presenting
+        # the tail of the pen
+        if self.previous_state in (
+            PenState.PEN_IS_IN_RANGE,
+            PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+            PenState.PEN_IS_IN_CONTACT,
+            PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+        ) and pen.current_state in (
+            PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+            PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON,
+            PenState.PEN_IS_ERASING,
+            PenState.PEN_IS_ERASING_WITH_BUTTON,
+        ):
+            rs.extend(
+                self.send_intermediate_state(pen, PenState.PEN_IS_OUT_OF_RANGE, button)
+            )
+
+        # same than above except from eraser to normal
+        if self.previous_state in (
+            PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT,
+            PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT_WITH_BUTTON,
+            PenState.PEN_IS_ERASING,
+            PenState.PEN_IS_ERASING_WITH_BUTTON,
+        ) and pen.current_state in (
+            PenState.PEN_IS_IN_RANGE,
+            PenState.PEN_IS_IN_RANGE_WITH_BUTTON,
+            PenState.PEN_IS_IN_CONTACT,
+            PenState.PEN_IS_IN_CONTACT_WITH_BUTTON,
+        ):
+            rs.extend(
+                self.send_intermediate_state(pen, PenState.PEN_IS_OUT_OF_RANGE, button)
+            )
+
+        if self.previous_state == PenState.PEN_IS_OUT_OF_RANGE:
+            if pen.current_state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+                rs.extend(
+                    self.send_intermediate_state(pen, PenState.PEN_IS_IN_RANGE, button)
+                )
+
+        rs.extend(super().event(pen, button))
+        self.previous_state = pen.current_state
+        return rs
+
+
 ################################################################################
 #
 # Windows 7 compatible devices
@@ -1312,3 +1492,14 @@ class TestXPPen_Artist24_28bd_093a(BaseTest.TestTablet):
             rdesc="05 0d 09 02 a1 01 85 07 09 20 a1 00 09 42 09 44 09 45 15 00 25 01 75 01 95 03 81 02 95 02 81 03 09 32 95 01 81 02 95 02 81 03 75 10 95 01 35 00 a4 05 01 09 30 65 13 55 0d 46 f0 50 26 ff 7f 81 02 09 31 46 91 2d 26 ff 7f 81 02 b4 09 30 45 00 26 ff 1f 81 42 09 3d 15 81 25 7f 75 08 95 01 81 02 09 3e 15 81 25 7f 81 02 c0 c0",
             input_info=(BusType.USB, 0x28BD, 0x093A),
         )
+
+
+class TestHuion_Kamvas_Pro_19_256c_006b(BaseTest.TestTablet):
+    hid_bpfs = [("Huion__Kamvas-Pro-19.bpf.o", True)]
+
+    def create_device(self):
+        return Huion_Kamvas_Pro_19_256c_006b(
+            "uhid test HUION Huion Tablet_GT1902",
+            rdesc="05 0d 09 02 a1 01 85 0a 09 20 a1 01 09 42 09 44 09 43 09 3c 09 45 15 00 25 01 75 01 95 06 81 02 09 32 75 01 95 01 81 02 81 03 05 01 09 30 09 31 55 0d 65 33 26 ff 7f 35 00 46 00 08 75 10 95 02 81 02 05 0d 09 30 26 ff 3f 75 10 95 01 81 02 09 3d 09 3e 15 a6 25 5a 75 08 95 02 81 02 c0 c0 05 0d 09 04 a1 01 85 04 09 22 a1 02 05 0d 95 01 75 06 09 51 15 00 25 3f 81 02 09 42 25 01 75 01 95 01 81 02 75 01 95 01 81 03 05 01 75 10 55 0e 65 11 09 30 26 ff 7f 35 00 46 15 0c 81 42 09 31 26 ff 7f 46 cb 06 81 42 05 0d 09 30 26 ff 1f 75 10 95 01 81 02 c0 05 0d 09 22 a1 02 05 0d 95 01 75 06 09 51 15 00 25 3f 81 02 09 42 25 01 75 01 95 01 81 02 75 01 95 01 81 03 05 01 75 10 55 0e 65 11 09 30 26 ff 7f 35 00 46 15 0c 81 42 09 31 26 ff 7f 46 cb 06 81 42 05 0d 09 30 26 ff 1f 75 10 95 01 81 02 c0 05 0d 09 56 55 00 65 00 27 ff ff ff 7f 95 01 75 20 81 02 09 54 25 7f 95 01 75 08 81 02 75 08 95 08 81 03 85 05 09 55 25 0a 75 08 95 01 b1 02 06 00 ff 09 c5 85 06 15 00 26 ff 00 75 08 96 00 01 b1 
 02 c0",
+            input_info=(BusType.USB, 0x256C, 0x006B),
+        )

-- 
2.44.0


