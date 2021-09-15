Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6F40CA5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhIOQgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:36:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3826 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhIOQeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m0s0m94z67jhw;
        Thu, 16 Sep 2021 00:30:37 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:32:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 3/9] diglim: LSM
Date:   Wed, 15 Sep 2021 18:31:39 +0200
Message-ID: <20210915163145.1046505-4-roberto.sassu@huawei.com>
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

Introduce a new LSM to keep track of the operations performed by digest
list parsers to convert the digest lists and upload them to the kernel.

The motivation and its behavior is described more in detail in
Documentation/security/diglim/lsm.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/diglim/index.rst |   1 +
 Documentation/security/diglim/lsm.rst   |  65 ++++
 MAINTAINERS                             |   1 +
 security/integrity/diglim/Makefile      |   2 +-
 security/integrity/diglim/diglim.h      |  27 ++
 security/integrity/diglim/fs.c          |   3 +
 security/integrity/diglim/hooks.c       | 436 ++++++++++++++++++++++++
 7 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/security/diglim/lsm.rst
 create mode 100644 security/integrity/diglim/hooks.c

diff --git a/Documentation/security/diglim/index.rst b/Documentation/security/diglim/index.rst
index d4ba4ce50a59..bf3cc4a9a91d 100644
--- a/Documentation/security/diglim/index.rst
+++ b/Documentation/security/diglim/index.rst
@@ -12,3 +12,4 @@ Digest Lists Integrity Module (DIGLIM)
    implementation
    remote_attestation
    tests
+   lsm
diff --git a/Documentation/security/diglim/lsm.rst b/Documentation/security/diglim/lsm.rst
new file mode 100644
index 000000000000..ce979e6c6dfd
--- /dev/null
+++ b/Documentation/security/diglim/lsm.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+LSM
+===
+
+When digest lists (in compact format) are directly uploaded by the kernel,
+determining their integrity is straightforward, as a file open is the only
+operation performed.
+
+However, if digest lists are first processed by a user space parser, many
+operations occur before the converted digest list is uploaded to the
+kernel, and any of them may affect the result of the conversion. In this
+case, the integrity of all files involved must be evaluated to ensure that
+the output is the expected one.
+
+The new DIGLIM LSM has been introduced with two goals: the first is to
+identify user space parsers as soon as they are loaded, in order to monitor
+the operations they perform; the second is to avoid interference from other
+processes, which are assumed as untrusted.
+
+Regarding the first goal, user space parsers are identified by calculating
+the digest of their executable and searching it in the DIGLIM hash table.
+An executable is successfully recognized as a digest list parser if its
+digest is found and the associated type is COMPACT_PARSER. Once a parser
+has been identified, DIGLIM LSM monitors the integrity of opened files. In
+addition, it also denies access to ld.so.cache, to avoid an unknown
+measurement or appraisal failure, and to files without content measurable
+by IMA (e.g. character devices).
+
+The integrity status of the parser, a set of flags representing the
+operations performed by IMA, is kept in the credentials of the process
+identified as parser. Initially, the flags are set from the operations done
+on the executable and they are AND-ed with the flags retrieved at each file
+open (which themselves are set from the operations done by IMA on that
+file). This ensures that even if one file was not processed, this is
+reflected in the global integrity status of the parser. Given that the AND
+operation prevents the cleared flag to be set again, the only way to upload
+a converted digest list with that flag is to restart the parser.
+
+The flags still set in the process credentials at the time the parser
+uploads the converted digest lists are then copied to the converted lists
+themselves, so that they can be retrieved by DIGLIM users during a digest
+query and evaluated (the query result might be discarded). This mechanism
+is reliable against LSM misconfiguration: if for any reason DIGLIM LSM is
+turned off, no flags will be set in the converted digest list.
+
+Regarding the second goal, avoiding interference from other user space
+processes is necessary if they are assumed to be untrusted. This threat
+model applies if the system is supposed to enforce a mandatory policy where
+only files shipped by software vendors are allowed to be accessed. The
+mandatory policy could be also defined by system administrators (they could
+decide the set of approved software vendors).
+
+To avoid interference to the user space parsers from other processes, the
+following countermeasures are implemented. First, files accessed by user
+space parsers are exclusively write-locked until the parsers finish to use
+them. A failure when write-locking a file (if the file was already opened
+for writing by another process) will result in the file access to be denied
+to the parser. Second, ptraces on the parsers are also denied as they might
+influence their execution.
+
+Other than these two limitations (not being able to access files
+write-locked by the parsers and to ptrace the parsers), processes which are
+not identified as parsers are not subject to the policy enforcement by
+DIGLIM LSM.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0ffceb271803..94220e40b7e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5511,6 +5511,7 @@ F:	Documentation/security/diglim/architecture.rst
 F:	Documentation/security/diglim/implementation.rst
 F:	Documentation/security/diglim/index.rst
 F:	Documentation/security/diglim/introduction.rst
+F:	Documentation/security/diglim/lsm.rst
 F:	Documentation/security/diglim/remote_attestation.rst
 F:	Documentation/security/diglim/tests.rst
 F:	include/linux/diglim.h
diff --git a/security/integrity/diglim/Makefile b/security/integrity/diglim/Makefile
index ae79a3317ec8..37fa6ef2a73c 100644
--- a/security/integrity/diglim/Makefile
+++ b/security/integrity/diglim/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_DIGLIM) += diglim.o
 
-diglim-y := methods.o parser.o ima.o fs.o loader.o
+diglim-y := methods.o parser.o ima.o fs.o loader.o hooks.o
diff --git a/security/integrity/diglim/diglim.h b/security/integrity/diglim/diglim.h
index c597c2e7a52a..b53de803a63c 100644
--- a/security/integrity/diglim/diglim.h
+++ b/security/integrity/diglim/diglim.h
@@ -21,6 +21,7 @@
 #include <crypto/hash_info.h>
 #include <linux/hash_info.h>
 #include <linux/diglim.h>
+#include <linux/lsm_hooks.h>
 
 #include "../integrity.h"
 
@@ -28,6 +29,13 @@
 #define HASH_BITS 10
 #define DIGLIM_HTABLE_SIZE (1 << HASH_BITS)
 
+#define FLAG_PARSER_EXEC	0x01
+#define FLAG_PARSER_FILE_ACCESS	0x02
+#define FLAG_PARSER_FILE_ACCESS_DENY	0x04
+
+extern struct lsm_blob_sizes diglim_lsm_blob_sizes;
+extern int diglim_lsm_enabled;
+
 /**
  * struct digest_list_item - a digest list loaded into the kernel
  *
@@ -229,4 +237,23 @@ int diglim_ima_get_info(struct file *file, u8 *buffer, size_t buffer_len,
 			enum hash_algo *algo, u8 *actions);
 
 ssize_t digest_list_read(struct path *root, char *path, enum ops op);
+static inline u8 *diglim_cred_actions(const struct cred *cred)
+{
+	return cred->security + diglim_lsm_blob_sizes.lbs_cred;
+}
+
+static inline u8 *diglim_cred_flags(const struct cred *cred)
+{
+	return diglim_cred_actions(cred) + 1;
+}
+
+static inline u8 *diglim_inode(const struct inode *inode)
+{
+	return inode->i_security + diglim_lsm_blob_sizes.lbs_inode;
+}
+
+static inline u8 *diglim_file(const struct file *file)
+{
+	return file->f_security + diglim_lsm_blob_sizes.lbs_file;
+}
 #endif /*__DIGLIM_INTERNAL_H*/
diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
index 467ff4f7c0ce..56c6f7ff2b3c 100644
--- a/security/integrity/diglim/fs.c
+++ b/security/integrity/diglim/fs.c
@@ -577,6 +577,9 @@ static ssize_t digest_list_write(struct file *file, const char __user *buf,
 	enum hash_algo algo;
 	u8 actions = 0;
 
+	if (diglim_lsm_enabled)
+		actions = *diglim_cred_actions(current_cred());
+
 	/* No partial writes. */
 	result = -EINVAL;
 	if (*ppos != 0)
diff --git a/security/integrity/diglim/hooks.c b/security/integrity/diglim/hooks.c
new file mode 100644
index 000000000000..f186ffbac628
--- /dev/null
+++ b/security/integrity/diglim/hooks.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Functions to evaluate the integrity of converted digest lists.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/cred.h>
+#include <linux/lsm_hooks.h>
+#include <linux/binfmts.h>
+#include <linux/xattr.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/sched/mm.h>
+#include <linux/ima.h>
+#include <uapi/linux/magic.h>
+
+#include "diglim.h"
+
+int diglim_lsm_enabled;
+
+/**
+ * diglim_file_read_with_ima - read the file with IMA
+ * @file: file descriptor of the file being accessed
+ *
+ * This function opens the file again so that it can pass the file descriptor to
+ * IMA for reading the file. It also marks the inode so that diglim_file_open()
+ * recognizes that the open was made by DIGLIM LSM and does not process it.
+ *
+ * NOTE: the second open might be not necessary, depending on the IMA policy;
+ *       however, since the second open is always performed with type
+ *       READING_DIGEST_LIST, it can be easily monitored by IMA with a rule with
+ *       func=DIGEST_LIST_CHECK
+ *
+ * Return: 0 on success, a negative value on error
+ */
+static int diglim_file_read_with_ima(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	u8 *inode_flags = diglim_inode(inode);
+	void *datap = NULL;
+	struct file *f;
+	int ret, flags;
+
+	/* Taken from ima_crypto.c. */
+	flags = file->f_flags & ~(O_WRONLY | O_APPEND | O_TRUNC | O_CREAT |
+				  O_NOCTTY | O_EXCL);
+	flags |= O_RDONLY;
+
+	/* Signal to diglim_file_open() to not evaluate the second open. */
+	*inode_flags |= FLAG_PARSER_FILE_ACCESS;
+	/* Open an additional file descriptor to use with ima_read_file(). */
+	f = dentry_open(&file->f_path, flags, file->f_cred);
+	*inode_flags &= ~FLAG_PARSER_FILE_ACCESS;
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+
+	/*
+	 * Pass the file descriptor to IMA with file type READING_DIGEST_LIST,
+	 * so that this operation can be more easily identified with an IMA rule
+	 * with func=DIGEST_LIST_CHECK.
+	 */
+	ret = kernel_read_file(f, 0, &datap, INT_MAX, NULL,
+			       READING_DIGEST_LIST);
+	if (ret >= 0)
+		vfree(datap);
+
+	fput(f);
+	return ret;
+}
+
+/**
+ * diglim_identify_parser - identify a digest list parser from the executable
+ * @cred: credentials of the child process
+ * @file: file descriptor of the child process executable
+ *
+ * This function first identifies a digest list parser from the executable, by
+ * searching the executable digest in the DIGLIM hash table. A parser is
+ * successfully identified if the digest is found in the hash table and if the
+ * type of the found digest is COMPACT_PARSER.
+ *
+ * If a parser has been successfully identified, this function also sets the
+ * actions performed by IMA on the executable in the process credentials. These
+ * initial actions will be AND-ed with the actions performed by IMA on each
+ * regular file opened by the parser. A missing action for a file will cause
+ * the corresponding action in the process credentials to be irreversibly
+ * cleared.
+ *
+ * Updating the actions in the process credentials in this way makes it clear
+ * whether or not the parser is suitable for use for a particular integrity goal
+ * (measurement or appraisal). If an action is set, it means that the executable
+ * and the process inputs have been evaluated for a particular goal, and from
+ * this it can be inferred that the output of the process is also correct.
+ *
+ * Return: 0 if a digest list parser has been successfully identified, a
+ *         negative value otherwise
+ */
+static int diglim_identify_parser(const struct cred *cred, struct file *file)
+{
+	struct integrity_iint_cache *iint;
+	struct inode *inode = file_inode(file);
+	u8 *parser_actions = diglim_cred_actions(cred);
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo = HASH_ALGO__LAST;
+	u16 modifiers = 0;
+	u8 digest_list_actions = 0, file_actions = 0;
+	int ret = -ENOENT;
+
+	/* Read the file with IMA. */
+	ret = diglim_file_read_with_ima(file);
+	if (ret < 0)
+		return ret;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return ret;
+
+	/*
+	 * Since executables are write-protected, information obtained from IMA
+	 * (digest and actions performed on the executable) are safe to use
+	 * without the risk of races with writers.
+	 */
+	mutex_lock(&iint->mutex);
+	if (!(iint->flags & IMA_COLLECTED)) {
+		mutex_unlock(&iint->mutex);
+		goto out;
+	}
+
+	/* Query the executable digest to determine if it is a parser. */
+	ret = diglim_digest_get_info(iint->ima_hash->digest,
+				     iint->ima_hash->algo, COMPACT_PARSER,
+				     &modifiers, &digest_list_actions);
+
+	mutex_unlock(&iint->mutex);
+
+	if (ret < 0)
+		goto out;
+
+	/* Obtain the flags from IMA operations on the executable. */
+	ret = diglim_ima_get_info(file, NULL, 0, NULL, digest, sizeof(digest),
+				  &algo, &file_actions);
+	if (!ret)
+		*parser_actions |= file_actions;
+
+	pr_debug("%s: task: %d(%s), parser initial actions: %d\n", __func__,
+		 current->pid, current->comm, *parser_actions);
+out:
+	return ret;
+}
+
+/**
+ * diglim_bprm_committing_creds - implement the bprm_committing_creds hook
+ * @bprm: linux_binprm structure of the file being executed
+ *
+ * This function implements the bprm_committing_creds hook, to identify a digest
+ * list parser from the digest of the executable. After a successful
+ * identification, the FLAG_PARSER_EXEC flag is set in the process credentials,
+ * so that the diglim_file_open() hook below knows that it should enforce the
+ * parser policy.
+ */
+static void diglim_bprm_committing_creds(struct linux_binprm *bprm)
+{
+	u8 *parser_flags = diglim_cred_flags(bprm->cred);
+	int ret;
+
+	/*
+	 * Try to identify the parsers if the parent directory is named diglim.
+	 */
+	if (strcmp(file_dentry(bprm->file)->d_parent->d_name.name, "diglim"))
+		return;
+
+	ret = diglim_identify_parser(bprm->cred, bprm->file);
+	if (ret < 0)
+		return;
+
+	*parser_flags |= FLAG_PARSER_EXEC;
+}
+
+/**
+ * diglim_file_open_check - check file access and if IMA eval is required
+ * @file: file descriptor of the file being accessed
+ *
+ * This function checks a file access and determines whether or not it is safe
+ * for the parser to access the file. Access (read) is considered safe if the
+ * file is in a trusted filesystem (procfs, securityfs), does not have content
+ * to be read or it has content that can be measured/appraised by IMA, and there
+ * are no concurrent writes.
+ *
+ * NOTE: access to ld.so.cache, although it can be allowed, is instead denied to
+ *       avoid an unknown measurement in the measurement list or appraisal
+ *       failure.
+ *
+ * This function also determines whether an IMA evaluation is required.
+ *
+ * The following table summarizes the policy enforced on the parsers.
+ *
+ *                                    Not parser               parser
+ * +-----------+--------------+-----------------------+-----------------------+
+ * | operation | file type    |                       |                       |
+ * +-----------+--------------+                       |                       |
+ * |           | ld.so.cache  | allow                 | allow                 |
+ * |           | reg          | allow [1]             | allow                 |
+ * |   write   | dir/link     | allow                 | allow                 |
+ * |           | procfs/secfs | allow                 | allow                 |
+ * |           | char/block/  | allow                 | allow                 |
+ * |           | socket/fifo  |                       |                       |
+ * +-----------+--------------+-----------------------+-----------------------+
+ * |           | ld.so.cache  | allow                 | deny                  |
+ * |           | reg          | allow                 | allow [2] + IMA eval  |
+ * |   read    | dir/link     | allow                 | allow                 |
+ * |           | procfs/secfs | allow                 | allow                 |
+ * |           | char/block/  | allow                 | deny                  |
+ * |           | socket/fifo  |                       |                       |
+ * +-----------+--------------+-----------------------+-----------------------+
+ *
+ * [1]: if not write-locked by the parser
+ * [2]: if there are no concurrent writes
+ *
+ * Return: 0 if access is allowed but IMA eval is not required, -EPERM if access
+ *         is denied and 1 if access is allowed and IMA eval is required.
+ */
+static int diglim_file_open_check(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	/* Skip non-read operations. */
+	if (!(file->f_mode & FMODE_READ))
+		return 0;
+
+	/* Deny access to ld.so.cache. */
+	if (!strcmp(file_dentry(file)->d_name.name, "ld.so.cache"))
+		return -EPERM;
+
+	/* Deny access to files that can have content but cannot be measured. */
+	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode) &&
+	    !S_ISDIR(inode->i_mode))
+		return -EPERM;
+
+	/* Allow access to dirs and symlinks. */
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	/* Allow access to files in procfs and securityfs. */
+	if (inode->i_sb->s_magic == PROC_SUPER_MAGIC ||
+	    inode->i_sb->s_magic == SECURITYFS_MAGIC)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * diglim_file_lock - write-lock the file before retrieving IMA actions
+ * @file: file descriptor of the file being locked
+ *
+ * This function write-locks the file being accessed in order to safely retrieve
+ * IMA actions and ensure that there are no concurrent writes, which would cause
+ * the retrieved actions to be outdated.
+ *
+ * Since IMA eventually resets the actions only when the file is closed, getting
+ * the exclusive write-lock ensures that the actions are up to date (for the
+ * exclusive write-lock to succeed there must be no pending writes, which means
+ * that IMA already updated the actions in ima_check_last_writer()).
+ *
+ * Return: 0 on success, -ETXTBSY if the file cannot be write-locked
+ */
+static int diglim_file_lock(struct file *file)
+{
+	u8 *file_flags = diglim_file(file);
+	int ret;
+
+	/* Write-lock the file until the parser finishes to use it. */
+	ret = deny_write_access(file);
+	if (ret < 0)
+		return ret;
+
+	/* Grab a reference to the inode to avoid free before unlocking it. */
+	igrab(file_inode(file));
+
+	/* Record deny_write_access() call in the file descriptor. */
+	*file_flags |= FLAG_PARSER_FILE_ACCESS_DENY;
+	return 0;
+}
+
+/**
+ * diglim_file_unlock - unlock the file locked by DIGLIM LSM
+ * @file: file descriptor of the file being unlocked
+ *
+ * This function first checks if the file was locked by DIGLIM LSM, and if yes,
+ * unlocks it.
+ */
+static void diglim_file_unlock(struct file *file)
+{
+	u8 *file_flags;
+
+	file_flags = diglim_file(file);
+
+	/* File not write-locked by DIGLIM LSM. */
+	if (!(*file_flags & FLAG_PARSER_FILE_ACCESS_DENY))
+		return;
+
+	/* Release write-lock. */
+	allow_write_access(file);
+
+	/* Clear flag. */
+	*file_flags &= ~FLAG_PARSER_FILE_ACCESS_DENY;
+
+	/* Release reference taken in diglim_file_lock(). */
+	iput(file_inode(file));
+}
+
+/**
+ * diglim_file_open - check file access and update process actions
+ * @file: file descriptor of the file being accessed
+ *
+ * This function checks the file being accessed by the parser and does an AND
+ * of the actions in the parser process credentials with the actions done by IMA
+ * on that file.
+ *
+ * The actions in the parser process credentials will be then copied to the
+ * converted digest lists uploaded by the parser.
+ *
+ * Return: 0 if access is allowed, a negative value if access is denied
+ */
+static int diglim_file_open(struct file *file)
+{
+	u8 file_actions = 0;
+	u8 *parser_flags = diglim_cred_flags(current_cred());
+	u8 *parser_actions = diglim_cred_actions(current_cred());
+	u8 initial_parser_actions = *parser_actions;
+	struct inode *inode = file_inode(file);
+	u8 *inode_flags = diglim_inode(inode);
+	int ret;
+
+	/* Skip processes that are not the parser. */
+	if (!(*parser_flags & FLAG_PARSER_EXEC))
+		return 0;
+
+	/* Skip calls due to dentry_open() in diglim_file_read_with_ima(). */
+	if (*inode_flags & FLAG_PARSER_FILE_ACCESS)
+		return 0;
+
+	/* Check file access. */
+	ret = diglim_file_open_check(file);
+	if (ret <= 0)
+		return ret;
+
+	/* Try to write-lock the file. */
+	ret = diglim_file_lock(file);
+	if (ret < 0)
+		return ret;
+
+	/* Read the file with IMA. */
+	ret = diglim_file_read_with_ima(file);
+	if (ret < 0) {
+		diglim_file_unlock(file);
+		return ret;
+	}
+
+	/* Retrieve the actions performed by IMA on the file. */
+	diglim_ima_get_info(file, NULL, 0, NULL, NULL, 0, NULL, &file_actions);
+
+	/* Do an AND of the parser process actions with the file actions. */
+	*parser_actions &= file_actions;
+
+	if (*parser_actions != initial_parser_actions)
+		pr_err("%s: task: %d(%s), cleared parser actions, file: %s, old flags: %d, new flags: %d\n",
+		       __func__, current->pid, current->comm,
+		       file_dentry(file)->d_name.name, initial_parser_actions,
+		       *parser_actions);
+
+	return 0;
+}
+
+/**
+ * diglim_file_free - unlock files accessed by the parser
+ * @file: file descriptor of the file being monitored
+ *
+ * This function unlocks files accessed by the parser.
+ */
+void diglim_file_free(struct file *file)
+{
+	diglim_file_unlock(file);
+}
+
+/**
+ * diglim_ptrace_access_check - deny ptraces on the parser process
+ * @child: task being ptraced
+ * @mode: ptrace mode
+ *
+ * This function denies ptraces on the parser process.
+ *
+ * Return: 0 if the ptrace is not done on the parser process, -EACCES otherwise
+ */
+static int diglim_ptrace_access_check(struct task_struct *child,
+				       unsigned int mode)
+{
+	const struct cred *cred = get_task_cred(child);
+	u8 *flags = diglim_cred_flags(cred);
+
+	/* Deny ptraces to the parser. */
+	if (*flags & FLAG_PARSER_EXEC)
+		return -EACCES;
+
+	return 0;
+}
+
+static struct security_hook_list diglim_lsm_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_committing_creds, diglim_bprm_committing_creds),
+	LSM_HOOK_INIT(file_open, diglim_file_open),
+	LSM_HOOK_INIT(file_free_security, diglim_file_free),
+	LSM_HOOK_INIT(ptrace_access_check, diglim_ptrace_access_check),
+};
+
+static int __init diglim_lsm_init(void)
+{
+	diglim_lsm_enabled = 1;
+	security_add_hooks(diglim_lsm_hooks, ARRAY_SIZE(diglim_lsm_hooks),
+			   "diglim");
+	return 0;
+}
+
+struct lsm_blob_sizes diglim_lsm_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = 2 * sizeof(u8),
+	.lbs_inode = sizeof(u8),
+	.lbs_file = sizeof(u8),
+};
+
+DEFINE_LSM(diglim) = {
+	.name = "diglim",
+	.init = diglim_lsm_init,
+	.blobs = &diglim_lsm_blob_sizes,
+};
-- 
2.25.1

