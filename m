Return-Path: <linux-kselftest+bounces-12254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85090F39E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E38B2619A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1915D5B2;
	Wed, 19 Jun 2024 15:55:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC615CD7A;
	Wed, 19 Jun 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812559; cv=none; b=gG1pwavna5PUsq8thuMnQlV7Pyy72BsH8zKjwPWowXqSwBsiIDAmDsZb4WPzbYdUw7ajd4gEjXDvt+3TWds8DUEQaRfDru0qecw2HBii6yK/GM/HUIo91lGuGs4ZZtJkkePRiTXaocVHGgJqL4B/cnrX0QkRHGbGm6lGsdmnMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812559; c=relaxed/simple;
	bh=dHNsGU6xkEyAuCQvetJnCdniuDr5wXId58AapfKXg40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cO3xijj+Yr6DqxgE6GsxNzo/YZIubC1Egd65LZQyoCEz/P6f+QHNl8dSvXVVE5jHnHnrTx0KAruDc6hGUcDlDgidT+ZNTOrpYUIL9ItBt62R95kIZsb695y6V4/9QooogWAV05krElNEh9Cr2m+qac4V0yQJz/2le1Ir85GItGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W476w62NGz9v7Hm;
	Wed, 19 Jun 2024 23:38:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A962A140A12;
	Wed, 19 Jun 2024 23:55:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHDjlo_3Jm_e28AA--.55865S2;
	Wed, 19 Jun 2024 16:55:39 +0100 (CET)
Message-ID: <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
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
Date: Wed, 19 Jun 2024 17:55:16 +0200
In-Reply-To: <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
	 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
	 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHDjlo_3Jm_e28AA--.55865S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7Aw13Kr1xJr1fGr4kWFg_yoW5JFW8pF
	W7K3WUKr4qvFW3Cr1Iv3WxZ3yrKryYqF47Xws8Xw1Yvwn0vr9Fkr4rKF45uFWkWrsIy3W2
	vFW7KFyfuw1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj59oNQAAsl

On Wed, 2024-06-19 at 11:49 -0400, Paul Moore wrote:
> On Wed, Jun 19, 2024 at 3:59=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > > On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Integrity detection and protection has long been a desirable featur=
e, to
> > > > reach a large user base and mitigate the risk of flaws in the softw=
are
> > > > and attacks.
> > > >=20
> > > > However, while solutions exist, they struggle to reach the large us=
er
> > > > base, due to requiring higher than desired constraints on performan=
ce,
> > > > flexibility and configurability, that only security conscious peopl=
e are
> > > > willing to accept.
> > > >=20
> > > > This is where the new digest_cache LSM comes into play, it offers
> > > > additional support for new and existing integrity solutions, to mak=
e
> > > > them faster and easier to deploy.
> > > >=20
> > > > The full documentation with the motivation and the solution details=
 can be
> > > > found in patch 14.
> > > >=20
> > > > The IMA integration patch set will be introduced separately. Also a=
 PoC
> > > > based on the current version of IPE can be provided.
> > >=20
> > > I'm not sure we want to implement a cache as a LSM.  I'm sure it woul=
d
> > > work, but historically LSMs have provided some form of access control=
,
> > > measurement, or other traditional security service.  A digest cache,
> > > while potentially useful for a variety of security related
> > > applications, is not a security service by itself, it is simply a fil=
e
> > > digest storage mechanism.
> >=20
> > Uhm, currently the digest_cache LSM is heavily based on the LSM
> > infrastructure:
>=20
> I understand that, but as I said previously, I don't believe that we
> want to support a LSM which exists solely to provide a file digest
> cache.  LSMs should be based around the idea of some type of access
> control, security monitoring, etc.
>=20
> Including a file digest cache in IMA, or implementing it as a
> standalone piece of kernel functionality, are still options.  If you
> want to pursue this, I would suggest that including the digest cache
> as part of IMA would be the easier of the two options; if it proves to
> be generally useful outside of IMA, it can always be abstracted out to
> a general kernel module/subsystem.

Ok. I thought about IPE and eBPF as potential users. But if you think
that adding as part of IMA would be easier, I could try to pursue that.

Thanks

Roberto


