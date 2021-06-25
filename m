Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2554B3B47AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFYQ7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 12:59:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3311 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFYQ7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 12:59:00 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNJ25g9kz6G83c;
        Sat, 26 Jun 2021 00:49:06 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:56:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 04/12] digest_lists: Objects
Date:   Fri, 25 Jun 2021 18:56:06 +0200
Message-ID: <20210625165614.2284243-5-roberto.sassu@huawei.com>
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

This patch defines the objects to manage digest lists:

- digest_list_item: represents a digest list;
- digest_list_item_ref: represents a reference to a digest list, i.e. the
  location at which a digest within a digest list can be accessed;
- digest_item: represents a unique digest.

It also defines some helpers for the objects. More information can be found
in Documentation/security/digest_lists.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst       | 156 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 .../integrity/digest_lists/digest_lists.h     | 117 +++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 security/integrity/digest_lists/digest_lists.h

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 995260294783..1031667324c9 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -345,3 +345,159 @@ with digest lists:
 
 - ``DIGEST_LIST_ADD``: the digest list is being added;
 - ``DIGEST_LIST_DEL``: the digest list is being deleted.
+
+
+Objects
+-------
+
+This section defines the objects to manage digest lists:
+
+- ``digest_list_item``: represents a digest list;
+- ``digest_list_item_ref``: represents a reference to a digest list,
+  i.e. the location at which a digest within a digest list can be accessed;
+- ``digest_item``: represents a unique digest.
+
+They are represented in the following class diagram:
+
+::
+
+ digest_offset,-----------+
+ hdr_offset               |
+                          |
+ +------------------+     |     +----------------------+
+ | digest_list_item |--- N:1 ---| digest_list_item_ref |
+ +------------------+           +----------------------+
+                                           |
+                                          1:N
+                                           |
+                                    +-------------+
+                                    | digest_item |
+                                    +-------------+
+
+A ``digest_list_item`` is associated to one or multiple
+``digest_list_item_ref``, one for each digest it contains. However,
+a ``digest_list_item_ref`` is associated to only one ``digest_list_item``,
+as it represents a single location within a specific digest list.
+
+Given that a ``digest_list_item_ref`` represents a single location, it is
+associated to only one ``digest_item``. However, a ``digest_item`` can have
+multiple references (as it might appears multiple times within the same
+digest list or in different digest lists, if it is duplicated).
+
+
+A ``digest_list_item`` is defined as:
+
+::
+
+	struct digest_list_item {
+		loff_t size;
+		u8 *buf;
+		u8 actions;
+		u8 digest[64];
+		enum hash_algo algo;
+		const char *label;
+	};
+
+- ``size``: size of the digest list buffer;
+- ``buf``: digest list buffer;
+- ``actions``: actions performed on the digest list;
+- ``digest``: digest of the digest list;
+- ``algo``: digest algorithm;
+- ``label``: label used to identify the digest list (e.g. file name).
+
+A ``digest_list_item_ref`` is defined as:
+
+::
+
+	struct digest_list_item_ref {
+		struct digest_list_item *digest_list;
+		loff_t digest_offset;
+		loff_t hdr_offset;
+	};
+
+- ``digest_list``: pointer to a ``digest_list_item`` structure;
+- ``digest_offset``: offset of the digest related to the digest list
+  buffer;
+- ``hdr_offset``: offset of the header of the digest block containing the
+  digest.
+
+A ``digest_item`` is defined as:
+
+::
+
+	struct digest_item {
+		struct hlist_node hnext;
+		struct digest_list_item_ref *refs;
+	};
+
+- ``hnext``: pointers of the hash table;
+- ``refs``: array of ``digest_list_item_ref`` structures including a
+  terminator (protected by RCU).
+
+All digest list references are stored for a given digest, so that a query
+result can include the OR of the modifiers and actions of each referenced
+digest list.
+
+The relationship between the described objects can be graphically
+represented as:
+
+::
+
+ Hash table            +-------------+         +-------------+
+ PARSER      +-----+   | digest_item |         | digest_item |
+ FILE        | key |-->|             |-->...-->|             |
+ METADATA    +-----+   |ref0|...|refN|         |ref0|...|refN|
+                       +-------------+         +-------------+
+            ref0:         |                               | refN:
+            digest_offset | +-----------------------------+ digest_offset
+            hdr_offset    | |                               hdr_offset
+                          V V
+                     +--------------------+
+                     |  digest_list_item  |
+                     |                    |
+                     | size, buf, actions |
+                     +--------------------+
+                          ^
+                          |
+ Hash table            +-------------+         +-------------+
+ DIGEST_LIST +-----+   |ref0         |         |ref0         |
+             | key |-->|             |-->...-->|             |
+             +-----+   | digest_item |         | digest_item |
+                       +-------------+         +-------------+
+
+The reference for the digest of the digest list differs from the references
+for the other digest types. ``digest_offset`` and ``hdr_offset`` are set to
+zero, so that the digest of the digest list is retrieved from the
+``digest_list_item`` structure directly (see ``get_digest()`` below).
+
+Finally, this section defines useful helpers to access a digest or the
+header the digest belongs to. For example:
+
+::
+
+ static inline struct compact_list_hdr *get_hdr(
+                                      struct digest_list_item *digest_list,
+                                      loff_t hdr_offset)
+ {
+         return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
+ }
+
+the header can be obtained by summing the address of the digest list buffer
+in the ``digest_list_item`` structure with ``hdr_offset``.
+
+Similarly:
+
+::
+
+ static inline u8 *get_digest(struct digest_list_item *digest_list,
+                              loff_t digest_offset, loff_t hdr_offset)
+ {
+         /* Digest list digest is stored in a different place. */
+         if (!digest_offset)
+                 return digest_list->digest;
+         return digest_list->buf + digest_offset;
+ }
+
+the digest can be obtained by summing the address of the digest list buffer
+with ``digest_offset`` (except for the digest lists, where the digest is
+stored in the ``digest`` field of the ``digest_list_item`` structure).
diff --git a/MAINTAINERS b/MAINTAINERS
index ccf555862673..9a7e9f16eee8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8387,6 +8387,7 @@ L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	Documentation/security/digest_lists.rst
+F:	security/integrity/digest_lists/digest_list.h
 F:	uapi/linux/digest_lists.h
 
 HUAWEI ETHERNET DRIVER
diff --git a/security/integrity/digest_lists/digest_lists.h b/security/integrity/digest_lists/digest_lists.h
new file mode 100644
index 000000000000..81b6cb10f4f1
--- /dev/null
+++ b/security/integrity/digest_lists/digest_lists.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+ * File: digest_lists.h
+ *      Unexported definitions for digest lists.
+ */
+
+#ifndef __DIGEST_LISTS_INTERNAL_H
+#define __DIGEST_LISTS_INTERNAL_H
+
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include <linux/hash.h>
+#include <linux/tpm.h>
+#include <linux/audit.h>
+#include <crypto/hash_info.h>
+#include <linux/hash_info.h>
+#include <uapi/linux/digest_lists.h>
+
+#define MAX_DIGEST_SIZE	64
+#define HASH_BITS 10
+#define MEASURE_HTABLE_SIZE (1 << HASH_BITS)
+
+struct digest_list_item {
+	loff_t size;
+	u8 *buf;
+	u8 actions;
+	u8 digest[64];
+	enum hash_algo algo;
+	const char *label;
+};
+
+struct digest_list_item_ref {
+	struct digest_list_item *digest_list;
+	loff_t digest_offset;
+	loff_t hdr_offset;
+};
+
+struct digest_item {
+	/* hash table pointers */
+	struct hlist_node hnext;
+	/* digest list references (protected by RCU) */
+	struct digest_list_item_ref *refs;
+};
+
+struct h_table {
+	atomic_long_t len;
+	struct hlist_head queue[MEASURE_HTABLE_SIZE];
+};
+
+static inline unsigned int hash_key(u8 *digest)
+{
+	return (digest[0] | digest[1] << 8) % MEASURE_HTABLE_SIZE;
+}
+
+static inline struct compact_list_hdr *get_hdr(
+					struct digest_list_item *digest_list,
+					loff_t hdr_offset)
+{
+	return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
+}
+
+static inline enum hash_algo get_algo(struct digest_list_item *digest_list,
+				      loff_t digest_offset, loff_t hdr_offset)
+{
+	/* Digest list digest algorithm is stored in a different place. */
+	if (!digest_offset)
+		return digest_list->algo;
+
+	return get_hdr(digest_list, hdr_offset)->algo;
+}
+
+static inline u8 *get_digest(struct digest_list_item *digest_list,
+			     loff_t digest_offset, loff_t hdr_offset)
+{
+	/* Digest list digest is stored in a different place. */
+	if (!digest_offset)
+		return digest_list->digest;
+
+	return digest_list->buf + digest_offset;
+}
+
+static inline struct compact_list_hdr *get_hdr_ref(
+					struct digest_list_item_ref *ref)
+{
+	return get_hdr(ref->digest_list, ref->hdr_offset);
+}
+
+static inline enum hash_algo get_algo_ref(struct digest_list_item_ref *ref)
+{
+	/* Digest list digest algorithm is stored in a different place. */
+	if (!ref->digest_offset)
+		return ref->digest_list->algo;
+
+	return get_hdr_ref(ref)->algo;
+}
+
+static inline u8 *get_digest_ref(struct digest_list_item_ref *ref)
+{
+	/* Digest list digest is stored in a different place. */
+	if (!ref->digest_offset)
+		return ref->digest_list->digest;
+
+	return ref->digest_list->buf + ref->digest_offset;
+}
+#endif /*__DIGEST_LISTS_INTERNAL_H*/
-- 
2.25.1

