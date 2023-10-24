Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1050A7D5D07
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 23:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJXVSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 17:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbjJXVS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 17:18:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38E10CE;
        Tue, 24 Oct 2023 14:18:27 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2ECEE6607341;
        Tue, 24 Oct 2023 22:18:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698182306;
        bh=lA00sz0Lx65AYKekb409w73xnTi/I00wyG4FTRF9Wr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir3xG0vLvri+xoOB5vvk5EU7wP/gQklulZkBXiCKV67qnbyDqQPj4hgQreVMjfJ+2
         uwYdF5wl3okCpb0QepIbNEnN1gBO9nY6sbvGAJ9EGH00VhHUzVeTCpkTe94GvaLXmC
         nMBfEB0YTmYaMN4hGT5Bkcd8i/yXY7Hscp7sCLjPHTQu9GiMlYqMuV+czQ9jwhO1z+
         wyKuS1Makuhm6trKb/ao53NgcoDTxanBRMRvDdARcyn0DkVYfixvS0AnnEFlc78vOd
         qpgir/R/wrT2X99U5bOHtcGR7Qg5L1RpMCeG5ID3V9F1YGZpJdKOnQ3hkFv0DC0ttm
         0NpN8tXhCDTLQ==
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
Subject: [RFC PATCH 2/2] kselftest: devices: Add board file for google,spherion
Date:   Tue, 24 Oct 2023 17:18:00 -0400
Message-ID: <20231024211818.365844-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024211818.365844-1-nfraprado@collabora.com>
References: <20231024211818.365844-1-nfraprado@collabora.com>
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

Add the list of devices expected to be probed from the USB and PCI
busses on the google,spherion machine. The USB host controller at
11200000 is shared between two busses, for USB2 and USB3, so an
additional match is used to select the USB2 bus.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 tools/testing/selftests/devices/boards/google,spherion | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion

diff --git a/tools/testing/selftests/devices/boards/google,spherion b/tools/testing/selftests/devices/boards/google,spherion
new file mode 100644
index 000000000000..ba86ffcfe43c
--- /dev/null
+++ b/tools/testing/selftests/devices/boards/google,spherion
@@ -0,0 +1,3 @@
+usb camera 11200000,PRODUCT=.*/2/.* 1.4.1 1 0,1
+usb bluetooth 11200000,PRODUCT=.*/2/.* 1.4.2 1 0,1
+pci wifi 11230000 0.0/0.0
-- 
2.42.0

