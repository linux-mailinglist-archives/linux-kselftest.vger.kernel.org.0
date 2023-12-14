Return-Path: <linux-kselftest+bounces-1921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D381325C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF67282F6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1FA58126;
	Thu, 14 Dec 2023 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dER//z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B4CF;
	Thu, 14 Dec 2023 06:00:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3364514fe31so717578f8f.1;
        Thu, 14 Dec 2023 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562435; x=1703167235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T31GFbwQeg9qNrLsS86G19Cxx4kW+D3BMQGOJA0RzmU=;
        b=L0dER//zz05CdnAqwhhKAE0T+YlLr1rYgvb0p/V8RjEdrw45Nh4MpgnZCP5l5bm7EO
         DtBGTLZ8u548R1SYP0muiSgCpJqzJHBc2R9HozyKYA8tgFzn6U+Byvb3dQc87LxsAgMR
         BqfSv74djYXo2ijzhPoiMjjLLSCorsm/dGGjd7KgpfehcVDSiA88uW9Siv5Oaky3nien
         4TRNCMKxj882MiYwLslUXOJJRlaDWKrVw71qUMLJzK3FR/2xwBI8a98nkgdkG/NdvqBH
         ywRO2J7Cdi877zrikgt+mJE/4teOvmN27F8n5yAjJbO24rDlgc7xI4TrsRyCf6KNz/oK
         o40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562435; x=1703167235;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T31GFbwQeg9qNrLsS86G19Cxx4kW+D3BMQGOJA0RzmU=;
        b=gGJqZks/k5VPxssOyUVADxfyP8qW9+4LvZGx5Zxsi/WQTlCsiqyMFcyiB5vihukSKV
         9mnFdrCWcYX9ewIYg3gM5Eny+CftxGNc1v1201T2ZC08G9nLOTHAwadaBoXCIfQYtvd2
         dR/4FPpg8k7L9rQ8VIKxRIVf+UBN1SBcviccXuyAr2G8W9oStRjg+zAnhU93QnOMTS+D
         xjPHGxXCqgvRxnnKXfuI4VmmkLSZJgSJseBIOv5iWHVzmdtTQNno4rRCIUvqm9iAsUM6
         s8bLBfEqEafE/ILwKVCoACUsCw3IbQo/d9FvR2qSUHrFAq64/rkuzX3VZLK8AVUivLyb
         Vhkw==
X-Gm-Message-State: AOJu0YyALZ8Ps4uVqQGIOFSO3xDMNSifAjjhlqcqxrCHaOwtpTitGWaX
	U8xwNLz+MR4MoVGRpbTNeDMktqoYp7rIbQ==
X-Google-Smtp-Source: AGHT+IGleDMcL5nFQzLGCW5amV1QnI1++eH9qy1wIZXg1bqfxr72T6dlCqUURbvk9SknNvSCOv3nUQ==
X-Received: by 2002:adf:e285:0:b0:333:2e11:377d with SMTP id v5-20020adfe285000000b003332e11377dmr4811580wri.40.1702562434701;
        Thu, 14 Dec 2023 06:00:34 -0800 (PST)
Received: from [192.168.3.251] (54-240-197-238.amazon.com. [54.240.197.238])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b00333381c6e12sm16139858wrt.40.2023.12.14.06.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:00:34 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fad44fb9-f57a-46e8-99f8-1c3d8e830cbe@xen.org>
Date: Thu, 14 Dec 2023 14:00:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v10 09/19] KVM: xen: separate initialization of
 shared_info cache and content
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20231204144334.910-1-paul@xen.org>
 <20231204144334.910-10-paul@xen.org>
 <1556d890fac61e36b9546c5f520faa15e449bd55.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <1556d890fac61e36b9546c5f520faa15e449bd55.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/12/2023 13:41, David Woodhouse wrote:
> On Mon, 2023-12-04 at 14:43 +0000, Paul Durrant wrote:
>> From: Paul Durrant <pdurrant@amazon.com>
>>
>> A subsequent patch will allow shared_info to be initialized using either a
>> GPA or a user-space (i.e. VMM) HVA. To make that patch cleaner, separate
>> the initialization of the shared_info content from the activation of the
>> pfncache.
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> 
> Spot the difference...
>   
>> -               /*
>> -                * This code mirrors kvm_write_wall_clock() except that it writes
>> -                * directly through the pfn cache and doesn't mark the page dirty.
>> -                */
>> -               wall_nsec = kvm_get_wall_clock_epoch(kvm);
> 
> 
>> +       /*
>> +        * This code mirrors kvm_write_wall_clock() except that it writes
>> +        * directly through the pfn cache and doesn't mark the page dirty.
>> +        */
>> +       wall_nsec = ktime_get_real_ns() - get_kvmclock_ns(kvm);
> 
> (Hint: it's commit 5d6d6a7d7e66a)

Ack.

> 
> With that fixed,
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 

Thanks.


