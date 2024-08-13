Return-Path: <linux-kselftest+bounces-15233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADA950938
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57261C228B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A241A0706;
	Tue, 13 Aug 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftY0zj6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB51199245;
	Tue, 13 Aug 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563429; cv=none; b=lnyfC4nNESnTjnWxoxKcFVLbhgI5PDLRmcakFVjicEnvcN3x1xBEzLB857/rdywdF+llre0cnCh68doIOonZEkOrRgjx4ijb6tWhUyvVWWo9omxXFoOd2CMELK13jGAEpHTmZWO+df3FWy+XI8dFGUIKZzsA3eXmITgL+qU5IWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563429; c=relaxed/simple;
	bh=QVJpNiVerk9xPP/kZXVkpqNKK+oHO9hrON1+2Sbx5EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmuH0x0X+nKvupuFV/VMt+LvpidEE0hwAua/GhB6cH6hdyoCZJLQIbRbKk2BOSPWf5ajWpyuGH0AtNGeqy6m/7lfolexZlo26+aWhU6wSndNHtV3Rhyn9mqkTCiDJ7MtpQfuCwfyMJehsHsTDXxPF3oatwGlITTBNim5pUe2GXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftY0zj6W; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so3825873a12.3;
        Tue, 13 Aug 2024 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723563426; x=1724168226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHvjoU9H+Sgc7R6GwAwflnlqFXRVRCL0RMPB/ZWgdjQ=;
        b=ftY0zj6WEtpvzBRGabqeH6QcbB6rjbxVAvJ80w0YK5UJ/1J3yrms+vNlpTTCKEHV/w
         hrkfw02iqV0VTyl+rwSzXmW7LQTHUAOUV4XDtQJ6YxTWYyTHnTwqctqyfPhD0fe5BbjK
         I6LKcIvFX9Gymr34V1XucBGFbbycHRCHJrTh+KFSfnY4MFmZeetu/Mf6yEqabssBfpo9
         WO3MBpXks9SoHSjsU7ibhfSPdRkDPH/ogOWFXwEhBTNfNRbpH5SYvYAsNjhIUt0zQ372
         GMO/K0eQ8Mu5uepD27p49NLIjasuxDcn6kGSw5Drq6akgkAJiFxN1zmH0f/X/GNiZTna
         1gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563426; x=1724168226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHvjoU9H+Sgc7R6GwAwflnlqFXRVRCL0RMPB/ZWgdjQ=;
        b=T+E9C7+3Yx0ly/m2Nl38bgovdmgx7PulJJtgA/6JjSgPHuA6mplTNNm+4Te1AUFqXV
         y31htHGGCNPENpVwF1+aXI8999n/by8Sy2NHtRVkIQi+a97+Ykt5KuH1bmFg+NZnhpHG
         0ITOOe0atM4sKj7dqXCbj0C/aaPeIhoj4AAdxDTt1ToXswFgM6Za4C+/D2wlxYv5hIeE
         yl5DphUNc1bXFASFoy7nhIQg5rPYgtADwzpc4XrfILJdVufyaQMfgPelIHwrI9W+ioMd
         cCAndk6+gfWsM7h9ibz2lnPdCLeeLXjht2DCvddLVs49JWTw8odsQTEko1cP+hHWSGww
         tseg==
X-Forwarded-Encrypted: i=1; AJvYcCUieHzsPZHblNAfOXBA144dldpmxn4jT90wncrcniAF2rNI9SAJ5Xw/VFxtsfr+L13sDl7juOXd1DAo9Z/usVD7qVxhpFZ5dVqoIv4PTSSiJuYx6TNH8DCWKSKrqQktQjUszHNqvDNvGwmx8ejWl4hJUpL6gpE57rpVuLRpJ3x87vqAs3xB
X-Gm-Message-State: AOJu0YwlZOt49HPeKcfieG6fUxw4uZcalIqGq/tjIAr8mTdAvBKZzjHj
	SmPbdFXh1SwKWW/XxcZ6jrCCAJo3X7zF8aNOULFFA9R79Two+YOBmMmzWQ==
X-Google-Smtp-Source: AGHT+IEQlDbnLbzSs4uXeAi5uFLqqcCOEWgKmEg9oXeIQtjqLte9jlaPMXzHCYFh30qYZAq1w3tIQg==
X-Received: by 2002:a17:907:f186:b0:a7d:a29e:5c33 with SMTP id a640c23a62f3a-a80ed1c1d76mr303743366b.28.1723563425896;
        Tue, 13 Aug 2024 08:37:05 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-227.xnet.hr. [88.207.40.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f45c86sm78694066b.25.2024.08.13.08.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:37:05 -0700 (PDT)
Message-ID: <391af1fe-53ff-4678-a78c-74262724c2e9@gmail.com>
Date: Tue, 13 Aug 2024 17:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftests: net: af_unix: cast void* to char* in
 call to macro TH_LOG()
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20240812002257.23447-2-mtodorovac69@gmail.com>
 <20240812151725.GB21855@kernel.org>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20240812151725.GB21855@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Simon,

On 8/12/24 17:17, Simon Horman wrote:
> On Mon, Aug 12, 2024 at 02:22:58AM +0200, Mirsad Todorovac wrote:
>> GCC 13.2.0 reported warning about (void *) beeing used as a param where (char *) is expected:
> 
> nit: being

Ouch! No patch is small enough that one should take its correctness for granted. :-O

>> In file included from msg_oob.c:14:
>> msg_oob.c: In function ‘__recvpair’:
>> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
>> 							but argument 6 has type ‘const void *’ [-Wformat=]
>>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>>       |                                        ^~~~~~~~~~~~~
>> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>>       |                 ^~~~~~~~
>> msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
>>   235 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>>       |                 ^~~~~~
>> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
>> 							but argument 6 has type ‘const void *’ [-Wformat=]
>>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>>       |                                        ^~~~~~~~~~~~~
>> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>>       |                 ^~~~~~~~
>> msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
>>   259 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>>       |                 ^~~~~~
> 
> Thanks, I see this too.
> 
>> Casting param to (char *) silences the warning.
> 
> It seems that all callers pass a string as the expected_errno argument.
> Perhaps it's type could be updated to char *, if that is what it is.
> I think this would avoid the need to cast.

Agreed and verified. If it is OK with you, I might post a v2.

Best regards,
Mirsad Todorovac

>> Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> 
> ...

