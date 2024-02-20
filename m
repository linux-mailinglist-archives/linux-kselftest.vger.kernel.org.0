Return-Path: <linux-kselftest+bounces-5017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D885B99B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8351F24235
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186164CF5;
	Tue, 20 Feb 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU7e7pDP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDF664A9;
	Tue, 20 Feb 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426403; cv=none; b=C93xxsU9Gq5wEgYZFBs14wgnxL25TY/J/2+lk7iRqX41s/r86M5dXsfnU854XnJj/22u+NmjfENIoTZikQKOc/ihfk1pB4Rz/ySu76dvrdXp1JuxqA4t8NKCkQ5RW9eeseeH5jMhW8tCjqSy9WV19THvuMFxPf3PZ0I3Naxivyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426403; c=relaxed/simple;
	bh=WcrPPnFdIaTswNzGGLNCjpYeRfDUJLHsrVeXfxJS7Wk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YTThp2efe7emMzZsHqJ+aDVRGQGQfnTC3T8ouv6S+fLj90pkGN6NfS4tWT34bQVXFso4Q0CN+8Mhy8358EmKHPHVjypY25rCdVsP+B0XIAXdmsOAwnb/M/T4Nc8ZpsiwpUGPh6yvZdy2MWUzYJz5F5y0mErrnphBcoOcPRwKjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU7e7pDP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394bec856fso3600667f8f.0;
        Tue, 20 Feb 2024 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426400; x=1709031200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kk7TVBPE2HlTc1l9Sm4itMeOxxlwuSodhj0pqtVmHM=;
        b=TU7e7pDP24TYuKARhHMIpwW55U49f5b5/PudxMBWTvNeKd9OHCk583W8CUl61O0loj
         trxrqBIP32qju7gLSNWU1J83hO3wW+EadX28rggK7yR6wha4AdiGn/T/D4j/Po1r2AjM
         h7FzLqBwei0ShQBtIfqolWxi3/X7p7j1TcJ0BaePblskZTihqaZcPEBt4Ely4wHyBkxD
         /z79p9HHYgVseW5Uq3HXmqSIiIyicxOK+tMxM6QvDVGihInDVI01G4E3T55QFrO9y/eC
         NfIzAUbsVvN5CqObIR+AxeNlHJ9G5ScKqDWr2p7+IaQsef0y2OYqirBb5lKJUetYdqH2
         HD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426400; x=1709031200;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kk7TVBPE2HlTc1l9Sm4itMeOxxlwuSodhj0pqtVmHM=;
        b=c2s7dfBOs93FR7GsgDlri+6XLVdl4l4ktDiAsjAHAz3+hhTma0V3na8GAx2ppJQXWg
         6aLOUgESIaGVr03sJhfMWmcMEaAxROwOvC5TPkJdO6sDwjNy75sYouE/LgDB4119qqmS
         RwU9PX5JS8Hh02MCtacAeGLmyBrq+zWN6h3I0x0SaiIl19EzFsNNpcj7VqzIv4vvejEw
         uZ+iFDnOpU4F1vPPWRbF2WAW/BW6glXzVwSThtQiLEFT5ADXkHfTUZ2zUnpy5M5MPW32
         93lP5Cff8Ww6C0vqshr3Ov+jonw4fKnEzqH43j0lYkJMBOBn/31HeGSiNJHQCCJ33NP4
         I66g==
X-Forwarded-Encrypted: i=1; AJvYcCWQx7LrfKPoA2JHEgQG7YCgaK5BBXEOl3oWE37zHUPwJ42hYjflTYAAlFNplejujq035HqRM2sf48v6Wi50M4eOWOE2bgxpyOW/fF3C9ZKyeOtfFEvp76gktOOA7rhbv6oQtE9MAjAkm/yokAsUgTGWgQ199jfL42m+dwCQbKHjYomg5HGFDcEHQwx1YiauEKm+Do2n1/IaiMuJNBc6P9y8y0LNCYXF6/j7l1EKQRv2OljDxZT9yvvv0Q==
X-Gm-Message-State: AOJu0Yw8oXJDhpl/MLOGjFGVWm0YJGKw5AQON4vdvntSeOf9hj+69q65
	7cB7ahmXljegQJrkgXH+TpqHnMpVZXycNhhkvGGz/CdES3l2QcaQ
X-Google-Smtp-Source: AGHT+IH7465FJ5bRclP1AsBPW6J2ByerjfrQoZxMhpklVxMUbyc5bzfafg2vxzaK3n/7AH+GNoFpcw==
X-Received: by 2002:a5d:5345:0:b0:33d:1bd1:8ae2 with SMTP id t5-20020a5d5345000000b0033d1bd18ae2mr9759369wrv.19.1708426400183;
        Tue, 20 Feb 2024 02:53:20 -0800 (PST)
Received: from [192.168.10.18] (54-240-197-233.amazon.com. [54.240.197.233])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600016c500b0033d60cba289sm3750737wrf.68.2024.02.20.02.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:53:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <0ba3a87b-7596-466c-9415-7af28c95dd1e@xen.org>
Date: Tue, 20 Feb 2024 10:53:18 +0000
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
References: <20240215152916.1158-1-paul@xen.org> <ZdPQ_AcbTYMtArFJ@google.com>
 <f85098ba-b56e-455a-9b73-909d71cf0b51@xen.org>
Organization: Xen Project
In-Reply-To: <f85098ba-b56e-455a-9b73-909d71cf0b51@xen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/02/2024 09:14, Paul Durrant wrote:
> On 19/02/2024 22:06, Sean Christopherson wrote:
>> On Thu, Feb 15, 2024, Paul Durrant wrote:
>>> David Woodhouse (1):
>>>    KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues
>>>
>>> Paul Durrant (19):
>>>    KVM: pfncache: Add a map helper function
>>>    KVM: pfncache: remove unnecessary exports
>>>    KVM: x86/xen: mark guest pages dirty with the pfncache lock held
>>>    KVM: pfncache: add a mark-dirty helper
>>>    KVM: pfncache: remove KVM_GUEST_USES_PFN usage
>>>    KVM: pfncache: stop open-coding offset_in_page()
>>>    KVM: pfncache: include page offset in uhva and use it consistently
>>>    KVM: pfncache: allow a cache to be activated with a fixed (userspace)
>>>      HVA
>>>    KVM: x86/xen: separate initialization of shared_info cache and 
>>> content
>>>    KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is
>>>      set
>>>    KVM: x86/xen: allow shared_info to be mapped by fixed HVA
>>>    KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
>>>    KVM: selftests: map Xen's shared_info page using HVA rather than GFN
>>>    KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
>>>    KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA
>>>      capability
>>>    KVM: x86/xen: split up kvm_xen_set_evtchn_fast()
>>>    KVM: x86/xen: don't block on pfncache locks in
>>>      kvm_xen_set_evtchn_fast()
>>>    KVM: pfncache: check the need for invalidation under read lock first
>>>    KVM: x86/xen: allow vcpu_info content to be 'safely' copied
>>>
>>> Sean Christopherson (1):
>>>    KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
>>>
>>>   Documentation/virt/kvm/api.rst                |  53 ++-
>>>   arch/s390/kvm/diag.c                          |   2 +-
>>>   arch/s390/kvm/gaccess.c                       |  14 +-
>>>   arch/s390/kvm/kvm-s390.c                      |   4 +-
>>>   arch/s390/kvm/priv.c                          |   4 +-
>>>   arch/s390/kvm/sigp.c                          |   2 +-
>>>   arch/x86/kvm/x86.c                            |   7 +-
>>>   arch/x86/kvm/xen.c                            | 361 +++++++++++------
>>>   include/linux/kvm_host.h                      |  49 ++-
>>>   include/linux/kvm_types.h                     |   8 -
>>>   include/uapi/linux/kvm.h                      |   9 +-
>>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
>>>   virt/kvm/pfncache.c                           | 382 ++++++++++--------
>>>   13 files changed, 591 insertions(+), 363 deletions(-)
>>
>> Except for the read_trylock() patch, just a few nits that I can fixup 
>> when
>> applying, though I'll defeinitely want your eyeballs on the end result 
>> as they
>> tweaks aren't _that_ trivial.
>>
>> Running tests now, if all goes well I'll push to kvm-x86 within the hour.
> 
> Oh, I read this last and you already made the changes :-) I'll check 
> kvm-x86. Thanks.
> 

I checked the patches you amended. All LGTM and my tests are fine too.

