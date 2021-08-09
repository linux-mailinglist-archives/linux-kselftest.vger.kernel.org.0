Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4540A3E42AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHIJb5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234368AbhHIJb5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:31:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27946101D;
        Mon,  9 Aug 2021 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501497;
        bh=mWQKQI8yAbXJt5cw/cLvAtRqYeiZGxdgd577VLR7NkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpSEOer/OkpU7r6DV1KoKKhSCqIU4pMP+/lGcx8JhRMC3E1esRD9uB6ECI77bygeZ
         H3x/10Dui32Fwd3ruyysS1gE3T/pA52msj7Id2xDBFoDuJGAecxcw36/wnS1EHa+JN
         hvLgPnAoqUtHDfKYF66HyIEydCU76nAs60EtXMgEIBeD1TdlmeBWl0nBJAA/p6O9jN
         NbcsdHoddzZmMUiQtT1f2BWRXoptyPDaxycbCNtAsqmludHan3Ru9p8GosS0ivrIYM
         GGtI/2xs5a4W0Anw8Wllz5iNwPR13fr9+teVuWbA1DZ/sy9Mf6rw/2orU0F73+GJel
         IyQ/BVDolaBSQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 1/8] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
Date:   Mon,  9 Aug 2021 12:31:20 +0300
Message-Id: <20210809093127.76264-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---

v3:
* Describe the units of sgx_total_mem in Dcumentation/x86/sgx.rst.
* Rewrite of the commit message (suggested by Dave):
  https://lore.kernel.org/linux-sgx/5d3614af-2393-6744-9d85-7001241ca76e@intel.com/

v2:
* sgx_nr_all_pages -> sgx_total_mem

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
2.32.0

