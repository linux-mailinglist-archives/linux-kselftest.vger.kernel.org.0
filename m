Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E6301A31
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 07:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbhAXGak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 01:30:40 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42676 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbhAXGah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 01:30:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UMf9yuo_1611469749;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMf9yuo_1611469749)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Jan 2021 14:29:09 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 3/5] x86/sgx: Optimize the free_cnt count in sgx_epc_section
Date:   Sun, 24 Jan 2021 14:29:05 +0800
Message-Id: <20210124062907.88229-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

`section->free_cnt` represents the free page in sgx_epc_section,
which is assigned once after initialization. In fact, just after the
initialization is completed, the pages are in the `init_laundry_list`
list and cannot be allocated. This needs to be recovered by EREMOVE
of function sgx_sanitize_section() before it can be used as a page
that can be allocated. The sgx_sanitize_section() will be called in
the kernel thread ksgxd.

This patch moves the initialization of `section->free_cnt` from the
initialization function `sgx_setup_epc_section()` to the function
`sgx_sanitize_section()`, and then accumulates the count after the
successful execution of EREMOVE. This seems to be more reasonable,
free_cnt will also truly reflect the allocatable free pages in EPC.

Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4465912174fd..e455ec7b3449 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -48,6 +48,7 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 		if (!ret) {
 			spin_lock(&section->lock);
 			list_move(&page->list, &section->page_list);
+			section->free_cnt++;
 			spin_unlock(&section->lock);
 		} else
 			list_move_tail(&page->list, &dirty);
@@ -643,7 +644,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
 	}
 
-	section->free_cnt = nr_pages;
 	return true;
 }
 
-- 
2.19.1.3.ge56e4f7

