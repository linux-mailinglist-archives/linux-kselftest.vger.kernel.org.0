Return-Path: <linux-kselftest+bounces-2459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E454281EEEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BEE1F22E75
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2445010;
	Wed, 27 Dec 2023 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r7pQchoj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEF44C84;
	Wed, 27 Dec 2023 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703680732;
	bh=ENMqB+GT1yQvxRmlz3ucoCgKOSrPmqH+OYpt0j0UxRs=;
	h=From:To:Cc:Subject:Date:From;
	b=r7pQchoju1ee2cF4Rzet87ddM5lLfb2Cirtd1jT/A1vDs3qeg0+vqTziKHdFhHBiu
	 fbivtrS+zIi3LNmw3rvJONlwXXj/DM2SMmsIUvYzCRYUuX6Y6Z7qy6u8FTTXbdGIzr
	 vPkX2RI5rzu2PTf5RjB/UA5FYVFXKifZF8mJVmjThZpuYG083Jj/9bhQbIKMoJXHGI
	 IvKirkUbQIqUFu6qxt9820xuO9MDP8n2P0akC1ZjGH+RN+NI6QGxte50kR6zFvQIuI
	 Tk6cKGroY+/S3bTFR0Jul+l9y9cTTFWdSd7of352yUYC7maKmrT5EjKWe0K7jpfi6G
	 RZ6G+CUl4MIMA==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93CB537813EA;
	Wed, 27 Dec 2023 12:38:46 +0000 (UTC)
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
Subject: [RFC PATCH v3 0/3] Add test to verify probe of devices from discoverable busses
Date: Wed, 27 Dec 2023 09:34:59 -0300
Message-ID: <20231227123643.52348-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi,

for this v3 I changed the approach for identifying devices in a stable
way from the match fields back to the hardware topology (used in v1).
The match fields were proposed as a way to avoid the possible issue of
PCI topology being reconfigured, but that wasn't observed on any real
system so far. However using match fields does allow for a real issue if
an external device similar to an internal one is connected to the
system, which results in a change of the match count and therefore a
test failure. So using the HW topology was chosen as the most reliable
approach.

The per-platform device description file now uses YAML following a
suggestion from Chris Obbard, and the test script was re-written in
python to handle the new YAML format.

A second sample board file is also now included for an x86 platform,
which contains an USB controller behind a PCI controller, which wasn't
possible to describe in v1.

Thanks,
Nícolas

v2: https://lore.kernel.org/all/20231127233558.868365-1-nfraprado@collabora.com
v1: https://lore.kernel.org/all/20231024211818.365844-1-nfraprado@collabora.com

Original cover letter:

This is part of an effort to improve detection of regressions impacting
device probe on all platforms. The recently merged DT kselftest [3]
detects probe issues for all devices described statically in the DT.
That leaves out devices discovered at run-time from discoverable busses.

This is where this test comes in. All of the devices that are connected
through discoverable busses (ie USB and PCI), and which are internal and
therefore always present, can be described in a per-platform file so
they can be checked for. The test will check that the device has been
instantiated and bound to a driver.

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

Changes in v3:
- Reverted approach of encoding stable device reference in test file
from device match fields (from modalias) back to HW topology (from v1)
- Changed board file description to YAML
- Rewrote test script in python to handle YAML and support x86 platforms

Changes in v2:
- Changed approach of encoding stable device reference in test file from
HW topology to device match fields (the ones from modalias)
- Better documented test format

Nícolas F. R. A. Prado (3):
  kselftest: Add test to verify probe of devices from discoverable
    busses
  kselftest: devices: Add sample board file for google,spherion
  kselftest: devices: Add sample board file for XPS 13 9300

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devices/Makefile      |   4 +
 .../devices/boards/Dell Inc.,XPS 13 9300.yaml |  40 +++
 .../devices/boards/google,spherion.yaml       |  50 +++
 tools/testing/selftests/devices/ksft.py       |  90 +++++
 .../devices/test_discoverable_devices.py      | 318 ++++++++++++++++++
 6 files changed, 503 insertions(+)
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion.yaml
 create mode 100644 tools/testing/selftests/devices/ksft.py
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.py

-- 
2.43.0


