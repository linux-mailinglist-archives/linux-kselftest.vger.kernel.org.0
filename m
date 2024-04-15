Return-Path: <linux-kselftest+bounces-7982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414338A53FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA7E28471D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49F84D08;
	Mon, 15 Apr 2024 14:30:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69B381C4;
	Mon, 15 Apr 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191409; cv=none; b=mBcqRrCiAUTgF5sQDSXDyeniYVg5TjK/scnfrqJr2TZyC+jAE5PBSebFe+9y9KFWBvQVLoyVbwJCGquMQe3H72+VuYfp+oddnL5tHk18KBiezYXXsxWl2ZTMqLRSRemFGCFrFcxeDQWjnVMW7hImf7g2PZboDwP0FgPKq/tFERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191409; c=relaxed/simple;
	bh=YzQ4i5qrhN9V57ocPuGAtqUzHjSjdvr1xff+mlGg8B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tm7jqgNMY/6U86We0GyzYkRe0qbcFYdXEqGoBcPQES1Hj55R1FLMqgRLOq4X+2NfH9XlD/ImV8lBZAIUwcbJsvXGsYaK1wV9LwflFo9zjio4UcDp4pouLidcmZc0hvcR3qYob2aX++q6MZ9dt0nSGJNBPiQlI29AaC32smIUZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJ8KY0xlnz9v7HR;
	Mon, 15 Apr 2024 22:13:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AC8BB1405DF;
	Mon, 15 Apr 2024 22:29:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshqQOR1mrL1NBg--.21472S6;
	Mon, 15 Apr 2024 15:29:54 +0100 (CET)
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
Subject: [PATCH v4 14/14] docs: Add documentation of the digest_cache LSM
Date: Mon, 15 Apr 2024 16:24:36 +0200
Message-Id: <20240415142436.2545003-15-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshqQOR1mrL1NBg--.21472S6
X-Coremail-Antispam: 1UD129KBjvAXoWftryDGw1xCF1rGFy8AryxKrg_yoW5urWUGo
	ZY9r4jyw1UKr15ZF4kCFnrAw13GwnYgwn7Ar18Kw45WF1rXFW5J3WDC3WUGFW3Jr4rGr9r
	A348J3yUJF1Utrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOx7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
	v_Gr1UMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnI
	WIevJa73UjIFyTuYvjxU9eOJUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h0wgABsW

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of the digest_cache LSM in Documentation/security.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_cache.rst | 763 ++++++++++++++++++++++++
 Documentation/security/index.rst        |   1 +
 MAINTAINERS                             |   1 +
 3 files changed, 765 insertions(+)
 create mode 100644 Documentation/security/digest_cache.rst

diff --git a/Documentation/security/digest_cache.rst b/Documentation/security/digest_cache.rst
new file mode 100644
index 000000000000..f7c2b1bcf25b
--- /dev/null
+++ b/Documentation/security/digest_cache.rst
@@ -0,0 +1,763 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Digest_cache LSM
+================
+
+Introduction
+============
+
+Integrity detection and protection has long been a desirable feature, to
+reach a large user base and mitigate the risk of flaws in the software and
+attacks.
+
+However, while solutions exist, they struggle to reach the large user base,
+due to requiring higher than desired constraints on performance,
+flexibility and configurability, that only security conscious people are
+willing to accept.
+
+This is where the new digest_cache LSM comes into play, it offers
+additional support for new and existing integrity solutions, to make them
+faster and easier to deploy.
+
+
+Motivation
+==========
+
+The digest_cache LSM helps to address two important shortcomings of the
+Integrity Measurement Architecture (IMA): predictability of the Platform
+Configuration Registers (PCRs), and the provisioning of reference values to
+compare the calculated file digest against.
+
+Remote attestation, according to Trusted Computing Group (TCG)
+specifications, is done by replicating the PCR extend operation in
+software with the digests in the event log (in this case the IMA
+measurement list), and by comparing the obtained value with the PCR value
+signed by the TPM with the quote operation.
+
+Due to how the extend operation is performed, if measurements are done in
+a different order, the final PCR value will be different. That means that
+if measurements are done in parallel, there is no way to predict what the
+final PCR value will be, making impossible to seal data to a PCR value. If
+the PCR value was predictable, a system could for example prove its
+integrity by unsealing and using its private key, without sending every
+time the full list of measurements.
+
+Provisioning reference values for file digests is also a difficult task.
+The solution so far was to add file signatures to RPM packages, and
+possibly to DEB packages, so that IMA can verify them. While this undoubtly
+works, it also requires Linux distribution vendors to support the feature
+by rebuilding all their packages, and eventually extending their PKI to
+perform the additional signatures. It could also require developers extra
+work to deal with the additional data.
+
+On the other hand, since often packages carry the file digests themselves,
+it won't be actually needed to add file signatures. If the kernel was able
+to extract the file digests by itself, all the tasks mentioned above for
+the Linux distribution vendors won't be needed too. All current and past
+Linux distributions can be easily retrofitted to enable IMA appraisal with
+the file digests from the packages.
+
+Narrowing down the scope of a package parser to only extract specific
+information makes it small enough to accurately verify that it cannot harm
+the kernel. In fact, the parsers included with the digest_cache LSM have
+been verified with the formal verification tool Frama-C, albeit with a
+limited buffer size (the verification time grows considerably with bigger
+buffer sizes). The parsers with the Frama-C assertions are available here:
+
+https://github.com/robertosassu/rpm-formal/
+
+Frama-C asserts that the parsers don't read beyond their assigned buffer
+for any byte combination.
+
+An additional mitigation against corrupted digest lists consists in
+verifying the signature of the package first, before attempting to extract
+the file digests.
+
+
+Solution
+========
+
+The digest_cache LSM can help IMA to extend a PCR in a deterministic way.
+If IMA knows that a file comes from a Linux distribution, it can measure
+files in a different way: measure the list of digests coming from the
+distribution (e.g. RPM package headers), and subsequently measure a file if
+it is not found in that list.
+
+If the system executes known files, it does not matter in which order they
+are executed, because the PCR is not extended. That however means that the
+lists of digests must be measured in a deterministic way. The digest_cache
+LSM has a prefetching mechanism to make this happen, consisting in
+sequentially reading digest lists in a directory until it finds the
+requested one.
+
+The resulting IMA measurement list however has a disadvantage: it does not
+tell to remote verifiers whether files with digest in the measured digest
+lists have been accessed or not and when. Also the IMA measurement list
+would change after a software update.
+
+The digest_cache LSM can also help IMA for appraisal. Currently, IMA has
+to evaluate the signature of each file individually, and expects that the
+Linux vendors include those signatures together with the files in the
+packages.
+
+With the digest_cache LSM, IMA can simply lookup in the list of digests
+extracted from package headers, once the signature of those headers has
+been verified. The same approach can be followed by other LSMs, such as
+Integrity Policy Enforcement (IPE).
+
+
+Design
+======
+
+Digest cache
+------------
+
+Main idea
+~~~~~~~~~
+
+The digest_cache LSM extracts digests from a file, referred to as a digest
+list, and stores them in kernel memory in a structure named digest_cache.
+
+The digest_cache structure contains a set of per algorithm hash tables,
+where digests are stored, the digest list pathname, a reference counter,
+the integrity state of the digest list, and the inodes for which the digest
+cache is used.
+
+If a digest cache is created from a directory, its hash tables are empty
+and instead it contains a snapshot of the directory entries discovered with
+iterate_dir().
+
+The integrity state of digest caches created from regular files is
+evaluated independently by other LSMs, for example by verifying the
+signature of the digest list, and is provided to the digest_cache LSM
+through a dedicated API.
+
+The extracted digests can be used as reference values initially for
+integrity verification of file data and at a later stage for integrity
+verification of file metadata.
+
+The digest_cache LSM can extract digests from a digest list, only if it has
+a parser for its format. Currently, it supports a TLV-based and the RPM
+package header formats, and can support more in the future.
+
+
+Digest list lookup
+~~~~~~~~~~~~~~~~~~
+
+In order to build a digest cache and return it to the caller for performing
+a query, the digest_cache LSM must know which digest list to use. There are
+a few alternatives.
+
+(1) There is only one digest list and its path is specified as default
+location at build-time in the kernel configuration or at run-time through
+securityfs. The digest_cache LSM builds a single digest cache from that
+digest list and returns it to the caller.
+
+(2) The default location is a directory containing multiple digest lists.
+Unlike (1), the digest_cache LSM does not know which digest list to select,
+and creates an iterator with a snapshot of the directory entries. During a
+query, the digest_cache LSMs iteratively creates a digest cache for each
+directory entry and searches for the digest until there is a match.
+
+(3) Same as (2), but the digest list file name is stored as value of the
+new security.digest_list xattr in the inode for which the digest cache is
+requested. The digest_cache LSM can directly retrieve the digest list using
+the default directory as the base path and the xattr value as last path
+component.
+
+(4) Similar to (3), but the digest_cache LSM still creates a directory
+iterator like in (2). It reads digest lists with a file name that does not
+match the security.digest_list xattr, to trigger a measurement, and creates
+a digest cache from the matching one. This is also known as the prefetching
+mechanism, introduced later.
+
+
+Digest cache creation
+~~~~~~~~~~~~~~~~~~~~~
+
+Digest list naming convention
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Once the digest_cache LSM selected the digest list to use, it reads the
+file and calls the appropriate parser to extract the digests, based on the
+filename prefix.
+
+The expected digest list file name format is::
+
+ <digest list format>-<file name>
+
+where format can be for example ``tlv`` or ``rpm``, which make the
+digest_cache LSM call respectively the TLV or RPM parser.
+
+Alternatively, also the following format is supported::
+
+ <seq num>-<digest list format>-<file name>
+
+``<seq num>-`` defines how directory entries should be ordered in the
+directory iterator.
+
+Digest cache create API
+^^^^^^^^^^^^^^^^^^^^^^^
+
+The digest_cache LSM offers an API for parsers to initialize and add
+digests to the digest cache hash tables.
+
+It exposes digest_cache_htable_init() to initialize a hash table for a
+given algorithm, and to size it depending on the number of digests to add,
+normally known by the parsers before adding digests.
+
+The number of hash table slots is determined by dividing the number of
+digests to add by the desired average collision depth. The latter can be
+changed in the kernel configuration, to have a different tradeoff between
+digest lookup speed and memory occupation.
+
+It also exposes digest_cache_htable_add(), to let parsers add extracted
+digests to the new hash table. If parsers need to add digests created with
+different algorithms, they can create as many hash tables as they need.
+
+Finally, parsers can also call digest_cache_htable_lookup() to lookup a
+digest in the passed digest_cache.
+
+Digest cache caching on create
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Since the same digest cache can be requested multiple times for
+verification of different inodes (e.g. installed files belonging to the
+same software package), a pointer to the newly created digest cache (named
+dig_owner) is stored in the inode security blob of the digest list.
+
+Dig_owner check and assignment is protected by the dig_owner_mutex, also
+stored in the inode security blob. The first requestor instantiates and
+populates the new digest cache. The other lock contenders wait until the
+lock is released and until the first requestor clears the INIT_IN_PROGRESS
+bit in the digest cache bit mask. The latter is needed to avoid lock
+inversion with the code tracking changes on digest lists/default directory.
+
+
+Digest cache request
+~~~~~~~~~~~~~~~~~~~~
+
+Users of the digest_cache LSM can request a digest cache by calling
+digest_cache_get(), passing the inode for which they need a digest cache,
+and can release it with digest_cache_put() once they are done. As mentioned
+above, the digest_cache LSM determines which digest list the digest cache
+should be built/retrieved from.
+
+Digest cache caching on request
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To avoid having to find the digest list inode for every digest_cache_get()
+call, also a pointer to the retrieved digest cache (named dig_user) is
+stored in the security blob of the inode for which the digest cache is
+requested.
+
+Dig_user is also protected by its own dig_user_mutex (stored in the same
+inode security blob) for check and assignment. Multiple requestors of a
+digest cache for the same inode have to wait until the first requestor
+finds the digest list inode and obtains the digest cache.
+
+Digest cache reference count
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Since digest cache pointers are stored in the inode security blobs and
+returned to the digest_cache_get() callers, the digest_cache LSM must track
+how many pointers are around, to avoid freeing a digest cache while it is
+still in use.
+
+The digest_cache LSM records the number of such pointers in a per digest
+cache reference count, and increments it every time the pointer is stored
+in a new inode security blob (either dig_owner or dig_user), or returned by
+digest_cache_get(), and decrements it when an inode is evicted from memory
+or a caller of digest_cache_get() calls digest_cache_put().
+
+
+Digest lookup
+~~~~~~~~~~~~~
+
+After a caller of digest_cache_get() obtains the desired digest cache, it
+can perform operations on it. The most important operation is querying for
+a digest, which can be performed by calling digest_cache_lookup().
+
+digest_cache_lookup() returns a numeric reference (digest_cache_found_t
+type), representing the digest cache containing the queried digest. It is
+not a pointer, to avoid it being accidentally passed to digest_cache_put().
+
+If the digest_cache LSM took the option (2) (multiple digest lists in the
+default directory but which one to use is unknown), digest_cache_get()
+returns an iterator instead, to be passed to digest_cache_lookup().
+
+Only the latter finally returns the digest cache containing the searched
+digest. If the digest is not found, digest_cache_lookup() returns zero.
+
+
+Verification data
+~~~~~~~~~~~~~~~~~
+
+Until now, the caller of the digest_cache LSM is assumed to always trust
+the returned digest cache from being created from authentic data. Or, there
+are security measures in place but not able to correlate reading a digest
+list with building a digest cache from it.
+
+The digest_cache LSM introduces a new mechanism for integrity providers to
+store verification data, i.e. their evaluation result of a digest list. It
+also allows callers of digest_cache_get() to later retrieve that
+information and decide whether or not they should use that digest cache.
+
+It achieves that by reserving space in the file descriptor security blob,
+and by setting the digest cache pointer in the digest list file descriptor.
+
+The digest_cache LSM supports multiple integrity providers at the same
+time, since multiple LSMs can implement the kernel_post_read_file LSM hook.
+Each provider is expected to choose an unique ID, so that the verification
+data can be given back through the same ID.
+
+Those integrity providers should implement the kernel_post_read_file LSM
+hook and call digest_cache_verif_set(), passing the digest list file
+descriptor, the unique ID and their evaluation result of the digest list.
+
+Callers of digest_cache_get() can call digest_cache_verif_get() to get
+the verification data, passing the returned digest cache pointer and the
+desired integrity provider ID. However, if the digest cache returned was an
+iterator, that call results in a NULL pointer, since the iterator is
+not populated with any digest list.
+
+In that case, those callers have to call digest_cache_lookup() to get the
+numeric reference of the digest cache containing the digest (thus populated
+from a digest list), and pass it to digest_cache_verif_get() after
+conversion to a digest cache pointer (with digest_cache_from_found_t()).
+
+
+Tracking changes
+~~~~~~~~~~~~~~~~
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
+The digest_cache LSM monitors such changes by registering to multiple LSM
+hooks (path_truncate, file_release, inode_unlink, inode_rename,
+inode_post_setxattr and inode_post_removexattr). Except for the last two,
+it accesses the dig_owner pointer in the affected inode security blob and
+sets the RESET bit.
+
+The next time that digest cache is requested, both dig_user and dig_owner
+are passed to digest_cache_put() and cleared. A new digest cache is
+created, as if there wasn't one in the first place.
+
+For the last two hooks, the RESET_USER bit is set instead, to limit
+clearing dig_user, since only retrieval of the digest list could change
+after modifying the security.digest_list xattr, and not the digest cache
+itself.
+
+Nothing changes for callers of digest_cache_get(), since they still hold
+the old digest cache pointer, despite that has been replaced in the inode
+security blobs. The old digest cache pointer will not be freed until those
+callers also call digest_cache_put() and the reference count reaches zero.
+
+Notify changes
+~~~~~~~~~~~~~~
+
+While new calls to digest_cache_get() result in a new digest cache to be
+returned, resetting the previous digest cache does not reflect in a reset
+of possibly cached security decisions based on that digest cache.
+
+IMA for example, would not be able to recheck a file digest against a
+modified digest cache, since it is not aware of the reset in the first
+place.
+
+Introduce a subscription-based notification mechanism, that dispatches to
+the interested parties events which include the type of event (e.g. reset)
+and the digest cache and inodes affected. A user of the digest_cache LSM
+can become a subscriber by calling digest_cache_register_notifier() and can
+unsubscribe by calling digest_cache_unregister_notifier().
+
+During a digest_cache_get(), add the inode for which the digest cache was
+requested to a notification list of the same digest cache. When the RESET
+bit is set, emit a event for each inode in that notification list, so that
+IMA and the other integrity providers can eventually invalidate their
+cached security decision on that inode.
+
+On a file digest cache reset, notify also users of the parent directory
+digest cache, since they might have looked up digests through that digest
+cache. Those users will see changes by performing another lookup.
+
+When the RESET_USER bit is set, emit a notification just for the inode
+signalled by the LSM hook, since the operation causing a reset
+(set/removexattr) only affects the link between the inode and the digest
+cache, and not the digest cache itself.
+
+Prefetching mechanism
+~~~~~~~~~~~~~~~~~~~~~
+
+One of the objectives of the digest_cache LSM is to make a TPM PCR
+predictable, by having digest lists measured in a deterministic order.
+Without the prefetching mechanism, digest lists are measured in a
+non-deterministic order, since the inodes for which a digest cache can be
+requested are accessed in a non-deterministic order too.
+
+The prefetching mechanism, when enabled by setting the new
+security.dig_prefetch xattr to 1, forces digest lists to be looked up by
+their file name in the list of the directory entries of the iterator
+created for the default directory.
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
+hand, since it determines the order of directory entries in the iterator
+(entries with lower seq nums are before entries with higher seq nums).
+Digest lists without that prefix are added at the end of iterator list,
+in the same order as iterate_dir() shows them.
+
+With ``[<seq num>-]``, the latency of digest cache creation when the
+prefetching mechanism is enabled can be significantly reduced for example
+by ordering digest lists by their appearance in the IMA measurement list,
+since that list reflects the order in which digest lists are requested at
+boot.
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
+entries of the iterator.
+
+
+Data structures and API
+=======================
+
+Data structures
+---------------
+
+These are the data structures defined and used internally by the
+digest_cache LSM.
+
+.. kernel-doc:: security/digest_cache/internal.h
+
+
+Public API
+----------
+
+This API is meant to be used by users of the digest_cache LSM.
+
+.. kernel-doc:: include/linux/digest_cache.h
+		:identifiers: digest_cache_found_t
+		              digest_cache_from_found_t
+
+.. kernel-doc:: security/digest_cache/main.c
+		:identifiers: digest_cache_get digest_cache_put
+
+.. kernel-doc:: security/digest_cache/htable.c
+		:identifiers: digest_cache_lookup
+
+.. kernel-doc:: security/digest_cache/verif.c
+		:identifiers: digest_cache_verif_set digest_cache_verif_get
+
+.. kernel-doc:: security/digest_cache/notifier.c
+		:identifiers: digest_cache_register_notifier
+			      digest_cache_unregister_notifier
+
+
+Parser API
+----------
+
+This API is meant to be used by digest list parsers.
+
+.. kernel-doc:: security/digest_cache/htable.c
+		:identifiers: digest_cache_htable_init
+		              digest_cache_htable_add
+			      digest_cache_htable_lookup
+
+
+Digest List Formats
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
+Appended Signature
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
+The design changed significantly, so DIGLIM was renamed to digest_cache
+LSM, as the name better reflects what the new component does.
+
+Since it was originally proposed, in 2017, this work grew up a lot thanks
+to various comments/suggestions. It became integrally part of the openEuler
+distribution since end of 2020.
+
+The most important difference between the old the current version is moving
+from a centralized repository of file digests to a per-package repository.
+This significantly reduces the memory pressure, since digest lists are
+loaded into kernel memory only when they are actually needed. Also, file
+digests are automatically unloaded from kernel memory at the same time
+inodes are evicted from memory during reclamation.
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
+The digest_cache LSM has been tested with an ad-hoc benchmark tool that
+creates 20000 files with a random size up to 100 bytes and randomly adds
+their digest to one of 303 digest lists. The number of digest lists has
+been derived from the ratio (66) digests/packages (124174/1883) found in
+the testing virtual machine (hence, 20000/66 = 303). IMA signatures have
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
+between the current behavior, and by using the digest_cache LSM.
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
+IMA Measurement Results
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
+ | no cache           | 12313 | 33.65 / 102.51 / 47.13 |   84170   |
+ +--------------------+-------+------------------------+-----------+
+ | cache, no prefetch |   304 | 34.04 / 33.32 / 33.09  |   81159   |
+ +--------------------+-------+------------------------+-----------+
+ | cache, prefetch    |   304 | 34.02 / 33.31 / 33.15  |   81122   |
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
+seen that there are not really performance differences between using or not
+using the digest cache.
+
+Prefetching does not add overhead, also because digest lists were ordered
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
+ | no cache           | 12313 | 14.08 / 79.09 / 22.70 |   85138   |
+ +--------------------+-------+-----------------------+-----------+
+ | cache, no prefetch |   304 | 14.44 / 15.11 / 14.96 |   85777   |
+ +--------------------+-------+-----------------------+-----------+
+ | cache, prefetch    |   304 | 14.30 / 15.41 / 14.40 |   83294   |
+ +--------------------+-------+-----------------------+-----------+
+
+Also in this case, the physical TPM causes the biggest delay especially
+without digest cache, where a higher number of measurements need to be
+extended in the TPM.
+
+The digest_cache LSM does not introduce a noticeable overhead in all
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
+IMA Appraisal Results
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
+ | appraise (ECDSA sig)       |    12312    |    96.74    |   78827   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache)           | 12312 + 303 |    33.09    |   80854   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache, prefetch) | 12312 + 303 |    33.42    |   81050   |
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
+ | appraise (ECDSA sig)       |    12312    |    27.68    |   80596   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache)           | 12313 + 303 |    14.96    |   80778   |
+ +----------------------------+-------------+-------------+-----------+
+ | appraise (cache, prefetch) | 12313 + 303 |    14.78    |   83354   |
+ +----------------------------+-------------+-------------+-----------+
+
+The difference is less marked when performing the read in parallel. Also,
+more memory seems to be occupied in the prefetch case.
+
+
+How to Test
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
index d7f700da009e..67b1fb3ab0ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6197,6 +6197,7 @@ DIGEST_CACHE LSM
 M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
+F:	Documentation/security/digest_cache.rst
 F:	security/digest_cache/
 F:	tools/testing/selftests/digest_cache/
 
-- 
2.34.1


