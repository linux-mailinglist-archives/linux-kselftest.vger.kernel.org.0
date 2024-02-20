Return-Path: <linux-kselftest+bounces-5046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3F85C204
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A07281B26
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174F76C72;
	Tue, 20 Feb 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAI/MB9o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F176911;
	Tue, 20 Feb 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448843; cv=none; b=QVQPY2D654ddAIxtcnN5BHq2OaAPAqK6bSACsEcif4ID/de3P8GJqEzX7WLjuP25w6U9icL+Eh1Ulbv2sRnQWXowMYPgRJSeQui3xN0l11LlL9ZKzxOiN7wKYdDkMFXKk4ye2/dgJsKuMulRsGD8Rg3BR3Uo2jYOebNZgYdQHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448843; c=relaxed/simple;
	bh=mtYh4pPl8nUvoS1cpHihY1SAedbSQ4SPzAugmWQRuzg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y9tKtrsX/ngBqg2MyKGA5LjNzCCY1VRsJE0ImIUWu1g9u+j94OdLqEUQitNKFf73JnSGMgYx9GS8mpftAmGAOlv8nGzW0C84lcGdRk6hgrXYJYJAhJMGKFLLb19SBNOYIlYyovHsU1wZQtlmHYiqQrgPxy7vQIXb7+zvlsYkJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAI/MB9o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4127109686fso3954715e9.2;
        Tue, 20 Feb 2024 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708448840; x=1709053640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bS6mzlS2FvG30g8kCU8KyMPeOwgxgcQl7tVtSUw6YUE=;
        b=lAI/MB9oFbzyaNZfoz840sx0CMM+mGzBvK2b4ln1Kge5yPZFBIpP1VhXIMjjkj5uNC
         psYZuPFBvfwISobjsRTN5bRv2T8Q0EdRlT/YL7F9WT1uU+nsAKDLkoIyrHbDkzp6iW8t
         Gx1B5I9MqU6bHy32svhJ/WpZGVlbTipSXdZWysjNKWFplkOvID1ULrNV1KuG17xFdcm1
         00Oka3gVCTwKqysWHTLrHVcE/7Iv/hBcdu+cqjoc3aDmUjUVRnoJdGauABsIQLw50BiM
         XRiYd+FmDrG9OHKvc4B8rOPut2GYuHpsPHj2MD1dTKD4sq5hSET/4QlCs/68MBqLEgyi
         +tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448840; x=1709053640;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS6mzlS2FvG30g8kCU8KyMPeOwgxgcQl7tVtSUw6YUE=;
        b=Ls2mFvTLZTSzKWqfZHsXXNN/4lthFSDbZ55S+lxCuXzdYHJyFZcX5YphIHpwCd6m5y
         NdDqALDIWnmhLEYhYTyXN7NCCitmAKDak7znOh3QR/DwMdaNTDDoHuaSWPebZAR6dmEi
         Oe6rZ9SHI/gxubn992Go3jnxmcLq2eF/60bDYzQqxirc4H+Zi1RQVEjF4HArMUbS4l9h
         AtJnEbKuIDGsT5SxaNaELPddBVWPnViE2kl/JSTDNIa9N61GYUR9xgF2LQYAZ+1Qsfz7
         Rmwuxjcto8FnNngTYIrWM00d6Y16OlV0KHo68xEArn5DAvG7pUSua7DndSzcUMYIPZSs
         E4dA==
X-Forwarded-Encrypted: i=1; AJvYcCXRo17lhE6TcalT23u+VRU6rPP0Fdnh3HpZs2WRzD7zwrqzyKji8fdz9gpUIElbHNZqHs8tpczVlm2NaZp8iy944sscg6+MZ1MHLBysxFch/A732Q5/qw1BECaukZcAUrBKGEOc4+kLRtbheSY6p8PoHycPPBMUDc52vIIqhF7QNqNDq9XZyPS4kxu23b/QxrdwxuQWSmAYU+VYWzpkvMRcqkVkmjVjVX0lk3P0R6KwBHg3/Y1NBfi+qg==
X-Gm-Message-State: AOJu0Yw0/jww1HVDaa96CwiGtPtcQ/dQkCIXvH+3a4ePzF5mRuElCuuI
	vuMis8O8cXD2iXuCkXrY/WPq4zInCou5KGFAw6gNLYIUVzVvprJ7
X-Google-Smtp-Source: AGHT+IGKDgeb1b4/RZMqZUijqCwIZaYIC4U3t4wwvNhBDBJASOb+1pT/1HGi9975hFGHmqQ0PDn8dQ==
X-Received: by 2002:a05:600c:1c93:b0:412:6dd4:1001 with SMTP id k19-20020a05600c1c9300b004126dd41001mr2072917wms.16.1708448839929;
        Tue, 20 Feb 2024 09:07:19 -0800 (PST)
Received: from [192.168.10.18] (54-240-197-233.amazon.com. [54.240.197.233])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm12231744wmq.10.2024.02.20.09.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:07:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bd028731-bc98-4735-a7f9-9b4ef9c00668@xen.org>
Date: Tue, 20 Feb 2024 17:07:17 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 00/21] KVM: xen: update shared_info and vcpu_info
 handling
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
 <170838297541.2281798.7838961694439257911.b4-ty@google.com>
 <05973da0-f68c-4c84-8806-bdba92f2ed6e@xen.org> <ZdTQCuWor4ipxW6E@google.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <ZdTQCuWor4ipxW6E@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2024 16:15, Sean Christopherson wrote:
> On Tue, Feb 20, 2024, Paul Durrant wrote:
>> On 20/02/2024 15:55, Sean Christopherson wrote:
>>> On Thu, 15 Feb 2024 15:28:55 +0000, Paul Durrant wrote:
>>>> From: Paul Durrant <pdurrant@amazon.com>
>>>>
>>>> This series contains a new patch from Sean added since v12 [1]:
>>>>
>>>> * KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
>>>>
>>>> This frees up the function name kvm_is_error_gpa() such that it can then be
>>>> re-defined in:
>>>>
>>>> [...]
>>>
>>> *sigh*
>>>
>>> I forgot to hit "send" on this yesterday.  But lucky for me, that worked out in
>>> my favor as I needed to rebase on top of kvm/kvm-uapi to avoid pointless conflicts
>>> in the uapi headeres.
>>>
>>> So....
>>>
>>> Applied to kvm-x86 xen, minus 18 and 19 (trylock stuff) and 21 (locking cleanup
>>> that we're doing elsewhere).
>>>
>>
>> Looks like you meant 17 & 18?
> 
> Doh, yes.
> 
>>> Paul and David, please take (another) look at the end result to make sure you don't
>>> object to any of my tweaks and that I didn't botch anything.
>>>
>>
>> What was the issue with 17? It was reasonable clean-up and I'd like to keep
>> it even without 18 being applied (and I totally understand your reasons for
>> that).
> 
> I omitted it purely to avoid creating an unnecessary dependency for the trylock
> patch.  That way the trylock patch (or whatever it morphs into) can be applied on
> any branch (along with the cleanup), i.e. doesn't need to be taken through kvm-x86/xen.

Ok, personally I don't see the dependency being an issue. I suspect it 
will be a while before we decide what to do about the locking issue... 
particularly since David is out this week, as he says.

