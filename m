Return-Path: <linux-kselftest+bounces-6110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE388766AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C91282130
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711BD29E;
	Fri,  8 Mar 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JqOY7WHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6031D558;
	Fri,  8 Mar 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909386; cv=none; b=BWRHkVf+g+ZlHRC+noW4X0zquJ2uhnBFo+wCOa+JcpqchJrh10WgVVEijow4FXS4wkJoFVpNO7TbOWaL+a8ZPZpSh8a5tn3o+q8n8GvML2bx2MRiKEQk4SIdQq4RJVCANHCJZcBSTBz1XwhmrJY2xhYDW8ZCjAsPJ0Kq1KJ0j6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909386; c=relaxed/simple;
	bh=YLwNG4ks4uquD6ezqQSUc9idKRgCGv1a6DYhg9Loufc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMuy9+SRpXDhkmC/i42tE0GFMBh0Q7hCI0eeOyNXm4yZrUMAiQ7sItNkXHILD+sETmyZkwW7T+baNm4WFkvsO6vgyaWjwAmDWluzr/qzCrp+5TVNQG8AiBFM0x0Zmq/8xh7mWRc2PgtSG6o77lNsxyJvp/S/4z4CeLPBSSeONZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JqOY7WHs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709909382;
	bh=YLwNG4ks4uquD6ezqQSUc9idKRgCGv1a6DYhg9Loufc=;
	h=From:To:Cc:Subject:Date:From;
	b=JqOY7WHsabCwCSD7TWrek2H9lotzYfofsA5Ea0lIfThtMCbMdXr5NwtzLSE6qQwuH
	 kWePg8cGL2acGgta6kFvgiBy4MlbKbLSR8tRUZocpDC2TYyeJV5GgBIna51AQX3U8q
	 91uP/mvP15KGWNPRMZyCey86Y9McRxsPmOch4Sd5Ob+kyVGBSvwHpcz77vz2q5g1cI
	 3Y8e4WBBmpd6krpJDnDitA/isQaU93O8LBD5u1wyAEMKsJs+aH2Uv3DsUj2syhODRv
	 gLHgbSlbT8BTcWsn7ZCSkqJP+x5Tj5PCKLZMc9PNF7bQZScq3sJ59vHi8XfhLh1fCP
	 3pxaO07AluZWg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6D0FE37820F2;
	Fri,  8 Mar 2024 14:49:41 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	shuah@kernel.org
Cc: dan.carpenter@linaro.org,
	broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	davidgow@google.com,
	Tim.Bird@sony.com,
	dianders@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH v2 0/2] Add a test to verify device probing on ACPI platforms
Date: Fri,  8 Mar 2024 15:49:31 +0100
Message-Id: <20240308144933.337107-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This v2 addresses some issues observed when running the ACPI probe
kselftest proposed in v1[1] across various devices and improves the overall
reliability of the test.

The acpi-extract-ids script has been improved to:
- Parse both .c and .h files
- Add an option to print only IDs matched by a driver (i.e. defined in an
ACPI match tables or in lists of IDs provided by the drivers)

The test_unprobed_devices.sh script relies on sysfs information to
determine if a device was successfully bound to a driver. Not all devices
listed in /sys/devices are expected to have a driver folder, so the script
has been adjusted to handle these cases and avoid generating false
negatives.

The test_unprobed_devices.sh test script logic has been modified to:
- Check the status attribute (when available) to exclusively test hardware
  devices that are physically present, enabled and operational
- Traverse only ACPI objects with a physical_node* link, to ensure testing
  of correctly enumerated devices
- Skip devices whose HID or CID are not matched by any driver, as
  determined by the list generated through the acpi-extract-ids script
- Skip devices with HID or CID listed in the ignored IDs list. This list
  has been added to contain IDs of devices that don't require a driver or
  cannot be represented as platform devices (e.g. ACPI container and module
  devices).
- Skip devices that are natively enumerated and don't need a driver, such
  as certain PCI bridges
- Skip devices unassigned to any subsystem, devices linked to other devices
  and class devices

Some of the heuristics used by the script are suboptimal and might require
adjustments over time. This kind of tests would greatly benefit from a
dedicated interface that exposes information about devices expected to be
matched by drivers and their probe status. Discussion regarding this matter
was initiated in v1.

As of now, I have not identified a suitable method for exposing this
information; I plan on submitting a separate RFC to propose some options
and engage in discussion. Meanwhile, this v2 focuses on utilizing already
available information to provide an ACPI equivalent of the existing DT
kselftest [2].

Adding in CC the people involved in the discussion at Plumbers [3], feel
free to add anyone that might be interested in this.

This series depends on:
- https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
- https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/

Thanks,

Laura

[1] https://lore.kernel.org/all/20230925155806.1812249-2-laura.nao@collabora.com/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/dt
[3] https://www.youtube.com/watch?v=oE73eVSyFXQ&t=9377s

Original cover letter:

Regressions that prevent a driver from probing a device can significantly
affect the functionality of a platform.

A kselftest to verify if devices on a DT-based platform are probed
correctly was recently introduced [4], but no such generic test is
available for ACPI platforms yet. bootrr [5]  provides device probe
testing, but relies on a pre-defined list of the peripherals present on
each DUT.

On ACPI based hardware, a complete description of the platform is
provided to the OS by the system firmware. ACPI namespace objects are
mapped by the Linux ACPI subsystem into a device tree in
/sys/devices/LNXSYSTEM:00; the information in this subtree can be parsed
to build a list of the hw peripherals present on the DUT dynamically.

This series adds a test to verify if the devices declared in the ACPI
namespace and supported by the kernel are probed correctly.

This work follows a similar approach to [4], adapted for the ACPI use
case.

The first patch introduces a script that builds a list of all ACPI device
IDs supported by the kernel, by inspecting the acpi_device_id structs in
the sources. This list can be used to avoid testing ACPI-enumerated
devices that don't have a matching driver in the kernel. This script was
highly inspired by the dt-extract-compatibles script [6].

In the second patch, a new kselftest is added. It parses the
/sys/devices/LNXSYSTEM:00 tree to obtain a list of all platform
peripherals and verifies which of those, if supported, are correctly
bound to a driver.

Feedback is much appreciated,

Thank you,

Laura

[4] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/
[5] https://github.com/kernelci/bootr
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/dt-extract-compatibles

Laura Nao (2):
  acpi: Add script to extract ACPI device ids in the kernel
  kselftest: Add test to detect unprobed devices on ACPI platforms

 MAINTAINERS                                   |   2 +
 scripts/acpi/acpi-extract-ids                 |  99 +++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/acpi/.gitignore       |   1 +
 tools/testing/selftests/acpi/Makefile         |  21 +++
 tools/testing/selftests/acpi/id_ignore_list   |   3 +
 .../selftests/acpi/test_unprobed_devices.sh   | 138 ++++++++++++++++++
 7 files changed, 265 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids
 create mode 100644 tools/testing/selftests/acpi/.gitignore
 create mode 100644 tools/testing/selftests/acpi/Makefile
 create mode 100644 tools/testing/selftests/acpi/id_ignore_list
 create mode 100755 tools/testing/selftests/acpi/test_unprobed_devices.sh

-- 
2.30.2


