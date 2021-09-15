Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF040CA46
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhIOQfi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:35:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3832 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhIOQfd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:35:33 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m2B67JVz67vP9;
        Thu, 16 Sep 2021 00:31:46 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:34:10 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 9/9] diglim: Admin guide
Date:   Wed, 15 Sep 2021 18:31:45 +0200
Message-ID: <20210915163145.1046505-10-roberto.sassu@huawei.com>
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

Introduce a DIGLIM administration guide. Its main purpose is to help users
to configure a system to load to the kernel all the digests of executable
and firmware from the RPM DB, and kernel modules of a custom kernel and a
temporary file mapped as executable as custom digest lists.

With further patch sets, it will be possible to load an execution policy in
IMA and create a measurement list only with digest lists and unknown files,
and to perform secure boot at application level.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/diglim.rst | 136 +++++++++++++++++++++++++++
 Documentation/admin-guide/index.rst  |   1 +
 MAINTAINERS                          |   1 +
 3 files changed, 138 insertions(+)
 create mode 100644 Documentation/admin-guide/diglim.rst

diff --git a/Documentation/admin-guide/diglim.rst b/Documentation/admin-guide/diglim.rst
new file mode 100644
index 000000000000..886100cf5a62
--- /dev/null
+++ b/Documentation/admin-guide/diglim.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+DIGLIM
+======
+
+Digest Lists Integrity Module (DIGLIM) is an integrity extension aiming to
+facilitate the deployment of remote attestation and secure boot solutions
+based on Integrity Measurement Architecture (IMA).
+
+DIGLIM documentation can be retrieved at ``Documentation/security/diglim``.
+
+Kernel Configuration Options
+============================
+
+DIGLIM can be enabled by setting ``CONFIG_DIGLIM=y`` in the kernel
+configuration. Optionally, it is possible to set
+``CONFIG_DIGLIM_DIGEST_LISTS_DIR`` with the directory digest lists are
+taken from by a kernel loader executed at kernel initialization time.
+Finally, with ``CONFIG_DIGLIM_UPLOADER_PATH`` it is possible to specify the
+path of the digest list uploader, which will execute user space parsers to
+process the digest lists in ``CONFIG_DIGLIM_DIGEST_LISTS_DIR`` that are not
+in the format recognized by the kernel.
+
+
+LSM
+===
+
+DIGLIM includes an LSM to protect user space parsers from other processes,
+when the parsers convert a digest list and uploads it to the kernel. As for
+other LSMs, ``diglim`` should be added to the list of enabled LSMs,
+provided with the ``lsm=`` kernel option. If DIGLIM LSM is not enabled,
+digest lists uploaded by the parser will not be marked as processed by IMA
+and will not be suitable for use.
+
+
+Setup
+=====
+
+Digest lists must be loaded as soon as possible, before files are accessed,
+so that IMA finds the digest of those files with a query. More details on
+the benefits of DIGLIM for IMA can be found in
+``Documentation/security/diglim/introduction.rst``.
+
+
+Digest List Generation
+----------------------
+
+Digest lists can be generated with the tools provided in ``tools/diglim``
+in the kernel sources. In order to compile the tools, it is necessary to
+install the ``glibc-static`` and ``rpm-devel`` packages.
+
+``compact_gen`` can be used to generate digest lists in the compact format,
+which can be directly uploaded to the kernel.
+
+In order to upload digests from the RPM database, it is necessary to
+generate three digest lists: one for ``upload_digest_lists``, which is
+responsible to execute the parsers for digest lists not in the compact
+format; two for ``rpm_parser``, which actually loads the RPM digest lists.
+
+``rpm_parser`` requires two digest lists, one for identification by DIGLIM
+LSM, and the other for measurement and appraisal with IMA. The commands
+are::
+
+ # tools/diglim/compact_gen -d /etc/digest_lists -i /usr/libexec/diglim/rpm_parser -t parser
+ # tools/diglim/compact_gen -d /etc/digest_lists -i /usr/libexec/diglim/rpm_parser -t file
+ # tools/diglim/compact_gen -d /etc/digest_lists -i /usr/libexec/diglim/upload_digest_lists -t file
+
+Optionally, an appended signature can be added to the generated digest
+lists, with the sign-file tool included in the kernel sources::
+
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/0-parser_list-compact-rpm_parser
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/0-file_list-compact-rpm_parser
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/0-file_list-compact-upload_digest_lists
+
+With an appropriate policy, appended signatures can be seen in the
+measurement, by selecting the ``ima-modsig`` template.
+
+Afterwards, digest lists can be generated from the RPM database with the
+command::
+
+ # tools/diglim/rpm_gen -d /etc/digest_lists
+
+If a custom kernel is used, an additional digest list should be generated
+for kernel modules::
+
+ # tools/diglim/compact_gen -d /etc/digest_lists -i /lib/modules/`uname -r` -t file
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/0-file_list-compact-`uname -r`
+
+Finally, in Fedora there is an mmap with execution permission on a file
+with 4K of zeros. A digest list can be generated by executing::
+
+ # dd if=/dev/zero of=/tmp/mmap bs=4096 count=1
+ # tools/diglim/compact_gen -d /etc/digest_lists -i /tmp/mmap -f
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/0-file_list-compact-mmap
+
+
+Initial Ram Disk
+----------------
+
+Generated digest lists should be copied to the initial ram disk in the
+``CONFIG_DIGLIM_DIGEST_LISTS_DIR`` directory. This can be accomplished,
+with dracut, by adding in /etc/dracut.conf::
+
+ install_optional_items+=" /etc/digest_lists/* "
+
+if ``CONFIG_DIGLIM_DIGEST_LISTS_DIR=/etc/digest_lists``.
+
+``upload_digest_lists`` and ``rpm_parser`` can be also copied to the
+initial ram disk by adding the following lines in /etc/dracut.conf::
+
+ install_optional_items+=" /usr/libexec/diglim/upload_digest_lists "
+ install_optional_items+=" /usr/libexec/diglim/rpm_parser "
+
+assuming that the binaries are installed in /usr/libexec/diglim.
+
+Another important option is::
+
+ do_strip="no"
+
+This prevents dracut from stripping the symbols from binaries. If binaries
+are altered, their digest will be different from the reference value and
+will not be found in the DIGLIM hash table.
+
+
+Boot and Digest List Upload
+---------------------------
+
+After generating the initial ram disk and rebooting, digest lists should
+have been added to the DIGLIM hash table. This can be checked by executing::
+
+ # cat /sys/kernel/security/integrity/diglim/digests_count
+ Parser digests: 1
+ File digests: 104273
+ Metadata digests: 0
+ Digest list digests: 2430
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index dc00afcabb95..1cc7d3b3e79c 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -79,6 +79,7 @@ configure specific aspects of kernel behavior to your liking.
    cputopology
    dell_rbu
    device-mapper/index
+   diglim
    edid
    efi-stub
    ext4
diff --git a/MAINTAINERS b/MAINTAINERS
index 1efc1724376e..953c86915c49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5507,6 +5507,7 @@ M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	Documentation/admin-guide/diglim.rst
 F:	Documentation/security/diglim/architecture.rst
 F:	Documentation/security/diglim/implementation.rst
 F:	Documentation/security/diglim/index.rst
-- 
2.25.1

