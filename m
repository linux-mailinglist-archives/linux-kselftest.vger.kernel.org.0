Return-Path: <linux-kselftest+bounces-36974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31366B004B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C035A7D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058E273D6F;
	Thu, 10 Jul 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozLfUdyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E9273D63;
	Thu, 10 Jul 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156148; cv=none; b=Co7wTAkO2ugNRRgKd0+lQ6Mz/d4hlB8hAyJZub1NAoiR2E/sNTRa5U68pl9eis+tdZLVDUogHjHnkBrisHqWGchGBvIf+XZmaLfzVJrqjLMnzWHbe9JGOdmy9NPy2M0KRf7x9bVzOvxhobXhNQDkcPOgYp+9a0zEVodvSQcyt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156148; c=relaxed/simple;
	bh=Z/uh8QYTHUIycpqei8dYAc94cZqurHyKG8OweVUhElA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2qxG6RFJN1N49seo+HFrzw85irgqWNJHwyhN//rXpXwQudjiyWUQ/csv+H1Z7LW5U5nTI9Woxz+rZCLaV9BDYX2uNDfKBzjwfBdnfu9VV0uhGa+iUETHLNOhkBl/L7T4ifYbNVKiQPLj3GuhP9La9ooO8IdSW8jy8z4CaG5QKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozLfUdyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23D6C4CEF5;
	Thu, 10 Jul 2025 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156148;
	bh=Z/uh8QYTHUIycpqei8dYAc94cZqurHyKG8OweVUhElA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ozLfUdyuWTQ1IqFw+EaC8SWsiWf/i7x66/KYx/xE+gCO/mVxzEuuBX5bwXux/bbks
	 giH7TnysAvChJjdQHu77Y1c1Sr4ecekKlfku0yvC/HVExRuANm3y/G+FE7w+09vApO
	 9s/YDL/KjHAlQSL9lOSGo3mTr9fECdroQKl+jiOB9ZEeMl3N/4vBCWogQsEwn+XugR
	 XJg5cJnJ833EOKsTg/yUw9EVRUziXVpOhG7jkM1FRVaQcIC5DVWBui9v5FJozW5Hrw
	 r/XtsVdkeCkGs7CGbqh5b+POexqbHLdXy2PRapfBGETW9FSNtfOWpag3lKa1+W/v+S
	 dezDAfykP/pVQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 10 Jul 2025 16:01:36 +0200
Subject: [PATCH v2 4/4] selftests/hid: add a test case for the recent
 syzbot underflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-report-size-null-v2-4-ccf922b7c4e5@kernel.org>
References: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
In-Reply-To: <20250710-report-size-null-v2-0-ccf922b7c4e5@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752156138; l=3864;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Z/uh8QYTHUIycpqei8dYAc94cZqurHyKG8OweVUhElA=;
 b=Z6jRKllfbgYwYmST03JECWzxOjanGelU/tFEEiHSYTZBV9r+XbkjeHk4sk0eB84hZwChenPSK
 fu4ah7R8SCVCdhSUkKggnT1CW0tmOcnxJmnbAT2Zm1I4Dj++p5pwUan
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Syzbot found a buffer underflow in __hid_request(). Add a related test
case for it.

It's not perfect, but it allows to catch a corner case when a report
descriptor is crafted so that it has a size of 0.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_mouse.py | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_mouse.py b/tools/testing/selftests/hid/tests/test_mouse.py
index 66daf7e5975ca50f0b065080669d7f6123fb177f..eb4e15a0e53bd5f3c8e0ea02365ff9da7eead93d 100644
--- a/tools/testing/selftests/hid/tests/test_mouse.py
+++ b/tools/testing/selftests/hid/tests/test_mouse.py
@@ -439,6 +439,68 @@ class BadResolutionMultiplierMouse(ResolutionMultiplierMouse):
         return 32  # EPIPE
 
 
+class BadReportDescriptorMouse(BaseMouse):
+    """
+    This "device" was one autogenerated by syzbot. There are a lot of issues in
+    it, and the most problematic is that it declares features that have no
+    size.
+
+    This leads to report->size being set to 0 and can mess up with usbhid
+    internals.  Fortunately, uhid merely passes the incoming buffer, without
+    touching it so a buffer of size 0 will be translated to [] without
+    triggering a kernel oops.
+
+    Because the report descriptor is wrong, no input are created, and we need
+    to tweak a little bit the parameters to make it look correct.
+    """
+
+    # fmt: off
+    report_descriptor = [
+        0x96, 0x01, 0x00,              # Report Count (1)                    0
+        0x06, 0x01, 0x00,              # Usage Page (Generic Desktop)        3
+        # 0x03, 0x00, 0x00, 0x00, 0x00,  # Ignored by the kernel somehow
+        0x2a, 0x90, 0xa0,              # Usage Maximum (41104)               6
+        0x27, 0x00, 0x00, 0x00, 0x00,  # Logical Maximum (0)                 9
+        0xb3, 0x81, 0x3e, 0x25, 0x03,  # Feature (Cnst,Arr,Abs,Vol)          14
+        0x1b, 0xdd, 0xe8, 0x40, 0x50,  # Usage Minimum (1346431197)          19
+        0x3b, 0x5d, 0x8c, 0x3d, 0xda,  # Designator Index                    24
+    ]
+    # fmt: on
+
+    def __init__(
+        self, rdesc=report_descriptor, name=None, input_info=(3, 0x045E, 0x07DA)
+    ):
+        super().__init__(rdesc, name, input_info)
+        self.high_resolution_report_called = False
+
+    def get_evdev(self, application=None):
+        assert self._input_nodes is None
+        return (
+            "Ok"  # should be a list or None, but both would fail, so abusing the system
+        )
+
+    def next_sync_events(self, application=None):
+        # there are no evdev nodes, so no events
+        return []
+
+    def is_ready(self):
+        # we wait for the SET_REPORT command to come
+        return self.high_resolution_report_called
+
+    def set_report(self, req, rnum, rtype, data):
+        if rtype != self.UHID_FEATURE_REPORT:
+            raise InvalidHIDCommunication(f"Unexpected report type: {rtype}")
+        if rnum != 0x0:
+            raise InvalidHIDCommunication(f"Unexpected report number: {rnum}")
+
+        if len(data) != 1:
+            raise InvalidHIDCommunication(f"Unexpected data: {data}, expected '[0]'")
+
+        self.high_resolution_report_called = True
+
+        return 0
+
+
 class ResolutionMultiplierHWheelMouse(TwoWheelMouse):
     # fmt: off
     report_descriptor = [
@@ -975,3 +1037,11 @@ class TestMiMouse(TestWheelMouse):
             # assert below print out the real error
             pass
         assert remaining == []
+
+
+class TestBadReportDescriptorMouse(base.BaseTestCase.TestUhid):
+    def create_device(self):
+        return BadReportDescriptorMouse()
+
+    def assertName(self, uhdev):
+        pass

-- 
2.49.0


