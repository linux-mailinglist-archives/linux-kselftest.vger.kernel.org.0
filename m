Return-Path: <linux-kselftest+bounces-1273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB76806C85
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EBF1F2129A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC830341;
	Wed,  6 Dec 2023 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql38TF2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB52D021;
	Wed,  6 Dec 2023 10:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9261C433C9;
	Wed,  6 Dec 2023 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701859585;
	bh=JOoHr4zAh5sfVvjyOaC6fr3FGC2Kr/B8zXOBA3bqE5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ql38TF2+Bk/+3SWO2B0vtrJl1LH67UPi+W3aBdUcu36509XjXAinFya3ZY8LZihoR
	 cr4zTTXdHt9PngxxE00RtOtIAPfRiGndKrnrWmqNAEItx/2D9HNlQt4zv1p5KsbjcU
	 1XB1WMl7mblniHfhMzY1Y16WtltTXn9O4f6GOAo88aihjH1iryMsqnEhk8IgVk44gb
	 Y0FEbi2hcsO90ZtVqTt0h2rEgPbpV7RjVUi8yfRG9w4GQGL993iJFJVbs8vsTI+nVs
	 ZDvmvFHfHwI7D8GTwEB/Zd7KYobhNIIhSYy+m5Os1vX5H9AeycYj9BvW4hddtEKQsz
	 foXaMJu4VJ72w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 06 Dec 2023 11:46:00 +0100
Subject: [PATCH v2 09/15] selftests/hid: tablets: define the elements of
 PenState
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-9-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=3714;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JOoHr4zAh5sfVvjyOaC6fr3FGC2Kr/B8zXOBA3bqE5E=;
 b=D07701ttFW/wdwLhzQVrnkMz0OMzwa3lqAwd05byE2uHsSte7/gzL5eDxfGQVPMQfVCJiSRWR
 3QBcnmPPYS+CdmB7l0MRXLqTMf6abw8BmkTcDtvJyqJD6/PglTR2mpR
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This introduces a little bit more readability by not using the raw values
but a dedicated Enum

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 36 ++++++++++++++++--------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 0ddf82695ed9..cec65294c9ec 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -13,40 +13,52 @@ from hidtools.util import BusType
 import libevdev
 import logging
 import pytest
-from typing import Dict, Tuple
+from typing import Dict, Optional, Tuple
 
 logger = logging.getLogger("hidtools.test.tablet")
 
 
+class BtnTouch(Enum):
+    """Represents whether the BTN_TOUCH event is set to True or False"""
+
+    DOWN = True
+    UP = False
+
+
+class ToolType(Enum):
+    PEN = libevdev.EV_KEY.BTN_TOOL_PEN
+    RUBBER = libevdev.EV_KEY.BTN_TOOL_RUBBER
+
+
 class PenState(Enum):
     """Pen states according to Microsoft reference:
     https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-pen-states
     """
 
-    PEN_IS_OUT_OF_RANGE = (False, None)
-    PEN_IS_IN_RANGE = (False, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_CONTACT = (True, libevdev.EV_KEY.BTN_TOOL_PEN)
-    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = (False, libevdev.EV_KEY.BTN_TOOL_RUBBER)
-    PEN_IS_ERASING = (True, libevdev.EV_KEY.BTN_TOOL_RUBBER)
+    PEN_IS_OUT_OF_RANGE = BtnTouch.UP, None
+    PEN_IS_IN_RANGE = BtnTouch.UP, ToolType.PEN
+    PEN_IS_IN_CONTACT = BtnTouch.DOWN, ToolType.PEN
+    PEN_IS_IN_RANGE_WITH_ERASING_INTENT = BtnTouch.UP, ToolType.RUBBER
+    PEN_IS_ERASING = BtnTouch.DOWN, ToolType.RUBBER
 
-    def __init__(self, touch, tool):
+    def __init__(self, touch: BtnTouch, tool: Optional[ToolType]):
         self.touch = touch
         self.tool = tool
 
     @classmethod
     def from_evdev(cls, evdev) -> "PenState":
-        touch = bool(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
+        touch = BtnTouch(evdev.value[libevdev.EV_KEY.BTN_TOUCH])
         tool = None
         if (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
         ):
-            tool = libevdev.EV_KEY.BTN_TOOL_RUBBER
+            tool = ToolType(libevdev.EV_KEY.BTN_TOOL_RUBBER)
         elif (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
             and not evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
         ):
-            tool = libevdev.EV_KEY.BTN_TOOL_PEN
+            tool = ToolType(libevdev.EV_KEY.BTN_TOOL_PEN)
         elif (
             evdev.value[libevdev.EV_KEY.BTN_TOOL_PEN]
             or evdev.value[libevdev.EV_KEY.BTN_TOOL_RUBBER]
@@ -68,7 +80,7 @@ class PenState(Enum):
                 if touch_found:
                     raise ValueError(f"duplicated BTN_TOUCH in {events}")
                 touch_found = True
-                touch = bool(ev.value)
+                touch = BtnTouch(ev.value)
             elif ev in (
                 libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_PEN),
                 libevdev.InputEvent(libevdev.EV_KEY.BTN_TOOL_RUBBER),
@@ -77,7 +89,7 @@ class PenState(Enum):
                     raise ValueError(f"duplicated BTN_TOOL_* in {events}")
                 tool_found = True
                 if ev.value:
-                    tool = ev.code
+                    tool = ToolType(ev.code)
                 else:
                     tool = None
 

-- 
2.41.0


