Return-Path: <linux-kselftest+bounces-1276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E32806C8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D8281A90
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36930331;
	Wed,  6 Dec 2023 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/k8QP7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAB13AEA;
	Wed,  6 Dec 2023 10:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCAC4339A;
	Wed,  6 Dec 2023 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859591;
	bh=pOwfO/gTl6S07OObuc/xFJuitivPZGd6txL7TG2VpdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z/k8QP7ehxdzQ+wMfGwuGeX8E6NC+M7NKGeHf+LeZ2AIQCEGk9p4cyUv5364rTcJY
	 6EBAVmvirMZuI6P8LWhmjY9o0ZjX27CYnNOetj+qRE4NoYPTrLBTWhsfBwUoU9X/GB
	 kywlgKyHHQD829SGpt4exE28uA9VOsMzAM47hnxX2o244tNDrOT4+8BdqBTYk8qiAO
	 eY4jJ0bxpduwNZ5qu4nqjRVd3xSM0XD0qWvlZUD/ZztYn+VCRUv/ZeEn5Nn3mB0sIE
	 GkNiyui6EiUJSH2BBKurGqMILz67KkUrtCRf8ViKxLdepZam9vMwJ9/v56wPB18W1R
	 CotAg5Y9VFSew==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:46:03 +0100
Subject: [PATCH v2 12/15] selftests/hid: tablets: add a secondary barrel
 switch test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-12-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=4659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pOwfO/gTl6S07OObuc/xFJuitivPZGd6txL7TG2VpdI=;
 b=wrlXNzdiguWIptxukcqXa2fnRQeQcKRGiUx1HKABt9ZlVc6LtKjYqva/lT659XLdF+qqJIoyC
 qt9oypaa+67CswJPbaVhNdtT8xQEXXCis25SzooEX+8ArkOWfOd40L4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Some tablets report 2 barrel switches. We better test those too.

Use the same transistions description from the primary button tests.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 20a7a7fdcd9d..a82db66264c5 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -366,6 +366,56 @@ class PenState(Enum):
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
@@ -444,6 +494,7 @@ class Pen(object):
         self.width = 10
         self.height = 10
         self.barrelswitch = False
+        self.secondarybarrelswitch = False
         self.invert = False
         self.eraser = False
         self.xtilt = 1
@@ -736,6 +787,22 @@ class BaseTest:
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


