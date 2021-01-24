Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6E301A2A
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhAXGaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 01:30:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48797 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbhAXGaE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 01:30:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UMf9apv_1611469748;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMf9apv_1611469748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Jan 2021 14:29:08 +0800
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
Subject: [PATCH v3 2/5] x86/sgx: Optimize the locking range in sgx_sanitize_section()
Date:   Sun, 24 Jan 2021 14:29:04 +0800
Message-Id: <20210124062907.88229-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The spin lock of sgx_epc_section only locks the page_list. The
EREMOVE operation and init_laundry_list is not necessary in the
protection range of the spin lock. This patch reduces the lock
range of the spin lock in the function sgx_sanitize_section()
and only protects the operation of the page_list.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c519fc5f6948..4465912174fd 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -41,20 +41,17 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
 		if (kthread_should_stop())
 			return;
 
-		/* needed for access to ->page_list: */
-		spin_lock(&section->lock);
-
 		page = list_first_entry(&section->init_laundry_list,
 					struct sgx_epc_page, list);
 
 		ret = __eremove(sgx_get_epc_virt_addr(page));
-		if (!ret)
+		if (!ret) {
+			spin_lock(&section->lock);
 			list_move(&page->list, &section->page_list);
-		else
+			spin_unlock(&section->lock);
+		} else
 			list_move_tail(&page->list, &dirty);
 
-		spin_unlock(&section->lock);
-
 		cond_resched();
 	}
 
-- 
2.19.1.3.ge56e4f7

