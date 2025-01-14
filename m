Return-Path: <linux-kselftest+bounces-24462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06F6A10BEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46F51881E89
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F451BD9E7;
	Tue, 14 Jan 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xrll/1pW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6E35966
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871180; cv=none; b=UVDAAEAtZxlrP+zW1wAqJvsq9/Unb4KU9WxbOwBISu8UjTxhHvHjCUppjWt/Sa7X27Bm76ZfBnrTBCb2smjpUqoRFVTgs4lfanbD3Z/rwrbD0UWiJP/PQpD3HIrE+ZhulbY9B+TIqb+ZMco0xkzNUPj3aoVbMIpaybleX+w/pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871180; c=relaxed/simple;
	bh=DPxSBXYj5+Cie9FQhV3urqAbzP460lDWuePHUdfwhY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtGNBDFYKvoy5OqXUrKoS/F3d5lAYiJZmxP4cWUjlRjNGMrA7WWFZxhV7An2Aw7fnkevWCEiB5Gl43fru0ztVO7HJ2NXkmMVKujFXiFV20OEOpzO7V4oHtb7AxVVKTZmnf6eqSIsO+7iKcbtYfsi789xm/0Lde991mPPJB9dxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xrll/1pW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678cd314b6so53361841cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736871177; x=1737475977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1ez0Y9/qkSWPKaIZfJ3AgE1cJ4EV6MroSfCc0eODCI=;
        b=Xrll/1pWKSrhiA35Eatzn/BczuelTUdgepvzkBD7IEq5/nkaR2W/DmAN9aW/Vjwi+0
         5br2CChhpafae7l5YTCduRJn5++y6/9l9uk/6vdvx3/xl//XWRaktQjXo5+/l1eDF7JE
         uiM5vSfVfKGZy6DCqb+gHoS8qCbWvJ6gUcvVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871177; x=1737475977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1ez0Y9/qkSWPKaIZfJ3AgE1cJ4EV6MroSfCc0eODCI=;
        b=HNWP6d3Ta46MMIkFi4l+InLa0RP98dQZ6wV09areQAzexmPsiOj8sv3u760iqVd+vj
         gvHHICWDCHg9UB3UE7LmRzQsZBuPGnCYTjWaskLh94Ci0mfH3mpRO77FV1Alt+hpLCbm
         CsZdELMK8Dkd1UScGgnxVb7mHaZ8LOxwC5m6brph++ZlEGTSHoOfPgy0zQzmGBrGoMYD
         ertugSZqeIjfdUzwCEXuqOftoB0Hyssa92OLaaZKVemBeBegeKYU975qK422X0akUrqM
         VMs1Pp1ScjnM2RwTjjCXHgZgWjRdfKG4XmRQSHQwiqV4+DMflBkfH42ccpLJGFPfPb0u
         Ed1A==
X-Forwarded-Encrypted: i=1; AJvYcCWpoF1HlsQdPWTKY4GMBcXR8uJdJg8F43uuhdCK9fliSjytyHZMKnbjWSK7WrVD4+ltBuG0s2GfTOj6/kgPBpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmfwH5To99LoqGSiGiymPFsxCWq1Aw4iq63irzONkPtoyUq2n
	h5zkMYofodQLUL+axhyuuVaS3VpjqQ6ZCIJ4fiCkHYSvzLEm94EOj0m9Qo0Rhv2lPTdug/rLVQB
	c
X-Gm-Gg: ASbGncu2n6PBB48Mxwaejxg3aRuNWJMYM0qVrF1AItn78C6mT3bxggxpxDm8Nty3o4N
	kbXjMXr+IImSEfLHSknWpgwPwhS97KagkIQUoI6UZ+82uOaeFrWg/9l/BOvznCzpX4wdcXxMm8Y
	cv4VFLHEi7VFhyY8I0/I5i/O0EF5xSTv0eyq9eKZExUCQmC35ZS16NbjihU8kRMXFaWFeGJlbvG
	tPuLtIr30NJPMviFN0n170P2c25IhjVOyv5KB9qELJg0CQCNhJCGTCrSbZ1AialzHI=
X-Google-Smtp-Source: AGHT+IHrpXsovA0TmTlCENO3wBEAm5DshEtDzJ+tfCxG67zi2dsgrXWeJ08LvJG3WrXCFjZLz5iriQ==
X-Received: by 2002:a05:6e02:114f:b0:3ce:7cca:7c0d with SMTP id e9e14a558f8ab-3ce7cca7c40mr17669525ab.12.1736871167110;
        Tue, 14 Jan 2025 08:12:47 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce7d9d720esm3366995ab.70.2025.01.14.08.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:12:46 -0800 (PST)
Message-ID: <af9577f7-71fb-4760-9bd6-c3fc43aa0f30@linuxfoundation.org>
Date: Tue, 14 Jan 2025 09:12:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Raghavendra Rao Ananta <rananta@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241210224435.15206-1-rananta@google.com>
 <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
 <291b5c9a-af51-4b7a-91de-8408a33f8390@efficios.com>
 <fbfe56d9-863b-4bf4-868c-bc64e0d3e93a@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fbfe56d9-863b-4bf4-868c-bc64e0d3e93a@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 07:27, Mathieu Desnoyers wrote:
> On 2025-01-14 09:07, Mathieu Desnoyers wrote:
>> On 2025-01-13 18:06, Shuah Khan wrote:
>>> On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
>>>> Currently the rseq constructor, rseq_init(), assumes that glibc always
>>>> has the support for rseq symbols (__rseq_size for instance). However,
>>>> glibc supports rseq from version 2.35 onwards. As a result, for the
>>>> systems that run glibc less than 2.35, the global rseq_size remains
>>>> initialized to -1U. When a thread then tries to register for rseq,
>>>> get_rseq_min_alloc_size() would end up returning -1U, which is
>>>> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
>>>> have the support for rseq symbols.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
>>>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>>>> ---
>>>
>>> Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
>>> commit if for Fixes tag
>>
>> Hi Shuah,
>>
>> I did not review nor ack this patch. I need to review it carefully
>> to make sure it does not break anything else moving forward.
>>
>> Please wait before merging.
> 
> I am preparing an alternative fix which keeps the selftests
> code in sync with librseq.
> 

Sorry for the mixup. I will go drop this now.

thanks,
-- Shuah

