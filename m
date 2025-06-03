Return-Path: <linux-kselftest+bounces-34241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F0ACCE16
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03569188E642
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F70221739;
	Tue,  3 Jun 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNoCSJk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB013AD05
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981922; cv=none; b=LGB7MawLNeDd+wi6WDtuJwI06oZEKDBVMYbRRtOY9LFP/0TYaXELANZFtDWqjxoBX2R3D8eHoiBWcq7SKi2zsbOBPi8iHEWWoyKzLbKOA3L7HXkKM8HOQBB2ejs5pP/nKpQIV//59UP5lTnEpThCbRXTcg5IszWw0aQXqEGv7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981922; c=relaxed/simple;
	bh=PhnGju2FaAl/Ou4Mi4eqXEqaDfOHiRecarv05XteqWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbNckFqIbcp8BcHOC7wAVYfHXFaCeNzsB6d1BpIJXFuoLmHQbS9Kd8Nh+GICEl90EB47COKjQ/j4izlsXpiUWvBEzJ1lgThyc/pLhzx9OFMAW4Q5/bXnyWttuBKI9sHa07iF9UdnolAbRhTmH1+FGEimZykMBtKIjXJAemxeQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNoCSJk9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748981919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dmdW4bmka8D9iCjUm0LgPnNY9QDzyr1/KIwj6yPU5Nc=;
	b=QNoCSJk9Y86dSBEszck5M12WcEV0mpy4H1NHEij2SYKBscuVS0HR8V+JmAM6tsPTHMJH9N
	fU5umsflQfPWjwKzzctsr0C3Dh/z6bGiBmn81Lkk1EER99cplkzfpaArsY5q0/GvKXfqqZ
	YK/2P7Dstnht2ypj0WPo6UnnS2m3Kyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-HEFC4xudPnmfbFlCM4j8Vw-1; Tue, 03 Jun 2025 16:18:36 -0400
X-MC-Unique: HEFC4xudPnmfbFlCM4j8Vw-1
X-Mimecast-MFC-AGG-ID: HEFC4xudPnmfbFlCM4j8Vw_1748981915
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450cb8ff0c6so29205635e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748981915; x=1749586715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmdW4bmka8D9iCjUm0LgPnNY9QDzyr1/KIwj6yPU5Nc=;
        b=egLruGsM2MZYQahT9FqGEQxUu2BZrumYQtZa4+JLwTu8pTgBv2fTgtljrEq0JG215a
         W1IbP99iHv/Zo9FaUactbcwWUaWuTblzmdStNEtuqtzN768a7VsgwrblVwNHvGqpvrvz
         vxvPcSDMtghzJnDozKtNtV4aKccgvvqQprgA1mznwBWdY98kHjWZhRaS/V4z9e7tyzaX
         l9swwFpUFrTk518yj5Ym7kF2HcLtq83bfzoecmKcf4bR29WX/tv0+SdUULkegGMSnrnN
         P+hqzwyub+PMZnF1mFXaaIluPH14odx5+/sNGq2+BnhAZ39AfJLZ96uBBhnM1kO3OWya
         31bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjNuHUWfx69FuxRrsnnm6gILMI7UD/rkAF9+znEl27wkNeuksZfltivbh+tOoACvrEcvUKEwexJ6S0OV41Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeblOQ/UCuaQO/P2/M9U4k99wsrKy0wR1OQCFXNPxZ8UJAaxdF
	rWmd8f4juPOZbphy7hdIFghoDAJCWSAfUENTh80z0YlO7pwQj2m3zulVoIG90++YfzL4Ghlbj5n
	GFETZigZuIVU4MUXGY4BkS9V28xssMKfjYHKiPlJpexJcU5vlCoebIoF2Ag3nj/EpNgZFbQ==
X-Gm-Gg: ASbGncvX6PcH9UB3Uczq/n0niq3Zi1NY/V3r4oSujXEPs59WBi6ETrI6HD2+ve0NHuQ
	q3uXL8X5BBazjbWQ2+S8gs1u+DS+t5psaEVYbhiL9v+fIfHaNc99RhBSjqLE0jHdDeka1yFknNF
	3qhDo8CRldDVRqPF60abmPFYy6xmnmqlHoCLBp5MbZqdd276vQD+7YSs24L/bG+ntSLX/o5O3Wy
	1IVb4M0pPIQoddh5WT+JncOnC7V6bA10yBLhODIBWC1aG5zd7gGwPQWEiFELH2JF5UYCzgyOrRW
	0tJOiO6LTH41r/t8QmSkYPWEnv9Wo+6Xv53lRHidOvHTx6LGhJMTlOxXnuzr3frZdkWLGjs8WAV
	QCyIYc7+l4183bohfXQ5C4gztx+RagF3f7FKz4U8=
X-Received: by 2002:a05:600c:818e:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-451f0a772b1mr800225e9.13.1748981915238;
        Tue, 03 Jun 2025 13:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFoZbzZ9OiBB+hfEam1+vq0MIwdg8ikG1TlX+hLCXBEfbkk5dPOMwLME6VFx/Iyp28v7K66w==
X-Received: by 2002:a05:600c:818e:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-451f0a772b1mr800135e9.13.1748981914874;
        Tue, 03 Jun 2025 13:18:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb09a3sm171214265e9.24.2025.06.03.13.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 13:18:33 -0700 (PDT)
Message-ID: <d7c61e25-f09e-4260-8228-d28f0289795a@redhat.com>
Date: Tue, 3 Jun 2025 22:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] selftests/mm: Add helper for logging test start
 and results
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-2-ff198df8e38e@kernel.org>
 <63e00cf8-8592-4117-bb27-42bc8c1f8921@redhat.com>
 <5e00c276-2d3b-4004-9f98-4703e2d642f9@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5e00c276-2d3b-4004-9f98-4703e2d642f9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 20:27, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 02:37:41PM +0200, David Hildenbrand wrote:
>> On 27.05.25 18:04, Mark Brown wrote:
> 
>>> +static char test_name[1024];
>>> +
>>> +static inline void log_test_start(const char *name, ...)
>>> +{
>>> +	va_list args;
>>> +	va_start(args, name);
>>> +
>>> +	vsnprintf(test_name, sizeof(test_name), name, args);
>>> +	ksft_print_msg("[RUN] %s\n", test_name);
> 
>> We could allocate the array in log_test_start() and free it in
>> log_test_result(). Then, we could assert more easily that we always have a
>> log_test_result() follow exactly one log_test_start() etc.
> 
> We could, however we don't have vasprintf() in nolibc and people have
> been doing work towards making nolibc more generally useful as a libc
> for the selftests (and/or the selftest interfaces more friendly to
> nolibc).  I don't really know what the end goal with that is but given
> the fairly small gain and the hope that this won't be a long term
> framework for anything I'd rather not add something that gets in the way
> of whatever's going on there.
> 
> Ideally the test programs would be refactored and these helpers deleted,
> but as we said previously that's a bigger job that neither of us is
> likely to get to in the short term :(

Jup ...

-- 
Cheers,

David / dhildenb


