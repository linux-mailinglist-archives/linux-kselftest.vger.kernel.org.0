Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3FA40CDF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhIOUce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:13811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhIOUcd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109360"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109360"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092774"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:13 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
Date:   Wed, 15 Sep 2021 13:30:52 -0700
Message-Id: <086aa5a16faf0d9b47ba9e0ebd2213713d0e76ff.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Just like normal memory, SGX memory can be overcommitted.  SGX has its
own reclaim mechanism which kicks in when physical SGX memory (Enclave
Page Cache / EPC) is exhausted.  That reclaim mechanism is relatively
rarely exercised and needs selftests to poke at it.

The amount of EPC on the system is determined by the BIOS and it varies
wildly between systems.  It can be dozens of MB on desktops, or many GB
on servers.

To run in a reasonable amount of time, the selftest needs to know how
much EPC there is in the system.

Introduce a new debugfs file to export that information.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[reinette: Use as placeholder patch until other discussions complete]
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/sgx.rst      |  6 ++++++
 arch/x86/kernel/cpu/sgx/main.c | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96ff9ef..f11bfb331b93 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,9 @@ user wants to deploy SGX applications both on the host and in guests
 on the same machine, the user should reserve enough EPC (by taking out
 total virtual EPC size of all SGX VMs from the physical EPC size) for
 host SGX applications so they can run with acceptable performance.
+
+Debugging
+=========
+
+*/sys/kernel/debug/x86/sgx_total_mem* contains an integer describing
+the total SGX reserved memory in bytes, available in the system.
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..b65da19a53ee 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <linux/debugfs.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
@@ -28,7 +29,10 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
 static LIST_HEAD(sgx_active_page_list);
 static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 
-/* The free page list lock protected variables prepend the lock. */
+/* Total EPC memory available in bytes. */
+static unsigned long sgx_total_mem;
+
+/* The number of free EPC pages in all nodes. */
 static unsigned long sgx_nr_free_pages;
 
 /* Nodes with one or more EPC sections. */
@@ -656,6 +660,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
+	sgx_total_mem += nr_pages * PAGE_SIZE;
+
 	return true;
 }
 
@@ -823,6 +829,8 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	debugfs_create_ulong("sgx_total_mem", 0444, arch_debugfs_dir, &sgx_total_mem);
+
 	return 0;
 
 err_provision:
-- 
2.25.1

