Return-Path: <linux-kselftest+bounces-22597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893739DB3AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 09:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F049281CE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1C14A4EB;
	Thu, 28 Nov 2024 08:24:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5613FD86;
	Thu, 28 Nov 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782288; cv=none; b=KYonWhBE5ajGRGs5fAmmmI1e/z03O1UcZEvpUekBjpVM016HcfEbw+V7yHsGJSKSGPm+ULFYZYuMITJmB3ghSHERiHoVKMt/2pjivqPSRbbicogdcy+Yb1jKnvmxJ6QdtUwxFYyp9EIDLgGgjPdQcivLC8GpjG5zcrzsPwQjXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782288; c=relaxed/simple;
	bh=SCu+ISsKCCcd6qkQaEWA3jNZcsdZonCDPyLTB8O/kyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+yO0gep3hvj7B3tQbmkJ4egKyv2UO4E5toEDOON7QGkcDoEqL6BEE4KGCMmVw+sD1b8tGGm0oZBBuuFRoH5FVlnm2GMs5tKYAEsxxkntMsLgALKvILt7wuJ4rSEL+OHd1fX0KvDdkLABEmBcuuL57WE/3YWM9Fz1r5oSTm8Iqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XzTDQ0Gx6z9v7JN;
	Thu, 28 Nov 2024 15:57:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B8230140762;
	Thu, 28 Nov 2024 16:24:23 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXNXWhKEhn28ZyAg--.30519S2;
	Thu, 28 Nov 2024 09:24:22 +0100 (CET)
Message-ID: <10c8fd4b53f946c2d7e933a35c6eb36557e8c592.camel@huaweicloud.com>
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
Date: Thu, 28 Nov 2024 09:23:57 +0100
In-Reply-To: <Z0d4vXuCqjTo_QW1@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
	 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
	 <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
	 <Z0Ybvzy7ianR-Sx9@bombadil.infradead.org>
	 <3dc25195b0362b3e5b6d6964df021ff4e7e1b226.camel@huaweicloud.com>
	 <Z0d4vXuCqjTo_QW1@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXNXWhKEhn28ZyAg--.30519S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15XFyUGry5CF48Zr1DWrg_yoW8uF4xpF
	WfK3ZIkr4kt3Wqkw4vyw47uFW0k393GrW5G3Z3Gr9ayr15KFya9FyIgw43WFZrKr4vgw4a
	qr1rZ3sIvw1kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGdH1TUBdQAAsw

On Wed, 2024-11-27 at 11:53 -0800, Luis Chamberlain wrote:
> On Wed, Nov 27, 2024 at 10:51:11AM +0100, Roberto Sassu wrote:
> > For eBPF programs we are also in a need for a better way to
> > measure/appraise them.
>=20
> I am confused now, I was under the impression this "Integrity Digest
> Cache" is just a special thing for LSMs, and so I was under the
> impression that kernel_read_file() lsm hook already would take care
> of eBPF programs.

Yes, the problem is that eBPF programs are transformed in user space
before they are sent to the kernel:

https://lwn.net/Articles/977394/

The Integrity Digest Cache can be used for the measurement/appraisal of
the initial eBPF ELF file, when they are accessed from the filesystem,
but the resulting blob sent to the kernel will be different.

> > Now, I'm trying to follow you on the additional kernel_read_file()
> > calls. I agree with you, if a parser tries to open again the file that
> > is being verified it would cause a deadlock in IMA (since the inode
> > mutex is already locked for verifying the original file).
>=20
> Just document this on the parser as a requirement.

Ok, will do.

> > > > Supporting kernel modules opened the road for new deadlocks, since =
one
> > > > can ask a digest list to verify a kernel module, but that digest li=
st
> > > > requires the same kernel module. That is why the in-kernel mechanis=
m is
> > > > 100% reliable,
> > >=20
> > > Are users of this infrastructure really in need of modules for these
> > > parsers?
> >=20
> > I planned to postpone this to later, and introduced two parsers built-
> > in (TLV and RPM). However, due to Linus's concern regarding the RPM
> > parser, I moved it out in a kernel module.
>=20
> OK this should be part of the commit log, ie that it is not desirable to
> have an rpm parser in-kernel for some users.

I understand. Will add in the commit log.

Just to clarify, we are not talking about the full blown librpm in the
kernel, but a 243 LOC that I rewrote to obtain only the information I
need. I also formally verified it with pseudo/totally random data with
Frama-C:

https://github.com/robertosassu/rpm-formal/blob/main/validate_rpm.c

Thanks

Roberto


