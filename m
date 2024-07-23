Return-Path: <linux-kselftest+bounces-14063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56D6939DA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E68B223CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFB15278E;
	Tue, 23 Jul 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUQGSc5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5215252C
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726655; cv=none; b=SwxkTo6IlpzCAlkiOkfCwFoFoGUnGO8e9LDgn5r2x46w70bimTDQESmuAxDNpwXSpegaQv+CrjicxbTYAwepnmkg/l1fpoGmFFhpvaPjJ1fUcuJAj8nR/QG9RkvWzdMihR1z6JXpn1GvvkaYKVrmLaoayEc+yVwBKkTaHdOFL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726655; c=relaxed/simple;
	bh=Yncer6iw6PhfpuYRJqGAfWtYlWU0gZdo6+GNkPi9OG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LU6LGrhYy2z+fXAe++1FdzrtKxWWBDcSNoBjzgESp12FzjVu4p4SSFID/ATIDl+Rl9GhX+LapRLuT1uKoorObWw1sBQ6LfLkTi0X8DxSxb1skvGPMwnuT0FPTfziP9cIDmk324fz5zQ7yv1CFFF5+9s3utV1Rtf/Y6dXF7ORQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUQGSc5T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721726652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=di3b6+JsOF88ta+JmszT4sf4RN4aT8grE7boITm/z88=;
	b=TUQGSc5TZ45gg05R0VAejsFz+jnac7vTah/6oF/tL62Ov/h9iwAWnY8utcrN7XF0FbhJNA
	UvlCwUIyWbH0Wq+i2d5vbdeJK/KzIXWJ7j3R+oKUPpM5O4R/xEsxrh6E9dDcn7X3PBXY3I
	A3YWyftUgwtMpwGfsuuZSsLMuyuh3OA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-ZNc-ANkFNHy2KlV9trn7Sw-1; Tue, 23 Jul 2024 05:24:10 -0400
X-MC-Unique: ZNc-ANkFNHy2KlV9trn7Sw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so7377861fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 02:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726649; x=1722331449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di3b6+JsOF88ta+JmszT4sf4RN4aT8grE7boITm/z88=;
        b=QxUtDOw1GYthwGPQCvAVVMwtHD3c+PXmlhM2tdVBTdTK7wPklQf2+KBLmASgfW0Lc8
         UK90w1yY6p673uYjMKIJSt1b6AdX5I4uZ1xIEOi3JEIcFcVnpYRLKqf18fUR3pHYOBA+
         ZpWDpwnFfhx+qbt9Rj14KgRqs5a6FJc+SG7aQv9coE0/OwTATswhhogbwS0oqEdMeswF
         bx4V9Dt+RXvbYhxIGfyoFiWMBsFEKGwuyUjHWsG89SPgbt4MOH68fiyYMlJsO87XdPuw
         lqCl0WeajaDGz1AXhrxw2Ud7M0ESKJUxw/7tFdo+tXDO/2xPOOc7Yx1Zs3QiN8IBdzxI
         /dqw==
X-Forwarded-Encrypted: i=1; AJvYcCXHf1qQeNyGARY6jCUdsB1kU6u2pHg56veP0liaMmzh5gYTe0osIQhu3SDNUDrcApXydMjJtZyXgHympF8mzvyE5Y0huCF9jgz14hdaPvRS
X-Gm-Message-State: AOJu0Ywzm+vQHisGy6zno5khxBRdW5v368Roe49M8AfafM6QEwC41wWV
	k8u6QJetDk1pv4evSefrG7J6Pv9B6onh63/noWNgXKOwRaqwPatygXbYv9RpWbk6+wxIQnusfkd
	+7uE87tmMxK9Qdiqm0p5snRjxS1uoDavYTS1Kv6f1+EKsC2ckg+C4VBt1uE9QHVFZew==
X-Received: by 2002:a2e:9357:0:b0:2ef:1c03:73e6 with SMTP id 38308e7fff4ca-2ef1c0374aemr31782141fa.5.1721726648767;
        Tue, 23 Jul 2024 02:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJWuDgcUZs1POGKMrOCZ33+7BgDR786BaYJXF0A6bQ28l60Nv/FdFgs8F4ROQIQKbxoHgZfA==
X-Received: by 2002:a2e:9357:0:b0:2ef:1c03:73e6 with SMTP id 38308e7fff4ca-2ef1c0374aemr31782081fa.5.1721726648322;
        Tue, 23 Jul 2024 02:24:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868480csm10896053f8f.13.2024.07.23.02.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:24:07 -0700 (PDT)
Message-ID: <416ebc12-50a1-48e5-a17f-8999f3b460cd@redhat.com>
Date: Tue, 23 Jul 2024 11:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support
 setting bridge fdb learning limit
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Johannes Nixdorf <jnixdorf-oss@avm.de>,
 linux-kselftest@vger.kernel.org
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
 <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 10:30, Nikolay Aleksandrov wrote:
> On 23/07/2024 11:22, Hangbin Liu wrote:
>> If the testing kernel doesn't support setting fdb_max_learned or show
>> fdb_n_learned, just skip it. Or we will get errors like
>>
>> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
>> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
>>
>> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>   .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> index 0760a34b7114..a21b7085da2e 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>> @@ -178,6 +178,22 @@ fdb_del()
>>   	check_err $? "Failed to remove a FDB entry of type ${type}"
>>   }
>>   
>> +check_fdb_n_learned_support()
>> +{
>> +	if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
>> +		echo "SKIP: iproute2 too old, missing bridge max learned support"
>> +		exit $ksft_skip
>> +	fi
>> +
>> +	ip link add dev br0 type bridge
>> +	local learned=$(fdb_get_n_learned)
>> +	ip link del dev br0
>> +	if [ "$learned" == "null" ]; then
>> +		echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
>> +		exit $ksft_skip
>> +	fi
>> +}
>> +
>>   check_accounting_one_type()
>>   {
>>   	local type=$1 is_counted=$2 overrides_learned=$3
>> @@ -274,6 +290,8 @@ check_limit()
>>   	done
>>   }
>>   
>> +check_fdb_n_learned_support
>> +
>>   trap cleanup EXIT
>>   
>>   setup_prepare
> 
> Isn't the selftest supposed to be added after the feature was included?
> 
> I don't understand why this one is special, we should have the same
> issue with all new features.

I must admit I was surprised when I learned the fact, but the stable 
team routinely runs up2date upstream self-tests on top of stable/older 
kernels:

https://lore.kernel.org/mptcp/ZAHLYvOPEYghRcJ1@kroah.com/

The expected self-test design is to probe the tested feature and skip if 
not available in the running kernel. The self-test should not break when 
run on an older kernel not offering such feature.

I understand some (most?) of the self-tests do not cope with the above 
perfectly, but we can improve ;).

Thanks,

Paolo



