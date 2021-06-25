Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813743B47D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFYRAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:00:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3316 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhFYRAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:00:21 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNGY20pzz6G8m4;
        Sat, 26 Jun 2021 00:47:49 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:57:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 09/12] digest_lists: Interfaces - digest_label
Date:   Fri, 25 Jun 2021 18:56:11 +0200
Message-ID: <20210625165614.2284243-10-roberto.sassu@huawei.com>
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

This patch introduces the digest_label interface. It can be used to set a
label to be applied to the next digest list (buffer) loaded through
digest_list_add.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst |  7 +++++
 security/integrity/digest_lists/fs.c    | 34 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 8f245fae6825..d83279046a55 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -683,3 +683,10 @@ other (with .ascii prefix) shows the digest list in ASCII format.
 
 Files are added and removed at the same time digest lists are added and
 removed.
+
+
+``digest_label``
+~~~~~~~~~~~~~~~~
+
+``digest_label`` can be used to set a label to be applied to the next
+digest list (buffer) loaded ``through digest_list_add``.
diff --git a/security/integrity/digest_lists/fs.c b/security/integrity/digest_lists/fs.c
index f665ef063df7..f6e88fac27bc 100644
--- a/security/integrity/digest_lists/fs.c
+++ b/security/integrity/digest_lists/fs.c
@@ -34,6 +34,7 @@
 
 static struct dentry *digest_lists_dir;
 static struct dentry *digest_lists_loaded_dir;
+static struct dentry *digest_label_dentry;
 static struct dentry *digest_list_add_dentry;
 static struct dentry *digest_list_del_dentry;
 char digest_label[NAME_MAX + 1];
@@ -465,6 +466,32 @@ static const struct file_operations digest_list_upload_ops = {
 	.llseek = generic_file_llseek,
 };
 
+/*
+ * digest_label_write: write label for next uploaded digest list.
+ */
+static ssize_t digest_label_write(struct file *file, const char __user *buf,
+				  size_t datalen, loff_t *ppos)
+{
+	int rc;
+
+	if (datalen >= sizeof(digest_label))
+		return -EINVAL;
+
+	rc = copy_from_user(digest_label, buf, datalen);
+	if (rc < 0)
+		return rc;
+
+	digest_label[datalen] = '\0';
+	return datalen;
+}
+
+static const struct file_operations digest_label_ops = {
+	.open = generic_file_open,
+	.write = digest_label_write,
+	.read = seq_read,
+	.llseek = generic_file_llseek,
+};
+
 static int __init digest_lists_fs_init(void)
 {
 	digest_lists_dir = securityfs_create_dir("digest_lists", integrity_dir);
@@ -488,8 +515,15 @@ static int __init digest_lists_fs_init(void)
 	if (IS_ERR(digest_list_del_dentry))
 		goto out;
 
+	digest_label_dentry = securityfs_create_file("digest_label", 0600,
+						     digest_lists_dir, NULL,
+						     &digest_label_ops);
+	if (IS_ERR(digest_label_dentry))
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(digest_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
 	securityfs_remove(digest_lists_loaded_dir);
-- 
2.25.1

