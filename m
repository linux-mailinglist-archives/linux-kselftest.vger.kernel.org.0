Return-Path: <linux-kselftest+bounces-13610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3692ECEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD71B2258F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2916D334;
	Thu, 11 Jul 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JN6xzLMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9416D326
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715970; cv=none; b=ZvIOoG88z9gvuktaXxynJtZFzqjmhHSKh6iTNbaV0CB/tTFRd+VIk5bEFBpZ8c7rfHecFAUSlIHtHMVFUwcyS3NzeyzEI0qVLDOcp9RrdQzCxoMYIs0u7G6WtdMHO0IkmKmZO336y2spedQpjrO7sFcRUbn0I+vbqAyfRBF14D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715970; c=relaxed/simple;
	bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4MpJQnBLW0pdzWl4wgpjDMs1mBkPnmqedCofM7vVBiP2JAZ70vtwQoeze76Xuo8jg/M7gGZqRVaHRtCQReZkcq3dL9jY++zGY9pramso1ZauXi7TzaEVWOYesXgAdw4ThqHPsO1ufKDmyB/Un1LFjVJCUg9tqPOa5P5+3hei3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JN6xzLMr; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so562325ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720715968; x=1721320768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
        b=JN6xzLMr2kFJcWlYbA9ZkaNrC0UcVxqb4XEQ6SoznaHJeC2JV4d+zc0B0mz636aHRE
         1ulycWNjN8CE/lANcKq4Iue+qKay8HzAEn7bD0LYKYb9IzoGOJR3EI9rkuOz0o3Z6x9R
         qt4a2xaCNZzhQvn5JY8BxBCNJs1KfneCSCj1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715968; x=1721320768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
        b=PlTqpIVzOkNvF9HYg5jHZA9RORMJ8PYI0a31bTdcEoE3+vHxrclnLESgO7vFdGwIm8
         rAeoGQ8zD2xJWShWjv3DJdn7JVZF42Xh7+vdfRQEoGE+QK05ztQ2MRAk4A4b5DBItjqM
         FIkW6EuEQfu94ArM/uAj+TE/iRdx3+OMYQIISflIScdkf/wdz+KZ9VdSo360osk8F8xJ
         vk8CUkgRU2q5DsaI6x1gauIgXz6zOP2gbzspAecIq4vwzdH+16p4qaVHy4ThGuVVIaZr
         1qIpr59gkY9HOR9bWnrUvLo+NJhJz5s1D6pV8Bg00QT75pb4HsWh2Y/FhwU+U7Hp84B/
         N80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAVu3AhVMGnGcqJOOsHJc98F3tEE0HMUMVOamNFNXyjJwqdlZ0jN9kEgFds4ak0UTpITqO0om3owlZmc3WbVn2ggMKuuPvySk6kBymEF5b
X-Gm-Message-State: AOJu0YypJ65iHL5I53uw7XlMmgwjL+POkzWx2T8gC0+15R13JaXp3swr
	tUwojZ3T3hwczrXRVld6/7u7ZNR5R9RprGfBmYnYNESj2ALDcq++Kw4p4cCFOI4=
X-Google-Smtp-Source: AGHT+IEcVXOWjzyyxDKz9J9qAwm6coQfMOzLMPdETUPQ+DFRggTMe1LEOGI457+OLkIquTJysLumyQ==
X-Received: by 2002:a92:640e:0:b0:383:17f9:6223 with SMTP id e9e14a558f8ab-38d1946e3b9mr29768555ab.2.1720715967995;
        Thu, 11 Jul 2024 09:39:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4a00665dsm15392495ab.52.2024.07.11.09.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:39:27 -0700 (PDT)
Message-ID: <390d33da-1676-4b01-a7d5-8b5c2cc6a3a9@linuxfoundation.org>
Date: Thu, 11 Jul 2024 10:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
 <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
 <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
 <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 00:52, Muhammad Usama Anjum wrote:
> On 7/10/24 9:16 PM, Shuah Khan wrote:
>> On 7/10/24 03:37, Muhammad Usama Anjum wrote:
>>> This patch brings just readability implements by using kselftests wrappers
>>> instead of manual pass/fail test cases counting. It has been on mailing
>>> list from several months now. Please can someone ack or nack?
>>>
>>
>> Okay. I think I responded to your other patches that are adding TAP
>> to individual tests when kselftest wrapped does it for you based on
>> return values.
> The current test doesn't return any exit value (hence implicitly always 0
> is returned). The return value in addition to some other changes is getting
> fixed in this patch.

Yes. Fixing the return the problems. Please send patches to do that
and I will take them.

thanks,
-- Shuah


