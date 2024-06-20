Return-Path: <linux-kselftest+bounces-12342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0137910D17
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7029D1F22020
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7681BB687;
	Thu, 20 Jun 2024 16:31:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1881BB682;
	Thu, 20 Jun 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901077; cv=none; b=O9YKfWSh719iYlRctzSQwOuIWawLnmW3q2291Qvwysc7GPjCc7H4bj/BNXgAodz4Jjwt1zxFvHqKidLMAZ50P2FATpVv/I8i0n5uiNhK1jEVhxHakPSISCRMAOLzGZ5IL8FNI982yu7/OrXyN8+Js7pRrUHBYFEWyIhZWtDTCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901077; c=relaxed/simple;
	bh=gTgvxw4Oyi7BJ7oODAOXGz4mQfb46ayQMJtrFK+oj3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Af5FrN3Re00zRi7sxqGe/+pdcL8sI8T0Bv9DatGhzcYQnnOCSBwBH92nv286VPEUOec4daM84tXSIblt3CLzD58XCX7wIMt+6Bs6QZYrjk1AIzjf6jMq94Nomi4hOc51PbDvmfrRG/6OeqZ8Ix/GnsvjkQ67YUCNgrRB6VkRG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W4ls91Zj1z9v7Hl;
	Fri, 21 Jun 2024 00:13:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C1E0A140857;
	Fri, 21 Jun 2024 00:30:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDn9FMqWXRmDrTMAA--.33469S2;
	Thu, 20 Jun 2024 17:30:54 +0100 (CET)
Message-ID: <c732b1eb15141f909e99247192539b7f76e9952c.camel@huaweicloud.com>
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
Date: Thu, 20 Jun 2024 18:30:31 +0200
In-Reply-To: <CAHC9VhSQOiC9t0qk10Lg3o6eAFdrR2QFLvCn1h2EP+P+AgdSbw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDn9FMqWXRmDrTMAA--.33469S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15tF47trW7Ar45KFW7Jwb_yoW5uw1Upa
	yUK3WUKr4ktFy7Cwn2ya17uayS9rW5tF17Xwn8J34rAF909r12kw1IkF45uFyUWrs5Ca42
	vF4aqry3u3s8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj596+AAAsp

On Thu, 2024-06-20 at 12:08 -0400, Paul Moore wrote:
> On Thu, Jun 20, 2024 at 11:14=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> > > On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > >=20
> > > > > > Making it a kernel subsystem would likely mean replicating what=
 the LSM
> > > > > > infrastructure is doing, inode (security) blob and being notifi=
ed about
> > > > > > file/directory changes.
> > > > >=20
> > > > > Just because the LSM framework can be used for something, perhaps=
 it
> > > > > even makes the implementation easier, it doesn't mean the framewo=
rk
> > > > > should be used for everything.
> > > >=20
> > > > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> > > >=20
> > > > That makes it a clear target for the security subsystem, and as you
> > > > suggested to start for IMA, if other kernel subsystems require them=
, we
> > > > can make it as an independent subsystem.
> > >=20
> > > Have you discussed the file digest cache functionality with either th=
e
> > > IPE or BPF LSM maintainers?  While digest_cache may support these
> >=20
> > Well, yes. I was in a discussion since long time ago with Deven and
> > Fan. The digest_cache LSM is listed in the Use Case section of the IPE
> > cover letter:
> >=20
> > https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-send-ema=
il-wufan@linux.microsoft.com/
>=20
> I would hope to see more than one sentence casually mentioning that
> there might be some integration in the future.

Sure, I can work more with Fan to do a proper integration.

> > I also developed an IPE module back in the DIGLIM days:
> >=20
> > https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500a98712=
1@huawei.com/
>=20
> That looks like more of an fs-verity integration to me.  Yes, of
> course there would be IPE changes to accept a signature/digest from a
> digest cache, but that should be minor.

True, but IPE will also benefit from not needing to specify every
digest in the policy.

Also, the design choice of attaching the digest cache to the inode
helps LSMs like IPE that don't have a per inode cache on their own.
Sure, IPE would have to do a digest lookup every time, but at least on
an already populated hash table.

> > As for eBPF, I just need to make the digest_cache LSM API callable by
> > eBPF programs, very likely not requiring any change on the eBPF
> > infrastructure itself.
>=20
> That's great, but it would be good to hear from KP and any other BPF
> LSM devs that this would be desirable.

Yes, I would also like to know their opinion. They already support
getting a file digest from IMA. Adding support for the digest_cache LSM
is a nice complement, to make security decisions based on an
authenticated source of reference digests (signature verification was
not shown in the example).

> I still believe that this is something that should live as a service
> outside of the LSM.

It will not cost me too much to plug to IMA rather than the LSM
infrastructure, but I would rather prefer the second.

I'm not aware of equivalent facilities in the kernel that would make
the digest_cache LSM work in the same way, so making it as an
independent kernel subsystem seems a too big jump for me.

Roberto


