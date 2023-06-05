Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5EF722E26
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjFESCW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjFESCU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0ACD2;
        Mon,  5 Jun 2023 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988140; x=1717524140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fEVbocJK76OsCYtzLBWGVMQr0k8AvV/EpnfvvAei/8=;
  b=fiDJOz1FnnWte9MAq/h2k6pZR7oU3vCYpew4zFRta0XmygQWdFN24ggG
   D8UVOexMGdw/0dN7soz/E/dYqXGbK94VFw2Axub+340OTqKNNUiZ9Xkee
   +NSqDmAgWSbbo9cUaMgrHivw/l1eCU5EFUDr7iCOi162FrGmXcLqx8fBw
   W+eWx5XgSo5CuPUxZ0CnAaH/xTbKPaub82AtkMGjHSI7nNY5BSUW2iDdu
   mbEUtsMfpv47yRgVGZteNd+sYq0v8+GIG7SIYGNhP9cWJP0Vt6ET2Rt8v
   VhWDlXqkjbTgdsXcUj5ihoSe0UAaxxlXo8hyEGX1ml3I1jhxPASmvKQWf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442814885"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442814885"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274024"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274024"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 03/19] selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
Date:   Mon,  5 Jun 2023 21:01:29 +0300
Message-Id: <20230605180145.112924-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
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

