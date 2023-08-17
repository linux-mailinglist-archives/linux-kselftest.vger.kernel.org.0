Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240487801BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356093AbjHQXgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 19:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356186AbjHQXgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 19:36:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0535A1;
        Thu, 17 Aug 2023 16:36:44 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38CD46606F65;
        Fri, 18 Aug 2023 00:36:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692315402;
        bh=aE/INpy7o44Kfxn435HuUOeX3n+B9yde3QUw9iCje4w=;
        h=From:To:Cc:Subject:Date:From;
        b=dOqfNs5WzZmQUlLDmqm1RFDl9Urn9i/8rcFpU3X6riPyzM4oi87Yv+vtY1p4Vkc0X
         xqDkkhzcmIF3H6DnQtGg7CkcxYTOi+UreAKxGtPj82Lb/5ZHKojXBUz9cx6shCCBP5
         urRTZmuDGUJ64QoDLkoBu0cpPxyq8QnOfx9ql4Ll9Ji6oiTXrn2SrD6gIIbnrLJSA2
         w75iavexLZO+LyMSGtc2TirXHeH48/QkivhADK7oFrGXWCnDP8pGUoxw11etZ2/yhg
         wtxg7nDGhaYIyAHKjA1lDA6Qm50HJl1sBD43BaDen5NNhpAycQEbR0DREYj2uJeYfg
         cpAj8oA5bLKeQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] Add a test to catch unprobed Devicetree devices
Date:   Thu, 17 Aug 2023 19:35:24 -0400
Message-ID: <20230817233635.2306377-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
- Extended dt-extract-compatibles script to be able to extract driver
  matching compatibles, instead of adding a new one in Coccinelle
- Made kselftest output in the KTAP format

Nícolas F. R. A. Prado (3):
  dt: dt-extract-compatibles: Handle cfile arguments in generator
    function
  dt: dt-extract-compatibles: Add flag for driver matching compatibles
  kselftest: Add new test for detecting unprobed Devicetree devices

 scripts/dtc/dt-extract-compatibles            | 74 +++++++++++++----
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/dt/.gitignore         |  1 +
 tools/testing/selftests/dt/Makefile           | 21 +++++
 .../selftests/dt/compatible_ignore_list       |  1 +
 tools/testing/selftests/dt/ktap_helpers.sh    | 57 +++++++++++++
 .../selftests/dt/test_unprobed_devices.sh     | 79 +++++++++++++++++++
 7 files changed, 218 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100644 tools/testing/selftests/dt/ktap_helpers.sh
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

-- 
2.41.0

