Return-Path: <linux-kselftest+bounces-8482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658408AB777
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B517282979
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811C13D890;
	Fri, 19 Apr 2024 23:30:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4664D;
	Fri, 19 Apr 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713569418; cv=none; b=VchaxWl1QOf8ul7RqeRNRslfbfPUQ3OhzfYTodDUNOB9Wf/g9AuCNnK4MVejr/is80Fb9wIWrli6bAvlKREropYW8GnrPKQ4FXxkeXQZlI3cZwB/p6Cm16Foo1gi/nCuoUChiNkX+gbJEy65CLqXvrR7UZqIGiLLUEfkz8nuWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713569418; c=relaxed/simple;
	bh=qZkLWvAWlgCjjdU0qNRhZCkRLi0oUlD656x5rum5Qvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZwN8Skbss+GkXy2+jhSECD9w8EZiTVsIhANEIU77atxd5mYNAXxdFVxAPfKYemOAoOhhb6b2TS5Y5Cvqgh9l0vKkGGHwrSZX4VPkL1Ov+uPkJmZN8bXDi3ashebRvd0bQU9zHXRUbbSHwxq2jdMRvte7nBjhkx8slJxDl+6bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VLr6h0Nn9z9ttCp;
	Sat, 20 Apr 2024 07:13:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2163D140B21;
	Sat, 20 Apr 2024 07:30:03 +0800 (CST)
Received: from [10.81.201.160] (unknown [10.81.201.160])
	by APP2 (Coremail) with SMTP id GxC2BwBHgCRh_iJmFsaOBg--.38143S2;
	Sat, 20 Apr 2024 00:30:02 +0100 (CET)
Message-ID: <8a47707d-f1ba-4eb5-b516-d689ad42a168@huaweicloud.com>
Date: Fri, 19 Apr 2024 16:29:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, corbet <corbet@lwn.net>,
 paul <paul@paul-moore.com>, jmorris <jmorris@namei.org>,
 serge <serge@hallyn.com>, akpm <akpm@linux-foundation.org>,
 shuah <shuah@kernel.org>, "mcoquelin.stm32" <mcoquelin.stm32@gmail.com>,
 "alexandre.torgue" <alexandre.torgue@foss.st.com>, mic <mic@digikod.net>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, zohar <zohar@linux.ibm.com>,
 "dmitry.kasatkin" <dmitry.kasatkin@gmail.com>,
 linux-integrity <linux-integrity@vger.kernel.org>,
 wufan <wufan@linux.microsoft.com>, pbrobinson <pbrobinson@gmail.com>,
 zbyszek <zbyszek@in.waw.pl>, hch <hch@lst.de>, mjg59 <mjg59@srcf.ucam.org>,
 pmatilai <pmatilai@redhat.com>, jannh <jannh@google.com>,
 dhowells <dhowells@redhat.com>, jikos <jikos@kernel.org>,
 mkoutny <mkoutny@suse.com>, ppavlu <ppavlu@suse.com>,
 "petr.vorel" <petr.vorel@gmail.com>, mzerqung <mzerqung@0pointer.de>,
 kgold <kgold@linux.ibm.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <Zh4DQ7RGxtWCam8K@archie.me>
 <66201cd2.df0a0220.a8ad5.6fbaSMTPIN_ADDED_BROKEN@mx.google.com>
 <fe361a16-1536-4c92-894a-0b24258384bf@gmail.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <fe361a16-1536-4c92-894a-0b24258384bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBHgCRh_iJmFsaOBg--.38143S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj5iejAAAsv

On 4/19/2024 4:18 AM, Bagas Sanjaya wrote:
> On 4/18/24 02:02, Roberto Sassu wrote:
>>
>> 72374d71c315
>>
>> Roberto
>>
> 
> Still FTA (fail to apply), unfortunately.

Sorry, looks like I didn't regenerate the patches after rebasing to the 
latest kernel. The current ones are still based on 6.8-rc3, but they 
still require some additional patches that I picked up.

Will send the new version with Jarkko suggestions implemented.

Thanks

Roberto



