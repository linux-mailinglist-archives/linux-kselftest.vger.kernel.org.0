Return-Path: <linux-kselftest+bounces-12348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0917910E09
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40501C22FD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E961B3736;
	Thu, 20 Jun 2024 17:06:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F011B3734;
	Thu, 20 Jun 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903173; cv=none; b=E5acr9EzeZEJD75Xap6IReurx0/MEyGIDzPVPFX7ib1kS7bVwYzQRLi1atKPLgXOVZ05x0+iEyQozJp35a5Q5y1dXBRU8DJx3Vv9jXBqM0w81KgIsePgwqbnxKsZ0KfhCXqJSms8PvzVXIS5U/aLwPF+41ed7BC+JBbGH5jfXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903173; c=relaxed/simple;
	bh=AoZ6D8fSBvekFvYLMvjwTYhprb4uvI1sHBlL9MIjCQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nloDgvPTAlTzHOkCi7O8avLnjHf4I1qPiBFVAjAOiqBkzkeG9aNCjY5QYfXegPJuOoTTzilbW5Z0LoIPL1lEKBlsmRd48ue975/inuqnGLtNzKUfp/MmR5Z5wPMUd3tkj0YVeVA2ObVnuM2XPazQkcAfB8v40iGaq5KcGcIRYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4W4mWr08Dbz9v7JW;
	Fri, 21 Jun 2024 00:43:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 757DF140F97;
	Fri, 21 Jun 2024 01:06:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHHDdmYXRm14LOAA--.36105S2;
	Thu, 20 Jun 2024 18:06:00 +0100 (CET)
Message-ID: <7ad255dce0b85e018b693d302689e0e970b8cc00.camel@huaweicloud.com>
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
Date: Thu, 20 Jun 2024 19:05:38 +0200
In-Reply-To: <CAHC9VhSA0dSQ1jaRO_J1S5xEc14XoCnYaVG3AWF=uYaDb-AjoQ@mail.gmail.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
	 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
	 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
	 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
	 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
	 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
	 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com>
	 <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
	 <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
	 <c96db3ab0aec6586b6d55c3055e7eb9fea6bf4e3.camel@huaweicloud.com>
	 <CAHC9VhSQOiC9t0qk10Lg3o6eAFdrR2QFLvCn1h2EP+P+AgdSbw@mail.gmail.com>
	 <c732b1eb15141f909e99247192539b7f76e9952c.camel@huaweicloud.com>
	 <CAHC9VhSA0dSQ1jaRO_J1S5xEc14XoCnYaVG3AWF=uYaDb-AjoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHHDdmYXRm14LOAA--.36105S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15tF48ur45tFWxtry7ZFb_yoWrXw4Dpa
	y7K3WUKr4ktFyxCr1Iy3W3Za4Fkry3tF17X3s8Jw15Aas09r1Ikr1SkrW5uFWDWrs7Cr12
	va1ag343Z3srAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj597OwABsq

On Thu, 2024-06-20 at 12:51 -0400, Paul Moore wrote:
> On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2024-06-20 at 12:08 -0400, Paul Moore wrote:
> > > On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > > > > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > >=20
> > > > > > > > Making it a kernel subsystem would likely mean replicating =
what the LSM
> > > > > > > > infrastructure is doing, inode (security) blob and being no=
tified about
> > > > > > > > file/directory changes.
> > > > > > >=20
> > > > > > > Just because the LSM framework can be used for something, per=
haps it
> > > > > > > even makes the implementation easier, it doesn't mean the fra=
mework
> > > > > > > should be used for everything.
> > > > > >=20
> > > > > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > > > > >=20
> > > > > > That makes it a clear target for the security subsystem, and as=
 you
> > > > > > suggested to start for IMA, if other kernel subsystems require =
them, we
> > > > > > can make it as an independent subsystem.
> > > > >=20
> > > > > Have you discussed the file digest cache functionality with eithe=
r the
> > > > > IPE or BPF LSM maintainers?  While digest_cache may support these
> > > >=20
> > > > Well, yes. I was in a discussion since long time ago with Deven and
> > > > Fan. The digest_cache LSM is listed in the Use Case section of the =
IPE
> > > > cover letter:
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-send=
-email-wufan@linux.microsoft.com/
> > >=20
> > > I would hope to see more than one sentence casually mentioning that
> > > there might be some integration in the future.
> >=20
> > Sure, I can work more with Fan to do a proper integration.
>=20
> That seems like a good pre-requisite for turning digest_cache into a
> general purpose subsystem.
>=20
> > > > I also developed an IPE module back in the DIGLIM days:
> > > >=20
> > > > https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500a9=
87121@huawei.com/
> > >=20
> > > That looks like more of an fs-verity integration to me.  Yes, of
> > > course there would be IPE changes to accept a signature/digest from a
> > > digest cache, but that should be minor.
> >=20
> > True, but IPE will also benefit from not needing to specify every
> > digest in the policy.
>=20
> Sure, but that isn't really that important from a code integration
> perspective, that's an admin policy issue.  I expect there would be
> much more integration work with fs-verity than with IPE, and I think
> the fs-verity related work might be a challenge.

Uhm, not sure what you mean, but I don't plan to touch fsverity. There
was already work to get the fsverity digest. All I would need to do
from my side is to request a digest cache for the inode being verified
by IPE and to query the fsverity digest.

Of course IPE should also capture kernel reads and verify the file
containing the reference digests, used to build the digest cache.

> > Also, the design choice of attaching the digest cache to the inode
> > helps LSMs like IPE that don't have a per inode cache on their own.
> > Sure, IPE would have to do a digest lookup every time, but at least on
> > an already populated hash table.
>=20
> Just because you need to attach some state to an inode does not mean a
> file digest cache must be a LSM.  It could be integrated into the VFS
> or it could be a separate subsystem; either way it could provide an
> API (either through well defined data structures or functions) that
> could be used by various LSMs and filesystems that provide integrity
> protection.

Given that IMA solved the same problem after 15 years, when it became
an LSM, I'm not super optimistic on that. But if VFS people or other
subsystem maintainers would be open for such alternative, I can give it
a try.

Roberto


