Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24CA2FA1B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392173AbhARNfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 08:35:24 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49185 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392314AbhARNfU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 08:35:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UM8549h_1610976838;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UM8549h_1610976838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jan 2021 21:33:58 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, haitao.huang@intel.com,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] x86/sgx: Remove redundant if conditions in sgx_encl_create
Date:   Mon, 18 Jan 2021 21:33:58 +0800
Message-Id: <20210118133358.99311-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In this scenario, there is no case where va_page is NULL, and
the error has been checked. The if condition statement here is
redundant, so remove the condition detection.

Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 90a5caf76939..f45957c05f69 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -66,9 +66,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	va_page = sgx_encl_grow(encl);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
-	else if (va_page)
-		list_add(&va_page->list, &encl->va_pages);
-	/* else the tail page of the VA page list had free slots. */
+
+	list_add(&va_page->list, &encl->va_pages);
 
 	/* The extra page goes to SECS. */
 	encl_size = secs->size + PAGE_SIZE;
-- 
2.19.1.3.ge56e4f7

