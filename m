Return-Path: <linux-kselftest+bounces-22336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219059D36E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04FF1F27142
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7821A073F;
	Wed, 20 Nov 2024 09:18:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6119F118;
	Wed, 20 Nov 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094310; cv=none; b=HIdK5GboX9DCG3wgeHuIJYTRy/rXpHng1mRLS4X9oJedw5ulGZOyXGtJccI1G/+1CldO9zqjEGg6b0txTmW7GiP2QeVI8rGSV3hhtVvnPd0cCRVRvwJ013fv42NXxnAUvg5nJf32W7d9EahuuGmM9ZFNL6n+FwcuDvRV7h/VmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094310; c=relaxed/simple;
	bh=508NFvW1FNQrfYLUCBjE2iq9wBGdecb4e7K/EzX0AG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrjxWhhroM5dvdvMSbKzkxYdU3iOdhI0/IQfa3eF7pLm8KgwHx3tKkEGcM6XKwnOUeDV+/j0yr2XR6HBrPgB2UXp6Fb0f/zBsqHlik3vdnV1oV3RH+ZLn3ySS+6/qBcgeQL/g1Rk2X7nbgaZQqP7LAGTvAp8CEu4aPtWSDgk9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XtZxg5BGDz9v7Hs;
	Wed, 20 Nov 2024 16:57:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 204001407FC;
	Wed, 20 Nov 2024 17:18:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB33XxLqT1nJB74AQ--.3896S2;
	Wed, 20 Nov 2024 10:18:21 +0100 (CET)
Message-ID: <9c68676cd810d6f6f9bb2bce0939ba2a04a4f8d2.camel@huaweicloud.com>
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
Date: Wed, 20 Nov 2024 10:18:01 +0100
In-Reply-To: <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
	 <20241119121402.GA28228@lst.de> <ZzzwxdHbG9HynADT@bombadil.infradead.org>
	 <70952351d25817211509bf1cf43d3e665aef1481.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB33XxLqT1nJB74AQ--.3896S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kur47trW3uFy7ZryxKrg_yoW8KryrpF
	WrAan8tF4kXr1kAFWkKw18ZryIg3y3AF4aqasYvr1fZr9I9r4UuF1Ikr43Wa4DWr18Kw1j
	krWYvFWxC34DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsPfHUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBGc9SXICEwAAs7

On Wed, 2024-11-20 at 10:16 +0100, Roberto Sassu wrote:
> On Tue, 2024-11-19 at 12:10 -0800, Luis Chamberlain wrote:
> > On Tue, Nov 19, 2024 at 01:14:02PM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 19, 2024 at 11:49:09AM +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Introduce ksys_finit_module() to let kernel components request a ke=
rnel
> > > > module without requiring running modprobe.
> > >=20
> > > That does sound more than sketchy, even more so because the commit lo=
g
> > > completely fails to explain why you'd need to do that.
> >=20
> > I also don't think the commit log is correct, I don't see how the
> > code is preventing calling modprobe, the indepotent check is intended
> > to prevent duplicate module init calls which may allocate extra vmalloc
> > space only to release it. You can test to see if your patch has any
> > improvments by enabling MODULE_STATS and MODULE_DEBUG_AUTOLOAD_DUPS
> > and check before / after results of /sys/kernel/debug/modules/stats  ,
> > right now this patch and commit log is not telling me anything useful.
>=20
> Maybe I misunderstood the code, but what causes modprobe to be executed
> in user space is a call to request_module().
>=20
> In my patch, I simply ported the code of the finit_module() system call
> to _ksys_finit_module(), net the conversion from struct fd to struct
> file, which is kept in the system call code.
>=20
> Also, from the kernel side, I'm providing a valid address for module
> arguments, and duplicating the string either with kmemdup() or
> strndup_user() in load_module(), depending on where the memory belongs
> to.
>=20
> Again, maybe I misunderstood, but I'm not introducing any functional
> change to the current behavior, the kernel side also provides a file
> descriptor and module arguments as user space would do (e.g. by
> executing insmod).
>=20
> As for the motivation, please have a look at my response to Christian:

Christoph, of course.

Roberto


> https://lore.kernel.org/linux-integrity/ZzzvAPetAn7CUEvx@bombadil.infrade=
ad.org/T/#ma8656b921bb5bfb60e7f10331061d462a87ce9f4
>=20
>=20
> In addition, you could also see how ksys_finit_module() is used here:
>=20
> https://lore.kernel.org/linux-integrity/20241119104922.2772571-8-roberto.=
sassu@huaweicloud.com/
>=20
> Thanks
>=20
> Roberto


