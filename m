Return-Path: <linux-kselftest+bounces-36811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44EAFE3A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179EE583224
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1F28688A;
	Wed,  9 Jul 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4AigL5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B9286434;
	Wed,  9 Jul 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052150; cv=none; b=Obx2n1v2A6TAYeeTAksuoN3up5gUjHnnxK77Ac/5URAu4j0vb8k6mDZJCEOtbaYC8nbpgVS+A3HsPyTwxdufHvYJSF1KE/1BVUiPlFhVZbGpYnkJLjBPzeo1G/jLmpmmNzw4vkQfA8LyRw1kl7lCcSyCAG4VD8eh1Wi6VfkFbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052150; c=relaxed/simple;
	bh=gV2jaj6M1p/R25rUOI3yMU7iCwdkbT5nU49Xub1IN5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0SkrCl2f+KzrqbIObxQVFgIKKqGwmBHXHhIqj11DbYvQbZVYdnQigmgBz+690KSyDKzOESBkFqah6XkLt7BA6BFupk4rpZ8sAJm2pHeHRgWrQ8bmu42K/7Ozql59MgEtQQKsKZ7NlH3jqGXQycutwm8S3BrYd6a4d7Gtu/BpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4AigL5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4DDC4CEF6;
	Wed,  9 Jul 2025 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052149;
	bh=gV2jaj6M1p/R25rUOI3yMU7iCwdkbT5nU49Xub1IN5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R4AigL5zYqE8r7rJwa45C9ifhqqcsnTuH9frlCa53A06vyATeLgY94HXoOVkzMfJE
	 6iw90EBDtVVQKqQ7gVVRDUWQI513iR//SO+fFImjtIZh6xAN+oYPp3TE62n9E1cm02
	 J9pgGM6QPqh7isLcZVS/3bc1AXbrt/4cVWTK/FwBynWwCV34Ng8TWrreIxwpbEAzyN
	 iuIKXf/YsAsHryaFThoq1ZxU9szhOVagbtNktdCcsURWJkTM3KYJwqS17d0CBzr92o
	 R9E3rmtRseK+vrNXlCbB6EucB6AuG+8xL56SR4K3y1GE08odVOYxAmdkDq1F6rq5qG
	 ezxA4PfpjLMAw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 09 Jul 2025 11:08:51 +0200
Subject: [PATCH 3/3] selftests/hid: sync python tests to hid-tools 0.10
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-wip-fix-ci-v1-3-b7df4c271cf8@kernel.org>
References: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
In-Reply-To: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052142; l=2366;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gV2jaj6M1p/R25rUOI3yMU7iCwdkbT5nU49Xub1IN5k=;
 b=0+AC0++/tfOnhJpHqffvD9RuKWPJlVZfsD+3zhpsNFlSJjOtzZAjnREzgfnkO/GZ7/oQvQgKW
 EJxn3PM4COmBGrkV0luAcVqFsaLHEGua35+r1EhD522l3npHsqu4jsH
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid-tools 0.10 fixes one inconvenience introduced by
commit 6a9e76f75c1a ("HID: multitouch: Disable touchpad
on firmware level while not in use")

This change added a new callback when a hid-nultitouch device is opened
or closed to put the underlying device into a given operating mode.
However, in the test cases, that means that while the single threaded
test is run, it opens the device but has to react to the device while
the open() is still running. hid-tools now implements a minimal thread
to circumvent this.

This makes the HID kernel tests in sync with hid-tools 0.10.

This has the net effect of running the full HID python testsuite in 6
minutes instead of 1 hour.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base_device.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/base_device.py b/tools/testing/selftests/hid/tests/base_device.py
index e13035fe1deb4c2ee5fd729d43c619bdd759c138..59465c58d94dfd3993ae87b25a62e444e93e0f66 100644
--- a/tools/testing/selftests/hid/tests/base_device.py
+++ b/tools/testing/selftests/hid/tests/base_device.py
@@ -23,6 +23,7 @@ import fcntl
 import functools
 import libevdev
 import os
+import threading
 
 try:
     import pyudev
@@ -344,10 +345,28 @@ class BaseDevice(UHIDDevice):
         if not self.kernel_is_ready or not self.started:
             return []
 
+        # Starting with kernel v6.16, an event is emitted when
+        # userspace opens a kernel device, and for some devices
+        # this translates into a SET_REPORT.
+        # Because EvdevDevice(path) opens every single evdev node
+        # we need to have a separate thread to process the incoming
+        # SET_REPORT or we end up having to wait for the kernel
+        # timeout of 5 seconds.
+        done = False
+
+        def dispatch():
+            while not done:
+                self.dispatch(1)
+
+        t = threading.Thread(target=dispatch)
+        t.start()
+
         self._input_nodes = [
             EvdevDevice(path)
             for path in self.walk_sysfs("input", "input/input*/event*")
         ]
+        done = True
+        t.join()
         return self._input_nodes
 
     def match_evdev_rule(self, application, evdev):

-- 
2.49.0


