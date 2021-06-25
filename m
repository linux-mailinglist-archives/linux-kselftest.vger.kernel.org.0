Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4E3B47DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFYRBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:01:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3318 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhFYRBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:01:41 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBND91GHlz6L52F;
        Sat, 26 Jun 2021 00:45:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:59:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 11/12] digest_lists: Interfaces - digests_count
Date:   Fri, 25 Jun 2021 18:56:13 +0200
Message-ID: <20210625165614.2284243-12-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625165614.2284243-1-roberto.sassu@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces the digests_count interface, which shows the current
number of digests stored in the hash table by type.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst |  7 +++++
 security/integrity/digest_lists/fs.c    | 35 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index f3900a6e92f6..25b5665bbeaa 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -697,3 +697,10 @@ digest list (buffer) loaded ``through digest_list_add``.
 
 ``digest_query``: allows to write a query in the format ``<algo>-<digest>``
 and to obtain all digest lists that include that digest.
+
+
+``digests_count``
+~~~~~~~~~~~~~~~~~
+
+``digests_count`` shows the current number of digests stored in the hash
+table by type.
diff --git a/security/integrity/digest_lists/fs.c b/security/integrity/digest_lists/fs.c
index bdfeb8797760..37091db50df5 100644
--- a/security/integrity/digest_lists/fs.c
+++ b/security/integrity/digest_lists/fs.c
@@ -37,6 +37,7 @@
 
 static struct dentry *digest_lists_dir;
 static struct dentry *digest_lists_loaded_dir;
+static struct dentry *digests_count;
 static struct dentry *digest_label_dentry;
 static struct dentry *digest_query_dentry;
 static struct dentry *digest_list_add_dentry;
@@ -44,6 +45,33 @@ static struct dentry *digest_list_del_dentry;
 char digest_query[CRYPTO_MAX_ALG_NAME + 1 + IMA_MAX_DIGEST_SIZE * 2 + 1];
 char digest_label[NAME_MAX + 1];
 
+static char *types_str[COMPACT__LAST] = {
+	[COMPACT_PARSER] = "Parser",
+	[COMPACT_FILE] = "File",
+	[COMPACT_METADATA] = "Metadata",
+	[COMPACT_DIGEST_LIST] = "Digest list",
+};
+
+static ssize_t digest_lists_show_htable_len(struct file *filp, char __user *buf,
+					    size_t count, loff_t *ppos)
+{
+	char tmpbuf[1024];
+	ssize_t len = 0;
+	int i;
+
+	for (i = COMPACT_PARSER; i < COMPACT__LAST; i++)
+		len += scnprintf(tmpbuf + len, sizeof(tmpbuf) - len,
+				 "%s digests: %li\n", types_str[i],
+				 atomic_long_read(&htable[i].len));
+
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+}
+
+static const struct file_operations htable_len_ops = {
+	.read = digest_lists_show_htable_len,
+	.llseek = generic_file_llseek,
+};
+
 static int parse_digest_list_filename(const char *digest_list_filename,
 				      u8 *digest, enum hash_algo *algo)
 {
@@ -646,6 +674,12 @@ static int __init digest_lists_fs_init(void)
 	if (IS_ERR(digest_lists_loaded_dir))
 		goto out;
 
+	digests_count = securityfs_create_file("digests_count", 0440,
+					       digest_lists_dir, NULL,
+					       &htable_len_ops);
+	if (IS_ERR(digests_count))
+		goto out;
+
 	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
 						digest_lists_dir, NULL,
 						&digest_list_upload_ops);
@@ -676,6 +710,7 @@ static int __init digest_lists_fs_init(void)
 	securityfs_remove(digest_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
+	securityfs_remove(digests_count);
 	securityfs_remove(digest_lists_loaded_dir);
 	securityfs_remove(digest_lists_dir);
 	return -1;
-- 
2.25.1

