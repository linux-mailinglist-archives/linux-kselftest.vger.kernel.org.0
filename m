Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D101340B4F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhINQiL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:38:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3804 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINQiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:38:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H887x2378z67Ljg;
        Wed, 15 Sep 2021 00:34:37 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 18:36:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 10/13] diglim: Interfaces - digest_query
Date:   Tue, 14 Sep 2021 18:33:58 +0200
Message-ID: <20210914163401.864635-11-roberto.sassu@huawei.com>
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

Introduce the digest_query interface, which allows to write a query in the
format <algo>-<digest> and to obtain all digest lists that include that
digest.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/diglim/fs.c | 181 +++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
index deeb04f3c42c..e383254c72a4 100644
--- a/security/integrity/diglim/fs.c
+++ b/security/integrity/diglim/fs.c
@@ -44,6 +44,13 @@ static struct dentry *digest_lists_loaded_dir;
  * list (buffer) loaded through digest_list_add.
  */
 static struct dentry *digest_list_label_dentry;
+/**
+ * DOC: digest_query
+ *
+ * digest_query allows to write a query in the format <algo>-<digest> and
+ * to obtain all digest lists that include that digest.
+ */
+static struct dentry *digest_query_dentry;
 /**
  * DOC: digest_list_add
  *
@@ -64,6 +71,7 @@ static struct dentry *digest_list_add_dentry;
  * described for digest_list_add.
  */
 static struct dentry *digest_list_del_dentry;
+char digest_query[CRYPTO_MAX_ALG_NAME + 1 + IMA_MAX_DIGEST_SIZE * 2 + 1];
 char digest_list_label[NAME_MAX + 1];
 
 static int parse_digest_list_filename(const char *digest_list_filename,
@@ -264,6 +272,84 @@ static const struct file_operations digest_list_ascii_ops = {
 	.release = seq_release,
 };
 
+/*
+ * *pos is the n-th reference to show among all the references in all digest
+ * items found with the query.
+ */
+static void *digest_query_start(struct seq_file *m, loff_t *pos)
+{
+	struct digest_item *d;
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo;
+	loff_t count = 0;
+	enum compact_types type = 0;
+	struct digest_list_item_ref *ref;
+	int ret;
+
+	ret = parse_digest_list_filename(digest_query, digest, &algo);
+	if (ret < 0)
+		return NULL;
+
+	for (type = 0; type < COMPACT__LAST; type++) {
+		d = __digest_lookup(digest, algo, type, NULL, NULL);
+		if (!d)
+			continue;
+
+		list_for_each_entry(ref, &d->refs, list) {
+			if (count++ == *pos) {
+				m->private = d;
+				return ref;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static void *digest_query_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct digest_item *d = (struct digest_item *)m->private;
+	struct digest_list_item_ref *cur_ref = (struct digest_list_item_ref *)v;
+	struct digest_list_item_ref *ref;
+
+	(*pos)++;
+
+	list_for_each_entry(ref, &d->refs, list) {
+		if (ref != cur_ref)
+			continue;
+
+		if (!list_is_last(&cur_ref->list, &d->refs))
+			return list_next_entry(cur_ref, list);
+	}
+
+	return NULL;
+}
+
+static void digest_query_stop(struct seq_file *m, void *v)
+{
+}
+
+static int digest_query_show(struct seq_file *m, void *v)
+{
+	struct digest_list_item_ref *ref = (struct digest_list_item_ref *)v;
+	struct digest_list_item *digest_list = ref->digest_list;
+	struct compact_list_hdr *hdr = get_hdr_ref(ref);
+
+	if (!ref->digest_offset) {
+		seq_printf(m, "%s (actions: %d): type: %d, size: %lld\n",
+			   digest_list->label, digest_list->actions,
+			   COMPACT_DIGEST_LIST, digest_list->size);
+		return 0;
+	}
+
+	seq_printf(m,
+		"%s (actions: %d): version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n",
+		digest_list->label, digest_list->actions, hdr->version,
+		hash_algo_name[hdr->algo], hdr->type, hdr->modifiers,
+		hdr->count, hdr->datalen);
+	return 0;
+}
+
 static int digest_list_get_secfs_files(char *label, u8 *digest,
 				       enum hash_algo algo, enum ops op,
 				       struct dentry **dentry,
@@ -594,6 +680,94 @@ static const struct file_operations digest_list_label_ops = {
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
+ * digest_query_open: sequentialize access to the add/del/query files
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
+ * digest_query_write: write digest query (<algo>-<digest>).
+ */
+static ssize_t digest_query_write(struct file *file, const char __user *buf,
+				  size_t datalen, loff_t *ppos)
+{
+	char *sep;
+	int rc, i;
+
+	if (datalen >= sizeof(digest_query))
+		return -EINVAL;
+
+	rc = copy_from_user(digest_query, buf, datalen);
+	if (rc)
+		return -EFAULT;
+
+	sep = strchr(digest_query, '-');
+	if (!sep) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*sep = '\0';
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, digest_query);
+	if (i < 0) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	*sep = '-';
+
+	for (i = 0; i < hash_digest_size[i] * 2; i++) {
+		if (!isxdigit(sep[i + 1])) {
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+out:
+	if (rc < 0) {
+		memset(digest_query, 0, sizeof(digest_query));
+		return rc;
+	}
+
+	return datalen;
+}
+
+/*
+ * digest_query_release - release the query file
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
 static int __init diglim_fs_init(void)
 {
 	diglim_dir = securityfs_create_dir("diglim", integrity_dir);
@@ -623,8 +797,15 @@ static int __init diglim_fs_init(void)
 	if (IS_ERR(digest_list_label_dentry))
 		goto out;
 
+	digest_query_dentry = securityfs_create_file("digest_query", 0600,
+						     diglim_dir, NULL,
+						     &digest_query_ops);
+	if (IS_ERR(digest_query_dentry))
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(digest_query_dentry);
 	securityfs_remove(digest_list_label_dentry);
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
-- 
2.25.1

