Return-Path: <linux-kselftest+bounces-22819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F19E37CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656A5282801
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2071AF0DC;
	Wed,  4 Dec 2024 10:45:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7465193067;
	Wed,  4 Dec 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309133; cv=none; b=jMEBseWfUC2PxXZfnEzVVriinG+NQ2OaccMEHoEpqBDKpItk8MI6nTOKgOhmw+g24bFaohZ2l5c/3dsyt/F4KjjzO5fq19IU3BikVAiP2tjkzlImZ1szD0+pzPt7N+Uo5njnlnvAd4z/8RWC6aORxG/dSo6EuJyL6fIuYuaE6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309133; c=relaxed/simple;
	bh=vlqTmq5FsT2/FE3QTwtg6jzPyAfB1te9WN7A5R7FPxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dm8aAZ2tOszeSHKY/O5VmadzHWTc860D6O3T/580kL2AOrIUVLRUKEzrwgQFHX5Y97xJPdjBXMDeTWHqwa3NVNYX+cIr1Gk6HuM2ev/TuPrmZZwXwowrFGL53h84a4vpiWFS8X13aPScYfq0LWN9eo5JDoMVlkgtDBbcP2BNGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Y3DCJ121Vz9v7Nj;
	Wed,  4 Dec 2024 18:24:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 24EC41401F2;
	Wed,  4 Dec 2024 18:45:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3X3+uMlBnYunQAg--.4171S2;
	Wed, 04 Dec 2024 11:45:21 +0100 (CET)
Message-ID: <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
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
Date: Wed, 04 Dec 2024 11:44:59 +0100
In-Reply-To: <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
	 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
	 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3X3+uMlBnYunQAg--.4171S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xCFWkWryrCFyfKryUZFb_yoWrZw1kpF
	WrKa17KrWkGr1Fkrn2ka17XFyFkws3tFyUXr1DGr98CrZ8WFyI9ryfKFW5uFyqgr1vkr42
	vr4agFy7Cwn8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bhb18UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBGdPvjYHuwABsf

On Tue, 2024-12-03 at 20:06 +0000, Eric Snowberg wrote:
>=20
> > On Nov 26, 2024, at 3:41=E2=80=AFAM, Roberto Sassu <roberto.sassu@huawe=
icloud.com> wrote:
> >=20
> > On Tue, 2024-11-26 at 00:13 +0000, Eric Snowberg wrote:
> > >=20
> > > > On Nov 19, 2024, at 3:49=E2=80=AFAM, Roberto Sassu <roberto.sassu@h=
uaweicloud.com> wrote:
> > > >=20
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > The Integrity Digest Cache can also help IMA for appraisal. IMA can=
 simply
> > > > lookup the calculated digest of an accessed file in the list of dig=
ests
> > > > extracted from package headers, after verifying the header signatur=
e. It is
> > > > sufficient to verify only one signature for all files in the packag=
e, as
> > > > opposed to verifying a signature for each file.
> > >=20
> > > Is there a way to maintain integrity over time?  Today if a CVE is di=
scovered=20
> > > in a signed program, the program hash can be added to the blacklist k=
eyring.=20
> > > Later if IMA appraisal is used, the signature validation will fail ju=
st for that=20
> > > program.  With the Integrity Digest Cache, is there a way to do this?=
 =20
> >=20
> > As far as I can see, the ima_check_blacklist() call is before
> > ima_appraise_measurement(). If it fails, appraisal with the Integrity
> > Digest Cache will not be done.
>=20
>=20
> It is good the program hash would be checked beforehand and fail if it is=
=20
> contained on the list.=20
>=20
> The .ima keyring may contain many keys.  If one of the keys was later=20
> revoked and added to the .blacklist, wouldn't this be missed?  It would=
=20
> be caught during signature validation when the file is later appraised, b=
ut=20
> now this step isn't taking place.  Correct?

For files included in the digest lists, yes, there won't be detection
of later revocation of a key. However, it will still work at package
level/digest list level, since they are still appraised with a
signature.

We can add a mechanism (if it does not already exist) to invalidate the
integrity status based on key revocation, which can be propagated to
files verified with the affected digest lists.

> With IMA appraisal, it is easy to maintain authenticity but challenging t=
o=20
> maintain integrity over time. In user-space there are constantly new CVEs=
. =20
> To maintain integrity over time, either keys need to be rotated in the .i=
ma=20
> keyring or program hashes need to be frequently added to the .blacklist. =
 =20
> If neither is done, for an end-user on a distro, IMA-appraisal basically=
=20
> guarantees authenticity.
>=20
> While I understand the intent of the series is to increase performance,=
=20
> have you considered using this to give the end-user the ability to mainta=
in=20
> integrity of their system?  What I mean is, instead of trying to import a=
nything=20
> from an RPM, just have the end-user provide this information in some form=
at=20
> to the Digest Cache.  User-space tools could be built to collect and form=
at=20

This is already possible, digest-cache-tools
(https://github.com/linux-integrity/digest-cache-tools) already allow
to create a digest list with the file a user wants.

But in this case, the user is vouching for having taken the correct
measure of the file at the time it was added to the digest list. This
would be instead automatically guaranteed by RPMs or other packages
shipped with Linux distributions.

To mitigate the concerns of CVEs, we can probably implement a rollback
prevention mechanism, which would not allow to load a previous version
of a digest list.

> the data needed by the Digest Cache.  This data  may allow multiple versi=
ons=20
> of the same program.  The data would then be signed by one of the system=
=20
> kernel keys (either something in the secondary or machine keyring), to ma=
intain=20
> a root of trust.  This would give the end-user the ability to have integr=
ity however=20
> they see fit.  This leaves the distro to provide signed programs and the =
end-user=20
> the ability to decide what level of software they want to run on their sy=
stem.  If=20
> something isn't in the Digest Cache, it gets bumped down to the tradition=
al=20
> IMA-appraisal.  I think it would simplify the problem you are trying to s=
olve,=20

All you say it is already possible. Users can generate and sign their
digest lists, and add enroll their key to the kernel keyring.

> especially around the missing kernel PGP code required for all this to wo=
rk,=20
> since it wouldn't be necessary.   With this approach, besides the perform=
ance=20
> gain, the end-user would gain the ability to maintain integrity that is e=
nforced by
> the kernel.

For what I understood, Linus would not be against the=20


