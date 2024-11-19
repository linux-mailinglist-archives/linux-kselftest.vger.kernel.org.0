Return-Path: <linux-kselftest+bounces-22250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587B9D23CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C5FB22F1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C41C302B;
	Tue, 19 Nov 2024 10:50:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E331BD9C8;
	Tue, 19 Nov 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013426; cv=none; b=o17jC874qgpNW+98X0RaRCD2ahPFy1UWZ1Hpwnm6OXNYoxqYqz3cGwSUTTF5MXzd5fYnFDInkGRiwKO9ystWPPBR084hfz2aAOiLefDSlCiStVvSGoV9I93+kOo49iwI5Hph9XKygcYCvb4ugwST5X3SQh2WSDq2lUXUzJZfTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013426; c=relaxed/simple;
	bh=uSaSDAV6MTDHnDdPb5ynKFA6kcjl9GJzS5ihaI6DJso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdsXIxjHHy6O1ga8vyaDGeUfCP7epkOpNofBmfPVMEw6SVexN7k5c2oxoRpVcU6j81JYBZMvkfgz5gRfIq+k+fOwViB6itgVsaqHKOq8jHm/xMUIzZlPVCcL3SkCh6VEXZ0z5Kux009L6TQJX4GgGbUCWLZSssaUfxCEH4+O9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt0tr3pN6z9v7JS;
	Tue, 19 Nov 2024 18:23:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AA586140B1F;
	Tue, 19 Nov 2024 18:50:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S2;
	Tue, 19 Nov 2024 11:50:07 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
Date: Tue, 19 Nov 2024 11:49:07 +0100
Message-ID: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S2
X-Coremail-Antispam: 1UD129KBjvAXoW3urykCryDtr47uryDWr15Jwb_yoW8AF13Co
	ZYkanrXw4kKFy3AF4kCFnrAay7W3sagw1xAr4vvryUZF1fXFW5Ga4DCa1DAFy3Zr48Xr97
	Aa48Z3yUXFWDtrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYh7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWr
	XVW8Jr1lIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxU9K9aDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEfwAAso

From: Roberto Sassu <roberto.sassu@huawei.com>

Integrity detection and protection has long been a desirable feature, to
reach a large user base and mitigate the risk of flaws in the software
and attacks.

However, while solutions exist, they struggle to reach a large user base,
due to requiring higher than desired constraints on performance,
flexibility and configurability, that only security conscious people are
willing to accept.

For example, IMA measurement requires the target platform to collect
integrity measurements, and to protect them with the TPM, which introduces
a noticeable overhead (up to 10x slower in a microbenchmark) on frequently
used system calls, like the open().

IMA Appraisal currently requires individual files to be signed and
verified, and Linux distributions to rebuild all packages to include file
signatures (this approach has been adopted from Fedora 39+). Like a TPM,
also signature verification introduces a significant overhead, especially
if it is used to check the integrity of many files.

This is where the new Integrity Digest Cache comes into play, it offers
additional support for new and existing integrity solutions, to make
them faster and easier to deploy.

The Integrity Digest Cache can help IMA to reduce the number of TPM
operations and to make them happen in a deterministic way. If IMA knows
that a file comes from a Linux distribution, it can measure files in a
different way: measure the list of digests coming from the distribution
(e.g. RPM package headers), and subsequently measure a file if it is not
found in that list.

The performance improvement comes at the cost of IMA not reporting which
files from installed packages were accessed, and in which temporal
sequence. This approach might not be suitable for all use cases.

The Integrity Digest Cache can also help IMA for appraisal. IMA can simply
lookup the calculated digest of an accessed file in the list of digests
extracted from package headers, after verifying the header signature. It is
sufficient to verify only one signature for all files in the package, as
opposed to verifying a signature for each file.

The same approach can be followed by other LSMs, such as Integrity Policy
Enforcement (IPE), and BPF LSM.

The Integrity Digest Cache is not tied to a specific package format. The
kernel supports a TLV-based digest list format. More can be added through
third-party kernel modules. The TLV parser has been verified for memory
safety with the Frama-C static analyzer. The version with the Frama-C
assertions is available here:

https://github.com/robertosassu/rpm-formal/blob/main/validate_tlv.c

Integrating the Integrity Digest Cache in IMA brings significant
performance improvements: up to 67% and 79% for measurement respectively in
sequential and parallel file reads; up to 65% and 43% for appraisal
respectively in sequential and parallel file reads.

The performance can be further enhanced by using fsverity digests instead
of conventional file digests, which would make IMA verify only the portion
of the file to be read. However, at the moment, fsverity digests are not
included in RPM packages. In this case, once rpm is extended to include
them, Linux distributions still have to rebuild their packages.

The Integrity Digest Cache can support both digest types, so that the
functionality is immediately available without waiting for Linux
distributions to do the transition.

This patch set only includes the patches necessary to extract digests from
a TLV-based data format, and exposes an API for LSMs to query them. A
separate patch set will be provided to integrate it in IMA.

This patch set and the follow-up IMA integration can be tested by following
the instructions at:

https://github.com/linux-integrity/digest-cache-tools

This patch set applies on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity

with commit 08ae3e5f5fc8 ("integrity: Use static_assert() to check struct
sizes").

Changelog

v5:
- Remove the RPM parser and selftests (suggested by Linus)
- Return digest cache pointer from digest_cache_lookup()
- Export new Parser API, and allow registration of third-party digest list
  parsers (suggested by Mimi)
- Reduce sizes in TLV format and remove TLV header (suggested by Jani
  Nikula)
- Introduce new DIGEST_LIST_NUM_ENTRIES TLV field
- Pass file descriptor instead of dentry in digest_cache_get() to properly
  detect potential deadlocks
- Introduce digest_cache_opened_fd() to tell lockdep when it is safe to
  nest a mutex if digest_cache_get() is called with that mutex held
- Add new patch to introduce ksys_finit_module()
- Make the TLV parser as configurable (Y/N/m) with Kconfig (suggested by
  Mimi)
- Don't store the path structure in the digest cache and pass it between
  creation and initialization of the digest cache
- Remove digest_cache_dir_update_dig_user() and keep the digest cache
  retrieved during digest_cache_get()
- Fail with an error pointer in digest_cache_dir_lookup_digest() if the
  current and passed directory digest cache don't match, or the digest
  cache was reset
- Handle num_digest = 0 in digest_cache_htable_init()
- Accept -EOPNOTSUPP error in digest_cache_new()
- Implement inode_free_security_rcu LSM hook instead of inode_free_security
- Move reservation of file descriptor security blob inside the #ifdef in
  init_ima_lsm()
- Add test file_reset_again to check the error pointer returned by
  digest_cache_lookup()
- Remove TLV_FAILURE_HDR_LEN TLV error test
- Add missing MODULE_DESCRIPTION in kselftest kernel module (suggested by
  Jeff Johnson)
- Replace dentry_open() with kernel_file_open() in populate.c and dir.c
- Skip affected tests when CONFIG_DYNAMIC_FTRACE_WITH_ARGS=n

v4:
- Rename digest_cache LSM to Integrity Digest Cache (suggested by Paul
  Moore)
- Update documentation
- Remove forward declaration of struct digest_cache in
  include/linux/digest_cache.h (suggested by Jarkko)
- Add DIGEST_CACHE_FREE digest cache event for notification
- Remove digest_cache_found_t typedef and use uintptr_t instead
- Add header callback in TLV parser and unexport tlv_parse_hdr() and
  tlv_parse_data()
- Plug the Integrity Digest Cache into the 'ima' LSM
- Switch from constructor to zeroing the object cache
- Remove notifier and detect digest cache changes by comparing pointers
- Rename digest_cache_dir_create() to digest_cache_dir_add_entries()
- Introduce digest_cache_dir_create() to create and initialize a directory
  digest cache
- Introduce digest_cache_dir_update_dig_user() to update dig_user with a
  file digest cache on positive digest lookup
- Use up to date directory digest cache, to take into account possible
  inode eviction for the old ones
- Introduce digest_cache_dir_prefetch() to prefetch digest lists
- Adjust component name in debug messages (suggested by Jarkko)
- Add FILE_PREFETCH and FILE_READ digest cache flags, remove RESET_USER
- Reintroduce spin lock for digest cache verification data (needed for the
  selftests)
- Get inode and file descriptor security blob offsets from outside (IMA)
- Avoid user-after-free in digest_cache_unref() by decrementing the ref.
  count after printing the debug message
- Check for digest list lookup loops also for the parent directory
- Put and clear dig_owner directly in digest_cache_reset_clear_owner()
- Move digest cache initialization code from digest_cache_create() to
  digest_cache_init()
- Hold the digest list path until the digest cache is initialized (to avoid
  premature inode eviction)
- Avoid race condition on setting DIR_PREFETCH in the directory digest
  cache
- Introduce digest_cache_dir_prefetch() and do it between digest cache
  creation and initialization (to avoid lock inversion)
- Avoid unnecessary length check in digest_list_parse_rpm()
- Declare arrays of strings in tlv parser as static
- Emit reset for parent directory on directory entry modification
- Rename digest_cache_reset_owner() to digest_cache_reset_clear_owner()
  and digest_cache_reset_user() to digest_cache_clear_user()
- Execute digest_cache_file_release() either if FMODE_WRITE or
  FMODE_CREATED are set in the file descriptor f_mode
- Determine in digest_cache_verif_set() which gfp flag to use depending on
  verifier ID
- Update selftests

v3:
- Rewrite documentation, and remove the installation instructions since
  they are now included in the README of digest-cache-tools
- Add digest cache event notifier
- Drop digest_cache_was_reset(), and send instead to asynchronous
  notifications
- Fix digest_cache LSM Kconfig style issues (suggested by Randy Dunlap)
- Propagate digest cache reset to directory entries
- Destroy per directory entry mutex
- Introduce RESET_USER bit, to clear the dig_user pointer on
  set/removexattr
- Replace 'file content' with 'file data' (suggested by Mimi)
- Introduce per digest cache mutex and replace verif_data_lock spinlock
- Track changes of security.digest_list xattr
- Stop tracking file_open and use file_release instead also for file writes
- Add error messages in digest_cache_create()
- Load/unload testing kernel module automatically during execution of test
- Add tests for digest cache event notifier
- Add test for ftruncate()
- Remove DIGEST_CACHE_RESET_PREFETCH_BUF command in test and clear the
  buffer on read instead

v2:
- Include the TLV parser in this patch set (from user asymmetric keys and
  signatures)
- Move from IMA and make an independent LSM
- Remove IMA-specific stuff from this patch set
- Add per algorithm hash table
- Expect all digest lists to be in the same directory and allow changing
  the default directory
- Support digest lookup on directories, when there is no
  security.digest_list xattr
- Add seq num to digest list file name, to impose ordering on directory
  iteration
- Add a new data type DIGEST_LIST_ENTRY_DATA for the nested data in the
  tlv digest list format
- Add the concept of verification data attached to digest caches
- Add the reset mechanism to track changes on digest lists and directory
  containing the digest lists
- Add kernel selftests

v1:
- Add documentation in Documentation/security/integrity-digest-cache.rst
- Pass the mask of IMA actions to digest_cache_alloc()
- Add a reference count to the digest cache
- Remove the path parameter from digest_cache_get(), and rely on the
  reference count to avoid the digest cache disappearing while being used
- Rename the dentry_to_check parameter of digest_cache_get() to dentry
- Rename digest_cache_get() to digest_cache_new() and add
  digest_cache_get() to set the digest cache in the iint of the inode for
  which the digest cache was requested
- Add dig_owner and dig_user to the iint, to distinguish from which inode
  the digest cache was created from, and which is using it; consequently it
  makes the digest cache usable to measure/appraise other digest caches
  (support not yet enabled)
- Add dig_owner_mutex and dig_user_mutex to serialize accesses to dig_owner
  and dig_user until they are initialized
- Enforce strong synchronization and make the contenders wait until
  dig_owner and dig_user are assigned to the iint the first time
- Move checking IMA actions on the digest list earlier, and fail if no
  action were performed (digest cache not usable)
- Remove digest_cache_put(), not needed anymore with the introduction of
  the reference count
- Fail immediately in digest_cache_lookup() if the digest algorithm is
  not set in the digest cache
- Use 64 bit mask for IMA actions on the digest list instead of 8 bit
- Return NULL in the inline version of digest_cache_get()
- Use list_add_tail() instead of list_add() in the iterator
- Copy the digest list path to a separate buffer in digest_cache_iter_dir()
- Use digest list parsers verified with Frama-C
- Explicitly disable (for now) the possibility in the IMA policy to use the
  digest cache to measure/appraise other digest lists
- Replace exit(<value>) with return <value> in manage_digest_lists.c

Roberto Sassu (15):
  lib: Add TLV parser
  module: Introduce ksys_finit_module()
  integrity: Introduce the Integrity Digest Cache
  digest_cache: Initialize digest caches
  digest_cache: Add securityfs interface
  digest_cache: Add hash tables and operations
  digest_cache: Allow registration of digest list parsers
  digest_cache: Parse tlv digest lists
  digest_cache: Populate the digest cache from a digest list
  digest_cache: Add management of verification data
  digest_cache: Add support for directories
  digest cache: Prefetch digest lists if requested
  digest_cache: Reset digest cache on file/directory change
  selftests/digest_cache: Add selftests for the Integrity Digest Cache
  docs: Add documentation of the Integrity Digest Cache

 Documentation/security/digest_cache.rst       | 850 ++++++++++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  10 +
 include/linux/digest_cache.h                  | 131 +++
 include/linux/kernel_read_file.h              |   1 +
 include/linux/syscalls.h                      |  10 +
 include/linux/tlv_parser.h                    |  32 +
 include/uapi/linux/tlv_digest_list.h          |  47 +
 include/uapi/linux/tlv_parser.h               |  41 +
 include/uapi/linux/xattr.h                    |   6 +
 kernel/module/main.c                          |  43 +-
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   2 +
 lib/tlv_parser.c                              |  87 ++
 lib/tlv_parser.h                              |  18 +
 security/integrity/Kconfig                    |   1 +
 security/integrity/Makefile                   |   1 +
 security/integrity/digest_cache/Kconfig       |  43 +
 security/integrity/digest_cache/Makefile      |  11 +
 security/integrity/digest_cache/dir.c         | 400 +++++++++
 security/integrity/digest_cache/htable.c      | 260 ++++++
 security/integrity/digest_cache/internal.h    | 283 ++++++
 security/integrity/digest_cache/main.c        | 597 ++++++++++++
 security/integrity/digest_cache/modsig.c      |  66 ++
 security/integrity/digest_cache/parsers.c     | 257 ++++++
 security/integrity/digest_cache/parsers/tlv.c | 341 +++++++
 security/integrity/digest_cache/populate.c    | 104 +++
 security/integrity/digest_cache/reset.c       | 227 +++++
 security/integrity/digest_cache/secfs.c       | 104 +++
 security/integrity/digest_cache/verif.c       | 135 +++
 security/integrity/ima/ima.h                  |   1 +
 security/integrity/ima/ima_fs.c               |   6 +
 security/integrity/ima/ima_main.c             |  10 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/digest_cache/.gitignore |   3 +
 tools/testing/selftests/digest_cache/Makefile |  24 +
 .../testing/selftests/digest_cache/all_test.c | 769 ++++++++++++++++
 tools/testing/selftests/digest_cache/common.c |  78 ++
 tools/testing/selftests/digest_cache/common.h |  93 ++
 .../selftests/digest_cache/common_user.c      |  33 +
 .../selftests/digest_cache/common_user.h      |  15 +
 tools/testing/selftests/digest_cache/config   |   2 +
 .../selftests/digest_cache/generators.c       | 130 +++
 .../selftests/digest_cache/generators.h       |  16 +
 .../selftests/digest_cache/testmod/Makefile   |  16 +
 .../selftests/digest_cache/testmod/kern.c     | 551 ++++++++++++
 46 files changed, 5849 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/security/digest_cache.rst
 create mode 100644 include/linux/digest_cache.h
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h
 create mode 100644 security/integrity/digest_cache/Kconfig
 create mode 100644 security/integrity/digest_cache/Makefile
 create mode 100644 security/integrity/digest_cache/dir.c
 create mode 100644 security/integrity/digest_cache/htable.c
 create mode 100644 security/integrity/digest_cache/internal.h
 create mode 100644 security/integrity/digest_cache/main.c
 create mode 100644 security/integrity/digest_cache/modsig.c
 create mode 100644 security/integrity/digest_cache/parsers.c
 create mode 100644 security/integrity/digest_cache/parsers/tlv.c
 create mode 100644 security/integrity/digest_cache/populate.c
 create mode 100644 security/integrity/digest_cache/reset.c
 create mode 100644 security/integrity/digest_cache/secfs.c
 create mode 100644 security/integrity/digest_cache/verif.c
 create mode 100644 tools/testing/selftests/digest_cache/.gitignore
 create mode 100644 tools/testing/selftests/digest_cache/Makefile
 create mode 100644 tools/testing/selftests/digest_cache/all_test.c
 create mode 100644 tools/testing/selftests/digest_cache/common.c
 create mode 100644 tools/testing/selftests/digest_cache/common.h
 create mode 100644 tools/testing/selftests/digest_cache/common_user.c
 create mode 100644 tools/testing/selftests/digest_cache/common_user.h
 create mode 100644 tools/testing/selftests/digest_cache/config
 create mode 100644 tools/testing/selftests/digest_cache/generators.c
 create mode 100644 tools/testing/selftests/digest_cache/generators.h
 create mode 100644 tools/testing/selftests/digest_cache/testmod/Makefile
 create mode 100644 tools/testing/selftests/digest_cache/testmod/kern.c

-- 
2.47.0.118.gfd3785337b


