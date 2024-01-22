Return-Path: <linux-kselftest+bounces-3360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F51837222
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238C11C2AABB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E64878A;
	Mon, 22 Jan 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H/fJHhNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4048780;
	Mon, 22 Jan 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949764; cv=none; b=pGqDe8wZFPT9OSz2IvipYAXD2OSrO39lFNG7LrlasDYsmBM70W+dH841GgxCuJexrt+3vpdT7YrZXWuVqysFOQNvCTW2OYi+wYZCOGJzFGJwVOwT+8DNX8Z4pjk6QKpr+CVVEjSl568V7AD9eWZh7Eu3VILh85Q04+KXXRjXbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949764; c=relaxed/simple;
	bh=bK4Q2EbBc/nuHHjpU5lTiNRDOBSyU7sMPKPNpqyyg8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLsiQbgH1jKwA/JXeE/8j/Jz5qRA8Pzmu9tsdPVnjwc+9WqnokRgEVUc6DBP4PL1Rq3coJki0vZ1iE3mqBT3bKZvXo8TE5vwkhVEhu0qINXh6yteCgs92fdWfhkPYhQf5t596vgfPAz7w9mNJzFNWCNYPhhSA7s4BG2FkM55u/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H/fJHhNA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705949762;
	bh=bK4Q2EbBc/nuHHjpU5lTiNRDOBSyU7sMPKPNpqyyg8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H/fJHhNArVz1m4aahhjDKDMbAHLrTGImjOS6d8WXBOLSU3QHcj+lcol49NLXYXp5b
	 CyopSGhNUGpL/R8gv7kXjsa0Xkttk21qkISVdly8gShz9gCHWphNffpyXjvg5NzOSp
	 pimw3bG0TzWrZBgnwnz+wV6Dn9k/DIMajrJzwZNbd6+XO+S+/+n9MQNKSokYut0L9w
	 T9VZGNDVzZT/4etPJ+tplbSG+zV3lASWBsLH2XNiMMYveIkx6Q94iMCX7NMMK6oW7L
	 6ns751E6MT+BrpAOUZdB/boLgB+n0qPNEv/JEET95uctoMchB9SEVusByxVqizI4UJ
	 /cBQJy86FAO9Q==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AABFF37820A7;
	Mon, 22 Jan 2024 18:55:56 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 22 Jan 2024 15:53:23 -0300
Subject: [PATCH v4 3/3] kselftest: devices: Add sample board file for XPS
 13 9300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-discoverable-devs-ksft-v4-3-d602e1df4aa2@collabora.com>
References: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
In-Reply-To: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: kernelci@lists.linux.dev, kernel@collabora.com, 
 Tim Bird <Tim.Bird@sony.com>, linux-pci@vger.kernel.org, 
 David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 linux-usb@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Add a sample board file describing the file's format and with the list
of devices expected to be probed on the XPS 13 9300 machine as an
example x86 platform.

Test output:

TAP version 13
Using board file: boards/Dell Inc.,XPS 13 9300.yaml
1..22
ok 1 /pci-controller/14.0/usb2-controller/9/camera.device
ok 2 /pci-controller/14.0/usb2-controller/9/camera.0.driver
ok 3 /pci-controller/14.0/usb2-controller/9/camera.1.driver
ok 4 /pci-controller/14.0/usb2-controller/9/camera.2.driver
ok 5 /pci-controller/14.0/usb2-controller/9/camera.3.driver
ok 6 /pci-controller/14.0/usb2-controller/10/bluetooth.device
ok 7 /pci-controller/14.0/usb2-controller/10/bluetooth.0.driver
ok 8 /pci-controller/14.0/usb2-controller/10/bluetooth.1.driver
ok 9 /pci-controller/2.0/gpu.device
ok 10 /pci-controller/2.0/gpu.driver
ok 11 /pci-controller/4.0/thermal.device
ok 12 /pci-controller/4.0/thermal.driver
ok 13 /pci-controller/12.0/sensors.device
ok 14 /pci-controller/12.0/sensors.driver
ok 15 /pci-controller/14.3/wifi.device
ok 16 /pci-controller/14.3/wifi.driver
ok 17 /pci-controller/1d.0/0.0/ssd.device
ok 18 /pci-controller/1d.0/0.0/ssd.driver
ok 19 /pci-controller/1d.7/0.0/sdcard-reader.device
ok 20 /pci-controller/1d.7/0.0/sdcard-reader.driver
ok 21 /pci-controller/1f.3/audio.device
ok 22 /pci-controller/1f.3/audio.driver
Totals: pass:22 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../devices/boards/Dell Inc.,XPS 13 9300.yaml      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
new file mode 100644
index 000000000000..ff932eb19f0b
--- /dev/null
+++ b/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml	
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# This is the device definition for the XPS 13 9300.
+# The filename "Dell Inc.,XPS 13 9300" was chosen following the format
+# "Vendor,Product", where Vendor comes from
+# /sys/devices/virtual/dmi/id/sys_vendor, and Product comes from
+# /sys/devices/virtual/dmi/id/product_name.
+#
+# See google,spherion.yaml for more information.
+#
+- type: pci-controller
+  # This machine has a single PCI host controller so it's valid to not have any
+  # key to identify the controller. If it had more than one controller, the UID
+  # of the controller from ACPI could be used to distinguish as follows:
+  #acpi-uid: 0
+  devices:
+    - path: 14.0
+      type: usb-controller
+      usb-version: 2
+      devices:
+        - path: 9
+          name: camera
+          interfaces: [0, 1, 2, 3]
+        - path: 10
+          name: bluetooth
+          interfaces: [0, 1]
+    - path: 2.0
+      name: gpu
+    - path: 4.0
+      name: thermal
+    - path: 12.0
+      name: sensors
+    - path: 14.3
+      name: wifi
+    - path: 1d.0/0.0
+      name: ssd
+    - path: 1d.7/0.0
+      name: sdcard-reader
+    - path: 1f.3
+      name: audio

-- 
2.43.0


