Return-Path: <linux-kselftest+bounces-834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0427FDB4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC312830EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21637D29;
	Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyskxjdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D1249F4;
	Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B6C433C9;
	Wed, 29 Nov 2023 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271522;
	bh=w/995xxVqtTO8u3lC0LbwRgYuG2cz3TbNhfloMXAPlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CyskxjdQbab85B6WOL09u/AiVOaGlrIRQv8Q45u21Mg19mAm1UEKoiAqwYnfwclgv
	 ZhbnuZEx5eHH9wAxv7Kn1ao3xymaIpF+ALVTlrf7h/4CRt1eq402hFp+AeboN5HPww
	 IoN8Xn1GrnGwgKMLa9y6ln4bfFkZEDraF2qvtE7dkkVXhk/5uIBfDuQiIYtw7SstoG
	 1xTlEVJiHH0Wdw7dKrYXBmqFsIGw8k7wbScJSnFYqJP0P93ZBV/Ae5Mtaqjf4r+VNY
	 aZtqaiPPnBWwcNRdivx+CWE+e3myRPuYNt2YDnGt7y9tsIpM4KUbKhzL+xbeCXYE2Z
	 3iGgAmfBrEUjA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:36 +0100
Subject: [PATCH 11/12] selftests/hid: tablets: add a secondary barrel
 switch test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-11-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=4576;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=w/995xxVqtTO8u3lC0LbwRgYuG2cz3TbNhfloMXAPlw=;
 b=ucW8VetRL0kO5xtEuqwr+BNOFlcTIG0bV37zbqf9YqTWowmFybNeamE/JypnOBJBzhknjY5sg
 YmR5vZ+H+JpA39N5Q3GwldF5BNuty5+5TlrTd4/5LNH2EK2hVl26QgG
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Some tablets report 2 barrel switches. We better test those too.

Use the same transistions description from the primary button tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/test_tablet.py | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 440a87170db1..f24cf2e168a4 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -351,6 +351,56 @@ class PenState(Enum):
             ),
         }
 
+    @staticmethod
+    def legal_transitions_with_secondary_button() -> Dict[str, Tuple["PenState", ...]]:
+        """We revisit the Windows Pen Implementation state machine:
+        we now have a secondary button.
+        Note: we don't looks for 2 buttons interactions.
+        """
+        return {
+            "hover-button": (PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,),
+            "hover-button -> out-of-range": (
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_OUT_OF_RANGE,
+            ),
+            "in-range -> button-press": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+            ),
+            "in-range -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> touch -> button-press -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+            ),
+            "in-range -> touch -> button-press -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> release -> button-release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+            "in-range -> button-press -> touch -> button-release -> release": (
+                PenState.PEN_IS_IN_RANGE,
+                PenState.PEN_IS_IN_RANGE_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT_WITH_SECOND_BUTTON,
+                PenState.PEN_IS_IN_CONTACT,
+                PenState.PEN_IS_IN_RANGE,
+            ),
+        }
+
     @staticmethod
     def tolerated_transitions() -> Dict[str, Tuple["PenState", ...]]:
         """This is not adhering to the Windows Pen Implementation state machine
@@ -429,6 +479,7 @@ class Pen(object):
         self.width = 10
         self.height = 10
         self.barrelswitch = False
+        self.secondarybarrelswitch = False
         self.invert = False
         self.eraser = False
         self.xtilt = 1
@@ -721,6 +772,22 @@ class BaseTest:
             """Rework the transition state machine by adding the primary button."""
             self._test_states(state_list, scribble)
 
+        @pytest.mark.skip_if_uhdev(
+            lambda uhdev: "Secondary Barrel Switch" not in uhdev.fields,
+            "Device not compatible, missing Secondary Barrel Switch usage",
+        )
+        @pytest.mark.parametrize("scribble", [True, False], ids=["scribble", "static"])
+        @pytest.mark.parametrize(
+            "state_list",
+            [
+                pytest.param(v, id=k)
+                for k, v in PenState.legal_transitions_with_secondary_button().items()
+            ],
+        )
+        def test_valid_secondary_button_pen_states(self, state_list, scribble):
+            """Rework the transition state machine by adding the secondary button."""
+            self._test_states(state_list, scribble)
+
         @pytest.mark.skip_if_uhdev(
             lambda uhdev: "Invert" not in uhdev.fields,
             "Device not compatible, missing Invert usage",

-- 
2.41.0


