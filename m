Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800740B4EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhINQhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:37:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3803 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhINQg6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:36:58 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H886f5F28z67x8s;
        Wed, 15 Sep 2021 00:33:30 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 18:35:39 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 09/13] diglim: Interfaces - digest_list_label
Date:   Tue, 14 Sep 2021 18:33:57 +0200
Message-ID: <20210914163401.864635-10-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914163401.864635-1-roberto.sassu@huawei.com>
References: <20210914163401.864635-1-roberto.sassu@huawei.com>
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

Introduce the digest_list_label interface. It can be used to set a label to
be applied to the next digest list (buffer) loaded through digest_list_add.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/diglim/fs.c | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
index 4913c1df2918..deeb04f3c42c 100644
--- a/security/integrity/diglim/fs.c
+++ b/security/integrity/diglim/fs.c
@@ -37,6 +37,13 @@ static struct dentry *diglim_dir;
  * removed.
  */
 static struct dentry *digest_lists_loaded_dir;
+/**
+ * DOC: digest_list_label
+ *
+ * digest_list_label can be used to set a label to be applied to the next digest
+ * list (buffer) loaded through digest_list_add.
+ */
+static struct dentry *digest_list_label_dentry;
 /**
  * DOC: digest_list_add
  *
@@ -553,6 +560,40 @@ static const struct file_operations digest_list_upload_ops = {
 	.llseek = generic_file_llseek,
 };
 
+/*
+ * digest_list_label_write: write label for next uploaded digest list.
+ */
+static ssize_t digest_list_label_write(struct file *file,
+				       const char __user *buf, size_t datalen,
+				       loff_t *ppos)
+{
+	int rc, i;
+
+	if (datalen >= sizeof(digest_list_label))
+		return -EINVAL;
+
+	rc = copy_from_user(digest_list_label, buf, datalen);
+	if (rc)
+		return -EFAULT;
+
+	for (i = 0; i < datalen; i++) {
+		if (!isgraph(digest_list_label[i]) &&
+		    digest_list_label[i] != '\0') {
+			memset(digest_list_label, 0, sizeof(digest_list_label));
+			return -EINVAL;
+		}
+	}
+
+	return datalen;
+}
+
+static const struct file_operations digest_list_label_ops = {
+	.open = generic_file_open,
+	.write = digest_list_label_write,
+	.read = seq_read,
+	.llseek = generic_file_llseek,
+};
+
 static int __init diglim_fs_init(void)
 {
 	diglim_dir = securityfs_create_dir("diglim", integrity_dir);
@@ -576,8 +617,15 @@ static int __init diglim_fs_init(void)
 	if (IS_ERR(digest_list_del_dentry))
 		goto out;
 
+	digest_list_label_dentry = securityfs_create_file("digest_list_label",
+							0600, diglim_dir, NULL,
+							&digest_list_label_ops);
+	if (IS_ERR(digest_list_label_dentry))
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(digest_list_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
 	securityfs_remove(digest_lists_loaded_dir);
-- 
2.25.1

