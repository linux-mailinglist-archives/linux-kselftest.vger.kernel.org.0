Return-Path: <linux-kselftest+bounces-33499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0758AC078E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFE43BD7DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E6280309;
	Thu, 22 May 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K094s7kF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B327BF92
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903378; cv=none; b=WqvGMAUXoGjz+4xngLQ+nyNph9vYfZuTL1oD0XilPrAN6AZpYpf8QzLTf+tD2DmQpJRjOActaaquqM9VQtJ5rxla5v2Ng2c7Cbeibk/nCNHQQQTBpiU+VrgqI7XP5TLBzcwz08NVOY95nkjl1B5jU7rmq5LkJxegcqJ/VrxP4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903378; c=relaxed/simple;
	bh=io+V+mrxK9WWXe0EXTbUgNp+2oHzLAkdNhwkoOyVEyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb/hKZBSTUtpA94RkXP82KNvxLjyh3jQeIVQBexX+m/bfBCO+bILvM9y5bjul5V7PCj180/CIEfDU/4XIAtsw+aXICNGHERgvHR5rjEL696/q3wZE80nISLpE70Few/sL9i1mCRLIMaKxu2eAyykvs21fEkr08Tbia4VqjGyaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K094s7kF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747903375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y+JhIAMtHUIDratsJJY78KupDIZPpYinM48aTm1d/JY=;
	b=K094s7kFX4vb8uaWYokdw3KVBkc3O+8C4qu/zGj8CegBcCxGiVQbb3NM4N8cOl+wuBx8Gh
	91beFB8r/CuugDCBNhJ9i+wZ4e9XEEzh/pEU0ITA/AUiMYyVm4Pe0yHIyp5ax6nmDLcP13
	KtN1ZxUwuyhR8vGlzbhYzyBnaTRmqMM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-HqkJQV9sMZOtCfPplbbHsg-1; Thu, 22 May 2025 04:42:53 -0400
X-MC-Unique: HqkJQV9sMZOtCfPplbbHsg-1
X-Mimecast-MFC-AGG-ID: HqkJQV9sMZOtCfPplbbHsg_1747903373
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a36a4c70b4so1837832f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 01:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747903373; x=1748508173;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+JhIAMtHUIDratsJJY78KupDIZPpYinM48aTm1d/JY=;
        b=Hn/GGXr9cjhobcYczj/+bvrySzM3LYDTPicZghxAQgVn+gmwE8Sq9VWhQIZgkTHd7f
         sj7oneCqoF1IgixycvmoAgkPsTjYealcQ/wC62LT+uFGLEzi/PdH4eFQU17U45bMjgXF
         ViDT+3xmcyQKRWbBmLfGeySE6pQv+UEp4lC86wxm1oDY+0ASWnnpD3Th0ZIy0z0/HVbo
         lvRco7Cdpg14iWGXt3Ggu6iBcOv3+Si5hDxN/fVLbWdThPyuv0McoD2Kg3lWwwpjlBV3
         D9o/A8L6VMt7HPYBLW9cvteP8e1+O37PwuvgXM3b6eq/U08MULbSfLoWni4XHrRac4Xf
         tdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVxGQq5nVvoz7soKHOANRnZJl0LzX2601kAussClWeXxBXV4zCYH1z4FiJlwFuHKUeMJH2j+cRr43ag5dzbCqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdxbB/HNo6pYKxMcnCG2MARCUnW4hxx2Dbcy/yOdbKPNTo6A6
	pNJmC0iDC2lSJRKpqbxKkiE3KEX++cgGleolBBVt3kxU//K3Shu0fs2vMgR4v/jjxRuo6xkQNQL
	xQjJ3FKHoh262RlP9v2NTGGVq+tztuvNAXlXQQtrSKYni1NU3j2qsAb4VlVhZBYrsf43MVg==
X-Gm-Gg: ASbGncuMzd0QZeXXyyzmBT357AeD74jsXzf1Rtj/FkcPTLzIrVjiHsnmI6QE8CH4w2g
	qu7xt+giPPkbifLUODr+x7QPaYxeiiKvYzX2AtSpDm0ATB01a4Ry7uUdQp/+jjXBcbVVNuTMBC8
	Kj4zK7m46klBo+o5R3/frVWSLrm+RE4qnVkAMefTqp4/lOz9jR9nQpXbV67/98FrEMPLx2NrZz7
	+naX8OCjXv6NAkILu1/gvIMQL+YAkgyiPPiXSVj5WRr9aq4F61dKbuWtH682Vh2WrYx41CG5LkN
	SJt08dFL2MveqACHIZwWkNlvyd2mFo1mw4s3JY3WbkedPX5jE9s=
X-Received: by 2002:a05:6000:2012:b0:3a3:4b95:a8ce with SMTP id ffacd0b85a97d-3a35fe5bb43mr19588978f8f.4.1747903372739;
        Thu, 22 May 2025 01:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz3Y59UeX0GI553areSAAultGv2dYGzLX+MDxO1ZCQLWx07jpD+bfnH7brjiXOk9VkcyUhaQ==
X-Received: by 2002:a05:6000:2012:b0:3a3:4b95:a8ce with SMTP id ffacd0b85a97d-3a35fe5bb43mr19588952f8f.4.1747903372277;
        Thu, 22 May 2025 01:42:52 -0700 (PDT)
Received: from ?IPV6:2a01:599:916:16c6:54bd:1780:84bf:8f90? ([2a01:599:916:16c6:54bd:1780:84bf:8f90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d230sm21902505f8f.4.2025.05.22.01.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:42:51 -0700 (PDT)
Message-ID: <f6cf8a99-48b0-46f7-b11b-574d1544fa24@redhat.com>
Date: Thu, 22 May 2025 10:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
 <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
 <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
 <e7cb18c4-fed3-4fa5-bb51-228f2b018ce9@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7cb18c4-fed3-4fa5-bb51-228f2b018ce9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 20:48, Mark Brown wrote:
> On Mon, May 19, 2025 at 03:28:47PM +0200, David Hildenbrand wrote:
>> On 16.05.25 20:07, Mark Brown wrote:
>>> On Fri, May 16, 2025 at 04:12:08PM +0200, David Hildenbrand wrote:
> 
>>> [Converting to kselftet_harness]
>>>>> That'd certainly work, though doing that is more surgery on the test
>>>>> than I personally have the time/enthusiasm for right now.
> 
>>>> Same over here.
> 
>>>> But probably if we touch it, we should just clean it up right away. Well,
>>>> if we decide that that is the right cleanup. (you mention something like that
>>>> in your patch description :)
> 
>>> OTOH there's something to be said for just making incremental
>>> improvements in the tests where we can, they tend not to get huge
>>> amounts of love in general which means perfect can very much be the
> 
>> I would agree if it would be a handful of small changes.
> 
>> But here we are already at
> 
>>   1 file changed, 107 insertions(+), 56 deletions(-)
> 
> So, I did have a brief poke at this which confirmed my instinct that
> blocking a fix for this (and the other similarly structured tests like
> cow) seems disproportionate.

Thanks for giving it a try.

> 
> The biggest issue is the configuration of fixtures, the harness really
> wants the set of test variants to be fixed at compile time (see the
> FIXTURE_ macros) but we're covering the dynamically discovered list of
> huge page sizes.

Yes.

Probably, one might be able to revert the logic: instead of running each 
test for each size, run each size for each test: then, the tests are 
fixed and would be covering all available sizes in a single logical test.

I agree that that really is a bigger rework. Let me take a look at your 
original patch later (fairly busy today, please poke me if I forget).

-- 
Cheers,

David / dhildenb


