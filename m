Return-Path: <linux-kselftest+bounces-18263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF900983B69
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 04:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1BAB20FA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B223DE;
	Tue, 24 Sep 2024 02:57:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752E1BC20
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146679; cv=none; b=pgkOkYCcXnfrrdrQou//j2D6pcfou4+AQPBK6mNVhPT9hRyfH3XEBTzOR9Z7Gn8qXBI2V5sgJcrx0cPVcZp8D83zwXCHcBOIBUy+dtSUjIXCPGR9XECp3eNNCzg5DaOuxlV5Rr5Ih7IlpCaVBlnevrT4/Omm8yLCXWYm4iNj3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146679; c=relaxed/simple;
	bh=zlgxtnpK0qR9EXKm+4ZIMyH+B3hARclBL6NJ1G+aD4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dmGKkiDYVLDexdRU+TDt9E86jy3USLbX0J96MuubNmPyqJr+Te+EivSjy7ylikOH4xwC0rlAf8fIOtkC4FrdlD79j0x4XrHxEh9I8DsGt87Dn1hQH5FJwB542Wgfl5b9bDfpKts8wue0pRmT+8svnutyi4JkynabxCcloOQeepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XCPcM0ntZzfcWc;
	Tue, 24 Sep 2024 10:55:31 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id A5F691401F0;
	Tue, 24 Sep 2024 10:57:47 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 10:57:47 +0800
Message-ID: <702f6d09-5216-eef5-299d-6445cfca8233@huawei.com>
Date: Tue, 24 Sep 2024 10:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
CC: <shuah@kernel.org>, <liwei391@huawei.com>, <broonie@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
 <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
 <CAHmME9p9iy+d2wx3vpD1XbVde9WvcJ1agTOqcNw4z=WABVn5XQ@mail.gmail.com>
 <87684869-4565-4a4a-845f-4301242be52a@linuxfoundation.org>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <87684869-4565-4a4a-845f-4301242be52a@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Hi,
On 2024/9/23 23:30, Shuah Khan wrote:
> On 9/20/24 09:31, Jason A. Donenfeld wrote:
>> Indeed probably <sched.h> is what's wanted here.
>>
> 
> Yu Liao, Please send v2 as per the review comments.
> 

CLONE_NEWTIME was introduced in glibc-2.36, which was released in August 2022.
As Christophe mentioned, <sched.h> is already indirectly included by
<phread.h>, so this issue does not exist if glibc version higher than 2.36.

Additionally, CLONE_NEWTIME was introduced in Linux 5.6 in March 2020, the
CLONE_ macros are also defined in <linux/sched.h>, which is part of the
kernel-header package.

My environment is Ubuntu 22.04 (Linux 5.15 + glibc 2.35), after upgrading to a
newer version of glibc, the issue appears to be resolved.
It seems to me that including <sched.h> might be unnecessary. I would greatly
appreciate your guidance on how best to handle this situation.

Best regards,
Yu

