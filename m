Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5633B47C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFYRAW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:00:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3312 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFYRAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:00:20 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNKY4mcGz6G8HX;
        Sat, 26 Jun 2021 00:50:25 +0800 (CST)
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
Subject: [RFC][PATCH 05/12] digest_lists: Methods
Date:   Fri, 25 Jun 2021 18:56:07 +0200
Message-ID: <20210625165614.2284243-6-roberto.sassu@huawei.com>
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

This patch introduces the methods requires to manage the three objects
defined.

- digest_item methods:
  - digest_add()
  - digest_del()
  - digest_lookup()
  - digest_get_info()

- digest_list_item_ref methods:
  - digest_list_ref_add()
  - digest_list_ref_del()

- digest_list_item methods:
  - digest_list_add()
  - digest_list_del()

More information about these functions can be found in
Documentation/security/digest_lists.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst       | 110 ++++
 MAINTAINERS                                   |   2 +
 include/linux/digest_lists.h                  |  24 +
 security/integrity/Kconfig                    |   1 +
 security/integrity/Makefile                   |   1 +
 security/integrity/digest_lists/Kconfig       |  11 +
 security/integrity/digest_lists/Makefile      |   8 +
 .../integrity/digest_lists/digest_lists.h     |  34 ++
 security/integrity/digest_lists/methods.c     | 548 ++++++++++++++++++
 9 files changed, 739 insertions(+)
 create mode 100644 include/linux/digest_lists.h
 create mode 100644 security/integrity/digest_lists/Kconfig
 create mode 100644 security/integrity/digest_lists/Makefile
 create mode 100644 security/integrity/digest_lists/methods.c

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 1031667324c9..8f1d15a37dbd 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -501,3 +501,113 @@ Similarly:
 the digest can be obtained by summing the address of the digest list buffer
 with ``digest_offset`` (except for the digest lists, where the digest is
 stored in the ``digest`` field of the ``digest_list_item`` structure).
+
+
+Methods
+-------
+
+This section introduces the methods requires to manage the three objects
+defined.
+
+
+``digest_item`` Methods
+~~~~~~~~~~~~~~~~~~~~~~~
+
+
+``digest_add()``
+................
+
+``digest_add()`` first checks in the hash table for the passed type if a
+``digest_item`` for the same digest already exists. If not, it creates a
+new one. Then, ``digest_add()`` calls ``digest_list_ref_add()`` to add a
+new reference of the digest list being added to the found or new
+``digest_item``.
+
+
+``digest_del()``
+................
+
+``digest_del()`` also searches the ``digest_item`` in the hash table. It
+should be always found, as digest lists can be deleted only if they were
+added before. Then, ``digest_del()`` calls ``digest_list_ref_del()`` to
+delete a reference of the digest list being deleted from the found
+``digest_item``.
+
+
+``digest_lookup()``
+...................
+
+``digest_lookup()`` searches the passed digest in the hash table. Then, it
+returns immediately a ``digest_item`` (or NULL if the digest is not found)
+if the modifiers and actions information are not requested by the caller,
+or iterates over all the valid references of the digest and calculates the
+OR for both of them. Iteration in the array of references ends when the
+digest list pointer in a reference is set to NULL. Access to the ``refs``
+array is protected by RCU to avoid access to digest lists being added or
+deleted (update is serialized by the securityfs interfaces).
+
+``digest_lookup()`` is not exposed to the rest of the kernel, because
+access to the returned ``digest_item`` outside RCU would be illegal.
+
+
+``digest_get_info()``
+.....................
+
+``digest_get_info()`` is the public version of ``digest_lookup()``, which
+does not return a ``digest_item`` but just the resulting modifiers and
+actions from the OR of the modifiers and actions from the referenced
+digest lists.
+
+
+``digest_list_item_ref`` Methods
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+
+``digest_list_ref_add()``
+.........................
+
+``digest_list_ref_add()`` adds a new reference at the end of the ``refs``
+array (also keeps a terminator as the last element). It does not search for
+duplicates, as a duplicate reference simply means that the digest appears
+multiple times in the digest list. ``digest_list_ref_add()`` does not add
+the new element in place, but first creates a copy of the current ``refs``
+array and uses RCU to replace it with the new one.
+
+
+``digest_list_ref_del()``
+.........................
+
+``digest_list_ref_del()`` first searches in the ``refs`` array a reference
+to a given digest list. Then, it invalidates the found reference so that it
+is skipped by the reader. Afterwards, it tries to allocate a smaller
+``refs`` array (with enough slots to store the valid references, except the
+one being deleted). If memory allocation succeeds,
+``digest_list_ref_del()`` copies the valid references to the copy of
+``refs`` and uses RCU to replace the original ``refs``. Otherwise, it keeps
+the original ``refs`` with the invalidated reference.
+
+
+``digest_list_item`` Methods
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+
+``digest_list_add()``
+.....................
+
+``digest_list_add()`` first searches the digest of the digest list in the
+hash table for the ``COMPACT_DIGEST_LIST`` type. Addition can be done if
+the digest list is not found (it is pointless to load the same digest list
+again). ``digest_list_add()`` then creates a new ``digest_item``,
+representing the digest of the digest list, a special
+``digest_list_item_ref`` with ``digest_offset`` and ``hdr_offset`` set to
+zero, and a new ``digest_list_item``.
+
+
+``digest_list_del()``
+.....................
+
+``digest_list_del()`` also searches the digest of the digest list in the
+hash table for the ``COMPACT_DIGEST_LIST`` type. Deletion can be done only
+if the digest list is found. ``digest_list_del()`` then deletes the
+``digest_list_item``, the special ``digest_list_item_ref`` and the
+``digest_item``.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7e9f16eee8..a9eb52e65b12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8387,7 +8387,9 @@ L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	Documentation/security/digest_lists.rst
+F:	include/linux/digest_list.h
 F:	security/integrity/digest_lists/digest_list.h
+F:	security/integrity/digest_lists/methods.c
 F:	uapi/linux/digest_lists.h
 
 HUAWEI ETHERNET DRIVER
diff --git a/include/linux/digest_lists.h b/include/linux/digest_lists.h
new file mode 100644
index 000000000000..f59a2bc5224f
--- /dev/null
+++ b/include/linux/digest_lists.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: digest_lists.h
+ *      Exported functions for digest list management.
+ */
+
+#ifndef __DIGEST_LISTS_H
+#define __DIGEST_LISTS_H
+
+#include <crypto/hash_info.h>
+#include <uapi/linux/digest_lists.h>
+
+int digest_get_info(u8 *digest, enum hash_algo algo, enum compact_types type,
+		    u16 *modifiers, u8 *actions);
+#endif
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..a6ae57a7453a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -98,5 +98,6 @@ config INTEGRITY_AUDIT
 
 source "security/integrity/ima/Kconfig"
 source "security/integrity/evm/Kconfig"
+source "security/integrity/digest_lists/Kconfig"
 
 endif   # if INTEGRITY
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..a1e4acb4d2ae 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -19,3 +19,4 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
                                      platform_certs/keyring_handler.o
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
+obj-$(CONFIG_DIGEST_LISTS)		+= digest_lists/
diff --git a/security/integrity/digest_lists/Kconfig b/security/integrity/digest_lists/Kconfig
new file mode 100644
index 000000000000..2d8290bd2d4d
--- /dev/null
+++ b/security/integrity/digest_lists/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Huawei Digest Lists
+#
+config DIGEST_LISTS
+	bool "Digest Lists"
+	select SECURITYFS
+	select CRYPTO
+	select CRYPTO_HASH_INFO
+	help
+	  Huawei Digest Lists provides reference values for file content and
+	  metadata, that can be used for measurement and appraisal with IMA.
diff --git a/security/integrity/digest_lists/Makefile b/security/integrity/digest_lists/Makefile
new file mode 100644
index 000000000000..0ba66ab2e260
--- /dev/null
+++ b/security/integrity/digest_lists/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for building Huawei Digest Lists.
+#
+
+obj-$(CONFIG_DIGEST_LISTS) += digest_lists.o
+
+digest_lists-y := methods.o
diff --git a/security/integrity/digest_lists/digest_lists.h b/security/integrity/digest_lists/digest_lists.h
index 81b6cb10f4f1..aadce9ca8f5f 100644
--- a/security/integrity/digest_lists/digest_lists.h
+++ b/security/integrity/digest_lists/digest_lists.h
@@ -64,6 +64,8 @@ static inline unsigned int hash_key(u8 *digest)
 	return (digest[0] | digest[1] << 8) % MEASURE_HTABLE_SIZE;
 }
 
+extern struct h_table htable[COMPACT__LAST];
+
 static inline struct compact_list_hdr *get_hdr(
 					struct digest_list_item *digest_list,
 					loff_t hdr_offset)
@@ -114,4 +116,36 @@ static inline u8 *get_digest_ref(struct digest_list_item_ref *ref)
 
 	return ref->digest_list->buf + ref->digest_offset;
 }
+
+static inline bool digest_list_ref_invalidated(struct digest_list_item_ref *ref)
+{
+	return (ref->digest_list == ZERO_SIZE_PTR);
+}
+
+static inline void digest_list_ref_invalidate(struct digest_list_item_ref *ref)
+{
+	ref->digest_list = ZERO_SIZE_PTR;
+}
+
+static inline bool digest_list_ref_is_last(struct digest_list_item_ref *ref)
+{
+	return (ref->digest_list == NULL);
+}
+
+struct digest_item *digest_lookup(u8 *digest, enum hash_algo algo,
+				  enum compact_types type, u16 *modifiers,
+				  u8 *actions);
+struct digest_item *digest_add(u8 *digest, enum hash_algo algo,
+			       enum compact_types type,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset);
+struct digest_item *digest_del(u8 *digest, enum hash_algo algo,
+			       enum compact_types type,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset);
+struct digest_item *digest_list_add(u8 *digest, enum hash_algo algo,
+				    loff_t size, u8 *buf, u8 actions,
+				    const char *label);
+struct digest_item *digest_list_del(u8 *digest, enum hash_algo algo, u8 actions,
+				    struct digest_list_item *digest_list);
 #endif /*__DIGEST_LISTS_INTERNAL_H*/
diff --git a/security/integrity/digest_lists/methods.c b/security/integrity/digest_lists/methods.c
new file mode 100644
index 000000000000..c4655fb3897a
--- /dev/null
+++ b/security/integrity/digest_lists/methods.c
@@ -0,0 +1,548 @@
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
+ * File: methods.c
+ *      Functions to manage digest lists.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/fault-inject.h>
+#include <linux/digest_lists.h>
+
+#include "digest_lists.h"
+#include "../integrity.h"
+
+/* Define a hash table for each digest type. */
+struct h_table htable[COMPACT__LAST] = {{
+	.len = ATOMIC_LONG_INIT(0),
+	.queue[0 ... MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
+}};
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+static DECLARE_FAULT_ATTR(fail_digest_lists);
+
+static int __init fail_digest_lists_debugfs(void)
+{
+	struct dentry *dir = fault_create_debugfs_attr("fail_digest_lists",
+						NULL, &fail_digest_lists);
+
+	return PTR_ERR_OR_ZERO(dir);
+}
+
+static inline bool should_fail_digest_lists(void)
+{
+	return should_fail(&fail_digest_lists, 1);
+}
+
+late_initcall(fail_digest_lists_debugfs);
+#else
+static inline bool should_fail_digest_lists(void)
+{
+	return false;
+}
+#endif
+
+/**
+ * digest_lookup - lookup digest and return associated modifiers and actions
+ * @digest: digest to lookup
+ * @algo: digest algorithm
+ * @type: type of digest to lookup (e.g. file, metadata)
+ * @modifiers: modifiers (attributes) associated to the found digest
+ * @actions: actions performed by IMA on the digest list containing the digest
+ *
+ * This function searches the given digest in the hash table depending on the
+ * passed type and sets the modifiers and actions associated to the digest, if
+ * the pointers are not NULL.
+ *
+ * This function is not intended for external use, as the returned digest item
+ * could be freed at any time after it has been returned. digest_get_info()
+ * should be used instead by external callers, as it only returns the modifiers
+ * and the actions associated to the digest at the time the digest is searched.
+ *
+ * RCU protects both the hash table and the digest_lists array, which contains
+ * references to the digest lists containing the found digest.
+ *
+ * Returns a digest_item structure if the digest is found, NULL otherwise.
+ */
+struct digest_item *digest_lookup(u8 *digest, enum hash_algo algo,
+				  enum compact_types type, u16 *modifiers,
+				  u8 *actions)
+{
+	struct digest_item *d = NULL;
+	struct digest_list_item_ref *ref;
+	int digest_len = hash_digest_size[algo];
+	unsigned int key = hash_key(digest);
+	bool found = false;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(d, &htable[type].queue[key], hnext) {
+		ref = rcu_dereference(d->refs);
+
+		for (; ref != NULL && !digest_list_ref_is_last(ref); ref++) {
+			if (digest_list_ref_invalidated(ref))
+				continue;
+
+			if (get_algo_ref(ref) != algo ||
+			    memcmp(get_digest_ref(ref), digest, digest_len))
+				break;
+
+			found = true;
+
+			/* There is no need to scan all digest list refs. */
+			if (!modifiers || !actions)
+				break;
+
+			/*
+			 * The resulting modifiers and actions are the OR of the
+			 * modifiers and actions for each digest list.
+			 */
+			*modifiers |= get_hdr_ref(ref)->modifiers;
+			*actions |= ref->digest_list->actions;
+		}
+
+		if (found)
+			break;
+	}
+
+	rcu_read_unlock();
+	return d;
+}
+
+/**
+ * digest_get_info - lookup digest and return associated modifiers and actions
+ * @digest: digest to lookup
+ * @algo: digest algorithm
+ * @type: type of digest to lookup (e.g. file, metadata)
+ * @modifiers: modifiers (attributes) associated to the found digest
+ * @actions: actions performed by IMA on the digest list containing the digest
+ *
+ * This function searches the given digest in the hash table depending on the
+ * passed type and sets the modifiers and actions associated to the digest, if
+ * the pointers are not NULL.
+ *
+ * This function is safe for external use, as it does not return pointers of
+ * objects that can be freed without the caller notices it.
+ *
+ * Returns 0 if the digest is found, -ENOENT otherwise.
+ */
+int digest_get_info(u8 *digest, enum hash_algo algo, enum compact_types type,
+		    u16 *modifiers, u8 *actions)
+{
+	struct digest_item *d;
+
+	d = digest_lookup(digest, algo, type, modifiers, actions);
+	if (!d)
+		return -ENOENT;
+
+	return 0;
+}
+
+/**
+ * digest_list_ref_add - add reference to a digest list
+ * @d: digest a new reference is added to
+ * @digest_list: digest list whose reference is being added
+ * @digest_offset: offset of the digest in the buffer of the digest list
+ * @hdr_offset: offset of the header within the digest list the digest refers to
+ *
+ * This function adds a new reference to an existing digest list for a given
+ * digest. The reference is described by the digest_list_item_ref structure and
+ * consists of a pointer of the digest list, the offset of the digest to the
+ * beginning of the digest list buffer and the offset of the header the digest
+ * refers to (each digest list might be composed of several digest blocks, each
+ * prefixed by a header describing the attributes of those digests).
+ *
+ * This function carefully updates the array of digest list references by
+ * creating a copy of the existing references, adding the new one and using
+ * RCU to replace the old array. An additional empty reference is allocated so
+ * that the reader can stop the iteration.
+ *
+ * Returns 0 if a new digest list reference was successfully added, a negative
+ * value otherwise.
+ */
+static int digest_list_ref_add(struct digest_item *d,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset)
+{
+	struct digest_list_item_ref *new_refs = NULL, *old_refs = d->refs, *ref;
+	u8 *digest = get_digest(digest_list, digest_offset, hdr_offset);
+	enum hash_algo algo = get_algo(digest_list, digest_offset, hdr_offset);
+	int digest_len = hash_digest_size[algo];
+	int all_refs;
+
+	for (ref = old_refs, all_refs = 0;
+	     ref != NULL && !digest_list_ref_is_last(ref); ref++, all_refs++)
+		;
+
+	/*
+	 * Allocate a new array of references with + 1 element for the new
+	 * reference and + 1 element for the terminator.
+	 */
+	if (!should_fail_digest_lists())
+		new_refs = kmalloc_array(all_refs + 2, sizeof(*new_refs),
+					 GFP_KERNEL);
+	if (!new_refs) {
+		print_hex_dump(KERN_ERR, "digest list ref allocation failed: ",
+			       DUMP_PREFIX_NONE, digest_len, 1, digest,
+			       digest_len, true);
+		return -ENOMEM;
+	}
+
+	memcpy(new_refs, old_refs, all_refs * sizeof(*new_refs));
+
+	/* Set the new reference. */
+	new_refs[all_refs].digest_list = digest_list;
+	new_refs[all_refs].digest_offset = digest_offset;
+	new_refs[all_refs].hdr_offset = hdr_offset;
+	/* Set the terminator. */
+	new_refs[all_refs + 1].digest_list = NULL;
+
+	/* Replace the old digest list references with the new ones with RCU. */
+	rcu_assign_pointer(d->refs, new_refs);
+	kfree_rcu(old_refs);
+
+	print_hex_dump_debug("add digest list ref: ", DUMP_PREFIX_NONE,
+			     digest_len, 1, digest, digest_len, true);
+	return 0;
+}
+
+/**
+ * digest_list_ref_del - del reference to a digest list
+ * @d: digest a reference is deleted from
+ * @digest_list: digest list whose reference is being deleted
+ * @digest_offset: offset of the digest in the buffer of the digest list
+ * @hdr_offset: offset of the header within the digest list the digest refers to
+ *
+ * This function searches the reference to an already loaded digest list in the
+ * array of references stored for each digest item. If the reference is found
+ * (if not, it is a bug), the function allocates a smaller array from which the
+ * found reference is removed and uses RCU to replace the existing array.
+ *
+ * Returns 0 if a reference of the passed digest list was successfully removed,
+ * a negative value otherwise.
+ */
+static int digest_list_ref_del(struct digest_item *d,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset)
+{
+	struct digest_list_item_ref *new_refs = NULL, *old_refs = d->refs;
+	struct digest_list_item_ref *ref, *found_ref = NULL;
+	u8 *digest = get_digest(digest_list, digest_offset, hdr_offset);
+	enum hash_algo algo = get_algo(digest_list, digest_offset, hdr_offset);
+	int digest_len = hash_digest_size[algo];
+	int i, valid_refs = 0;
+
+	/* Search for a digest list reference. */
+	for (ref = d->refs, valid_refs = 0; !digest_list_ref_is_last(ref);
+	     ref++) {
+		if (digest_list_ref_invalidated(ref))
+			continue;
+
+		valid_refs++;
+
+		if (!found_ref && ref->digest_list == digest_list)
+			found_ref = ref;
+	}
+
+	if (!found_ref) {
+		print_hex_dump(KERN_ERR, "digest list ref not found: ",
+			       DUMP_PREFIX_NONE, digest_len, 1, digest,
+			       digest_len, true);
+		return 0;
+	}
+
+	digest_list_ref_invalidate(found_ref);
+
+	if (valid_refs > 1) {
+		/* Allocate a smaller array of digest list references. */
+		if (!should_fail_digest_lists())
+			new_refs = kcalloc(valid_refs, sizeof(*new_refs),
+					   GFP_KERNEL);
+		if (new_refs) {
+			for (ref = d->refs, i = 0;
+			     !digest_list_ref_is_last(ref); ref++) {
+				/* Skip the reference to delete. */
+				if (ref == found_ref)
+					continue;
+
+				/* Skip invalid references. */
+				if (digest_list_ref_invalidated(ref))
+					continue;
+
+				/* Copy the remaining references. */
+				memcpy(&new_refs[i++], ref, sizeof(*new_refs));
+			}
+		} else {
+			new_refs = old_refs;
+		}
+	}
+
+	/* Replace the array of digest list references with RCU. */
+	rcu_assign_pointer(d->refs, new_refs);
+	if (old_refs != new_refs)
+		kfree_rcu(old_refs);
+
+	print_hex_dump_debug("del digest list ref: ", DUMP_PREFIX_NONE,
+			     digest_len, 1, digest, digest_len, true);
+	return 0;
+}
+
+/**
+ * digest_add - add a new digest
+ * @digest: digest in binary form
+ * @algo: digest algorithm
+ * @type: digest type
+ * @digest_list: digest list the new digest belongs to
+ * @digest_offset: offset of the digest in the buffer of the digest list
+ * @hdr_offset: offset of the header within the digest list the digest refers to
+ *
+ * This function first searches if the digest is already in the hash table for
+ * the given type. The digest is searched by comparing the passed digest and
+ * algorithm with the digest obtained from the first valid digest list reference
+ * (buffer + digest offset).
+ *
+ * If the digest exists, only a new reference is added (there might be multiple
+ * references to the same digest list).
+ *
+ * If the digest is not found, a new digest item is allocated and a reference to
+ * the passed digest list is added to that item. The digest item is finally
+ * added to the hash table for the given type.
+ *
+ * Returns a new or the found digest item on success, an error pointer
+ * otherwise.
+ */
+struct digest_item *digest_add(u8 *digest, enum hash_algo algo,
+			       enum compact_types type,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset)
+{
+	int digest_len = hash_digest_size[algo];
+	struct digest_item *d;
+	int ret;
+
+	/* Search the digest. */
+	d = digest_lookup(digest, algo, type, NULL, NULL);
+	if (d) {
+		/*
+		 * Add a new digest list reference to the existing digest item.
+		 */
+		ret = digest_list_ref_add(d, digest_list, digest_offset,
+					  hdr_offset);
+		if (ret < 0)
+			return ERR_PTR(ret);
+
+		print_hex_dump_debug("digest add duplicate: ", DUMP_PREFIX_NONE,
+				     digest_len, 1, digest, digest_len, true);
+		return d;
+	}
+
+	/* Allocate a new digest item. */
+	if (!should_fail_digest_lists())
+		d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		print_hex_dump_debug("digest allocation failed: ",
+				     DUMP_PREFIX_NONE, digest_len, 1, digest,
+				     digest_len, true);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Add a new digest list reference to the new digest item. */
+	ret = digest_list_ref_add(d, digest_list, digest_offset, hdr_offset);
+	if (ret < 0) {
+		kfree(d);
+		return ERR_PTR(ret);
+	}
+
+	/* Add the new digest item to the hash table for the given type. */
+	hlist_add_head_rcu(&d->hnext, &htable[type].queue[hash_key(digest)]);
+	atomic_long_inc(&htable[type].len);
+
+	print_hex_dump_debug("digest add: ", DUMP_PREFIX_NONE, digest_len, 1,
+			     digest, digest_len, true);
+	return d;
+}
+
+/**
+ * digest_del - delete a digest with one reference, or just a reference
+ * @digest: digest in binary form
+ * @algo: digest algorithm
+ * @type: digest type
+ * @digest_list: digest list the digest belongs to
+ * @digest_offset: offset of the digest in the buffer of the digest list
+ * @hdr_offset: offset of the header within the digest list the digest refers to
+ *
+ * This function is called when a digest list is being removed. The digest is
+ * first searched in the hash table for the given type. If it is found (if not,
+ * it is a bug, because digest lists can be deleted only if they were added
+ * previously), a reference of the passed digest list is deleted from the array
+ * of references of the digest item.
+ *
+ * If the last reference was deleted, the digest item is also deleted and
+ * removed from the hash table.
+ *
+ * Returns the found digest item if it still has digest list references, NULL
+ * if all references were deleted, an error pointer otherwise.
+ */
+struct digest_item *digest_del(u8 *digest, enum hash_algo algo,
+			       enum compact_types type,
+			       struct digest_list_item *digest_list,
+			       loff_t digest_offset, loff_t hdr_offset)
+{
+	struct digest_item *d;
+	int digest_len = hash_digest_size[algo];
+	int ret;
+
+	/* Search the digest. */
+	d = digest_lookup(digest, algo, type, NULL, NULL);
+	if (!d) {
+		print_hex_dump(KERN_ERR, "digest not found: ", DUMP_PREFIX_NONE,
+			       digest_len, 1, digest, digest_len, true);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* Delete a reference of the passed digest list. */
+	ret = digest_list_ref_del(d, digest_list, digest_offset, hdr_offset);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	print_hex_dump_debug(d->refs != NULL ?
+			     "digest del duplicate: " : "digest del: ",
+			     DUMP_PREFIX_NONE, digest_len, 1, digest,
+			     digest_len, true);
+
+	/* Return if there are still references. */
+	if (d->refs != NULL)
+		return d;
+
+	/*
+	 * Remove the digest item from the hash table and free it if there are
+	 * no more references left.
+	 */
+	hlist_del_rcu(&d->hnext);
+	atomic_long_dec(&htable[type].len);
+	kfree(d);
+	return NULL;
+}
+
+/**
+ * digest_list_add - add a new digest list
+ * @digest: digest of the digest list in binary form
+ * @algo: digest algorithm
+ * @size: digest list size
+ * @buf: digest list buffer
+ * @actions: actions (measure/appraise) performed by IMA on the digest list
+ * @label: label to be used to identify the digest list
+ *
+ * This function allocates a new digest list item, which contains the buffer,
+ * size, actions performed by IMA and a label. Each digest list item is
+ * associated to a digest item representing the digest of the digest list.
+ *
+ * This function prevents the same digest list to be added multiple times by
+ * searching its digest in the hash table for the COMPACT_DIGEST_LIST type.
+ *
+ * The passed buffer is copied in a new memory area, to avoid to reference
+ * memory that could be freed by the caller.
+ *
+ * If allocation of a new digest list and the associated buffer was successful,
+ * its digest is added to the hash table for the COMPACT_DIGEST_LIST type.
+ *
+ * Returns the digest item associated to the digest list item on success, an
+ * error pointer otherwise.
+ */
+struct digest_item *digest_list_add(u8 *digest, enum hash_algo algo,
+				    loff_t size, u8 *buf, u8 actions,
+				    const char *label)
+{
+	struct digest_item *d;
+	struct digest_list_item *digest_list = NULL;
+	int digest_len = hash_digest_size[algo];
+
+	/* Search the digest of the digest list. */
+	d = digest_lookup(digest, algo, COMPACT_DIGEST_LIST, NULL, NULL);
+	if (d) {
+		print_hex_dump(KERN_ERR, "digest list already uploaded: ",
+			       DUMP_PREFIX_NONE, digest_len, 1, digest,
+			       digest_len, true);
+		return ERR_PTR(-EEXIST);
+	}
+
+	/* Allocate a new digest list. */
+	if (!should_fail_digest_lists())
+		digest_list = kzalloc(sizeof(*digest_list), GFP_KERNEL);
+	if (!digest_list) {
+		print_hex_dump(KERN_ERR, "digest list allocation failed: ",
+			       DUMP_PREFIX_NONE, digest_len, 1, digest,
+			       digest_len, true);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	digest_list->size = size;
+	if (!should_fail_digest_lists())
+		digest_list->buf = kmemdup(buf, size, GFP_KERNEL);
+	if (!digest_list->buf) {
+		print_hex_dump(KERN_ERR, "digest list allocation failed: ",
+			       DUMP_PREFIX_NONE, digest_len, 1, digest,
+			       digest_len, true);
+		kfree(digest_list);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	digest_list->actions = actions;
+	memcpy(digest_list->digest, digest, hash_digest_size[algo]);
+	digest_list->algo = algo;
+	digest_list->label = label;
+
+	/* Add the digest of the digest list to the hash table. */
+	d = digest_add(digest, algo, COMPACT_DIGEST_LIST, digest_list, 0, 0);
+	if (IS_ERR(d)) {
+		kfree(digest_list->buf);
+		kfree(digest_list);
+	}
+
+	return d;
+}
+
+/**
+ * digest_list_del - delete an existing digest list
+ * @digest: digest of the digest list in binary form
+ * @algo: digest algorithm
+ * @actions: actions (measure/appraise) performed by IMA on the digest list
+ * @digest_list: digest list to delete
+ *
+ * This function searches the digest of the digest list in the hash table for
+ * the COMPACT_DIGEST_LIST type. If it is found, this function frees the
+ * buffer and the digest list item allocated in digest_list_add().
+ *
+ * This function prevents the imbalance of digests (references left after
+ * delete) by ensuring that only digest lists that were previously added can be
+ * deleted.
+ *
+ * Returns NULL on successful deletion, an error pointer otherwise.
+ */
+struct digest_item *digest_list_del(u8 *digest, enum hash_algo algo, u8 actions,
+				    struct digest_list_item *digest_list)
+{
+	struct digest_item *d;
+
+	/* Delete the digest item associated to the digest list. */
+	d = digest_del(digest, algo, COMPACT_DIGEST_LIST, digest_list, 0, 0);
+	if (IS_ERR(d))
+		return d;
+
+	/*
+	 * Free the buffer and the digest list item allocated when the digest
+	 * list was added.
+	 */
+	kfree(digest_list->buf);
+	kfree(digest_list);
+	return NULL;
+}
-- 
2.25.1

