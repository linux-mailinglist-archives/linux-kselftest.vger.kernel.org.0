Return-Path: <linux-kselftest+bounces-23534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED419F6FCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 23:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F08616C3E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 22:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2611FCF53;
	Wed, 18 Dec 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGlYRTaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701051FC7F8;
	Wed, 18 Dec 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559224; cv=none; b=REz732URJm86LWoKP3DovbrlibrciaBIficz3iG5Fsn2YVVKDc6AQtjRqfYOjgxhaqR8Fc0rtRmF4WfOm7Y+TVizckgf2s5vKFcdlOAbyx+qsh/XhA822QkDf/ZN5xcvV3kpeUjcfoqOjNKPSSx5ffX+VXyljE9/flFDaP+7GDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559224; c=relaxed/simple;
	bh=xKESxwgtfIw585P+aR6GOoDoH34+K24k8Ll8figZlr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR7H7qa6USeGnljuXQ8jD7SheaM5lBYWzHGywC0qZ6BOi+lTDVG9DIli6doaummPotR5JH2/dqaqAZpCZqfu+Gcu3qOfsHnHz9SiceVoI/kQ6vlhr3TAX0FwsTiHjZMF2erZ3riKAvNC9t68eZjh6ZOT4Po0GhHe3OtKrGE0oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGlYRTaW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283d48so941885e9.1;
        Wed, 18 Dec 2024 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734559221; x=1735164021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEDJdqFiLZsiDutJbeKnD8xOHhaGVRHbF49Nvl7TLk0=;
        b=FGlYRTaWt6KWxvdShcqrlDOB3cyUnzDQ60zK9T+ikXFa///mU/37v83Ek7eYP6SDkz
         PX6WATlfwsceEVyk4b6lAUyujdV7oIC1m13UQB7pnd1Dwl9KB0/fbBjmuZX8tT1QYnpc
         Bhhq2F/rGka09XoVO0bLXfKV91ru4ZiewIovQD6bquBCl4Zlgl7Yg+Q+JBP8lr6qvRKZ
         +hQaPnBfKZ5E6PN0jxk96elIyeqkDxX7P2FTj/OrvjsAl+ujlKe1PZk89KBcrjHZWi77
         Ic4QIPgOnXpG+SrBCzqfsaomGEpkspqxilzSHO7vQoS/5tvy07EpnyRF9BJMjRt5zD8M
         ecPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734559221; x=1735164021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEDJdqFiLZsiDutJbeKnD8xOHhaGVRHbF49Nvl7TLk0=;
        b=BKMY+w62yU3jU8oHZzxyoXSMs/obunNB7Xp/PEt5nAT4tqwEWREmZO1iHtYe4kxBt9
         TNRU2GG5dDA1qkbO8Nqx4tUkJEIIa5ZRPTKiZJI4IMcxhOtE9CSpFdGvwhD4MeaFe4O1
         5u+jcKjLa/IVhHwDmpBfbD3sMJkIjQUHo56pF24Sjnj3ssOFFPdPArAhduLOHaU95OHs
         1vLdkdXX8awU0pzk0uVTuWMvM5cg0SuLmGL4NZbiKo/1U9ldRgcNixbVsiU3yxR2lJ9s
         rfBymcW4IiJZcS6iLr0Ah+6ifg/m4X1F5K26Hzco/6+o7G0IlnHDwhTAaiaxjMMkDHcM
         ubpA==
X-Forwarded-Encrypted: i=1; AJvYcCWK9c/Ly7nMD2VlXvx0BWXzURvnyZJZM1u5ARuULczAYMZwDF+4qSRtudDlIUzTFQ2qKqaNB6FSzV4+/bo/@vger.kernel.org, AJvYcCWaoljfhBClrZXhMNvANIlvQl5+MXHtTNfpE6qFtewfjyISmoRYwi2N4MQgKejGzDlZhiRZQBULwMwUGgFzU/ks@vger.kernel.org, AJvYcCXcjuAnjtw+ACI7qUMTdCDU9rPRsfmuXkxA8XarjBe/SHBZT7Bl5uNJxg8N+r1A3gDkN8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9xedqGCxrwV2fTGojYvs1DlUfcfX97f2it8laUAA+bBFVFG/
	xTQb4OJR4lsCPwhK9MzttBxYo3Ql9zg1cXORe27S+vn/O+VlFQ6j
X-Gm-Gg: ASbGncuuGGn+IlJN+RMS5q+4Nqk2ocI0o7jqj60957PmFfVxSFso/U2sLSES0xadfLT
	5q6+BWjVCtG8c5t+fczpuHbPUqh32dxw8GNcpKePzbeutVi+YMnKz0XcTeWz23cRxb+D9WsSdEm
	5GEEJL483SHHMG/HephPQs0ZonsoNQON5JNI9ASI7+zksAxR3Qtx6dKJvf9UESgtTD1P9d/UjCb
	g48kS2KbQ7a96vCxQkGyMnDVl/kAccU1Uwt8dpFA32kmMez0P5cqklqngRkXZ6N1eYdL/21TF85
	iuuPT0gzpTvkpAjGWgQD9N+jY7a5
X-Google-Smtp-Source: AGHT+IF9wk04esHUXSZqWJ2E1YZNGNyDe4HzBjGkI4DRDO2j4Q2UhdQUzfThPeXXkCNt9RD0PSHLLg==
X-Received: by 2002:a05:600c:4f15:b0:436:30e4:4590 with SMTP id 5b1f17b1804b1-4365540cd9emr37830685e9.32.1734559220371;
        Wed, 18 Dec 2024 14:00:20 -0800 (PST)
Received: from ?IPV6:2a02:8012:e013:0:3fe7:9506:a78f:9d50? ([2a02:8012:e013:0:3fe7:9506:a78f:9d50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1243asm31843505e9.22.2024.12.18.14.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:00:19 -0800 (PST)
Message-ID: <4f3fbcfe-a44c-4cb3-ae99-1a03f8bc2b83@gmail.com>
Date: Wed, 18 Dec 2024 22:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] KVM: VMX: Handle vectoring error in
 check_emulate_instruction
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk,
 pdurrant@amazon.co.uk, jalliste@amazon.co.uk
References: <20241217181458.68690-1-iorlov@amazon.com>
 <20241217181458.68690-5-iorlov@amazon.com> <Z2MWzyoq8c2FfJnM@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Z2MWzyoq8c2FfJnM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 18:39, Sean Christopherson wrote:
> I definitely think it's worth explaining that moving the detection covers new
> emulation cases, and also calling out that handle_ept_misconfig() consults
> vmx_check_emulate_instruction(), i.e. that moving the detection shouldn't
> affect KVM's overall handlng of EPT Misconfig.
> 
> --
> 
> Move handling of emulation during event vectoring, which KVM doesn't
> support, into VMX's check_emulate_instruction(), so that KVM detects
> all unsupported emulation, not just cached emulated MMIO (EPT misconfig).
> E.g. on emulated MMIO that isn't cached (EPT Violation) or occurs with
> legacy shadow paging (#PF).
> 
> Rejecting emulation on other sources of emulation also fixes a largely
> theoretical flaw (thanks to the "unprotect and retry" logic), where KVM
> could incorrectly inject a #DF:
> 
>    1. CPU executes an instruction and hits a #GP
>    2. While vectoring the #GP, a shadow #PF occurs
>    3. On the #PF VM-Exit, KVM re-injects #GP
>    4. KVM emulates because of the write-protected page
>    5. KVM "successfully" emulates and also detects the #GP
>    6. KVM synthesizes a #GP, and since #GP has already been injected,
>       incorrectly escalates to a #DF.
> 
> Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
> mean MMIO anymore: it can also be set due to the write protection
> violation.
> 
> Note, handle_ept_misconfig() checks vmx_check_emulate_instruction() before
> attempting emulation of any kind.
> 

Yeah, I thought that covering the change in non-cacheable MMIO / shadow 
paged #PF handling, but forgot to include it into the commit message :( 
Could you please fix the message when applying? The message you 
suggested looks good to me.

Thanks!

-- 
Kind regards,
Ivan Orlov

