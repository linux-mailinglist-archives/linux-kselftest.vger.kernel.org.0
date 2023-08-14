Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBA77C10C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjHNTv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 15:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjHNTvE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 15:51:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEAFA
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692042664; x=1723578664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oqkmurrjjCknc2tekPnRE1SNkVqLKF9XJZEokVHf3SI=;
  b=hMMEycJUrSJk6Fdya3Qx4860BvVzHOV1yJlPtIDZHNiqwTbpfwbucwSU
   XP+v80p743tv/+y3+j22b9Ar/13scJR9PxnVxXnPmzgVG673PNm1lUkHT
   iXFw073ir7UpebYgC/umybMfMBlkCBLdQZgYTYmKIA/QTQs2KT6zPwLV1
   kboQABF2MeMr+J+VnPXuJCngdjXzwOm+NwVe4UcfPdNNktfFryI+KJVbk
   8mnYQRwuhZ89T0q3/Q5e5hLCizVvpJKjcHoA1N4Nzku14ZuQdyCkxqgOo
   C/sZ6SpYe8RrlTSaCL6BVoH0tjeHrwij0dtCq59XY0c5NDk/cizYcCvQM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403103855"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="403103855"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 12:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980119418"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="980119418"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.212.61.216])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 12:51:00 -0700
Date:   Mon, 14 Aug 2023 12:50:59 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
Subject: How to run a single test on kselftest
Message-ID: <20230814195059.GA6500@yjiang5-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
   Can anyone give some hints on how to run a single test on the kselftest
framework? The reason that I want such support is because I have to run
test cases inside emulator, which is very slow.

   Per the kselftest documents, I can run kvm selftests with "make
-C tools/testing/selftests TARGETS=kvm run_tests", but it does not provide
a mechanism to run a single test in KVM subsystem. It takes a very long
time to finish the KVM subset testing inside the slow emulator while I'm
only trying to replace/add one testcase.

   Currently I modify the code like below, to run only a single test. Not
sure if there is a more generic way to do that. If no such mechanism and
there are more people have similar need, is it possible to add it? I'm more
than happy to contribute with guide.

Thank you
--jyh

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c692cc86e7da..25fce1a3ceb8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -56,7 +56,7 @@ LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c

 # Non-compiled test targets
-TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
+#TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh

 # Compiled test targets
 TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
@@ -135,7 +135,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test

 # Compiled outputs used by test targets
-TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
+#TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test

 TEST_GEN_PROGS_aarch64 += aarch64/aarch32_id_regs
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
@@ -186,6 +186,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))

+TEST_GEN_PROGS = x86_64/cr4_cpuid_sync_test
+
 OVERRIDE_TARGETS = 1

 # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most

