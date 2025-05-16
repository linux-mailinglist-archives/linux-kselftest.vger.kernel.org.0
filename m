Return-Path: <linux-kselftest+bounces-33176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE5AB9CB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28AB1B61022
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695A23C507;
	Fri, 16 May 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrOqPRxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A21DFDE
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400131; cv=none; b=s8+YR/OIEKDOAWU1iRpLD7yEnze3Yqht4JIcXbPKowztSuC9fN/UJG5Zz5846ftXjmFxNJIfw4w/pZb/2HQ+rnwgmtdbBu+pwPC/6kCGmmh3t/IdycTu+pUkmXCRZDdzyvq5zCH0xDcriUM6t5TfuR2kpife7C4P/l7tguMvWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400131; c=relaxed/simple;
	bh=bZzWGMDYDzVegdcHFicDYJ1jOFP1bsLQ9Gud/BDvN34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGKMiuFcCx6FcFyktoa+dknxKl4DR4/5FMWCXLcx3S71mAdKvXxPRVc3q7bpb4jrjrTgiNb/51KPoLgsJK367rNv1Nt1e+L3PmhTyLJttSo7d9Q/JobXps8gibck8RckKrUOrshrKK69SA9A/V1qkSPT7r+lVc0uf4X2fB5R5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrOqPRxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747400129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PF4o05Qile29JrPKngFz8A7PCJwee70N2MJa6OzBXtQ=;
	b=SrOqPRxsmfFIQVEQcpt7+digDXdiIhNcl4O9Rv4IRBdysTx+wya+tRmKki5YgL8PX+WXcp
	S2Vzn43n/Cq9W5HBFUKU0OB7+1nwZ/No8shnNl8/Y6vOoL26LvPFFxV1E+GwKHpJmmTTrl
	LZiybTZMQwUdfNfIwjUbEIlyDs9dvCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-XZAipYllMtyjInw9qsQWhg-1; Fri, 16 May 2025 08:55:27 -0400
X-MC-Unique: XZAipYllMtyjInw9qsQWhg-1
X-Mimecast-MFC-AGG-ID: XZAipYllMtyjInw9qsQWhg_1747400127
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so11317815e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 05:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747400126; x=1748004926;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PF4o05Qile29JrPKngFz8A7PCJwee70N2MJa6OzBXtQ=;
        b=LywLWVAyQup6FYRoFOq5aNAsDaS/grM2O2XdQ/YhycBtFGZgXNXVkA7htvN1g09SXr
         X4QHi0yMolly7v6buLlp+VcFSr596N8K7aszgGihw7zVhBNtpkqBBTLz/9Pz+D1/d31B
         qhCHa9UjgrS+dqv6SQcevPnZU8zxRTqjuz7VgdbqE1y9TYrwVXrxTPD5UN/rmTFYFEye
         3Zn9hNURuIeXUpVxsHYtcb+byliDauP+6UPQKEhqwZQdzy/ZNoDiWSQO8xt20dsiynf/
         Fm5qEPFDMueKqhKGb8K8ZwMli6JnxsiswvBaMHsEChu6cFoQOGOFl5Odvl3OEg0wK3/E
         EMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcih1pd/8HYCGiNGVN4fcIJMF++Fbk1St2f9XvB76pzmoWQg8NCc9deaMiqjUTXDZVmVZslRub2IKgyknonno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKAdzjbJ4lyme7W2sq1jlAQ2I78dMUprmma8r/07Ryeem3NTi
	xioSfM/PjRj976VuocZB357Lw2BdXoEyyZrCnhQ0xCi7sMM7aeSasNfXY/pFTnljwrrKLupVSdg
	0DRD+D/RsbVamo4aTRDhaDfsxgXTicHOmvDfuTrO5kWy3BqF1CqTblvzavnDgtUnkIBhhpA==
X-Gm-Gg: ASbGncsOhNPkFggNvruILjHYChxnFMT+vbT3FihCrNiwfeKx6RVMfvu2d5Z967Occj7
	UN9aYePzC8lU3wkKPKqegW/hshxF4OZMnilc6zdanKB8P1Z7Ik6zePrpgeIfvWW7onchdyQHed2
	gaI1bxRFbYeTgDrNrr/R6KyyTEKb7p4hFl6Q6cuthpCcUg/fVpJogS5hTDQrdH8WCQLZTUpBusR
	CA2VlUxp7QiHzxgddflCgQMIl9TTll8b8Nm0DXi1QTYVih0daNAWcVlQJeSZZ+L1Zx2FKSnXztf
	hqP/koD5gZmKe62FaGWJF5qjWU7OmharfxPe7oYQJOh+oTVEBeUEfQUBc5c5xLsviIMvhNb57jL
	CSz309BrY3Yg35j8qwk+x1kJLGO2zu0B9rbH4Kro=
X-Received: by 2002:a05:6000:1a85:b0:3a3:4ba9:67cc with SMTP id ffacd0b85a97d-3a35c825f6dmr3791639f8f.33.1747400126561;
        Fri, 16 May 2025 05:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxmqyrl2Rmv5n5lMbM8yWmXcj+ByZHNn8K0w0aCt6HfAzzFOdJD39SfyvM80IH0dNAiN28qQ==
X-Received: by 2002:a05:6000:1a85:b0:3a3:4ba9:67cc with SMTP id ffacd0b85a97d-3a35c825f6dmr3791627f8f.33.1747400126137;
        Fri, 16 May 2025 05:55:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5aba3sm2745916f8f.40.2025.05.16.05.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:55:24 -0700 (PDT)
Message-ID: <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
Date: Fri, 16 May 2025 14:55:24 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 14:29, Mark Brown wrote:
> On Fri, May 16, 2025 at 10:02:16AM +0200, David Hildenbrand wrote:
>> On 15.05.25 10:57, Mark Brown wrote:
> 
>>> The kselftest framework uses the string logged when a test result is
>>> reported as the unique identifier for a test, using it to track test
>>> results between runs. The gup_longterm test completely fails to follow
>>> this pattern, it runs a single test function repeatedly with various
>>> parameters but each result report is a string logging an error message
>>> which is fixed between runs.
> 
>> As the person who wrote that test (that you apparently didn't CC for some
> 
> I just CCed whoever get_maintainers told me to CC for the patch.

For the future, it's a good idea to look for the author of the 
problematic bits.

> 
>> reason), what exactly is the problem with that?
> 
>> We run tests. If all pass, we're happy, if one fails, we investigate.
> 
> None of the tooling is able to either distinguish between the multiple
> tests that are being run in gup_longterm, nor compare the results of
> multiple runs effectively.  If all the tests run they report themselves
> as being duplicates of the same test name, if one of them starts failing
> the effect is that one of the duplicates disappears and we get an
> entirely new test that's never passed reported.  If multiple tests fail
> it's even worse.  This means that UIs displaying test results end up
> reporting things unclearly (Was there a regression or was a new test
> that never worked added?  What was the test?).  Since it's difficult
> to track the tests between runs tooling that does reporting of things
> like "This last worked in X" in the UI doesn't work properly, and tool
> driven bisection of issues similarly struggles since it can't tell
> what's going on with any of the tests between runs.

Okay, so this is purely to make tooling happy. Humans are smart enough 
to figure it out.


What mechanism do we have in place to reliably prevent that from 
happening? And is this at least documented somewhere ("unique identifier 
for a test")>

I guess when using kselftest_harness, we get a single identifier per 
tests (and much less output) just automatically.

 > > Basically, the output is garbled and vastly less useful for people
> running this as a matter of routine or as part of a broader kselftest
> run.  For example with my own automation I probably won't notice that a
> previously working test failed unless every single test fails, and newly
> added tests that never worked are a much lower priority to the point
> where I may never look at them depending on where they are.
> 
> If a selftest is reporting multiple tests it should report them with
> names that are stable and unique.

I'm afraid we have other such tests that report duplicate conditions. 
cow.c is likely another candidate (written by me ;) ).

Probably, the affected tests should be converted to use 
kselftest_harness, where we just report the result for a single tests, 
and not the individual assertions.

That would reduce the output of these tests drastically as well.

So that is likely the way to clean this up properly and make tooling happy?

-- 
Cheers,

David / dhildenb


