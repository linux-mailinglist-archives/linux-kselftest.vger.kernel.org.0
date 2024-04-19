Return-Path: <linux-kselftest+bounces-8455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB98AB28F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43331C23717
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E3130AF4;
	Fri, 19 Apr 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOR1vmlF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB77130A6B;
	Fri, 19 Apr 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542152; cv=none; b=cWtkjMLENv22YUeYJpKkcQe9chge+j8dgSxcRHHKUmtiYs9gHDNYx2eq/pTBbz+VAaCoHRo53PJBUyO0zcJwOcC8ymMbIl8VDOQ/g8FAf9teWNBp5sn1zKG8cjjTMG9ebkybB12Y7+0FCoq9Fs/7gWynhScf3RweJ2RDKvosiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542152; c=relaxed/simple;
	bh=A8FN6YL5Az3clcIJCbPbOL1X/kNc80XyKoP/anoignQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cTXa3tYloiByFVk1YU4lAbmXfB7s4pobr+XzcATuCYeG9r7tusymoshHET15TFnoz2CG73/fYZqZ1kn+pFAzRi2fWjf4JUSNlC8EV/tdxwQdHDftdT5fiu5s/kMpfPoIK3duBt/as69D4ixuy7cLZhcf6zszF6izG8p/e7WETvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOR1vmlF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso245996666b.3;
        Fri, 19 Apr 2024 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713542149; x=1714146949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ily9XXgSD/kSnjxbuyMtZIWiGo4h6I0dlgEt1ZQhU4=;
        b=TOR1vmlF2VaEmVFTr/tFxi3TNhpt39pyBjqSDL2zVXZt6vxEdooAeq1xQpR7lzP87x
         VXMc2ZMflXY+laSz1BUqpxQdavXckKM3OUbUf7F29LjMn/e1wPWPqRMvWe3htMgwB06D
         Ul8ChtcKvCGndVVdwTzL3FoqenyqdWVfBGk4iCb7iY92gwTwVzZE1evl7h36RyL7jhmF
         1N+lzEsOF1iYul+DnWpwjIjvCbfVqKwqLE1FV5IkFRuGeXerkrCvjyrWNcGTQcc2cLCL
         25i6HEOF8W+j9+3/IgZsDcNNfJucYIqsKe40z+YqwqGdb3OqFFXcR5Z1J0cYTosafLtH
         c4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542149; x=1714146949;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ily9XXgSD/kSnjxbuyMtZIWiGo4h6I0dlgEt1ZQhU4=;
        b=qirElfHIKH97KhomfUhR4vKaouAbvD186CGHAknrIXER9P+XyPPcOjq9rcMMUp6aVi
         BjIYktIb5OHZwFcHMDvb98tdhNWILabjCTSDngpsH/Q2MX/eTgxqfo0qmVPDqVCLvjBm
         0sANfVgVLWjFyuzqjsRr2oekx72yZtqJOwRJAzAkBwqMoeqSzMNpVJxFtPHi1pMdSmXj
         DXJxdzB/H7KRV0UjZpB4P+2DBCCv+tbFxFWv03+o8XC99dKcYob33m+2f4c0U7xryZgm
         ccSbsOu35zPtthXmlL7T2fE2ZUznOzr/tjmuXFcbGfnxz0mtF1pTQZ8pGJuPuML4xkNr
         WKIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKrJI/xJ+sVyvO3hz5DCcMdT+QQwwu26DwSS69KG5Ewu43dPX380DIbl+tFQiAY4AMzj8Qq/PoPpMIbY62MU+21AQwOnssWR0NolfWDfxF9MZGvG0tw2nNlf6BlNrjnnvp2EdnAjR5ZydrsUpLjeFABA4gQ/TeNt9eT8nCCcYyD/Huq7GjobV1U8h67at0GQFlfvvhAPvTvC0eQIxx
X-Gm-Message-State: AOJu0YzkRhLHXs8XRPPuqkYwH2ec0KY8B3A8NegH0kxF3Kbl24zGthcx
	NCH+k5Fy6ywSrroL+Y24i3NgtDbH/Fyk9cErZMKUdKZGbtSg+/JI
X-Google-Smtp-Source: AGHT+IFiBXFjHgdLNLqc/6MyFlXlHcUOp51E0aYDDjyISWqtYIAbODukC+t3gRLsiB//YhgYnwkUVw==
X-Received: by 2002:a17:906:eb41:b0:a55:6b76:eedc with SMTP id mc1-20020a170906eb4100b00a556b76eedcmr1680531ejb.14.1713542149390;
        Fri, 19 Apr 2024 08:55:49 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00a526aa9e75asm2378399ejc.77.2024.04.19.08.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:55:48 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <15a9176e-9221-44b9-b8df-910c0c16ddc2@xen.org>
Date: Fri, 19 Apr 2024 16:55:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 08/10] KVM: x86: Remove periodic global clock updates
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
 <20240418193528.41780-9-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This effectively reverts commit 332967a3eac0 ("x86: kvm: introduce
> periodic global clock updates"). The periodic update was introduced to
> propagate NTP corrections to the guest KVM clock, when the KVM clock was
> based on CLOCK_MONOTONIC.
> 
> However, commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
> monotonic raw clock") switched to using CLOCK_MONOTONIC_RAW as the basis
> for the KVM clock, avoiding the NTP frequency skew altogether.
> 
> So the periodic update serves no purpose. Remove it.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/x86.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


