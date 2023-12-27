Return-Path: <linux-kselftest+bounces-2462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73F81EEFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548C3B21ABC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672D46423;
	Wed, 27 Dec 2023 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0tt9ZmqE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF4446D2;
	Wed, 27 Dec 2023 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703680750;
	bh=Cdexw2n4HbQxTZM8qiQfp93a3YFILA6CwYD1mIyyWME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0tt9ZmqETf0TBxM2J2UgjYJ8+xcebCzI4pqoSgsv3BuExqU1j8K+cYcT6dsVJ0nq4
	 ckS+XOL7dOO2OGUhPH9IIQR8qo5IFunanMt/IqTeS5evLbOGHnVqhtALgkEds0ZGRl
	 CKE4LmdqBgwErQAKBV8x16y8+t0hu46j/EelxK01G7349ApzDUAXOR/4RnvJhYCoJz
	 GT2DDcg3/AOARyp1I5xqPpVchcsaf4tJ+rMoIRIIGzRvEF4UDQsl+fp0l+UwShRj0e
	 ppbf1XUFggpGPjpVQ4C3uix5i/HmGQ9cK1SaCBlC4yZIUNVah/WqiuCg2VUU+hx5/S
	 Njam0JfivD26g==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14E0937813EA;
	Wed, 27 Dec 2023 12:39:04 +0000 (UTC)
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
Subject: [RFC PATCH v3 3/3] kselftest: devices: Add sample board file for XPS 13 9300
Date: Wed, 27 Dec 2023 09:35:02 -0300
Message-ID: <20231227123643.52348-4-nfraprado@collabora.com>
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

Changes in v3:
- Added this commit

 .../devices/boards/Dell Inc.,XPS 13 9300.yaml | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml

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


