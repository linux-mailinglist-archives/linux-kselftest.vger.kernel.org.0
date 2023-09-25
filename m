Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1647ADC7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjIYP6T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjIYP6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 11:58:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE6B8;
        Mon, 25 Sep 2023 08:58:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7587266072FC;
        Mon, 25 Sep 2023 16:58:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695657489;
        bh=/jor1FFC8SKohb/3sjU4fNSEVcDdd5txHAwwx7fIBc0=;
        h=From:To:Cc:Subject:Date:From;
        b=Yj7TZPGyFSKyYUXBAftWJ3qbMbHh0mNoeK4uMfrKq9i3JM/0QRIIHCkI+AyPTbQAl
         P/89sJTx9UWu7mnSpcKa03WHuHHuo6EjAquah4HRMEB+hajtAU9dLrsPklof/fEIRg
         ZQ35ITZn9dbYss1m75f6PsBPGP+sLgA7pCL1hdhhYs4RGi70xIteGWNGIE4gKwmYcW
         nHLW++Y1ii3M7l7DeJ0upjzB84UscOnXAhY1RtHIBSlWqBE1AnIyuEoTZeyMulbfVW
         SYEmByZhyhfZlKGQCMwcE6GeryzXqOtL9oFmtKW5PCkq/3IqiXEYKFfS9WNxwC3TN3
         8TjP9ypoHuQhw==
From:   Laura Nao <laura.nao@collabora.com>
To:     rafael@kernel.org, lenb@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org, groeck@chromium.org,
        broonie@kernel.org, robh+dt@kernel.org, kernelci@lists.linux.dev,
        kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI platforms
Date:   Mon, 25 Sep 2023 17:58:04 +0200
Message-Id: <20230925155806.1812249-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Regressions that prevent a driver from probing a device can significantly
affect the functionality of a platform.

A kselftest to verify if devices on a DT-based platform are probed
correctly was recently introduced [1], but no such generic test is
available for ACPI platforms yet. bootrr [2]  provides device probe
testing, but relies on a pre-defined list of the peripherals present on
each DUT.

On ACPI based hardware, a complete description of the platform is
provided to the OS by the system firmware. ACPI namespace objects are
mapped by the Linux ACPI subsystem into a device tree in
/sys/devices/LNXSYSTEM:00; the information in this subtree can be parsed
to build a list of the hw peripherals present on the DUT dynamically.

This series adds a test to verify if the devices declared in the ACPI
namespace and supported by the kernel are probed correctly.

This work follows a similar approach to [1], adapted for the ACPI use
case.

The first patch introduces a script that builds a list of all ACPI device
IDs supported by the kernel, by inspecting the acpi_device_id structs in
the sources. This list can be used to avoid testing ACPI-enumerated
devices that don't have a matching driver in the kernel. This script was
highly inspired by the dt-extract-compatibles script [3].

In the second patch, a new kselftest is added. It parses the
/sys/devices/LNXSYSTEM:00 tree to obtain a list of all platform
peripherals and verifies which of those, if supported, are correctly
bound to a driver.

Feedback is much appreciated,

Thank you,

Laura

[1] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/
[2] https://github.com/kernelci/bootr
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/dt-extract-compatibles

Laura Nao (2):
  acpi: Add script to extract ACPI device ids in the kernel
  kselftest: Add test to detect unprobed devices on ACPI platforms

 MAINTAINERS                                   |  2 +
 scripts/acpi/acpi-extract-ids                 | 60 +++++++++++++++
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/acpi/.gitignore       |  2 +
 tools/testing/selftests/acpi/Makefile         | 23 ++++++
 .../selftests/acpi/test_unprobed_devices.sh   | 75 +++++++++++++++++++
 6 files changed, 163 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids
 create mode 100644 tools/testing/selftests/acpi/.gitignore
 create mode 100644 tools/testing/selftests/acpi/Makefile
 create mode 100755 tools/testing/selftests/acpi/test_unprobed_devices.sh

-- 
2.30.2

