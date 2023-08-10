Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DC4778215
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjHJUYZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHJUYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 16:24:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E112136;
        Thu, 10 Aug 2023 13:24:22 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F0BD46607234;
        Thu, 10 Aug 2023 21:24:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691699061;
        bh=mfSXUsLYLqVGYNrw2dZQqMTMToZ4UamGbospLR4IvHs=;
        h=From:To:Cc:Subject:Date:From;
        b=bTQUuyaTsT4EW5uT9OWjFc8TsukuzocVCxxs9n7j/GmeMBx2LLhm6jgXKjgYLMaCz
         ZljCRyzgyBMvdz2eRnnUPFyWLTQDH1OI27p8Xnxb19S9h0dybbnyc7LQRRvKQY7G3X
         y2Izdgt26uuhj0vssozDzgG+G7biJDBpGT/Nch1NkZm55YNWqUIKhLRZ8HnnZGuqU5
         q1+S87MJaAuVUhJ8iHenz++PbiZsLxaYLjYPBrEJkiPo+d7nF3q4x2pTWmjmp+au0D
         /mx986LwBtszj9tEdB8ruQLIQ4scrw0enrywTFIETmKeedCSZbLJB8WDecqBTTAD7Q
         79ghEnvWiapkg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cocci@inria.fr, Mark Brown <broonie@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernelci@lists.linux.dev, Julia Lawall <Julia.Lawall@inria.fr>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/2] Add a test to catch unprobed Devicetree devices
Date:   Thu, 10 Aug 2023 16:23:49 -0400
Message-ID: <20230810202413.1780286-1-nfraprado@collabora.com>
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

Patch 1 introduces a script to parse the kernel source using Coccinelle
and extract all compatibles that can be matched by a Devicetree node to
a driver. Patch 2 adds a kselftest that walks over the Devicetree nodes
on the current platform and compares the compatibles to the ones on the
list, and on an ignore list, to point out devices that failed to be
probed.

A compatible list is needed because not all compatibles that can show up
in a Devicetree node can be used to match to a driver, for example the
code for that compatible might use "OF_DECLARE" type macros and avoid
the driver framework, or the node might be controlled by a driver that
was bound to a different node.

An ignore list is needed for the few cases where it's common for a
driver to match a device but not probe, like for the "simple-mfd"
compatible, where the driver only probes if that compatible is the
node's first compatible.

Even though there's already scripts/dtc/dt-extract-compatibles that does
a similar job, it didn't seem to find all compatibles, returning ~3k,
while Coccinelle found ~11k. Besides that, Coccinelle actually parses
the C files, so it should be a more robust solution than relying on
regexes.

The reason for parsing the kernel source instead of relying on
information exposed by the kernel at runtime (say, looking at modaliases
or introducing some other mechanism), is to be able to catch issues
where a config was renamed or a driver moved across configs, and the
.config used by the kernel not updated accordingly. We need to parse the
source to find all compatibles present in the kernel independent of the
current config being run.

Feedback is very much welcome.

Thanks,
Nícolas

[1] https://github.com/kernelci/bootrr


Nícolas F. R. A. Prado (2):
  scripts/dtc: Add script to extract matchable DT compatibles
  kselftest: Add Devicetree unprobed devices test

 scripts/dtc/extract-matchable-dt-compatibles  | 33 +++++++++++
 scripts/dtc/matchable_dt_compatibles.cocci    | 58 +++++++++++++++++++
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/dt/.gitignore         |  1 +
 tools/testing/selftests/dt/Makefile           | 17 ++++++
 .../selftests/dt/compatible_ignore_list       |  3 +
 .../selftests/dt/test_unprobed_devices.sh     | 58 +++++++++++++++++++
 7 files changed, 171 insertions(+)
 create mode 100755 scripts/dtc/extract-matchable-dt-compatibles
 create mode 100644 scripts/dtc/matchable_dt_compatibles.cocci
 create mode 100644 tools/testing/selftests/dt/.gitignore
 create mode 100644 tools/testing/selftests/dt/Makefile
 create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
 create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh

-- 
2.41.0

