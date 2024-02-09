Return-Path: <linux-kselftest+bounces-4432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084084F695
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39401287890
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF766B56;
	Fri,  9 Feb 2024 14:10:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C950247;
	Fri,  9 Feb 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487802; cv=none; b=FgjVuS4M/MMWVG0hfxuXZfPSO5kNOnHnNirpOvJ4vkFqohYiF5t5sAehxf0NKunxVgG/DgC7+ErBRHr53d9fQa2fRwRnrsECUUJ2BBZv5+MIc8dMHjMDfZ6EqJbjr928cmi/OnopIz9bVWNYp6aZDH9AQ7RAzcTVakyOSkzmvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487802; c=relaxed/simple;
	bh=wHqtCB1+eY06rNvuDYjVH1ShRhuhIJK5Cw5NsSHbMnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WY0qZvH9kAnusEPD28XC6N08Nyr9QKPpPYxILlWcIjlky6V+9xqS2NaoFdGEx/BIt9BUX5IVyW+Ai63X8g6Isi7sUIBYRaJslez2jp9Shzj84L+pxZQ6FmbdBCFVNPyPU8fKIczfLR3+H+I20riLlEuazTdUerd78sLSU2P2Bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TWZxs32hlz9xFmM;
	Fri,  9 Feb 2024 21:50:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E9AAA14068B;
	Fri,  9 Feb 2024 22:09:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S2;
	Fri, 09 Feb 2024 15:09:45 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
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
	petrtesarik@huaweicloud.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 00/13] security: digest_cache LSM
Date: Fri,  9 Feb 2024 15:09:04 +0100
Message-Id: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykCrWxGr1ruF4UuF4rXwb_yoWfAFyxp3
	97C3W5Kws5ZFy7Aw4fA3W29F1rt395KF47Gw4fXr13ZrW5XryFy3WIkw17Zry3XrW8Xa1S
	yw47Kr15Ww1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
	WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7sRiuWl3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y4VwACsE

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the digest_cache LSM, whose purpose is to deliver reference
digest values to integrity providers, such as IMA and IPE, abstracting to
them how those digests where extracted from the respective data source.

The major benefit is the ability to use the vaste amount of digests already
provided (and likely signed) by software vendors, without needing them to
adapt their format to the one understood by the integrity provider.

IMA and IPE can immediately interface with the digest_cache LSM and query
the digest of an accessed file. If the digest is found, it means that the
file is coming from the software vendor and not modified. If not, the file
might have been corrupted. Each integrity provider decides how to handle
this situation.

The second major benefit is performance improvement. Since the digest_cache
LSM has the ability to extract many digests from a single data source, it
means that it has less signatures to verify compared to the approach of
verifying individual file signatures (IMA appraisal). Preliminary tests
have shown a speedup of IMA appraisal of about 65% for sequential read, and
45% for parallel read.

This patch set has as prerequisites the file_release LSM hook (to be
introduced with the move of IMA/EVM to the LSM infrastructure), and
support for PGP keys, which is still unclear how it should be done.

The IMA integration patch set will be introduced separately. Also a PoC
based on the current version of IPE can be provided.

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

Roberto Sassu (13):
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
  selftests/digest_cache: Add selftests for digest_cache LSM
  docs: Add documentation of the digest_cache LSM

 Documentation/security/digest_cache.rst       | 900 ++++++++++++++++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  16 +
 include/linux/digest_cache.h                  |  89 ++
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
 security/digest_cache/Kconfig                 |  34 +
 security/digest_cache/Makefile                |  11 +
 security/digest_cache/dir.c                   | 245 +++++
 security/digest_cache/htable.c                | 268 ++++++
 security/digest_cache/internal.h              | 259 +++++
 security/digest_cache/main.c                  | 545 +++++++++++
 security/digest_cache/modsig.c                |  66 ++
 security/digest_cache/parsers/parsers.h       |  15 +
 security/digest_cache/parsers/rpm.c           | 223 +++++
 security/digest_cache/parsers/tlv.c           | 299 ++++++
 security/digest_cache/populate.c              | 163 ++++
 security/digest_cache/reset.c                 | 168 ++++
 security/digest_cache/secfs.c                 |  87 ++
 security/digest_cache/verif.c                 | 119 +++
 security/security.c                           |   3 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/digest_cache/.gitignore |   3 +
 tools/testing/selftests/digest_cache/Makefile |  23 +
 .../testing/selftests/digest_cache/all_test.c | 706 ++++++++++++++
 tools/testing/selftests/digest_cache/common.c |  79 ++
 tools/testing/selftests/digest_cache/common.h | 131 +++
 .../selftests/digest_cache/common_user.c      |  47 +
 .../selftests/digest_cache/common_user.h      |  17 +
 tools/testing/selftests/digest_cache/config   |   1 +
 .../selftests/digest_cache/generators.c       | 248 +++++
 .../selftests/digest_cache/generators.h       |  19 +
 .../selftests/digest_cache/testmod/Makefile   |  16 +
 .../selftests/digest_cache/testmod/kern.c     | 499 ++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 45 files changed, 5714 insertions(+), 6 deletions(-)
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


