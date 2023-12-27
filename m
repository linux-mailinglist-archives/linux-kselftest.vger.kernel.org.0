Return-Path: <linux-kselftest+bounces-2461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FF81EEFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C6EB22503
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B56446D9;
	Wed, 27 Dec 2023 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RUco1QkL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235845BE8;
	Wed, 27 Dec 2023 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703680744;
	bh=w80K9K625ryDqDV9yrKgZIzYlHFhUgvQGqQRjI4U7tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUco1QkLKUFQk9nWedO8uRG/VSc8S0RlucRtAPO22EtGLDElTR5BEwP7fQgyFo3cv
	 PSFxefaoo2nczudYiPR+tMvrhK5DnsR29w0C9Q80AAALdvatiooz9Xq2Rr6j3sFkP2
	 1hGenunQmt/GjOJkUGDieV02TvXqOGWZvIF3hbSAhLFU3lmqrUxGTyVAz4jZZptCUK
	 rVN+jUfSlIHNk1VT8u5o51V9mn2CaYuPZRZIJkQxIPn+x1FV5NgeAzuUwMDLcNj5zT
	 +KGh7eMzQh1jU96lbwFL7kc+s56amnXql2umiPEKHiLxvNcyJd5UXOZYBqFMZekeKu
	 lIddXsocHMiLg==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC6DA3781F8F;
	Wed, 27 Dec 2023 12:38:58 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kernelci@lists.linux.dev,
	kernel@collabora.com,
	Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <groeck@chromium.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/3] kselftest: devices: Add sample board file for google,spherion
Date: Wed, 27 Dec 2023 09:35:01 -0300
Message-ID: <20231227123643.52348-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227123643.52348-1-nfraprado@collabora.com>
References: <20231227123643.52348-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Changes in v3:
- Rewritten to use the YAML format and HW topology

 .../devices/boards/google,spherion.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion.yaml

diff --git a/tools/testing/selftests/devices/boards/google,spherion.yaml b/tools/testing/selftests/devices/boards/google,spherion.yaml
new file mode 100644
index 000000000000..1212542d31e7
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
+#   busses sharing the same controller.
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


