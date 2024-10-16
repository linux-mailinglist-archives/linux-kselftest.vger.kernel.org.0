Return-Path: <linux-kselftest+bounces-19827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C9D9A043F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9264C1F27678
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F721D8E1E;
	Wed, 16 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AyfvSMEk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1031D1E78
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067360; cv=none; b=Ec8xJlbFsy7D7dOPqMkcLqkRJbOLHPoCYFfCRi7CogTlhpqfwfttlyvCF9KgvKfWSsocbS0+mjPXSj7rvx26xF6UWku/lhXyMgcAqUNpYs1OPwOQ8Aa9OEOnT8o0rfkxWY3OoA5OJvkrVAMkBSanPeiT1lns4PboMqYgFMOv63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067360; c=relaxed/simple;
	bh=N202Jvd2z1R+2BguPkpH3/D11R0swo/kiwbD+Xzurjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6Y5imDgzrVok3H5amokUK6zJUq7fs60RDdWVM6787hbE4W+4tCFGzc/Ajy8VGe1UUTUqCQ9ceWYE0XC5O8ReaaXmWbAMELaEdkxPOlJgkgV6iNJm6cp6PhHp1Wcn7yZsXR+MTUG7Ikq2+/62JwySZPoFYduCWbWyK/gRuLSwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AyfvSMEk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e681bc315so483731b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729067359; x=1729672159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trF/dh/Irh2UNMh3v7o1TScBHHiEUzOckr2Jk/WjDJA=;
        b=AyfvSMEkrd+ZKg6YK3Y2YZHP9GYjm2sAkPYS+wVpLCsL2UGVGSRM61GMNShVLeJvu2
         CaAqcNzI+pygic6Ndc5z98kddhJ9DDyPYWbaUo68BVjfr/ZOscasFBN674bahKY2bjVE
         B8TKBBELfNP9xyGsbIyisaArNfvhI4WXqbT2ih7rB42NHbdkVSQZiEjXlmhopfs0o5nR
         yinSq+y/32S5jkLGf/xHy2/4dJyfJmg11pxHqpscMviwFcWhIRyzS4QDMhGiaml5y2sq
         zwwLGMYph7IBLIQk31ZKneWKT5gWdxVo8AYaIODujFDgQCUtSg4QvwhnWLpTHu+y9+aM
         7LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067359; x=1729672159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trF/dh/Irh2UNMh3v7o1TScBHHiEUzOckr2Jk/WjDJA=;
        b=apNyJkMbQNLxM4a0dT2tnxG03LGg7ftZd5si/tyUGVmsd81U8jZwXMSbyxRSTDpoSE
         vWwFiCV094foI2a7w+GhZJrukSFwDdndTJ3XWeIY9VylgMumQTBIAbuSd6huqIupLHHe
         NVxNS11UYSzsBQTExyVCKvaEk0xgTV/aattT8MZTmR9ZdLEI3/Ls+Y/LWfZ2RXfi1jcU
         jkSb2kXgsz14QT3vgInhIa0GzxJcDO/6XEUvYCMQS45E4+01BZvJKVFyEO7cKn2CnCu/
         JO+9RGgh+AnH/eJ3a2me3EKW4p/jMw0VsXYzrQRYagM0maA1/RdFiR4wUbz3Uage6a3B
         tPpw==
X-Forwarded-Encrypted: i=1; AJvYcCXl89tus/jLZMRPxQK4WJQYYIDe6b3/te8wy6HF0gzM+x69pnUvTKGBuLgPg24bedeh+sImrFWSgXqwjF8MYDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN576bsKTd5NYitcNpBqpcr6vIqOkLmdyn9kIQwLExyYXW2iQ7
	gFJfiHEq1PDo0rlwd2UZoLUs4nNeUna5VjSyF7dAylOXR7a01hOxWAs79zfS5Qw=
X-Google-Smtp-Source: AGHT+IEYBjdMZopMAhLWooBm5Yhp/3iKwxBpg7IAbCpfERdDHy0HbUnN4JDCE5pHIbU9U2pCUuA5+Q==
X-Received: by 2002:a05:6a00:62c7:b0:71e:4a0f:4d1c with SMTP id d2e1a72fcca58-71e7d75c020mr3702907b3a.5.1729067358597;
        Wed, 16 Oct 2024 01:29:18 -0700 (PDT)
Received: from [10.68.122.241] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774cf306sm2563312b3a.153.2024.10.16.01.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:29:18 -0700 (PDT)
Message-ID: <1e49c65d-5fa0-4559-9251-b75537d43ef8@bytedance.com>
Date: Wed, 16 Oct 2024 16:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v3 1/2] bpf: Fix
 bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, alan.maguire@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
 <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
 <8a81f13f-c877-435c-9887-732b20a7d827@linux.dev>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <8a81f13f-c877-435c-9887-732b20a7d827@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/10/1 10:27, Martin KaFai Lau 写道:
> On 9/14/24 3:32 AM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> 
> I think you meant bpf_get/setsockopt with SOL_IP will fail. so 
> s/ipv4/SOL_IP/?
> 
>> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
>> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
>> use ip_queue_xmit, inet_sk(sk)->tos.
> 
> Change lgtm.
> 
> Patch 2 has a conflict, so can you please reword this commit message to 
> reflect the latest change. e.g. afaik, this is no longer specific to 
> mapped address or not.
> 

Sorry for taking so long to reply.

Will do, thanks.

>>
>> Bpf_get/setsockopt use sk_is_inet() helper to fix this case.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   net/core/filter.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index e4a4454df5f9..90f4dbb8d2b5 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5399,7 +5399,12 @@ static int sol_ip_sockopt(struct sock *sk, int 
>> optname,
>>                 char *optval, int *optlen,
>>                 bool getopt)
>>   {
>> -    if (sk->sk_family != AF_INET)
>> +
>> +    /*
>> +     * SOL_IP socket options are available on AF_INET and AF_INET6, for
>> +     * example, TCP over IPv4 via INET6 API.
>> +     */
>> +    if (!sk_is_inet(sk))
>>           return -EINVAL;
>>       switch (optname) {
> 


