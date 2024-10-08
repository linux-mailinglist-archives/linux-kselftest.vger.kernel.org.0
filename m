Return-Path: <linux-kselftest+bounces-19188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC6B993C06
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AC91F23656
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 01:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD21A934;
	Tue,  8 Oct 2024 01:11:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878E538A;
	Tue,  8 Oct 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728349919; cv=none; b=HJaG1yp3+JErpFozrGKrt1s0BquVJkEaPXBxGkyLKPlqFUc/cLSk7vatE3/RSlBu8sI7BENeSbh7ysWlLvum2HIWZfCA9UeEL/lxlNK//K31gIAT5Rw2WICfLEaa81e4T5hYruMYGVdTJ6/eBjcngwD7ITcNjkBiNbgZwpm6HfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728349919; c=relaxed/simple;
	bh=SdlDI9a+uJoKZhKuEDighpVDSb+q6CK9Yr/42Xt5DcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzQUG6/afnzJM/Uo/UBaaT30p6O7ZoBnXSraIHfdCD2ccarjqKzudf4lNlFa6LReRlzscgNeAOqISYOIcbFbRwT4+fRrVnuXbJNXB/iVSfacxWe0mcAF+vs9muk32jIZrhlDhRtQ5KQXy6K7koEanwIoc5CoUqOydypPo1P25qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 479d0678851211efa216b1d71e6e1362-20241008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fc280e17-f542-41c8-9c8b-1a60bbb3c5df,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.38,REQID:fc280e17-f542-41c8-9c8b-1a60bbb3c5df,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:82c5f88,CLOUDID:f65fad8a700406f1a46a20f2b66df0bd,BulkI
	D:240930095346LCDR0KJ9,BulkQuantity:3,Recheck:0,SF:17|19|45|64|66|38|24|10
	2,TC:nil,Content:0|-5,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 479d0678851211efa216b1d71e6e1362-20241008
X-User: tianyaxiong@kylinos.cn
Received: from [192.168.85.19] [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1900617351; Tue, 08 Oct 2024 09:11:42 +0800
Message-ID: <1e02d812-9955-462a-9316-197e27747eb3@kylinos.cn>
Date: Tue, 8 Oct 2024 09:11:18 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Add __init and __exit to the functions
 bpf_test_no_cfi_init()/bpf_test_no_cfi_exit()
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, shuah@kernel.org, hinker.li@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240930013301.10817-1-tianyaxiong@kylinos.cn>
 <511a2e2f-6bdd-4e62-b647-796ca4c53119@iogearbox.net>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <511a2e2f-6bdd-4e62-b647-796ca4c53119@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/2 20:15, Daniel Borkmann 写道:
> On 9/30/24 3:33 AM, Yaxiong Tian wrote:
>> From: Yaxiong Tian <iambestgod@outlook.com>
>>
>> To save some running memory,Add __init and __exit to the
>> module load/unload functions.
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c 
>> b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
>> index 948eb3962732..aa571ab3c6c6 100644
>> --- a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
>> +++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
>> @@ -56,7 +56,7 @@ static struct bpf_struct_ops test_no_cif_ops = {
>>       .owner = THIS_MODULE,
>>   };
>>   -static int bpf_test_no_cfi_init(void)
>> +static int __init bpf_test_no_cfi_init(void)
>>   {
>>       int ret;
>>   @@ -71,7 +71,7 @@ static int bpf_test_no_cfi_init(void)
>>       return ret;
>>   }
>>   -static void bpf_test_no_cfi_exit(void)
>> +static void __exit bpf_test_no_cfi_exit(void)
>>   {
>>   }
> Not that the memory saving matters too much in this context, but lets 
> also
> annotate bpf_testmod_init and bpf_testmod_exit while at it?
>
Of course, it will provide a reference for those who are not familiar 
with this part of the code.
> Thanks,
> Daniel

