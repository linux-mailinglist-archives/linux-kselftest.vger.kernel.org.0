Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532240CA25
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhIOQeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:34:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3824 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhIOQeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m0q4x9Mz67gjm;
        Thu, 16 Sep 2021 00:30:35 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:32:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 1/9] ima: Introduce new hook DIGEST_LIST_CHECK
Date:   Wed, 15 Sep 2021 18:31:37 +0200
Message-ID: <20210915163145.1046505-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915163145.1046505-1-roberto.sassu@huawei.com>
References: <20210915163145.1046505-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a new hook called DIGEST_LIST_CHECK to measure and appraise files
read by the kernel with type READING_DIGEST_LIST. Files with this type are:
- digest lists directly read by the kernel
- executables of digest list parsers
- files read by the parsers (including digest lists)

Typical rules with the new hook are:
- measure func=DIGEST_LIST_CHECK pcr=11
- appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        | 1 +
 security/integrity/ima/ima_main.c   | 3 ++-
 security/integrity/ima/ima_policy.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..d01ca3566aec 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -202,6 +202,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
 	hook(SETXATTR_CHECK, setxattr_check)		\
+	hook(DIGEST_LIST_CHECK, digest_list)		\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 26a709207ca3..d33765c7aaa7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -723,7 +723,8 @@ const int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 761ae5b63735..8d6f5d85dfa4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1222,6 +1222,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case MODULE_CHECK:
 	case KEXEC_KERNEL_CHECK:
 	case KEXEC_INITRAMFS_CHECK:
+	case DIGEST_LIST_CHECK:
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
@@ -1446,6 +1447,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = CRITICAL_DATA;
 			else if (strcmp(args[0].from, "SETXATTR_CHECK") == 0)
 				entry->func = SETXATTR_CHECK;
+			else if (strcmp(args[0].from, "DIGEST_LIST_CHECK") == 0)
+				entry->func = DIGEST_LIST_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.25.1

