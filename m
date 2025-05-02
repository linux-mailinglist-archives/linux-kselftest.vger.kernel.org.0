Return-Path: <linux-kselftest+bounces-32192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F2AA72D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E8E3A3752
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FB254AF4;
	Fri,  2 May 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbcA53Zq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10432417C5
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191158; cv=none; b=JrY8Ze9XDYDwyOX/9SNZI0GRtneFoklvVvrbNCa4jH8IzuZfGpBIZnsnetoBj8lGpf6xBb5oGvm0ZN+cdRlmfOnWZuRTGMu578UneX3UrMEUj/AIsq6DgUKVSEDfeEDWjxS5lzzZyQDlliWXl/mDg5HF2rfPIDkFBmzL5NPY9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191158; c=relaxed/simple;
	bh=ThxPZZefkO6ccE1r7dEv+qr8reoUOV9RWERJ1bG/7MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axaOMPKLKSGY/aS9wcAwqTF3QSeJwYcgIGGPXXlFL5xZ/MtV0RKw0eg450139ecdzDE0czSe5/TM7D5aaebDQcrH5vTZeFNbBskFLHVitQgkfsFn1r9jhZ5qk9rkt/+gwCf2xSlgjwB12ravjoIx499kMMRZS+LJOB6ayL17orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbcA53Zq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746191155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3gW6mlhffHhh1n9pvflSPn8OiRLEan3lJqSmN71dWk=;
	b=CbcA53Zq02r0jOcISUM7kLT9HylOFILlFplLCAz10hbxa7Fp8UMl9r2q1EUVxhmz8/Ws0/
	ALGHotgWE0t4N69yMcm24qEJuvBcwsZPvIck4ktc6KJCodUwYA7rF1iD2NDS71eC5kbfd7
	tFUDHG4cNgOO1BSPB7frMcRP88zaEtU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-qzimhkpPPgqSLTEn81nslw-1; Fri, 02 May 2025 09:05:52 -0400
X-MC-Unique: qzimhkpPPgqSLTEn81nslw-1
X-Mimecast-MFC-AGG-ID: qzimhkpPPgqSLTEn81nslw_1746191152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32b08so780218f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 06:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746191151; x=1746795951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3gW6mlhffHhh1n9pvflSPn8OiRLEan3lJqSmN71dWk=;
        b=qUe1dpbCzWWgpEq99dCZiOgn88iSPtIkfd2D5ToA+7z+W/HOSSECS+s14eL/No3Xb+
         Y9J1D5BZpw0zsPufHE8MCuI5O+b58PN386cDRLL9ym1JNx1GNbsbtnC1YrMMoN2i6E0W
         RYYLI8Nha5ECQkvYc82fadr5QjpROGdHF38VkxSqBvykH1Pj/VcTTFVX6wBFqSDR1tDi
         3/wj9nweTbNbJm3CGXPEgfng81yKr4bDVP8D/0TOuUggdaKXa+2ff5qr6Oh0Lw4h6m81
         ZBZdE+UFniY+Zk2NeG4ayl3JNrtvl/yYITiTR5fOePIyH0R34g568jPrQiB6g0HQeBN7
         eOwA==
X-Forwarded-Encrypted: i=1; AJvYcCVkSVKvx1RRpTPc3z4TvZgPWtlhwOMSyE8hfw+XYFHqdkuMMzjgIVE9DoS25zBLwIFUo5443o5O5AsrUp/RXgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztT6PmahJXvWL7Om/v2zSXN+LGy0EJ52JEE/hsR6LtKdM/JRvn
	n06QP2fvelmeXd/5omCmVDqsCBdd4/rjKrl7bltvG+mnUkDbaptA8VAHqrAT54J6CSUkd74IUAX
	4OJ5n/BPnxU8oVUA5kWIqLZqOKchOudxblfaAocIX+40WlDX02OplnhSiNOrrjUg4wg==
X-Gm-Gg: ASbGncvnKDrG2WNPz2AAzIj/cNCw2jGFlUOe5HWUNXEYudH4uiMh62TJ76UBIBhpKLt
	eFB5AlwtkSQZDET2Jw247ZdlFpBjUO56sjZHBSqc6AmQ7h4kMEW08KcPQPeGSpE5FSAge+pE5ho
	XzCZoBmpALVWg29KS6XgjhZWrw7iifKv33Agl/MqJX+H/w8KaU3RCRDQCznriuPddg4uAcNTttv
	EpCfLTDjtqWtXXmp++BCf0NDW8X46MJSIokykW9Q78LlM6+0KVw7X2glxBJehQY3c7hBtug+msx
	iaz24GVNwNVF3TAzZkY=
X-Received: by 2002:a5d:67c3:0:b0:3a0:99de:5309 with SMTP id ffacd0b85a97d-3a099de56ebmr1607627f8f.18.1746191151395;
        Fri, 02 May 2025 06:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmlDrq4esQgIs8sXEIsIllslf5/QjKHYKbfmMh14tvL8V/tT0QxJugXZSxfAWZv8Ds0uWHHQ==
X-Received: by 2002:a5d:67c3:0:b0:3a0:99de:5309 with SMTP id ffacd0b85a97d-3a099de56ebmr1607596f8f.18.1746191151014;
        Fri, 02 May 2025 06:05:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3bc0sm2164980f8f.35.2025.05.02.06.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:05:50 -0700 (PDT)
Message-ID: <f94dc055-6c3b-4fae-868a-723f9dc63db5@redhat.com>
Date: Fri, 2 May 2025 15:05:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM /
 timeout
To: Edward Cree <ecree.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, willemb@google.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
References: <20250429170804.2649622-1-kuba@kernel.org>
 <2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 8:03 PM, Edward Cree wrote:
> On 29/04/2025 18:08, Jakub Kicinski wrote:
>> +class KsftTerminate(KeyboardInterrupt):
>> +    pass
> ...
>> @@ -229,11 +249,12 @@ KSFT_DISRUPTIVE = True
>>              cnt_key = 'xfail'
>>          except BaseException as e:
>>              stop |= isinstance(e, KeyboardInterrupt)
>> +            stop |= isinstance(e, KsftTerminate)
> 
> The first isinstance() will return True for a KsftTerminate as it's a
>  subclass of KeyboardInterrupt, and thus the second line isn't needed.

@Jakub: I'm using the selftests code to refresh my rather rusty python
skills, I think it would be good to address the above and keep the
codebase clean.

Thanks,

Paolo


