Return-Path: <linux-kselftest+bounces-12257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09590F42A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD31B20F85
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCB1534E9;
	Wed, 19 Jun 2024 16:38:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F031D54A;
	Wed, 19 Jun 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815109; cv=none; b=ec5jHiuIaH8pnJkgJXabmoPl4ZDumPHJzbfnfM+jQwPZNeB8EdszVNnwRw93eYZl3Yh69WftSAtJTow7c5+zONN0R9uU31vHjCV/LG8AlhKmYvEh8+hecRC4B0UgVsIaPQe27bORNg+fSETCHF+z40mUpcPqubMGXfnuoR2irDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815109; c=relaxed/simple;
	bh=NHchRoi/0zQ2fsMrrnKC/Owr0Ktvs/1FYWkF5bGopZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxNeKJjw25TJjcW1Il8Wvm6PqiztDnVQsEGc0QhmUMKUMj0oCf1q2CjtFX4axgo2W2DqKp/ZviqVmkeSdwaUDMcGNwuZeDeVEapNKmjjVoInBU/FOexfLMyrEWzdWzB7PN8UNlZ0rLNPYXvewry9LJYRYUGXcckp8UK0IiRBc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4W484459Dyz9v7Hl;
	Thu, 20 Jun 2024 00:20:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E10BE1409C9;
	Thu, 20 Jun 2024 00:38:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3jDdgCXNmkmy9AA--.11796S2;
	Wed, 19 Jun 2024 17:38:12 +0100 (CET)
Message-ID: <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
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
Date: Wed, 19 Jun 2024 18:37:49 +0200
In-Reply-To: <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
	 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
	 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
	 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
	 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC3jDdgCXNmkmy9AA--.11796S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1xXw15KFyDKF1kuw1DGFg_yoW5uryfpF
	W7K3WUKr4vqFW3Cr1Iv3W7Z3yrKrWaqr47Xrs8Jw15Arn0vr9rGr4rKF45uFykWr4Yk3W2
	vFW2gFy7uw1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj59oyQAAsZ

On Wed, 2024-06-19 at 12:34 -0400, Paul Moore wrote:
> On Wed, Jun 19, 2024 at 11:55=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2024-06-19 at 11:49 -0400, Paul Moore wrote:
> > > On Wed, Jun 19, 2024 at 3:59=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > > > > On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > >=20
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > >=20
> > > > > > Integrity detection and protection has long been a desirable fe=
ature, to
> > > > > > reach a large user base and mitigate the risk of flaws in the s=
oftware
> > > > > > and attacks.
> > > > > >=20
> > > > > > However, while solutions exist, they struggle to reach the larg=
e user
> > > > > > base, due to requiring higher than desired constraints on perfo=
rmance,
> > > > > > flexibility and configurability, that only security conscious p=
eople are
> > > > > > willing to accept.
> > > > > >=20
> > > > > > This is where the new digest_cache LSM comes into play, it offe=
rs
> > > > > > additional support for new and existing integrity solutions, to=
 make
> > > > > > them faster and easier to deploy.
> > > > > >=20
> > > > > > The full documentation with the motivation and the solution det=
ails can be
> > > > > > found in patch 14.
> > > > > >=20
> > > > > > The IMA integration patch set will be introduced separately. Al=
so a PoC
> > > > > > based on the current version of IPE can be provided.
> > > > >=20
> > > > > I'm not sure we want to implement a cache as a LSM.  I'm sure it =
would
> > > > > work, but historically LSMs have provided some form of access con=
trol,
> > > > > measurement, or other traditional security service.  A digest cac=
he,
> > > > > while potentially useful for a variety of security related
> > > > > applications, is not a security service by itself, it is simply a=
 file
> > > > > digest storage mechanism.
> > > >=20
> > > > Uhm, currently the digest_cache LSM is heavily based on the LSM
> > > > infrastructure:
> > >=20
> > > I understand that, but as I said previously, I don't believe that we
> > > want to support a LSM which exists solely to provide a file digest
> > > cache.  LSMs should be based around the idea of some type of access
> > > control, security monitoring, etc.
> > >=20
> > > Including a file digest cache in IMA, or implementing it as a
> > > standalone piece of kernel functionality, are still options.  If you
> > > want to pursue this, I would suggest that including the digest cache
> > > as part of IMA would be the easier of the two options; if it proves t=
o
> > > be generally useful outside of IMA, it can always be abstracted out t=
o
> > > a general kernel module/subsystem.
> >=20
> > Ok. I thought about IPE and eBPF as potential users. But if you think
> > that adding as part of IMA would be easier, I could try to pursue that.
>=20
> It isn't clear to me how this would interact with IPE and/or eBPF, but
> if you believe there is value there I would encourage you to work with
> those subsystem maintainers.  If the consensus is that a general file
> digest cache is useful then you should pursue the digest cache as a
> kernel subsystem, just not a LSM.

Making it a kernel subsystem would likely mean replicating what the LSM
infrastructure is doing, inode (security) blob and being notified about
file/directory changes.

I guess I will go for the IMA route...

Roberto



