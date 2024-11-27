Return-Path: <linux-kselftest+bounces-22583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A79DACBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CCE282171
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5E201038;
	Wed, 27 Nov 2024 17:57:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEC1F9EDC;
	Wed, 27 Nov 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730245; cv=none; b=hKER0Im2Nl5cW91lI8Ambd5N9fqR4sehmyFzVvBYc6y843rSOA+2/tpffXASUIVa7dVC/KTMWMIY5H2RlDRKgOxtvI6B3zAQsUcx6TkGS/mWLsReI8FglIY85c8EmW558/J+uDYuxfGXEp1yhlPi7oZWoHKxDhoOImU+XJ08SgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730245; c=relaxed/simple;
	bh=x1kowV5XL3Zqxu+IDAagYEQKyPRxx7DwTqSCw5LeAnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apTLwCG0rCyoKbDxHp0klUTvJUl2lDkHvySstI3k1Jwe2fdOqCwQ+1FhaCHC2qYKyACQ3/2VJWVTLG8AlZLLXWvJL0zTktTJl+qezOVlrXkOFZZRzhsuxxIymvZRDo3bKSvtMMXxShOvQsPAoDN8RyR+KavLjEONLbJuewScZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xz6732N50z9v7Nb;
	Thu, 28 Nov 2024 01:36:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 19E9D140392;
	Thu, 28 Nov 2024 01:57:17 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3aDljXUdnvqlmAg--.45319S2;
	Wed, 27 Nov 2024 18:57:16 +0100 (CET)
Message-ID: <8b7d0c280ae51f619c0e57379824a858de463098.camel@huaweicloud.com>
Subject: Re: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Dr. Greg" <greg@enjellic.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, mcgrof@kernel.org,
 petr.pavlu@suse.com, samitolvanen@google.com,  da.gomez@samsung.com,
 akpm@linux-foundation.org, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Wed, 27 Nov 2024 18:56:47 +0100
In-Reply-To: <20241127173042.GA1649@wind.enjellic.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241127173042.GA1649@wind.enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD3aDljXUdnvqlmAg--.45319S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1ktrW8Kw17Cw4kAr1rCrg_yoW7Gw4fpa
	93Kay5Kr4kJFWxCFs2y3WfurWFk3yrtw4UWrn8W348Ary5ur1I9w10ka1UuF9rGrn2ya12
	vr4Uta4UC3s0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUBDDGUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGdGg-MHRgABsX

On Wed, 2024-11-27 at 11:30 -0600, Dr. Greg wrote:
> On Tue, Nov 19, 2024 at 11:49:07AM +0100, Roberto Sassu wrote:
>=20
> Hi Roberto, I hope the week is going well for you.
>=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Integrity detection and protection has long been a desirable feature, t=
o
> > reach a large user base and mitigate the risk of flaws in the software
> > and attacks.
> >=20
> > However, while solutions exist, they struggle to reach a large user bas=
e,
> > due to requiring higher than desired constraints on performance,
> > flexibility and configurability, that only security conscious people ar=
e
> > willing to accept.
> >=20
> > For example, IMA measurement requires the target platform to collect
> > integrity measurements, and to protect them with the TPM, which introdu=
ces
> > a noticeable overhead (up to 10x slower in a microbenchmark) on frequen=
tly
> > used system calls, like the open().
> >=20
> > IMA Appraisal currently requires individual files to be signed and
> > verified, and Linux distributions to rebuild all packages to include fi=
le
> > signatures (this approach has been adopted from Fedora 39+). Like a TPM=
,
> > also signature verification introduces a significant overhead, especial=
ly
> > if it is used to check the integrity of many files.
> >=20
> > This is where the new Integrity Digest Cache comes into play, it offers
> > additional support for new and existing integrity solutions, to make
> > them faster and easier to deploy.
> >=20
> > The Integrity Digest Cache can help IMA to reduce the number of TPM
> > operations and to make them happen in a deterministic way. If IMA knows
> > that a file comes from a Linux distribution, it can measure files in a
> > different way: measure the list of digests coming from the distribution
> > (e.g. RPM package headers), and subsequently measure a file if it is no=
t
> > found in that list.
> >=20
> > The performance improvement comes at the cost of IMA not reporting whic=
h
> > files from installed packages were accessed, and in which temporal
> > sequence. This approach might not be suitable for all use cases.
> >=20
> > The Integrity Digest Cache can also help IMA for appraisal. IMA can sim=
ply
> > lookup the calculated digest of an accessed file in the list of digests
> > extracted from package headers, after verifying the header signature. I=
t is
> > sufficient to verify only one signature for all files in the package, a=
s
> > opposed to verifying a signature for each file.
>=20
> Roberto, a big picture question for you, our apologies if we
> completely misunderstand your patch series.

Hi Greg

no need to apologise, happy to answer your questions.

> The performance benefit comes from the fact that the kernel doesn't
> have to read a file and calculate the cryptographic digest when the
> file is accessed.  The 'trusted' digest value comes from a signed list
> of digests that a packaging entity provides and the kernel validates.
> So there is an integrity guarantee that the supplied digests were the
> same as when the package was built.

The performance benefit (for appraisal with my benchmark: 65% with
sequential file access and 43% with parallel file access) comes from
verifying the ECDSA signature of 303 digest lists, as opposed to the
ECDSA signature of 12312 files.

The additional performance boost due to switching from file data digest
to fsverity digests is on top of that.

> Is there a guarantee implemented, that we missed, that the on-disk
> file actually has the digest value that was initially generated by the
> packaging entity when the file is accessed operationally?

Yes, the guarantee is provided by IMA by measuring the actual file
digest and searching it in a digest cache. The integration in IMA of
the Integrity Digest Cache is done in a separate patch set:

https://lore.kernel.org/linux-security-module/20241119110103.2780453-1-robe=
rto.sassu@huaweicloud.com/

The integrity evaluation result is invalidated when the file is
modified, or when the digest list used to verify the file is modified
too.

For fsverity, the guarantee similarly comes from searching the fsverity
digest in a digest cache, but as opposed of IMA the integrity
evaluation result does not need to be invalidated for a file write,
since fsverity-protected files are accessible only in read-only mode.
However, the result still needs to be invalidated if the digest list
changes.

> Secondly, and in a related issue, what happens in a container
> environment when a pathname is accessed that is actually a different
> file but with the same effective pathname as a file that is in the
> vendor validated digest list?

At the moment nothing, only the file data are evaluated. Currently, the
Integrity Digest Cache does not store the pathnames associated to a
digest. It can be done as an extension, if desired, and the pathnames
can be compared.

Roberto

> Once again, apologies, if we completely misinterpret the issues
> involved.
>=20
> Have a good remainder of the week.
>=20
> As always,
> Dr. Greg
>=20
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project


