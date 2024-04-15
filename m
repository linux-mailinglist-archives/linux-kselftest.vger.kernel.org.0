Return-Path: <linux-kselftest+bounces-7988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7948A556C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0775E1F22AC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CA433C9;
	Mon, 15 Apr 2024 14:44:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B121D52B;
	Mon, 15 Apr 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192254; cv=none; b=kyWL+NloTl6CAKcSc7+j/wcUfLcShp+ARNSPxWQp3VwY1iU9z6n9ZoHNa1sj/FVofQfucQ4IrBMqz2K6Na6sGVJDD6MSGuP5QYGgpqypmf40K1I36L7IxbXLm0oIA4SMUA8/Q1mnX8CHCmbrzh+SurViI6KagVx4W+rdL4wWb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192254; c=relaxed/simple;
	bh=6HcZNB2GKTsycYKJe1NGj3TZRbra4cpuJ4EXp3SFi0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vmiax9pfoSvE5YL+CkAKGXUHFZCJ/gOgz+gNPJOpOKCxZ3E51UWgSAey6pBbaZ7xDvI0aqoeNiIdwwgTljSPoD8p1dr+9VhvEwbTBWTNyzuguoek7c1CtS9QL7KwMFn+QFXCylzQaOEAXMqm+xKWmW09GHbdbt1pCpuO3p3hGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJ86p2SThz9v7Jj;
	Mon, 15 Apr 2024 22:04:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 783A7140801;
	Mon, 15 Apr 2024 22:25:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S2;
	Mon, 15 Apr 2024 15:25:00 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org,
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
Subject: [PATCH v4 00/14] security: digest_cache LSM
Date: Mon, 15 Apr 2024 16:24:22 +0200
Message-Id: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4rXFy5tw4UZF4DWw43GFg_yoWfKr1xp3
	ykC3W5Kws5ZFy7Aw4xAF129r1Fqa95KF47Gws7Xr13ZrWYqryFy3WIkw17Zry3XrWUXa1S
	vw47KF15Ww1DJaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU0NzVUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h0qAABs8

From: Roberto Sassu <roberto.sassu@huawei.com>

Integrity detection and protection has long been a desirable feature, to
reach a large user base and mitigate the risk of flaws in the software
and attacks.

However, while solutions exist, they struggle to reach the large user
base, due to requiring higher than desired constraints on performance,
flexibility and configurability, that only security conscious people are
willing to accept.

This is where the new digest_cache LSM comes into play, it offers
additional support for new and existing integrity solutions, to make
them faster and easier to deploy.

The full documentation with the motivation and the solution details can be
found in patch 14.

The IMA integration patch set will be introduced separately. Also a PoC
based on the current version of IPE can be provided.

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
  security: Introduce the digest_cache LSM
  digest_cache: Add securityfs interface
  digest_cache: Add hash tables and operations
  digest_cache: Populate the digest cache from a digest list
  digest_cache: Parse tlv digest lists
  digest_cache: Parse rpm digest lists
  digest_cache: Add management of verification data
  digest_cache: Add support for directories
  digest cache: Prefetch digest lists if requested
  digest_cache: Reset digest cache on file/directory change
  digest_cache: Notify digest cache events
  selftests/digest_cache: Add selftests for digest_cache LSM
  docs: Add documentation of the digest_cache LSM

 Documentation/security/digest_cache.rst       | 763 ++++++++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  16 +
 include/linux/digest_cache.h                  | 117 +++
 include/linux/kernel_read_file.h              |   1 +
 include/linux/tlv_parser.h                    |  28 +
 include/uapi/linux/lsm.h                      |   1 +
 include/uapi/linux/tlv_digest_list.h          |  72 ++
 include/uapi/linux/tlv_parser.h               |  59 ++
 include/uapi/linux/xattr.h                    |   6 +
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   3 +
 lib/tlv_parser.c                              | 214 +++++
 lib/tlv_parser.h                              |  17 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/digest_cache/Kconfig                 |  33 +
 security/digest_cache/Makefile                |  11 +
 security/digest_cache/dir.c                   | 252 ++++++
 security/digest_cache/htable.c                | 268 ++++++
 security/digest_cache/internal.h              | 290 +++++++
 security/digest_cache/main.c                  | 570 ++++++++++++
 security/digest_cache/modsig.c                |  66 ++
 security/digest_cache/notifier.c              | 135 +++
 security/digest_cache/parsers/parsers.h       |  15 +
 security/digest_cache/parsers/rpm.c           | 223 +++++
 security/digest_cache/parsers/tlv.c           | 299 +++++++
 security/digest_cache/populate.c              | 163 ++++
 security/digest_cache/reset.c                 | 235 +++++
 security/digest_cache/secfs.c                 |  87 ++
 security/digest_cache/verif.c                 | 119 +++
 security/security.c                           |   3 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/digest_cache/.gitignore |   3 +
 tools/testing/selftests/digest_cache/Makefile |  24 +
 .../testing/selftests/digest_cache/all_test.c | 815 ++++++++++++++++++
 tools/testing/selftests/digest_cache/common.c |  78 ++
 tools/testing/selftests/digest_cache/common.h | 135 +++
 .../selftests/digest_cache/common_user.c      |  47 +
 .../selftests/digest_cache/common_user.h      |  17 +
 tools/testing/selftests/digest_cache/config   |   1 +
 .../selftests/digest_cache/generators.c       | 248 ++++++
 .../selftests/digest_cache/generators.h       |  19 +
 .../selftests/digest_cache/testmod/Makefile   |  16 +
 .../selftests/digest_cache/testmod/kern.c     | 564 ++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 46 files changed, 6047 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/security/digest_cache.rst
 create mode 100644 include/linux/digest_cache.h
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h
 create mode 100644 security/digest_cache/Kconfig
 create mode 100644 security/digest_cache/Makefile
 create mode 100644 security/digest_cache/dir.c
 create mode 100644 security/digest_cache/htable.c
 create mode 100644 security/digest_cache/internal.h
 create mode 100644 security/digest_cache/main.c
 create mode 100644 security/digest_cache/modsig.c
 create mode 100644 security/digest_cache/notifier.c
 create mode 100644 security/digest_cache/parsers/parsers.h
 create mode 100644 security/digest_cache/parsers/rpm.c
 create mode 100644 security/digest_cache/parsers/tlv.c
 create mode 100644 security/digest_cache/populate.c
 create mode 100644 security/digest_cache/reset.c
 create mode 100644 security/digest_cache/secfs.c
 create mode 100644 security/digest_cache/verif.c
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


