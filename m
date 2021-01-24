Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1819E301A2B
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 07:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbhAXGaQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 01:30:16 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:13536 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbhAXGaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 01:30:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UMfTHuJ_1611469750;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMfTHuJ_1611469750)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Jan 2021 14:29:10 +0800
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
Subject: [PATCH v3 5/5] x86/sgx: Remove redundant if conditions in sgx_encl_create
Date:   Sun, 24 Jan 2021 14:29:07 +0800
Message-Id: <20210124062907.88229-6-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In this scenario, there is no case where va_page is NULL, and
the error has been checked. The if condition statement here is
redundant, so remove the condition detection.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 1c6ecf9fbeff..b0b829f1b761 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -66,9 +66,11 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	va_page = sgx_encl_grow(encl);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
-	else if (va_page)
-		list_add(&va_page->list, &encl->va_pages);
-	/* else the tail page of the VA page list had free slots. */
+
+	if (WARN_ONCE(!va_page, "non-empty VA page list before ECREATE"))
+		return -EIO;
+
+	list_add(&va_page->list, &encl->va_pages);
 
 	/* The extra page goes to SECS. */
 	encl_size = secs->size + PAGE_SIZE;
-- 
2.19.1.3.ge56e4f7

