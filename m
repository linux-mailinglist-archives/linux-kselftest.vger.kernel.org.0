Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C897D5CF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjJXVS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXVS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 17:18:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BD10CF;
        Tue, 24 Oct 2023 14:18:24 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8CF66607333;
        Tue, 24 Oct 2023 22:18:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698182303;
        bh=YRq5099l8oQL4Fdgmj24/WWMHCqsGt/HPtK1ssRTRao=;
        h=From:To:Cc:Subject:Date:From;
        b=ka/ZKhFp5M0+/HZbpCsb/pNnyzTib5pwvFEwqEMBcLpZKQeZl3X5l65mXPgALnchS
         VNbg51Rugu1nhqbFGtYnMItn2Ejb7TtMvzMF2QflQezH3EN7NYYkYtsbBOY+8fSa9t
         0nI1rqJNFcb3KDmnaBjK+3XaTkoHpOdKjlf3QguMmTba+Tnv8p+isVAZNP/kWI4n1V
         t6fYkZQTThb+ISVq44KhCtxSKW9v5UIMLtgAYRsk7xlS03QUdMOQQ929+W+yAY5/Te
         7Wnn4TVona2qfx9AlnFmBPk+MXH9BnhPe0DCKIWV3znm5faqxttQ8Q62xOkO+AmUp0
         2MGixT6kVYbjg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Add test to verify probe of devices from discoverable busses on DT platforms
Date:   Tue, 24 Oct 2023 17:17:58 -0400
Message-ID: <20231024211818.365844-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
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


This is part of an effort to improve detection of regressions impacting
device probe on all platforms. The recently merged DT kselftest [1]
detects probe issues for all devices described statically in the DT.
That leaves out devices discovered at run-time from discoverable busses.

This is where this test comes in. All of the devices that are connected
through discoverable busses (ie USB and PCI), and which are internal and
therefore always present, can be described in a per-platform file so
they can be checked for. The test will check that the device has been
instantiated and bound to a driver.

Patch 1 introduces the test. Patch 2 adds the test definitions for the
google,spherion machine (Acer Chromebook 514) as an example.

This is the sample output from the test running on Spherion:

TAP version 13
 Using board file:  boards/google,spherion
1..10
ok 1 usb.camera.0.device
ok 2 usb.camera.0.driver
ok 3 usb.camera.1.device
ok 4 usb.camera.1.driver
ok 5 usb.bluetooth.0.device
ok 6 usb.bluetooth.0.driver
ok 7 usb.bluetooth.1.device
ok 8 usb.bluetooth.1.driver
ok 9 pci.wifi.device
ok 10 pci.wifi.driver
 Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0

[1] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/


Nícolas F. R. A. Prado (2):
  kselftest: Add test to verify probe of devices from discoverable
    busses
  kselftest: devices: Add board file for google,spherion

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devices/.gitignore    |   1 +
 tools/testing/selftests/devices/Makefile      |   8 +
 .../selftests/devices/boards/google,spherion  |   3 +
 .../devices/test_discoverable_devices.sh      | 165 ++++++++++++++++++
 5 files changed, 178 insertions(+)
 create mode 100644 tools/testing/selftests/devices/.gitignore
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.sh

-- 
2.42.0

