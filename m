Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A031C5DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 04:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBPDcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 22:32:46 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53430 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhBPDci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 22:32:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UOjzwRj_1613446294;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOjzwRj_1613446294)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Feb 2021 11:31:35 +0800
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
Subject: [PATCH v5 2/3] x86/sgx: Allows ioctl PROVISION to execute before CREATE
Date:   Tue, 16 Feb 2021 11:31:32 +0800
Message-Id: <20210216033133.79543-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210216033133.79543-1-tianjia.zhang@linux.alibaba.com>
References: <20210216033133.79543-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the function sgx_create_enclave(), the direct assignment
operation of attributes_mask determines that the ioctl PROVISION
operation must be executed after the ioctl CREATE operation,
which will limit the flexibility of SGX developers.

This patch takes the assignment of attributes_mask from the
function sgx_create_enclave() has been moved to the function
sgx_open(), this will allow users to perform ioctl PROVISION
operations before ioctl CREATE, increase the flexibility of
the API and reduce restrictions.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/driver.c | 1 +
 arch/x86/kernel/cpu/sgx/ioctl.c  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 8ce6d8371cfb..892e2a2a3221 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -36,6 +36,7 @@ static int sgx_open(struct inode *inode, struct file *file)
 		return ret;
 	}
 
+	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
 	file->private_data = encl;
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 90a5caf76939..1c6ecf9fbeff 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -109,7 +109,6 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
-	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
-- 
2.19.1.3.ge56e4f7

