Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F140CA28
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhIOQeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:34:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3823 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhIOQeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m0q01TBz67jmn;
        Thu, 16 Sep 2021 00:30:35 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:32:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/9] integrity: Introduce DIGLIM advanced features
Date:   Wed, 15 Sep 2021 18:31:36 +0200
Message-ID: <20210915163145.1046505-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Introduction
============

This patch set depends on:
- support for the euid policy keyword for critical data
  (https://lore.kernel.org/linux-integrity/20210705115650.3373599-1-roberto.sassu@huawei.com/)
- basic DIGLIM
  (https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/)

Introduce the remaining features necessary to upload to the kernel
reference values from RPM headers or digest lists in other formats.

Loader: it will automatically uploads digest lists from a directory
        specified in the kernel configuration and will execute a user space
        uploader to upload digest lists in a format that is not recognized
        by the kernel;

LSM: it identifies digest list parsers and monitor their activity for
     integrity evaluation; it protects digest list parsers from other user
     space processes considered as untrusted;

Digest list generators: user space tools to generate digest lists from
                        files (in the compact format) or from the RPM DB;

Digest list uploader and parsers: user space tools responsible to upload to
                                  the kernel digest lists not in the
                                  compact format (e.g. those derived from
                                  the RPM DB);

Administration guide: it describes the steps necessary to upload to the
                      kernel all the digests of an RPM-based Linux
                      distribution, using a custom kernel with the DIGLIM
                      patches applied.

With these changes, DIGLIM is ready to be used by IMA for measurement and
appraisal (this functionality will be added with a future patch set).

DIGLIM already supports appended signatures, but at the moment they cannot
be interpreted by IMA (unsupported ID PKEY_ID_PGP). Another patch set is
necessary to load the PGP keys from the Linux distribution to the system
keyring and to verify the PGP signatures of the RPM headers.

With the patch sets above and the execution policies for IMA proposed some
time ago, it will be possible to generate a measurement list with digest
lists and unknown files, and enable IMA appraisal in enforcing mode.
The kernel command line would be:

ima_template=ima-modsig ima_policy="exec_tcb|tmpfs|digest_lists|appraise_exec_tcb|appraise_tmpfs|appraise_digest_lists"

The effort required for Linux distribution vendors will be to generate and
sign the digest lists for the digest list uploader and the RPM parser. This
could be done for example in the kernel-tools package (or in a separate
package). Existing package signatures are sufficient for remaining files.


Issues/Questions
================

Lockdep (patch 2/9)
-------------------

I'm using iterate_dir() and file_open_root() to iterate and open files
in a directory. Unfortunately, I get the following warning:

============================================
WARNING: possible recursive locking detected
5.15.0-rc1-dont-use-00049-ga5a881519991 #134 Not tainted
--------------------------------------------
swapper/1 is trying to acquire lock:
0000000066812898 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: path_openat+0x75d/0xd20

but task is already holding lock:
0000000066812898 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: iterate_dir+0x65/0x250

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sb->s_type->i_mutex_key#7);
  lock(&sb->s_type->i_mutex_key#7);

 *** DEADLOCK ***


due to the fact that path_openat() might be trying to lock the directory
already locked by iterate_dir(). What it would be a good way to avoid it?


Inode availability in security_file_free() (patch 3/9)
------------------------------------------------------

It seems that this hook is called when the last reference to a file is
released. After enabling debugging, sometimes the kernel reported that the
inode I was trying to access was already freed.

To avoid this situation, I'm grabbing an additional reference of the inode
in the security_file_open() hook, to ensure that the inode does not
disappear, and I'm releasing it in the security_file_free() hook. Is this
solution acceptable?

Roberto Sassu (9):
  ima: Introduce new hook DIGEST_LIST_CHECK
  diglim: Loader
  diglim: LSM
  diglim: Tests - LSM
  diglim: Compact digest list generator
  diglim: RPM digest list generator
  diglim: Digest list uploader
  diglim: RPM parser
  diglim: Admin guide

 Documentation/admin-guide/diglim.rst          | 136 +++++
 Documentation/admin-guide/index.rst           |   1 +
 .../security/diglim/implementation.rst        |  16 +
 Documentation/security/diglim/index.rst       |   1 +
 Documentation/security/diglim/lsm.rst         |  65 +++
 Documentation/security/diglim/tests.rst       |  18 +-
 MAINTAINERS                                   |  10 +
 security/integrity/diglim/Kconfig             |  14 +
 security/integrity/diglim/Makefile            |   2 +-
 security/integrity/diglim/diglim.h            |  27 +
 security/integrity/diglim/fs.c                |   3 +
 security/integrity/diglim/hooks.c             | 436 ++++++++++++++++
 security/integrity/diglim/loader.c            |  92 ++++
 security/integrity/iint.c                     |   1 +
 security/integrity/ima/ima.h                  |   1 +
 security/integrity/ima/ima_main.c             |   3 +-
 security/integrity/ima/ima_policy.c           |   3 +
 security/integrity/integrity.h                |   8 +
 tools/diglim/Makefile                         |  27 +
 tools/diglim/common.c                         |  79 +++
 tools/diglim/common.h                         |  59 +++
 tools/diglim/compact_gen.c                    | 349 +++++++++++++
 tools/diglim/rpm_gen.c                        | 334 ++++++++++++
 tools/diglim/rpm_parser.c                     | 483 ++++++++++++++++++
 tools/diglim/upload_digest_lists.c            | 238 +++++++++
 tools/testing/selftests/diglim/Makefile       |  12 +-
 tools/testing/selftests/diglim/common.h       |   9 +
 tools/testing/selftests/diglim/selftest.c     | 357 ++++++++++++-
 28 files changed, 2764 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/admin-guide/diglim.rst
 create mode 100644 Documentation/security/diglim/lsm.rst
 create mode 100644 security/integrity/diglim/hooks.c
 create mode 100644 security/integrity/diglim/loader.c
 create mode 100644 tools/diglim/Makefile
 create mode 100644 tools/diglim/common.c
 create mode 100644 tools/diglim/common.h
 create mode 100644 tools/diglim/compact_gen.c
 create mode 100644 tools/diglim/rpm_gen.c
 create mode 100644 tools/diglim/rpm_parser.c
 create mode 100644 tools/diglim/upload_digest_lists.c

-- 
2.25.1

