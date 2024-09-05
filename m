Return-Path: <linux-kselftest+bounces-17298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD5D96E0D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCFF1C2563E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C91A2C27;
	Thu,  5 Sep 2024 17:10:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C01A0B06;
	Thu,  5 Sep 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556238; cv=none; b=gE+0R40yZjshxn/opCc8pLsX2sW6BVfMOdcJOdpibOaglHhLmm/de4o/svPSEQyUGuZuOsHHnXU4MkeljKADMYWERosuFtvz19sxrJQL286vjuCJfMsBcMAovj4tI1JUtnHAMIgVPS+ZAA7CrdTXeIDZjb9tbMAfQso/xVTQ4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556238; c=relaxed/simple;
	bh=txJaOor+9ZWaoWB3yu0QW4hZEAgJucHNaOLbH3vB1vE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7SmJx46m2SqXmzFHBgKlbzxR65Y/yT51xxK2CRa9R6VJKtoqROwHTUI0JuIl6fTHcj8Pz5lGyzhFYOZMHvt5a1EKdCYDsc6JsnGRIwpfsMZOgNWXlAmOdLKaCzcRCl198vBvhXho6HfRZMOUtxpat8tX82bcLmkijJjK6a2Xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X04wm4HLTz9v7Jf;
	Fri,  6 Sep 2024 00:45:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 772AF140FEB;
	Fri,  6 Sep 2024 01:10:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCH6cnv5dlmbH5WAA--.17402S2;
	Thu, 05 Sep 2024 18:10:23 +0100 (CET)
Message-ID: <0cd494edfc48232257753f870d9b88436bee25bc.camel@huaweicloud.com>
Subject: Re: [PATCH v5 13/14] selftests/digest_cache: Add selftests for the
 Integrity Digest Cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, corbet@lwn.net, 
	akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 05 Sep 2024 19:10:04 +0200
In-Reply-To: <c6ac95bd-df49-4db7-8f5c-1281a9f95ecd@quicinc.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
	 <20240905150543.3766895-14-roberto.sassu@huaweicloud.com>
	 <c6ac95bd-df49-4db7-8f5c-1281a9f95ecd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCH6cnv5dlmbH5WAA--.17402S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF43Jw4kXrykuF13tryrZwb_yoWxCwbEgw
	4vvryfC3y3ZF129a1jyas8JFy2ga1vgw1Yqr1kJF95XryfA39IkrWkK3sIvw18Cw4ftF93
	AayDAwnxtr1SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUsB
	HqDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oL1gACse

On Thu, 2024-09-05 at 10:02 -0700, Jeff Johnson wrote:
> On 9/5/24 08:05, Roberto Sassu wrote:
> ...
> > +module_init(digest_cache_test_init);
> > +module_exit(digest_cache_test_fini);
> > +MODULE_LICENSE("GPL");
>=20
> Missing MODULE_DESCRIPTION()
>=20
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=3D1. Recently, multiple
> developers have been eradicating these warnings treewide, and very few
> are left, so please don't introduce a new one :)

Argh, thanks for the reminder! You mentioned in the PGP patch set.

Roberto


