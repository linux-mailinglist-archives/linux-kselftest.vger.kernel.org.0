Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518203B47C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFYRAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:00:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3313 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFYRAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:00:20 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNGW44gnz6G8kB;
        Sat, 26 Jun 2021 00:47:47 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:57:56 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 06/12] digest_lists: Parser
Date:   Fri, 25 Jun 2021 18:56:08 +0200
Message-ID: <20210625165614.2284243-7-roberto.sassu@huawei.com>
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

This patch introduces the necessary functions to parse a digest list and
to execute the requested operation.

The main function is digest_list_parse(), which coordinates the various
steps required to add or delete a digest list, and has the logic to roll
back when one of the steps fails.

A more detailed description about the steps can be found in
Documentation/security/digest_lists.rst

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst       |  33 +++
 MAINTAINERS                                   |   1 +
 security/integrity/digest_lists/Makefile      |   2 +-
 .../integrity/digest_lists/digest_lists.h     |   3 +
 security/integrity/digest_lists/parser.c      | 270 ++++++++++++++++++
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_lists/parser.c

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 8f1d15a37dbd..04ea4b3790e0 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -611,3 +611,36 @@ hash table for the ``COMPACT_DIGEST_LIST`` type. Deletion can be done only
 if the digest list is found. ``digest_list_del()`` then deletes the
 ``digest_list_item``, the special ``digest_list_item_ref`` and the
 ``digest_item``.
+
+
+Parser
+------
+
+This section introduces the necessary functions to parse a digest list and
+to execute the requested operation.
+
+The main function is ``digest_list_parse()``, which coordinates the
+various steps required to add or delete a digest list, and has the logic
+to roll back when one of the steps fails.
+
+#. Calls ``digest_list_validate()`` to validate the passed buffer
+   containing the digest list to ensure that the format is correct.
+
+#. Calls ``get_digest_list()`` to create a new ``digest_list_item`` for the
+   add operation, or to retrieve the existing one for the delete operation.
+   ``get_digest_list()`` refuses to add digest lists that were previously
+   added and to delete digest lists that weren't previously added. Also,
+   ``get_digest_list()`` refuses to delete digest lists that are not
+   processed in the same way as when they were added (it would guarantee
+   that also deletion is notified to remote verifiers).
+
+#. Calls ``_digest_list_parse()`` which takes the created/retrieved
+   ``digest_list_item`` and adds or delete the digests included in the
+   digest list.
+
+#. If an error occurred, performs a rollback to the previous state, by
+   calling ``_digest_list_parse()`` with the opposite operation and the
+   buffer size at the time the error occurred.
+
+#. ``digest_list_parse()`` deletes the ``digest_list_item`` on unsuccessful
+   add or successful delete.
diff --git a/MAINTAINERS b/MAINTAINERS
index a9eb52e65b12..31d280acf5fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8390,6 +8390,7 @@ F:	Documentation/security/digest_lists.rst
 F:	include/linux/digest_list.h
 F:	security/integrity/digest_lists/digest_list.h
 F:	security/integrity/digest_lists/methods.c
+F:	security/integrity/digest_lists/parser.c
 F:	uapi/linux/digest_lists.h
 
 HUAWEI ETHERNET DRIVER
diff --git a/security/integrity/digest_lists/Makefile b/security/integrity/digest_lists/Makefile
index 0ba66ab2e260..86cca5bb7824 100644
--- a/security/integrity/digest_lists/Makefile
+++ b/security/integrity/digest_lists/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_DIGEST_LISTS) += digest_lists.o
 
-digest_lists-y := methods.o
+digest_lists-y := methods.o parser.o
diff --git a/security/integrity/digest_lists/digest_lists.h b/security/integrity/digest_lists/digest_lists.h
index aadce9ca8f5f..442ab116a6a5 100644
--- a/security/integrity/digest_lists/digest_lists.h
+++ b/security/integrity/digest_lists/digest_lists.h
@@ -148,4 +148,7 @@ struct digest_item *digest_list_add(u8 *digest, enum hash_algo algo,
 				    const char *label);
 struct digest_item *digest_list_del(u8 *digest, enum hash_algo algo, u8 actions,
 				    struct digest_list_item *digest_list);
+
+int digest_list_parse(loff_t size, void *buf, enum ops op, u8 actions,
+		      u8 *digest, enum hash_algo algo, const char *label);
 #endif /*__DIGEST_LISTS_INTERNAL_H*/
diff --git a/security/integrity/digest_lists/parser.c b/security/integrity/digest_lists/parser.c
new file mode 100644
index 000000000000..7ed6765a9dc4
--- /dev/null
+++ b/security/integrity/digest_lists/parser.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: parser.c
+ *      Functions to parse digest lists.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+
+#include "digest_lists.h"
+#include "../integrity.h"
+
+/**
+ * digest_list_validate - validate format of digest list
+ * @size: buffer size
+ * @buf: buffer containing the digest list
+ *
+ * This function validates the format of the passed digest list.
+ *
+ * Returns 0 if the digest list was successfully validated, -EINVAL otherwise.
+ */
+static int digest_list_validate(loff_t size, void *buf)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	struct compact_list_hdr *hdr;
+	size_t digest_len;
+
+	while (bufp < bufendp) {
+		if (bufp + sizeof(*hdr) > bufendp) {
+			pr_err("invalid data\n");
+			return -EINVAL;
+		}
+
+		hdr = bufp;
+
+		if (hdr->version != 1) {
+			pr_err("unsupported version\n");
+			return -EINVAL;
+		}
+
+		hdr->type = le16_to_cpu(hdr->type);
+		hdr->modifiers = le16_to_cpu(hdr->modifiers);
+		hdr->algo = le16_to_cpu(hdr->algo);
+		hdr->count = le32_to_cpu(hdr->count);
+		hdr->datalen = le32_to_cpu(hdr->datalen);
+
+		if (hdr->algo >= HASH_ALGO__LAST) {
+			pr_err("invalid hash algorithm\n");
+			return -EINVAL;
+		}
+
+		digest_len = hash_digest_size[hdr->algo];
+
+		if (hdr->type >= COMPACT__LAST ||
+		    hdr->type == COMPACT_DIGEST_LIST) {
+			pr_err("invalid type %d\n", hdr->type);
+			return -EINVAL;
+		}
+
+		bufp += sizeof(*hdr);
+
+		if (hdr->datalen != hdr->count * digest_len ||
+		    bufp + hdr->datalen > bufendp) {
+			pr_err("invalid data\n");
+			return -EINVAL;
+		}
+
+		bufp += hdr->count * digest_len;
+	}
+
+	return 0;
+}
+
+/**
+ * _digest_list_parse - parse digest list and add/delete digests
+ * @size: buffer size
+ * @buf: buffer containing the digest list
+ * @op: operation to be performed
+ * @digest_list: digest list digests being added/deleted belong to
+ *
+ * This function parses the digest list and adds or delete the digests in the
+ * found digest blocks.
+ *
+ * Returns the buffer size if all digests were successfully added or deleted,
+ * the size of the already parsed buffer on error.
+ */
+static int _digest_list_parse(loff_t size, void *buf, enum ops op,
+			      struct digest_list_item *digest_list)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	struct compact_list_hdr *hdr;
+	struct digest_item *d;
+	size_t digest_len;
+	int i;
+
+	while (bufp < bufendp) {
+		if (bufp + sizeof(*hdr) > bufendp)
+			break;
+
+		hdr = bufp;
+		bufp += sizeof(*hdr);
+
+		digest_len = hash_digest_size[hdr->algo];
+
+		for (i = 0; i < hdr->count && bufp + digest_len <= bufendp;
+		     i++, bufp += digest_len) {
+			switch (op) {
+			case DIGEST_LIST_ADD:
+				d = digest_add(bufp, hdr->algo, hdr->type,
+					       digest_list, bufp - buf,
+					       (void *)hdr - buf);
+				break;
+			case DIGEST_LIST_DEL:
+				d = digest_del(bufp, hdr->algo, hdr->type,
+					       digest_list, bufp - buf,
+					       (void *)hdr - buf);
+				break;
+			default:
+				break;
+			}
+
+			if (IS_ERR(d)) {
+				pr_err("failed to %s a digest from %s\n",
+				       (op == DIGEST_LIST_ADD) ?
+				       "add" : "delete", digest_list->label);
+				goto out;
+			}
+		}
+	}
+out:
+	return bufp - buf;
+}
+
+/**
+ * get_digest_list - get the digest list extracted digests will be associated to
+ * @size: buffer size
+ * @buf: buffer containing the digest list
+ * @op: digest list operation
+ * @actions: actions performed on the digest list being processed
+ * @digest: digest of the digest list
+ * @algo: digest algorithm
+ * @label: label to identify the digest list (e.g. file name)
+ *
+ * This function retrieves the digest list item for the passed digest and
+ * algorithm. If it is not found at addition time, this function creates a new
+ * one.
+ *
+ * This function also ensures that the actions done at the time of deletion
+ * match the actions done at the time of addition (it would guarantee that also
+ * deletion is notified to remote verifiers).
+ *
+ * Returns the retrieved/created digest list item on success, an error pointer
+ * otherwise.
+ */
+static struct digest_list_item *get_digest_list(loff_t size, void *buf,
+						enum ops op, u8 actions,
+						u8 *digest, enum hash_algo algo,
+						const char *label)
+{
+	struct digest_item *d;
+	struct digest_list_item *digest_list;
+	int digest_len = hash_digest_size[algo];
+
+	switch (op) {
+	case DIGEST_LIST_ADD:
+		/* Add digest list to be associated to each digest. */
+		d = digest_list_add(digest, algo, size, buf, actions, label);
+		if (IS_ERR(d))
+			return (void *)d;
+
+		digest_list = d->refs[0].digest_list;
+		break;
+	case DIGEST_LIST_DEL:
+		/* Lookup digest list to delete the references. */
+		d = digest_lookup(digest, algo, COMPACT_DIGEST_LIST, NULL,
+				  NULL);
+		if (!d) {
+			print_hex_dump(KERN_ERR,
+				       "digest list digest not found: ",
+				       DUMP_PREFIX_NONE, digest_len, 1, digest,
+				       digest_len, true);
+			return ERR_PTR(-ENOENT);
+		}
+
+		digest_list = d->refs[0].digest_list;
+
+		/* Reject deletion if actions on delete differ from add. */
+		if (digest_list->actions != actions) {
+			pr_err("actions mismatch, add: %d, del: %d\n",
+			       digest_list->actions, actions);
+			return ERR_PTR(-EPERM);
+		}
+
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return digest_list;
+}
+
+/**
+ * digest_list_parse - parse a digest list
+ * @size: buffer size
+ * @buf: buffer containing the digest list
+ * @op: digest list operation
+ * @actions: actions performed on the digest list being processed
+ * @digest: digest of the digest list
+ * @algo: digest algorithm
+ * @label: label to identify the digest list (e.g. file name)
+ *
+ * This function parses the passed digest list and executed the requested
+ * operation. If the operation cannot be successfully executed, this function
+ * performs a rollback to the previous state.
+ *
+ * Returns the buffer size on success, a negative value otherwise.
+ */
+int digest_list_parse(loff_t size, void *buf, enum ops op, u8 actions,
+		      u8 *digest, enum hash_algo algo, const char *label)
+{
+	struct digest_item *d;
+	struct digest_list_item *digest_list;
+	enum ops rollback_op = (op == DIGEST_LIST_ADD) ?
+			       DIGEST_LIST_DEL : DIGEST_LIST_ADD;
+	int ret, rollback_size;
+
+	ret = digest_list_validate(size, buf);
+	if (ret < 0)
+		return ret;
+
+	digest_list = get_digest_list(size, buf, op, actions, digest, algo,
+				      label);
+	if (IS_ERR(digest_list))
+		return PTR_ERR(digest_list);
+
+	ret = _digest_list_parse(size, buf, op, digest_list);
+	if (ret < 0)
+		goto out;
+
+	if (ret != size) {
+		rollback_size = ret;
+
+		ret = _digest_list_parse(rollback_size, buf, rollback_op,
+					 digest_list);
+		if (ret != rollback_size)
+			pr_err("rollback failed\n");
+
+		ret = -EINVAL;
+	}
+out:
+	/* Delete digest list on unsuccessful add or successful delete. */
+	if ((op == DIGEST_LIST_ADD && ret < 0) ||
+	    (op == DIGEST_LIST_DEL && ret == size)) {
+		d = digest_list_del(digest, algo, actions, digest_list);
+		if (IS_ERR(d))
+			return PTR_ERR(d);
+	}
+
+	return ret;
+}
-- 
2.25.1

