Return-Path: <linux-kselftest+bounces-5546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82D86B656
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 18:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505EE1C232B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744815DBA8;
	Wed, 28 Feb 2024 17:47:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2455208C6;
	Wed, 28 Feb 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142440; cv=none; b=PUIp3+hfPuAW+PnYIY3OqDbLVEwc3n0Up+xnE6FyAdEeEV5tDd+nFWIcAC2Q5bAE/LDlPC/atEGj8AWmWRIdmqFutXtfIq3Awyg4iVRyRZgF92AtxT0s5ZmmeVtmXoODF72DkYv1tct/jpbnENTo00bBpk7dTOpLZE2m0OavZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142440; c=relaxed/simple;
	bh=xHvKTOsABz1LDQNy4mHww2CXHcFEll/LFGFThBQaQcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vw53GfccyRfqw0IiPLtx8byAWPqh1F3r5akT0VKod5/LiawFY+dV3st4cJOLiKsiyfgDIwkvKy0RFYmSv6JUF2jgGZ5iHWL2FlzIJwpA3F96cVbdLSNRHPejGzIM+oepRBGOA0LEerYx75uLnsPrSPnGYRwEALm8yJRPb6r39iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlLxd34Hnz9xxS8;
	Thu, 29 Feb 2024 01:31:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A89DA140893;
	Thu, 29 Feb 2024 01:47:05 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC38SWGcd9lGPZcAw--.40616S2;
	Wed, 28 Feb 2024 18:47:04 +0100 (CET)
Message-ID: <e6d1314d46dc4befd78bfa33e2cf3d8572a16009.camel@huaweicloud.com>
Subject: Re: [PATCH v3 00/13] security: digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  shuah@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com,  mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 petrtesarik@huaweicloud.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 28 Feb 2024 18:46:43 +0100
In-Reply-To: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC38SWGcd9lGPZcAw--.40616S2
X-Coremail-Antispam: 1UD129KBjvJXoW3uF1DCFyxCw13Wr4ftry8AFb_yoWDAw17p3
	97CF15Kws5ZFy7Aw4fA3W29FyFv395KF47Gws7Xr13ZrWYvrnYy3WxCw17Zry3XrW8Xa1I
	yw47Kr15Ww4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IUUCeHDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5bMmQAAsz

On Fri, 2024-02-09 at 15:09 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the digest_cache LSM, whose purpose is to deliver reference
> digest values to integrity providers, such as IMA and IPE, abstracting to
> them how those digests where extracted from the respective data source.
>=20
> The major benefit is the ability to use the vaste amount of digests alrea=
dy
> provided (and likely signed) by software vendors, without needing them to
> adapt their format to the one understood by the integrity provider.
>=20
> IMA and IPE can immediately interface with the digest_cache LSM and query
> the digest of an accessed file. If the digest is found, it means that the
> file is coming from the software vendor and not modified. If not, the fil=
e
> might have been corrupted. Each integrity provider decides how to handle
> this situation.
>=20
> The second major benefit is performance improvement. Since the digest_cac=
he
> LSM has the ability to extract many digests from a single data source, it
> means that it has less signatures to verify compared to the approach of
> verifying individual file signatures (IMA appraisal). Preliminary tests
> have shown a speedup of IMA appraisal of about 65% for sequential read, a=
nd
> 45% for parallel read.
>=20
> This patch set has as prerequisites the file_release LSM hook (to be
> introduced with the move of IMA/EVM to the LSM infrastructure), and
> support for PGP keys, which is still unclear how it should be done.
>=20
> The IMA integration patch set will be introduced separately. Also a PoC
> based on the current version of IPE can be provided.

Hi everyone

I still hope to receive some comments on this and on the IMA
integration patch set.

Meanwhile, I built openSUSE Tumbleweed packages with both those patch
sets (with few changes) and the PGP one (with the parser in kernel
space).

I also published the first preliminary version of digest-cache-tools
which contains the tools to manage the digest_cache LSM.

https://github.com/linux-integrity/digest-cache-tools


The README should give a pretty good idea on how to configure the
digest_cache LSM correctly, to do IMA measurement (with predictable
PCR) and IMA appraisal.

That basically requires to install only the kernel and the digest-
cache-tools packages (plus dracut, to enable IMA measurement/appraisal
from the initial ram disk).

Other than that, openSUSE Tumbleweed with these three packages (and no
other modifications, even in the build infrastructure) is basically
offering the integrity features that IMA supports.

Roberto

> v2:
> - Include the TLV parser in this patch set (from user asymmetric keys and
>   signatures)
> - Move from IMA and make an independent LSM
> - Remove IMA-specific stuff from this patch set
> - Add per algorithm hash table
> - Expect all digest lists to be in the same directory and allow changing
>   the default directory
> - Support digest lookup on directories, when there is no
>   security.digest_list xattr
> - Add seq num to digest list file name, to impose ordering on directory
>   iteration
> - Add a new data type DIGEST_LIST_ENTRY_DATA for the nested data in the
>   tlv digest list format
> - Add the concept of verification data attached to digest caches
> - Add the reset mechanism to track changes on digest lists and directory
>   containing the digest lists
> - Add kernel selftests
>=20
> v1:
> - Add documentation in Documentation/security/integrity-digest-cache.rst
> - Pass the mask of IMA actions to digest_cache_alloc()
> - Add a reference count to the digest cache
> - Remove the path parameter from digest_cache_get(), and rely on the
>   reference count to avoid the digest cache disappearing while being used
> - Rename the dentry_to_check parameter of digest_cache_get() to dentry
> - Rename digest_cache_get() to digest_cache_new() and add
>   digest_cache_get() to set the digest cache in the iint of the inode for
>   which the digest cache was requested
> - Add dig_owner and dig_user to the iint, to distinguish from which inode
>   the digest cache was created from, and which is using it; consequently =
it
>   makes the digest cache usable to measure/appraise other digest caches
>   (support not yet enabled)
> - Add dig_owner_mutex and dig_user_mutex to serialize accesses to dig_own=
er
>   and dig_user until they are initialized
> - Enforce strong synchronization and make the contenders wait until
>   dig_owner and dig_user are assigned to the iint the first time
> - Move checking IMA actions on the digest list earlier, and fail if no
>   action were performed (digest cache not usable)
> - Remove digest_cache_put(), not needed anymore with the introduction of
>   the reference count
> - Fail immediately in digest_cache_lookup() if the digest algorithm is
>   not set in the digest cache
> - Use 64 bit mask for IMA actions on the digest list instead of 8 bit
> - Return NULL in the inline version of digest_cache_get()
> - Use list_add_tail() instead of list_add() in the iterator
> - Copy the digest list path to a separate buffer in digest_cache_iter_dir=
()
> - Use digest list parsers verified with Frama-C
> - Explicitly disable (for now) the possibility in the IMA policy to use t=
he
>   digest cache to measure/appraise other digest lists
> - Replace exit(<value>) with return <value> in manage_digest_lists.c
>=20
> Roberto Sassu (13):
>   lib: Add TLV parser
>   security: Introduce the digest_cache LSM
>   digest_cache: Add securityfs interface
>   digest_cache: Add hash tables and operations
>   digest_cache: Populate the digest cache from a digest list
>   digest_cache: Parse tlv digest lists
>   digest_cache: Parse rpm digest lists
>   digest_cache: Add management of verification data
>   digest_cache: Add support for directories
>   digest cache: Prefetch digest lists if requested
>   digest_cache: Reset digest cache on file/directory change
>   selftests/digest_cache: Add selftests for digest_cache LSM
>   docs: Add documentation of the digest_cache LSM
>=20
>  Documentation/security/digest_cache.rst       | 900 ++++++++++++++++++
>  Documentation/security/index.rst              |   1 +
>  MAINTAINERS                                   |  16 +
>  include/linux/digest_cache.h                  |  89 ++
>  include/linux/kernel_read_file.h              |   1 +
>  include/linux/tlv_parser.h                    |  28 +
>  include/uapi/linux/lsm.h                      |   1 +
>  include/uapi/linux/tlv_digest_list.h          |  72 ++
>  include/uapi/linux/tlv_parser.h               |  59 ++
>  include/uapi/linux/xattr.h                    |   6 +
>  lib/Kconfig                                   |   3 +
>  lib/Makefile                                  |   3 +
>  lib/tlv_parser.c                              | 214 +++++
>  lib/tlv_parser.h                              |  17 +
>  security/Kconfig                              |  11 +-
>  security/Makefile                             |   1 +
>  security/digest_cache/Kconfig                 |  34 +
>  security/digest_cache/Makefile                |  11 +
>  security/digest_cache/dir.c                   | 245 +++++
>  security/digest_cache/htable.c                | 268 ++++++
>  security/digest_cache/internal.h              | 259 +++++
>  security/digest_cache/main.c                  | 545 +++++++++++
>  security/digest_cache/modsig.c                |  66 ++
>  security/digest_cache/parsers/parsers.h       |  15 +
>  security/digest_cache/parsers/rpm.c           | 223 +++++
>  security/digest_cache/parsers/tlv.c           | 299 ++++++
>  security/digest_cache/populate.c              | 163 ++++
>  security/digest_cache/reset.c                 | 168 ++++
>  security/digest_cache/secfs.c                 |  87 ++
>  security/digest_cache/verif.c                 | 119 +++
>  security/security.c                           |   3 +-
>  tools/testing/selftests/Makefile              |   1 +
>  .../testing/selftests/digest_cache/.gitignore |   3 +
>  tools/testing/selftests/digest_cache/Makefile |  23 +
>  .../testing/selftests/digest_cache/all_test.c | 706 ++++++++++++++
>  tools/testing/selftests/digest_cache/common.c |  79 ++
>  tools/testing/selftests/digest_cache/common.h | 131 +++
>  .../selftests/digest_cache/common_user.c      |  47 +
>  .../selftests/digest_cache/common_user.h      |  17 +
>  tools/testing/selftests/digest_cache/config   |   1 +
>  .../selftests/digest_cache/generators.c       | 248 +++++
>  .../selftests/digest_cache/generators.h       |  19 +
>  .../selftests/digest_cache/testmod/Makefile   |  16 +
>  .../selftests/digest_cache/testmod/kern.c     | 499 ++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  45 files changed, 5714 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/security/digest_cache.rst
>  create mode 100644 include/linux/digest_cache.h
>  create mode 100644 include/linux/tlv_parser.h
>  create mode 100644 include/uapi/linux/tlv_digest_list.h
>  create mode 100644 include/uapi/linux/tlv_parser.h
>  create mode 100644 lib/tlv_parser.c
>  create mode 100644 lib/tlv_parser.h
>  create mode 100644 security/digest_cache/Kconfig
>  create mode 100644 security/digest_cache/Makefile
>  create mode 100644 security/digest_cache/dir.c
>  create mode 100644 security/digest_cache/htable.c
>  create mode 100644 security/digest_cache/internal.h
>  create mode 100644 security/digest_cache/main.c
>  create mode 100644 security/digest_cache/modsig.c
>  create mode 100644 security/digest_cache/parsers/parsers.h
>  create mode 100644 security/digest_cache/parsers/rpm.c
>  create mode 100644 security/digest_cache/parsers/tlv.c
>  create mode 100644 security/digest_cache/populate.c
>  create mode 100644 security/digest_cache/reset.c
>  create mode 100644 security/digest_cache/secfs.c
>  create mode 100644 security/digest_cache/verif.c
>  create mode 100644 tools/testing/selftests/digest_cache/.gitignore
>  create mode 100644 tools/testing/selftests/digest_cache/Makefile
>  create mode 100644 tools/testing/selftests/digest_cache/all_test.c
>  create mode 100644 tools/testing/selftests/digest_cache/common.c
>  create mode 100644 tools/testing/selftests/digest_cache/common.h
>  create mode 100644 tools/testing/selftests/digest_cache/common_user.c
>  create mode 100644 tools/testing/selftests/digest_cache/common_user.h
>  create mode 100644 tools/testing/selftests/digest_cache/config
>  create mode 100644 tools/testing/selftests/digest_cache/generators.c
>  create mode 100644 tools/testing/selftests/digest_cache/generators.h
>  create mode 100644 tools/testing/selftests/digest_cache/testmod/Makefile
>  create mode 100644 tools/testing/selftests/digest_cache/testmod/kern.c
>=20


