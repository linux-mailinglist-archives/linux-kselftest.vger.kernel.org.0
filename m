Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83248722E49
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjFESFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjFESEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:04:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60B10F6;
        Mon,  5 Jun 2023 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988239; x=1717524239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tlqcBuGsxOSKA74bKjbrp+jQUh7f0hcz1UsL+nprPCM=;
  b=Wqpt7jOaUP7T6Zma2jkS7N41+GFkGsSzywN/hkT9eH8F1symbnGa7ja+
   nP1jxfM/KVuLqgkvxTzVCkcf9KkqQgHoKvuAxi/Tx0N8GQTW4r4RSYj7d
   1pM+Tizzia2uo2vcdyYGnkf+uIe1Lw2yk1kDao0qYpprGKjYrNP9MpmBx
   fYPlRqB6rERAuscFKRJzzLEJ6+GwcAl/vj8VdgdyzX1NyfUInbKw53iTA
   IMx16CTE+ztTfC+wXLxlyiGv5sWUCy5N9YQ7+bzvRP2opNs5ahMlbL4XK
   aqV0TRuJEULRu1owJCqEet/VUn+p73PS9nEyxPJ7X5uPeWnfPuLMOs6Jk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815458"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815458"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274326"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274326"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 18/19] selftests/resctrl: Pass the real number of tests to show_cache_info()
Date:   Mon,  5 Jun 2023 21:01:44 +0300
Message-Id: <20230605180145.112924-19-ilpo.jarvinen@linux.intel.com>
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

Results include warm-up test which is discarded before passing the sum
to show_cache_info(). show_cache_info() handles this by subtracting one
from the number of tests in divisor. It is a trappy construct to have
sum and number of tests parameters to disagree like this.

A more logical place for subtracting the skipped tests is where the sum
is calculated so move it there. Pass the correct number of tests to
show_cache_info() so it can be used directly as the divisor for
calculating the average.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 2 +-
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 385c01dd3ec6..5aa112e5fdd3 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -290,7 +290,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	long avg_diff = 0;
 	int ret;
 
-	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_llc_val = sum_llc_val / num_of_runs;
 	avg_diff = (long)abs(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index ed6c8e64ad11..3848dfb46aba 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -77,7 +77,7 @@ static int check_results(struct resctrl_val_param *param)
 	no_of_bits = count_bits(param->mask);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0ac9d6bbd13d..cb2197647c6c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -59,7 +59,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	fclose(fp);
 
 	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
 
-- 
2.30.2

