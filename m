Return-Path: <linux-kselftest+bounces-22335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DA9D36D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7092844E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1FA19E7E3;
	Wed, 20 Nov 2024 09:17:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B999166F0C;
	Wed, 20 Nov 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094225; cv=none; b=AzuOOrfjOVEkn2RPau/XhM/+BrVtCxBaveBNl+qgSrWFwg8VuaDuw8chCCZ8rC8EjsTXaT4jQRHhJmHSez6X7GlT2hu8kOmag0gDxTao5R59nQbfoIERyl60GI6NQg3HviLkf/GB/fo330zZm3mzI+rx8RqwPWApd9cclJ2KxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094225; c=relaxed/simple;
	bh=gAVjzkaXRr+xe9qeGtTLqpf9sbv7Z9bAxVHWSex9YJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5pXGaDAMlTfgU07eJaj/K0e0MZhW2seZTeHS1Z8ZESZKjB7MlmGkche7Tq1mD0dHrQOqbJmNc3cgLj66UTZUQvR4cr4s8mf+4kJ/uVBQjiMFMZSc3GkA3EnDuEM3w6+ynSIuMEgFFtegAx5OfdTECWR36deYkUh7pAx9Hf3QCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XtZmq3DMxz9v7Jb;
	Wed, 20 Nov 2024 16:49:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5C4861407F5;
	Wed, 20 Nov 2024 17:16:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3HHzrqD1noRn4AQ--.3289S2;
	Wed, 20 Nov 2024 10:16:49 +0100 (CET)
Message-ID: <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>
Subject: Re: [PATCH v6 02/15] module: Introduce ksys_finit_module()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, petr.pavlu@suse.com,
 samitolvanen@google.com, da.gomez@samsung.com,  akpm@linux-foundation.org,
 paul@paul-moore.com, jmorris@namei.org,  serge@hallyn.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
 linux-modules@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl,  mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, 
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, 
 mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Wed, 20 Nov 2024 10:16:23 +0100
In-Reply-To: <ZzzwxdHbG9HynADT@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
	 <20241119121402.GA28228@lst.de> <ZzzwxdHbG9HynADT@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC3HHzrqD1noRn4AQ--.3289S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18Kr1Dur15Zr48tr47Arb_yoW8tr1rpF
	Wruan8tF1vqr1kAFWkGw1xZryIg3y3AF4aqas5Z34fZr909r4UuF4I9r43ua4DWr18Kw1j
	krn0qrW8G34DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBGc9SXIBzwACsm

On Tue, 2024-11-19 at 12:10 -0800, Luis Chamberlain wrote:
> On Tue, Nov 19, 2024 at 01:14:02PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 19, 2024 at 11:49:09AM +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Introduce ksys_finit_module() to let kernel components request a kern=
el
> > > module without requiring running modprobe.
> >=20
> > That does sound more than sketchy, even more so because the commit log
> > completely fails to explain why you'd need to do that.
>=20
> I also don't think the commit log is correct, I don't see how the
> code is preventing calling modprobe, the indepotent check is intended
> to prevent duplicate module init calls which may allocate extra vmalloc
> space only to release it. You can test to see if your patch has any
> improvments by enabling MODULE_STATS and MODULE_DEBUG_AUTOLOAD_DUPS
> and check before / after results of /sys/kernel/debug/modules/stats  ,
> right now this patch and commit log is not telling me anything useful.

Maybe I misunderstood the code, but what causes modprobe to be executed
in user space is a call to request_module().

In my patch, I simply ported the code of the finit_module() system call
to _ksys_finit_module(), net the conversion from struct fd to struct
file, which is kept in the system call code.

Also, from the kernel side, I'm providing a valid address for module
arguments, and duplicating the string either with kmemdup() or
strndup_user() in load_module(), depending on where the memory belongs
to.

Again, maybe I misunderstood, but I'm not introducing any functional
change to the current behavior, the kernel side also provides a file
descriptor and module arguments as user space would do (e.g. by
executing insmod).

As for the motivation, please have a look at my response to Christian:

https://lore.kernel.org/linux-integrity/ZzzvAPetAn7CUEvx@bombadil.infradead=
.org/T/#ma8656b921bb5bfb60e7f10331061d462a87ce9f4


In addition, you could also see how ksys_finit_module() is used here:

https://lore.kernel.org/linux-integrity/20241119104922.2772571-8-roberto.sa=
ssu@huaweicloud.com/

Thanks

Roberto


