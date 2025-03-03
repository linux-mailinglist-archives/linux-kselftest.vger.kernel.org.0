Return-Path: <linux-kselftest+bounces-27993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18AA4B677
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 04:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482131890511
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CA1A08AF;
	Mon,  3 Mar 2025 03:24:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402A142900;
	Mon,  3 Mar 2025 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972281; cv=none; b=nc40CyHLZ/x+/u3FcyOaI8BAlQo7AZqv2MUBJP47/wir8JqG/u0RU9NTqMFujuh5Uu/l55sHu13GwfssVqfMV6Y873HKEi99549B5v32blsoj0OFjwAhxJbmO6W28a96feYe9ZlvLvmrLNSNOFHa8DyNd0+e/v5C54Tsdg1+9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972281; c=relaxed/simple;
	bh=UcP3opEi5PP9Ja8NK4VfQ8fuAffygbj26lA15ZkNhBI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=duDUDH5a3eh4a7LAkMcG+D5D2PVzV4uDApSerL3CrTCTYdN0P+nue9TDtZN0MXcMknPDH9U62EyB7AuiUsjt1V8G68G0Zz+pRDUX8ne7Oec0nh6kpMR8AEfY2BEcDUtiwui9oW05MKWYEPXL0fmOkZVQfRamJu5tYp4QCDEmQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04fd338ef7df11efa216b1d71e6e1362-20250303
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a0c845bf-8a62-4b64-817b-71fe6da47bd4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4f134b344d0d9fd307ada4f0dd2ebdd0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04fd338ef7df11efa216b1d71e6e1362-20250303
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2042143849; Mon, 03 Mar 2025 11:24:30 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 4B7C2B807587;
	Mon,  3 Mar 2025 11:24:29 +0800 (CST)
X-ns-mid: postfix-67C520ED-258227829
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id B58AAB807587;
	Mon,  3 Mar 2025 03:24:28 +0000 (UTC)
Message-ID: <e46e7143-84e7-4f98-962c-27467bef5457@kylinos.cn>
Date: Mon, 3 Mar 2025 11:23:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: liuye <liuye@kylinos.cn>
Subject: Re: [PATCH] selftests/dma: Fix bad array reference.
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206021239.51897-1-liuye@kylinos.cn>
 <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
 <0758d73d-98b7-4f9b-a3b2-001d69eb949d@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <0758d73d-98b7-4f9b-a3b2-001d69eb949d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

By code observation only.

Thanks,
Liu Ye

=E5=9C=A8 2025/2/27 05:41, Shuah Khan =E5=86=99=E9=81=93:
> On 2/25/25 18:31, liuye wrote:
>> Friendly ping.
>>
>> =E5=9C=A8 2025/2/6 10:12, Liu Ye =E5=86=99=E9=81=93:
>>> dir[directions] should be directions[dir] to correctly index the
>>> directions array.
>>>
>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>> ---
>>> =C2=A0 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/=
testing/selftests/dma/dma_map_benchmark.c
>>> index b12f1f9babf8..b925756373ce 100644
>>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>>> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
>>> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("dma mapping benchmark: =
threads:%d seconds:%d node:%d dir:%s granule: %d\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
hreads, seconds, node, dir[directions], granule);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
hreads, seconds, node, directions[dir], granule);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("average map latency(us):%.1f s=
tandard deviation:%.1f\n",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 map.avg_map_100ns/10.0, map.map_stddev/10.0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("average unmap latency(us):%.1f=
 standard deviation:%.1f\n",
>
> How did you find this problem?
>
> thanks,
> -- Shuah
>
>

