Return-Path: <linux-kselftest+bounces-19884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29589A158C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1D61C219B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B01D2793;
	Wed, 16 Oct 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1M6R6mT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAB18732A;
	Wed, 16 Oct 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116312; cv=none; b=NrklBIwcJu+yXqSd4N09Lw6NvGrOYmRDB5BHpWr3cVacqGCnk04UWMKBaPCKzgDXbEpGllM98Kwvt6sRy2+snzs324TOY9rXdWNBU100sbWbxp5+vmO2XUg8PKgB8rdO59WEVvSz6t0xYD/seshHTZOgIs7wBotW2vZtZnW3sCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116312; c=relaxed/simple;
	bh=m+ov/kVs568rdAOKI4g86lXMj+F8r3CaFxVqeHbibgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adoNUbSZvs46UJTZJAHdtdN++W6fqG4sjGfVAmasQ4t3/q5b3UhfRcvPYx8YghO2g21IZtWwl3FVwJxbx/PSnuSTdk/7qdwiYUhEPki+3sNOZQ9+cERP4Q2Ru4TIdc8VRpj8IpXnNAq/aenTIjibrdcixmjOk0XhqQ7kcgvYLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1M6R6mT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430558cddbeso1752575e9.1;
        Wed, 16 Oct 2024 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729116309; x=1729721109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eib+0uxxctBnJ3GemeBl+zs6xNFdQY858TCAdBOxxas=;
        b=Y1M6R6mTglD51wayjA3cjZkCwxWW9vbk1JVRbFKC7OAnwHbabSxDrgOTBGnKbl1kHc
         NFbZvc9eteKcaL9dn7NKOj+f0/piRjcqasjwE50Q4Vfe+6fR4Nu8so6witJ9CApBxn+O
         rLIpi06aX1v46ooO4BvGD+s2vVoBrViGeUx3EQa8TWln01ilYncfHh3aKiJx8uLtnG5g
         /81v4fN0uZT+xQ4C1OTzQO/Nj7X07ItpkqxR631zky1cGhapkIu4ZbfLSnOjGRLY8kOq
         40O+uKgTjPCZ8vrebllX4MzKSEGPmShR3ZEyyMZKfygz97w3hFT0HDBmsmIg3XomNAAH
         6b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116309; x=1729721109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eib+0uxxctBnJ3GemeBl+zs6xNFdQY858TCAdBOxxas=;
        b=i6o3CkcUcB02Lf7ZFmrTfbOpLWVXlZtY3Iiyvp2J88W+HnSv1WxrbuviXE6/Kk7y6X
         8ucRhCpWLGiI56R9Vlqh302wyhfd1m6JuZ60jOaC2Y/P3Eulx8rNW1iFLZ4LzB58QxOv
         Z9QKOrvjnkEH5CujtFbpFEGNJKivloKJw/aMxzNh8pXzW9XNx30+PN50PWgZHGgliiWl
         1nanTRzSPg5yeigaksd34U+0Nc1aHfuopRNqY0y9ldu2c44khLioDAWYi/Y8wZSC1hwZ
         +aImncIXq5R9vEFe+XTVwI664N7kPRcU6zKfiZFOBVfksVMd9dl8XDI5Uh/4JaSZAu5Q
         BeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqstj06XUnKykWDwzwh2lEUi+XR4mF3q94vEawmX9tjPwEWfVEhLXCcnbRYt0mrMVfvuPohJSEQPZXzI5@vger.kernel.org, AJvYcCUpoqiMsxIA08wGB0xMDnQJ77nih4KFw0MMMfEere9jjSLC/Mf7VenQ3+HFSSDpJljvBySh9LwFZSvPEnY63GD+@vger.kernel.org, AJvYcCXlBU2CD4ARM18HdpoeQaMZlOq3dK/T13/9ZYL5ahrLQLsbqvC4DrPtdvpUef65Y2o4r/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyzq9YH/Uy+wMy0kyMwJC13cjmP5dJENvZ1de2EFd6qi2lgaFN
	55HO8MHiOW0rCmmDjQrv9A77mohDltK89F4Mbq3VZjToYd9xnMHv
X-Google-Smtp-Source: AGHT+IFHS7yUP+gqPUlAOVcvDGP/scaJVzDVX481vwVPL2msLYF5ZPDnJxUh9Be2IAi4QJPe7zUGvA==
X-Received: by 2002:a05:600c:474a:b0:431:4e33:98b6 with SMTP id 5b1f17b1804b1-431587174b4mr6592285e9.5.1729116308883;
        Wed, 16 Oct 2024 15:05:08 -0700 (PDT)
Received: from ?IPV6:2a02:8012:e013:0:f52b:f2f2:1fbe:f0ae? ([2a02:8012:e013:0:f52b:f2f2:1fbe:f0ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c3bcdasm6021755e9.17.2024.10.16.15.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 15:05:07 -0700 (PDT)
Message-ID: <cea2040f-7214-41cb-9e9c-98895bf5a1ec@gmail.com>
Date: Wed, 16 Oct 2024 23:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error
 generation
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com,
 nh-open-source@amazon.com, pdurrant@amazon.co.uk
References: <20240927161657.68110-1-iorlov@amazon.com>
 <20240927161657.68110-2-iorlov@amazon.com> <Zwmyzg5WiKKvySS1@google.com>
 <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
 <ZxAqscbrROD1_szG@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <ZxAqscbrROD1_szG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 22:05, Sean Christopherson wrote:
> On Tue, Oct 15, 2024, Ivan Orlov wrote:
>>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>>> index c67e448c6ebd..afd785e7f3a3 100644
>>>> --- a/arch/x86/kvm/vmx/vmx.c
>>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>>> @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>>>>   	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>>>>   	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
>>>>   	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
>>>> -		int ndata = 3;
>>>> +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
>>>> +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
>>>
>>> There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.
>>
>> Ah alright, then we definitely don't need an is_mmio field. I assume we
>> can't do MMIO at GPA=0, right?
> 
> Wrong :-)
> 

Then getting rid of `is_mmio` will make distinguishing between vectoring 
error due to MMIO with GPA=0 and non-mmio vectoring error quite hard for 
the error reporti

Passing INVALID_GPA into the userspace due to non-mmio vectoring error 
will change the existing internal.data order, but I can do it if it's 
fine. Sorry for nitpicking :)

>  From an architectural perspective, GPA=0 is not special in any way.  E.g. prior
> to L1TF, Linux would happily use the page with PFN=0.
> 

Cool, didn't know about this vulnerability... Thanks for the explanation!

-- 
Kind regards,
Ivan Orlov

