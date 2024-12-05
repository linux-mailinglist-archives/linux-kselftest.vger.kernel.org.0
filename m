Return-Path: <linux-kselftest+bounces-22857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C29E505A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D831882227
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC801D5173;
	Thu,  5 Dec 2024 08:54:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AB16F27E;
	Thu,  5 Dec 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388870; cv=none; b=Tp2HpPuqU/8/OJ/lzjMvnkSwn6Dk+bgRCN5xDbdNTrIu8yRoiTj1udZyXAUif90BmPw1HbXx32KUxwwxFbd8SXkQRLvKKTtNFNelSworQ0kjYb61WJ8Yk4UIDQq9/ZP5JW6vJz2Gm00W/MQnfixOwGkMI03pwvDxn9jW4VA+B6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388870; c=relaxed/simple;
	bh=g0gydrHl/2oqhtVxsWa7SZilONyoK1LSyfq8FZ/A+/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpCy5o3WuMg0r11Awj5NtIPVQuYSgP/P2dnMqBsXsdZgZS/sX3nHgXNZ06WfxMKBo8eNzh+LbPjjuUy8wLMF4Oc+fLXry+Cowm7EDFFrXFn9/OwAPkboC1oBgD4x93AFv4AmR8OoELy3nKhR+T7rIx8KEF3qKdrk6q16yi+JCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y3nhd2ylsz9v7Vj;
	Thu,  5 Dec 2024 16:33:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 00C2714051A;
	Thu,  5 Dec 2024 16:54:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBH9CQdalFnenXcAg--.56302S2;
	Thu, 05 Dec 2024 09:54:08 +0100 (CET)
Message-ID: <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
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
Date: Thu, 05 Dec 2024 09:53:45 +0100
In-Reply-To: <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
	 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
	 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
	 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
	 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBH9CQdalFnenXcAg--.56302S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW8tF1DCFykKFWfAF47Jwb_yoW7tw1kpa
	y5Ka13Kr4kWr10k3Z2ka1UWF1Fk3yftr15Xwn8Xry5CrZ0gr929F1xKa15uFyDGr1kGr12
	vr1ag347CrWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBGdRD-QHxQAAsB

On Thu, 2024-12-05 at 00:57 +0000, Eric Snowberg wrote:
>=20
> > On Dec 4, 2024, at 3:44=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawei=
cloud.com> wrote:
> >=20
> > On Tue, 2024-12-03 at 20:06 +0000, Eric Snowberg wrote:
> > >=20
> > > > On Nov 26, 2024, at 3:41=E2=80=AFAM, Roberto Sassu <roberto.sassu@h=
uaweicloud.com> wrote:
> > > >=20
> > > > On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
> > > > >=20
> > > > > > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <roberto.sas=
su@huaweicloud.com> wrote:
> > > > > >=20
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > >=20
> > > > > > The Integrity Digest Cache can also help IMA for appraisal. IMA=
 can simply
> > > > > > lookup the calculated digest of an accessed file in the list of=
 digests
> > > > > > extracted from package headers, after verifying the header sign=
ature. It is
> > > > > > sufficient to verify only one signature for all files in the pa=
ckage, as
> > > > > > opposed to verifying a signature for each file.
> > > > >=20
> > > > > Is there a way to maintain integrity over time?  Today if a CVE i=
s discovered=20
> > > > > in a signed program, the program hash can be added to the blackli=
st keyring.=20
> > > > > Later if IMA appraisal is used, the signature validation will fai=
l just for that=20
> > > > > program.  With the Integrity Digest Cache, is there a way to do t=
his? =20
> > > >=20
> > > > As far as I can see, the ima_check_blacklist() call is before
> > > > ima_appraise_measurement(). If it fails, appraisal with the Integri=
ty
> > > > Digest Cache will not be done.
> > >=20
> > >=20
> > > It is good the program hash would be checked beforehand and fail if i=
t is=20
> > > contained on the list.=20
> > >=20
> > > The .ima keyring may contain many keys.  If one of the keys was later=
=20
> > > revoked and added to the .blacklist, wouldn't this be missed?  It wou=
ld=20
> > > be caught during signature validation when the file is later appraise=
d, but=20
> > > now this step isn't taking place.  Correct?
> >=20
> > For files included in the digest lists, yes, there won't be detection
> > of later revocation of a key. However, it will still work at package
> > level/digest list level, since they are still appraised with a
> > signature.
> >=20
> > We can add a mechanism (if it does not already exist) to invalidate the
> > integrity status based on key revocation, which can be propagated to
> > files verified with the affected digest lists.
> >=20
> > > With IMA appraisal, it is easy to maintain authenticity but challengi=
ng to=20
> > > maintain integrity over time. In user-space there are constantly new =
CVEs. =20
> > > To maintain integrity over time, either keys need to be rotated in th=
e .ima=20
> > > keyring or program hashes need to be frequently added to the .blackli=
st.  =20
> > > If neither is done, for an end-user on a distro, IMA-appraisal basica=
lly=20
> > > guarantees authenticity.
> > >=20
> > > While I understand the intent of the series is to increase performanc=
e,=20
> > > have you considered using this to give the end-user the ability to ma=
intain=20
> > > integrity of their system?  What I mean is, instead of trying to impo=
rt anything=20
> > > from an RPM, just have the end-user provide this information in some =
format=20
> > > to the Digest Cache.  User-space tools could be built to collect and =
format=20
> >=20
> > This is already possible, digest-cache-tools
> > (https://github.com/linux-integrity/digest-cache-tools) already allow
> > to create a digest list with the file a user wants.
> >=20
> > But in this case, the user is vouching for having taken the correct
> > measure of the file at the time it was added to the digest list. This
> > would be instead automatically guaranteed by RPMs or other packages
> > shipped with Linux distributions.
> >=20
> > To mitigate the concerns of CVEs, we can probably implement a rollback
> > prevention mechanism, which would not allow to load a previous version
> > of a digest list.
>=20
> IMHO, pursuing this with the end-user being in control of what is contain=
ed=20
> within the Digest Cache vs what is contained in a distro would provide mo=
re
> value. Allowing the end-user to easily update their Digest Cache in some =
way=20
> without having to do any type of revocation for both old and vulnerable=
=20
> applications with CVEs would be very beneficial.

Yes, deleting the digest list would invalidate any integrity result
done with that digest list.

I developed also an rpm plugin that synchronizes the digest lists with
installed software. Old vulnerable software cannot be verified anymore
with the Integrity Digest Cache, since the rpm plugin deletes the old
software digest lists.

https://github.com/linux-integrity/digest-cache-tools/blob/main/rpm-plugin/=
digest_cache.c

The good thing is that the Integrity Digest Cache can be easily
controlled with filesystem operations (it works similarly to security
blobs attached to kernel objects, like inodes and file descriptors).

As soon as something changes (e.g. digest list written, link to the
digest lists), this triggers a reset in the Integrity Digest Cache, so
digest lists and files need to be verified again. Deleting the digest
list causes the in-kernel digest cache to be wiped away too (when the
reference count reaches zero).

> Is there a belief the Digest Cache would be used without signed kernel=
=20
> modules?  Is the performance gain worth changing how kernel modules=20
> get loaded at boot?  Couldn't this part just be dropped for easier accept=
ance? =20
> Integrity is already maintained with the current model of appended signat=
ures.=20

I don't like making exceptions in the design, and I recently realized
that it should not be task of the users of the Integrity Digest Cache
to limit themselves.

But the main problem was not the kernel modules themselves, but the
infrastructure needed in user space to load them, which might not be
available at the time a digest list parser needs to be loaded.

I hope ksys_finit_module() does not cause too much resistance (however
I need to document it better, as others noted). It is just a different
way to pass the same parameters of the finit_module() system call.

Thanks

Roberto


