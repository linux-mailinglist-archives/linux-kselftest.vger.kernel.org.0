Return-Path: <linux-kselftest+bounces-12347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB65910DB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9671281647
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF81B29D3;
	Thu, 20 Jun 2024 16:55:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54317545;
	Thu, 20 Jun 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902512; cv=none; b=Adf1ayNPlE7o+ICF6yYHIOuZYF7gXkNFW21AbrEviYIu8XwpAKjAoegKiAgkjtTRYzIvKFl8IR5M4xY3nggGDAakDpGqdcasFO07+Wa6qDJKRpH4i4sN7ruClGoC9R5wAKo5gtBvPaQkqCKs1z0YsN1SxUVGR/dq2uIEvvZBUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902512; c=relaxed/simple;
	bh=n/OylNdLLua5A6nOl8x8qWlFN4KVendP+QyGaek6KKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQXRB/Frh6a5EZjL0eI3IAzf6MWP+lCm0bcLazoXnSXJDemUZjdMNjIc8Qmq39rD1iSa/Nx1QbWw6G+eQGoZzQbUheshvuTdG9RYQehVGNNWvajgJ1+srLlwXgKpXj6sOh9gw8DZH3Jrgf4eY93Uy7hbWTyS6dYOrND0O4sRHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4W4mH545g5z9v7JT;
	Fri, 21 Jun 2024 00:32:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8FBD4140B1F;
	Fri, 21 Jun 2024 00:54:56 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3vznJXnRmXGHOAA--.2808S2;
	Thu, 20 Jun 2024 17:54:55 +0100 (CET)
Message-ID: <027480a3afbdba9a0bc630d65a4907b624610fec.camel@huaweicloud.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Dr. Greg" <greg@enjellic.com>
Cc: Paul Moore <paul@paul-moore.com>, corbet@lwn.net, jmorris@namei.org, 
 serge@hallyn.com, akpm@linux-foundation.org, shuah@kernel.org, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, mic@digikod.net, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 20 Jun 2024 18:54:30 +0200
In-Reply-To: <20240620163234.GA27816@wind.enjellic.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
	 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
	 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
	 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
	 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
	 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
	 <20240620163234.GA27816@wind.enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA3vznJXnRmXGHOAA--.2808S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr47Kr4DZFy7tw17uF4kJFb_yoW3Kr1fpF
	W7K3WUKr4ktrW7Cr4Iva17ZaySqrW3JrW7XrZ8Jw15Zrn0kry7Kr1IkF45uFyDWr4fA3W2
	va12qr9ruw1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkvb40E47kJMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5lNt7
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj597MgAAsi

On Thu, 2024-06-20 at 11:32 -0500, Dr. Greg wrote:
> On Wed, Jun 19, 2024 at 06:37:49PM +0200, Roberto Sassu wrote:
>=20
> Good morning Roberto, I hope your week is going well, greetings to
> everyone copied else as well.
>=20
> > On Wed, 2024-06-19 at 12:34 -0400, Paul Moore wrote:
> > > On Wed, Jun 19, 2024 at 11:55???AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Wed, 2024-06-19 at 11:49 -0400, Paul Moore wrote:
> > > > > On Wed, Jun 19, 2024 at 3:59???AM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > > > > > > On Mon, Apr 15, 2024 at 10:25???AM Roberto Sassu
> > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > >=20
> > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > >=20
> > > > > > > > Integrity detection and protection has long been a desirabl=
e feature, to
> > > > > > > > reach a large user base and mitigate the risk of flaws in t=
he software
> > > > > > > > and attacks.
> > > > > > > >=20
> > > > > > > > However, while solutions exist, they struggle to reach the =
large user
> > > > > > > > base, due to requiring higher than desired constraints on p=
erformance,
> > > > > > > > flexibility and configurability, that only security conscio=
us people are
> > > > > > > > willing to accept.
> > > > > > > >=20
> > > > > > > > This is where the new digest_cache LSM comes into play, it =
offers
> > > > > > > > additional support for new and existing integrity solutions=
, to make
> > > > > > > > them faster and easier to deploy.
> > > > > > > >=20
> > > > > > > > The full documentation with the motivation and the solution=
 details can be
> > > > > > > > found in patch 14.
> > > > > > > >=20
> > > > > > > > The IMA integration patch set will be introduced separately=
. Also a PoC
> > > > > > > > based on the current version of IPE can be provided.
> > > > > > >=20
> > > > > > > I'm not sure we want to implement a cache as a LSM.  I'm sure=
 it would
> > > > > > > work, but historically LSMs have provided some form of access=
 control,
> > > > > > > measurement, or other traditional security service.  A digest=
 cache,
> > > > > > > while potentially useful for a variety of security related
> > > > > > > applications, is not a security service by itself, it is simp=
ly a file
> > > > > > > digest storage mechanism.
> > > > > >=20
> > > > > > Uhm, currently the digest_cache LSM is heavily based on the LSM
> > > > > > infrastructure:
> > > > >=20
> > > > > I understand that, but as I said previously, I don't believe that=
 we
> > > > > want to support a LSM which exists solely to provide a file diges=
t
> > > > > cache.  LSMs should be based around the idea of some type of acce=
ss
> > > > > control, security monitoring, etc.
> > > > >=20
> > > > > Including a file digest cache in IMA, or implementing it as a
> > > > > standalone piece of kernel functionality, are still options.  If =
you
> > > > > want to pursue this, I would suggest that including the digest ca=
che
> > > > > as part of IMA would be the easier of the two options; if it prov=
es to
> > > > > be generally useful outside of IMA, it can always be abstracted o=
ut to
> > > > > a general kernel module/subsystem.
> > > >=20
> > > > Ok. I thought about IPE and eBPF as potential users. But if you thi=
nk
> > > > that adding as part of IMA would be easier, I could try to pursue t=
hat.
> > >=20
> > > It isn't clear to me how this would interact with IPE and/or eBPF, bu=
t
> > > if you believe there is value there I would encourage you to work wit=
h
> > > those subsystem maintainers.  If the consensus is that a general file
> > > digest cache is useful then you should pursue the digest cache as a
> > > kernel subsystem, just not a LSM.
>=20
> > Making it a kernel subsystem would likely mean replicating what the LSM
> > infrastructure is doing, inode (security) blob and being notified about
> > file/directory changes.
> >=20
> > I guess I will go for the IMA route...
>=20
> This thread brings up an issue that we have been thinking about but
> has been on the back burner.
>=20
> Roberto, I'm assuming you have seen our TSEM submissions go by.  Our
> V4 release will be immediately after the Fourth of July holiday week
> here in the states.
>=20
> Since TSEM implements a generic security modeling framework for the
> kernel, it ends up implementing a superset of IMA functionality.  That
> required us to implement our own file digest generation and cacheing
> infrastructure.
>=20
> Given the trajectory that things are on with respect to security,
> there is only going to be more demand for file digests and their
> associated cacheing.  Doesn't seem like it makes a lot of sense to
> have multiple teams replicating what is largely the same
> functionality.
>=20
> If your group would have interest, we would certainly be willing to
> entertain conversations on how we could collaborate to brew up
> something that would be of mutual benefit to everyone who has a need
> for this type of infrastructure.

Hi Greg

sure, I would be happy to give you more details on how the digest_cache
LSM works and how you could make use of it.

> As you noted, consumers of the BPF LSM would also be a clear candidate
> for generic infrastructure.  One of the issues blocking a BPF based
> integrity implementation is that BPF itself is not going to be able
> generate digests on its own.  So it would seem to make sense to have
> whatever gets built have a kfunc accessible API.  Plenty of other
> additional warts on that front as well but getting access to digests
> is the necessary starting point.

Yes, adding a few kfuncs is what I had in mind.

> Given what we have seen with IMA's challenge with respect to overlayfs
> issues and file versioning issues in general, it would seem to be of
> profit to have all these issues addressed uniformally and in one
> place.
>=20
> Since virtually everything that is accessing this infrastructure is
> going to be an LSM, we would envision API's out of a common
> infrastructure, invoked by the event handlers of the various LSM's
> interested in integrity information, driving the cache generation and
> maintenance.  That would seem to have all of the benefits of being
> implemented by the LSM infrastructure without necessarily being an
> 'LSM' in and of itself.

Yes, this is exactly how it works. There is a generic API for users to
get a digest cache and query it. The LSM infrastructure is needed for
attaching data to an inode and for being notified of file backend
changes.

The digest_cache LSM makes it transparent for its users the process of
retrieving the reference digest for a given file whose integrity should
be checked, and allows those users to simply query the calculated file
digest.

> We assume that everyone would want to maintain the O(1) lookup
> characteristics of what the LSM inode blob mechanism provides.  We
> would presume that a common cacheing architecture would return a
> pointer to the structure that the digest cache maintains describing
> the various digests associated with the contents of a file, as there
> will be a need for multiple digest support, when an LSM hands the
> cache an inode referencing a file.  An LSM could then place that
> pointer in its own inode blob for future reference.

That was what initially thought and implemented. But I realized that
pinning the digest cache to other inode security blobs makes it more
difficult to free the digest cache (when its reference count goes to
zero).

I opted instead for releasing a digest cache when not in use, and for
introducing a notification mechanism, similar to what LSMs use to
notify about policy changes, which reports when the file backend
changes, so that LSMs can invalidate their decision based on the
affected digest cache. This mechanism is already working in IMA:

https://lore.kernel.org/linux-integrity/20240415161044.2572438-10-roberto.s=
assu@huaweicloud.com/

> Either that, probably better, stick a pointer into the inode structure
> itself that references it's digest cache object and it would get
> populated by the first event that opens the associated file.

Yes, the digest cache pointer is stored both in the inode that should
be verified with the digest cache, and in the inode the digest cache
was created from. The first reference avoids retrieving the link file-
package every time a digest cache is requested for that inode.

> > Roberto
>=20
> So an open invitation to anyone that would want to discuss
> requirements around a common implementation.
>=20
> Have a good weekend.

Thanks, the same to you.

Roberto

> As always,
> Dr. Greg
>=20
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project


