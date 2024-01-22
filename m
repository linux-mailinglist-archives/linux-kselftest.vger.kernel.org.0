Return-Path: <linux-kselftest+bounces-3359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523D83721E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996C51F30F2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D24482C3;
	Mon, 22 Jan 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cKszw2Ae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E6481D0;
	Mon, 22 Jan 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949759; cv=none; b=Y2LacGGrNBaWAgwjfa08fX4poz+Fp66yp5pcabRwVM+QRM5xJ1HA+M9xcKbmDDEWbFoS1IYzV4D6nITPOvaTAuX1x7vWlnscOPmoqve9wG5tpr65pzlAz6bAktoMZuys7RTIvPrsGBRMYUPX1rmW++vnuqjRjZpzF8sJkxH2Dm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949759; c=relaxed/simple;
	bh=XlWgFCEd1SjOkC7UVUqtq0/icGneNh7lrC4VNEUBB2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaljZIxhAIT0zTQ7rLlQljZyGvurqliCHKpnF/S914NuAFpDIqlMKc/DEuLkZ2c+cBHU1kMot6aIVAK6gkJgQtRDzS7/BYVI+R941anuN9v7nG//WR4aZh3qjORyaqS1GMuMB8eB7geYa3mvjJ7Wqp/qNxTVJ60ck46gphAOTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cKszw2Ae; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705949756;
	bh=XlWgFCEd1SjOkC7UVUqtq0/icGneNh7lrC4VNEUBB2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cKszw2AeLHrO8h2Fh2RPFJyaqiuDJEMkhc9VBzBKM67aFldEDZrgiD1/58xCXukhE
	 0V4voweoHyc3sXHQx3uuDVobke3XBJInX09Dg+W0K7KtkbqWoHt4woVC6UT8n09Z4p
	 ojNwbwlq5IaXXgjtzMnrHMlE4xSMIfMg3LitJIvxbUdwW+JRFM0yucd7J5KKrFB1Kt
	 YwiHd+xA504IR9WPAjxvzrG58BU3QSE1Gzhoyl148Knb3kq3fNodvF/NFV19WhUOkl
	 7b8+E08tXhfLPMvfLNHcg9I5r9iSg5Mgdmtu6soe7yPkGt0jy1DSEQ0De6H7M25xmP
	 LT6AzfK5MqIIg==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9E77F37820A5;
	Mon, 22 Jan 2024 18:55:50 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 22 Jan 2024 15:53:22 -0300
Subject: [PATCH v4 2/3] kselftest: devices: Add sample board file for
 google,spherion
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-discoverable-devs-ksft-v4-2-d602e1df4aa2@collabora.com>
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
of devices expected to be probed on the google,spherion machine as an
example.

Test output:

TAP version 13
Using board file: boards/google,spherion.yaml
1..8
ok 1 /usb2-controller@11200000/1.4.1/camera.device
ok 2 /usb2-controller@11200000/1.4.1/camera.0.driver
ok 3 /usb2-controller@11200000/1.4.1/camera.1.driver
ok 4 /usb2-controller@11200000/1.4.2/bluetooth.device
ok 5 /usb2-controller@11200000/1.4.2/bluetooth.0.driver
ok 6 /usb2-controller@11200000/1.4.2/bluetooth.1.driver
ok 7 /pci-controller@11230000/0.0/0.0/wifi.device
ok 8 /pci-controller@11230000/0.0/0.0/wifi.driver
Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../selftests/devices/boards/google,spherion.yaml  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/devices/boards/google,spherion.yaml b/tools/testing/selftests/devices/boards/google,spherion.yaml
new file mode 100644
index 000000000000..17157ecd8c14
--- /dev/null
+++ b/tools/testing/selftests/devices/boards/google,spherion.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# This is the device definition for the Google Spherion Chromebook.
+# The filename "google,spherion" comes from the Devicetree compatible, so this
+# file will be automatically used when the test is run on that machine.
+#
+# The top-level is a list of controllers, either for USB or PCI(e).
+# Every controller needs to have a 'type' key set to either 'usb-controller' or
+# 'pci-controller'.
+# Every controller needs to be uniquely identified on the platform. To achieve
+# this, several optional keys can be used:
+# - dt-mmio: identify the MMIO address of the controller as defined in the
+#   Devicetree.
+# - usb-version: for USB controllers to differentiate between USB3 and USB2
+#   buses sharing the same controller.
+# - acpi-uid: _UID property of the controller as supplied by the ACPI. Useful to
+#   distinguish between multiple PCI host controllers.
+#
+# The 'devices' key defines a list of devices that are accessible under that
+# controller. A device might be a leaf device or another controller (see
+# 'Dell Inc.,XPS 13 9300.yaml').
+#
+# The 'path' key is needed for every child device (that is, not top-level) to
+# define how to reach this device from the parent controller. For USB devices it
+# follows the format \d(.\d)* and denotes the port in the hub at each level in
+# the USB topology. For PCI devices it follows the format \d.\d(/\d.\d)*
+# denoting the device (identified by device-function pair) at each level in the
+# PCI topology.
+#
+# The 'name' key is used in the leaf devices to name the device for clarity in
+# the test output.
+#
+# For USB leaf devices, the 'interfaces' key should contain a list of the
+# interfaces in that device that should be bound to a driver.
+#
+- type: usb-controller
+  dt-mmio: 11200000
+  usb-version: 2
+  devices:
+    - path: 1.4.1
+      interfaces: [0, 1]
+      name: camera
+    - path: 1.4.2
+      interfaces: [0, 1]
+      name: bluetooth
+- type: pci-controller
+  dt-mmio: 11230000
+  devices:
+    - path: 0.0/0.0
+      name: wifi

-- 
2.43.0


