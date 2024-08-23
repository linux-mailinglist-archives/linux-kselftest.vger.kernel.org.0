Return-Path: <linux-kselftest+bounces-16132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5195C60E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77489B24A43
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8745674D;
	Fri, 23 Aug 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OgzVhv08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3B13A88A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396702; cv=none; b=q8tC9wTrsSIA+BnSbuZLWAFR/mYDOhG8I+2+A1F90eZD1rJNcMZy9vs0QNnOewKhClq13UuBQdW+Cavq5URUcNN/bx3WTm4rOF1qD73F8N18PmDzPbcmpD3pU4oK9W/Sr5/kJa0Lfuf5EkpY+Er8y3MkeOAUGxN8WTwJCtw0Vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396702; c=relaxed/simple;
	bh=vn/ZOdIeoLtOfVc1hGIaG5wGmE3X/icgB5gRwNGeQJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLNUewKzHmYbFobNnDRKzohfEd1o2+vOR9+iqB8e4IpUsTQVEEJlD52O21wzLw2laqn/qXlb9jUXRF0SIFUU1Acx2C2XadwvLUYkD6qVpXN0lLNCHPfXeYVGgVqB0KDH1eJge6pqBCRxMLQc3GG0ENBILAyt1qh8JLbMwPjpMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgzVhv08; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18138d48-3758-5aad-1d68-6250687f75f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724396698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2pvmNoBXbC35XP6oZr9MPuOdP6ZuhsCvUKhJSr7VdE=;
	b=OgzVhv08IpqRpac8IxVAC7nL2KPOffjOR0w72yV/uacOBx71nccJznLWqWb0lMeUOktUki
	VxQ4Ig25RYfCzdxFpiZvWQ1wyGe2VCvmthXE/CpMFRO66usjGrYd60Wkj22wTD/huLfwib
	Vq/Gn5YiLoSJtPCE2COB87fHMJlEKcs=
Date: Fri, 23 Aug 2024 15:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 mykolal@fb.com, shuah@kernel.org, jolsa@kernel.org, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net
References: <20240820023447.29002-1-hao.ge@linux.dev>
 <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Yonghong


Thank you very much for taking the time to review my patch.


On 8/22/24 05:03, Yonghong Song wrote:
>
> On 8/19/24 7:34 PM, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> Smatch reported the following warning:
>>      ./tools/testing/selftests/bpf/testing_helpers.c:455 
>> get_xlated_program()
>>      warn: variable dereferenced before check 'buf' (see line 454)
>>
>> It seems correct,so let's modify it based on it's suggestion.
>>
>> Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
>> check in get_xlated_program()") fixed an issue in the test_verifier.c
>> once,but it was reverted this time.
>>
>> Let's solve this issue with the minimal changes possible.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: 
>> https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
>> Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() 
>> helper")
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>
> In the future, please change subject '[PATCH] ...' to '[PATCH 
> bpf-next] ...'
> so CI can properly test it.
>

OK, I understand. I will follow this rule in the future.


> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

