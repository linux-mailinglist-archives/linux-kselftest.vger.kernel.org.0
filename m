Return-Path: <linux-kselftest+bounces-22563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE329DA51A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8975C283F2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BE19343B;
	Wed, 27 Nov 2024 09:51:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B5A95E;
	Wed, 27 Nov 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701115; cv=none; b=bjR2EJNIwInOEnnJaO/x5ZkyitvMMlVaqAWQA4K82Ep/IrjsRHEFfVvJ3VoqEMhmLBuxw/s9iwe+KsJJgXiDyJ2mvY2jrROCT0KL7aRMM932VJ04cDp0ZKcPPeHvRRyE4d301jH65yhoRvkcZgnRyLgzTt2YUZr56Jw9yUazV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701115; c=relaxed/simple;
	bh=AdbIqBFr2DX9C4NxpilK5N8h40ZnTWNw2PIzHja54Ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fm4Qt53/tyiXu7vUHUIm75TBA0VT2UervyqVmTTOVbX52ZIFwCtKXM9Kq11T3u9XdHKj/etjH9TansW++DjqJVsHnJlOUK708E5ZujvIcRTsDCIHdU0Mx8gLVn84kJFSfCF/alJfRqIxkjTO9aQGQMg2JJF/kOC+BtgaYor9I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XyvCX4xMtz9v7JS;
	Wed, 27 Nov 2024 17:24:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C3DE8140452;
	Wed, 27 Nov 2024 17:51:39 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAX1jaT60ZnO3hhAg--.24999S2;
	Wed, 27 Nov 2024 10:51:38 +0100 (CET)
Message-ID: <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest
 list parsers
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, petr.pavlu@suse.com,
 samitolvanen@google.com, da.gomez@samsung.com,  akpm@linux-foundation.org,
 paul@paul-moore.com, jmorris@namei.org,  serge@hallyn.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
 linux-modules@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,  mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, 
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, 
 mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Wed, 27 Nov 2024 10:51:11 +0100
In-Reply-To: <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
	 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
	 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
	 <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAX1jaT60ZnO3hhAg--.24999S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF48Ww47WFyfAFW7Gr1kAFb_yoWxXr1xpa
	yakan0kF4kJr1Ik3Z7Aa1xu3yF9393X3y5Wrn5Jry3Zrn8ur1Fvr1fKa1Uua4jkrs7JF12
	qr4Yq34ayF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGdGg-MCpAAAsx

On Tue, 2024-11-26 at 11:04 -0800, Luis Chamberlain wrote:
> On Tue, Nov 26, 2024 at 11:25:07AM +0100, Roberto Sassu wrote:
> > On Mon, 2024-11-25 at 15:53 -0800, Luis Chamberlain wrote:
> >=20
> > Firmware, eBPF programs and so on are supposed
>=20
> Keyword: "supposed".=20

It depends if they are in a policy. They can also be verified with
other methods, such as file signatures.

For eBPF programs we are also in a need for a better way to
measure/appraise them.

> > As far as the LSM infrastructure is concerned, I'm not adding new LSM
> > hooks, nor extending/modifying the existing ones. The operations the
> > Integrity Digest Cache is doing match the usage expectation by LSM (net
> > denying access, as discussed with Paul Moore).
>=20
> If modules are the only proven exception to your security model you are
> not making the case for it clearly.

The Integrity Digest Cache is not implementing any security model, this
is demanded to other LSMs which might decide to use the Integrity
Digest Cache based on a policy.

If we want to be super picky, the ksys_finit_module() helper is not
calling security_kernel_module_request(), which is done when using
request_module(). On the other hand, ksys_finit_module() is not
triggering user space, as the description of the function states
(anyway, apologies for not bringing up this earlier).

Net this, and we can discuss if it is more appropriate to call the LSM
hook, the helper does not introduce any exception since
security_file_open() is called when the kernel opens the file
descriptor, and security_kernel_read_file() and
security_kernel_post_read_file() are called in the same way regardless
if it is user space doing insmod or the kernel calling
ksys_finit_module().

The only exception is that the Integrity Digest Cache is unable to
verify the kernel modules containing the parsers, but I believe this is
fine because they are verified with their appended signature.

If there are any other concerns I'm missing, please let me know.

> > The Integrity Digest Cache is supposed to be used as a supporting tool
> > for other LSMs to do regular access control based on file data and
> > metadata integrity. In doing that, it still needs the LSM
> > infrastructure to notify about filesystem changes, and to store
> > additional information in the inode and file descriptor security blobs.
> >=20
> > The kernel_post_read_file LSM hook should be implemented by another LSM
> > to verify the integrity of a digest list, when the Integrity Digest
> > Cache calls kernel_read_file() to read that digest list.
>=20
> If LSM folks *do* agree that this work is *suplementing* LSMS then sure,
> it was not clear from the commit logs. But then you need to ensure the
> parsers are special snowflakes which won't ever incur other additional
> kernel_read_file() calls.

The Integrity Digest Cache was originally called digest_cache LSM, but
was renamed due to Paul's concern that it is not a proper LSM enforcing
a security model. If you are interested, I gave a talk at LSS NA 2024:

https://www.youtube.com/watch?v=3DaNwlKYSksg8

Given that the Integrity Digest Cache could not be standalone and use
the LSM infrastructure facilities, it is going to be directly
integrated in IMA, although it is not strictly necessary.

I planned to support IPE and BPF LSM as other users.

Uhm, let me clarify your last sentence a bit.

Let's assume that IMA is asked to verify a parser, when invoked through
the kernel_post_read_file hook. IMA is not handling the exception, and
is calling digest_cache_get() as usual. Normally, this would succeed,
but because digest_cache_get() realizes that the file descriptor passed
as argument is marked (i.e. it was opened by the Integrity Digest Cache
itself), it returns NULL.

That means that IMA falls back on another verification method, which is
verifying the appended signature.

The most important design principle that I introduced is that users of
the Integrity Digest Cache don't need to be aware of any exception,
everything is handled by the Integrity Digest Cache itself.

The same occurs when a kernel read occurs with file ID
READING_DIGEST_LIST (introduced in this patch set). Yes, I forbid
specifying an IMA policy which requires the Integrity Digest Cache to
verify digest lists, but due to the need of handling kernel modules
I decided to handle the exceptions in the Integrity Digest Cache itself
(this is why now I'm passing a file descriptor to digest_cache_get()
instead of a dentry).

Now, I'm trying to follow you on the additional kernel_read_file()
calls. I agree with you, if a parser tries to open again the file that
is being verified it would cause a deadlock in IMA (since the inode
mutex is already locked for verifying the original file).

In the Integrity Digest Cache itself, this is not going to happen,
since the file being verified with a digest cache is known and an
internal open of the same file fails. If it is really necessary, we can
pass the information to the parsers so that they are aware, it is just
an additional parameter.

However, I was assuming that a parser just receives the data read by
the Integrity Digest Cache, and just calls the Parser API to add the
extracted digests to the new digest cache. Also this can be discussed,
but I guess there is no immediate need.

> > Supporting kernel modules opened the road for new deadlocks, since one
> > can ask a digest list to verify a kernel module, but that digest list
> > requires the same kernel module. That is why the in-kernel mechanism is
> > 100% reliable,
>=20
> Are users of this infrastructure really in need of modules for these
> parsers?

I planned to postpone this to later, and introduced two parsers built-
in (TLV and RPM). However, due to Linus's concern regarding the RPM
parser, I moved it out in a kernel module.

Also, a parser cannot be in user space, since the trust anchor is in
the kernel (the public keys and the signature verification mechanism),
it is not something that can be established in the initial ram disk
since the Integrity Digest Cache will be continously used in the
running system (maybe more parsers will be loaded on demand depending
on requests from user space).

And finally, the parser cannot run in user space, since it would be at
the same level of what the kernel is verifying.

Thanks

Roberto


