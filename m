Return-Path: <linux-kselftest+bounces-17257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40C96DD52
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021F6B27F4E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9319E837;
	Thu,  5 Sep 2024 15:06:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10919E827;
	Thu,  5 Sep 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548810; cv=none; b=ZA1OKE3h5AZ+FLNgyuL4G09ylTNsfqc+/Mj6EWo06e20fUqczD8fVrTokMTpX6QefXo34nolwJWjvjXi803Jtf5d2AQ9cxNlUL8skEIWXQfAnxY0R+xb9XggZVJTMzbbCR1v9lR+mwdquMeqMO4a3vHHG4xeNNzZffZYQy74VFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548810; c=relaxed/simple;
	bh=HexUfndJtKlTs4DBTxqhlHBf2aCiiqQ0GWD6DRpuHDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O08yMPE3cgFlmFFj0ViBhd0GrUdFFZf/KWSQAJwwoASinrB66yE/6OTZ5QCaQcwfzXFLQjmSD2aQk21vBb6fZcZ9K4BAiIOi4mv0r1tk5s886kEhummjYJqqUAdPHFQccCuqETMReNoeRrEib+9hkIFZG/TAycHzGhhmXny9J4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02JS43mjz9v7Hk;
	Thu,  5 Sep 2024 22:47:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C2E43140516;
	Thu,  5 Sep 2024 23:06:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S2;
	Thu, 05 Sep 2024 16:06:31 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
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
Subject: [PATCH v5 00/14] integrity: Introduce the Integrity Digest Cache
Date: Thu,  5 Sep 2024 17:05:29 +0200
Message-Id: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S2
X-Coremail-Antispam: 1UD129KBjvAXoW3urykCryDtr47uryDWr15Jwb_yoW8Wr4UXo
	ZYkwsxXw4kKFy3AF4DCFnrAay7W3sYgw1xAr4vvryUZFyfXFyUGa4DCa1DJFy3Zr48Xr97
	Za48Z3yUXFWDtwn3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYa7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF
	7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU0uMKtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK1wAAsW

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

The Integrity Digest Cache is not tied to a specific package format. While
it currently supports a TLV-based and the RPM formats, it can be easily
extended to support more formats, such as DEBs. Focusing on just extracting
digests keeps these parsers minimal and reasonably simple (e.g. the RPM
parser has ~220 LOC). Included parsers have been verified for memory safety
with the Frama-C static analyzer. The parsers with the Frama-C assertions
are available here:

https://github.com/robertosassu/rpm-formal/

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
a TLV-based and RPM data formats, and exposes an API for LSMs to query
them. A separate patch set will be provided to integrate it in IMA.

This patch set and the follow-up IMA integration can be tested by following
the instructions at:

https://github.com/linux-integrity/digest-cache-tools

This patch set applies on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity

with commit fa8a4ce432e8 ("ima: fix buffer overrun in
ima_eventdigest_init_common").

Changelog

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

Roberto Sassu (14):
  lib: Add TLV parser
  integrity: Introduce the Integrity Digest Cache
  digest_cache: Initialize digest caches
  digest_cache: Add securityfs interface
  digest_cache: Add hash tables and operations
  digest_cache: Populate the digest cache from a digest list
  digest_cache: Parse tlv digest lists
  digest_cache: Parse rpm digest lists
  digest_cache: Add management of verification data
  digest_cache: Add support for directories
  digest cache: Prefetch digest lists if requested
  digest_cache: Reset digest cache on file/directory change
  selftests/digest_cache: Add selftests for the Integrity Digest Cache
  docs: Add documentation of the Integrity Digest Cache

 Documentation/security/digest_cache.rst       | 814 ++++++++++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  10 +
 include/linux/digest_cache.h                  |  58 ++
 include/linux/kernel_read_file.h              |   1 +
 include/linux/tlv_parser.h                    |  48 ++
 include/uapi/linux/tlv_digest_list.h          |  72 ++
 include/uapi/linux/tlv_parser.h               |  62 ++
 include/uapi/linux/xattr.h                    |   6 +
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   2 +
 lib/tlv_parser.c                              | 221 +++++
 lib/tlv_parser.h                              |  17 +
 security/integrity/Kconfig                    |   1 +
 security/integrity/Makefile                   |   1 +
 security/integrity/digest_cache/Kconfig       |  33 +
 security/integrity/digest_cache/Makefile      |  11 +
 security/integrity/digest_cache/dir.c         | 397 +++++++++
 security/integrity/digest_cache/htable.c      | 254 ++++++
 security/integrity/digest_cache/internal.h    | 277 ++++++
 security/integrity/digest_cache/main.c        | 559 ++++++++++++
 security/integrity/digest_cache/modsig.c      |  66 ++
 .../integrity/digest_cache/parsers/parsers.h  |  15 +
 security/integrity/digest_cache/parsers/rpm.c | 220 +++++
 security/integrity/digest_cache/parsers/tlv.c | 341 ++++++++
 security/integrity/digest_cache/populate.c    | 157 ++++
 security/integrity/digest_cache/reset.c       | 227 +++++
 security/integrity/digest_cache/secfs.c       | 104 +++
 security/integrity/digest_cache/verif.c       | 131 +++
 security/integrity/ima/ima.h                  |   1 +
 security/integrity/ima/ima_fs.c               |   6 +
 security/integrity/ima/ima_main.c             |  11 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/digest_cache/.gitignore |   3 +
 tools/testing/selftests/digest_cache/Makefile |  24 +
 .../testing/selftests/digest_cache/all_test.c | 749 ++++++++++++++++
 tools/testing/selftests/digest_cache/common.c |  78 ++
 tools/testing/selftests/digest_cache/common.h | 134 +++
 .../selftests/digest_cache/common_user.c      |  47 +
 .../selftests/digest_cache/common_user.h      |  17 +
 tools/testing/selftests/digest_cache/config   |   1 +
 .../selftests/digest_cache/generators.c       | 248 ++++++
 .../selftests/digest_cache/generators.h       |  19 +
 .../selftests/digest_cache/testmod/Makefile   |  16 +
 .../selftests/digest_cache/testmod/kern.c     | 501 +++++++++++
 45 files changed, 5964 insertions(+), 1 deletion(-)
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
 create mode 100644 security/integrity/digest_cache/parsers/parsers.h
 create mode 100644 security/integrity/digest_cache/parsers/rpm.c
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
2.34.1


