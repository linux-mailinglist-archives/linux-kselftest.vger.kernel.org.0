Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1528CEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfEWWbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:31:10 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59910 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbfEWWbK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:31:10 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEs-00062R-Eu; Thu, 23 May 2019 16:31:07 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEq-0001SE-4P; Thu, 23 May 2019 16:31:04 -0600
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
Date:   Thu, 23 May 2019 16:30:55 -0600
Message-Id: <20190523223100.5526-6-logang@deltatee.com>
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
Subject: [PATCH v5 05/10] NTB: Rename ntb.c to support multiple source files in the module
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kbuild system does not support having multiple source files in
a module if one of those source files has the same name as the module.

Therefore, we must rename ntb.c to core.c, while the module remains
ntb.ko.

This is similar to the way the nvme modules are structured.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/Makefile          | 2 ++
 drivers/ntb/{ntb.c => core.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/ntb/{ntb.c => core.c} (100%)

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 1921dec1949d..537226f8e78d 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
+
+ntb-y := core.o
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/core.c
similarity index 100%
rename from drivers/ntb/ntb.c
rename to drivers/ntb/core.c
-- 
2.20.1

