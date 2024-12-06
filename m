Return-Path: <linux-kselftest+bounces-22910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B741F9E6B4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 11:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695F1283D08
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782331F4737;
	Fri,  6 Dec 2024 10:07:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78221EC013;
	Fri,  6 Dec 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479663; cv=none; b=ovqiKIdKwjFm0Kv/4uVH6XvjWFMlnZX4nUzCN5k5PiIi7OX4yc4og0Qk64L5/6b21HdD8mkzLRo58AfQ2yqI2fnn6Ofj/e0WzT2REziPusgy3IRAL8gCBeuxxMAE38WTIe7NBwY82vl6MfK7LAxqieLu5ivoD7zf+YvhwsoJlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479663; c=relaxed/simple;
	bh=wCskiwZPxJocfyRr8Lpw6NVFf60Ktp7E+Fe64hQVv+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZG4c2JdgdxTmmvgx9UzqHxWgxoWUI/oQ1Zp8qGfdgwSXW1t4P+ULKQiA92rLc7rPwpIxMwzpJxdUU0egzDF0kZpy93+TEpoWnqoLaaW2FnITYOaRevrsMKzRIfoJxhu2XZ5HXoZcQil0g+rlyX5aageB8/LrPSUOb6qL5DZWV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4RGd0ypFz9v7Vc;
	Fri,  6 Dec 2024 17:46:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 023FF1404C4;
	Fri,  6 Dec 2024 18:07:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHtyfGzFJnF8jsAg--.57474S2;
	Fri, 06 Dec 2024 11:07:21 +0100 (CET)
Message-ID: <d7eb63db3ee2c04fc92efe30dc9c1eadabd3f61a.camel@huaweicloud.com>
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
Date: Fri, 06 Dec 2024 11:06:59 +0100
In-Reply-To: <F9EE3709-2A90-4E9A-8531-44EC0F9C240C@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
	 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
	 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
	 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
	 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
	 <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
	 <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
	 <F9EE3709-2A90-4E9A-8531-44EC0F9C240C@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHtyfGzFJnF8jsAg--.57474S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15CF1xKw13WFWfAFW5Jrb_yoWfJryfpa
	y5K3W7KF4kJr1Skrn2y3WrXF4Fk3yftr1UXwn8Jry5Cr909r10vr1xKr45uFyDWr18Gr12
	vr1aga47Ar1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGdSYXQEkgABs4

On Thu, 2024-12-05 at 19:41 +0000, Eric Snowberg wrote:
>=20
> > On Dec 5, 2024, at 9:16=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawei=
cloud.com> wrote:
> >=20
> > On Thu, 2024-12-05 at 09:53 +0100, Roberto Sassu wrote:
> > > On Thu, 2024-12-05 at 00:57 +0000, Eric Snowberg wrote:
> > > >=20
> > > > > On Dec 4, 2024, at 3:44=E2=80=AFAM, Roberto Sassu <roberto.sassu@=
huaweicloud.com> wrote:
> > > > >=20
> > > > > On Tue, 2024-12-03 at 20:06 +0000, Eric Snowberg wrote:
> > > > > >=20
> > > > > > > On Nov 26, 2024, at 3:41=E2=80=AFAM, Roberto Sassu <roberto.s=
assu@huaweicloud.com> wrote:
> > > > > > >=20
> > > > > > > On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
> > > > > > > >=20
> > > > > > > > > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <rober=
to.sassu@huaweicloud.com> wrote:
> > > > > > > > >=20
> > > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > >=20
> > > > > > > > > The Integrity Digest Cache can also help IMA for appraisa=
l. IMA can simply
> > > > > > > > > lookup the calculated digest of an accessed file in the l=
ist of digests
> > > > > > > > > extracted from package headers, after verifying the heade=
r signature. It is
> > > > > > > > > sufficient to verify only one signature for all files in =
the package, as
> > > > > > > > > opposed to verifying a signature for each file.
> > > > > > > >=20
> > > > > > > > Is there a way to maintain integrity over time?  Today if a=
 CVE is discovered=20
> > > > > > > > in a signed program, the program hash can be added to the b=
lacklist keyring.=20
> > > > > > > > Later if IMA appraisal is used, the signature validation wi=
ll fail just for that=20
> > > > > > > > program.  With the Integrity Digest Cache, is there a way t=
o do this? =20
> > > > > > >=20
> > > > > > > As far as I can see, the ima_check_blacklist() call is before
> > > > > > > ima_appraise_measurement(). If it fails, appraisal with the I=
ntegrity
> > > > > > > Digest Cache will not be done.
> > > > > >=20
> > > > > >=20
> > > > > > It is good the program hash would be checked beforehand and fai=
l if it is=20
> > > > > > contained on the list.=20
> > > > > >=20
> > > > > > The .ima keyring may contain many keys.  If one of the keys was=
 later=20
> > > > > > revoked and added to the .blacklist, wouldn't this be missed?  =
It would=20
> > > > > > be caught during signature validation when the file is later ap=
praised, but=20
> > > > > > now this step isn't taking place.  Correct?
> > > > >=20
> > > > > For files included in the digest lists, yes, there won't be detec=
tion
> > > > > of later revocation of a key. However, it will still work at pack=
age
> > > > > level/digest list level, since they are still appraised with a
> > > > > signature.
> > > > >=20
> > > > > We can add a mechanism (if it does not already exist) to invalida=
te the
> > > > > integrity status based on key revocation, which can be propagated=
 to
> > > > > files verified with the affected digest lists.
> > > > >=20
> > > > > > With IMA appraisal, it is easy to maintain authenticity but cha=
llenging to=20
> > > > > > maintain integrity over time. In user-space there are constantl=
y new CVEs. =20
> > > > > > To maintain integrity over time, either keys need to be rotated=
 in the .ima=20
> > > > > > keyring or program hashes need to be frequently added to the .b=
lacklist.  =20
> > > > > > If neither is done, for an end-user on a distro, IMA-appraisal =
basically=20
> > > > > > guarantees authenticity.
> > > > > >=20
> > > > > > While I understand the intent of the series is to increase perf=
ormance,=20
> > > > > > have you considered using this to give the end-user the ability=
 to maintain=20
> > > > > > integrity of their system?  What I mean is, instead of trying t=
o import anything=20
> > > > > > from an RPM, just have the end-user provide this information in=
 some format=20
> > > > > > to the Digest Cache.  User-space tools could be built to collec=
t and format=20
> > > > >=20
> > > > > This is already possible, digest-cache-tools
> > > > > (https://github.com/linux-integrity/digest-cache-tools) already a=
llow
> > > > > to create a digest list with the file a user wants.
> > > > >=20
> > > > > But in this case, the user is vouching for having taken the corre=
ct
> > > > > measure of the file at the time it was added to the digest list. =
This
> > > > > would be instead automatically guaranteed by RPMs or other packag=
es
> > > > > shipped with Linux distributions.
> > > > >=20
> > > > > To mitigate the concerns of CVEs, we can probably implement a rol=
lback
> > > > > prevention mechanism, which would not allow to load a previous ve=
rsion
> > > > > of a digest list.
> > > >=20
> > > > IMHO, pursuing this with the end-user being in control of what is c=
ontained=20
> > > > within the Digest Cache vs what is contained in a distro would prov=
ide more
> > > > value. Allowing the end-user to easily update their Digest Cache in=
 some way=20
> > > > without having to do any type of revocation for both old and vulner=
able=20
> > > > applications with CVEs would be very beneficial.
> > >=20
> > > Yes, deleting the digest list would invalidate any integrity result
> > > done with that digest list.
> > >=20
> > > I developed also an rpm plugin that synchronizes the digest lists wit=
h
> > > installed software. Old vulnerable software cannot be verified anymor=
e
> > > with the Integrity Digest Cache, since the rpm plugin deletes the old
> > > software digest lists.
> > >=20
> > > https://github.com/linux-integrity/digest-cache-tools/blob/main/rpm-p=
lugin/digest_cache.c
> > >=20
> > > The good thing is that the Integrity Digest Cache can be easily
> > > controlled with filesystem operations (it works similarly to security
> > > blobs attached to kernel objects, like inodes and file descriptors).
> > >=20
> > > As soon as something changes (e.g. digest list written, link to the
> > > digest lists), this triggers a reset in the Integrity Digest Cache, s=
o
> > > digest lists and files need to be verified again. Deleting the digest
> > > list causes the in-kernel digest cache to be wiped away too (when the
> > > reference count reaches zero).
> > >=20
> > > > Is there a belief the Digest Cache would be used without signed ker=
nel=20
> > > > modules?  Is the performance gain worth changing how kernel modules=
=20
> > > > get loaded at boot?  Couldn't this part just be dropped for easier =
acceptance? =20
> > > > Integrity is already maintained with the current model of appended =
signatures.=20
> > >=20
> > > I don't like making exceptions in the design, and I recently realized
> > > that it should not be task of the users of the Integrity Digest Cache
> > > to limit themselves.
> >=20
> > Forgot to mention that your use case is possible. The usage of the
> > Integrity Digest Cache must be explicitly enabled in the IMA policy. It
> > will be used if the matching rule has 'digest_cache=3Ddata' (its forese=
en
> > to be used also for metadata).
>=20
> I see a lot of benefit if metadata integrity could be maintained, but in =
the=20
> current form of this series, I don't think that is possible.  The Digest =
Cache=20
> doesn't contain or enforce the file path, which would be necessary to=20
> maintain integrity.  Here is an example of why it would be needed, say=
=20
> you have two applications that need a configuration file to start.  The f=
irst=20
> application has an empty file where no configuration options are currentl=
y=20
> defined. Now there is a hash for an empty file in the Digest Cache.  The=
=20
> second application can be started with an empty configuration file, howev=
er=20
> the end-user has added some options to it.  If the configuration file for=
 the=20
> second application is replaced with an empty file, it will not be detecte=
d,=20
> since the Digest Cache would see the empty file hash in its cache.

I was thinking more to store in the digest cache digests of metadata
(including for example the expected SELinux label), that EVM can
lookup.

In that way, the problem you foresee cannot happen: if you replace the
file belonging to app2_t with the one belonging to app1_t, SELinux
would deny the permission to access; if you change the SELinux label of
the file, EVM will deny the access.

You can still go back to the initial state, for that a rollback
prevention mechanism is needed (maybe EVM can remove the digest of the
initial state from the digest cache when it sees an update?).

In general, the Integrity Digest Cache should be considered as an
alternative mechanism to validate immutable files, or the initial state
of mutable files. For mutable files, EVM HMAC will protect further
updates.

Roberto

> > For kernel modules, it is sufficient to not provide that keyword for
> > the MODULE_CHECK hook.
> >=20
> > However, there is the possibility that you lose another advantage of
> > the Integrity Digest Cache, the predictability of the IMA PCR. By not
> > using digest caches, there is the risk that the IMA PCR will be
> > unstable, due to loading kernel modules in a different order at each
> > boot.
>=20
> Understood, my recommendation was based on trying to narrow the series=
=20
> to help try to get something like this adopted quicker.
>=20


