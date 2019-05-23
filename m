Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3128D16
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfEWWb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:31:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60076 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388554AbfEWWbP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:31:15 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEv-00062W-R4; Thu, 23 May 2019 16:31:13 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEq-0001ST-L6; Thu, 23 May 2019 16:31:04 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 23 May 2019 16:31:00 -0600
Message-Id: <20190523223100.5526-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5 10/10] NTB: Describe the ntb_msi_test client in the documentation.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a blurb in Documentation/ntb.txt to describe the ntb_msi_test tool's
debugfs interface. Similar to the (out of date) ntb_tool description.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/ntb.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index a043854d28df..802a539f1592 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -194,6 +194,33 @@ Debugfs Files:
 	This file is used to read and write peer scratchpads.  See
 	*spad* for details.
 
+NTB MSI Test Client (ntb\_msi\_test)
+------------------------------------
+
+The MSI test client serves to test and debug the MSI library which
+allows for passing MSI interrupts across NTB memory windows. The
+test client is interacted with through the debugfs filesystem:
+
+* *debugfs*/ntb\_tool/*hw*/
+	A directory in debugfs will be created for each
+	NTB device probed by the tool.  This directory is shortened to *hw*
+	below.
+* *hw*/port
+	This file describes the local port number
+* *hw*/irq*_occurrences
+	One occurrences file exists for each interrupt and, when read,
+	returns the number of times the interrupt has been triggered.
+* *hw*/peer*/port
+	This file describes the port number for each peer
+* *hw*/peer*/count
+	This file describes the number of interrupts that can be
+	triggered on each peer
+* *hw*/peer*/trigger
+	Writing an interrupt number (any number less than the value
+	specified in count) will trigger the interrupt on the
+	specified peer. That peer's interrupt's occurrence file
+	should be incremented.
+
 NTB Hardware Drivers
 ====================
 
-- 
2.20.1

