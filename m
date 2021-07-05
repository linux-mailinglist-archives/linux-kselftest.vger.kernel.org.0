Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F803BBE49
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhGEOjh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 10:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhGEOjg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 10:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E68A61283;
        Mon,  5 Jul 2021 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625495819;
        bh=y52tpphSpDoVZ3rjuGEqTXUglt2049AtGx/h6xY+gf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnUyWaN7RVfSHU1mzMOfFIqvHaVehl52zd+zvY0vq1dXqKoC1twU5ozt7twXw0W8T
         ROqual2tbcjAz0ieNmNnAD9fNBZYzv9+sqAvdL1NJHi71g7FFdskjMNKv7UW6YlQb3
         ouXuyY70bDLpdxELAODISC5/E0MPPbEZWB/Ajceo26q/sb/I2aiUFfvlo73uwq7SJh
         kKxLK9xS7/LmTUQ4Fduc/fK60ZV92Ny6hMyvO7ygXYGNIv4W6aq5wX97sqXGoFbaRi
         pqsznarbt2jrzXY+i8n1HC8CwjlEK5dimtx/RgEWKAYn6S0P7ZLXZ7Ms8lON6Dn3gE
         flL52tsYRvnBg==
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
Subject: [PATCH 1/4] x86/sgx: Add sgx_nr_all_pages to the debugfs
Date:   Mon,  5 Jul 2021 17:36:49 +0300
Message-Id: <20210705143652.116125-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705143652.116125-1-jarkko@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create /sys/kernel/debug/x86/sgx_nr_all_pages, which reports total
number of EPC pages available in the system.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 Documentation/x86/sgx.rst      |  9 +++++++++
 arch/x86/kernel/cpu/sgx/main.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index dd0ac96ff9ef..3a8fefdebee0 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -250,3 +250,12 @@ user wants to deploy SGX applications both on the host and in guests
 on the same machine, the user should reserve enough EPC (by taking out
 total virtual EPC size of all SGX VMs from the physical EPC size) for
 host SGX applications so they can run with acceptable performance.
+
+SGX debugging
+=============
+
+The total number of available EPC pages can observed by:
+
+  # mount -t debugfs debugfs /sys/kernel/debug
+  # cat /sys/kernel/debug/x86/sgx_nr_all_pages
+  <the number of all EPC pages available in the system>
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..43e4b6215e62 100644
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
+/* The number of EPC pages in total in all nodes. */
+static unsigned long sgx_nr_all_pages;
+
+/* The number of free EPC pages in all nodes. */
 static unsigned long sgx_nr_free_pages;
 
 /* Nodes with one or more EPC sections. */
@@ -656,6 +660,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
+	sgx_nr_all_pages += nr_pages;
+
 	return true;
 }
 
@@ -823,6 +829,8 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	debugfs_create_ulong("sgx_nr_all_pages", 0444, arch_debugfs_dir, &sgx_nr_all_pages);
+
 	return 0;
 
 err_provision:
-- 
2.32.0

