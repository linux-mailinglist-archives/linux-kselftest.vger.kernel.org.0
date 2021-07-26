Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555B93D64AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jul 2021 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhGZQAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 12:00:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3494 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbhGZQAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 12:00:21 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYQJp6lCtz6GCVT;
        Tue, 27 Jul 2021 00:25:46 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 18:40:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC][PATCH v2 10/12] diglim: Interfaces - digests_count
Date:   Mon, 26 Jul 2021 18:36:58 +0200
Message-ID: <20210726163700.2092768-11-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726163700.2092768-1-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce the digests_count interface, which shows the current number of
digests stored in the hash table by type.

Reported-by: kernel test robot <lkp@intel.com> (frame size warning)
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/diglim/fs.c | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
index f1c1fc56448a..3b1d9616cb62 100644
--- a/security/integrity/diglim/fs.c
+++ b/security/integrity/diglim/fs.c
@@ -23,6 +23,7 @@
 #include "diglim.h"
 
 #define MAX_DIGEST_LIST_SIZE (64 * 1024 * 1024 - 1)
+#define TMPBUF_SIZE 512
 
 static struct dentry *diglim_dir;
 /**
@@ -36,6 +37,13 @@ static struct dentry *diglim_dir;
  * removed.
  */
 static struct dentry *digest_lists_loaded_dir;
+/**
+ * DOC: digests_count
+ *
+ * digests_count shows the current number of digests stored in the hash
+ * table by type.
+ */
+static struct dentry *digests_count;
 /**
  * DOC: digest_label
  *
@@ -73,6 +81,39 @@ static struct dentry *digest_list_del_dentry;
 char digest_query[CRYPTO_MAX_ALG_NAME + 1 + IMA_MAX_DIGEST_SIZE * 2 + 1];
 char digest_label[NAME_MAX + 1];
 
+static char *types_str[COMPACT__LAST] = {
+	[COMPACT_PARSER] = "Parser",
+	[COMPACT_FILE] = "File",
+	[COMPACT_METADATA] = "Metadata",
+	[COMPACT_DIGEST_LIST] = "Digest list",
+};
+
+static ssize_t diglim_show_htable_len(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *tmpbuf;
+	ssize_t ret, len = 0;
+	int i;
+
+	tmpbuf = kmalloc(TMPBUF_SIZE, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	for (i = COMPACT_PARSER; i < COMPACT__LAST; i++)
+		len += scnprintf(tmpbuf + len, TMPBUF_SIZE - len,
+				 "%s digests: %lu\n", types_str[i],
+				 htable[i].len);
+
+	ret = simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+	kfree(tmpbuf);
+	return ret;
+}
+
+static const struct file_operations htable_len_ops = {
+	.read = diglim_show_htable_len,
+	.llseek = generic_file_llseek,
+};
+
 static int parse_digest_list_filename(const char *digest_list_filename,
 				      u8 *digest, enum hash_algo *algo)
 {
@@ -696,6 +737,12 @@ static int __init diglim_fs_init(void)
 	if (IS_ERR(digest_lists_loaded_dir))
 		goto out;
 
+	digests_count = securityfs_create_file("digests_count", 0440,
+					       diglim_dir, NULL,
+					       &htable_len_ops);
+	if (IS_ERR(digests_count))
+		goto out;
+
 	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
 						diglim_dir, NULL,
 						&digest_list_upload_ops);
@@ -726,6 +773,7 @@ static int __init diglim_fs_init(void)
 	securityfs_remove(digest_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
+	securityfs_remove(digests_count);
 	securityfs_remove(digest_lists_loaded_dir);
 	securityfs_remove(diglim_dir);
 	return -1;
-- 
2.25.1

