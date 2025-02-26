Return-Path: <linux-kselftest+bounces-27551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4353A45233
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CCC3B1541
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A818DB37;
	Wed, 26 Feb 2025 01:31:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F518E35D;
	Wed, 26 Feb 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533518; cv=none; b=l1a+s8Jhz3o4IARDIqsfqgeIGV7IvCuvK4NEeHRaXtUeuX3BkgbcoB/OKazeapjeHa2Rl4NtQyAs+0DsiSoapdwYDxM1i3RHOhwQkZgFLgKSgU5fBqWN2H3X6TWPeK6lmPATN+VEKKa31RTXd2/IXhrgUIuU7xgbew7aiAD/tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533518; c=relaxed/simple;
	bh=L3dm/SwAxUqsx3uG2YU0y3l4QN3OoRPOynwCehZLHxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWDdvap/p9zNe7rYVVHw+9nW8hC/eiUi3Ts4xZ+DVoBhFaP3+qWVwt99/4QFLJdZd73VYhJhCkcwIkvgMPsSdIGghPqfvevdI3ehZxUdXBPwfPT11jHhlO9K9FiHBnaIGU8+9oCgrICvelEq1VyAImykJbKmQ5ZYX4QGySwRyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d6931a4f3e111efa216b1d71e6e1362-20250226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5b5f6783-ba01-4aef-82f4-3cbb1c2ff2ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ed40136524d943b14a243b128549dba6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d6931a4f3e111efa216b1d71e6e1362-20250226
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 871505546; Wed, 26 Feb 2025 09:31:40 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id D4100B80758A;
	Wed, 26 Feb 2025 09:31:39 +0800 (CST)
X-ns-mid: postfix-67BE6EFB-719495276
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 6E94AB80758A;
	Wed, 26 Feb 2025 01:31:38 +0000 (UTC)
Message-ID: <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Date: Wed, 26 Feb 2025 09:31:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: Fix bad array reference.
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206021239.51897-1-liuye@kylinos.cn>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <20250206021239.51897-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Friendly ping.

=E5=9C=A8 2025/2/6 10:12, Liu Ye =E5=86=99=E9=81=93:
> dir[directions] should be directions[dir] to correctly index the
> directions array.
>
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/te=
sting/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..b925756373ce 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>  	}
> =20
>  	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s g=
ranule: %d\n",
> -			threads, seconds, node, dir[directions], granule);
> +			threads, seconds, node, directions[dir], granule);
>  	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>  			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>  	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

