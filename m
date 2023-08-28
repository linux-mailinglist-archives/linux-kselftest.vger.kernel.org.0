Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205FC78BA0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjH1VOr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 17:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjH1VOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 17:14:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2FC3;
        Mon, 28 Aug 2023 14:14:30 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 973B6660087A;
        Mon, 28 Aug 2023 22:14:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693257269;
        bh=kMWLY6tuvILGJ3usJxrB0TPO3XiaNxG6Cf6+Lo6rdrg=;
        h=From:To:Cc:Subject:Date:From;
        b=RMNPZO/Vg4Y6R4vwYhpxQUY1VAdEKCTsmFKQPKgOcbOtPRYThJQEHvXlQ9gAGH+WE
         LYbU7idaQDV1eWwELh4Gg6uAY76d9fHg5o2clXfcQc6rgc3oeB2CGWPTV580aZBHY6
         rqUP5JU99WeKQL3Dls4/thGN11p/BvD6gPj0aIl1IOz+3Sy8zzvfibq7PHS43pbyy9
         7SoGu5ir4DRtMq2YKYRLx8EmlSgUa2oACKOqkONTCAHW9A+n3n+T+JmbgxmqgHu0LR
         x+EipqMVAq2OARILiP/Rxzjj0CETuU6qYc8MtK6geZ3V3PWd97+QSN73Jba8rR+tyB
         YSJdcmIKCcVhA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernelci@lists.linux.dev,
        kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/3] Add a test to catch unprobed Devicetree devices
Date:   Mon, 28 Aug 2023 17:13:09 -0400
Message-ID: <20230828211424.2964562-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Regressions that cause a device to no longer be probed by a driver can
have a big impact on the platform's functionality, and despite being
relatively common there isn't currently any generic test to detect them.
As an example, bootrr [1] does test for device probe, but it requires
defining the expected probed devices for each platform.

Given that the Devicetree already provides a static description of
devices on the system, it is a good basis for building such a test on
top.

This series introduces a test to catch regressions that prevent devices
from probing.

Patches 1 and 2 extend the existing dt-extract-compatibles to be able to
output only the compatibles that can be expected to match a Devicetree
node to a driver. Patch 2 adds a kselftest that walks over the
Devicetree nodes on the current platform and compares the compatibles to
the ones on the list, and on an ignore list, to point out devices that
failed to be probed.

A compatible list is needed because not all compatibles that can show up
in a Devicetree node can be used to match to a driver, for example the
code for that compatible might use "OF_DECLARE" type macros and avoid
the driver framework, or the node might be controlled by a driver that
was bound to a different node.

An ignore list is needed for the few cases where it's common for a
driver to match a device but not probe, like for the "simple-mfd"
compatible, where the driver only probes if that compatible is the
node's first compatible.

The reason for parsing the kernel source instead of relying on
information exposed by the kernel at runtime (say, looking at modaliases
or introducing some other mechanism), is to be able to catch issues
where a config was renamed or a driver moved across configs, and the
.config used by the kernel not updated accordingly. We need to parse the
source to find all compatibles present in the kernel independent of the
current config being run.

[1] https://github.com/kernelci/bootrr

Changes in v3:
- Added DT selftest path to MAINTAINERS
- Enabled device probe test for nodes with 'status = "ok"'
- Added pass/fail/skip totals to end of test output

Changes in v2:
- Extended dt-extract-compatibles script to be able to extract driver
  matching compatibles, instead of adding a new one in Coccinelle
- Made kselftest output in the KTAP format

Nícolas F. R. A. Prado (3):
  dt: dt-extract-compatibles: Handle cfile arguments in generator
    function
  dt: dt-extract-compatibles: Add flag for driver matching compatibles
  kselftest: Add new test for detecting unprobed Devicetree devices

 MAINTAINERS                                   |  1 +
 scripts/dtc/dt-extract-compatibles            | 74 +++++++++++++----
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/dt/.gitignore         |  1 +
 tools/testing/selftests/dt/Makefile           | 21 +++++
 .../selftests/dt/compatible_ignore_list       |  1 +
 tools/testing/selftests/dt/ktap_helpers.sh    | 70 ++++++++++++++++
 .../selftests/dt/test_unprobed_devices.sh     | 83 +++++++++++++++++++
 8 files changed, 236 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100644 tools/testing/selftests/dt/ktap_helpers.sh
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

-- 
2.42.0

