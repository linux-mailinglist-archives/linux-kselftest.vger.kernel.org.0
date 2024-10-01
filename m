Return-Path: <linux-kselftest+bounces-18762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77E98C1E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF81F2147B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59B1C9EDC;
	Tue,  1 Oct 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T4xJxuhW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61C1C8FD5;
	Tue,  1 Oct 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797454; cv=none; b=acRKYjZC4Fty4lNBV+SpXjtXULJj1GwkedN/0VKnZpZlmjdxe80HvcrEx+ooitZmAJJlkAUaScFj9rOlkkDv0g3aqicIJeT9Rk0NUtEOZCoY9c+6qczyoWQEcrVNuvDpBquV7dz2+TyJOMnvvoo5WGmqcxmWeZcwIS3CkVvGBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797454; c=relaxed/simple;
	bh=uh9EhIRmTQfFlAsmyL3OVDGo/q51it5ueX+NO09uEbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=smLZKm1oDd3SaLMz0UeQ+xTBgxX/Mr6j2I7ntA3PvbtQ52c7F21MGA/ylZAP/6QTzhBebbEJYBQv3FH7zoEFylQE/wSFrDCsLhAKhjfp+ysNFaC9FD+UsJBjSr/7fapVfP+NnTq61S9h867s2l46Dv3wCnNEPl7WDYw3GaW5mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T4xJxuhW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727797451;
	bh=uh9EhIRmTQfFlAsmyL3OVDGo/q51it5ueX+NO09uEbc=;
	h=From:Date:Subject:To:Cc:From;
	b=T4xJxuhWZDmr4RQw/qGKq8YoSdDeaRZSKIJ7crVtLTibbNqgnVmCCQXMIL7s7cxN7
	 SM2GZadJykWIgbjaosM4l6L6HrcNbx1FK7xzd4OPpbafP22gYF9vAnwSN/yemHtom/
	 nN68JbmHn/mMLS5gtOcMfGW9e+msWXsRjVMfs7mXZbUfDjGcxBRYUYlipeKXgd1XfQ
	 MdsldGQz1qxgly7N0Z7k+d366fX7iP1ApsQqX7j5DgfhezKeWIjIO1OUTPe2mzT7Vv
	 5MLVFYLpPMJmYZRP9FaDkEDY5iEfI30XgsRHlSJDMthv5hBToonOa9SBU3Emx1tXJr
	 /EJWSIr5UnPFg==
Received: from [192.168.1.33] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62CEC17E0FE4;
	Tue,  1 Oct 2024 17:44:10 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 01 Oct 2024 11:43:23 -0400
Subject: [PATCH] docs: dev-tools: Add documentation for the device focused
 kselftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJoY/GYC/x2M0QpAQBAAf0X7bOtWCL8iD9wtNjq6ldTl310ep
 2YmgnIQVuiyCIFvUTl8AsozsOvoF0ZxiaEwRUnGEG7K+3yxXuiSbhndYRVr24wlEZl2qiC1Z+B
 Znv/bD+/7ARsAJ4ZnAAAA
To: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.1

Add documentation for the kselftests focused on testing devices and
point to it from the kselftest documentation. There are multiple tests
in this category so the aim of this page is to make it clear when to run
each test.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
This patch depends on patch "kselftest: devices: Add test to detect
missing devices" [1], since this patch documents that test.

[1] https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com
---
 Documentation/dev-tools/kselftest.rst       |  9 ++++++
 Documentation/dev-tools/testing-devices.rst | 47 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index f3766e326d1e..fdb1df86783a 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -31,6 +31,15 @@ kselftest runs as a userspace process.  Tests that can be written/run in
 userspace may wish to use the `Test Harness`_.  Tests that need to be
 run in kernel space may wish to use a `Test Module`_.
 
+Documentation on the tests
+==========================
+
+For documentation on the kselftests themselves, see:
+
+.. toctree::
+
+   testing-devices
+
 Running the selftests (hotplug tests are run in limited mode)
 =============================================================
 
diff --git a/Documentation/dev-tools/testing-devices.rst b/Documentation/dev-tools/testing-devices.rst
new file mode 100644
index 000000000000..ab26adb99051
--- /dev/null
+++ b/Documentation/dev-tools/testing-devices.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (c) 2024 Collabora Ltd
+
+=============================
+Device testing with kselftest
+=============================
+
+
+There are a few different kselftests available for testing devices generically,
+with some overlap in coverage and different requirements. This document aims to
+give an overview of each one.
+
+Note: Paths in this document are relative to the kselftest folder
+(``tools/testing/selftests``).
+
+Device oriented kselftests:
+
+* Devicetree (``dt``)
+
+  * **Coverage**: Probe status for devices described in Devicetree
+  * **Requirements**: None
+
+* Error logs (``devices/error_logs``)
+
+  * **Coverage**: Error (or more critical) log messages presence coming from any
+    device
+  * **Requirements**: None
+
+* Discoverable bus (``devices/probe``)
+
+  * **Coverage**: Presence and probe status of USB or PCI devices that have been
+    described in the reference file
+  * **Requirements**: Manually describe the devices that should be tested in a
+    YAML reference file (see ``devices/probe/boards/google,spherion.yaml`` for
+    an example)
+
+* Exist (``devices/exist``)
+
+  * **Coverage**: Presence of all devices
+  * **Requirements**: Generate the reference (see ``devices/exist/README.rst``
+    for details) on a known-good kernel
+
+Therefore, the suggestion is to enable the error log and devicetree tests on all
+(DT-based) platforms, since they don't have any requirements. Then to greatly
+improve coverage, generate the reference for each platform and enable the exist
+test. The discoverable bus test can be used to verify the probe status of
+specific USB or PCI devices, but is probably not worth it for most cases.

---
base-commit: cea5425829f77e476b03702426f6b3701299b925
change-id: 20241001-kselftest-device-docs-6c8a411109b5

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


