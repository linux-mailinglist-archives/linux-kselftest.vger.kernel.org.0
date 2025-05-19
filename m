Return-Path: <linux-kselftest+bounces-33348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8091ABC915
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3493A3D28
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBE21D3C0;
	Mon, 19 May 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pcmkDMFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08E217679;
	Mon, 19 May 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689699; cv=none; b=SzRTTr8pJsUX4v4wTojo8jquW9/mHrDmSFsXtyapy6CdfSco90Twq70CJM2R84emiTTnOc9E7YZEXrL+2JlnBKyFLtxXVILrSTSocv8Gpm+UesQEW+zGfsg9xFKrjEyeS1lTkedKZKWj98XIqqEti5BJx4fxeRVwmVLFidJO4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689699; c=relaxed/simple;
	bh=3yfVvu6ctqWi+Mp9M69igcy+47NYdaPDBKZNyw0wM4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSXQi2LAibH8qsA9mUR7aPfCcVKg44RvtmjNYHZeuITb21j5eOFUok+t45flST54JpsgV28WIyMPVjPY4OFDJRnggMOnmPNKzv27qHOrbuaIkNhokO4Q26vinzHOmx80cVf0KeW0TuUTmRJTW3HrRcmycM5k4gd/LzTa6KiagYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pcmkDMFX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QMMUftil4FlsregLW3WZllvx1g/ssMdCAfRuynRUtyw=; b=pcmkDMFXzjkKlk3kgFLPUqLZUp
	V9R85rTjGwdqhigl/1QzO4ZBclt+nLhwImLYwU1ouFm0fR0zwkAbsg21Zck53BKUZuS+94COX31RQ
	shcEKsQNLcvEkJG6/W8GsCUvTEcGTB4B3jbSbZztB8ydANBTmK3xvxZqH2dr2ms8ivdjclQ7hPEoV
	qE2KMvEPKxlvhuhHnPaRYyf9BxJnXI8iWhGHtKxRuAuJKzf2Ow8Hy+nWdG1MTBkIMRRyLiTDfKbC2
	nuGg8/OOmZdd/MyLtDS1eboTTjDhPjQXXhm1K0Owgjc8WzyS2KmHBTQKRZryw2OLuO1nCICmbSW22
	1mAjVltA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uH7v5-00AQE4-LW; Mon, 19 May 2025 23:21:11 +0200
Message-ID: <2ebb7982-5462-4ca0-9936-f0821cbb9036@igalia.com>
Date: Mon, 19 May 2025 18:21:06 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix usage() message to clarify timeout
 value unit
To: Jonathan Velez <jonvelez12345@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
 dave@stgolabs.net, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250515174523.349331-1-jonvelez12345@gmail.com>
 <FBB34B65-F524-484C-A505-09AC20AF1ECB@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <FBB34B65-F524-484C-A505-09AC20AF1ECB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Em 19/05/2025 17:30, Jonathan Velez escreveu:
> 
> 
>> On May 15, 2025, at 1:45 PM, Jonathan Velez <jonvelez12345@gmail.com> wrote:
>>
>> futex_wait_timeout: Fix usage() message to clarify timeout value unit
>>
>> Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
>> ---
>> tools/testing/selftests/futex/functional/futex_wait_timeout.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
>> index d183f878360b..737475df9242 100644
>> --- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
>> +++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
>> @@ -31,7 +31,7 @@ void usage(char *prog)
>> 	printf("Usage: %s\n", prog);
>> 	printf("  -c	Use color\n");
>> 	printf("  -h	Display this help message\n");
>> -	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
>> +	printf("  -t N	Set timeout duration in nanoseconds (default: 100,000 ns = 100 us)\n");
>> 	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
>> 	       VQUIET, VCRITICAL, VINFO);
>> }
>> -- 
>> 2.43.0
>>
>     Hello,
>     
>     I’m following up on the validity of this Patch.
>     
>     Best Regards,
>     Jonathan Velez
> 

I think the current string already states what's the value unit of the 
timeout in nanoseconds and is good as it is.

