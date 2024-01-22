Return-Path: <linux-kselftest+bounces-3357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F5837212
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF3C1C2ABA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A547A55;
	Mon, 22 Jan 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I+gkp7Ma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C213DB9E;
	Mon, 22 Jan 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949748; cv=none; b=oGOd/pFhXYlyV5dT3hr65PRCykjfF/V5TbVQZNAxPypV3hyPY+A5QcZX1NiG6c2DaXvB2AoHpf64z6jQRADaPQcnKYzJtkB+1SHh4kZ6MU0sznDiikyv1pYDEiExq6HTOgOKvLDo/7tpJrOQ82wcOwypv7jbVqVBXFWuH83/wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949748; c=relaxed/simple;
	bh=/kA5lAH45fxwuthlEiD+vf1dP3hl/faQzu+RmcAfVWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O6hAzDNVtgSKS4lKD08i/U6NtRZ9rrt3Fryb43/g1RrKwcJfLBbUTlMtLKtvu1362DSRS4+TUbAd0coJrTHaCUciI4KNkhjsYjelgiiv6BBG1nHwSdxA2As+hr6n82C4QenHCeWnYu2FpNAhZOHBitXeRg0NSNR8lA4jE0mGRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I+gkp7Ma; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705949744;
	bh=/kA5lAH45fxwuthlEiD+vf1dP3hl/faQzu+RmcAfVWk=;
	h=From:Subject:Date:To:Cc:From;
	b=I+gkp7Maenr8HD2rs1ztDVK8yjY1aBUnqvwba+v3rVePuOkXCCBgKr5ceZXzGSIGQ
	 VK78iwfUdmmmq5iFf5RSWRnrnb1V5oXq64ULDpkQemCpUOp0VSRZz8/wpkzPPD6NWm
	 Cg2MUDnoUYiMFaW2TH7LOtKD7n2sLoLgCx2EoePyDVRbx1XfPQvUB8JQvuMGWtJI20
	 6fBWYyartg3yYfTVEUT7285afqBuR1W3qQmgv2dszcYy9Ezrea84XuUYOm14AEDpTa
	 8fC6TACh4Ay7GCw6E33GOUpwDohjykx98xMP2Kp6mmgbVecFttbjiez63T+aEjcuCU
	 tNey8ii0DneSA==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C4E5B37820A4;
	Mon, 22 Jan 2024 18:55:38 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v4 0/3] Add test to verify probe of devices from
 discoverable buses
Date: Mon, 22 Jan 2024 15:53:20 -0300
Message-Id: <20240122-discoverable-devs-ksft-v4-0-d602e1df4aa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKC5rmUC/zXMQQrCMBCF4auUWRtJJomkrnTlIcRF2kyaYG0lU
 4pQeneD4PKD9/4NmEomhnOzQaE1c56nCnNooE9+GkjkUA0o0UiFKELmfl6p+G4kEWhl8eS4iDZ
 YqUgrPDkH9fwuFPPnF74/qmOZX2JJhfw/V7foUFtt3PF2Vda2xtlLl2gcvGfY9y/OXpdbnAAAA
 A==
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

This is part of an effort to improve detection of regressions impacting
device probe on all platforms. The recently merged DT kselftest [3]
detects probe issues for all devices described statically in the DT.
That leaves out devices discovered at run-time from discoverable buses.

This is where this test comes in. All of the devices that are connected
through discoverable buses (ie USB and PCI), and which are internal and
therefore always present, can be described based on their position in
the system topology in a per-platform YAML file so they can be checked
for. The test will check that the device has been instantiated and bound
to a driver.

Patch 1 introduces the test. Patch 2 and 3 add the device definitions
for the google,spherion machine (Acer Chromebook 514) and XPS 13 as
examples.

This is the output from the test running on Spherion:

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

[3] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/

Changes in v4:
- Dropped RFC tag
- Fixed 'busses' misspelling
- Link to v3: https://lore.kernel.org/all/20231227123643.52348-1-nfraprado@collabora.com

Changes in v3:
- Reverted approach of encoding stable device reference in test file
from device match fields (from modalias) back to HW topology (from v1)
- Changed board file description to YAML
- Rewrote test script in python to handle YAML and support x86 platforms
- Link to v2: https://lore.kernel.org/all/20231127233558.868365-1-nfraprado@collabora.com

Changes in v2:
- Changed approach of encoding stable device reference in test file from
HW topology to device match fields (the ones from modalias)
- Better documented test format
- Link to v1: https://lore.kernel.org/all/20231024211818.365844-1-nfraprado@collabora.com

---
Nícolas F. R. A. Prado (3):
      kselftest: Add test to verify probe of devices from discoverable buses
      kselftest: devices: Add sample board file for google,spherion
      kselftest: devices: Add sample board file for XPS 13 9300

 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/devices/Makefile           |   4 +
 .../devices/boards/Dell Inc.,XPS 13 9300.yaml      |  40 +++
 .../selftests/devices/boards/google,spherion.yaml  |  50 ++++
 tools/testing/selftests/devices/ksft.py            |  90 ++++++
 .../selftests/devices/test_discoverable_devices.py | 318 +++++++++++++++++++++
 6 files changed, 503 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-discoverable-devs-ksft-9d501e312688

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


