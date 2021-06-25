Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2693B47D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFYRA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:00:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3315 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFYRAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:00:21 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNGX5wmGz6G8gh;
        Sat, 26 Jun 2021 00:47:48 +0800 (CST)
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
Subject: [RFC][PATCH 08/12] digest_lists: Interfaces - digest_lists_loaded
Date:   Fri, 25 Jun 2021 18:56:10 +0200
Message-ID: <20210625165614.2284243-9-roberto.sassu@huawei.com>
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

This patch introduces the digest_lists_loaded directory in
<securityfs>/integrity/digest_lists.

It contains two files for each loaded digest list: one shows the digest
list in binary format, and the other (with .ascii prefix) shows the digest
list in ASCII format.

Files are added and removed at the same time digest lists are added and
removed.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst |  11 +
 security/integrity/digest_lists/fs.c    | 298 +++++++++++++++++++++++-
 2 files changed, 305 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 85a34a5ad7ce..8f245fae6825 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -672,3 +672,14 @@ policy, to measure it.
 ``digest_list_del`` can be used to upload a digest list and delete the
 digests from the hash table; data are interpreted in the same way as
 described for ``digest_list_add``.
+
+
+``digest_lists_loaded``
+~~~~~~~~~~~~~~~~~~~~~~~
+
+``digest_lists_loaded`` is a directory containing two files for each
+loaded digest list: one shows the digest list in binary format, and the
+other (with .ascii prefix) shows the digest list in ASCII format.
+
+Files are added and removed at the same time digest lists are added and
+removed.
diff --git a/security/integrity/digest_lists/fs.c b/security/integrity/digest_lists/fs.c
index b407c5f7b659..f665ef063df7 100644
--- a/security/integrity/digest_lists/fs.c
+++ b/security/integrity/digest_lists/fs.c
@@ -29,9 +29,250 @@
 
 #include "digest_lists.h"
 
+#define HDR_ASCII_FMT \
+	"actions: %d, version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n"
+
 static struct dentry *digest_lists_dir;
+static struct dentry *digest_lists_loaded_dir;
 static struct dentry *digest_list_add_dentry;
 static struct dentry *digest_list_del_dentry;
+char digest_label[NAME_MAX + 1];
+
+static int parse_digest_list_filename(const char *digest_list_filename,
+				      u8 *digest, enum hash_algo *algo)
+{
+	int i;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (!strncmp(digest_list_filename, hash_algo_name[i],
+			     strlen(hash_algo_name[i])))
+			break;
+
+	if (i == HASH_ALGO__LAST)
+		return -ENOENT;
+
+	*algo = i;
+	return hex2bin(digest, strchr(digest_list_filename, '-') + 1,
+		       hash_digest_size[*algo]);
+}
+
+/* returns pointer to hlist_node */
+static void *digest_list_start(struct seq_file *m, loff_t *pos)
+{
+	struct digest_item *d;
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo;
+	struct compact_list_hdr *hdr;
+	u32 count = 0;
+	void *buf, *bufp, *bufendp;
+	int ret;
+
+	ret = parse_digest_list_filename(file_dentry(m->file)->d_name.name,
+					 digest, &algo);
+	if (ret < 0)
+		return NULL;
+
+	d = digest_lookup(digest, algo, COMPACT_DIGEST_LIST, NULL, NULL);
+	if (!d)
+		return NULL;
+
+	bufp = buf = d->refs[0].digest_list->buf;
+	bufendp = bufp + d->refs[0].digest_list->size;
+
+	while (bufp < bufendp) {
+		hdr = (struct compact_list_hdr *)bufp;
+		count += hdr->count;
+		bufp += sizeof(*hdr) + hdr->datalen;
+	}
+
+	return *pos <= count ? d : NULL;
+}
+
+static void *digest_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct digest_item *d = (struct digest_item *)v;
+	struct compact_list_hdr *hdr;
+	u32 count = 0;
+	void *buf = d->refs[0].digest_list->buf;
+	void *bufp = buf;
+	void *bufendp = bufp + d->refs[0].digest_list->size;
+
+	(*pos)++;
+
+	while (bufp < bufendp) {
+		hdr = (struct compact_list_hdr *)bufp;
+		count += hdr->count;
+		bufp += sizeof(*hdr) + hdr->datalen;
+	}
+
+	return *pos <= count ? d : NULL;
+}
+
+static void digest_list_stop(struct seq_file *m, void *v)
+{
+}
+
+static void print_digest(struct seq_file *m, u8 *digest, u32 size)
+{
+	u32 i;
+
+	for (i = 0; i < size; i++)
+		seq_printf(m, "%02x", *(digest + i));
+}
+
+static void digest_list_putc(struct seq_file *m, void *data, int datalen)
+{
+	while (datalen--)
+		seq_putc(m, *(char *)data++);
+}
+
+static int digest_list_show_common(struct seq_file *m, void *v, bool binary)
+{
+	struct digest_item *d = (struct digest_item *)v;
+	struct compact_list_hdr *hdr;
+	u32 count = 0;
+	void *buf = d->refs[0].digest_list->buf;
+	void *bufp = buf;
+	void *bufendp = bufp + d->refs[0].digest_list->size;
+
+	while (bufp < bufendp) {
+		hdr = (struct compact_list_hdr *)bufp;
+
+		if (m->index >= count + hdr->count) {
+			bufp += sizeof(*hdr) + hdr->datalen;
+			count += hdr->count;
+			continue;
+		}
+
+		if (count == m->index) {
+			if (binary)
+				digest_list_putc(m, (void *)hdr, sizeof(*hdr));
+			else
+				seq_printf(m, HDR_ASCII_FMT,
+					   d->refs[0].digest_list->actions,
+					   hdr->version,
+					   hash_algo_name[hdr->algo], hdr->type,
+					   hdr->modifiers, hdr->count,
+					   hdr->datalen);
+		}
+
+		if (binary) {
+			digest_list_putc(m, bufp + sizeof(*hdr) +
+					 (m->index - count) *
+					 hash_digest_size[hdr->algo],
+					 hash_digest_size[hdr->algo]);
+		} else {
+			print_digest(m, bufp + sizeof(*hdr) +
+				     (m->index - count) *
+				     hash_digest_size[hdr->algo],
+				     hash_digest_size[hdr->algo]);
+			seq_puts(m, "\n");
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
+static int digest_list_show(struct seq_file *m, void *v)
+{
+	return digest_list_show_common(m, v, true);
+}
+
+static int digest_list_ascii_show(struct seq_file *m, void *v)
+{
+	return digest_list_show_common(m, v, false);
+}
+
+static const struct seq_operations digest_list_seqops = {
+	.start = digest_list_start,
+	.next = digest_list_next,
+	.stop = digest_list_stop,
+	.show = digest_list_show
+};
+
+static int digest_list_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &digest_list_seqops);
+}
+
+static const struct file_operations digest_list_ops = {
+	.open = digest_list_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct seq_operations digest_list_ascii_seqops = {
+	.start = digest_list_start,
+	.next = digest_list_next,
+	.stop = digest_list_stop,
+	.show = digest_list_ascii_show
+};
+
+static int digest_list_ascii_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &digest_list_ascii_seqops);
+}
+
+static const struct file_operations digest_list_ascii_ops = {
+	.open = digest_list_ascii_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int digest_list_get_secfs_files(char *label, u8 *digest,
+				       enum hash_algo algo, enum ops op,
+				       struct dentry **dentry,
+				       struct dentry **dentry_ascii)
+{
+	char digest_list_filename[NAME_MAX + 1] = { 0 };
+	u8 digest_str[IMA_MAX_DIGEST_SIZE * 2 + 1] = { 0 };
+	char *dot, *label_ptr;
+
+	label_ptr = strrchr(label, '/');
+	if (label_ptr)
+		label = label_ptr + 1;
+
+	bin2hex(digest_str, digest, hash_digest_size[algo]);
+
+	snprintf(digest_list_filename, sizeof(digest_list_filename),
+		 "%s-%s-%s.ascii", hash_algo_name[algo], digest_str, label);
+
+	dot = strrchr(digest_list_filename, '.');
+
+	*dot = '\0';
+	if (op == DIGEST_LIST_ADD)
+		*dentry = securityfs_create_file(digest_list_filename, 0440,
+						 digest_lists_loaded_dir, NULL,
+						 &digest_list_ops);
+	else
+		*dentry = lookup_positive_unlocked(digest_list_filename,
+						digest_lists_loaded_dir,
+						strlen(digest_list_filename));
+	*dot = '.';
+	if (IS_ERR(*dentry))
+		return PTR_ERR(*dentry);
+
+	if (op == DIGEST_LIST_ADD)
+		*dentry_ascii = securityfs_create_file(digest_list_filename,
+						0440, digest_lists_loaded_dir,
+						NULL, &digest_list_ascii_ops);
+	else
+		*dentry_ascii = lookup_positive_unlocked(digest_list_filename,
+						digest_lists_loaded_dir,
+						strlen(digest_list_filename));
+	if (IS_ERR(*dentry_ascii)) {
+		if (op == DIGEST_LIST_ADD)
+			securityfs_remove(*dentry);
+
+		return PTR_ERR(*dentry_ascii);
+	}
+
+	return 0;
+}
 
 static ssize_t digest_list_read(char *path, enum ops op)
 {
@@ -43,6 +284,7 @@ static ssize_t digest_list_read(char *path, enum ops op)
 	struct file *file;
 	u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
 	enum hash_algo algo = HASH_ALGO__LAST;
+	struct dentry *dentry, *dentry_ascii;
 	int rc, pathlen = strlen(path);
 
 	/* remove \n */
@@ -74,9 +316,27 @@ static ssize_t digest_list_read(char *path, enum ops op)
 	if (measured)
 		actions |= COMPACT_ACTION_IMA_MEASURED;
 
-	rc = digest_list_parse(size, data, op, actions, digest, algo, "");
+	rc = digest_list_get_secfs_files(path, digest, algo, op, &dentry,
+					 &dentry_ascii);
+	if (rc < 0)
+		goto out_vfree;
+
+	rc = digest_list_parse(size, data, op, actions, digest, algo,
+			       dentry->d_name.name);
 	if (rc < 0)
 		pr_err("unable to upload digest list %s (%d)\n", path, rc);
+
+	if ((rc < 0 && op == DIGEST_LIST_ADD) ||
+	    (rc == size && op == DIGEST_LIST_DEL)) {
+		/* Release reference taken in digest_list_get_secfs_files(). */
+		if (op == DIGEST_LIST_DEL) {
+			dput(dentry);
+			dput(dentry_ascii);
+		}
+
+		securityfs_remove(dentry);
+		securityfs_remove(dentry_ascii);
+	}
 out_vfree:
 	vfree(data);
 out:
@@ -94,7 +354,7 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 	char *data;
 	ssize_t result;
 	enum ops op = DIGEST_LIST_ADD;
-	struct dentry *dentry = file_dentry(file);
+	struct dentry *dentry = file_dentry(file), *dentry_ascii;
 	u8 digest[IMA_MAX_DIGEST_SIZE];
 	enum hash_algo algo = HASH_ALGO__LAST;
 	u8 actions = 0;
@@ -135,12 +395,36 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 		if (measured)
 			actions |= COMPACT_ACTION_IMA_MEASURED;
 
+		result = digest_list_get_secfs_files(digest_label[0] != '\0' ?
+						     digest_label : "parser",
+						     digest, algo, op,
+						     &dentry, &dentry_ascii);
+		if (result < 0)
+			goto out_kfree;
+
+		memset(digest_label, 0, sizeof(digest_label));
+
 		result = digest_list_parse(datalen, data, op, actions, digest,
-					   algo, "");
+					   algo, dentry->d_name.name);
 		if (result != datalen) {
 			pr_err("unable to upload generated digest list\n");
 			result = -EINVAL;
 		}
+
+		if ((result < 0 && op == DIGEST_LIST_ADD) ||
+		    (result == datalen && op == DIGEST_LIST_DEL)) {
+			/*
+			 * Release reference taken in
+			 * digest_list_get_secfs_files().
+			 */
+			if (op == DIGEST_LIST_DEL) {
+				dput(dentry);
+				dput(dentry_ascii);
+			}
+
+			securityfs_remove(dentry);
+			securityfs_remove(dentry_ascii);
+		}
 	}
 out_kfree:
 	kfree(data);
@@ -181,12 +465,17 @@ static const struct file_operations digest_list_upload_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init digest_lists_fs_init(void)
+static int __init digest_lists_fs_init(void)
 {
 	digest_lists_dir = securityfs_create_dir("digest_lists", integrity_dir);
 	if (IS_ERR(digest_lists_dir))
 		return -1;
 
+	digest_lists_loaded_dir = securityfs_create_dir("digest_lists_loaded",
+							digest_lists_dir);
+	if (IS_ERR(digest_lists_loaded_dir))
+		goto out;
+
 	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
 						digest_lists_dir, NULL,
 						&digest_list_upload_ops);
@@ -203,6 +492,7 @@ int __init digest_lists_fs_init(void)
 out:
 	securityfs_remove(digest_list_del_dentry);
 	securityfs_remove(digest_list_add_dentry);
+	securityfs_remove(digest_lists_loaded_dir);
 	securityfs_remove(digest_lists_dir);
 	return -1;
 }
-- 
2.25.1

