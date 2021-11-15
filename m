Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A645107B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 19:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhKOSt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 13:49:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:59273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242884AbhKOSrU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 13:47:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220713111"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="220713111"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="454130658"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 10:35:37 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 08/13] selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
Date:   Mon, 15 Nov 2021 10:35:21 -0800
Message-Id: <41f7c508eea79a3198b5014d7691903be08f9ff1.1636997631.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636997631.git.reinette.chatre@intel.com>
References: <cover.1636997631.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Add a variation of the unclobbered_vdso test.

In the new test, create a heap for the test enclave, which has the same
size as all available Enclave Page Cache (EPC) pages in the system. This
will guarantee that all test_encl.elf pages *and* SGX Enclave Control
Structure (SECS) have been swapped out by the page reclaimer during the
load time.

This test will trigger both the page reclaimer and the page fault handler.
The page reclaimer triggered, while the heap is being created during the
load time. The page fault handler is triggered for all the required pages,
while the test case is executing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- No longer depend on NUMA node attributes to learn amount of SGX memory,
  instead compute it directly from information obtained via CPUID (Dave).

Changes since V1:
- Add signature from Dave.
- Add support to obtain SGX physical memory from v8 of Jarkko's patches.

 tools/testing/selftests/sgx/main.c | 75 ++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f41fba919d06..ee8139a22a3c 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -245,6 +245,81 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+/*
+ * A section metric is concatenated in a way that @low bits 12-31 define the
+ * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
+ * metric.
+ */
+static unsigned long sgx_calc_section_metric(unsigned int low,
+					     unsigned int high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+/*
+ * Sum total available physical SGX memory across all EPC sections
+ *
+ * Return: total available physical SGX memory available on system
+ */
+static unsigned long get_total_epc_mem(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned long total_size = 0;
+	unsigned int type;
+	int section = 0;
+
+	while (true) {
+		eax = SGX_CPUID;
+		ecx = section + SGX_CPUID_EPC;
+		__cpuid(&eax, &ebx, &ecx, &edx);
+
+		type = eax & SGX_CPUID_EPC_MASK;
+		if (type == SGX_CPUID_EPC_INVALID)
+			break;
+
+		if (type != SGX_CPUID_EPC_SECTION)
+			break;
+
+		total_size += sgx_calc_section_metric(ecx, edx);
+
+		section++;
+	}
+
+	return total_size;
+}
+
+TEST_F(enclave, unclobbered_vdso_oversubscribed)
+{
+	unsigned long total_mem;
+	struct encl_op op;
+
+	total_mem = get_total_epc_mem();
+	ASSERT_NE(total_mem, 0);
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+}
+
 TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
-- 
2.25.1

