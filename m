Return-Path: <linux-kselftest+bounces-12400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69858911C79
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0BF1F21A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5550616937B;
	Fri, 21 Jun 2024 07:10:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649812D742;
	Fri, 21 Jun 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953847; cv=none; b=fIkL68iOGM7rMPVtZP+qQqYG05/qBnSiGQxVftYXyMPC1wSISSLCvNTwcpE6KXIQHwfxh2+FinLBhNtHRI5AN45CiAJRuUlZ+jMFm+7mA5hJe2DiRDejXrN+5eHunhjP/1W9T/IujEojXHcFoa0DMNnVEjHZoCgZ8NuOdR5LW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953847; c=relaxed/simple;
	bh=tTzUneXN/ZTgqfDOl9eH/BR2ek8SLVcP4nl2X6fxqTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NH9j5cQVas4zh+jZTx1WZQqzEuVHKbxGVJSERUaLyZkY40TZynheOy+CFIocsyffkZNN1Z4ucmudxT+Lgohdu9nNA+WMjhFvwoJLIr3TDQpiA7H4fMQFoCeics62WlOTDhhR7aXBv6pecHFv6rMlCY2OehUJB7njpQdHyfv7LpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4W57GJ3ZLdz9v7JT;
	Fri, 21 Jun 2024 14:47:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 19C85140B34;
	Fri, 21 Jun 2024 15:10:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXLDdVJ3Vm6UXYAA--.42974S2;
	Fri, 21 Jun 2024 08:10:33 +0100 (CET)
Message-ID: <63a3fc7e2ffa79fdddd3ab8ec920412d6357d07f.camel@huaweicloud.com>
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
Date: Fri, 21 Jun 2024 09:10:09 +0200
In-Reply-To: <CAHC9VhSqtdwO_C1r_uduPLdZp3o+75ojSY+B7JG6H2noEmv7VA@mail.gmail.com>
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
	 <7ad255dce0b85e018b693d302689e0e970b8cc00.camel@huaweicloud.com>
	 <CAHC9VhSqtdwO_C1r_uduPLdZp3o+75ojSY+B7JG6H2noEmv7VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXLDdVJ3Vm6UXYAA--.42974S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4rKF48Xw1DXrW5GryDJrb_yoW7GFyUpa
	y7K3WUKr4kJF17Cr1Iy3W3Za4Fyry3tF47X3s8Jw1rAFyq9r1Ikr1Ikr45uFyDWr4kCr1j
	ya12gry7Z3s8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj5uBegAAsW

On Thu, 2024-06-20 at 13:13 -0400, Paul Moore wrote:
> On Thu, Jun 20, 2024 at 1:06=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2024-06-20 at 12:51 -0400, Paul Moore wrote:
> > > On Thu, Jun 20, 2024 at 12:31=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Thu, 2024-06-20 at 12:08 -0400, Paul Moore wrote:
> > > > > On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > > > > > > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > > > > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > Making it a kernel subsystem would likely mean replicat=
ing what the LSM
> > > > > > > > > > infrastructure is doing, inode (security) blob and bein=
g notified about
> > > > > > > > > > file/directory changes.
> > > > > > > > >=20
> > > > > > > > > Just because the LSM framework can be used for something,=
 perhaps it
> > > > > > > > > even makes the implementation easier, it doesn't mean the=
 framework
> > > > > > > > > should be used for everything.
> > > > > > > >=20
> > > > > > > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > > > > > > >=20
> > > > > > > > That makes it a clear target for the security subsystem, an=
d as you
> > > > > > > > suggested to start for IMA, if other kernel subsystems requ=
ire them, we
> > > > > > > > can make it as an independent subsystem.
> > > > > > >=20
> > > > > > > Have you discussed the file digest cache functionality with e=
ither the
> > > > > > > IPE or BPF LSM maintainers?  While digest_cache may support t=
hese
> > > > > >=20
> > > > > > Well, yes. I was in a discussion since long time ago with Deven=
 and
> > > > > > Fan. The digest_cache LSM is listed in the Use Case section of =
the IPE
> > > > > > cover letter:
> > > > > >=20
> > > > > > https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-=
send-email-wufan@linux.microsoft.com/
> > > > >=20
> > > > > I would hope to see more than one sentence casually mentioning th=
at
> > > > > there might be some integration in the future.
> > > >=20
> > > > Sure, I can work more with Fan to do a proper integration.
> > >=20
> > > That seems like a good pre-requisite for turning digest_cache into a
> > > general purpose subsystem.
> > >=20
> > > > > > I also developed an IPE module back in the DIGLIM days:
> > > > > >=20
> > > > > > https://lore.kernel.org/linux-integrity/a16a628b9e21433198c4905=
00a987121@huawei.com/
> > > > >=20
> > > > > That looks like more of an fs-verity integration to me.  Yes, of
> > > > > course there would be IPE changes to accept a signature/digest fr=
om a
> > > > > digest cache, but that should be minor.
> > > >=20
> > > > True, but IPE will also benefit from not needing to specify every
> > > > digest in the policy.
> > >=20
> > > Sure, but that isn't really that important from a code integration
> > > perspective, that's an admin policy issue.  I expect there would be
> > > much more integration work with fs-verity than with IPE, and I think
> > > the fs-verity related work might be a challenge.
> >=20
> > Uhm, not sure what you mean, but I don't plan to touch fsverity. There
> > was already work to get the fsverity digest. All I would need to do
> > from my side is to request a digest cache for the inode being verified
> > by IPE and to query the fsverity digest.
>=20
> So your proposed file digest cache wouldn't be used as a replacement
> for the fs-verity digest?  Hmm.  I'll leave this up to you and Fan
> (current IPE maintainer), but I'm not sure how much value this would
> have for IPE, especially since I believe IPE's fs-verity support is
> mostly around fs-verity signatures.

The digest_cache (LSM) would store fsverity digests in the hash table.
At the moment, there is no available source for those, but they could
be included in RPM headers like regular digests.

IPE will compare the digest from fsverity with the digest queried on
the digest cache.

Roberto

> > Of course IPE should also capture kernel reads and verify the file
> > containing the reference digests, used to build the digest cache.
> >=20
> > > > Also, the design choice of attaching the digest cache to the inode
> > > > helps LSMs like IPE that don't have a per inode cache on their own.
> > > > Sure, IPE would have to do a digest lookup every time, but at least=
 on
> > > > an already populated hash table.
> > >=20
> > > Just because you need to attach some state to an inode does not mean =
a
> > > file digest cache must be a LSM.  It could be integrated into the VFS
> > > or it could be a separate subsystem; either way it could provide an
> > > API (either through well defined data structures or functions) that
> > > could be used by various LSMs and filesystems that provide integrity
> > > protection.
> >=20
> > Given that IMA solved the same problem after 15 years, when it became
> > an LSM, I'm not super optimistic on that. But if VFS people or other
> > subsystem maintainers would be open for such alternative, I can give it
> > a try.
>=20
> I think you should, because I'm not currently supportive of
> digest_cache as a standalone LSM.
>=20


