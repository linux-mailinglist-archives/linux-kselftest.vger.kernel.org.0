Return-Path: <linux-kselftest+bounces-23225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D59ED951
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D674161D4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8D1E9B16;
	Wed, 11 Dec 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlKLWE0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED591D88D3;
	Wed, 11 Dec 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954747; cv=none; b=ld8LcC+KaGhQQxPG8dvvtCpBG9YDBK61tIOqS5RepUPKCKIm0Q0f0ssPZ4qFg+Af9ChJhZtlYXIsjBzantPOFBE4EGI9FxFqJBGBolm1pIBV3xZ1giQYrDoewbAH5SdjCsEq29INEOBNwAhkNT5VxFY7UEu3NgkkyZz2I+p3UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954747; c=relaxed/simple;
	bh=ZfacqWWvGCBePwSGhsCyH6JBE542nvyx8Wgo736Xgak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbpU4Z0WO/vYMl1zilOsSiQc8nU4FLRzokYVG6NF7ejFscYIKVDkRLOWDbnIodpc6638JvmGP++zB+feS5INLV+XCIp0ZMID3sAK/YOiyiWNSNthnLlZCCVmDHT/WxuSWHSD2wegzt2ONbBC9seHLXKjJrb1H0pYJIgMeFGYtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlKLWE0i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-386329da1d9so2663893f8f.1;
        Wed, 11 Dec 2024 14:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954744; x=1734559544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynvu08ggcInud4tytcajfb8J8UHfrTJ2Sn4njevRCew=;
        b=DlKLWE0isfSG5Ef8N+d9h1VMPyBsl7Z5mNPzj6OTJUfPofY8yUQNJniuvrJH6uoiRA
         3PVgLjr6lJeLb2dfWo6mvA9WyyfNhq/VX79yXGLiS2c7Qdx49fXFzVKv2TfbLvGk1ucw
         YtX5C/Ub9F1GsBH9e0xhOYtMkgQInYMvET64f8v8pOIi39HjLlGE7vlzQvcnIB7lgGCI
         3eo99PSfM8tIO8mXUKQchJK6kyI9eSc+qKUpcmuXloDcBFiIEDjl4yQ44RCbHJflIAfV
         AsJiIutT1UCGsO6lzBXu+ZuLYnmIxdrxuCFTGOrt2ha26X3rbTUL7avuBGesodU/oUSv
         qBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954744; x=1734559544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynvu08ggcInud4tytcajfb8J8UHfrTJ2Sn4njevRCew=;
        b=I9SAy98LlCNbdM2zvqYzG2LjC+TRPZSwE+4hl2qa8T8yRBWLXEYeeAyTpp3pCH6aaT
         dm0w8iZqt0niDkVoR7SxuFhajePTY5JsA0JvMrQdTE7mnFy1n4GLXsudZN75HzCEBI6u
         K1nGO65CSW2rmMZdntSpJbiTvDBcWVktRxo43nPfL7gC1CWgY1WuwORJOlahhcjXHn9z
         lz+JSBvnwPt7cicnzZUmFStWX25izRBA0fATiEsARBw0bMPqw4fzWastKTjfUmD+rVAM
         +8bg9s4f4P0/OV+UaYHHFmBD7TMYpeNBhNtMST2BAVMt1/XncuLPM9nzl4tKZXJVKYyx
         6EHA==
X-Forwarded-Encrypted: i=1; AJvYcCW9GKs82TpSONtp9ir6Nn5FC/Kr7/gMD0OCmvFLEXMap+dek/qxh8HqzDHj4jetpJL2i/HneaWL7QZs5QiL5qcl@vger.kernel.org, AJvYcCWX6Fi5/x/TYihmzsbPigJ8Sqx4TpoeVk2NOSj6LnGx3B+YPRzxwufFkZ8HyXkD+HNAQXI=@vger.kernel.org, AJvYcCXL6aTe1/VvV7VGm5SeZ8gUQvP3UutqT18Bxm6S4fosrIDnK0YPcve/TvxIHTAhs8Bx9C7j3SWGBc2anaZT@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZGZh+oHqPVRegOyTwWBjzJcF9FpJJbW/2xP7ow/vSt67Pgoh
	8H0ZzeQ3rjPs/c78TE/LksXq48kXZN5hLGuhRkTNwsIbiiGoo5Qj
X-Gm-Gg: ASbGncvej/U4yLuHSWv3x2PtbDMnEXtVi3A505uef+UNmo3z5qP9ln2toxbxqMjIYla
	BVuAZN8BtL0qFls+kV510ACdIZJYGnVhrIkbIxG2BVtld1cZzyUXWhntXCI+jG7Qi+TLDCyxM54
	aNbbzO3ozMT/y5SVhdqlBWmWJbG0aJ68IdiF89EKntocOqqSMQaH5qBFDnZEXSVRve6c/Qb8S3G
	Yy93jvM9u1ZjntM9onmV3ZjliD2+qKYJr/lQ1NypWgy4R9rNJDqNdXf5i6La2NixegMjbVu9ciX
	1NEdX4rjhr/yDBoUnLUmlH4=
X-Google-Smtp-Source: AGHT+IGRieHHyC9oKtOlgXtQVuBt2BECe2ItAzjUH1SbeqIzfhSGBuJwjxykN84TYfXtWkFgli7NdA==
X-Received: by 2002:a5d:584b:0:b0:385:df84:8496 with SMTP id ffacd0b85a97d-3864ce4b01fmr3071275f8f.3.1733954743761;
        Wed, 11 Dec 2024 14:05:43 -0800 (PST)
Received: from ?IPV6:2a02:8012:e013:0:1ab3:1f25:931:4d97? ([2a02:8012:e013:0:1ab3:1f25:931:4d97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361d1cd906sm33661115e9.12.2024.12.11.14.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:05:43 -0800 (PST)
Message-ID: <8420f030-c949-4735-8680-e82a57692142@gmail.com>
Date: Wed, 11 Dec 2024 22:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in
 check_emulate_instruction
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk,
 dwmw@amazon.co.uk
References: <20241111102749.82761-1-iorlov@amazon.com>
 <20241111102749.82761-4-iorlov@amazon.com> <Z1nWykQ3e4D5e2C-@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Z1nWykQ3e4D5e2C-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 18:15, Sean Christopherson wrote:
> On Mon, Nov 11, 2024, Ivan Orlov wrote:
>> Move unhandleable vmexit due to MMIO during vectoring error detection
>> into check_emulate_instruction. Implement a function which checks if
>> emul_type indicates MMIO so it can be used for both VMX and SVM.
>>
>> Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
>> mean MMIO anymore: it can also be set due to the write protection
>> violation.
>>
>> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
>> ---
>> V1 -> V2:
>> - Detect the unhandleable vectoring error in vmx_check_emulate_instruction
>> instead of handling it in the common MMU code (which is specific for
>> cached MMIO)
>>
>>   arch/x86/include/asm/kvm_host.h | 10 ++++++++--
>>   arch/x86/kvm/vmx/vmx.c          | 25 ++++++++++++-------------
>>   2 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index eb413079b7c6..3de9702a9135 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -2017,8 +2017,8 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
>>    *			VMware backdoor emulation handles select instructions
>>    *			and reinjects the #GP for all other cases.
>>    *
>> - * EMULTYPE_PF - Set when emulating MMIO by way of an intercepted #PF, in which
>> - *		 case the CR2/GPA value pass on the stack is valid.
>> + * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
>> + *		 the CR2/GPA value pass on the stack is valid.
>>    *
>>    * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
>>    *				 state and inject single-step #DBs after skipping
>> @@ -2053,6 +2053,12 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
>>   #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
>>   #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
>>   
>> +static inline bool kvm_is_emul_type_mmio(int emul_type)
> 
> Hmm, this should probably be "pf_mmio", not just "mmio".  E.g. if KVM is emulating
> large swaths of guest code because unrestricted guest is disabled, then can end up
> emulating an MMIO access for "normal" emulation.
> 
> Hmm, actually, what if we go with this?
> 
>    static inline bool kvm_can_emulate_event_vectoring(int emul_type)
>    {
> 	return !(emul_type & EMULTYPE_PF) ||
> 	       (emul_type & EMULTYPE_WRITE_PF_TO_SP);
>    }
> 

I don't mind using either option here, in fact both of them would 
require an update if there is a new emulated page fault type; Let's use 
more generic one (which is kvm_can_emulate_event_vectoring) :)

I'm thinking about a static assert we could add to it, to be sure the 
condition gets updated if such an EMUL_TYPE is introduced, but I can't 
think of something neat... Anyway, it can be done in a separate patch I 
guess (if we really need it).

--
Kind regards,
Ivan Orlov

