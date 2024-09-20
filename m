Return-Path: <linux-kselftest+bounces-18151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAE97CFCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 03:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B718D1F21A39
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DEC8488;
	Fri, 20 Sep 2024 01:54:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51FAD51
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726797291; cv=none; b=Nos5/O54AK/V7i5NYSyX2yAOMleRpmlDuNXFDlqM2iJf+LvUIYPGvcfw+Rxv6pyKAzRrATHER42Cw2ZX86IYU81QN9POymZbcsXsjZDyhoY4J1eVvoUqawrdmWNbb7sAV6JP/sq14t/czp3t4lJ3iayhltBjD1ndGtlG1Y0Iitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726797291; c=relaxed/simple;
	bh=iJzs79/3XOR2eSG0Fb6vBVOP+2q5E+Ry8zbWYGCJ82k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDy3jiyPJHDciPn+HGF9iO1MqXakqaC63Hn9WQq8edj8qnBFSmpt7BhypFr6TUjwdk6F2JT+AVrqM0URjzdBistXCjn4LAKfiMIBsqUs0ldnz7LM1ygqsdDhTAineTGV83petOLvML4+FIqfDOElxtwH/n+NcVSOteBG5cq7NWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X8wQb1gRHzyQsM;
	Fri, 20 Sep 2024 09:53:27 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 75DEE1403D5;
	Fri, 20 Sep 2024 09:54:45 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 09:54:44 +0800
Message-ID: <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
Date: Fri, 20 Sep 2024 09:54:44 +0800
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
To: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>
CC: <liwei391@huawei.com>, <Jason@zx2c4.com>, <christophe.leroy@csgroup.eu>,
	<broonie@kernel.org>, <linux-kselftest@vger.kernel.org>, Xie XiuQi
	<xiexiuqi@huawei.com>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)

On 2024/9/20 0:51, Shuah Khan wrote:

>> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> index 72a1d9b43a84..84f2bbb2d5e0 100644
>> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> @@ -19,6 +19,7 @@
>>   #include <sys/ptrace.h>
>>   #include <sys/wait.h>
>>   #include <sys/types.h>
>> +#include <linux/sched.h>
>>   #include <linux/random.h>
>>   #include <linux/compiler.h>
>>   #include <linux/ptrace.h>
> 
> Do you see this error after installing headers? Installing headers is
> a dependency to be able to compile selftests.
> 

Yes, this error still exists after installing header files. Here are my steps
to reproduce:

make headers_install
make -C tools/testing/selftests TARGETS=vDSO

After applying the patch, the error no longer appears.

Best regards,
Yu

