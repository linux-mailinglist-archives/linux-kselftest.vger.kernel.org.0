Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6186A4CF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 22:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB0VQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 16:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjB0VQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 16:16:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A190826CD8;
        Mon, 27 Feb 2023 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677532605; x=1709068605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ELF9ow2F2OB1PVfHYSLDbv3bTw6H8vE2SYqZsSwjkOI=;
  b=Av7DlEKWHs9UKsugYPSjxZDflSYd9qlDx5h/hxLKXiO7XbwWT8Bd9YSf
   Uyehc3+dpFBlx7drCVG1/raygCDOV4SybGpFToWFpPOkCxq5G0DwBdLWM
   rkqh5SkeUTG4NIEhk8dVTMw1YcXANMlkKVHR4wZdSSo6z1tAOj7uaBDgs
   2yEFIgZtliQd4AXImCmjoTdYN+X+W+RIyGiUAWEREtrmeoQqaWhRAEOPP
   u7sPAv/vxBcc8HQX1v6ZR8S8K/1g7TtKfDUhaQF02OM3lolu2/sw4kJi3
   QcTd/hu3zck4Nrtsoy96xG9YuKD8/QckY7I46QBOzevTisGTxkYRPjiB5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322216377"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="322216377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 13:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651372913"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="651372913"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2023 13:16:42 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
        linux-kselftest@vger.kernel.org, mizhang@google.com,
        chang.seok.bae@intel.com
Subject: [PATCH 2/2] selftests/x86/amx: Add a ptrace test
Date:   Mon, 27 Feb 2023 13:05:04 -0800
Message-Id: <20230227210504.18520-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227210504.18520-1-chang.seok.bae@intel.com>
References: <20221018221349.4196-1-chang.seok.bae@intel.com>
 <20230227210504.18520-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Include a test case to validate the XTILEDATA injection to the target.

Also, it ensures the kernel's ability to copy states between different
XSAVE formats.

Refactor the memcmp() code to be usable for the state validation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/x86/amx.c | 108 +++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 625e42901237..d884fd69dd51 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -14,8 +14,10 @@
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
+#include <sys/ptrace.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
+#include <sys/uio.h>
 
 #include "../kselftest.h" /* For __cpuid_count() */
 
@@ -583,6 +585,13 @@ static void test_dynamic_state(void)
 	_exit(0);
 }
 
+static inline int __compare_tiledata_state(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
+{
+	return memcmp(&xbuf1->bytes[xtiledata.xbuf_offset],
+		      &xbuf2->bytes[xtiledata.xbuf_offset],
+		      xtiledata.size);
+}
+
 /*
  * Save current register state and compare it to @xbuf1.'
  *
@@ -599,9 +608,7 @@ static inline bool __validate_tiledata_regs(struct xsave_buffer *xbuf1)
 		fatal_error("failed to allocate XSAVE buffer\n");
 
 	xsave(xbuf2, XFEATURE_MASK_XTILEDATA);
-	ret = memcmp(&xbuf1->bytes[xtiledata.xbuf_offset],
-		     &xbuf2->bytes[xtiledata.xbuf_offset],
-		     xtiledata.size);
+	ret = __compare_tiledata_state(xbuf1, xbuf2);
 
 	free(xbuf2);
 
@@ -826,6 +833,99 @@ static void test_context_switch(void)
 	free(finfo);
 }
 
+/* Ptrace test */
+
+/*
+ * Make sure the ptracee has the expanded kernel buffer on the first
+ * use. Then, initialize the state before performing the state
+ * injection from the ptracer.
+ */
+static inline void ptracee_firstuse_tiledata(void)
+{
+	load_rand_tiledata(stashed_xsave);
+	init_xtiledata();
+}
+
+/*
+ * Ptracer injects the randomized tile data state. It also reads
+ * before and after that, which will execute the kernel's state copy
+ * functions. So, the tester is advised to double-check any emitted
+ * kernel messages.
+ */
+static void ptracer_inject_tiledata(pid_t target)
+{
+	struct xsave_buffer *xbuf;
+	struct iovec iov;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		fatal_error("unable to allocate XSAVE buffer");
+
+	printf("\tRead the init'ed tiledata via ptrace().\n");
+
+	iov.iov_base = xbuf;
+	iov.iov_len = xbuf_size;
+
+	memset(stashed_xsave, 0, xbuf_size);
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_GETREGSET");
+
+	if (!__compare_tiledata_state(stashed_xsave, xbuf))
+		printf("[OK]\tThe init'ed tiledata was read from ptracee.\n");
+	else
+		printf("[FAIL]\tThe init'ed tiledata was not read from ptracee.\n");
+
+	printf("\tInject tiledata via ptrace().\n");
+
+	load_rand_tiledata(xbuf);
+
+	memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
+	       &xbuf->bytes[xtiledata.xbuf_offset],
+	       xtiledata.size);
+
+	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_SETREGSET");
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		fatal_error("PTRACE_GETREGSET");
+
+	if (!__compare_tiledata_state(stashed_xsave, xbuf))
+		printf("[OK]\tTiledata was correctly written to ptracee.\n");
+	else
+		printf("[FAIL]\tTiledata was not correctly written to ptracee.\n");
+}
+
+static void test_ptrace(void)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork");
+	} else if (!child) {
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			err(1, "PTRACE_TRACEME");
+
+		ptracee_firstuse_tiledata();
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	ptracer_inject_tiledata(child);
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "ptrace test");
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -846,6 +946,8 @@ int main(void)
 	ctxtswtest_config.num_threads = 5;
 	test_context_switch();
 
+	test_ptrace();
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
-- 
2.17.1

