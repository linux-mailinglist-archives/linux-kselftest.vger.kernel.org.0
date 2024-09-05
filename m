Return-Path: <linux-kselftest+bounces-17270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A3E96DDA2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BAA1F27A88
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F921A08CC;
	Thu,  5 Sep 2024 15:10:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2851A08B2;
	Thu,  5 Sep 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549059; cv=none; b=SGFbyzoYdBu9jfboaa13K1LYdIia5IVuMDx0mOlHT0oN2sibWo6Bcy8KWr4zzFJfmBS5aH4Z5oMwflZn4nf1A0V82ltL9JXGG22RR7NgZB+5krcfsXpm6tUt8jiW80vQOKL9RkcZscmqIJPmgQX38LBmtq4g2J2+ZuFOYlqdoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549059; c=relaxed/simple;
	bh=aJkgwPhC90LW1cXOrVZ/XvQ8x/SQukH5El0EYGphG8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVtyinGRJ8DTj1WvZUzarYF0QdSEoW+lnyWbQHN5Dn8eEUSLiPrJkhlSwDSsdRQCyJl+qREMH4ZEi1uxgSvqbqnbIPh0QmqKY4mccqE/oN7ge8OJAnugPIdZvO25r0xaDEuySsH14l5cNYFYoNZeMBNw1QxJ7z60L+dUZ99h0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02PK75Vrz9v7NP;
	Thu,  5 Sep 2024 22:51:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6474E141017;
	Thu,  5 Sep 2024 23:10:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHmTCzydlmEFVUAA--.29644S6;
	Thu, 05 Sep 2024 16:10:48 +0100 (CET)
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
Subject: [PATCH v5 14/14] docs: Add documentation of the Integrity Digest Cache
Date: Thu,  5 Sep 2024 17:05:43 +0200
Message-Id: <20240905150543.3766895-15-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHmTCzydlmEFVUAA--.29644S6
X-Coremail-Antispam: 1UD129KBjvAXoWfCFWrGFWkCFW3Kw1Utr4xWFg_yoW5KrW3to
	ZY9w4Yyw15KF15AF48AFnrJryUW3sYgwn7AF1vgr45WF10qFW5Ja4DC3WUGFW3Jr4rGwnr
	A348J39rJF1Utrn3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO27kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIev
	Ja73UjIFyTuYvjxUBTmhUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK6wABsr

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of the Integrity Digest Cache in
Documentation/security.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_cache.rst | 814 ++++++++++++++++++++++++
 Documentation/security/index.rst        |   1 +
 MAINTAINERS                             |   2 +
 3 files changed, 817 insertions(+)
 create mode 100644 Documentation/security/digest_cache.rst

diff --git a/Documentation/security/digest_cache.rst b/Documentation/security/digest_cache.rst
new file mode 100644
index 000000000000..ddc33e672090
--- /dev/null
+++ b/Documentation/security/digest_cache.rst
@@ -0,0 +1,814 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Integrity Digest Cache
+======================
+
+Introduction
+============
+
+Integrity detection and protection has long been a desirable feature, to
+reach a large user base and mitigate the risk of flaws in the software
+and attacks.
+
+However, while solutions exist, they struggle to reach a large user base,
+due to requiring higher than desired constraints on performance,
+flexibility and configurability, that only security conscious people are
+willing to accept.
+
+For example, IMA measurement requires the target platform to collect
+integrity measurements, and to protect them with the TPM, which introduces
+a noticeable overhead (up to 10x slower in a microbenchmark) on frequently
+used system calls, like the open().
+
+IMA Appraisal currently requires individual files to be signed and
+verified, and Linux distributions to rebuild all packages to include file
+signatures (this approach has been adopted from Fedora 39+). Like a TPM,
+also signature verification introduces a significant overhead, especially
+if it is used to check the integrity of many files.
+
+This is where the new Integrity Digest Cache comes into play, it offers
+additional support for new and existing integrity solutions, to make
+them faster and easier to deploy.
+
+The Integrity Digest Cache can help IMA to reduce the number of TPM
+operations and to make them happen in a deterministic way. If IMA knows
+that a file comes from a Linux distribution, it can measure files in a
+different way: measure the list of digests coming from the distribution
+(e.g. RPM package headers), and subsequently measure a file if it is not
+found in that list.
+
+The performance improvement comes at the cost of IMA not reporting which
+files from installed packages were accessed, and in which temporal
+sequence. This approach might not be suitable for all use cases.
+
+The Integrity Digest Cache can also help IMA for appraisal. IMA can simply
+lookup the calculated digest of an accessed file in the list of digests
+extracted from package headers, after verifying the header signature. It is
+sufficient to verify only one signature for all files in the package, as
+opposed to verifying a signature for each file.
+
+The same approach can be followed by other LSMs, such as Integrity Policy
+Enforcement (IPE), and BPF LSM.
+
+The Integrity Digest Cache is not tied to a specific package format. While
+it currently supports a TLV-based and the RPM formats, it can be easily
+extended to support more formats, such as DEBs. Focusing on just extracting
+digests keeps these parsers minimal and reasonably simple (e.g. the RPM
+parser has ~220 LOC). Included parsers have been verified for memory safety
+with the Frama-C static analyzer. The parsers with the Frama-C assertions
+are available here:
+
+https://github.com/robertosassu/rpm-formal/
+
+Integrating the Integrity Digest Cache in IMA brings significant
+performance improvements: up to 67% and 79% for measurement respectively in
+sequential and parallel file reads; up to 65% and 43% for appraisal
+respectively in sequential and parallel file reads.
+
+The performance can be further enhanced by using fsverity digests instead
+of conventional file digests, which would make IMA verify only the portion
+of the file to be read. However, at the moment, fsverity digests are not
+included in RPM packages. In this case, once rpm is extended to include
+them, Linux distributions still have to rebuild their packages.
+
+The Integrity Digest Cache can support both digest types, so that the
+functionality is immediately available without waiting for Linux
+distributions to do the transition.
+
+
+Design
+======
+
+Main idea
+---------
+
+The Integrity Digest Cache extracts digests from a file, referred to as a
+digest list, and stores them in kernel memory in a structure named
+digest_cache.
+
+The digest_cache structure contains a set of per algorithm hash tables,
+where digests are stored, the digest list pathname, a reference counter,
+and the integrity state of the digest list.
+
+If a digest cache is created from a directory, its hash tables are empty
+and instead it contains a snapshot of the directory entries discovered with
+iterate_dir().
+
+The integrity state of digest caches created from regular files, also
+called verification data, is evaluated independently by LSMs, for example
+by verifying the signature of the digest list, and is provided to the
+Integrity Digest Cache through a dedicated API.
+
+The extracted digests can be used as reference values initially for
+integrity verification of file data and at a later stage for integrity
+verification of file metadata.
+
+The Integrity Digest Cache can extract digests from a digest list, provided
+that it has a parser for its format.
+
+
+Caching and reference counting
+------------------------------
+
+Creating a digest cache every time it is requested would introduce an
+unnecessary overhead, due to repeating the same operation. For this reason,
+the Integrity Digest Cache reserves space in the inode security blob
+(through IMA) and stores two types of digest cache reference.
+
+If the digest cache was created from the same inode, the Integrity Digest
+Cache stores in the inode security blob a reference called dig_owner,
+because the inode owns the content.
+
+If the digest cache was requested for verifying an inode, the Integrity
+Digest Cache stores a reference called dig_user, because the inode is a
+user of the digest cache.
+
+An inode can have both types of reference set, if it is a digest list
+to be verified with another digest list.
+
+Check and assignemt of dig_owner and dig_user is protected respectively
+with the dig_owner_mutex and dig_user_mutex mutexes.
+
+The digest cache reference count tracks how many references have been made
+to that digest cache (whether that reference is stored in the inode
+security blob, or is returned to a user of the Integrity Digest Cache).
+
+Only when the reference count reaches zero, i.e. all references have been
+released, the digest cache can be freed.
+
+
+Digest cache lifecycle
+----------------------
+
+Digest cache request
+~~~~~~~~~~~~~~~~~~~~
+
+The first step in order to query a digest from a digest list is to request
+a digest cache, by calling digest_cache_get(). The Integrity Digest Cache
+takes care of the digest cache creation and initialization processes,
+transparently to the caller.
+
+The caller passes as argument to digest_cache_get() the inode that the
+caller intends to verify. The Integrity Digest Cache first sees if there
+is a cached digest cache in that inode (dig_user reference). If there is,
+it immediately returns the digest cache with the reference count increased,
+since the reference is returned to the caller.
+
+Otherwise, it will perform the necessary steps (below) to obtain one.
+
+
+Digest list lookup
+~~~~~~~~~~~~~~~~~~
+
+In order to build a digest cache and return it to the caller for performing
+a query, the Integrity Digest Cache must know which digest list to use.
+There are a few alternatives.
+
+(1) There is only one digest list and its path is specified as default
+location at build-time in the kernel configuration or at run-time through
+securityfs. The Integrity Digest Cache builds a single digest cache from
+that digest list and returns it to the caller.
+
+(2) The default location is a directory containing multiple digest lists.
+Unlike (1), the Integrity Digest Cache does not know which digest list to
+select, and creates a directory digest cache with a snapshot of the
+directory entries. During a query, the Integrity Digest Cache iteratively
+creates a digest cache for each directory entry and searches for the digest
+until there is a match.
+
+(3) Same as (2), but the digest list file name is stored as value of the
+new security.digest_list xattr in the inode for which the digest cache is
+requested. The Integrity Digest Cache can directly retrieve the digest list
+using the default directory as the base path and the xattr value as last
+path component.
+
+(4) Similar to (3), but the Integrity Digest Cache still creates a
+directory digest cache like in (2). Then, it only reads the digest list if
+the directory entry file name does not match the security.digest_list
+xattr, to trigger a measurement or, otherwise, creates a digest cache from
+the matching one. This is also known as the prefetching mechanism,
+introduced later.
+
+
+Digest cache creation
+~~~~~~~~~~~~~~~~~~~~~
+
+Once the Integrity Digest Cache selected the digest list to use, it looks
+up the digest list inode through the VFS, verifies whether in the inode
+security blob there is already a digest cache reference (dig_owner).
+
+If there is, it returns that to digest_cache_get() with the reference count
+increased, which in turn will store it in dig_user and will increment the
+reference count again before returning to the caller.
+
+If there isn't, it creates a new digest cache and performs the same steps
+as if dig_owner exists.
+
+
+Digest cache initialization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The digest cache creation does not include initialization and adding the
+digests. It cannot be done inside the dig_owner_mutex and dig_user_mutex,
+to avoid lock inversion with the inode lock done by the VFS.
+
+Digest cache initialization is done by digest_cache_get() by
+calling digest_cache_init(), after releasing the dig_user_mutex. Any
+digest_cache_get() caller can potentially initialize a digest cache.
+
+To avoid multiple initialization attempts, callers atomically test and set
+the INIT_STARTED atomic flag. The first seeing the flag cleared is the one
+in charge of the initialization. The other callers wait for another atomic
+flag, INIT_IN_PROGRESS to be cleared to zero (it is set to one on digest
+cache creation).
+
+Failures during initialization can be detected by checking the INVALID flag
+in the digest cache and, in this case, the digest cache is not returned to
+the caller of digest_cache_get().
+
+
+Digest list naming convention
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The digest_cache_get() caller performing the digest cache initialization
+reads the digest list and calls the appropriate parser to extract the
+digests, based on the file name prefix.
+
+The expected digest list file name format is::
+
+ <digest list format>-<file name>
+
+where format can be for example ``tlv`` or ``rpm``, which make the
+Integrity Digest Cache call respectively the TLV or RPM parser.
+
+Alternatively, also the following format is supported::
+
+ <seq num>-<digest list format>-<file name>
+
+``<seq num>-`` defines how directory entries should be ordered in the
+directory digest cache. If present, directory entries are ordered in
+ascending way by that number.
+
+
+Digest list parsing
+^^^^^^^^^^^^^^^^^^^
+
+The selected digest list parser first calls digest_cache_htable_init() to
+create the hash tables in the digest cache, once for each hash algorithm
+of the digests to be added. digest_cache_htable_init() accepts as parameter
+the number of digests to add, usually known before adding digests.
+
+The number of hash table slots is determined by dividing the number of
+digests to add by the desired average collision depth. The latter can be
+changed in the kernel configuration, to have a different tradeoff between
+digest lookup speed and memory occupation.
+
+The parser then calls digest_cache_htable_add(), to add extracted digests
+to the new hash tables. It can also call digest_cache_htable_lookup() to
+check for duplicate digests.
+
+Directory digest cache
+^^^^^^^^^^^^^^^^^^^^^^
+
+If the digest list location is a directory, digest_cache_init() calls
+digest_cache_dir_add_entries(), which in turn calls iterate_dir() to
+get the current directory entries and to add them to a linked list.
+
+When a digest is looked up on a directory digest cache,
+digest_cache_dir_lookup_digest() will create a regular digest cache for
+each directory entry and will lookup into it until it finds the digest.
+
+digest_cache_dir_lookup_digest() also gets a digest cache reference for
+each directory entry, so that digest lookup is faster at the next call.
+
+
+Digest lookup
+~~~~~~~~~~~~~
+
+After a caller of digest_cache_get() obtains the desired digest cache, it
+can perform operations on it. The most important operation is querying for
+a digest, which can be performed by calling digest_cache_lookup().
+
+digest_cache_lookup() returns a numeric reference (uintptr_t type),
+representing the digest cache containing the queried digest. It is not a
+pointer, to avoid it being accidentally passed to digest_cache_put().
+
+If digest_cache_get() returned a directory digest cache,
+digest_cache_lookup() cannot directly perform the search, since its hash
+tables are empty. Instead, it calls digest_cache_dir_lookup_digest(),
+which searches the digest in the digest cache of each directory entry.
+
+digest_cache_dir_lookup_digest(), if it finds a digest in a directory
+digest cache, it calls digest_cache_dir_update_dig_user() to update
+dig_user of the inode, whose digest is queried, with the digest cache
+containing the digest. This ensures that next time digest_cache_get() is
+called for the same inode, the digest is searched in the right digest
+cache, instead of repeating the search in each directory entry.
+
+
+Verification data
+~~~~~~~~~~~~~~~~~
+
+Until now, the caller of the Integrity Digest Cache is assumed to always
+trust the returned digest cache from being created from authentic data. Or,
+there are security measures in place but not able to correlate reading a
+digest list with building a digest cache from it.
+
+The Integrity Digest Cache introduces a new mechanism for integrity
+providers to store verification data, i.e. their evaluation result of a
+digest list. It also allows callers of digest_cache_get() to later retrieve
+that information and decide whether or not they should use that digest
+cache.
+
+It achieves that by reserving space in the file descriptor security blob,
+and by setting the digest cache pointer in the digest list file descriptor
+before the digest list is read by the kernel.
+
+Integrity providers should implement the kernel_post_read_file LSM hook and
+call digest_cache_verif_set(), passing the same digest list file descriptor
+on which the digest cache pointer was set, their unique ID and their
+evaluation result of the digest list.
+
+The Integrity Digest Cache supports multiple integrity providers at the
+same time, since multiple LSMs can implement the kernel_post_read_file LSM
+hook. Each provider is expected to choose an unique ID, so that the
+verification data can be given back through the same ID.
+
+Callers of digest_cache_get() can call digest_cache_verif_get() to get
+the verification data, passing the returned digest cache pointer and the
+desired integrity provider ID. However, if the digest cache returned was
+created from a directory, that call results in a NULL pointer, since the
+directory digest cache is not populated from any digest list.
+
+In that case, those callers have to call digest_cache_lookup() to get the
+numeric reference of the digest cache containing the digest (thus populated
+from a digest list), and pass it to digest_cache_verif_get() after casting
+the value to a digest cache pointer.
+
+
+Tracking digest cache changes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After a digest cache has been built and its pointer has been set in the
+inode security blob, it might happen that there are changes in the digest
+lists, in the default directory and in the value of the
+security.digest_list xattr.
+
+All these changes may influence which digest cache is returned to callers
+of digest_cache_get() and which digests in the digest cache might be
+searched.
+
+The Integrity Digest Cache monitors such changes by registering to multiple
+LSM hooks (path_truncate, file_release, inode_unlink, inode_rename,
+inode_post_setxattr and inode_post_removexattr). Except for the last two,
+it accesses the dig_owner pointer in the affected inode security blob, sets
+the RESET bit, puts the digest cache and clears dig_owner itself.
+
+The next time that digest cache is requested with digest_cache_get(), also
+dig_user is put and cleared. The same happens in
+digest_cache_dir_lookup_digest(), where the digest cache of a directory
+entry is released and cleared as well. After a reset, a new digest cache is
+created and returned, as if there wasn't one in the first place.
+
+For the last two hooks, when the security.digest_list xattr is modified,
+dig_user is cleared so that at the next digest_cache_get() call a new
+digest cache is retrieved, since the location of the digest list might have
+changed.
+
+Nothing changes for previous callers of digest_cache_get(), since they
+still hold the old digest cache pointer, despite that has been replaced in
+the inode security blobs. The old digest cache pointer will be still valid
+until the callers decide to release that digest cache.
+
+
+Security decision update after digest cache changes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+While new calls to digest_cache_get() result in a new digest cache to be
+returned, resetting the previous digest cache does not reflect in a reset
+of possibly cached security decisions by users of the Integrity Digest
+Cache.
+
+One possible way for those users to become aware of a digest cache change
+is to store the digest cache pointer they used for a security decision, to
+call digest_cache_get() again during a new file access and to compare the
+two pointers. The previous pointer remains valid until the digest cache
+is released.
+
+IMA stores the current digest cache pointer in its managed metadata. At
+every file access, it calls digest_cache_get() again and compares the
+returned pointer with the one previously stored. If the pointers are the
+same, IMA continues to use the previous evaluation result. If not, it
+performs the evaluation again.
+
+The cost of this check is very small. In the case where the digest cache
+didn't change since the last digest_cache_get(), the cost is to check if
+the dig_user pointer is not NULL, and to increment and decrement the digest
+cache reference count.
+
+In terms of memory, this solution requires IMA to store an additional
+pointer in its metadata.
+
+
+Prefetching mechanism
+~~~~~~~~~~~~~~~~~~~~~
+
+One of the objectives of the Integrity Digest Cache is to make a TPM PCR
+predictable, by having digest lists measured in a deterministic order.
+Without the prefetching mechanism, digest lists are measured in a
+non-deterministic order, since the inodes for which a digest cache can be
+requested are accessed in a non-deterministic order too.
+
+The prefetching mechanism, when enabled by setting the new
+security.dig_prefetch xattr to 1, forces digest lists to be looked up by
+their file name in the digest cache created for the parent directory.
+
+The predictability of the PCR is ensured by reading both matching and
+non-matching digest lists during the search, so that integrity providers
+can measure them, and by only creating a digest cache for the matching one.
+In this way, it does not matter if a digest list later in the list of
+directory entries is requested before a earlier one, since all digest lists
+until that point are measured anyway.
+
+However, while this mechanism ensures predictability of the PCR, it could
+also introduce significant latencies, especially if the matching digest
+list is very late in the list of directory entries. Before a digest cache
+is returned from that digest list, hundreds or thousands of digest lists
+could have to be read first.
+
+Then, the ``[<seq num>-]`` prefix in the digest list file name comes at
+hand, since it determines the order of directory entries in the directory
+digest cache (entries with lower seq nums are before entries with higher
+seq nums). Digest lists without that prefix are added at the end of the
+directory entries list, in the same order as iterate_dir() shows them.
+
+Boot performance can be greatly improved by looking at the IMA measurement
+list and by seeing in which order digest lists are requested at boot. Then,
+``[<seq num>-]`` can be appended to directory entries depending on their
+position in the measurement list.
+
+While digest lists can be requested in a slightly different order due to
+the non-deterministic access to inodes, the differences should be minimal,
+causing only fewer extra digest lists to be read before the right one is
+found.
+
+Ordering directory entries can also improve digest queries requiring
+iteration on all digest lists in the default directory. If directory
+entries are ordered by their appearance in the IMA measurement list, a
+digest is found faster because most likely it is searched in the same
+order as when the IMA measurement list was recorded, and thus its
+digest list comes earlier than the others in the list of the directory
+entries of the directory digest cache.
+
+
+Release a digest cache
+~~~~~~~~~~~~~~~~~~~~~~
+
+The Integrity Digest Cache uses the reference count mechanism to ensure
+that a digest cache does not simply disappear when someone is using it.
+
+Either when an inode is evicted from memory, or a caller of
+digest_cache_get() finished to use a digest cache, they should call
+digest_cache_put() to signal to the Integrity Digest Cache that they are no
+longer interested in that digest cache and that it can be eventually freed.
+
+A digest cache is freed when all digest cache users called
+digest_cache_put(), and the reference count reached the value zero.
+
+
+Formal verification of concurrency
+==================================
+
+The Integrity Digest Cache has been designed to work in a heavily concurrent
+environment, where code can be executed as a follow up of a VFS operation,
+or upon a direct request by a user of the Integrity Digest Cache.
+
+For this reason, a sound locking mechanism is necessary to protect data
+structures against concurrent accesses.
+
+The first verification of the locking mechanism was done with the in-kernel
+lockdep, which can detect potential deadlocks and unsafe usage of the
+locking primitives.
+
+There is an ongoing verification with a tool named Dartagnan, reachable at
+the following URL:
+
+https://github.com/hernanponcedeleon/Dat3M
+
+This verification required porting the Integrity Digest Cache to user
+space, and to simulate concurrent requests through the pthread library.
+
+Dartagnan explores all thread interleavings and checks for data races. In
+addition to lockdep, it can also spot for example improperly guarded
+variables.
+
+
+Data structures and API
+=======================
+
+Data structures
+---------------
+
+These are the data structures defined and used internally by the
+Integrity Digest Cache.
+
+.. kernel-doc:: security/integrity/digest_cache/internal.h
+
+
+Public API
+----------
+
+This API is meant to be used by users of the Integrity Digest Cache.
+
+.. kernel-doc:: security/integrity/digest_cache/main.c
+		:identifiers: digest_cache_get digest_cache_put
+
+.. kernel-doc:: security/integrity/digest_cache/htable.c
+		:identifiers: digest_cache_lookup
+
+.. kernel-doc:: security/integrity/digest_cache/verif.c
+		:identifiers: digest_cache_verif_set digest_cache_verif_get
+
+
+Parser API
+----------
+
+This API is meant to be used by digest list parsers.
+
+.. kernel-doc:: security/integrity/digest_cache/htable.c
+		:identifiers: digest_cache_htable_init
+		              digest_cache_htable_add
+			      digest_cache_htable_lookup
+
+
+Digest list formats
+===================
+
+tlv
+---
+
+The Type-Length-Value (TLV) format was chosen for its extensibility.
+Additional fields can be added without breaking compatibility with old
+versions of the parser.
+
+The layout of a tlv digest list is the following::
+
+ [header: DIGEST_LIST_FILE, num fields, total len]
+ [field: DIGEST_LIST_ALGO, length, value]
+ [field: DIGEST_LIST_ENTRY#1, length, value (below)]
+  |- [header: DIGEST_LIST_ENTRY_DATA, num fields, total len]
+  |- [DIGEST_LIST_ENTRY_DIGEST#1, length, file digest]
+  |- [DIGEST_LIST_ENTRY_PATH#1, length, file path]
+ [field: DIGEST_LIST_ENTRY#N, length, value (below)]
+  |- [header: DIGEST_LIST_ENTRY_DATA, num fields, total len]
+  |- [DIGEST_LIST_ENTRY_DIGEST#N, length, file digest]
+  |- [DIGEST_LIST_ENTRY_PATH#N, length, file path]
+
+DIGEST_LIST_ALGO is a field to specify the algorithm of the file digest.
+DIGEST_LIST_ENTRY is a nested TLV structure with the following fields:
+DIGEST_LIST_ENTRY_DIGEST contains the file digest; DIGEST_LIST_ENTRY_PATH
+contains the file path.
+
+
+rpm
+---
+
+The rpm digest list is basically a subset of the RPM package header.
+Its format is::
+
+ [RPM magic number]
+ [RPMTAG_IMMUTABLE]
+
+RPMTAG_IMMUTABLE is a section of the full RPM header containing the part
+of the header that was signed, and whose signature is stored in the
+RPMTAG_RSAHEADER section.
+
+
+Appended signature
+------------------
+
+Digest lists can have a module-style appended signature, that can be used
+for appraisal with IMA. The signature type can be PKCS#7, as for kernel
+modules, or a different type.
+
+
+History
+=======
+
+The original name of this work was IMA Digest Lists, which was somehow
+considered too invasive. The code was moved to a separate component named
+DIGLIM (DIGest Lists Integrity Module), with the purpose of removing the
+complexity away of IMA, and also adding the possibility of using it with
+other kernel components (e.g. Integrity Policy Enforcement, or IPE).
+
+The design changed significantly, so DIGLIM was renamed to Integrity Digest
+Cache, as the name better reflects what the new component does.
+
+Since it was originally proposed, in 2017, this work grew up a lot thanks
+to various comments/suggestions. It became integrally part of the openEuler
+distribution since end of 2020.
+
+The most important difference between the old the current version is moving
+from a centralized repository of file digests to a per-package repository.
+This reduces the digest lookup time, since digests are searched in smaller
+hash tables, and significantly reduces the memory pressure, since
+digest lists are loaded into kernel memory only when they are actually
+needed, and removed during reclamation.
+
+
+Performance
+===========
+
+System specification
+--------------------
+
+The tests have been performed on a Fedora 38 virtual machine with 4 cores
+(AMD EPYC-Rome, no hyperthreading), 16 GB of RAM, no TPM/TPM passthrough/
+emulated. The QEMU process has been pinned to 4 real CPU cores and its
+priority was set to -20.
+
+
+Benchmark tool
+--------------
+
+The Integrity Digest Cache has been tested with an ad-hoc benchmark tool
+that creates 20000 files with a random size up to 100 bytes and randomly
+adds their digest to one of 303 digest lists. The number of digest lists
+has been derived from the ratio (66) digests/packages (124174/1883) found
+in the testing virtual machine (hence, 20000/66 = 303). IMA signatures have
+been done with ECDSA NIST P-384.
+
+The benchmark tool then creates a list of 20000 files to be accessed,
+randomly chosen (there can be duplicates). This is necessary to make the
+results reproducible across reboots (by always replaying the same
+operations). The benchmark reads (sequentially and in parallel) the files
+from the list 2 times, flushing the kernel caches before each read.
+
+Each test has been performed 5 times, and the average value is taken.
+
+
+Purpose of the benchmark
+------------------------
+
+The purpose of the benchmark is to show the performance difference of IMA
+between the current behavior, and by using the Integrity Digest Cache.
+
+
+IMA measurement policy: no cache
+--------------------------------
+
+.. code-block:: bash
+
+ measure func=FILE_CHECK fowner=2001 pcr=12
+
+
+IMA measurement policy: cache
+-----------------------------
+
+.. code-block:: bash
+
+ measure func=DIGEST_LIST_CHECK pcr=12
+ measure func=FILE_CHECK fowner=2001 digest_cache=data pcr=12
+
+
+IMA measurement results
+-----------------------
+
+Sequential
+~~~~~~~~~~
+
+This test was performed reading files sequentially, and waiting for the
+current read to terminate before beginning a new one.
+
+::
+
+                      +-------+------------------------+-----------+
+                      | meas. | time no/p/vTPM (sec.)  | slab (KB) |
+ +--------------------+-------+------------------------+-----------+
+ | no cache           | 12313 | 31.71 / 102.80 / 46.29 |   86802   |
+ +--------------------+-------+------------------------+-----------+
+ | cache, no prefetch |   304 | 32.21 / 34.28 / 32.47  |   83709   |
+ +--------------------+-------+------------------------+-----------+
+ | cache, prefetch    |   304 | 32.67 / 34.47 / 32.67  |   83720   |
+ +--------------------+-------+------------------------+-----------+
+
+The table shows that 12313 measurements (boot_aggregate + files) have been
+made without the digest cache, and 304 with the digest cache
+(boot_aggregate + digest lists). Consequently, the memory occupation
+without the cache is higher due to the higher number of measurements.
+
+Not surprisingly, for the same reason, also the test time is significantly
+higher without the digest cache when the physical or virtual TPM is used.
+
+In terms of pure performance, first number in the third column, it can be
+seen that there are not significant performance differences between using
+or not using the digest cache.
+
+Prefetching adds little overhead, because digest lists were ordered
+according to their appearance in the IMA measurement list (which minimize
+the digest lists to prefetch).
+
+
+Parallel
+~~~~~~~~
+
+This test was performed reading files in parallel, not waiting for the
+current read to terminate.
+
+::
+
+                      +-------+-----------------------+-----------+
+                      | meas. | time no/p/vTPM (sec.) | slab (KB) |
+ +--------------------+-------+-----------------------+-----------+
+ | no cache           | 12313 | 15.84 / 79.26 / 23.43 |   87635   |
+ +--------------------+-------+-----------------------+-----------+
+ | cache, no prefetch |   304 | 15.97 / 16.64 / 16.09 |   89890   |
+ +--------------------+-------+-----------------------+-----------+
+ | cache, prefetch    |   304 | 16.18 / 16.84 / 16.24 |   85738   |
+ +--------------------+-------+-----------------------+-----------+
+
+Also in this case, the physical TPM causes the biggest delay especially
+without digest cache, where a higher number of measurements need to be
+extended in the TPM.
+
+The Integrity Digest Cache does not introduce a noticeable overhead in all
+scenarios.
+
+
+IMA appraisal policy: no cache
+------------------------------
+
+.. code-block:: bash
+
+ appraise func=FILE_CHECK fowner=2001
+
+
+IMA appraisal policy: cache
+---------------------------
+
+.. code-block:: bash
+
+ appraise func=DIGEST_LIST_CHECK
+ appraise func=FILE_CHECK fowner=2001 digest_cache=data
+
+
+IMA appraisal results
+---------------------
+
+Sequential
+~~~~~~~~~~
+
+This test was performed reading files sequentially, and waiting for the
+current read to terminate before beginning a new one.
+
+::
+
+                              +-------------+-------------+-----------+
+                              |    files    | time (sec.) | slab (KB) |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (ECDSA sig)       |    12312    |    98.10    |   80842   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache)           | 12312 + 303 |    34.09    |   83138   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache, prefetch) | 12312 + 303 |    34.08    |   83410   |
+ +----------------------------+-------------+-------------+-----------+
+
+This test shows a huge performance difference from verifying the signature
+of 12312 files as opposed to just verifying the signature of 303 digest
+lists, and looking up the digest of the files being read.
+
+There are some differences in terms of memory occupation, which is quite
+expected due to the fact that we have to take into account the digest
+caches loaded in memory, while with the standard appraisal they don't
+exist.
+
+
+Parallel
+~~~~~~~~
+
+This test was performed reading files in parallel, not waiting for the
+current read to terminate.
+
+::
+
+                              +-------------+-------------+-----------+
+                              |    files    | time (sec.) | slab (KB) |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (ECDSA sig)       |    12312    |    29.00    |   82255   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache)           | 12313 + 303 |    16.51    |   88359   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache, prefetch) | 12313 + 303 |    17.08    |   86266   |
+ +----------------------------+-------------+-------------+-----------+
+
+The difference is less marked when performing the read in parallel. Also,
+more memory seems to be occupied in the non-prefetch case.
+
+
+How to test
+===========
+
+Please follow the instructions here:
+
+https://github.com/linux-integrity/digest-cache-tools
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 59f8fc106cb0..34933e13c509 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -19,3 +19,4 @@ Security Documentation
    digsig
    landlock
    secrets/index
+   digest_cache
diff --git a/MAINTAINERS b/MAINTAINERS
index ba8d5c137bef..3b212c747652 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11115,8 +11115,10 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	Documentation/security/digest_cache.rst
 F:	security/integrity/
 F:	security/integrity/ima/
+F:	tools/testing/selftests/digest_cache/
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
-- 
2.34.1


