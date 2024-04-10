Return-Path: <linux-kselftest+bounces-7590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5DF89FE51
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE8B1C23164
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA461836D5;
	Wed, 10 Apr 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4eCElQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E51836CF;
	Wed, 10 Apr 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769618; cv=none; b=L84ibo0B0mPRUxfyyNJRXeOzb1d7lC0uj4ye8uKk/Ozx7fCUC4EfifbwTd116eierEa7tAtfdlFKTrst1GkO02uF+le3qCsnJOl2mbbnfYaftamL9RpqPcOZu4vjsuGJW3b2rFS6sRW3UaeHmQExsaL7eg5boodFPlWKb5rTuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769618; c=relaxed/simple;
	bh=NRjDhzfLqC2R4odsgxweyRIqdiNBxTSqNtx3waczKaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWNNCyHdVjMoLrwC6vIg4JyXMPNo+4HlBdZMmwQH79eCdn/BRDDI2dFpyrBL/4kJHhmSTCwZSfdzNIf7/BjxHd/cT/pybasCykg+uP5tOvNFwaB4uLPA/cj1Jlbcy3xxoKkfKSQXBUPtj4X7gY04o2sjTSUOOv22jPno0yc+9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4eCElQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEFBC433F1;
	Wed, 10 Apr 2024 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769617;
	bh=NRjDhzfLqC2R4odsgxweyRIqdiNBxTSqNtx3waczKaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k4eCElQLoQFnG5yBLhLasiNlX3OpjWMea7xonPaGMmGxBB+rbEC9I+2WUtB4Pmzzy
	 zSF/pIECOt+hYt2teOvAkw1uIsC8UurdFwriCyKcLcQSzw2o0KP0jCZExyckzAJvdz
	 xycB89afbhJVW60uSz40vJ1WbR7eNmmM3CAj12BWZMvVSaAcZM/RkqvvnPon66BuIB
	 S5l5J2G7qX/Hw2DAyh9kJhvMVP0Su/HD4FO23Kv/RjD6utN1vVRdl3X2f6XvDE1JnM
	 JceituV17NNnOo0ldpXGR+3PHjWYJsPbbCL3JY7LnHIlk8BF5ts2NOMLDvkc0kPLlJ
	 6IsUGC8fnYKQg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:33 +0200
Subject: [PATCH 13/18] selftests/hid: tablets: add a couple of XP-PEN
 tablets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-13-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=14364;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=NRjDhzfLqC2R4odsgxweyRIqdiNBxTSqNtx3waczKaM=;
 b=cLdfBOwapGFLfIkyFxsCzNQoydneS1IZp2rQRTinP2lDL5ESeWdNsN0m0C6y2njOnbTpiDXoA
 qnN2dDUKGVmCUoWW7JML+FG5j/uoZZ7xS+FiC06dUF8kIEkLRWj+PSD
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Those tablets don't need special initialization, but are reporting
the events with the wrong usages:
- tip switch is used when the eraser should be used
- eraser is used instead of the secondary barrel switch

Add tests for those so we don't regress in the future.

Currently we set x/y tilt to 0 to not trigger the bpf program
compensate_coordinates_by_tilt()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 246 +++++++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index df1134e5713c..e265f1d4e089 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -874,6 +874,229 @@ class USIPen(PenDigitizer):
     pass
 
 
+class XPPen_ArtistPro16Gen2_28bd_095b(PenDigitizer):
+    """
+    Pen with two buttons and a rubber end, but which reports
+    the second button as an eraser
+    """
+
+    def __init__(
+        self,
+        name,
+        rdesc_str=None,
+        rdesc=None,
+        application="Pen",
+        physical="Stylus",
+        input_info=(BusType.USB, 0x28BD, 0x095B),
+        evdev_name_suffix=None,
+    ):
+        super().__init__(
+            name, rdesc_str, rdesc, application, physical, input_info, evdev_name_suffix
+        )
+        self.fields.append("Secondary Barrel Switch")
+
+    def move_to(self, pen, state, button):
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
+            pen.xtilt = 0
+            pen.ytilt = 0
+            pen.twist = 0
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.eraser = button == BtnPressed.SECONDARY_PRESSED
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.eraser = button == BtnPressed.SECONDARY_PRESSED
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_ERASING_INTENT:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = False
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_ERASING:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = True
+            pen.eraser = False
+            pen.barrelswitch = False
+
+        pen.xtilt = 0
+        pen.ytilt = 0
+        pen.current_state = state
+
+
+class XPPen_Artist24_28bd_093a(PenDigitizer):
+    """
+    Pen that reports secondary barrel switch through eraser
+    """
+
+    def __init__(
+        self,
+        name,
+        rdesc_str=None,
+        rdesc=None,
+        application="Pen",
+        physical="Stylus",
+        input_info=(BusType.USB, 0x28BD, 0x093A),
+        evdev_name_suffix=None,
+    ):
+        super().__init__(
+            name, rdesc_str, rdesc, application, physical, input_info, evdev_name_suffix
+        )
+        self.fields.append("Secondary Barrel Switch")
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
+        elif state == PenState.PEN_IS_IN_RANGE:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_IN_CONTACT:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            pen.eraser = False
+            pen.barrelswitch = False
+        elif state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+            pen.tipswitch = False
+            pen.inrange = True
+            pen.invert = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.eraser = button == BtnPressed.SECONDARY_PRESSED
+        elif state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+            pen.tipswitch = True
+            pen.inrange = True
+            pen.invert = False
+            assert button is not None
+            pen.barrelswitch = button == BtnPressed.PRIMARY_PRESSED
+            pen.eraser = button == BtnPressed.SECONDARY_PRESSED
+
+        pen.current_state = state
+
+    def send_intermediate_state(self, pen, state, button):
+        intermediate_pen = copy.copy(pen)
+        self.move_to(intermediate_pen, state, button, debug=False)
+        return super().event(intermediate_pen, button)
+
+    def event(self, pen, button):
+        rs = []
+
+        # the pen reliably sends in-range events in a normal case (non emulation of eraser mode)
+        if self.previous_state == PenState.PEN_IS_IN_CONTACT:
+            if pen.current_state == PenState.PEN_IS_OUT_OF_RANGE:
+                rs.extend(
+                    self.send_intermediate_state(pen, PenState.PEN_IS_IN_RANGE, button)
+                )
+
+        if button == BtnPressed.SECONDARY_PRESSED:
+            if self.previous_state == PenState.PEN_IS_IN_RANGE:
+                if pen.current_state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_OUT_OF_RANGE, button
+                        )
+                    )
+
+            if self.previous_state == PenState.PEN_IS_IN_RANGE_WITH_BUTTON:
+                if pen.current_state == PenState.PEN_IS_IN_RANGE:
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_OUT_OF_RANGE, button
+                        )
+                    )
+
+            if self.previous_state == PenState.PEN_IS_IN_CONTACT:
+                if pen.current_state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_OUT_OF_RANGE, button
+                        )
+                    )
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_IN_RANGE_WITH_BUTTON, button
+                        )
+                    )
+
+            if self.previous_state == PenState.PEN_IS_IN_CONTACT_WITH_BUTTON:
+                if pen.current_state == PenState.PEN_IS_IN_CONTACT:
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_OUT_OF_RANGE, button
+                        )
+                    )
+                    rs.extend(
+                        self.send_intermediate_state(
+                            pen, PenState.PEN_IS_IN_RANGE, button
+                        )
+                    )
+
+        rs.extend(super().event(pen, button))
+        self.previous_state = pen.current_state
+        return rs
+
+
 ################################################################################
 #
 # Windows 7 compatible devices
@@ -1052,3 +1275,26 @@ class TestGoodix_27c6_0e00(BaseTest.TestTablet):
             rdesc="05 0d 09 04 a1 01 85 01 09 22 a1 02 55 0e 65 11 35 00 15 00 09 42 25 01 75 01 95 01 81 02 25 7f 09 30 75 07 81 42 95 01 75 08 09 51 81 02 75 10 05 01 26 04 20 46 e6 09 09 30 81 02 26 60 15 46 9a 06 09 31 81 02 05 0d 55 0f 75 08 25 ff 45 ff 09 48 81 42 09 49 81 42 55 0e c0 09 22 a1 02 09 42 25 01 75 01 95 01 81 02 25 7f 09 30 75 07 81 42 95 01 75 08 09 51 81 02 75 10 05 01 26 04 20 46 e6 09 09 30 81 02 26 60 15 46 9a 06 09 31 81 02 05 0d 55 0f 75 08 25 ff 45 ff 09 48 81 42 09 49 81 42 55 0e c0 09 22 a1 02 09 42 25 01 75 01 95 01 81 02 25 7f 09 30 75 07 81 42 95 01 75 08 09 51 81 02 75 10 05 01 26 04 20 46 e6 09 09 30 81 02 26 60 15 46 9a 06 09 31 81 02 05 0d 55 0f 75 08 25 ff 45 ff 09 48 81 42 09 49 81 42 55 0e c0 09 22 a1 02 09 42 15 00 25 01 75 01 95 01 81 02 25 7f 09 30 75 07 81 42 75 08 09 51 95 01 81 02 05 01 26 04 20 75 10 55 0e 65 11 09 30 35 00 46 e6 09 81 02 26 60 15 46 9a 06 09 31 81 02 05 0d 55 0f 75 08 25 ff 45 ff 09 48 81 42 09 49 81 42 55 0e c0 09 22 
 a1 02 09 42 15 00 25 01 75 01 95 01 81 02 25 7f 09 30 75 07 81 42 75 08 09 51 95 01 81 02 05 01 26 04 20 75 10 55 0e 65 11 09 30 35 00 46 e6 09 81 02 26 60 15 46 9a 06 09 31 81 02 05 0d 55 0f 75 08 25 ff 45 ff 09 48 81 42 09 49 81 42 55 0e c0 09 54 15 00 25 7f 75 08 95 01 81 02 85 02 09 55 95 01 25 0a b1 02 85 03 06 00 ff 09 c5 15 00 26 ff 00 75 08 96 00 01 b1 02 c0 05 0d 09 02 a1 01 09 20 a1 00 85 08 05 01 a4 09 30 35 00 46 e6 09 15 00 26 04 20 55 0d 65 13 75 10 95 01 81 02 09 31 46 9a 06 26 60 15 81 02 b4 05 0d 09 38 95 01 75 08 15 00 25 01 81 02 09 30 75 10 26 ff 0f 81 02 09 31 81 02 09 42 09 44 09 5a 09 3c 09 45 09 32 75 01 95 06 25 01 81 02 95 02 81 03 09 3d 55 0e 65 14 36 d8 dc 46 28 23 16 d8 dc 26 28 23 95 01 75 10 81 02 09 3e 81 02 09 41 15 00 27 a0 8c 00 00 35 00 47 a0 8c 00 00 81 02 05 20 0a 53 04 65 00 16 01 f8 26 ff 07 75 10 95 01 81 02 0a 54 04 81 02 0a 55 04 81 02 0a 57 04 81 02 0a 58 04 81 02 0a 59 04 81 02 0a 72 04 81 02 0a 73 04 81 02 0a 74 04 81 02 05 0d 09 3b 15 0
 0 25 64 75 08 81 02 09 5b 25 ff 75 40 81 02 06 00 ff 09 5b 75 20 81 02 05 0d 09 5c 26 ff 00 75 08 81 02 09 5e 81 02 09 70 a1 02 15 01 25 06 09 72 09 73 09 74 09 75 09 76 09 77 81 20 c0 06 00 ff 09 01 15 00 27 ff ff 00 00 75 10 95 01 81 02 85 09 09 81 a1 02 09 81 15 01 25 04 09 82 09 83 09 84 09 85 81 20 c0 85 10 09 5c a1 02 15 00 25 01 75 08 95 01 09 38 b1 02 09 5c 26 ff 00 b1 02 09 5d 75 01 95 01 25 01 b1 02 95 07 b1 03 c0 85 11 09 5e a1 02 09 38 15 00 25 01 75 08 95 01 b1 02 09 5e 26 ff 00 b1 02 09 5f 75 01 25 01 b1 02 75 07 b1 03 c0 85 12 09 70 a1 02 75 08 95 01 15 00 25 01 09 38 b1 02 09 70 a1 02 25 06 09 72 09 73 09 74 09 75 09 76 09 77 b1 20 c0 09 71 75 01 25 01 b1 02 75 07 b1 03 c0 85 13 09 80 15 00 25 ff 75 40 95 01 b1 02 85 14 09 44 a1 02 09 38 75 08 95 01 25 01 b1 02 15 01 25 03 09 44 a1 02 09 a4 09 44 09 5a 09 45 09 a3 b1 20 c0 09 5a a1 02 09 a4 09 44 09 5a 09 45 09 a3 b1 20 c0 09 45 a1 02 09 a4 09 44 09 5a 09 45 09 a3 b1 20 c0 c0 85 15 75 08 95 01 05 0d 09 90 a1 02 09 38
  25 01 b1 02 09 91 75 10 26 ff 0f b1 02 09 92 75 40 25 ff b1 02 05 06 09 2a 75 08 26 ff 00 a1 02 09 2d b1 02 09 2e b1 02 c0 c0 85 16 05 06 09 2b a1 02 05 0d 25 01 09 38 b1 02 05 06 09 2b a1 02 09 2d 26 ff 00 b1 02 09 2e b1 02 c0 c0 85 17 06 00 ff 09 01 a1 02 05 0d 09 38 75 08 95 01 25 01 b1 02 06 00 ff 09 01 75 10 27 ff ff 00 00 b1 02 c0 85 18 05 0d 09 38 75 08 95 01 15 00 25 01 b1 02 c0 c0 06 f0 ff 09 01 a1 01 85 0e 09 01 15 00 25 ff 75 08 95 40 91 02 09 01 15 00 25 ff 75 08 95 40 81 02 c0",
             input_info=(BusType.I2C, 0x27C6, 0x0E00),
         )
+
+
+class TestXPPen_ArtistPro16Gen2_28bd_095b(BaseTest.TestTablet):
+    hid_bpfs = [("XPPen__ArtistPro16Gen2.bpf.o", True)]
+
+    def create_device(self):
+        dev = XPPen_ArtistPro16Gen2_28bd_095b(
+            "uhid test XPPen Artist Pro 16 Gen2 28bd 095b",
+            rdesc="05 0d 09 02 a1 01 85 07 09 20 a1 00 09 42 09 44 09 45 09 3c 15 00 25 01 75 01 95 04 81 02 95 01 81 03 09 32 15 00 25 01 95 01 81 02 95 02 81 03 75 10 95 01 35 00 a4 05 01 09 30 65 13 55 0d 46 ff 34 26 ff 7f 81 02 09 31 46 20 21 26 ff 7f 81 02 b4 09 30 45 00 26 ff 3f 81 42 09 3d 15 81 25 7f 75 08 95 01 81 02 09 3e 15 81 25 7f 81 02 c0 c0",
+            input_info=(BusType.USB, 0x28BD, 0x095B),
+        )
+        return dev
+
+
+class TestXPPen_Artist24_28bd_093a(BaseTest.TestTablet):
+    hid_bpfs = [("XPPen__Artist24.bpf.o", True)]
+
+    def create_device(self):
+        return XPPen_Artist24_28bd_093a(
+            "uhid test XPPen Artist 24 28bd 093a",
+            rdesc="05 0d 09 02 a1 01 85 07 09 20 a1 00 09 42 09 44 09 45 15 00 25 01 75 01 95 03 81 02 95 02 81 03 09 32 95 01 81 02 95 02 81 03 75 10 95 01 35 00 a4 05 01 09 30 65 13 55 0d 46 f0 50 26 ff 7f 81 02 09 31 46 91 2d 26 ff 7f 81 02 b4 09 30 45 00 26 ff 1f 81 42 09 3d 15 81 25 7f 75 08 95 01 81 02 09 3e 15 81 25 7f 81 02 c0 c0",
+            input_info=(BusType.USB, 0x28BD, 0x093A),
+        )

-- 
2.44.0


