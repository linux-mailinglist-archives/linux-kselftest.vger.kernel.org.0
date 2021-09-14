Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2358140B4C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhINQfo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:35:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3797 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhINQfn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:35:43 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H884x6TV0z6H6mX;
        Wed, 15 Sep 2021 00:32:01 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 18:34:23 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 03/13] diglim: Objects
Date:   Tue, 14 Sep 2021 18:33:51 +0200
Message-ID: <20210914163401.864635-4-roberto.sassu@huawei.com>
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

Define the objects to manage digest lists:

- digest_list_item: a digest list loaded into the kernel;
- digest_list_item_ref: a reference to a digest list;
- digest_item: a digest of a digest list.

Also define some helpers for the objects. More information can be found in
Documentation/security/diglim/implementation.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../security/diglim/implementation.rst        |  78 +++++++
 MAINTAINERS                                   |   1 +
 security/integrity/diglim/diglim.h            | 203 ++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 security/integrity/diglim/diglim.h

diff --git a/Documentation/security/diglim/implementation.rst b/Documentation/security/diglim/implementation.rst
index 59a180b3bb3f..2089b854e5a5 100644
--- a/Documentation/security/diglim/implementation.rst
+++ b/Documentation/security/diglim/implementation.rst
@@ -95,3 +95,81 @@ with digest lists:
 
 - ``DIGEST_LIST_ADD``: the digest list is being added;
 - ``DIGEST_LIST_DEL``: the digest list is being deleted.
+
+
+Objects
+-------
+
+This section defines the objects to manage digest lists.
+
+.. kernel-doc:: security/integrity/diglim/diglim.h
+
+They are represented in the following class diagram::
+
+ digest_offset,
+ hdr_offset---------------+
+                          |
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
+All digest list references are stored for a given digest, so that a query
+result can include the OR of the modifiers and actions of each referenced
+digest list.
+
+The relationship between the described objects can be graphically
+represented as::
+
+ Hash table            +-------------+         +-------------+
+ PARSER      +-----+   | digest_item |         | digest_item |
+ FILE        | key |-->|             |-->...-->|             |
+ METADATA    +-----+   |ref0|...|refN|         |ref0|...|refN|
+                       +-------------+         +-------------+
+            ref0:         |                               | refN:
+            digest_offset | +-----------------------------+ digest_offset
+            hdr_offset    | |                               hdr_offset
+                          | |
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
+.. kernel-doc:: security/integrity/diglim/diglim.h
+   :identifiers: get_hdr
+
+.. kernel-doc:: security/integrity/diglim/diglim.h
+   :identifiers: get_digest
diff --git a/MAINTAINERS b/MAINTAINERS
index b02a8616362b..49e3989677a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5512,6 +5512,7 @@ F:	Documentation/security/diglim/implementation.rst
 F:	Documentation/security/diglim/index.rst
 F:	Documentation/security/diglim/introduction.rst
 F:	include/uapi/linux/diglim.h
+F:	security/integrity/diglim/diglim.h
 
 DIOLAN U2C-12 I2C DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
diff --git a/security/integrity/diglim/diglim.h b/security/integrity/diglim/diglim.h
new file mode 100644
index 000000000000..1c1f513060c7
--- /dev/null
+++ b/security/integrity/diglim/diglim.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Definitions only used inside DIGLIM.
+ */
+
+#ifndef __DIGLIM_INTERNAL_H
+#define __DIGLIM_INTERNAL_H
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
+#include <uapi/linux/diglim.h>
+
+#define MAX_DIGEST_SIZE 64
+#define HASH_BITS 10
+#define DIGLIM_HTABLE_SIZE (1 << HASH_BITS)
+
+/**
+ * struct digest_list_item - a digest list loaded into the kernel
+ *
+ * @size: size of the digest list buffer
+ * @buf: digest list buffer
+ * @digest: digest of the digest list
+ * @label: label used to identify the digest list (e.g. file name)
+ * @actions: actions performed on the digest list
+ * @algo: digest algorithm
+ */
+struct digest_list_item {
+	loff_t size;
+	u8 *buf;
+	u8 digest[64];
+	const char *label;
+	u8 actions;
+	enum hash_algo algo;
+};
+
+/**
+ * struct digest_list_item_ref - a reference to a digest list
+ *
+ * @list: linked list pointers
+ * @digest_list: pointer to struct digest_list_item
+ * @digest_offset: offset of the digest in the referenced digest list
+ * @hdr_offset: offset of the header the digest refers to in the digest list
+ */
+struct digest_list_item_ref {
+	struct list_head list;
+	struct digest_list_item *digest_list;
+	u32 digest_offset;
+	u32 hdr_offset;
+};
+
+/**
+ * struct digest_item - a digest of a digest list
+ *
+ * @hnext: pointers of the hash table
+ * @refs: linked list of struct digest_list_item_ref
+ */
+struct digest_item {
+	struct hlist_node hnext;
+	struct list_head refs;
+};
+
+/**
+ * struct h_table - hash table of struct digest_item
+ *
+ * @len: number of stored struct digest_item
+ * @queue: heads of the hash table
+ */
+struct h_table {
+	unsigned long len;
+	struct hlist_head queue[DIGLIM_HTABLE_SIZE];
+};
+
+static inline unsigned int hash_key(u8 *digest)
+{
+	return (digest[0] | digest[1] << 8) % DIGLIM_HTABLE_SIZE;
+}
+
+/**
+ * get_hdr - get a compact header from a digest list
+ * @digest_list: digest list the header is obtained from
+ * @hdr_offset: header offset relative to the digest list buffer
+ *
+ * This function obtains a header from a digest list buffer and a header offset.
+ *
+ * Return: a compact list header
+ */
+static inline struct compact_list_hdr *
+get_hdr(struct digest_list_item *digest_list, loff_t hdr_offset)
+{
+	return (struct compact_list_hdr *)(digest_list->buf + hdr_offset);
+}
+
+/**
+ * get_algo - get a digest algorithm from a digest list
+ * @digest_list: digest list the digest algorithm is obtained from
+ * @digest_offset: offset of the digest relative to the digest list buffer
+ * @hdr_offset: offset of the header relative to the digest list buffer
+ *
+ * This function returns the algorithm from struct digest_list_item if the
+ * passed digest offset is zero, or from the header the digest refers to if the
+ * digest offset is not zero.
+ *
+ * Return: the algorithm of the digest list digest or a digest inside the digest
+ * list
+ */
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
+/**
+ * get_digest - get a digest from a digest list
+ * @digest_list: digest list the digest is obtained from
+ * @digest_offset: offset of the digest relative to the digest list buffer
+ * @hdr_offset: offset of the header relative to the digest list buffer
+ *
+ * This function returns the digest from struct digest_list_item if the
+ * passed digest offset is zero, or from the digest list buffer if the
+ * digest offset is not zero.
+ *
+ * Return: the digest list digest or a digest inside the digest list
+ */
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
+/**
+ * get_hdr_ref - get a compact header from a digest list reference
+ * @ref: digest list reference the header is obtained from
+ *
+ * This function obtains a header from a digest list reference, which contains
+ * the pointer to the digest list buffer and the digest and header offsets.
+ *
+ * Return: a compact list header
+ */
+static inline struct compact_list_hdr *
+get_hdr_ref(struct digest_list_item_ref *ref)
+{
+	return get_hdr(ref->digest_list, ref->hdr_offset);
+}
+
+/**
+ * get_algo_ref - get a digest algorithm from a digest list reference
+ * @ref: digest list reference the digest algorithm is obtained from
+ *
+ * This function returns the algorithm from struct digest_list_item_ref, which
+ * contains the pointer to the digest list buffer and the digest and header
+ * offsets.
+ *
+ * Return: the algorithm of the digest list digest or a digest inside the digest
+ * list
+ */
+static inline enum hash_algo get_algo_ref(struct digest_list_item_ref *ref)
+{
+	/* Digest list digest algorithm is stored in a different place. */
+	if (!ref->digest_offset)
+		return ref->digest_list->algo;
+
+	return get_hdr_ref(ref)->algo;
+}
+
+/**
+ * get_digest_ref - get a digest from a digest list reference
+ * @ref: digest list reference the digest is obtained from
+ *
+ * This function returns the digest from struct digest_list_item_ref, which
+ * contains the pointer to the digest list buffer and the digest and header
+ * offsets.
+ *
+ * Return: the digest list digest or a digest inside the digest list
+ */
+static inline u8 *get_digest_ref(struct digest_list_item_ref *ref)
+{
+	/* Digest list digest is stored in a different place. */
+	if (!ref->digest_offset)
+		return ref->digest_list->digest;
+
+	return ref->digest_list->buf + ref->digest_offset;
+}
+#endif /*__DIGLIM_INTERNAL_H*/
-- 
2.25.1

