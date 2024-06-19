Return-Path: <linux-kselftest+bounces-12217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D790E507
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F34A282C59
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE777F08;
	Wed, 19 Jun 2024 07:59:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA3770FC;
	Wed, 19 Jun 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783986; cv=none; b=uV34e3M1w8ZzdjWhglVoRGW76qWiGZqv0LTuAkra5iNWE9G/ZpqJjSTNPLCdfYXlsedB7E/+rbbNt4W27rmCTOjPe472V+otY5l7HRopOMEvDOpwOQeEmV2p21GJwFshx09ljvKyEEtDMH0zFQew2n+mnSi6JpubOTpnnNSm+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783986; c=relaxed/simple;
	bh=1682kPZ0rCkDXK9rlE7DjUnagikwOiSEMJpPmPx4ENo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8A3zRp6ZgX6Wo+HbCcwba4mf+Zi/kv4kbLsg2WUGcrj7Hw/DpdwDwrLbQDU2QFFPDHOPifCVoFPp+bISaz/rdKUpWxpy67v/VdDOzrn2GV9oestFcxpotG2A02bTmdqbiR7Ikf+8UciEskfZTnswRslBbMB+2YVRPaq5YlDd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4W3wYT5SYjz9v7Hk;
	Wed, 19 Jun 2024 15:41:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6107E1409C9;
	Wed, 19 Jun 2024 15:59:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXLDfJj3JmG1u3AA--.19750S2;
	Wed, 19 Jun 2024 08:59:23 +0100 (CET)
Message-ID: <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
 akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, mic@digikod.net, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Wed, 19 Jun 2024 09:59:02 +0200
In-Reply-To: <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXLDfJj3JmG1u3AA--.19750S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18WF1kCryUury8Cw15Jwb_yoWrWF47pa
	9xK3W7tr4kAFy7Cw1Iya1xua4FvasYgF43GwsYqryfAan8Aryjva10kw15ZFyUJrs0qay2
	vF4jkr1UZ3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj5tewQACsi

On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Integrity detection and protection has long been a desirable feature, t=
o
> > reach a large user base and mitigate the risk of flaws in the software
> > and attacks.
> >=20
> > However, while solutions exist, they struggle to reach the large user
> > base, due to requiring higher than desired constraints on performance,
> > flexibility and configurability, that only security conscious people ar=
e
> > willing to accept.
> >=20
> > This is where the new digest_cache LSM comes into play, it offers
> > additional support for new and existing integrity solutions, to make
> > them faster and easier to deploy.
> >=20
> > The full documentation with the motivation and the solution details can=
 be
> > found in patch 14.
> >=20
> > The IMA integration patch set will be introduced separately. Also a PoC
> > based on the current version of IPE can be provided.
>=20
> I'm not sure we want to implement a cache as a LSM.  I'm sure it would
> work, but historically LSMs have provided some form of access control,
> measurement, or other traditional security service.  A digest cache,
> while potentially useful for a variety of security related
> applications, is not a security service by itself, it is simply a file
> digest storage mechanism.

Uhm, currently the digest_cache LSM is heavily based on the LSM
infrastructure:

static struct security_hook_list digest_cache_hooks[] __ro_after_init =3D {
	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
	LSM_HOOK_INIT(path_truncate, digest_cache_path_truncate),
	LSM_HOOK_INIT(file_release, digest_cache_file_release),
	LSM_HOOK_INIT(inode_unlink, digest_cache_inode_unlink),
	LSM_HOOK_INIT(inode_rename, digest_cache_inode_rename),
	LSM_HOOK_INIT(inode_post_setxattr, digest_cache_inode_post_setxattr),
	LSM_HOOK_INIT(inode_post_removexattr,
		      digest_cache_inode_post_removexattr),
};

struct lsm_blob_sizes digest_cache_blob_sizes __ro_after_init =3D {
	.lbs_inode =3D sizeof(struct digest_cache_security),
	.lbs_file =3D sizeof(struct digest_cache *),
};

Sure, there could be a different indexing mechanism, although using the
inode security blob seems quite efficient, since resolving the path is
sufficient to find a digest cache.

Also, registering to inode_alloc/free_security allows the digest_cache
LSM to dynamically deallocate data when it is not necessary. In
addition to that, there are a number of hooks to determine whether a
digest cache should be refreshed or not.

In the past, it was part of IMA and known as IMA Digest Lists, and as a
separate module, called DIGLIM.

Both required explicit loading of the file digests are extract from to
the kernel through securityfs. Loading was done by an rpm plugin,
invoked when software is installd/removed.

That didn't look a good idea. DIGLIM does not know when the system is
under memory pressure and when digests can be evicted from memory. All
digests needed to be loaded, leading to having a big database.

I think this shortcoming has now been effectively solved by attaching
the digests to the filesystem. Digests are always there, loadable on
demand, unloadable by the system under memory pressure.

> I think it's fine if an individual LSM wants to implement a file
> digest cache as part of its own functionality, but a generalized file
> digest cache seems like something that should be part of the general
> kernel, and not implemented as a LSM.

If we keep the same design as now, it would be anyway connected to the
filesystem, but reusing the LSM infrastructure makes it very easy as I
don't require any change anywhere else.

Sure, it is not doing access control, but I haven't find another good
way to achieve the same. Do you have anything more specific in mind?

Thanks

Roberto


