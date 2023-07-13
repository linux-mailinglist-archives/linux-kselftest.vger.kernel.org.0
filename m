Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0E75235F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjGMNU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjGMNUh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC830E1;
        Thu, 13 Jul 2023 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254427; x=1720790427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fEVbocJK76OsCYtzLBWGVMQr0k8AvV/EpnfvvAei/8=;
  b=V3b4HCbxFRaUoXjeZ1j6rDCl2E7ytiwepYJYyS2gCaZvnBcX33DrYZEJ
   xhTBrMTgXvAJlPfSTRyjSR8EeUx4VbvKd7SvrsUPilb3lPDJHZfCkckxR
   Z9jVEWjJe53gq3Sqpn6AOibdOErRFvipd3qcDfBOUtnakZ0CieVeKWX3L
   71xfONcWojh3zNLeuwREXnqZ3Cre2jcnZm7WPIYGNIkMCP8ZoJdUVSkHR
   tiPJckV5jvHiQ9hncLfI2cxAfd1uBa3WPD1DP21Qpij6e2XeOPVcLBf+k
   DZfNK2X7ieUqkjD2iKFCzkHroqvP/enn8oIpOtxfDQP1cbzTiJ+p+oomh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496565"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496565"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615719"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615719"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:24 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 03/19] selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
Date:   Thu, 13 Jul 2023 16:19:16 +0300
Message-Id: <20230713131932.133258-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A child calls PARENT_EXIT() when it fails to run a benchmark to kill
the parent process. PARENT_EXIT() lacks unmount for the resctrl FS and
the parent won't be there to unmount it either after it gets killed.

Add the resctrl FS unmount also to PARENT_EXIT().

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 87e39456dee0..f455f0b7e314 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,6 +43,7 @@
 	do {					\
 		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
+		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
-- 
2.30.2

