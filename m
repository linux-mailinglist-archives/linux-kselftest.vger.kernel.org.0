Return-Path: <linux-kselftest+bounces-8096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFF8A648C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 09:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9752282A6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D28757E1;
	Tue, 16 Apr 2024 07:10:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5238FA1;
	Tue, 16 Apr 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251427; cv=none; b=ezFFctzE71FwZcl+SowpEKXXrGdiblHZbGG5C0zUjYu158OyaxQP/v1ojk9pBNTnI/mjkZXSXcAOpap74r2rbdHVmBT9GPBw/pTnS81OCUW+1BDIeD/UQqFBE5HBOy8ye9zORZu8Imcgu+y46DSGQoqW/vg7ZRqnyvptrlCEefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251427; c=relaxed/simple;
	bh=HTvD9UJrcBuAyr6mHs2JwdJQiWn7njxpGgUPFIgumgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmB2BexF+Rh78zjdalBiB3YlwhzvzsX2OVWwbv/6uNRUeXljaUDxWjGohVviHolvnEj/3ExY9b/G1+HU+iDJ/wGVIUl14tpfP1Hc/JTiJjXgK3Gyv2Hb71aePqjS6NmAl2wsWX4PYqdhJuOeSWf8wdIk0W6cbdFA+6PKz8MJed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJZWj1XRLz9v7RF;
	Tue, 16 Apr 2024 14:53:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B91A9140792;
	Tue, 16 Apr 2024 15:10:20 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXDyRIJB5mDcxRBg--.12904S2;
	Tue, 16 Apr 2024 08:10:20 +0100 (CET)
Message-ID: <bc4cb132f21735a51e71d683cb9c374da53c20cf.camel@huaweicloud.com>
Subject: Re: [PATCH v4 02/14] security: Introduce the digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 akpm@linux-foundation.org, shuah@kernel.org,  mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 16 Apr 2024 09:09:56 +0200
In-Reply-To: <D0KY2HE7TMDH.2X3BQUDMRK17U@kernel.org>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <20240415142436.2545003-3-roberto.sassu@huaweicloud.com>
	 <D0KY2HE7TMDH.2X3BQUDMRK17U@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXDyRIJB5mDcxRBg--.12904S2
X-Coremail-Antispam: 1UD129KBjvAXoWftry8GFyDJryUJw18WFy7Awb_yoW5CryUGo
	ZayF47Jw409FyUZr4DCFn7Za1UC3WFg3yxAF4kJrWDZ3WIva4UG3WDCa1DJFW5Jr18JFZ7
	Aas7J3y8AFWUtr93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5h5KgACsx

On Mon, 2024-04-15 at 22:31 +0300, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the digest_cache LSM, to collect digests from various sources
> > (called digest lists), and to store them in kernel memory, in a set of =
hash
> > tables forming a digest cache. Extracted digests can be used as referen=
ce
> > values for integrity verification of file data or metadata.
> >=20
> > A digest cache has three types of references: in the inode security blo=
b of
> > the digest list the digest cache was created from (dig_owner field); in=
 the
> > security blob of the inodes for which the digest cache is requested
> > (dig_user field); a reference returned by digest_cache_get().
> >=20
> > References are released with digest_cache_put(), in the first two cases
> > when inodes are evicted from memory, in the last case when that functio=
n is
> > explicitly called. Obtaining a digest cache reference means that the di=
gest
> > cache remains valid and cannot be freed until releasing it and until th=
e
> > total number of references (stored in the digest cache) becomes zero.
> >=20
> > When digest_cache_get() is called on an inode to compare its digest wit=
h
> > a reference value, the digest_cache LSM knows which digest cache to get
> > from the new security.digest_list xattr added to that inode, which cont=
ains
> > the file name of the desired digest list digests will be extracted from=
.
> >=20
> > All digest lists are expected to be in the same directory, defined in t=
he
> > kernel config, and modifiable (with a later patch) at run-time through
> > securityfs. When the digest_cache LSM reads the security.digest_list xa=
ttr,
> > it uses its value as last path component, appended to the default path
> > (unless the default path is a file). If an inode does not have that xat=
tr,
> > the default path is considered as the final destination.
> >=20
> > The default path can be either a file or a directory. If it is a file, =
the
> > digest_cache LSM always uses the same digest cache from that file to ve=
rify
> > all inodes (the xattr, if present, is ignored). If it is a directory, a=
nd
> > the inode to verify does not have the xattr, a subsequent patch will ma=
ke
> > it possible to iterate and lookup on the digest caches created from eac=
h
> > directory entry.
> >=20
> > Digest caches are created on demand, only when digest_cache_get() is
> > called. The first time a digest cache is requested, the digest_cache LS=
M
> > creates it and sets its reference in the dig_owner and dig_user fields =
of
> > the respective inode security blobs. On the next requests, the previous=
ly
> > set reference is returned, after incrementing the reference count.
> >=20
> > Since there might be multiple digest_cache_get() calls for the same ino=
de,
> > or for different inodes pointing to the same digest list, dig_owner_mut=
ex
> > and dig_user_mutex have been introduced to protect the check and assign=
ment
> > of the digest cache reference in the inode security blob.
> >=20
> > Contenders that didn't get the lock also have to wait until the digest
> > cache is fully instantiated (when the bit INIT_IN_PROGRESS is cleared).
> > Dig_owner_mutex cannot be used for waiting on the instantiation to avoi=
d
> > lock inversion with the inode lock for directories.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  MAINTAINERS                                   |   6 +
> >  include/linux/digest_cache.h                  |  32 ++
> >  include/uapi/linux/lsm.h                      |   1 +
> >  include/uapi/linux/xattr.h                    |   3 +
> >  security/Kconfig                              |  11 +-
> >  security/Makefile                             |   1 +
> >  security/digest_cache/Kconfig                 |  16 +
> >  security/digest_cache/Makefile                |   7 +
> >  security/digest_cache/internal.h              |  86 ++++
> >  security/digest_cache/main.c                  | 404 ++++++++++++++++++
> >  security/security.c                           |   3 +-
> >  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
> >  12 files changed, 567 insertions(+), 6 deletions(-)
> >  create mode 100644 include/linux/digest_cache.h
> >  create mode 100644 security/digest_cache/Kconfig
> >  create mode 100644 security/digest_cache/Makefile
> >  create mode 100644 security/digest_cache/internal.h
> >  create mode 100644 security/digest_cache/main.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b1ca23ab8732..72801a88449c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6193,6 +6193,12 @@ L:	linux-gpio@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/gpio/gpio-gpio-mm.c
> > =20
> > +DIGEST_CACHE LSM
> > +M:	Roberto Sassu <roberto.sassu@huawei.com>
> > +L:	linux-security-module@vger.kernel.org
> > +S:	Maintained
> > +F:	security/digest_cache/
> > +
> >  DIGITEQ AUTOMOTIVE MGB4 V4L2 DRIVER
> >  M:	Martin Tuma <martin.tuma@digiteqautomotive.com>
> >  L:	linux-media@vger.kernel.org
>=20
> Nit: afaik, MAINTAINER updates should be split.

Ok, didn't know...

> > diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.=
h
> > new file mode 100644
> > index 000000000000..e79f94a60b0f
> > --- /dev/null
> > +++ b/include/linux/digest_cache.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Nit: Git has an author field in commit granularity so adding author
> fields to files is sort of old world.

Still like it if you don't mind...

What happens when you get the source code from non-git?

> > + *
> > + * Public API of the digest_cache LSM.
> > + */
> > +
> > +#ifndef _LINUX_DIGEST_CACHE_H
> > +#define _LINUX_DIGEST_CACHE_H
> > +
> > +#include <linux/fs.h>
> > +
> > +struct digest_cache;
>=20
> Is this declaration necessary?

I thought so. Users of the digest_cache LSM do:

struct digest_cache *digest_cache;


digest_cache =3D digest_cache_get(dentry);


and so on. Those users don't know the internal layout of the
digest_cache structure, but still pass it to the various functions.

> I don't think you need forward declaration here as this does compile:
>=20
> #include <stdio.h>
>=20
> struct digest_cache *digest_cache_get(void)
> {
>         return NULL;
> }
>=20
> int main(void)
> {
>         return (long)digest_cache_get();
> }
>=20
>=20
> > +
> > +#ifdef CONFIG_SECURITY_DIGEST_CACHE
> > +struct digest_cache *digest_cache_get(struct dentry *dentry);
> > +void digest_cache_put(struct digest_cache *digest_cache);
> > +
> > +#else
> > +static inline struct digest_cache *digest_cache_get(struct dentry *den=
try)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void digest_cache_put(struct digest_cache *digest_cache)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_SECURITY_DIGEST_CACHE */
> > +#endif /* _LINUX_DIGEST_CACHE_H */
> > diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> > index 33d8c9f4aa6b..832b3aea5c26 100644
> > --- a/include/uapi/linux/lsm.h
> > +++ b/include/uapi/linux/lsm.h
> > @@ -64,6 +64,7 @@ struct lsm_ctx {
> >  #define LSM_ID_LANDLOCK		110
> >  #define LSM_ID_IMA		111
> >  #define LSM_ID_EVM		112
> > +#define LSM_ID_DIGEST_CACHE	113
> > =20
> >  /*
> >   * LSM_ATTR_XXX definitions identify different LSM attributes
> > diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> > index 9463db2dfa9d..8a58cf4bce65 100644
> > --- a/include/uapi/linux/xattr.h
> > +++ b/include/uapi/linux/xattr.h
> > @@ -54,6 +54,9 @@
> >  #define XATTR_IMA_SUFFIX "ima"
> >  #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
> > =20
> > +#define XATTR_DIGEST_LIST_SUFFIX "digest_list"
> > +#define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST=
_SUFFIX
> > +
> >  #define XATTR_SELINUX_SUFFIX "selinux"
> >  #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
> > =20
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 52c9af08ad35..99f99cbd94cc 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -194,6 +194,7 @@ source "security/yama/Kconfig"
> >  source "security/safesetid/Kconfig"
> >  source "security/lockdown/Kconfig"
> >  source "security/landlock/Kconfig"
> > +source "security/digest_cache/Kconfig"
> > =20
> >  source "security/integrity/Kconfig"
> > =20
> > @@ -233,11 +234,11 @@ endchoice
> > =20
> >  config LSM
> >  	string "Ordered list of enabled LSMs"
> > -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoy=
o,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,sm=
ack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFA=
ULT_SECURITY_TOMOYO
> > -	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SEC=
URITY_DAC
> > -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoy=
o,apparmor,bpf"
> > +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,smack,=
selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,apparm=
or,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,tomoyo=
,bpf" if DEFAULT_SECURITY_TOMOYO
> > +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,bpf" i=
f DEFAULT_SECURITY_DAC
> > +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,selinu=
x,smack,tomoyo,apparmor,bpf"
> >  	help
> >  	  A comma-separated list of LSMs, in initialization order.
> >  	  Any LSMs left off this list, except for those with order
> > diff --git a/security/Makefile b/security/Makefile
> > index 59f238490665..e9b43e7b715a 100644
> > --- a/security/Makefile
> > +++ b/security/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
> >  obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
> >  obj-$(CONFIG_BPF_LSM)			+=3D bpf/
> >  obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
> > +obj-$(CONFIG_SECURITY_DIGEST_CACHE)	+=3D digest_cache/
> > =20
> >  # Object integrity file lists
> >  obj-$(CONFIG_INTEGRITY)			+=3D integrity/
> > diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kcon=
fig
> > new file mode 100644
> > index 000000000000..e53fbf0779d6
> > --- /dev/null
> > +++ b/security/digest_cache/Kconfig
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config SECURITY_DIGEST_CACHE
> > +	bool "Digest_cache LSM"
> > +	default n
> > +	help
> > +	  This option enables an LSM maintaining a cache of digests
> > +	  (e.g. of file data or metadata).
> > +
> > +	  This LSM can support other kernel components in making access
> > +	  control decisions.
> > +
> > +config DIGEST_LIST_DEFAULT_PATH
> > +	string
> > +	default "/etc/digest_lists"
> > +	help
> > +	  Default directory where digest_cache LSM expects to find digest lis=
ts.
> > diff --git a/security/digest_cache/Makefile b/security/digest_cache/Mak=
efile
> > new file mode 100644
> > index 000000000000..48848c41253e
> > --- /dev/null
> > +++ b/security/digest_cache/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for building the digest_cache LSM.
> > +
> > +obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> > +
> > +digest_cache-y :=3D main.o
> > diff --git a/security/digest_cache/internal.h b/security/digest_cache/i=
nternal.h
> > new file mode 100644
> > index 000000000000..5f04844af3a5
> > --- /dev/null
> > +++ b/security/digest_cache/internal.h
> > @@ -0,0 +1,86 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> ditto
>=20
> > + *
> > + * Internal header of the digest_cache LSM.
> > + */
> > +
> > +#ifndef _DIGEST_CACHE_INTERNAL_H
> > +#define _DIGEST_CACHE_INTERNAL_H
> > +
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/digest_cache.h>
> > +
> > +/* Digest cache bits in flags. */
> > +#define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
> > +
> > +/**
> > + * struct digest_cache - Digest cache
> > + * @ref_count: Number of references to the digest cache
> > + * @path_str: Path of the digest list the digest cache was created fro=
m
> > + * @flags: Control flags
> > + *
> > + * This structure represents a cache of digests extracted from a diges=
t list.
> > + */
> > +struct digest_cache {
> > +	atomic_t ref_count;
> > +	char *path_str;
> > +	unsigned long flags;
> > +};
> > +
> > +/**
> > + * struct digest_cache_security - Digest cache pointers in inode secur=
ity blob
> > + * @dig_owner: Digest cache created from this inode
> > + * @dig_owner_mutex: Protects @dig_owner
> > + * @dig_user: Digest cache requested for this inode
> > + * @dig_user_mutex: Protects @dig_user
> > + *
> > + * This structure contains references to digest caches, protected by t=
heir
> > + * respective mutex.
> > + */
> > +struct digest_cache_security {
> > +	struct digest_cache *dig_owner;
> > +	struct mutex dig_owner_mutex;
> > +	struct digest_cache *dig_user;
> > +	struct mutex dig_user_mutex;
> > +};
> > +
> > +extern struct lsm_blob_sizes digest_cache_blob_sizes;
> > +extern char *default_path_str;
> > +
> > +static inline struct digest_cache_security *
> > +digest_cache_get_security(const struct inode *inode)
> > +{
> > +	if (unlikely(!inode->i_security))
> > +		return NULL;
> > +
> > +	return inode->i_security + digest_cache_blob_sizes.lbs_inode;
> > +}
> > +
> > +static inline struct digest_cache *
> > +digest_cache_ref(struct digest_cache *digest_cache)
> > +{
> > +	atomic_inc(&digest_cache->ref_count);
> > +	pr_debug("Ref (+) digest cache %s (ref count: %d)\n",
> > +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
> > +	return digest_cache;
> > +}
> > +
> > +static inline struct digest_cache *
> > +digest_cache_unref(struct digest_cache *digest_cache)
> > +{
> > +	bool ref_is_zero =3D atomic_dec_and_test(&digest_cache->ref_count);
> > +
> > +	pr_debug("Ref (-) digest cache %s (ref count: %d)\n",
> > +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
> > +	return (ref_is_zero) ? digest_cache : NULL;
> > +}
> > +
> > +/* main.c */
> > +struct digest_cache *digest_cache_create(struct dentry *dentry,
> > +					 struct path *digest_list_path,
> > +					 char *path_str, char *filename);
> > +
> > +#endif /* _DIGEST_CACHE_INTERNAL_H */
> > diff --git a/security/digest_cache/main.c b/security/digest_cache/main.=
c
> > new file mode 100644
> > index 000000000000..14dba8915e99
> > --- /dev/null
> > +++ b/security/digest_cache/main.c
> > @@ -0,0 +1,404 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> > + *
> > + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> > + *
> > + * Implement the main code of the digest_cache LSM.
> > + */
> > +
> > +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
> > +#include <linux/namei.h>
> > +#include <linux/xattr.h>
> > +
> > +#include "internal.h"
> > +
> > +static int digest_cache_enabled __ro_after_init =3D 1;
> > +static struct kmem_cache *digest_cache_cache __read_mostly;
> > +
> > +char *default_path_str =3D CONFIG_DIGEST_LIST_DEFAULT_PATH;
> > +
> > +/**
> > + * digest_cache_alloc_init - Allocate and initialize a new digest cach=
e
> > + * @path_str: Path string of the digest list
> > + * @filename: Digest list file name (can be an empty string)
> > + *
> > + * This function allocates and initializes a new digest cache.
> > + *
> > + * Return: A digest_cache structure on success, NULL on error.
> > + */
> > +static struct digest_cache *digest_cache_alloc_init(char *path_str,
> > +						    char *filename)
> > +{
> > +	struct digest_cache *digest_cache;
> > +
> > +	digest_cache =3D kmem_cache_alloc(digest_cache_cache, GFP_KERNEL);
> > +	if (!digest_cache)
> > +		return digest_cache;
> > +
> > +	digest_cache->path_str =3D kasprintf(GFP_KERNEL, "%s%s%s", path_str,
> > +					   filename[0] ? "/" : "", filename);
> > +	if (!digest_cache->path_str) {
> > +		kmem_cache_free(digest_cache_cache, digest_cache);
> > +		return NULL;
> > +	}
> > +
> > +	atomic_set(&digest_cache->ref_count, 1);
> > +	digest_cache->flags =3D 0UL;
> > +
> > +	pr_debug("New digest cache %s (ref count: %d)\n",
> > +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
>=20
> Nit: kretprobe can be used to grab the same information easil and
> do e.g. statistics and stuff like that. Traces for return values
> are not very useful.

I like to do dynamic debug, and I can control what part I want to
debug. All these messages allowed me to debug efficiently when there
was any issue. Would be a pity to remove them.

Thanks

Roberto

> > +
> > +	return digest_cache;
> > +}
> > +
> > +/**
> > + * digest_cache_free - Free all memory occupied by the digest cache
> > + * @digest_cache: Digest cache
> > + *
> > + * This function frees the memory occupied by the digest cache.
> > + */
> > +static void digest_cache_free(struct digest_cache *digest_cache)
> > +{
> > +	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
>=20
> ditto for the above trace
>=20
> > +	kfree(digest_cache->path_str);
> > +	kmem_cache_free(digest_cache_cache, digest_cache);
> > +}
> > +
> > +/**
> > + * digest_cache_create - Create a digest cache
> > + * @dentry: Dentry of the inode for which the digest cache will be use=
d
> > + * @digest_list_path: Path structure of the digest list
> > + * @path_str: Path string of the digest list
> > + * @filename: Digest list file name (can be an empty string)
> > + *
> > + * This function first locates, from the passed path, the digest list =
inode
> > + * from which the digest cache will be created or retrieved (if it alr=
eady
> > + * exists).
> > + *
> > + * If dig_owner is NULL in the inode security blob, this function crea=
tes a
> > + * new digest cache with reference count set to 1 (reference returned)=
, sets
> > + * it to dig_owner and consequently increments again the digest cache =
reference
> > + * count.
> > + *
> > + * Otherwise, it simply increments the reference count of the existing
> > + * dig_owner, since that reference is returned to the caller.
> > + *
> > + * Incrementing the reference count twice before calling path_put() en=
sures
> > + * that the digest cache returned is valid even if the inode is evicte=
d from
> > + * memory (which decreases the reference count).
> > + *
> > + * Releasing the dig_owner_mutex lock does not mean that the digest ca=
che is
> > + * ready for use. digest_cache_create() callers that found a partially
> > + * instantiated digest cache have to wait until the INIT_IN_PROGRESS b=
it is
> > + * cleared by the caller that is actually creating that digest cache.
> > + *
> > + * Return: A new digest cache on success, NULL on error.
> > + */
> > +struct digest_cache *digest_cache_create(struct dentry *dentry,
> > +					 struct path *digest_list_path,
> > +					 char *path_str, char *filename)
> > +{
> > +	struct path file_path;
> > +	struct digest_cache *digest_cache =3D NULL;
> > +	struct digest_cache_security *dig_sec;
> > +	struct inode *inode =3D d_backing_inode(digest_list_path->dentry);
> > +	bool dig_owner_exists =3D false;
> > +	int ret;
> > +
> > +	if (S_ISDIR(d_backing_inode(digest_list_path->dentry)->i_mode) &&
> > +	    filename[0]) {
> > +		ret =3D vfs_path_lookup(digest_list_path->dentry,
> > +				      digest_list_path->mnt, filename, 0,
> > +				      &file_path);
> > +		if (ret < 0) {
> > +			pr_debug("Cannot find digest list %s/%s\n", path_str,
> > +				 filename);
> > +			return NULL;
> > +		}
> > +
> > +		digest_list_path =3D &file_path;
> > +		inode =3D d_backing_inode(file_path.dentry);
> > +
> > +		/*
> > +		 * Cannot request a digest cache for the same inode the
> > +		 * digest cache is populated from.
> > +		 */
> > +		if (d_backing_inode(dentry) =3D=3D inode) {
> > +			pr_debug("Cannot request a digest cache for %s and use it as digest=
 list\n",
> > +				 dentry->d_name.name);
> > +			goto out;
> > +		}
> > +
> > +		/* No support for nested directories. */
> > +		if (!S_ISREG(inode->i_mode)) {
> > +			pr_debug("%s is not a regular file (no support for nested directori=
es)\n",
> > +				 dentry->d_name.name);
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	dig_sec =3D digest_cache_get_security(inode);
> > +	if (unlikely(!dig_sec))
> > +		goto out;
> > +
> > +	/* Serialize check and assignment of dig_owner. */
> > +	mutex_lock(&dig_sec->dig_owner_mutex);
> > +	if (dig_sec->dig_owner) {
> > +		/* Increment ref. count for reference returned to the caller. */
> > +		digest_cache =3D digest_cache_ref(dig_sec->dig_owner);
> > +		dig_owner_exists =3D true;
> > +		mutex_unlock(&dig_sec->dig_owner_mutex);
> > +		goto exists;
> > +	}
> > +
> > +	/* Ref. count is already 1 for this reference. */
> > +	digest_cache =3D digest_cache_alloc_init(path_str, filename);
> > +	if (!digest_cache) {
> > +		mutex_unlock(&dig_sec->dig_owner_mutex);
> > +		goto out;
> > +	}
> > +
> > +	/* Increment ref. count for reference set to dig_owner. */
> > +	dig_sec->dig_owner =3D digest_cache_ref(digest_cache);
> > +
> > +	/* Make the other lock contenders wait until creation complete. */
> > +	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
> > +	mutex_unlock(&dig_sec->dig_owner_mutex);
> > +
> > +	/* Creation complete, notify the other lock contenders. */
> > +	clear_and_wake_up_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
> > +exists:
> > +	if (dig_owner_exists)
> > +		/* Wait until creation complete. */
> > +		wait_on_bit(&dig_sec->dig_owner->flags, INIT_IN_PROGRESS,
> > +			    TASK_UNINTERRUPTIBLE);
> > +out:
> > +	if (digest_list_path =3D=3D &file_path)
> > +		path_put(&file_path);
> > +
> > +	return digest_cache;
> > +}
> > +
> > +/**
> > + * digest_cache_new - Retrieve digest list file name and request diges=
t cache
> > + * @dentry: Dentry of the inode for which the digest cache will be use=
d
> > + *
> > + * This function locates the default path. If it is a file, it directl=
y creates
> > + * a digest cache from it. Otherwise, it reads the digest list file na=
me from
> > + * the security.digest_list xattr and requests the creation of a diges=
t cache
> > + * with that file name. If security.digest_list is not found, this fun=
ction
> > + * requests the creation of a digest cache on the parent directory.
> > + *
> > + * Return: A new digest cache on success, NULL on error.
> > + */
> > +static struct digest_cache *digest_cache_new(struct dentry *dentry)
> > +{
> > +	char filename[NAME_MAX + 1] =3D { 0 };
> > +	struct digest_cache *digest_cache =3D NULL;
> > +	struct path default_path;
> > +	int ret;
> > +
> > +	ret =3D kern_path(default_path_str, 0, &default_path);
> > +	if (ret < 0) {
> > +		pr_debug("Cannot find path %s\n", default_path_str);
> > +		return NULL;
> > +	}
> > +
> > +	/* The default path is a file, no need to get xattr. */
> > +	if (S_ISREG(d_backing_inode(default_path.dentry)->i_mode)) {
> > +		pr_debug("Default path %s is a file, not reading %s xattr\n",
> > +			 default_path_str, XATTR_NAME_DIGEST_LIST);
> > +		goto create;
> > +	} else if (!S_ISDIR(d_backing_inode(default_path.dentry)->i_mode)) {
> > +		pr_debug("Default path %s must be either a file or a directory\n",
> > +			 default_path_str);
> > +		goto out;
> > +	}
> > +
> > +	ret =3D vfs_getxattr(&nop_mnt_idmap, dentry, XATTR_NAME_DIGEST_LIST,
> > +			   filename, sizeof(filename) - 1);
> > +	if (ret <=3D 0) {
> > +		pr_debug("Digest list path not found for file %s, using %s\n",
> > +			 dentry->d_name.name, default_path_str);
> > +		goto create;
> > +	}
> > +
> > +	if (strchr(filename, '/')) {
> > +		pr_debug("%s xattr should contain only a file name, got: %s\n",
> > +			 XATTR_NAME_DIGEST_LIST, filename);
> > +		goto out;
> > +	}
> > +
> > +	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
> > +		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
> > +		 filename);
> > +create:
> > +	digest_cache =3D digest_cache_create(dentry, &default_path,
> > +					   default_path_str, filename);
> > +out:
> > +	path_put(&default_path);
> > +	return digest_cache;
> > +}
> > +
> > +/**
> > + * digest_cache_get - Get a digest cache for a given inode
> > + * @dentry: Dentry of the inode for which the digest cache will be use=
d
> > + *
> > + * This function tries to find a digest cache from the inode security =
blob of
> > + * the passed dentry (dig_user field). If a digest cache was not found=
, it calls
> > + * digest_cache_new() to create a new one. In both cases, it increment=
s the
> > + * digest cache reference count before returning the reference to the =
caller.
> > + *
> > + * The caller is responsible to call digest_cache_put() to release the=
 digest
> > + * cache reference returned.
> > + *
> > + * Lock dig_user_mutex to protect against concurrent requests to obtai=
n a digest
> > + * cache for the same inode, and to make other contenders wait until t=
he first
> > + * requester finishes the process.
> > + *
> > + * Return: A digest cache on success, NULL otherwise.
> > + */
> > +struct digest_cache *digest_cache_get(struct dentry *dentry)
> > +{
> > +	struct digest_cache_security *dig_sec;
> > +	struct digest_cache *digest_cache =3D NULL;
> > +	struct inode *inode =3D d_backing_inode(dentry);
> > +
> > +	if (!digest_cache_enabled)
> > +		return NULL;
> > +
> > +	dig_sec =3D digest_cache_get_security(inode);
> > +	if (unlikely(!dig_sec))
> > +		return NULL;
> > +
> > +	/* Serialize accesses to inode for which the digest cache is used. */
> > +	mutex_lock(&dig_sec->dig_user_mutex);
> > +	if (!dig_sec->dig_user)
> > +		/* Consume extra reference from digest_cache_create(). */
> > +		dig_sec->dig_user =3D digest_cache_new(dentry);
> > +
> > +	if (dig_sec->dig_user)
> > +		/* Increment ref. count for reference returned to the caller. */
> > +		digest_cache =3D digest_cache_ref(dig_sec->dig_user);
> > +
> > +	mutex_unlock(&dig_sec->dig_user_mutex);
> > +	return digest_cache;
> > +}
> > +EXPORT_SYMBOL_GPL(digest_cache_get);
> > +
> > +/**
> > + * digest_cache_put - Release a digest cache reference
> > + * @digest_cache: Digest cache
> > + *
> > + * This function decrements the reference count of the digest cache pa=
ssed as
> > + * argument. If the reference count reaches zero, it calls digest_cach=
e_free()
> > + * to free the digest cache.
> > + */
> > +void digest_cache_put(struct digest_cache *digest_cache)
> > +{
> > +	struct digest_cache *to_free;
> > +
> > +	to_free =3D digest_cache_unref(digest_cache);
> > +	if (!to_free)
> > +		return;
> > +
> > +	digest_cache_free(to_free);
> > +}
> > +EXPORT_SYMBOL_GPL(digest_cache_put);
> > +
> > +struct lsm_blob_sizes digest_cache_blob_sizes __ro_after_init =3D {
> > +	.lbs_inode =3D sizeof(struct digest_cache_security),
> > +};
> > +
> > +/**
> > + * digest_cache_inode_alloc_security - Initialize inode security blob
> > + * @inode: Inode for which the security blob is initialized
> > + *
> > + * This function initializes the digest_cache_security structure, dire=
ctly
> > + * stored in the inode security blob.
> > + *
> > + * Return: Zero.
> > + */
> > +static int digest_cache_inode_alloc_security(struct inode *inode)
> > +{
> > +	struct digest_cache_security *dig_sec;
> > +
> > +	/* The inode security blob is always allocated here. */
> > +	dig_sec =3D digest_cache_get_security(inode);
> > +	mutex_init(&dig_sec->dig_owner_mutex);
> > +	mutex_init(&dig_sec->dig_user_mutex);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * digest_cache_inode_free_security - Release the digest cache referen=
ces
> > + * @inode: Inode for which the digest cache references are released
> > + *
> > + * Since the inode is being evicted, this function releases the non-ne=
eded
> > + * references to the digest caches stored in the digest_cache_security
> > + * structure.
> > + */
> > +static void digest_cache_inode_free_security(struct inode *inode)
> > +{
> > +	struct digest_cache_security *dig_sec;
> > +
> > +	dig_sec =3D digest_cache_get_security(inode);
> > +	if (!dig_sec)
> > +		return;
> > +
> > +	mutex_destroy(&dig_sec->dig_owner_mutex);
> > +	mutex_destroy(&dig_sec->dig_user_mutex);
> > +	if (dig_sec->dig_owner)
> > +		digest_cache_put(dig_sec->dig_owner);
> > +	if (dig_sec->dig_user)
> > +		digest_cache_put(dig_sec->dig_user);
> > +}
> > +
> > +static struct security_hook_list digest_cache_hooks[] __ro_after_init =
=3D {
> > +	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security=
),
> > +	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
> > +};
> > +
> > +/**
> > + * digest_cache_init_once - Initialize the digest cache structure
> > + * @foo: Digest cache structure to initialize
> > + *
> > + * This function fills the digest cache structure with zeros.
> > + */
> > +static void digest_cache_init_once(void *foo)
> > +{
> > +	struct digest_cache *digest_cache =3D (struct digest_cache *)foo;
> > +
> > +	memset(digest_cache, 0, sizeof(*digest_cache));
> > +}
> > +
> > +static const struct lsm_id digest_cache_lsmid =3D {
> > +	.name =3D "digest_cache",
> > +	.id =3D LSM_ID_DIGEST_CACHE,
> > +};
> > +
> > +/**
> > + * digest_cache_init - Initialize the digest_cache LSM
> > + *
> > + * Initialize the digest_cache LSM, by instantiating a cache for the
> > + * digest_cache structure and by registering the digest_cache LSM hook=
s.
> > + */
> > +static int __init digest_cache_init(void)
> > +{
> > +	digest_cache_cache =3D kmem_cache_create("digest_cache_cache",
> > +					       sizeof(struct digest_cache),
> > +					       0, SLAB_PANIC,
> > +					       digest_cache_init_once);
> > +
> > +	security_add_hooks(digest_cache_hooks, ARRAY_SIZE(digest_cache_hooks)=
,
> > +			   &digest_cache_lsmid);
> > +	return 0;
> > +}
> > +
> > +DEFINE_LSM(digest_cache) =3D {
> > +	.name =3D "digest_cache",
> > +	.enabled =3D &digest_cache_enabled,
> > +	.init =3D digest_cache_init,
> > +	.blobs =3D &digest_cache_blob_sizes,
> > +};
> > diff --git a/security/security.c b/security/security.c
> > index cbdc9bebe802..cb084ed58617 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -50,7 +50,8 @@
> >  	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> >  	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
> >  	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> > -	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
> > +	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
> > +	(IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) ? 1 : 0))
> > =20
> >  /*
> >   * These are descriptions of the reasons that can be passed to the
> > diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tool=
s/testing/selftests/lsm/lsm_list_modules_test.c
> > index 4d5d4cee2586..d00831edc582 100644
> > --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> > +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> > @@ -128,6 +128,9 @@ TEST(correct_lsm_list_modules)
> >  		case LSM_ID_EVM:
> >  			name =3D "evm";
> >  			break;
> > +		case LSM_ID_DIGEST_CACHE:
> > +			name =3D "digest_cache";
> > +			break;
> >  		default:
> >  			name =3D "INVALID";
> >  			break;
>=20
> BR, Jarkko


