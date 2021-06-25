Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599D3B47DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFYRBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:01:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3317 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhFYRBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:01:40 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBND84LGRz6L4sy;
        Sat, 26 Jun 2021 00:45:44 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:59:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 10/12] digest_lists: Interfaces - digest_query
Date:   Fri, 25 Jun 2021 18:56:12 +0200
Message-ID: <20210625165614.2284243-11-roberto.sassu@huawei.com>
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

This patch introduces the digest_query interface, which allows to write a
query in the format ``<algo>-<digest>`` and to obtain all digest lists that
include that digest.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst |   7 ++
 security/integrity/digest_lists/fs.c    | 150 ++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index d83279046a55..f3900a6e92f6 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -690,3 +690,10 @@ removed.
 
 ``digest_label`` can be used to set a label to be applied to the next
 digest list (buffer) loaded ``through digest_list_add``.
+
+
+``digest_query``
+~~~~~~~~~~~~~~~~
+
+``digest_query``: allows to write a query in the format ``<algo>-<digest>``
+and to obtain all digest lists that include that digest.
diff --git a/security/integrity/digest_lists/fs.c b/security/integrity/digest_lists/fs.c
index f6e88fac27bc..bdfeb8797760 100644
--- a/security/integrity/digest_lists/fs.c
+++ b/security/integrity/digest_lists/fs.c
@@ -31,12 +31,17 @@
 
 #define HDR_ASCII_FMT \
 	"actions: %d, version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n"
+#define QUERY_RESULT_FMT \
+	"%s (actions: %d): version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n"
+#define QUERY_RESULT_DIGEST_LIST_FMT "%s (actions: %d): type: %d, size: %lld\n"
 
 static struct dentry *digest_lists_dir;
 static struct dentry *digest_lists_loaded_dir;
 static struct dentry *digest_label_dentry;
+static struct dentry *digest_query_dentry;
 static struct dentry *digest_list_add_dentry;
 static struct dentry *digest_list_del_dentry;
+char digest_query[CRYPTO_MAX_ALG_NAME + 1 + IMA_MAX_DIGEST_SIZE * 2 + 1];
 char digest_label[NAME_MAX + 1];
 
 static int parse_digest_list_filename(const char *digest_list_filename,
@@ -224,6 +229,83 @@ static const struct file_operations digest_list_ascii_ops = {
 	.release = seq_release,
 };
 
+static void *digest_query_start(struct seq_file *m, loff_t *pos)
+{
+	struct digest_item *d;
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo;
+	loff_t count = 0;
+	enum compact_types type = 0;
+	struct digest_list_item_ref *ref;
+	int ret, refs;
+
+	ret = parse_digest_list_filename(digest_query, digest, &algo);
+	if (ret < 0)
+		return NULL;
+
+	for (type = 0; type < COMPACT__LAST; type++) {
+		d = digest_lookup(digest, algo, type, NULL, NULL);
+		if (!d)
+			continue;
+
+		rcu_read_lock();
+		for (ref = rcu_dereference(d->refs), refs = 0;
+		     ref != NULL && !digest_list_ref_is_last(ref);
+		     ref++, refs++)
+			;
+		rcu_read_unlock();
+
+		count += refs;
+
+		if (count > *pos)
+			break;
+	}
+
+	if (type == COMPACT__LAST)
+		return NULL;
+
+	return d->refs ? d->refs + (*pos - (count - refs)) : NULL;
+}
+
+static void *digest_query_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct digest_list_item_ref *refs = (struct digest_list_item_ref *)v;
+
+	refs++;
+	(*pos)++;
+
+	return (refs->digest_list) ? refs : NULL;
+}
+
+static void digest_query_stop(struct seq_file *m, void *v)
+{
+}
+
+static int digest_query_show(struct seq_file *m, void *v)
+{
+	struct digest_list_item_ref *refs = (struct digest_list_item_ref *)v;
+	struct digest_list_item *digest_list = refs->digest_list;
+	struct compact_list_hdr *hdr;
+
+	if (digest_list_ref_invalidated(refs))
+		return 0;
+
+	hdr = get_hdr_ref(refs);
+
+	if (!refs->digest_offset) {
+		seq_printf(m, QUERY_RESULT_DIGEST_LIST_FMT, digest_list->label,
+			   digest_list->actions, COMPACT_DIGEST_LIST,
+			   digest_list->size);
+		return 0;
+	}
+
+	seq_printf(m, QUERY_RESULT_FMT, digest_list->label,
+		   digest_list->actions, hdr->version,
+		   hash_algo_name[hdr->algo], hdr->type, hdr->modifiers,
+		   hdr->count, hdr->datalen);
+	return 0;
+}
+
 static int digest_list_get_secfs_files(char *label, u8 *digest,
 				       enum hash_algo algo, enum ops op,
 				       struct dentry **dentry,
@@ -492,6 +574,67 @@ static const struct file_operations digest_label_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static const struct seq_operations digest_query_seqops = {
+	.start = digest_query_start,
+	.next = digest_query_next,
+	.stop = digest_query_stop,
+	.show = digest_query_show,
+};
+
+/*
+ * digest_query_open: open to write a query or read the result.
+ */
+static int digest_query_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &flags))
+		return -EBUSY;
+
+	if (file->f_flags & O_WRONLY)
+		return 0;
+
+	return seq_open(file, &digest_query_seqops);
+}
+
+/*
+ * digest_query_open: write digest query (<algo>-<digest>).
+ */
+static ssize_t digest_query_write(struct file *file, const char __user *buf,
+				  size_t datalen, loff_t *ppos)
+{
+	int rc;
+
+	if (datalen >= sizeof(digest_query))
+		return -EINVAL;
+
+	rc = copy_from_user(digest_query, buf, datalen);
+	if (rc < 0)
+		return rc;
+
+	digest_query[datalen] = '\0';
+	return datalen;
+}
+
+/*
+ * digest_query_release - release the digest_query file
+ */
+static int digest_query_release(struct inode *inode, struct file *file)
+{
+	clear_bit(0, &flags);
+
+	if (file->f_flags & O_WRONLY)
+		return 0;
+
+	return seq_release(inode, file);
+}
+
+static const struct file_operations digest_query_ops = {
+	.open = digest_query_open,
+	.write = digest_query_write,
+	.read = seq_read,
+	.release = digest_query_release,
+	.llseek = generic_file_llseek,
+};
+
 static int __init digest_lists_fs_init(void)
 {
 	digest_lists_dir = securityfs_create_dir("digest_lists", integrity_dir);
@@ -521,8 +664,15 @@ static int __init digest_lists_fs_init(void)
 	if (IS_ERR(digest_label_dentry))
 		goto out;
 
+	digest_query_dentry = securityfs_create_file("digest_query", 0600,
+						     digest_lists_dir, NULL,
+						     &digest_query_ops);
+	if (IS_ERR(digest_query_dentry))
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(digest_query_dentry);
 	securityfs_remove(digest_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
-- 
2.25.1

