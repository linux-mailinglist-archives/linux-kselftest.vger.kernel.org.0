Return-Path: <linux-kselftest+bounces-4333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0484DC12
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEDB25DEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F16BFA4;
	Thu,  8 Feb 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4/Fie8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8A6BB5B;
	Thu,  8 Feb 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382338; cv=none; b=XXwB3BC3CjJHr4lDbgsBwiKQjlItWwF4m1Kkkw4yykevsfavZbEMTKdkQidA7eeCQzrh0NQHc5S0cTdfWvpsx0+yoTTorD3EyKVlyLE2eRezscojYVQiWewscH7ZW6PL9e2114+JmbpwGWICn7ADezzfc6iKEuKQfchPJ3OQOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382338; c=relaxed/simple;
	bh=nsYgwYdoCf/v23CMHkRT2qhweno5Q0SXZJgI7dMic6A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qbuLSb4e2cRxwvlq7+g9HRgA2QafUwEiIURul/MRRReaAkl0FHlCvSS0pP4Jw38yXfAtSCsJ8Z2W+3PIvKy7299S/hL1xO74DBrEMR0sEtAwVEQkPDlSCRBhRGjgsiWQhzlA3Ca9eniFnOtTaOd5bID5kcemYsTg51Rpghc2t8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4/Fie8p; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d05b8942so1154669f8f.3;
        Thu, 08 Feb 2024 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707382335; x=1707987135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLijPkNPZl+6L/SNv7KMroW42WvF577+ZBffRW12WRY=;
        b=K4/Fie8p2dbJtsglNr3D9Zfe/IO5JJlq2HUkmRbox1W2Aca6I3UAYmA8lfRs7oXrzs
         BgnUyUfLA27WnfgAwQ/fGnfAn/pOxv32oRDpU1WnLsAX8Jg2P6YB/gVBs6QxlCQNa7gh
         DLmZj2WcxeP5GjyjpS6JicryortXoQvBi0hjGdTLP5uvEQznG0wiAoYym5YfcO6wmEL2
         b6SuXFcg2IJvka5vapB5rzUDXTEvGZfUPgCwvon7HHeJTwTarGxFMl3WGM5LEsVfjGxR
         J3r2YNajDLCWPzh1kYpWKc+9Irtm+j7l8FHIcVP3KIsf/64C00QNEoMxEobh6IqbdeUL
         SDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707382335; x=1707987135;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLijPkNPZl+6L/SNv7KMroW42WvF577+ZBffRW12WRY=;
        b=HG8mcd+psIBixo8BC39rUDU9lNwO8Y4tiB7TrhZZ0Rd8dxRfODHne8B0/4n1S1iMgi
         YWwNZGUEo6Q8LzqjpBoSVZswx0O2ZBxVeOJyB9oZpaxFOrVDD/9tF/++Dr2UpwFNXrlP
         wHpRsgxMJhVKP/QslNJRPYJKqywbl0Wi7Bx55u51P7Su+scXmHtMboF8EDfElCLrBpc/
         V9BHhY6lTQ8D0mJmBqV44aoFByxCxqTbnUiMKaUJCnfhyQkJXp5A2Iq9JdfRTH5lpC2l
         04s8f+uI1FGccWEBi1wxnuBm0Mo24Rv3fIZBqWUlA4y0QdN6i3QNXSDgS33riH1XN6fH
         m8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWXwjJemMRRs2uNf0KoZDXmZuWdqy2vIo9z0HWqghOT4Z7N/YWJzpTQwJg20XTTCiOyZwhnr2kJ9NX003XN/CU2zROrrHwHoqpXRSkefRicUM3NqYDGF02CRek/1osH7k5fY4teRatgaS0PyN7lR4taDB/q0mPorGKCtDkbnxEIkk1tsSQNRMPZNxDqtDgm6JEBRluhzXpIjIr7aB0o
X-Gm-Message-State: AOJu0Yy5mv/6vzP3/h23J6SALH+k/MlChyr7KBNgbchGwnptQwQc8edn
	2ogp5bl8OMkAkfu8OsbavRcj6PGcewz+R+MDkaoneoO6LP5A4c3/
X-Google-Smtp-Source: AGHT+IG2lAcMdFKBZ5vcEaLKD/Wi/8gZcHvjnvfWa8YHRbWGT4Dmq2v32/8oBzuewudCDRhlB3OTzw==
X-Received: by 2002:a5d:558e:0:b0:33a:fe3b:b2ae with SMTP id i14-20020a5d558e000000b0033afe3bb2aemr4867695wrv.66.1707382334630;
        Thu, 08 Feb 2024 00:52:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9mTO16tkOA+8xvP3tdKoS2oQCC+t3nSnWwQABs6FQGzpVYvQOZaC7FjLZFFYgdXcHeFSK05gT+W1HEMCFcxyowCXGEHrjTN5FKbkjXhfV7Mc5SmfmHswNmCKppsmvv4C7BlOxgJrs60HUV9feZcl88lnXvfNPfYqBbA5F4/L2eIV9bOK9F/kVLlMOLei+eF7IR/VLDL7k+nd9XSWn2onJqY4WS3+MzIcaik3H/9LEXLXISqI1ZrOX5KyB+1rl2IsBrPFPFdM/598+CkR2XRHmedDdI/WJdAAZ7Zdavo9EVAw2xIy97yqJVe+APv7Uh0RFEirn/tn9n4zbbLKxRrA6IShxK+GDlZOWEVg4hUFPZHmQJCTv4g9JTTEnDBU71YWsOKPnCLuRCgDaf3Yp/XQhHO+0mD1yHKdekPoAWJoM1ghNTwQ=
Received: from [192.168.10.199] (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056000069000b0033b0d2ba3a1sm941262wrb.63.2024.02.08.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:52:14 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <92918ee8-3cc9-41c3-a284-5cd6648abc05@xen.org>
Date: Thu, 8 Feb 2024 08:52:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by
 fixed HVA
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-12-paul@xen.org> <ZcMCogbbVKuTIXWJ@google.com>
Organization: Xen Project
In-Reply-To: <ZcMCogbbVKuTIXWJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 04:10, Sean Christopherson wrote:
> On Mon, Jan 15, 2024, Paul Durrant wrote:
>> @@ -638,20 +637,32 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>>   		}
>>   		break;
>>   
>> -	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
>>   		int idx;
>>   
>>   		mutex_lock(&kvm->arch.xen.xen_lock);
>>   
>>   		idx = srcu_read_lock(&kvm->srcu);
>>   
>> -		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>> -			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>> -			r = 0;
>> +		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
>> +			if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>> +				r = 0;
>> +			} else {
>> +				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>> +						     gfn_to_gpa(data->u.shared_info.gfn),
>> +						     PAGE_SIZE);
>> +			}
>>   		} else {
>> -			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>> -					     gfn_to_gpa(data->u.shared_info.gfn),
>> -					     PAGE_SIZE);
>> +			if (data->u.shared_info.hva == 0) {
> 
> I know I said I don't care about the KVM Xen ABI, but I still think using '0' as
> "invalid" is ridiculous.
> 

With the benefit of some sleep, I'm wondering why 0 is a 'ridiculous' 
invalid value for a *virtual* address? Surely it's essentially a 
numerical cast of the canonically invalid NULL pointer?

   Paul

