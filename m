Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C845E2FA22A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbhARNvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 08:51:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40318 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392291AbhARNeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 08:34:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UM8540F_1610976790;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UM8540F_1610976790)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jan 2021 21:33:10 +0800
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
Subject: [PATCH] mm: Optimizing error condition detection in do_mprotect_pkey()
Date:   Mon, 18 Jan 2021 21:33:10 +0800
Message-Id: <20210118133310.98375-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Obviously, the error variable detection of the if statement is
for the mprotect callback function, so it is also put into the
scope of calling callbck.

Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab709023e9aa..94188df1ee55 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -617,10 +617,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (tmp > end)
 			tmp = end;
 
-		if (vma->vm_ops && vma->vm_ops->mprotect)
+		if (vma->vm_ops && vma->vm_ops->mprotect) {
 			error = vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
-		if (error)
-			goto out;
+			if (error)
+				goto out;
+		}
 
 		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
-- 
2.19.1.3.ge56e4f7

