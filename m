Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6EE3B47A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFYQ7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 12:59:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3310 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFYQ7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 12:59:00 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBN935PWCz6L52F;
        Sat, 26 Jun 2021 00:43:03 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:56:36 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 03/12] digest_lists: Basic definitions
Date:   Fri, 25 Jun 2021 18:56:05 +0200
Message-ID: <20210625165614.2284243-4-roberto.sassu@huawei.com>
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

This patch introduces the basic definitions, exported to user space, to use
digest lists. The definitions, added to include/uapi/linux/digest_lists.h,
are documented in Documentation/security/digest_lists.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst | 119 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 include/uapi/linux/digest_lists.h       |  43 +++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 include/uapi/linux/digest_lists.h

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 8980be7836f8..995260294783 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -226,3 +226,122 @@ the digest list) (step 5).
 
 Finally, digests can be searched from user space through a securityfs file
 (step 6) or by the kernel itself.
+
+
+Implementation
+==============
+
+This section describes the implementation of Huawei Digest Lists.
+
+
+Basic Definitions
+-----------------
+
+This section introduces the basic definitions required to use digest lists.
+
+
+Compact Digest List Format
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Compact digest lists consist of one or multiple headers defined as:
+
+::
+
+	struct compact_list_hdr {
+		__u8 version;
+		__u8 _reserved;
+		__le16 type;
+		__le16 modifiers;
+		__le16 algo;
+		__le32 count;
+		__le32 datalen;
+	} __packed;
+
+which characterize the subsequent block of concatenated digests.
+
+The ``algo`` field specifies the algorithm used to calculate the digest.
+
+The ``count`` field specifies how many digests are stored in the subsequent
+block of digests.
+
+The ``datalen`` field specifies the length of the subsequent block of
+digests (it is redundant, it is the same as
+``hash_digest_size[algo] * count``).
+
+
+Compact Types
+.............
+
+Digests can be of different types:
+
+- ``COMPACT_PARSER``: digests of executables which are given the ability to
+  parse digest lists not in the compact format and to upload to the kernel
+  the digest list converted to the compact format;
+- ``COMPACT_FILE``: digests of regular files;
+- ``COMPACT_METADATA``: digests of file metadata (e.g. the digest
+  calculated by EVM to verify a portable signature);
+- ``COMPACT_DIGEST_LIST``: digests of digest lists (only used internally by
+  the kernel).
+
+Different users of Huawei Digest Lists might query digests with different
+compact types. For example, IMA would be interested in COMPACT_FILE, as it
+deals with regular files, while EVM would be interested in
+COMPACT_METADATA, as it verifies file metadata.
+
+
+Compact Modifiers
+.................
+
+Digests can also have specific attributes called modifiers (bit position):
+
+- ``COMPACT_MOD_IMMUTABLE``: file content or metadata should not be
+  modifiable.
+
+IMA might use this information to deny open for writing, or EVM to deny
+setxattr operations.
+
+
+Actions
+.......
+
+This section defines a set of possible actions that have been executed on
+the digest lists (bit position):
+
+- ``COMPACT_ACTION_IMA_MEASURED``: the digest list has been measured by
+  IMA;
+- ``COMPACT_ACTION_IMA_APPRAISED``: the digest list has been successfully
+  appraised by IMA;
+- ``COMPACT_ACTION_IMA_APPRAISED_DIGSIG``: the digest list has been
+  successfully appraised by IMA by verifying a digital signature.
+
+This information might help users of Huawei Digest Lists to decide whether
+to use the result of a queried digest.
+
+For example, if a digest belongs to a digest list that was not measured
+before, IMA should ignore the result of the query as the measurement list
+sent to remote verifiers would lack how the database was populated.
+
+
+Compact Digest List Example
+...........................
+
+::
+
+ version: 1, type: 2, modifiers: 0 algo: 4, count: 3, datalen: 96
+ <SHA256 digest1><SHA256 digest2><SHA256 digest3>
+ version: 1, type: 3, modifiers: 1 algo: 6, count: 2, datalen: 128
+ <SHA512 digest1><SHA512 digest2>
+
+This digest list consists of two blocks. The first block contains three
+SHA256 digests of regular files. The second block contains two SHA512
+digests of immutable metadata.
+
+
+Compact Digest List Operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Finally, this section defines the possible operations that can be performed
+with digest lists:
+
+- ``DIGEST_LIST_ADD``: the digest list is being added;
+- ``DIGEST_LIST_DEL``: the digest list is being deleted.
diff --git a/MAINTAINERS b/MAINTAINERS
index cba3d82fee43..ccf555862673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8387,6 +8387,7 @@ L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	Documentation/security/digest_lists.rst
+F:	uapi/linux/digest_lists.h
 
 HUAWEI ETHERNET DRIVER
 M:	Bin Luo <luobin9@huawei.com>
diff --git a/include/uapi/linux/digest_lists.h b/include/uapi/linux/digest_lists.h
new file mode 100644
index 000000000000..9545a8aaa231
--- /dev/null
+++ b/include/uapi/linux/digest_lists.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
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
+ *      Digest list definitions exported to user space.
+ */
+
+#ifndef _UAPI__LINUX_DIGEST_LISTS_H
+#define _UAPI__LINUX_DIGEST_LISTS_H
+
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+enum compact_types { COMPACT_KEY, COMPACT_PARSER, COMPACT_FILE,
+		     COMPACT_METADATA, COMPACT_DIGEST_LIST, COMPACT__LAST };
+
+enum compact_modifiers { COMPACT_MOD_IMMUTABLE, COMPACT_MOD__LAST };
+
+enum compact_actions { COMPACT_ACTION_IMA_MEASURED,
+		       COMPACT_ACTION_IMA_APPRAISED,
+		       COMPACT_ACTION_IMA_APPRAISED_DIGSIG,
+		       COMPACT_ACTION__LAST };
+
+enum ops { DIGEST_LIST_ADD, DIGEST_LIST_DEL, DIGEST_LIST_OP__LAST };
+
+struct compact_list_hdr {
+	__u8 version;
+	__u8 _reserved;
+	__le16 type;
+	__le16 modifiers;
+	__le16 algo;
+	__le32 count;
+	__le32 datalen;
+} __packed;
+#endif
-- 
2.25.1

