Return-Path: <linux-kselftest+bounces-12404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C27911D1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41341C217E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C216D317;
	Fri, 21 Jun 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iheIrgXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593D16C69A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955835; cv=none; b=jOhguFVBGht7LWLR8Dq6DZFrJYEU5P4sc5CzVtizqjR6AWOU7WXp2PicTnO62FORcnxzO44uQarp6OswHqCXn25ldUaPNOXITVnIojpuemNlDiszeA3vk7VxmbM6huhUxx3qiGdGqqKCfLtQaTfbh7jHQj5++rqLF9NAmNpfwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955835; c=relaxed/simple;
	bh=YNBcFfzbWAq+jVZSQczcHRECwRi328adu6VUAsu6zYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3cl59aMTKPualWbj7MGKr4cKFo2Rrq+q9bGAZVWzlr/77q//qvGmnOAAJ1t8IjduqWG8No5252EdeATxh+Ar5RafbF69shpcTUSveatBVGM3effMO5PKtLimnddUTGjlfaoS+2K2ZtZyr8GTIoeX2fZGlR1JN0RFMNwo5HMhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iheIrgXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718955833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PXQ4efuXmJaBuTYOu/+WHETOQnkAh+ulGBOP07t9dcc=;
	b=iheIrgXrXHKgsZdHEzowClQQ+9H9QyBB/+LqeKDsMVhS7me1dfgFpu/fD1PSt1QKTG1GO2
	WphLRQGQj2tCZ+ri94A4vlwJAVwsC85zAmOkjDinBAygFtTUvisspGNa6FgdhPPu/cCasH
	Kf79dACwiLsCtmnJkRXA7cxDEZrk9uw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-dFno_wm4Ns-rwRezOARnaw-1; Fri, 21 Jun 2024 03:43:51 -0400
X-MC-Unique: dFno_wm4Ns-rwRezOARnaw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so12659595e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 00:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955830; x=1719560630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXQ4efuXmJaBuTYOu/+WHETOQnkAh+ulGBOP07t9dcc=;
        b=q61nafXbnOQqxNLAsYz52xKvpemox8NfN837gq8Om06dIsdGY3pcr+4fz0O3O1rtrh
         Zrg5SNRetHMGD25KLRr83C2+YtB44UaNHA1m8TIDfykGR0yqZKxLR8toeDcKq736tCj8
         9T8jQB5GXWeaXTr9snVQUNnV1Nw6S6QTQHLBWWbC51zn5ivpndRbvLmY7uRA9zovBkNk
         Vc/yJtqi1GFg/fmdQdZcGg2ZywWfUfgZ3BmGQ3M2r6eKWWiqvaddFmITBxzpoLdozQtw
         6ZjHBz0zSLtrbAfUQm4u5wCocUidStznvfwfoxXV0I57JX0sXMtdMtqVaoNeZxf4INUb
         y7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWbCigyne2WxZlL7Q+SGtnJSkMVs0mhlMK3Ir3HMtyIrJih2QgXE3SrMOMd/05xlAp6nl4Z+BfV94t93cR1yiUCCvfxLVi51eb3ED2wsHAS
X-Gm-Message-State: AOJu0YydJC8SC2UB80fwzbQn695ZHd5CSSbRFfoVThfKzb8o3RvsqRzA
	O3/TKAvG7zsLiQstIBmAUZAB6zTCCPPXFL7ok5D9wP0ir2uyJQnlhjM6Y9oDoHooUGJMdNRDY5X
	PNh69q2F0Fse2tl2KrgYYDNRRinRV92ZQtf4R4qpuYBfJ+FHRZoTjDPprZWFSEExvww==
X-Received: by 2002:a05:600c:12d1:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-42475183abcmr50829125e9.21.1718955829951;
        Fri, 21 Jun 2024 00:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGFhPCh+f56fSUHi3uGdtrIekqv4PyB9COw2ZzQozbPAmaFpHnj4r7upN+wLk//8erbglA0Q==
X-Received: by 2002:a05:600c:12d1:b0:420:173f:e1e9 with SMTP id 5b1f17b1804b1-42475183abcmr50828995e9.21.1718955829516;
        Fri, 21 Jun 2024 00:43:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63d4sm52393385e9.3.2024.06.21.00.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:43:49 -0700 (PDT)
Message-ID: <96df0073-6fde-4252-a9cb-22eeb0a876bb@redhat.com>
Date: Fri, 21 Jun 2024 09:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Elliot Berman
 <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com
References: <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com> <20240620231133.GN2494510@nvidia.com>
 <ZnTBGCeSN1u6wzLb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZnTBGCeSN1u6wzLb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 01:54, Sean Christopherson wrote:
> On Thu, Jun 20, 2024, Jason Gunthorpe wrote:
>> On Thu, Jun 20, 2024 at 01:30:29PM -0700, Sean Christopherson wrote:
>>> I.e. except for blatant bugs, e.g. use-after-free, we need to be able to guarantee
>>> with 100% accuracy that there are no outstanding mappings when converting a page
>>> from shared=>private.  Crossing our fingers and hoping that short-term GUP will
>>> have gone away isn't enough.
>>
>> To be clear it is not crossing fingers. If the page refcount is 0 then
>> there are no references to that memory anywhere at all. It is 100%
>> certain.
>>
>> It may take time to reach zero, but when it does it is safe.
> 
> Yeah, we're on the same page, I just didn't catch the implicit (or maybe it was
> explicitly stated earlier) "wait for the refcount to hit zero" part that David
> already clarified.
>   
>> Many things rely on this property, including FSDAX.
>>
>>> For non-CoCo VMs, I expect we'll want to be much more permissive, but I think
>>> they'll be a complete non-issue because there is no shared vs. private to worry
>>> about.  We can simply allow any and all userspace mappings for guest_memfd that is
>>> attached to a "regular" VM, because a misbehaving userspace only loses whatever
>>> hardening (or other benefits) was being provided by using guest_memfd.  I.e. the
>>> kernel and system at-large isn't at risk.
>>
>> It does seem to me like guest_memfd should really focus on the private
>> aspect.

We'll likely have to enter that domain for clean huge page support 
and/or pKVM here either way.

Likely the future will see a mixture of things: some will use 
guest_memfd only for the "private" parts and anon/shmem for the "shared" 
parts, others will use guest_memfd for both.

>>
>> If we need normal memfd enhancements of some kind to work better with
>> KVM then that may be a better option than turning guest_memfd into
>> memfd.
> 
> Heh, and then we'd end up turning memfd into guest_memfd.  As I see it, being
> able to safely map TDX/SNP/pKVM private memory is a happy side effect that is
> possible because guest_memfd isn't subordinate to the primary MMU, but private
> memory isn't the core idenity of guest_memfd.

Right.

> 
> The thing that makes guest_memfd tick is that it's guest-first, i.e. allows mapping
> memory into the guest with more permissions/capabilities than the host.  E.g. access
> to private memory, hugepage mappings when the host is forced to use small pages,
> RWX mappings when the host is limited to RO, etc.
> 
> We could do a subset of those for memfd, but I don't see the point, assuming we
> allow mmap() on shared guest_memfd memory.  Solving mmap() for VMs that do
> private<=>shared conversions is the hard problem to solve.  Once that's done,
> we'll get support for regular VMs along with the other benefits of guest_memfd
> for free (or very close to free).

I suspect there would be pushback from Hugh trying to teach memfd things 
it really shouldn't be doing.

I once shared the idea of having a guest_memfd+memfd pair (managed by 
KVM or whatever more genric virt infrastructure), whereby we could move 
folios back and forth and only the memfd pages can be mapped and 
consequently pinned. Of course, we could only move full folios, which 
implies some kind of option b) for handling larger memory chunks 
(gigantic pages).

But I'm not sure if that is really required and it wouldn't be just 
easier to let the guest_memfd be mapped but only shared pages are handed 
out.

-- 
Cheers,

David / dhildenb


