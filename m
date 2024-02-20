Return-Path: <linux-kselftest+bounces-5012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBE85B6A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BDC1F238B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6395FBB6;
	Tue, 20 Feb 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCl+nh95"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F85BAC7;
	Tue, 20 Feb 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419935; cv=none; b=ePLrS7waLHcz823F59sJsEWgOTJ6bjgsi1M1c/bVzTWVHHnjHpGTOAYq+pCgsGP4RTJsHUN1qFCRvM0j18gcwi7bcdORtqsavCP/ivIiPIBqVN3ulX+NI2TgRdsMf+XWiw1MMDsiWPeFU8ZXq12adJs3c7HuoTz7qOe4Xj0gS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419935; c=relaxed/simple;
	bh=jK3b9DLJc9Th42/uIfgM88dYSGXRde4vwZMJjZeqWns=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JFSQidP5ulHTH/D40DPBBmBAD8WKpj5xoMRB+P/Bo7szgXTGdOZYFI7Ngbd0cI2jNjrZQnUmrX6raHmyUzCQNFbGIKHuCYE0MmtazZox9LQ/I0YwnR4DsgHAsGCnF4DJeSFwia1/cv8mmDVD5LZa2A+XCbc0eN2vgecoVEBEo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCl+nh95; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4126aee00b2so8852045e9.3;
        Tue, 20 Feb 2024 01:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419932; x=1709024732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ig5UbaNkYqer64gSBn+qlNSGWqY7ObrqlHVCVer7Hj0=;
        b=nCl+nh95l2xfjO66LiC+sEZsJ9ZwGj//3iDT6ouLO+Kt1KfUJtIQ06jiC58781n4k+
         YeyB+RqZ1j2K5ilvxQL8Divzd0pPRJet8iu7tjtPWUguqhpkiRMeEjab3O15+XuwyPET
         Ttff8GOAR3A7jtzlEmC3COdY6Kq1IZ62NusEu1r0STuqJIV+2KUwoa4tVIUeQnul5PAl
         R0/9bkYBBLw7/VHNluYBPwUo78MfTde4Gucnkiid8kHAnkQsjwlFYeAuwpyWDI+YVwOR
         BeU5a46qq9fYIdXkDTLF+87IeSlWS0qyd+CVg2uZa1irPWY6zgNINF8W22ygLDEXVsXn
         bmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419932; x=1709024732;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig5UbaNkYqer64gSBn+qlNSGWqY7ObrqlHVCVer7Hj0=;
        b=joWR9u4WFQ0Mk0h9NROzcQzLwNAKS0JR7GTZOJolk/EaYqOp7q5fHqX4ALmCBI7sCC
         RvmZAV3H5Ef/E/x2mfMXIUyNG29BoU789O+Jfi9pPLlASX22cEiH65lKML9Z7Pl3JGil
         nfixuzhN2qFw8mjXlkFOGEv0V/XDiJcsXy1eRhnHIozNPZPMHExqGEfgzB8pgtEopGAf
         ZoGeOqV/1hiMjSsGHATlhSAAreLUnyt7ovJmLXUsROeqpTeH4ZghIWo812wXDOdaTOZ2
         YuatGU9fwjngWLx50/arKUxcsBmGTWKiU52m/YbmgsottPfiZg4Dj+lKfszLDNzC9xmT
         wmww==
X-Forwarded-Encrypted: i=1; AJvYcCWKixPwoY/TZyl6s3dVO3AToFC8YmJ33KmuMNFvOGW38tvc+yadXS5yNE2LX5oPxLNwRfJkBSxpmdXpL23IwqmPxvuA5bMyV5FbNsnoDrixI6vrtYhVcIsxMpMkWUnOq8VA84bwPf2ixRnly473osjQW5sXXpsJzWBF9z3zWYAhIutZJYFdcqzqL38WDeF11bHU96kDMZP1rnhDM34qSzp9Ou9rC4sri7TZ5UvOb3dzg5goJXiopimYfA==
X-Gm-Message-State: AOJu0Yx3Vgnm0FRxK/nxVPcciojR4yY+pNu6QA2yK1gUQLV7YO0DHUAO
	K08xHcN8OGeT9k9QBhv/JYZKmb+m6qc7YDns6vA/4c7JJUdo5AFd
X-Google-Smtp-Source: AGHT+IFLOoKRegUiU+mZanJ0U2d2TL31TO0Zdg38BMIBc2yTRhNdPGtUWzTbgBCy4gzGh9AS1QwMPw==
X-Received: by 2002:a05:600c:4f0d:b0:412:107d:cd6c with SMTP id l13-20020a05600c4f0d00b00412107dcd6cmr10595323wmq.28.1708419931996;
        Tue, 20 Feb 2024 01:05:31 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b00412706c3ddasm570024wme.18.2024.02.20.01.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:05:31 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <54ef40fc-31dd-4d37-8091-66a1ff3df6b9@xen.org>
Date: Tue, 20 Feb 2024 09:05:29 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 18/21] KVM: x86/xen: don't block on pfncache locks in
 kvm_xen_set_evtchn_fast()
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
 <20240215152916.1158-19-paul@xen.org> <ZdPQVP7eejq3eFjc@google.com>
Organization: Xen Project
In-Reply-To: <ZdPQVP7eejq3eFjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:04, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> From: Paul Durrant <pdurrant@amazon.com>
>>
>> As described in [1] compiling with CONFIG_PROVE_RAW_LOCK_NESTING shows that
>> kvm_xen_set_evtchn_fast() is blocking on pfncache locks in IRQ context.
>> There is only actually blocking with PREEMPT_RT because the locks will
>> turned into mutexes. There is no 'raw' version of rwlock_t that can be used
>> to avoid that, so use read_trylock() and treat failure to lock the same as
>> an invalid cache.
>>
>> [1] https://lore.kernel.org/lkml/99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org/T/#mbd06e5a04534ce9c0ee94bd8f1e8d942b2d45bd6
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>> ---
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: x86@kernel.org
>>
>> v13:
>>   - Patch title change.
>>
>> v11:
>>   - Amended the commit comment.
>>
>> v10:
>>   - New in this version.
>> ---
>>   arch/x86/kvm/xen.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>> index 59073642c078..8650141b266e 100644
>> --- a/arch/x86/kvm/xen.c
>> +++ b/arch/x86/kvm/xen.c
>> @@ -1678,10 +1678,13 @@ static int set_shinfo_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
>>   	unsigned long flags;
>>   	int rc = -EWOULDBLOCK;
>>   
>> -	read_lock_irqsave(&gpc->lock, flags);
>> -	if (!kvm_gpc_check(gpc, PAGE_SIZE))
>> +	local_irq_save(flags);
>> +	if (!read_trylock(&gpc->lock))
>>   		goto out;
> 
> I am not comfortable applying this patch.  As shown by the need for the next patch
> to optimize unrelated invalidations, switching to read_trylock() is more subtle
> than it seems at first glance.  Specifically, there are no fairness guarantees.
> 
> I am not dead set against this change, but I don't want to put my SoB on what I
> consider to be a hack.
> 
> I've zero objections if you can convince Paolo to take this directly, i.e. this
> isn't a NAK.  I just don't want to take it through my tree.

Ok. I'll drop this from v14 then. It can go separately, assuming there 
is no move to add the raw lock which would negate it.

