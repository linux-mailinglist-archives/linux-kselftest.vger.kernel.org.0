Return-Path: <linux-kselftest+bounces-14076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B1B939E23
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2984B21AD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCF14D422;
	Tue, 23 Jul 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="o6au6aVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621314A4FF
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727844; cv=none; b=GJG1Lg2q/wSfusLYW1BCDAmQZuvu53FBnItwMnKDht0bN1S+xLigb7ctdGDdh8Cs4o2AjOcoZMOtBYd83jS5SjYJnQZAGFSBFnRR3VwhxIgutGTs4QfNr7ZboLNcZ1BCISKzqrnTkDqw1BvaM7x0G6paF2FuPX1xndqMd6y2iCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727844; c=relaxed/simple;
	bh=Nam78+M2Soy8/lRIJN/Vh3xSIk93Op3wC6MwnVpMp3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSdbq1I6jrmfn24ThR8P2qpGePP5S2TkcRU/nKm6Y00dzPnKlpypX/rJKtOSn63ZRdIkvovRBZ1/nzDEHb8EtWazWbsZ7Y1HyDyReQf2kh7ipY8NUuw1JwfgsVi0YvOVFJMyVTtJmhVP6O4ZBSeX9gUOHetYKGOgVk2wR4LbKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=o6au6aVl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so77328931fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1721727840; x=1722332640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRSXpraH9s9tylzoOKuBfCsXylfNT5Y6OvorPeW8FOc=;
        b=o6au6aVlsoDh2JVJAdlTAdgkO73+/UfHK312gHYRChHubYRdf9jR6cYjTMG4g56PGV
         ORkLlJmJzNnDEb+0VrxjQzZ8/QU2asGh6D+J8GrvJzghDvx91iKXwZlCrnPxDgriJUEE
         536kRUaZABShxf2+fbq77xZSPhAqolJkOMs0+SWjioLmQlpCRbP2FkN5zhWgK6r2XtVB
         LMG9kX8UScVjl0i2QSErZnNYlGc+usbQLYVD6ki5kzCa/JqHuxeiEFu507dC6xAry6+Y
         UP3iZa4Y21BZc+3CpL0pnvmqiY1UZP2+gY+iN4Eggc3k7+vBr3DOlzsDR5YRxbxNpMXS
         158g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727840; x=1722332640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRSXpraH9s9tylzoOKuBfCsXylfNT5Y6OvorPeW8FOc=;
        b=ksL0DSqRh1zHhfKJ2tIHlxqVQFptqnpmNjoSTfzbwTxhY5OhUAJxQw94F/VeC+p7na
         xtX8UjjVJ5SEFYIsxbXYp9a3b/qts3oj6wMeycxr7TF3GVsuFnxFqA4lm+SzN9B+kwmd
         B9XbVdXCZYZKAGM7JF6HtxLXyo6DRPMpC+9hGa0q/8GZS9MpVBYYWRVyV1ixrqZt6Fl/
         11iTrpJFlvXHnUdZe6xv2+Mj5r/cK48lA729aW83CRU0dEzC50y3pRu6cw6KluADNX21
         x7hdU/E/mNtl5YlvyxWqR2NLnFeAgGIgQ3UuUZg3hkOCjj/XsGTXaZqtqFFY2iOfIeaa
         7nRw==
X-Forwarded-Encrypted: i=1; AJvYcCVBvRITNknRfrgmmXnGDqVNodjArf0XMkoSQuGvk+H55ezSv7r2yIQUcuMZBRsIpZmtbOTnPAk/UNhlbPq+ziETJq35NCzdAkhomHjUEh/H
X-Gm-Message-State: AOJu0YzqoWLi+lB6g0a9eye3bdM8XZusi8np9RD1Z95pvltBWaEjY3uP
	PXWMFeaS7pgrNN8KbojoMl7WsgzfvO1TLhmpqYj3NvPaRsh6PfnJYFYwrYNvuh0=
X-Google-Smtp-Source: AGHT+IGadT6nydv7bbqtypowfsklEQTxOwqo8CN5PLw11lmyeug4EPH4xxpbHRG9E6sc5LBymNPR5A==
X-Received: by 2002:a2e:8784:0:b0:2ef:1ba9:dc5a with SMTP id 38308e7fff4ca-2ef1ba9e0aemr74839531fa.28.1721727840103;
        Tue, 23 Jul 2024 02:44:00 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785b89sm516698466b.36.2024.07.23.02.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:43:59 -0700 (PDT)
Message-ID: <eb8196bb-5ff4-4c98-8b62-c2cf35f3135e@blackwall.org>
Date: Tue, 23 Jul 2024 12:43:58 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support
 setting bridge fdb learning limit
To: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Johannes Nixdorf <jnixdorf-oss@avm.de>,
 linux-kselftest@vger.kernel.org
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
 <d5dc8f31-26ed-488c-9d63-a96b95609814@blackwall.org>
 <416ebc12-50a1-48e5-a17f-8999f3b460cd@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <416ebc12-50a1-48e5-a17f-8999f3b460cd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/07/2024 12:24, Paolo Abeni wrote:
> 
> 
> On 7/23/24 10:30, Nikolay Aleksandrov wrote:
>> On 23/07/2024 11:22, Hangbin Liu wrote:
>>> If the testing kernel doesn't support setting fdb_max_learned or show
>>> fdb_n_learned, just skip it. Or we will get errors like
>>>
>>> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
>>> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
>>>
>>> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>   .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>>> index 0760a34b7114..a21b7085da2e 100755
>>> --- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>>> +++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
>>> @@ -178,6 +178,22 @@ fdb_del()
>>>       check_err $? "Failed to remove a FDB entry of type ${type}"
>>>   }
>>>   +check_fdb_n_learned_support()
>>> +{
>>> +    if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
>>> +        echo "SKIP: iproute2 too old, missing bridge max learned support"
>>> +        exit $ksft_skip
>>> +    fi
>>> +
>>> +    ip link add dev br0 type bridge
>>> +    local learned=$(fdb_get_n_learned)
>>> +    ip link del dev br0
>>> +    if [ "$learned" == "null" ]; then
>>> +        echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
>>> +        exit $ksft_skip
>>> +    fi
>>> +}
>>> +
>>>   check_accounting_one_type()
>>>   {
>>>       local type=$1 is_counted=$2 overrides_learned=$3
>>> @@ -274,6 +290,8 @@ check_limit()
>>>       done
>>>   }
>>>   +check_fdb_n_learned_support
>>> +
>>>   trap cleanup EXIT
>>>     setup_prepare
>>
>> Isn't the selftest supposed to be added after the feature was included?
>>
>> I don't understand why this one is special, we should have the same
>> issue with all new features.
> 
> I must admit I was surprised when I learned the fact, but the stable team routinely runs up2date upstream self-tests on top of stable/older kernels:
> 
> https://lore.kernel.org/mptcp/ZAHLYvOPEYghRcJ1@kroah.com/
> 
> The expected self-test design is to probe the tested feature and skip if not available in the running kernel. The self-test should not break when run on an older kernel not offering such feature.
> 
> I understand some (most?) of the self-tests do not cope with the above perfectly, but we can improve ;).
> 
> Thanks,
> 
> Paolo
> 
> 

Interesting, and unexpected at least for me. :) But okay, I'll keep it in mind
when sending/reviewing patches.

Thanks!

For the patch:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



