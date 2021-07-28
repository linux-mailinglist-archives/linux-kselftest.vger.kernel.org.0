Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B63D990D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhG1Wvt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 18:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhG1Wvt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9385861039;
        Wed, 28 Jul 2021 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627512707;
        bh=hREBdLCKjaxlY5Soq23xg0bs1+PSVQDszy+dpUZzM18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HL0ieCWngKN+4RV1gBWRxBgkFsZl9+zs5X5uQsWHkQ/EjUn+NeyQXNiDAKlP1rVQq
         to6/IuRy3mx3yGDIbBqUcu2qJ1WWTURryVc1OaILOh+qYaJRkpUbK2rHJPoX1L8Png
         An7hmasl9G0UtB7vUI7x9ccIdSbpkTLqHVaO007l18u5v5b2dgfSj8KV35XfZIlwiD
         UcoT03RGOlC9skU/8r37FTjyXl59qTX6FIwZQkhoYIGopdMj6/7otem0SlXDGiZWBb
         BWcnSxu4otUslkejzSFGklIzkew2LVWtCUI4SJP3fSqhwQr5N1uVC7Ffcaqgg0x9JG
         wm8zdg2ESDkLA==
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
Subject: [PATCH v2 1/4] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
Date:   Thu, 29 Jul 2021 01:51:37 +0300
Message-Id: <20210728225140.248408-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728225140.248408-1-jarkko@kernel.org>
References: <20210728225140.248408-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create /sys/kernel/debug/x86/sgx_total_mem, after the driver is
initialized, describing the total amount of SGX reserved memory (also known
as Enclave Page Cache (EPC)) available in the system.

This can be used to implement stress that trigger the page reclaimer, and
it is probably useful information when admistering a system running
enclaves anyhow.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

---

v2:
* sgx_nr_all_pages -> sgx_total_mem

 Documentation/x86/sgx.rst      |  6 ++++++
 arch/x86/kernel/cpu/sgx/main.c | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96ff9ef..15bb8f4e42af 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,9 @@ user wants to deploy SGX applications both on the host and in guests
 on the same machine, the user should reserve enough EPC (by taking out
 total virtual EPC size of all SGX VMs from the physical EPC size) for
 host SGX applications so they can run with acceptable performance.
+
+SGX debugging
+=============
+
+*/sys/kernel/debug/x86/sgx_total_mem* describes the total available
+SGX mwemory available in the system.
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

