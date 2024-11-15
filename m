Return-Path: <linux-kselftest+bounces-22115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009469CF274
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8422E1F21D91
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51431D5AD7;
	Fri, 15 Nov 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdYT92Go"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418A1D5173
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690642; cv=none; b=ffJnqqk++aTBcTBj5PP4Vw1/qCnIi2njV0S+E18iBx3uCMFW4Uw3vlLwJxWuQfo0KY/EINahOYjsNCNP6DQY7E+NEKeU+i8cPhdOz8gXnh3C+3BFPpAw2WCVY0Wd6GWty1xIxgHYxsGc9P6RAcMUWRvfNbJX8zdU5wQqzDfx3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690642; c=relaxed/simple;
	bh=VFsz53rKK1c3y7SHDdK7nkd3SLfBSUfMhdGyM3Cgze8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh74MZCeDhAugs64pN4L7JBAjZwhhbYtZCZeoRQG2VHDP7zz2AVGowzJkm22IkCoLI9sP9kiLHJwWTSg7+JySvMzE5Ah4qdO9qax2Jwy0ohZuxIb5xaWyl32gfeLpuLZsx+bSYD0osa7mHW3ZJy8cQZerf8xpPOt0GfgAVERKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdYT92Go; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731690640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=48OliLDzjGOtoC4m2e/3Cn/tIGUFMAeqWxw8T4GQ1zM=;
	b=OdYT92GoFPTGA37LSlDbTHKE5nAb3kcSFpxgegaT+8xhjqQhyKWdlBszejHUyf7Mrcu7su
	LKWrqma7a5Q2V+aAu12OdK+a/rmd/tYnknbSG/ml/FgHR9tMEmprDzHqHvEuPc8dbnFbam
	Z76qWcijnVdyoz23YcEbQkX0D96ng2o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-wKLHRtrxOVm82oMXXKY-bg-1; Fri, 15 Nov 2024 12:10:39 -0500
X-MC-Unique: wKLHRtrxOVm82oMXXKY-bg-1
X-Mimecast-MFC-AGG-ID: wKLHRtrxOVm82oMXXKY-bg
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539f7abe2e6so1676635e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 09:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690637; x=1732295437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48OliLDzjGOtoC4m2e/3Cn/tIGUFMAeqWxw8T4GQ1zM=;
        b=rpGUQ0N995wIU14GKinmegxqqDi3eKlPh1X2bpzyB213U1UiC6bXX+6oHghA/K88pL
         yri39XpvtFa5s4gRxwOTuUzP3UHYSNehI47PeKg6UOmQj1vDOAo7/I4gwZoK6ecYIuPW
         1YOmZSOYUt2XOEnO9FqDszFYerbUVHJqGZkAZQtlT69KEiOq9e9LALEeXvZvvgdEMnlw
         0kXCCmNy5zeQX9m/6TKLfCjztdEa9fRt0iMSUdMgYTmxdyvoAf2avqP7dl058IYJULUH
         E8hAkF4QgbwlC+jlNoi9Lfg9P4BMHJ8pQEo5nUHithBKaMp68cPU3U4oPv9lk5u5gzWZ
         RkEA==
X-Forwarded-Encrypted: i=1; AJvYcCVDe7pMhPBifaFkLkeleVBG6YI7Y22mmFbbZy8b8H2XnieXbr0VKfe5BPjnky+gLogwl4oq0aTk2qCA51Bl4QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkBhyzT64648W6XUZp8S3ENuU/5zD6GxuFXmtA816JUrjBu3t
	+sHmaVVmykdzNg6PDa7o9c0dgXgf+3/yzmZxNM8LjuIYtynCY3nOhoTAPTudMkkXfp5B+znCDbu
	S0/XJgv/nIzzorBbXl+Xv9/7L9FpYPnhuFP37ZKIUWFo2/5AqgydBVidUEolrEWPbzg==
X-Received: by 2002:a05:6512:39c6:b0:539:f13c:e5d1 with SMTP id 2adb3069b0e04-53dab3b0648mr1791131e87.38.1731690637362;
        Fri, 15 Nov 2024 09:10:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq5FUuRRyR5Vm7BO6UHaxJzl2kq52Rh+JW8BLqfChE5k/Qq35g8v4m3WQZHC3kxF7OpNDRyQ==
X-Received: by 2002:a05:6512:39c6:b0:539:f13c:e5d1 with SMTP id 2adb3069b0e04-53dab3b0648mr1791114e87.38.1731690636916;
        Fri, 15 Nov 2024 09:10:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721d7sm61558775e9.9.2024.11.15.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:10:36 -0800 (PST)
Message-ID: <dcdce8e1-51da-42da-a892-59c6ccd9de23@redhat.com>
Date: Fri, 15 Nov 2024 18:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, ackerleytng@google.com, vannapurve@google.com,
 rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, faresx@amazon.com
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
 <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
 <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
 <02f77d32-e2a1-431b-bb67-33d36c06acd3@amazon.co.uk>
 <f4c5d0a6-a582-44e3-8949-c199cc0bfba7@redhat.com>
 <f1f34ac0-d505-4982-aad9-86a0db9f4a35@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f1f34ac0-d505-4982-aad9-86a0db9f4a35@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 17:59, Patrick Roy wrote:
> 
> 
> On Tue, 2024-11-12 at 14:52 +0000, David Hildenbrand wrote:
>> On 12.11.24 15:40, Patrick Roy wrote:
>>> I remember talking to someone at some point about whether we could reuse
>>> the proc-local stuff for guest memory, but I cannot remember the outcome
>>> of that discussion... (or maybe I just wanted to have a discussion about
>>> it, but forgot to follow up on that thought?).  I guess we wouldn't use
>>> proc-local _allocations_, but rather just set up proc-local mappings of
>>> the gmem allocations that have been removed from the direct map.
>>
>> Yes. And likely only for memory we really access / try access, if possible.
> 
> Well, if we start on-demand mm-local mapping the things we want to
> access, we're back in TLB flush hell, no?

At least the on-demand mapping shouldn't require a TLB flush? Only 
"unmapping" if we want to restrict the size of a "mapped pool" of 
restricted size.

Anyhow, this would be a pure optimization, to avoid the expense of 
mapping everything, when in practice you'd like not access most of it.

(my theory, happy to be told I'm wrong :) )

> And we can't know
> ahead-of-time what needs to be mapped, so everything would need to be
> mapped (unless we do something like mm-local mapping a page on first
> access, and then just never unmapping it again, under the assumption
> that establishing the mapping won't be expensive)

Right, the whole problem is that we don't know that upfront.

> 
>>>
>>> I'm wondering, where exactly would be the differences to Sean's idea
>>> about messing with the CR3 register inside KVM to temporarily install
>>> page tables that contain all the gmem stuff, conceptually? Wouldn't we
>>> run into the same interrupt problems that Sean foresaw for the CR3
>>> stuff? (which, admittedly, I still don't quite follow what these are :(
>>> ).
>>
>> I'd need some more details on that. If anything would rely on the direct
>> mapping (from IRQ context?) than ... we obviously cannot remove the
>> direct mapping :)
> 
> I've talked to Fares internally, and it seems that generally doing
> mm-local mappings of guest memory would work for us. We also figured out
> what the "interrupt problem" is, namely that if we receive an interrupt
> while executing in a context that has mm-local mappings available, those
> mappings will continue to be available while the interrupt is being
> handled.

Isn't that likely also the case with secretmem where we removed the 
directmap, but have an effective per-mm mapping in the (user-space 
portion) of the page table?

> I'm talking to my security folks to see how much of a concern
> this is for the speculation hardening we're trying to achieve. Will keep
> you in the loop there :)

Thanks!

-- 
Cheers,

David / dhildenb


