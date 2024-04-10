Return-Path: <linux-kselftest+bounces-7595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4383189FE65
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F387C2891D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D605194C64;
	Wed, 10 Apr 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dybj+T4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D019069E;
	Wed, 10 Apr 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769627; cv=none; b=mWzVhmoLde9+wOBUVaMqmvTn+g5Q+z6/xBLI1i8d5VZWj1LQOxTLx7pWMnJqOfurhtpwzLcsD0RiHb3GHCyCeSe/5HmkRHcZWlmuJN8WnGQqF5ZqF4MhgCyXxSGD3mChVKDyc5TNLIwkuB5CWIkaKuFaAXd2MA8dgK04y/PzgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769627; c=relaxed/simple;
	bh=cW39rxLL7SNmaGCvHGHkPuHo9w+dGTGLLZl6+MwFSus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjbKOnjF/O+jGlsJagm2a+y+4xBwjDYVlrtTXP+r9sKM8LOP/JFJyJzbpkQ8Hp/EOqkkwzKzQcyHRFCWGyzf8gjep0yV4MkGxcKEOA+QxyBVSl2IAdLRSOR4qsS1PIZ6DTGatwArBJSrN9PHyoAQPr0yWeYWufm5kLIRzTohp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dybj+T4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778BAC433B1;
	Wed, 10 Apr 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769626;
	bh=cW39rxLL7SNmaGCvHGHkPuHo9w+dGTGLLZl6+MwFSus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dybj+T4MZ+9xXcNecuCD8ZyeFdCL0cI8dfA80X31p9Jtktjy0NTiodPrgm4IPCSZc
	 LR78+QVgM6GkQhy/qSwkuggiO7+XpyWZsUXZoomAFNQvW6E/5dJIDSK8UC9zrA3b9F
	 sDfhkogd6x1cO2oNk2Ue1JUEPXrmURtI6PBOEdHnRcVPIkid9YVURZaN2iewx0fR5q
	 lwgaQyFSNd1MJuLQ5zpB731ZPlPexVeNJ9OdRbgOTPYqW1zRHP/9SUKb6UVdWeHLOn
	 A6DE0zMuOv39xBEvc8N17GZWAsPhbNZcjpiGFmR/Sz+N+SEDL7wrmn3/hQVljvgO+V
	 xOMwQ0Z+QfmDQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:38 +0200
Subject: [PATCH 18/18] selftests/hid: add tests for the Raptor Mach 2
 joystick
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-18-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=3284;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cW39rxLL7SNmaGCvHGHkPuHo9w+dGTGLLZl6+MwFSus=;
 b=ywHPEum0yoe1I9JQLPf4Fgbqf+WbEPJv48/GuUbFojAlXhjBfEQsHpTV0VwwNsJ/4bu42zsuZ
 hiQSyFEopFgAAYKB5BvwabsLbDizKbJqfaLUdrQXZGlgT+UOvLjhrQj
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The only interesting bit is the HAT switch, and we use a BPF program
to fix it. So ensure this works correctly.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_gamepad.py | 47 ++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/test_gamepad.py b/tools/testing/selftests/hid/tests/test_gamepad.py
index bd30dadbeb7d..8d5b5ffdae49 100644
--- a/tools/testing/selftests/hid/tests/test_gamepad.py
+++ b/tools/testing/selftests/hid/tests/test_gamepad.py
@@ -10,7 +10,7 @@ from . import base
 import libevdev
 import pytest
 
-from .base_gamepad import BaseGamepad, JoystickGamepad
+from .base_gamepad import BaseGamepad, JoystickGamepad, AxisMapping
 from hidtools.util import BusType
 
 import logging
@@ -609,6 +609,40 @@ class AsusGamepad(BaseGamepad):
         self.buttons = (1, 2, 4, 5, 7, 8, 14, 15, 13)
 
 
+class RaptorMach2Joystick(JoystickGamepad):
+    axes_map = {
+        "left_stick": {
+            "x": AxisMapping("x"),
+            "y": AxisMapping("y"),
+        },
+        "right_stick": {
+            "x": AxisMapping("z"),
+            "y": AxisMapping("Rz"),
+        },
+    }
+
+    def __init__(
+        self,
+        name,
+        rdesc=None,
+        application="Joystick",
+        input_info=(BusType.USB, 0x11C0, 0x5606),
+    ):
+        super().__init__(rdesc, application, name, input_info)
+        self.buttons = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
+        self.hat_switch = 240  # null value is 240 as max is 239
+
+    def event(
+        self, *, left=(None, None), right=(None, None), hat_switch=None, buttons=None
+    ):
+        if hat_switch is not None:
+            hat_switch *= 30
+
+        return super().event(
+            left=left, right=right, hat_switch=hat_switch, buttons=buttons
+        )
+
+
 class TestSaitekGamepad(BaseTest.TestGamepad):
     def create_device(self):
         return SaitekGamepad()
@@ -617,3 +651,14 @@ class TestSaitekGamepad(BaseTest.TestGamepad):
 class TestAsusGamepad(BaseTest.TestGamepad):
     def create_device(self):
         return AsusGamepad()
+
+
+class TestRaptorMach2Joystick(BaseTest.TestGamepad):
+    hid_bpfs = [("FR-TEC__Raptor-Mach-2.bpf.o", True)]
+
+    def create_device(self):
+        return RaptorMach2Joystick(
+            "uhid test Sanmos Group FR-TEC Raptor MACH 2",
+            rdesc="05 01 09 04 a1 01 05 01 85 01 05 01 09 30 75 10 95 01 15 00 26 ff 07 46 ff 07 81 02 05 01 09 31 75 10 95 01 15 00 26 ff 07 46 ff 07 81 02 05 01 09 33 75 10 95 01 15 00 26 ff 03 46 ff 03 81 02 05 00 09 00 75 10 95 01 15 00 26 ff 03 46 ff 03 81 02 05 01 09 32 75 10 95 01 15 00 26 ff 03 46 ff 03 81 02 05 01 09 35 75 10 95 01 15 00 26 ff 03 46 ff 03 81 02 05 01 09 34 75 10 95 01 15 00 26 ff 07 46 ff 07 81 02 05 01 09 36 75 10 95 01 15 00 26 ff 03 46 ff 03 81 02 05 09 19 01 2a 1d 00 15 00 25 01 75 01 96 80 00 81 02 05 01 09 39 26 ef 00 46 68 01 65 14 75 10 95 01 81 42 05 01 09 00 75 08 95 1d 81 01 15 00 26 ef 00 85 58 26 ff 00 46 ff 00 75 08 95 3f 09 00 91 02 85 59 75 08 95 80 09 00 b1 02 c0",
+            input_info=(BusType.USB, 0x11C0, 0x5606),
+        )

-- 
2.44.0


