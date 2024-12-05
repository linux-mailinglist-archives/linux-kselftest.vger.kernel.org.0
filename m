Return-Path: <linux-kselftest+bounces-22875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424559E5B23
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D6C167C16
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566321C9FF;
	Thu,  5 Dec 2024 16:17:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CE1B59A;
	Thu,  5 Dec 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415434; cv=none; b=LoYFPpssgsL7KHp/+Aef23D1WgpW+Bzs+UReuLc8KmX8pYXKOZH1+mrcUY6k4Fvo0oqN3VM/PFYujTh6C7DKMMENOmxTi3OlKK6pBx8NQjJzYOH0Vgo5pMbMINLpQ+Fjsr+KgodSqunOZOMrHdduCq3DgCYuHoBhrudMylnYqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415434; c=relaxed/simple;
	bh=24u3NV3S+df1el9+yMHZsdL7yPqcdKjB/Z3S9Hz4PEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k5h2sFQuABhrlNKglSlkDVtXQxtSDQO4HllT2a+4QHU7F23yRMR5DLv2lF2wgQ1ju/iKQc9SQLmzoJCl0VUM5D2epmeuo41TZ8UUmMnNuR8s02cI9b84BYs10Z/HJMxrS9UPH5d3QmOlmON0uWGNzkgP69hjrYHwYNz32TxmBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y3zWZ1Lzsz9v7Vs;
	Thu,  5 Dec 2024 23:55:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E00BB140FA5;
	Fri,  6 Dec 2024 00:17:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3kYDt0VFnefHjAg--.35558S2;
	Thu, 05 Dec 2024 17:17:04 +0100 (CET)
Message-ID: <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
Subject: Re: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>, 
 "mcgrof@kernel.org" <mcgrof@kernel.org>, "petr.pavlu@suse.com"
 <petr.pavlu@suse.com>,  "samitolvanen@google.com"
 <samitolvanen@google.com>, "da.gomez@samsung.com" <da.gomez@samsung.com>, 
 Andrew Morton <akpm@linux-foundation.org>, "paul@paul-moore.com"
 <paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>,
 "serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>,  "alexandre.torgue@foss.st.com"
 <alexandre.torgue@foss.st.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org"
 <linux-api@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "wufan@linux.microsoft.com"
 <wufan@linux.microsoft.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
  "zbyszek@in.waw.pl" <zbyszek@in.waw.pl>, "hch@lst.de" <hch@lst.de>,
 "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "pmatilai@redhat.com"
 <pmatilai@redhat.com>,  "jannh@google.com" <jannh@google.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,  "jikos@kernel.org"
 <jikos@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "ppavlu@suse.com" <ppavlu@suse.com>, "petr.vorel@gmail.com"
 <petr.vorel@gmail.com>,  "mzerqung@0pointer.de" <mzerqung@0pointer.de>,
 "kgold@linux.ibm.com" <kgold@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 05 Dec 2024 17:16:41 +0100
In-Reply-To: <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
	 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
	 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
	 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
	 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
	 <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3kYDt0VFnefHjAg--.35558S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15CF1xXw47XrWkXFWxCrg_yoWxCFyfpa
	yrKa13Kr4kXr1Fkwn2ya18XF1Fk3yftr15Xwn8Gry5CrZ09r9F9r1xKa15uFyDGr18Gr12
	vr1aga47Cr4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBGdRD7YO4wAAsv

On Thu, 2024-12-05 at 09:53 +0100, Roberto Sassu wrote:
> On Thu, 2024-12-05 at 00:57 +0000, Eric Snowberg wrote:
> >=20
> > > On Dec 4, 2024, at 3:44=E2=80=AFAM, Roberto Sassu <roberto.sassu@huaw=
eicloud.com> wrote:
> > >=20
> > > On Tue, 2024-12-03 at 20:06 +0000, Eric Snowberg wrote:
> > > >=20
> > > > > On Nov 26, 2024, at 3:41=E2=80=AFAM, Roberto Sassu <roberto.sassu=
@huaweicloud.com> wrote:
> > > > >=20
> > > > > On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
> > > > > >=20
> > > > > > > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <roberto.s=
assu@huaweicloud.com> wrote:
> > > > > > >=20
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > >=20
> > > > > > > The Integrity Digest Cache can also help IMA for appraisal. I=
MA can simply
> > > > > > > lookup the calculated digest of an accessed file in the list =
of digests
> > > > > > > extracted from package headers, after verifying the header si=
gnature. It is
> > > > > > > sufficient to verify only one signature for all files in the =
package, as
> > > > > > > opposed to verifying a signature for each file.
> > > > > >=20
> > > > > > Is there a way to maintain integrity over time?  Today if a CVE=
 is discovered=20
> > > > > > in a signed program, the program hash can be added to the black=
list keyring.=20
> > > > > > Later if IMA appraisal is used, the signature validation will f=
ail just for that=20
> > > > > > program.  With the Integrity Digest Cache, is there a way to do=
 this? =20
> > > > >=20
> > > > > As far as I can see, the ima_check_blacklist() call is before
> > > > > ima_appraise_measurement(). If it fails, appraisal with the Integ=
rity
> > > > > Digest Cache will not be done.
> > > >=20
> > > >=20
> > > > It is good the program hash would be checked beforehand and fail if=
 it is=20
> > > > contained on the list.=20
> > > >=20
> > > > The .ima keyring may contain many keys.  If one of the keys was lat=
er=20
> > > > revoked and added to the .blacklist, wouldn't this be missed?  It w=
ould=20
> > > > be caught during signature validation when the file is later apprai=
sed, but=20
> > > > now this step isn't taking place.  Correct?
> > >=20
> > > For files included in the digest lists, yes, there won't be detection
> > > of later revocation of a key. However, it will still work at package
> > > level/digest list level, since they are still appraised with a
> > > signature.
> > >=20
> > > We can add a mechanism (if it does not already exist) to invalidate t=
he
> > > integrity status based on key revocation, which can be propagated to
> > > files verified with the affected digest lists.
> > >=20
> > > > With IMA appraisal, it is easy to maintain authenticity but challen=
ging to=20
> > > > maintain integrity over time. In user-space there are constantly ne=
w CVEs. =20
> > > > To maintain integrity over time, either keys need to be rotated in =
the .ima=20
> > > > keyring or program hashes need to be frequently added to the .black=
list.  =20
> > > > If neither is done, for an end-user on a distro, IMA-appraisal basi=
cally=20
> > > > guarantees authenticity.
> > > >=20
> > > > While I understand the intent of the series is to increase performa=
nce,=20
> > > > have you considered using this to give the end-user the ability to =
maintain=20
> > > > integrity of their system?  What I mean is, instead of trying to im=
port anything=20
> > > > from an RPM, just have the end-user provide this information in som=
e format=20
> > > > to the Digest Cache.  User-space tools could be built to collect an=
d format=20
> > >=20
> > > This is already possible, digest-cache-tools
> > > (https://github.com/linux-integrity/digest-cache-tools) already allow
> > > to create a digest list with the file a user wants.
> > >=20
> > > But in this case, the user is vouching for having taken the correct
> > > measure of the file at the time it was added to the digest list. This
> > > would be instead automatically guaranteed by RPMs or other packages
> > > shipped with Linux distributions.
> > >=20
> > > To mitigate the concerns of CVEs, we can probably implement a rollbac=
k
> > > prevention mechanism, which would not allow to load a previous versio=
n
> > > of a digest list.
> >=20
> > IMHO, pursuing this with the end-user being in control of what is conta=
ined=20
> > within the Digest Cache vs what is contained in a distro would provide =
more
> > value. Allowing the end-user to easily update their Digest Cache in som=
e way=20
> > without having to do any type of revocation for both old and vulnerable=
=20
> > applications with CVEs would be very beneficial.
>=20
> Yes, deleting the digest list would invalidate any integrity result
> done with that digest list.
>=20
> I developed also an rpm plugin that synchronizes the digest lists with
> installed software. Old vulnerable software cannot be verified anymore
> with the Integrity Digest Cache, since the rpm plugin deletes the old
> software digest lists.
>=20
> https://github.com/linux-integrity/digest-cache-tools/blob/main/rpm-plugi=
n/digest_cache.c
>=20
> The good thing is that the Integrity Digest Cache can be easily
> controlled with filesystem operations (it works similarly to security
> blobs attached to kernel objects, like inodes and file descriptors).
>=20
> As soon as something changes (e.g. digest list written, link to the
> digest lists), this triggers a reset in the Integrity Digest Cache, so
> digest lists and files need to be verified again. Deleting the digest
> list causes the in-kernel digest cache to be wiped away too (when the
> reference count reaches zero).
>=20
> > Is there a belief the Digest Cache would be used without signed kernel=
=20
> > modules?  Is the performance gain worth changing how kernel modules=20
> > get loaded at boot?  Couldn't this part just be dropped for easier acce=
ptance? =20
> > Integrity is already maintained with the current model of appended sign=
atures.=20
>=20
> I don't like making exceptions in the design, and I recently realized
> that it should not be task of the users of the Integrity Digest Cache
> to limit themselves.

Forgot to mention that your use case is possible. The usage of the
Integrity Digest Cache must be explicitly enabled in the IMA policy. It
will be used if the matching rule has 'digest_cache=3Ddata' (its foreseen
to be used also for metadata).

For kernel modules, it is sufficient to not provide that keyword for
the MODULE_CHECK hook.

However, there is the possibility that you lose another advantage of
the Integrity Digest Cache, the predictability of the IMA PCR. By not
using digest caches, there is the risk that the IMA PCR will be
unstable, due to loading kernel modules in a different order at each
boot.

Roberto


> But the main problem was not the kernel modules themselves, but the
> infrastructure needed in user space to load them, which might not be
> available at the time a digest list parser needs to be loaded.
>=20
> I hope ksys_finit_module() does not cause too much resistance (however
> I need to document it better, as others noted). It is just a different
> way to pass the same parameters of the finit_module() system call.
>=20
> Thanks
>=20
> Roberto


