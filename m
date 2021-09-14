Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2939C40B4F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhINQiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:38:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3806 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhINQiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:38:12 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H887y5gq4z67Vmm;
        Wed, 15 Sep 2021 00:34:38 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 18:36:51 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 12/13] diglim: Remote Attestation
Date:   Tue, 14 Sep 2021 18:34:00 +0200
Message-ID: <20210914163401.864635-13-roberto.sassu@huawei.com>
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

Add more information about remote attestation with IMA and DIGLIM in
Documentation/security/diglim/remote_attestation.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/diglim/index.rst       |  1 +
 .../security/diglim/remote_attestation.rst    | 87 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 89 insertions(+)
 create mode 100644 Documentation/security/diglim/remote_attestation.rst

diff --git a/Documentation/security/diglim/index.rst b/Documentation/security/diglim/index.rst
index 4771134c2f0d..0f28c5ad71c0 100644
--- a/Documentation/security/diglim/index.rst
+++ b/Documentation/security/diglim/index.rst
@@ -10,3 +10,4 @@ Digest Lists Integrity Module (DIGLIM)
    introduction
    architecture
    implementation
+   remote_attestation
diff --git a/Documentation/security/diglim/remote_attestation.rst b/Documentation/security/diglim/remote_attestation.rst
new file mode 100644
index 000000000000..d22d01ce3e40
--- /dev/null
+++ b/Documentation/security/diglim/remote_attestation.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Remote Attestation
+==================
+
+When a digest list is added or deleted through the ``digest_list_add`` or
+``digest_list_del`` interfaces, the function ``diglim_ima_get_info()`` is
+called to retrieve the integrity status from IMA. This function supports
+two methods: by file, where the integrity information is retrieved from
+the ``integrity_iint_cache`` structure associated to the inode, if found;
+by buffer, where the buffer (directly written to securityfs, or filled from
+a file read by the kernel) is passed to ``ima_measure_critical_data()`` for
+measurement.
+
+For the by file method, existing IMA rules can be used, as long as the
+digest list matches the criteria. For the by buffer method, the following
+rule must be added to the IMA policy::
+
+ measure func=CRITICAL_DATA label=diglim
+
+The second method gives more accurate information, as it creates a
+measurement entry during addition and deletion, while the first method
+creates an entry only during addition.
+
+Below there is an example of usage of the by buffer method.
+
+When a file is uploaded, the workflow and the resulting IMA measurement
+list are:
+
+.. code-block:: bash
+
+ # echo $PWD/0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_add
+ # echo $PWD/0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_del
+ # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
+ ...
+ 10 <template digest> ima-buf sha256:<buffer digest> add_file_0-file_list-compact-cat <buffer>
+ 10 <template digest> ima-buf sha256:<buffer digest> del_file_0-file_list-compact-cat <buffer>
+
+When a buffer is uploaded, the workflow and the resulting IMA measurement
+list are:
+
+.. code-block:: bash
+
+ # echo 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_label
+ # cat 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_add
+ # echo 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_label
+ # cat 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_del
+ # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
+ ...
+ 10 <template digest> ima-buf sha256:<buffer digest> add_buffer_0-file_list-compact-cat <buffer>
+ 10 <template digest> ima-buf sha256:<buffer digest> del_buffer_0-file_list-compact-cat <buffer>
+
+In the second case, the digest list label must be set explicitly, as the
+kernel cannot determine it by itself (in the first case it is derived from
+the name of the file uploaded).
+
+The confirmation that the digest list has been processed by IMA can be
+obtained by reading the ASCII representation of the digest list:
+
+.. code-block:: bash
+
+ # cat /sys/kernel/security/integrity/diglim/digest_lists_loaded/sha256-<digest list digest>-0-file_list-compact-cat.ascii
+ actions: 1, version: 1, algo: sha256, type: 2, modifiers: 1, count: 1, datalen: 32
+ 87e5bd81850e11eeec2d3bb696b626b2a7f45673241cbbd64769c83580432869
+
+In this output, ``actions`` is set to 1 (``COMPACT_ACTION_IMA_MEASURED``
+bit set).
+
+
+DIGLIM guarantees that the information reported in the IMA measurement list
+is complete (with the by buffer method). If digest list loading is not
+recorded, digest query results are ignored by IMA. If the addition was
+recorded, deletion can be performed only if also the deletion is recorded.
+This can be seen in the following sequence of commands:
+
+.. code-block:: bash
+
+ # echo 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_label
+ # cat 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_add
+ # echo 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_label
+ # /tmp/cat 0-file_list-compact-cat > /sys/kernel/security/integrity/diglim/digest_list_del
+ diglim: actions mismatch, add: 1, del: 0
+ diglim: unable to upload generated digest list
+ /tmp/cat: write error: Invalid argument
+
+Digest list measurement is avoided with the execution of ``/tmp/cat``, for
+which a dont_measure rule was previously added in the IMA policy.
diff --git a/MAINTAINERS b/MAINTAINERS
index 826f628f4fab..eac82f151d18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5511,6 +5511,7 @@ F:	Documentation/security/diglim/architecture.rst
 F:	Documentation/security/diglim/implementation.rst
 F:	Documentation/security/diglim/index.rst
 F:	Documentation/security/diglim/introduction.rst
+F:	Documentation/security/diglim/remote_attestation.rst
 F:	include/linux/diglim.h
 F:	include/uapi/linux/diglim.h
 F:	security/integrity/diglim/diglim.h
-- 
2.25.1

