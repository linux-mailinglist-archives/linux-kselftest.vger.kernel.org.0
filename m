Return-Path: <linux-kselftest+bounces-5011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E685B69F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E631F2505F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180615F471;
	Tue, 20 Feb 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncIqjJ42"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B75D8EA;
	Tue, 20 Feb 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419816; cv=none; b=OVaI0/yGYtU5P6CKDtfafwMMMje18aorJgeBvJD5o+pgEP+yjW6MugI/Q1HM03JgxR/qBY0XExw0L3yvYLId+F9g61zCxEn27C3gFOlCft2ZBiVc3qMISu94ok7ebxCZOCkvv95nn8XPjVt4dtBq9qrKrCnPvlEqvXcMkGalAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419816; c=relaxed/simple;
	bh=+QEWfSHhYBKuafjCwRIfOA10sASx6MgTqjF9OOhMZfw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B6C7mrONgJvzGR+RX/wCY8mBY0DwgqDyjJTDJvVsQdGUavdjWRJo3WHJ8UQT3I4mmYOAL0qFrztRSl8ukGk8HPZGVLsUWoXNyHJtGaUDKRtYrl4YHNjB8fO/BTo7OTe809eqVoJW5aA+XtqMo5mnsH2qFe3zP6fpvDz5zlK94O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncIqjJ42; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d36736d4eso1690013f8f.1;
        Tue, 20 Feb 2024 01:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419812; x=1709024612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+OmS3xJIO7hb5gJugts8YXFx8Npo3EjobwfBSBe6mM=;
        b=ncIqjJ42GRWsPJXQ4vL99HAmBoK4ClzKSITAjG8xO0pHqYiybXNm5A3LXPbmWZuccd
         spfFj6ytsmfYmKkupcnbxpPdDaPyBc333SDl4CDqSN9d31zSCQth/4gnzFv+TaeokRVi
         aJyB69RUdgGMfZcJBkvqoxEul2Bnir+A448cGLkuYG20Q+aYCWAay2ogdzRZ/1T1VIlr
         vCj089ERY+5/twt1zRF9nLQnMu1QHeWIPyEpumsh2039e94KPHYa+UnqqU85IhCnPfCH
         WDT1Xm+2vYced8tSLqpRX9FRCg0Z1ufx4Id7wgQq6cQ9kjomSckuyx07GL0fIRuwf2GH
         cKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419812; x=1709024612;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+OmS3xJIO7hb5gJugts8YXFx8Npo3EjobwfBSBe6mM=;
        b=Hxu3qs3SdmZ+6l4LQwN4YFRPaYnT8HtIVv5bDjGB55byebQ5KZRKuid3FTfKnXjMf2
         gyXyiok96GoUgST0LiyI/MqeggqBPM31PLz9IDpDtZVDGCVCZspoRGXMYpiYHTeYSa4b
         UGrlXkeYgos2iegJNJFhA/+n4WbtGom/ZIeIjAEFEkO+o6tTsvgx8egqRB+Fmyb/VH7q
         7DM01w7GNfdRWRDlNHdBuCWpm/c2zKRcj1wG620FXSKAKLAVha318FUc9olI244aMbRR
         9rxa6yX7khu9NhbBxYPgcfUyz7amXi3e91ZwW7ojwKtigiCamf8Yc2umwpFimJObS5E0
         bQOg==
X-Forwarded-Encrypted: i=1; AJvYcCX8OeIRpcUFiyGXkEoLsaPloy2+E3DjqJ3nEj6s//ZRQbO8A+ydw/+wILGHtNKxvUT+VURvd2aEKv42AgggtW91aZlMntkLUmKInfcyI8NtJyCvsEAGdaTwrLRiusetHviA8lpakTR6kgFziqb/iBJtOTRyj+Pbwa6EOFv+0aCHc/2FoslVSf56/lKALicAVX0Nfsg1mAqUPBX74b36ePS08Fa+hheQkxqL/8iKVMgmY+qE61nASj3nvQ==
X-Gm-Message-State: AOJu0YyXBZymyXbRtScwdm4KoZvLcaFEDe0zFQfBalKRbR1c5++A/zcq
	FR4o6oCaMU9SdY6iWR0fJ5LmgOL4bS+Im20AY+MlFBDGfOx6A/tk
X-Google-Smtp-Source: AGHT+IFyx3w1wlPEzpgR7Ybfr5R4Y2VTP7azarkJVPCcn5zXERIvj9cTPp2mnyLIEdlKjn5VJornuA==
X-Received: by 2002:a5d:4104:0:b0:33b:4d24:18c7 with SMTP id l4-20020a5d4104000000b0033b4d2418c7mr9232891wrp.9.1708419812576;
        Tue, 20 Feb 2024 01:03:32 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.239])
        by smtp.gmail.com with ESMTPSA id bx15-20020a5d5b0f000000b0033d202abf01sm12058043wrb.28.2024.02.20.01.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:03:32 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <0f290ba9-4fd1-4986-8562-b90706fd1b5d@xen.org>
Date: Tue, 20 Feb 2024 09:03:30 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 12/21] KVM: x86/xen: allow shared_info to be mapped by
 fixed HVA
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240215152916.1158-1-paul@xen.org>
 <20240215152916.1158-13-paul@xen.org> <ZdPNw9evnWw2JzG-@google.com>
Organization: Xen Project
In-Reply-To: <ZdPNw9evnWw2JzG-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 21:53, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> @@ -715,13 +731,23 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>>   		break;
>>   
>>   	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
>> -		if (kvm->arch.xen.shinfo_cache.active)
>> +		if (kvm->arch.xen.shinfo_cache.active &&
>> +		    kvm->arch.xen.shinfo_cache.gpa != KVM_XEN_INVALID_GPA)
> 
> This should really use INVALID_GPA when checking internal gpc state.  Mostly to
> help clarify what is/isn't KVM Xen ABI, but also because I don't like the subtle
> assumption that KVM_XEN_INVALID_GPA == INVALID_GPA.
> 

Sorry, yes, that was miss on my part.

> Even better, if we slot in two helpers when the HVA-based GPC support is added,
> then the Xen code doesn't need to to make assumptions about how the GPC code
> manages HVA vs. GPA internally.  E.g. if we ever refactor the code again and use
> a dedicated flag instead of gpc->gpa as the implicit flag.
> 
>    static inline bool kvm_gpc_is_gpa_active(struct gfn_to_pfn_cache *gpc)
>    {
> 	return gpc->active && !kvm_is_error_gpa(gpc->gpa);
>    }
> 
>    static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
>    {
> 	return gpc->active && kvm_is_error_gpa(gpc->gpa);
>    }

Sure, sounds good to me. I'll add those.

