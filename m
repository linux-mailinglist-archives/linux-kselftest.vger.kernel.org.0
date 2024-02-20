Return-Path: <linux-kselftest+bounces-5013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72EA85B704
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC038287061
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66816605C1;
	Tue, 20 Feb 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cETYwYuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC35D754;
	Tue, 20 Feb 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420469; cv=none; b=E63z4UwLydBdsOFg/JPehxHo3OaurKuUIOVoYblRNF2LkjE6sl4eAv5cjN0Hwmofdw4GEYQTwPlO+brxa03GXc35DXkAk6qDmNKPXhjlx6LStCGDvCOhSrqaGJTHVwKMj4RGTR4ZIS3g/rTLPBgcRUDYAWKL2eK1OyUPvoPrx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420469; c=relaxed/simple;
	bh=RtTybUor9/LxymR5f14KPmgtgO8KSgVPbZN0ZPDUpNQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c1zKKYlM5PlgKh5DoGg8xmHyZGsDKZbI8VgMy62Bl9YGLTCjMl/aIOm5Wi2tsJEDxuXzHDvKMi9xeguE3EdTnWN6bhvqGL0tZnfoNpbP9c/7++fu9S4xI4Ce4hRdtvvPOw83H8DtBVSzjEOb/4Pzu8UwEPAnQhcFPduuDHXHehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cETYwYuS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d241ff062cso18768511fa.3;
        Tue, 20 Feb 2024 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708420466; x=1709025266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHRJ5uavxHQACQ5cYO9Ea7N25IBRyUXaZPA2PXvjQX0=;
        b=cETYwYuSNYFf8t7dqPDj/WupuK4boT7M8VWuFhuZjuE65CZXNDD9xhXS75NETbFWAz
         P5hvaSs8TUPZDSGZM4eLy+Uu8B2bw3mUC0PFBCuUsc065mJ2/Q7t9RbIZJj3OuqJIo9k
         nM5r8vFHpPT3Y0BoSq3jSJA7mMXs+RVLh0h6zr4qIEw4gKpL59R2v34V4D+3jVeCYJCc
         oD4tuznzkLA0jBa8CLKb/LjvJiTj4uBx3Y8fSF4O06p0DFCeOF4ewmgnL8MC9YYzuwSt
         CZT+T/Wj3vBRi/EjKDgBYBSy4fB4DO65iztA2jeQpirAKFjyNDwr26hlXj7EN7O0vQgK
         ESAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420466; x=1709025266;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHRJ5uavxHQACQ5cYO9Ea7N25IBRyUXaZPA2PXvjQX0=;
        b=RHK9oCmA35vj1fYMqh2D8YXCgDQaO685PYnYjlTCIh/HNZBr/rr+5EPSuOQdUMSVDJ
         m7ymUnMguFRZ3i/PBEcuhp32mRm2Hz7JJp2YjyiJyjdDJO6GTehknSRN7UdY7NZIv51G
         tzvXQnVBPbOcmS3/sDU5t+d2bu6Mh7uqe7wKRI4SwU2HtFDHYprnWLoYG0MShl8rQtlD
         BBe3xWl/OzmRUD4QTlL7Renhv+t2NaRXqHZCcKocy2BY+TwUeWU2J+/N6/UTqtwak0MD
         YKylPoSvpIzVfrC4xoqsVKMYsI1GFUVr816XVUhQTASZYxJ+EO114bhCGO6F3D1P2+I7
         r8hg==
X-Forwarded-Encrypted: i=1; AJvYcCWSnGxB+WIZNq35uFZrDqDfZ30OMg8iVuOUZX8GHoFYK+WPu83qDBIm3HLuayyHEBvCUXyqjZCt6Emf3h80/ds9yFINSmrcv9LWvAqBU2UATh2y6Lyq9CA2Im6JPTmHjzQk3CEBChdMZaT7ICPU3JQXHlmQ301XcU7wOHYt6xTaSsM1cdKe4c33xDjv8JBb608jUKWlXaCMUJf+VNVsNf47SIGqY5+QIy6ShSJJKAJ5V2mBDTuqLX0F6g==
X-Gm-Message-State: AOJu0Yxyw3K5TR4BoCaYdn33QKH/bePzN/aTd6o/pM+sWCxLexgywh67
	9YBFOsMZ0GShXXQnIPmnkCVK0/PRnmvvF4GTYTDaZ6hgvIQ2yRvI
X-Google-Smtp-Source: AGHT+IFLd9RCl041APIPsfPJkZcwqeY3/oNw2kxk8d1G1VB7yLLZXzUgS2yvdkID6kLKaOeRKOkxZA==
X-Received: by 2002:a2e:bc09:0:b0:2d2:38b6:661b with SMTP id b9-20020a2ebc09000000b002d238b6661bmr4331135ljf.33.1708420465340;
        Tue, 20 Feb 2024 01:14:25 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.239])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b0033d1f25b798sm12629258wrb.82.2024.02.20.01.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:14:25 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <f85098ba-b56e-455a-9b73-909d71cf0b51@xen.org>
Date: Tue, 20 Feb 2024 09:14:23 +0000
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
Organization: Xen Project
In-Reply-To: <ZdPQ_AcbTYMtArFJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:06, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> David Woodhouse (1):
>>    KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues
>>
>> Paul Durrant (19):
>>    KVM: pfncache: Add a map helper function
>>    KVM: pfncache: remove unnecessary exports
>>    KVM: x86/xen: mark guest pages dirty with the pfncache lock held
>>    KVM: pfncache: add a mark-dirty helper
>>    KVM: pfncache: remove KVM_GUEST_USES_PFN usage
>>    KVM: pfncache: stop open-coding offset_in_page()
>>    KVM: pfncache: include page offset in uhva and use it consistently
>>    KVM: pfncache: allow a cache to be activated with a fixed (userspace)
>>      HVA
>>    KVM: x86/xen: separate initialization of shared_info cache and content
>>    KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is
>>      set
>>    KVM: x86/xen: allow shared_info to be mapped by fixed HVA
>>    KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
>>    KVM: selftests: map Xen's shared_info page using HVA rather than GFN
>>    KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
>>    KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA
>>      capability
>>    KVM: x86/xen: split up kvm_xen_set_evtchn_fast()
>>    KVM: x86/xen: don't block on pfncache locks in
>>      kvm_xen_set_evtchn_fast()
>>    KVM: pfncache: check the need for invalidation under read lock first
>>    KVM: x86/xen: allow vcpu_info content to be 'safely' copied
>>
>> Sean Christopherson (1):
>>    KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
>>
>>   Documentation/virt/kvm/api.rst                |  53 ++-
>>   arch/s390/kvm/diag.c                          |   2 +-
>>   arch/s390/kvm/gaccess.c                       |  14 +-
>>   arch/s390/kvm/kvm-s390.c                      |   4 +-
>>   arch/s390/kvm/priv.c                          |   4 +-
>>   arch/s390/kvm/sigp.c                          |   2 +-
>>   arch/x86/kvm/x86.c                            |   7 +-
>>   arch/x86/kvm/xen.c                            | 361 +++++++++++------
>>   include/linux/kvm_host.h                      |  49 ++-
>>   include/linux/kvm_types.h                     |   8 -
>>   include/uapi/linux/kvm.h                      |   9 +-
>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
>>   virt/kvm/pfncache.c                           | 382 ++++++++++--------
>>   13 files changed, 591 insertions(+), 363 deletions(-)
> 
> Except for the read_trylock() patch, just a few nits that I can fixup when
> applying, though I'll defeinitely want your eyeballs on the end result as they
> tweaks aren't _that_ trivial.
> 
> Running tests now, if all goes well I'll push to kvm-x86 within the hour.

Oh, I read this last and you already made the changes :-) I'll check 
kvm-x86. Thanks.


