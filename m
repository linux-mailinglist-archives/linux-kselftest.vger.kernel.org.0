Return-Path: <linux-kselftest+bounces-4446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4884F6FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD9284AE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB426A8AA;
	Fri,  9 Feb 2024 14:14:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98169D21;
	Fri,  9 Feb 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488043; cv=none; b=PhyDUwi3OB0dKnNTph/itptVCJC0KRwsUMqCL/oPSxpJ/C9GRqiGcDkAVi/ZFHdkDlJoBFIRcPBfaJ0BwkBCw/xRmszDglvOMWLkS43961b4vi/PmLugni4XE5yXdpytK/LVfquP+flHxCb8PkEiI5lCCeEDxKl0nlad42vfy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488043; c=relaxed/simple;
	bh=6wqzNgp62owJUlql6tnI4hRFRErRJ9xngX6jLxJn+mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHd6UxaEA5q3zRXZ4HNQIzTl1lQrVBVG+0qWkWxv02IJeXQT1yTwZPJLUqDAm87rufVgM6wHqPOvifRWZVgiIMV+C/kXcrSPEjZdui6NDodnaqrth1S/aBkbFCSn50eKuGwrjgftd/FTN7Uw5VWvXCPQq2DFGSkxZY2GvMJrlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TWb6x5W38z9yBkR;
	Fri,  9 Feb 2024 21:58:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 34B15140FB5;
	Fri,  9 Feb 2024 22:13:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCThMsZloMgpAg--.31110S5;
	Fri, 09 Feb 2024 15:13:46 +0100 (CET)
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
Subject: [PATCH v3 13/13] docs: Add documentation of the digest_cache LSM
Date: Fri,  9 Feb 2024 15:09:17 +0100
Message-Id: <20240209140917.846878-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoCThMsZloMgpAg--.31110S5
X-Coremail-Antispam: 1UD129KBjvAXoWftryDGw1xCr45Cry3ZFyrZwb_yoWrGr18to
	ZY9r4UAw18Kr15uF1kCFnrAw1UG3ZYgwn7Ar18tw45WF18XFWUG3WDC3WUGFy5Jr4rGr97
	A34xJw48Jr1Dtrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO97kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUwOzVUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5o4HQABsC

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of the digest_cache LSM in Documentation/security.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_cache.rst | 900 ++++++++++++++++++++++++
 Documentation/security/index.rst        |   1 +
 MAINTAINERS                             |   1 +
 3 files changed, 902 insertions(+)
 create mode 100644 Documentation/security/digest_cache.rst

diff --git a/Documentation/security/digest_cache.rst b/Documentation/security/digest_cache.rst
new file mode 100644
index 000000000000..6a492e23495c
--- /dev/null
+++ b/Documentation/security/digest_cache.rst
@@ -0,0 +1,900 @@
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
+The digest_cache LSM collects digests from various sources (called digest
+lists), and stores them in kernel memory, in a set of hash tables forming a
+digest cache. Extracted digests can be used as reference values for
+integrity verification of file content or metadata.
+
+A digest cache has three types of references: in the inode security blob of
+the digest list the digest cache was created from (dig_owner field); in the
+security blob of the inodes for which the digest cache is requested
+(dig_user field); a reference returned by digest_cache_get().
+
+References are released with digest_cache_put(), in the first two cases
+when inodes are evicted from memory, in the last case when that function is
+explicitly called. Obtaining a digest cache reference means that the digest
+cache remains valid and cannot be freed until releasing it and until the
+total number of references (stored in the digest cache) becomes zero.
+
+When digest_cache_get() is called on an inode to compare its digest with
+a reference value, the digest_cache LSM knows which digest cache to get
+from the new security.digest_list xattr added to that inode, which contains
+the file name of the desired digest list digests will be extracted from.
+
+All digest lists are expected to be in the same directory, defined in the
+kernel config, and modifiable at run-time through securityfs. When the
+digest_cache LSM reads the security.digest_list xattr, it uses its value as
+last path component, appended to the default path (unless the default path
+is a file). If an inode does not have that xattr, the default path is
+considered as the final destination.
+
+The default path can be either a file or a directory. If it is a file, the
+digest_cache LSM always uses the same digest cache from that file to verify
+all inodes (the xattr, if present, is ignored). If it is a directory, and
+the inode to verify does not have the xattr, the digest_cache LSM iterates
+and looks up on the digest caches created from each directory entry.
+
+Digest caches are created on demand, only when digest_cache_get() is
+called. The first time a digest cache is requested, the digest_cache LSM
+creates it and sets its reference in the dig_owner and dig_user fields of
+the respective inode security blobs. On the next requests, the previously
+set reference is returned, after incrementing the reference count.
+
+Since there might be multiple digest_cache_get() calls for the same inode,
+or for different inodes pointing to the same digest list, dig_owner_mutex
+and dig_user_mutex have been introduced to protect the check and assignment
+of the digest cache reference in the inode security blob.
+
+Contenders that didn't get the lock also have to wait until the digest
+cache is fully instantiated (when the bit INIT_IN_PROGRESS is cleared).
+Dig_owner_mutex cannot be used for waiting on the instantiation to avoid
+lock inversion with the inode lock for directories.
+
+
+Verification data
+-----------------
+
+The digest_cache LSM can support other LSMs in their decisions of granting
+access to file content and metadata.
+
+However, the information alone about whether a digest was found in a digest
+cache might not be sufficient, because for example those LSMs wouldn't know
+whether the digest cache itself was created from authentic data.
+
+Digest_cache_verif_set() lets the same LSMs (or a chosen integrity
+provider) evaluate the digest list being read during the creation of the
+digest cache, by implementing the kernel_post_read_file LSM hook, and lets
+them attach their verification data to that digest cache.
+
+Space is reserved in the file descriptor security blob for the digest cache
+pointer. Digest_cache_to_file_sec() sets that pointer before calling
+kernel_read_file() in digest_cache_populate(), and
+digest_cache_from_file_sec() retrieves the pointer back from the file
+descriptor passed by LSMs with digest_cache_verif_set().
+
+Multiple providers are supported, in the event there are multiple
+integrity LSMs active. Each provider should also provide an unique verifier
+ID as an argument to digest_cache_verif_set(), so that verification data
+can be distinguished.
+
+A caller of digest_cache_get() can retrieve back the verification data by
+calling digest_cache_verif_get() and passing a digest cache pointer and the
+desired verifier ID.
+
+Since directory digest caches are not populated themselves, LSMs have to do
+a lookup first to get the digest cache containing the digest, call
+digest_cache_from_found_t() to convert the returned digest_cache_found_t
+type to a digest cache pointer, and pass that to digest_cache_verif_get().
+
+
+Directories
+-----------
+
+In the environments where xattrs are not available (e.g. in the initial ram
+disk), the digest_cache LSM cannot precisely determine which digest list in
+a directory contains the desired reference digest. However, although
+slower, it would be desirable to search the digest in all digest lists of
+that directory.
+
+This done in two steps. When a digest cache is being created,
+digest_cache_create() invokes digest_cache_dir_create(), to generate the
+list of current directory entries. Entries are placed in the list in
+ascending order by the <seq num> if prepended to the file name, or at the
+end of the list if not.
+
+The resulting digest cache has the IS_DIR bit set, to distinguish it from
+the digest caches created from regular files.
+
+Second, when a digest is searched in a directory digest cache,
+digest_cache_lookup() invokes digest_cache_dir_lookup_digest() to
+iteratively search that digest in each directory entry generated by
+digest_cache_dir_create().
+
+That list is stable, even if new files are added or deleted from that
+directory. In that case, the digest_cache LSM will invalidate the digest
+cache, forcing next callers of digest_cache_get() to get a new directory
+digest cache with the updated list of directory entries.
+
+If the current directory entry does not have a digest cache reference,
+digest_cache_dir_lookup_digest() invokes digest_cache_create() to create a
+new digest cache for that entry. In either case,
+digest_cache_dir_lookup_digest() calls then digest_cache_htable_lookup()
+with the new/existing digest cache to search the digest.
+
+The iteration stops when the digest is found. In that case,
+digest_cache_dir_lookup_digest() returns the digest cache reference of the
+current directory entry as the digest_cache_found_t type, so that callers
+of digest_cache_lookup() don't mistakenly try to call digest_cache_put()
+with that reference.
+
+This new reference type will be used to retrieve information about the
+digest cache containing the digest, which is not known in advance until the
+digest search is performed.
+
+The order of the list of directory entries influences the speed of the
+digest search. A search terminates faster if less digest caches have to be
+created. One way to optimize it could be to order the list of digest lists
+in the same way of when they are requested at boot.
+
+Finally, digest_cache_dir_free() releases the digest cache references
+stored in the list of directory entries, and frees the list itself.
+
+
+Prefetching
+-----------
+
+A desirable goal when doing integrity measurements is that they are done
+always in the same order across boots, so that the resulting PCR value
+becomes predictable and suitable for sealing policies. However, due to
+parallel execution of system services at boot, a deterministic order of
+measurements is difficult to achieve.
+
+The digest_cache LSM is not exempted from this issue. Under the assumption
+that only the digest list is measured, and file measurements are omitted if
+their digest is found in that digest list, a PCR can be predictable only if
+all files belong to the same digest list. Otherwise, it will still be
+unpredictable, since files accessed in a non-deterministic order will cause
+digest lists to be measured in a non-deterministic order too.
+
+The prefetching mechanism overcomes this issue by searching a digest list
+file name in digest_list_dir_lookup_filename() among the entries of the
+linked list built by digest_cache_dir_create(). If the file name does not
+match, it reads the digest list to trigger its measurement. Otherwise, it
+also creates a digest cache and returns that to the caller.
+
+Prefetching needs to be explicitly enabled by setting the new
+security.dig_prefetch xattr to 1 in the directory containing the digest
+lists. The newly introduced function digest_cache_prefetch_requested()
+checks first if the DIR_PREFETCH bit is set in dig_owner, otherwise it
+reads the xattr. digest_cache_create() sets DIR_PREFETCH in dig_owner, if
+prefetching is enabled, before declaring the digest cache as initialized.
+
+
+Tracking changes
+----------------
+
+The digest_cache LSM registers to five LSM hooks, file_open, path_truncate,
+file_release, inode_unlink and inode_rename, to monitor digest lists and
+directory modifications.
+
+If an action affects a digest list or the parent directory, these hooks
+call digest_cache_reset() to set the RESET bit on the digest cache. This
+will cause next calls to digest_cache_get() and digest_cache_create() to
+respectively put and clear dig_user and dig_owner, and request a new
+digest cache.
+
+That does not affect other users of the old digest cache, since that one
+remains valid as long as the reference count is greater than zero. However,
+they can explicitly call the new function digest_cache_was_reset(), to
+check if the RESET bit was set on the digest cache reference they hold.
+
+Recreating a file digest cache means reading the digest list again and
+extracting the digests. Recreating a directory digest cache, instead, does
+not mean recreating the digest cache for directory entries, since those
+digest caches are likely already stored in the inode security blob. It
+would happen however for new files.
+
+File digest cache reset is done on file_open, when a digest list is opened
+for write, path_truncate, when a digest list is truncated (there is no
+inode_truncate, file_truncate does not catch operations through the
+truncate() system call), inode_unlink, when a digest list is removed, and
+inode_rename when a digest list is renamed.
+
+Directory digest cache reset is done on file_release, when a digest list is
+written in the digest list directory, on inode_unlink, when a digest list
+is deleted from that directory, and finally on inode_rename, when a digest
+list is moved to/from that directory.
+
+With the exception of file_release, which will always be executed (cannot
+be denied), the other LSM hooks are not optimal, since the digest_cache LSM
+does not know whether or not the operation will be allowed also by other
+LSMs. If the operation is denied, the digest_cache LSM would do an
+unnecessary reset.
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
+.. kernel-doc:: security/digest_cache/reset.c
+		:identifiers: digest_cache_was_reset
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
+(AMD EPYC-Rome, no hyperthreading), 4 GB of RAM, no TPM/TPM passthrough/
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
+ measure func=FILE_CHECK fowner=2001 digest_cache=content pcr=12
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
+ appraise func=FILE_CHECK fowner=2001 digest_cache=content
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
+Additional patches need to be applied to the kernel.
+
+The patch to introduce the file_release LSM hook:
+
+https://lore.kernel.org/linux-integrity/20240115181809.885385-14-roberto.sassu@huaweicloud.com/
+
+The patch set to use the PGP keys from the Linux distributions for
+verifying the RPM header signatures:
+
+https://lore.kernel.org/linux-integrity/20230720153247.3755856-1-roberto.sassu@huaweicloud.com/
+
+The same URL contains two GNUPG patches to be applied to the user space
+program.
+
+The patch set to use the digest_cache LSM from IMA:
+
+https://github.com/robertosassu/linux/commits/digest_cache-lsm-v3-ima/
+
+First, it is necessary to install the kernel headers in usr/ in the kernel
+source directory:
+
+.. code-block:: bash
+
+ $ make headers_install
+
+After, it is necessary to copy the new kernel headers (tlv_parser.h,
+uasym_parser.h, tlv_digest_list.h) from usr/include/linux in the kernel
+source directory to /usr/include/linux.
+
+Then, gpg must be rebuilt with the additional patches to convert the PGP
+keys of the Linux distribution to the new user asymmetric key format:
+
+.. code-block:: bash
+
+ $ gpg --conv-kernel <path of PGP key> >> certs/uasym_keys.bin
+
+This embeds the converted keys in the kernel image.
+
+Finally, the following kernel options must be enabled:
+
+.. code-block:: bash
+
+ CONFIG_SECURITY_DIGEST_CACHE=y
+ CONFIG_UASYM_KEYS_SIGS=y
+ CONFIG_UASYM_PRELOAD_PUBLIC_KEYS=y
+
+and the kernel must be rebuilt with the patches applied. After reboot, it
+is necessary to build and install the digest list tools downloadable from:
+
+https://github.com/linux-integrity/digest-cache-tools
+
+and to execute (as root):
+
+.. code-block:: bash
+
+ # manage_digest_lists -o gen -d /etc/digest_lists -i rpmdb -f rpm
+
+The new gpg must also be installed in the system, as it will be used to
+convert the PGP signatures of the RPM headers to the user asymmetric key
+format.
+
+It is recommended to create an additional digest list with the following
+files, by creating a file named ``list`` with the content:
+
+.. code-block:: bash
+
+ /usr/bin/manage_digest_lists
+ /usr/lib64/libgen-tlv-list.so
+ /usr/lib64/libgen-rpm-list.so
+ /usr/lib64/libparse-rpm-list.so
+ /usr/lib64/libparse-tlv-list.so
+
+Then, to create the digest list, it is sufficient to execute:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i list -L -d /etc/digest_lists -o gen -f tlv
+
+Also, a digest list must be created for the modified gpg binary:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i /usr/bin/gpg -d /etc/digest_lists -o gen -f tlv
+
+If appraisal is enabled and in enforcing mode, it is necessary to sign the
+new digest lists, with the sign-file tool in the scripts/ directory of the
+kernel sources:
+
+.. code-block:: bash
+
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/tlv-list
+ # scripts/sign-file sha256 certs/signing_key.pem certs/signing_key.pem /etc/digest_lists/tlv-gpg
+
+The final step is to add security.digest_list to each file with:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i /etc/digest_lists -o add-xattr
+
+After that, it is possible to test the digest_cache LSM with the following
+policy written to /etc/ima/ima-policy:
+
+.. code-block:: bash
+
+ measure func=DIGEST_LIST_CHECK template=ima-modsig pcr=12
+ dont_measure fsmagic=0x01021994
+ measure func=BPRM_CHECK digest_cache=content pcr=12
+ measure func=MMAP_CHECK digest_cache=content pcr=12
+
+Tmpfs is excluded for now, until memfd is properly handled. The reason why
+the DIGEST_LIST_CHECK rule is before the dont_measure is that otherwise
+digest lists in the initial ram disk won't be processed.
+
+Before loading the policy, it is possible to enable dynamic debug to see
+which operations are done by the digest_cache LSM:
+
+.. code-block:: bash
+
+ # echo "file security/digest_cache/* +p" > /sys/kernel/debug/dynamic_debug/control
+
+Alternatively, the same strings can be set as value of the dyndbg= option
+in the kernel command line.
+
+A preliminary test, before booting the system with the new policy, is to
+supply the policy to IMA in the current system with:
+
+.. code-block:: bash
+
+ # cat /etc/ima/ima-policy > /sys/kernel/security/ima/policy
+
+After executing some commands, it can be seen if the digest_cache LSM is
+working by checking the IMA measurement list. If there are only digest
+lists, it means that everything is working properly, and the system can be
+rebooted. The instructions have been tested on a Fedora 38 OS.
+
+After boot, it is possible to check the content of the measurement list:
+
+.. code-block:: bash
+
+ # cat /sys/kernel/security/ima/ascii_runtime_measurements
+
+
+At this point, it is possible to enable the prefetching mechanism to make
+the PCR predictable. The virtual machine must be configured with a TPM
+(Emulated).
+
+To enable the prefetching mechanism, it is necessary to set
+security.dig_prefetch to '1' for the /etc/digest_lists directory:
+
+.. code-block:: bash
+
+ # setfattr -n security.dig_prefetch -v "1" /etc/digest_lists
+
+The final step is to reorder digest lists to be in the same order in which
+they appear in the IMA measurement list.
+
+This can be done by executing the command:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i /sys/kernel/security/ima/ascii_runtime_measurements -d /etc/digest_lists -o add-seqnum
+
+Since we renamed the digest lists, we need to update security.digest_list
+too:
+
+.. code-block:: bash
+
+ # manage_digest_lists -i /etc/digest_lists -o add-xattr
+
+By rebooting several times, and just logging in (to execute the same
+commands during each boot), it is possible to compare the PCR 12, and see
+that it is always the same. That of course works only if the TPM is reset
+at each boot (e.g. if the virtual machine has a virtual TPM) or if the code
+is tested in the host environment.
+
+.. code-block:: bash
+
+ # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-sha256/12
+
+The last step is to test IMA appraisal. This can be done by adding the
+following lines to /etc/ima/ima-policy:
+
+.. code-block:: bash
+
+ appraise func=DIGEST_LIST_CHECK appraise_type=imasig|modsig
+ dont_appraise fsmagic=0x01021994
+ appraise func=BPRM_CHECK digest_cache=content
+ appraise func=MMAP_CHECK digest_cache=content
+
+The following test is to ensure that IMA prevents the execution of unknown
+files:
+
+.. code-block:: bash
+
+ # cp -a /bin/cat .
+ # ./cat
+
+That will work. But not on the modified binary:
+
+.. code-block:: bash
+
+ # echo 1 >> cat
+ # ./cat
+ -bash: ./cat: Permission denied
+
+Execution will be denied, and a new entry in the measurement list will
+appear (it would be probably ok to not add that entry, as access to the
+file was denied):
+
+.. code-block:: bash
+
+ 12 50b5a68bea0776a84eef6725f17ce474756e51c0 ima-ng sha256:15e1efee080fe54f5d7404af7e913de01671e745ce55215d89f3d6521d3884f0 /root/cat
+
+Finally, it is possible to test the shrinking of the digest cache, by
+forcing the kernel to evict inodes from memory:
+
+.. code-block:: bash
+
+ # echo 3 > /proc/sys/vm/drop_caches
+
+If dynamic debug was enabled, the kernel log should have messages like:
+
+.. code-block:: bash
+
+ [  313.032536] DIGEST CACHE: Removed digest sha256:102900208eef27b766380135906d431dba87edaa7ec6aa72e6ebd3dd67f3a97b from digest list /etc/digest_lists/rpm-libseccomp-2.5.3-4.fc38.x86_64
+
+Optionally, it is possible to test IMA measurement/appraisal from the very
+beginning of the boot process, for now by including all digest lists and the
+IMA policy in the initial ram disk. In the future, there will be a dracut
+patch for ``dracut_install`` to select only the necessary digest lists.
+
+This can be simply done by executing:
+
+.. code-block:: bash
+
+ # dracut -f -I " /etc/ima/ima-policy " -i /etc/digest_lists/ /etc/digest_lists/ --nostrip --kver <your kernel version>
+
+The --nostrip option is particularly important. If debugging symbols are
+stripped from the binary, its digest no longer matches with the one from
+the package, causing access denied.
+
+The final test is to try the default IMA measurement and appraisal
+policies, so that there is no gap between when the system starts and when
+the integrity evaluation is effective. The default policies actually will
+be used only until systemd is able to load the custom policy to
+measure/appraise binaries and shared libraries. It should be good enough
+for the system to boot.
+
+The default IMA measurement and appraisal policies can be loaded at boot by
+adding the following to the kernel command line:
+
+.. code-block:: bash
+
+ ima_policy="tcb|appraise_tcb|digest_cache_measure|digest_cache_appraise"
+
+The ima-modsig template can be selected by adding to the kernel command
+line:
+
+.. code-block:: bash
+
+ ima_template=ima-modsig
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
index ee52cc664bc7..076b6e9da194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6159,6 +6159,7 @@ DIGEST_CACHE LSM
 M:	Roberto Sassu <roberto.sassu@huawei.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
+F:	Documentation/security/digest_cache.rst
 F:	security/digest_cache/
 F:	tools/testing/selftests/digest_cache/
 
-- 
2.34.1


