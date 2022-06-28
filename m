Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9855E91D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344206AbiF1OjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 10:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347026AbiF1OjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 10:39:04 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E72A941;
        Tue, 28 Jun 2022 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1656427140; x=1687963140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaJgMADj7ev1K3Is1fXfxdTNXcbOe+xlCWeo10RKNAY=;
  b=mDTk8hap1JLpaPQwUdO7OXNwUlLI8iFNX/jFXUlECNDLY/inrYMZE4FC
   tiUtMnQDdWSUdVn7+tGphQNKnlIeVJOGCpw5DNnRHVTOUdWau4RLxSo5B
   fIm61cCPTMu15sopUImVMbXRrhwHd9vzGR8u0Ne6qMIIX2Ix+lglbq2Ki
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="128773746"
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="128773746"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:38:55 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 28 Jun 2022 16:38:54 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 16:38:54 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Tue, 28 Jun 2022 16:38:54 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <jarkko@kernel.org>, <peterhuewe@gmx.de>,
        <stefan.mahnke-hartmann@infineon.com>,
        <johannes.holland@infineon.com>
Subject: [PATCH v2] selftests/tpm2: increase timeout for kselftests
Date:   Tue, 28 Jun 2022 16:39:27 +0200
Message-ID: <20220628143927.26043-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Johannes Holland <johannes.holland@infineon.com>

Due to CreatePrimary commands which need to create RSA keys of
increasing size, the timeout value need to be raised, as well.
Default is 45s.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
---
Changelog:
 * v2:
   * Add maintainter to recipients
   * Change subject
 tools/testing/selftests/tpm2/settings | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/tpm2/settings

diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
new file mode 100644
index 000000000000..919bc3803f03
--- /dev/null
+++ b/tools/testing/selftests/tpm2/settings
@@ -0,0 +1,2 @@
+timeout=600
+
-- 
2.25.1

