Return-Path: <linux-kselftest+bounces-8440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BB8AB1D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2511C214E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF11304A7;
	Fri, 19 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3ZADtVJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD513049E;
	Fri, 19 Apr 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540597; cv=none; b=uyHx9EBHxCFm1LJIE8Sx/sO1nSwELt373qBTP8oAmCTGdlKtn/gSN0KzS1wGofr/7YxTHH0qAMl2dsDKc1duL3kAkZYd1aJWnt/8+smLqB1qJhzNEmf2mCkt95F+lYnoQSXFQRsqG51/LZbBp1rCXHckA22+TMpIl4ighcux1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540597; c=relaxed/simple;
	bh=zT9iJ5PbjhLLEYo+jfeZgwNnELE4T6yi5z/mQLNwves=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MZZFy1dgqfrDObbXb1TYn53RueBRD9zo+2RRcpca0p8vcqI71Ha3IiRpY3g90ql9CypAKHEoN2heMzPK9MGvzlFGpivY/cRQnPDD3TIuHGnVQN1A0qiCHFuTDOg9N45ZHmB+7RWdz21JWgc+6ugqXGK/b2m8wpFYDXjs15iRK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3ZADtVJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-419d320b8a5so847545e9.3;
        Fri, 19 Apr 2024 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540594; x=1714145394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vA4Wyq7G4LwKrA+RVKqAzEJ7JuH0WyGpbgryKUE75M4=;
        b=E3ZADtVJSkQgTE9zq2y4iK4MJ0XdMqXjOZxY9OCKl0a/E51Fx8Q7du181vX2DXeK/q
         v3yWXFS702DZaOcPlwVZwWy0JoN5+Itet9xHheGLP3YwoyPTARLlnbeAAvz8CJ1XbKB0
         q1HZPMjGxiRzUXlVPifAXTvk5IOn4e96HmK79J9yhwCfuAUpf0t/jrhujqzf/Qr1/KXM
         e/F3QJ0YtIDAkLsgmNjwZtJ48AKdjbDe9DXUaEzrOujZ/sp84X2DTMB4hFDHeP1dA5/k
         3zQDa+TJ0CoW7rEm5FT34BaX5d65NvD8JHof60dmbbebSrtIOsqU0KV8VaZPJgFbuFkA
         +ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540594; x=1714145394;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA4Wyq7G4LwKrA+RVKqAzEJ7JuH0WyGpbgryKUE75M4=;
        b=TkG1/m2sJFptos/6IH40HIiy2Vb+F80wteVCNHtkBKJ13V5qMo+VuGX7gAGm4ACDmp
         cbCZy9jEQAIkhEiZHk2UC1kjbYCjwCYw4GVD6zVw5EIW23d8fZ3+rFNyh/PFF6ewaT7Z
         TT4OGkzgZAcinXyaIq48YKf8X7bs7p25hVpk3de+xAzFEygadpOKuPcOJVmS0zjKH8KR
         YZAblUtYBTnB1K4QT6qbYdCcxn7BwbG/IEg98a79OLi/RvKsn71H+JowWY4vqiBjzdTD
         ot9/kmC5BOeJ5hOeyx8mDZ7rEyMQnKrObQr2z1IpDuloNHVpxI9MvPz6wPSJqZn2aZKE
         QH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWicUMcKUyaAWa0SlRD/QzT41V19jBxnE9vUkIQZg4tdwLdcZsDnZlWIDbYVZfTe2wSSWotor9IdBnNeSO0C4ftzZnxT3uwW6q/XlFczeS3rpB+pqXDJ4u1elxSh+4lsKIrlCuiTBH8O9RxP1dF2ykITMFqzETGXKXfjfpEVBg7ROFP+kgE7cuYyC4EjKvwIi+BIAPoLDNr1PrWom1C
X-Gm-Message-State: AOJu0Yw/5/tVFfxvuybRMTD2iOGienpLC3poHngkJ0lUd0+Mr4eWx8L6
	P3MSRkI36wxmSvEaJ1Y1R5JSYswkJ3+LBx1RO6l91U8wIsopXmGX
X-Google-Smtp-Source: AGHT+IFunWtJWZrTq7c04EP2u1pyUQraDQihoidKL/m4rvFGMZmmkHrnyWKWLLqIPM03fOBYa5hgKQ==
X-Received: by 2002:a05:600c:1547:b0:418:e08c:817 with SMTP id f7-20020a05600c154700b00418e08c0817mr1695973wmg.32.1713540594088;
        Fri, 19 Apr 2024 08:29:54 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm6936153wmo.4.2024.04.19.08.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:29:53 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <cb0a026d-aaf9-4503-a07a-a3c433a25c0e@xen.org>
Date: Fri, 19 Apr 2024 16:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 02/10] KVM: x86: Improve accuracy of KVM clock when TSC
 scaling is in force
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
References: <20240418193528.41780-1-dwmw2@infradead.org>
 <20240418193528.41780-3-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kvm_guest_time_update() function scales the host TSC frequency to
> the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
> scaling ratio previously calculated for that vCPU. Then calcuates the
> scaling factors for the KVM clock itself based on that guest TSC
> frequency.
> 
> However, it uses kHz as the unit when scaling, and then multiplies by
> 1000 only at the end.
> 
> With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
> result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
> the KVM clock advertised to the guest is based on a frequency of
> 2,499,999,000 Hz.
> 
> By using Hz as the unit from the beginning, the KVM clock would be based
> on a more accurate frequency of 2,499,999,999 Hz in this example.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
> ---
>   arch/x86/include/asm/kvm_host.h |  2 +-
>   arch/x86/kvm/x86.c              | 17 +++++++++--------
>   arch/x86/kvm/xen.c              |  2 +-
>   3 files changed, 11 insertions(+), 10 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


