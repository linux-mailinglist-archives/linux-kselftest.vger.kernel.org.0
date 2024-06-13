Return-Path: <linux-kselftest+bounces-11871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE02907651
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E33A1F272D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19D14A089;
	Thu, 13 Jun 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ui23fgE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA8149C7D;
	Thu, 13 Jun 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291715; cv=none; b=I6k4pqn5/dnQLOyMWKruLeFSOBwjVdYSTr1f3x99KWFHFM/o5FCp66V0vm77JZddfbMvxArw8ykJz6xDy04Aau4JRhKa2agjvfS66UJ8RAFpAXXjqPWllg7zf/8T6yNyW36L8udfxZ+S88BqZoFRXJOrcRgtfYaJLtZ1CWKGyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291715; c=relaxed/simple;
	bh=mt4zljf//d/ZLhry8ZIW+H+w5ZVB+RIooYCp5+PfIp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3wasWUNaw1lo22uj+M3oljXdvkGXm6okZTU+FrI80K5CboGeMEmCydwcQDGUf+vq27Nc72s4ypESmddPlCBmv8cvGfxQ5kGBByCQ2SP60K30dxeValU2yw/PQK/kRCufb1mJZfGKDav498t2WJ3s2lRVyTgroUCSbhMgw0av1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ui23fgE4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718291712;
	bh=mt4zljf//d/ZLhry8ZIW+H+w5ZVB+RIooYCp5+PfIp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ui23fgE4fIJb1iwXrYKnDH/yvk/z9ELcIU9rN0w3xYDk8TWLWIWjnNP3Amiw9QjU5
	 k01zUI1l1A49/L48DV5oQ280ZYHDUa38BHzYezTi9KqmXNpafWRFhdWZC56zA+Xb0m
	 tE98g9NtQjbdegx/sqlzAeQebnSOTOGlMakAGdBqYzHZa3SDn7u/2H8tlbeOIXv1o/
	 NE40UymaBZ+i1GIz+XaLQ3+B2ZcMiX/3Dod2p2MLWMURvoB7o1m7TzX0O3QtZ3kHy5
	 Ujf43TGsOGrGN1VKD6+/sxjhK0CvommnTLHOtp8f8fixdrMyAAR/kkGtQ7C8eOTRHI
	 tjUAfkDyi2G4g==
Received: from [192.168.1.250] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 162553782198;
	Thu, 13 Jun 2024 15:15:10 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 13 Jun 2024 11:14:52 -0400
Subject: [PATCH 2/2] kselftest: devices: Add of-fullname-regex property
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-2-7b396a9b032d@collabora.com>
References: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com>
In-Reply-To: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Introduce a new 'of-fullname-regex' property that takes a regular
expression and matches against the OF_FULLNAME property. It allows
matching controllers that don't have a unique DT address across sibling
controllers, and thus dt-mmio can't be used.

One particular example of where this is needed is on MT8195 which has
multiple USB controllers described by two level deep nodes and using the
ranges property:

    ssusb2: usb@112a1000 {
        reg = <0 0x112a1000 0 0x2dff>, <0 0x112a3e00 0 0x0100>;
        ranges = <0 0 0 0x112a0000 0 0x3f00>;
        xhci2: usb@0 {

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../selftests/devices/boards/google,spherion.yaml  |  4 ++++
 .../selftests/devices/test_discoverable_devices.py | 24 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/devices/boards/google,spherion.yaml b/tools/testing/selftests/devices/boards/google,spherion.yaml
index 17157ecd8c14..3ea843324797 100644
--- a/tools/testing/selftests/devices/boards/google,spherion.yaml
+++ b/tools/testing/selftests/devices/boards/google,spherion.yaml
@@ -11,6 +11,10 @@
 # this, several optional keys can be used:
 # - dt-mmio: identify the MMIO address of the controller as defined in the
 #   Devicetree.
+# - of-fullname-regex: regular expression to match against the OF_FULLNAME
+#   property. Useful when the controller's address is not unique across other
+#   sibling controllers. In this case, dt-mmio can't be used, and this property
+#   allows the matching to include parent nodes as well to make it unique.
 # - usb-version: for USB controllers to differentiate between USB3 and USB2
 #   buses sharing the same controller.
 # - acpi-uid: _UID property of the controller as supplied by the ACPI. Useful to
diff --git a/tools/testing/selftests/devices/test_discoverable_devices.py b/tools/testing/selftests/devices/test_discoverable_devices.py
index 19f28ea774f4..8f2200540a1f 100755
--- a/tools/testing/selftests/devices/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/test_discoverable_devices.py
@@ -64,6 +64,22 @@ def get_dt_mmio(sysfs_dev_dir):
         sysfs_dev_dir = os.path.dirname(sysfs_dev_dir)
 
 
+def get_of_fullname(sysfs_dev_dir):
+    re_of_fullname = re.compile("OF_FULLNAME=(.*)")
+    of_full_name = None
+
+    # PCI controllers' sysfs don't have an of_node, so have to read it from the
+    # parent
+    while not of_full_name:
+        try:
+            with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
+                of_fullname = re_of_fullname.search(f.read()).group(1)
+                return of_fullname
+        except:
+            pass
+        sysfs_dev_dir = os.path.dirname(sysfs_dev_dir)
+
+
 def get_acpi_uid(sysfs_dev_dir):
     with open(os.path.join(sysfs_dev_dir, "firmware_node", "uid")) as f:
         return f.read()
@@ -97,6 +113,11 @@ def find_controller_in_sysfs(controller, parent_sysfs=None):
             if str(controller["dt-mmio"]) != get_dt_mmio(c):
                 continue
 
+        if controller.get("of-fullname-regex"):
+            re_of_fullname = re.compile(str(controller["of-fullname-regex"]))
+            if not re_of_fullname.match(get_of_fullname(c)):
+                continue
+
         if controller.get("usb-version"):
             if controller["usb-version"] != get_usb_version(c):
                 continue
@@ -195,6 +216,9 @@ def generate_pathname(device):
     if device.get("dt-mmio"):
         pathname += "@" + str(device["dt-mmio"])
 
+    if device.get("of-fullname-regex"):
+        pathname += "-" + str(device["of-fullname-regex"])
+
     if device.get("name"):
         pathname = pathname + "/" + device["name"]
 

-- 
2.45.0


