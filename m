Return-Path: <linux-kselftest+bounces-22919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D39E740B
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BB62830D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C83207670;
	Fri,  6 Dec 2024 15:27:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9F149C51;
	Fri,  6 Dec 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498840; cv=none; b=Xo4LOFqHtxTw4LIMCHzbhBab6RtnQBp/piH007R3yd0v947b/7fHNYYCImQw1MMlUPiIqJKTcGU8qCgNJxKhhE0h5HLvcEAgpXUhNHXejDrIYFGM0I3cFWNduWVayTrKWALvBXbFwPCl+7nfeXjCMVCgqHM5453dlKXHHid419w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498840; c=relaxed/simple;
	bh=t32dw6iXSXNfQ5mxX1Cyqo2AyiY4zuIOCE6LlwJtnQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KLgOkF/VLjrQ/VmYys5LXwamNk4YUvMkXBHPEv3CJes8/Q7CzKQsZy7oF/8fQiOL9yhwKQFw9hlWCX+Fwv82LFyAJoUYWjIX1zj7Qeu86agywfQtZjh8hYsycPzLL/6iS7WTuS4qWe4Tm/vwx3SSJrMgupH+rGkGdQuZrU+QEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4ZMT4cq8z9v7Vv;
	Fri,  6 Dec 2024 23:05:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C695A140724;
	Fri,  6 Dec 2024 23:27:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3cTKyF1NnDj_wAg--.61464S2;
	Fri, 06 Dec 2024 16:27:02 +0100 (CET)
Message-ID: <e0c1dfe84c64e50112bf46b8b906b76f2ff49391.camel@huaweicloud.com>
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
Date: Fri, 06 Dec 2024 16:26:38 +0100
In-Reply-To: <C5C46D67-F45B-406A-AD84-8CC8285E40C3@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
	 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
	 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
	 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
	 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
	 <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
	 <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
	 <F9EE3709-2A90-4E9A-8531-44EC0F9C240C@oracle.com>
	 <d7eb63db3ee2c04fc92efe30dc9c1eadabd3f61a.camel@huaweicloud.com>
	 <C5C46D67-F45B-406A-AD84-8CC8285E40C3@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3cTKyF1NnDj_wAg--.61464S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GryDAr1Dur15Wr48Wry7GFg_yoWfZFyUpa
	y5K3W7Kr4kJr1jyr12y3WrXr1FkrWftr1UXwn8Jry5Ar90kr18Zr1xKr45uFyDWr18Jr12
	qr1agFy7Ar1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGdSYXQKIAAAsF

On Fri, 2024-12-06 at 15:15 +0000, Eric Snowberg wrote:
>=20
> > On Dec 6, 2024, at 3:06=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawei=
cloud.com> wrote:
> >=20
> > On Thu, 2024-12-05 at 19:41 +0000, Eric Snowberg wrote:
> > >=20
> > > > On Dec 5, 2024, at 9:16=E2=80=AFAM, Roberto Sassu <roberto.sassu@hu=
aweicloud.com> wrote:
> > > >=20
> > > > On Thu, 2024-12-05 at 09:53 +0100, Roberto Sassu wrote:
> > > > > On Thu, 2024-12-05 at 00:57 +0000, Eric Snowberg wrote:
> > > > > >=20
> > > > > > > On Dec 4, 2024, at 3:44=E2=80=AFAM, Roberto Sassu <roberto.sa=
ssu@huaweicloud.com> wrote:
> > > > > > >=20
> > > > > > > On Tue, 2024-12-03 at 20:06 +0000, Eric Snowberg wrote:
> > > > > > > >=20
> > > > > > > > > On Nov 26, 2024, at 3:41=E2=80=AFAM, Roberto Sassu <rober=
to.sassu@huaweicloud.com> wrote:
> > > > > > > > >=20
> > > > > > > > > On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
> > > > > > > > > >=20
> > > > > > > > > > > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <r=
oberto.sassu@huaweicloud.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > > >=20
> > > > > > > > > > > The Integrity Digest Cache can also help IMA for appr=
aisal. IMA can simply
> > > > > > > > > > > lookup the calculated digest of an accessed file in t=
he list of digests
> > > > > > > > > > > extracted from package headers, after verifying the h=
eader signature. It is
> > > > > > > > > > > sufficient to verify only one signature for all files=
 in the package, as
> > > > > > > > > > > opposed to verifying a signature for each file.
> > > > > > > > > >=20
> > > > > > > > > > Is there a way to maintain integrity over time?  Today =
if a CVE is discovered=20
> > > > > > > > > > in a signed program, the program hash can be added to t=
he blacklist keyring.=20
> > > > > > > > > > Later if IMA appraisal is used, the signature validatio=
n will fail just for that=20
> > > > > > > > > > program.  With the Integrity Digest Cache, is there a w=
ay to do this? =20
> > > > > > > > >=20
> > > > > > > > > As far as I can see, the ima_check_blacklist() call is be=
fore
> > > > > > > > > ima_appraise_measurement(). If it fails, appraisal with t=
he Integrity
> > > > > > > > > Digest Cache will not be done.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > It is good the program hash would be checked beforehand and=
 fail if it is=20
> > > > > > > > contained on the list.=20
> > > > > > > >=20
> > > > > > > > The .ima keyring may contain many keys.  If one of the keys=
 was later=20
> > > > > > > > revoked and added to the .blacklist, wouldn't this be misse=
d?  It would=20
> > > > > > > > be caught during signature validation when the file is late=
r appraised, but=20
> > > > > > > > now this step isn't taking place.  Correct?
> > > > > > >=20
> > > > > > > For files included in the digest lists, yes, there won't be d=
etection
> > > > > > > of later revocation of a key. However, it will still work at =
package
> > > > > > > level/digest list level, since they are still appraised with =
a
> > > > > > > signature.
> > > > > > >=20
> > > > > > > We can add a mechanism (if it does not already exist) to inva=
lidate the
> > > > > > > integrity status based on key revocation, which can be propag=
ated to
> > > > > > > files verified with the affected digest lists.
> > > > > > >=20
> > > > > > > > With IMA appraisal, it is easy to maintain authenticity but=
 challenging to=20
> > > > > > > > maintain integrity over time. In user-space there are const=
antly new CVEs. =20
> > > > > > > > To maintain integrity over time, either keys need to be rot=
ated in the .ima=20
> > > > > > > > keyring or program hashes need to be frequently added to th=
e .blacklist.  =20
> > > > > > > > If neither is done, for an end-user on a distro, IMA-apprai=
sal basically=20
> > > > > > > > guarantees authenticity.
> > > > > > > >=20
> > > > > > > > While I understand the intent of the series is to increase =
performance,=20
> > > > > > > > have you considered using this to give the end-user the abi=
lity to maintain=20
> > > > > > > > integrity of their system?  What I mean is, instead of tryi=
ng to import anything=20
> > > > > > > > from an RPM, just have the end-user provide this informatio=
n in some format=20
> > > > > > > > to the Digest Cache.  User-space tools could be built to co=
llect and format=20
> > > > > > >=20
> > > > > > > This is already possible, digest-cache-tools
> > > > > > > (https://github.com/linux-integrity/digest-cache-tools) alrea=
dy allow
> > > > > > > to create a digest list with the file a user wants.
> > > > > > >=20
> > > > > > > But in this case, the user is vouching for having taken the c=
orrect
> > > > > > > measure of the file at the time it was added to the digest li=
st. This
> > > > > > > would be instead automatically guaranteed by RPMs or other pa=
ckages
> > > > > > > shipped with Linux distributions.
> > > > > > >=20
> > > > > > > To mitigate the concerns of CVEs, we can probably implement a=
 rollback
> > > > > > > prevention mechanism, which would not allow to load a previou=
s version
> > > > > > > of a digest list.
> > > > > >=20
> > > > > > IMHO, pursuing this with the end-user being in control of what =
is contained=20
> > > > > > within the Digest Cache vs what is contained in a distro would =
provide more
> > > > > > value. Allowing the end-user to easily update their Digest Cach=
e in some way=20
> > > > > > without having to do any type of revocation for both old and vu=
lnerable=20
> > > > > > applications with CVEs would be very beneficial.
> > > > >=20
> > > > > Yes, deleting the digest list would invalidate any integrity resu=
lt
> > > > > done with that digest list.
> > > > >=20
> > > > > I developed also an rpm plugin that synchronizes the digest lists=
 with
> > > > > installed software. Old vulnerable software cannot be verified an=
ymore
> > > > > with the Integrity Digest Cache, since the rpm plugin deletes the=
 old
> > > > > software digest lists.
> > > > >=20
> > > > > https://github.com/linux-integrity/digest-cache-tools/blob/main/r=
pm-plugin/digest_cache.c
> > > > >=20
> > > > > The good thing is that the Integrity Digest Cache can be easily
> > > > > controlled with filesystem operations (it works similarly to secu=
rity
> > > > > blobs attached to kernel objects, like inodes and file descriptor=
s).
> > > > >=20
> > > > > As soon as something changes (e.g. digest list written, link to t=
he
> > > > > digest lists), this triggers a reset in the Integrity Digest Cach=
e, so
> > > > > digest lists and files need to be verified again. Deleting the di=
gest
> > > > > list causes the in-kernel digest cache to be wiped away too (when=
 the
> > > > > reference count reaches zero).
> > > > >=20
> > > > > > Is there a belief the Digest Cache would be used without signed=
 kernel=20
> > > > > > modules?  Is the performance gain worth changing how kernel mod=
ules=20
> > > > > > get loaded at boot?  Couldn't this part just be dropped for eas=
ier acceptance? =20
> > > > > > Integrity is already maintained with the current model of appen=
ded signatures.=20
> > > > >=20
> > > > > I don't like making exceptions in the design, and I recently real=
ized
> > > > > that it should not be task of the users of the Integrity Digest C=
ache
> > > > > to limit themselves.
> > > >=20
> > > > Forgot to mention that your use case is possible. The usage of the
> > > > Integrity Digest Cache must be explicitly enabled in the IMA policy=
. It
> > > > will be used if the matching rule has 'digest_cache=3Ddata' (its fo=
reseen
> > > > to be used also for metadata).
> > >=20
> > > I see a lot of benefit if metadata integrity could be maintained, but=
 in the=20
> > > current form of this series, I don't think that is possible.  The Dig=
est Cache=20
> > > doesn't contain or enforce the file path, which would be necessary to=
=20
> > > maintain integrity.  Here is an example of why it would be needed, sa=
y=20
> > > you have two applications that need a configuration file to start.  T=
he first=20
> > > application has an empty file where no configuration options are curr=
ently=20
> > > defined. Now there is a hash for an empty file in the Digest Cache.  =
The=20
> > > second application can be started with an empty configuration file, h=
owever=20
> > > the end-user has added some options to it.  If the configuration file=
 for the=20
> > > second application is replaced with an empty file, it will not be det=
ected,=20
> > > since the Digest Cache would see the empty file hash in its cache.
> >=20
> > I was thinking more to store in the digest cache digests of metadata
> > (including for example the expected SELinux label), that EVM can
> > lookup.
> >=20
> > In that way, the problem you foresee cannot happen: if you replace the
> > file belonging to app2_t with the one belonging to app1_t, SELinux
> > would deny the permission to access; if you change the SELinux label of
> > the file, EVM will deny the access.
>=20
> If two different applications have config files in /etc, wouldn't both fi=
les=20
> have the same SELinux label?

Likely, unless there is an application-specific policy.

> > You can still go back to the initial state, for that a rollback
> > prevention mechanism is needed (maybe EVM can remove the digest of the
> > initial state from the digest cache when it sees an update?).
> >=20
> > In general, the Integrity Digest Cache should be considered as an
> > alternative mechanism to validate immutable files, or the initial state
> > of mutable files. For mutable files, EVM HMAC will protect further
> > updates.
>=20
> In the example above, from a distro standpoint, most files contained in /=
etc=20
> are viewed as being mutable.  However an end-user that wants to maintain=
=20
> integrity on their system wouldn't view it that way.  They don't want con=
fig=20
> changes they have made to be backed out. In the current form they would=
=20
> view this series as an Authenticity Digest Cache. I'm just trying to show=
 that=20
> this could be a lot more valuable to the end-user if some things were cha=
nged.

I agree, I think the current patch set contains the minimum necessary,
and it can grow depending on use cases/requirements from the community.

Thanks

Roberto


