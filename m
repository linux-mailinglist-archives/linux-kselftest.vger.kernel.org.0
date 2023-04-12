Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B326DF703
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjDLNXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDLNXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB8272B;
        Wed, 12 Apr 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305779; x=1712841779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdoyU1mkO+uuh6+FXiTKLcjnbdTl7FIeNDqvfQ0Ihec=;
  b=ixVzsFSYJRZ80syfLzEnzuny1PeLGekxSVdSgVzno3rEFz7CyM2mBO14
   uANEeEJE0bcNWFqleQecfIrMhNnVhaXc4yi4BMRDJzZf2pVG0mIhVQ20L
   sDJ0PDqGUUqKK7eObWi179mEoOIzGJEMF04ow1UqpI+g8yCXQP8/Umg3E
   t7XKSuNopo7qJCtevzmS19bylzJH7z24ncHMxXOPDGW9WUWKfCpMsCugG
   JIlIxxRLT+p3kDgknZ5bqK8kBX4K9Xk8sMJ2afyAuPbESDlB7jd6rAsTM
   r55x9d8PdWA01s5URZ3Jy6lCyNEYgl6dWP0+/uAn7Fc8lqJownJB5y2/G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590160"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230078"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230078"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/22] selftests/resctrl: Add flush_buffer() to fill_buf
Date:   Wed, 12 Apr 2023 16:21:11 +0300
Message-Id: <20230412132122.29452-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, flushing is only done after allocating and filling the
buffer and cannot be controlled by the test cases.

The new CAT test will want to control flushing within a test so
introduce flush_buffer() for that purpose.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 5 +++++
 tools/testing/selftests/resctrl/resctrl.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index f5ca0c573891..316800715386 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -66,6 +66,11 @@ static void mem_flush(void *p, size_t s)
 	sb();
 }
 
+void flush_buffer(unsigned long long span)
+{
+	mem_flush(startptr, span);
+}
+
 static void *malloc_and_init_memory(size_t s)
 {
 	void *p = NULL;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 968ac2a321ff..594e72f04b63 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,6 +99,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 void free_buffer(void);
 int alloc_buffer(unsigned long long buf_size, int memflush);
+void flush_buffer(unsigned long long span);
 int use_buffer(unsigned long long buf_size, int op, bool once);
 int run_fill_buf(unsigned long span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-- 
2.30.2

