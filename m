Return-Path: <linux-kselftest+bounces-10834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA938D3791
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B93C2875DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA9125C0;
	Wed, 29 May 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7oxhbXM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF911CAB;
	Wed, 29 May 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989278; cv=none; b=laZLLRZeyFH0+qmkqk1CLe1bcSLwIQmtQgVoNzJzewMIz6aFdZh0iEH7y5Fw2e0vN91pnvY5mTvUcdnGlijM7XRMrj6aLhMsock0gzg+R3mNR12PduiS2PkEcl8xypVfoSzQNzOkaZzxWLhbx98hHK2dbNqUSVCYvOlsOT0SI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989278; c=relaxed/simple;
	bh=q/QcWkL0UB/TfKnBBxD16bQnT3JzTfVI78kmbn9Sk7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGQcR/bcedAvHSXfDVQs8GBGPX9WcRialhPE8d96yUIQHSdlKlsFG5+R/GNFo0k3fXMZOYyVmrEq0VP4FpA+PUGxplGBI0rca6tXUknLUrH3lXA8pMwmTaTBh9Q0vYgDw+WYwf0ucXzTNwVflB+6uYZEGmGnciWrmwcL05rcu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7oxhbXM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4211fb904a8so2870555e9.2;
        Wed, 29 May 2024 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989275; x=1717594075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TH9AZVvcxUJR/4QUCNHDouLCDuH+SVSmkfVCXWmBq4Q=;
        b=l7oxhbXMiL2Vl1WY3/xaCvIigZwDbMAHfL95WZ8ROh4JOQ5vmWwnxbHIkzdBEVv8s8
         S4dRuTWaHCKe9bNzDu/wU7ZvvKkyCNBCG+cCw+iNrP0scxUResY0EtAZhvudiIcZS98o
         IJMU2TC1/SzeHLEAlMiB1D/YwFClIpZ8yn+8nxoTIYLgkp9RexgKRvbsSB9Iq65n0Ix6
         v/cH3zr8M/7/H7EoRwA0artA9R74mgwHt+jTvCnBH/841xXS1YfSNjyZnenjyTf4M6+D
         eZVGg7/+4f55oqqb615kiogcweW8T0jEgjqfK++5nKR1H7STcGw5QXdn13HnEMJpLkf0
         f/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989275; x=1717594075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH9AZVvcxUJR/4QUCNHDouLCDuH+SVSmkfVCXWmBq4Q=;
        b=L6E1PvDtpwn1ChOyu97l0DinF26DANtMAy+FNWqjgC19mte5NgS8LjwNvuMyt6AeSJ
         +OKic7GivQAoY9kDno3iYgIMFjNqhfrnIDvupxj4h1Sb8xaxiPDQ8/MFBQlktYdI6agF
         ZksvpN2wn0+4R3qBzXx7bHHnUrJFS3Z+o9ARDOio2AFXZHGsHiR/BJwoMxxDVRweB6Fz
         m6iFcEIbHmLLlmfgjNJa02DnDviJLoLrlU6/bF5am4qP6JR/nTASLORUomYI2QrNKHN8
         PD5HswvULaW0mN/oRBQPvuiWQh6XNijO7NPbOverGo9zdoBX3Yqffpp5JUlyEt4y0xWH
         97Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWGg4X3WgLlxpU4pc0FVvoOgze3IWRf+NKTiFlnvr9Qc0g6NpDXV8FERoVI9QK2o6QssfguCBH/Kp/FWrgFswhgFHzVkHnkqQLW4/HX+i8RafQqCP8OUS/U89rkugRBdxfnr/pO4ViMABLfIqMU
X-Gm-Message-State: AOJu0Yy3zrIgCKU2BooupbNlRo0DqYYdj4Pf+/ddY9P3Vx4pywVq5iqf
	eWvnAv8NBp/ROsLZyKowJeek5U5mB6K2pADOtXx0rRnp/MsHc27B
X-Google-Smtp-Source: AGHT+IH/SbtgIvQhfBhQNi+oTOhxI4TBXpdbu6t7iqfcccSs7tfoKygTsnIgdKm44287Hv5UXHMOZA==
X-Received: by 2002:a05:600c:1d25:b0:419:f241:6336 with SMTP id 5b1f17b1804b1-421089f9e0bmr119003405e9.1.1716989274954;
        Wed, 29 May 2024 06:27:54 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae96bsm179889945e9.35.2024.05.29.06.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:27:54 -0700 (PDT)
Message-ID: <11b57fcc-9e30-46c8-96fc-c0d8131a7959@gmail.com>
Date: Wed, 29 May 2024 14:27:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com, skhan@linuxfoundation.org
References: <20240516211731.1635930-1-ivan.orlov0322@gmail.com>
 <CA+GJov7Az+hovuTou=c=SLiB0N9vwT8HD_GDR-h_kA+Nk=TN2w@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov7Az+hovuTou=c=SLiB0N9vwT8HD_GDR-h_kA+Nk=TN2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 22:12, Rae Moar wrote:
> On Thu, May 16, 2024 at 11:17 PM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> There are multiple assertion formatting functions in the `assert.c`
>> file, which are not covered with tests yet. Implement the KUnit test
>> for these functions.
>>
>> The test consists of 11 test cases for the following functions:
>>
>> 1) 'is_literal'
>> 2) 'is_str_literal'
>> 3) 'kunit_assert_prologue', test case for multiple assert types
>> 4) 'kunit_assert_print_msg'
>> 5) 'kunit_unary_assert_format'
>> 6) 'kunit_ptr_not_err_assert_format'
>> 7) 'kunit_binary_assert_format'
>> 8) 'kunit_binary_ptr_assert_format'
>> 9) 'kunit_binary_str_assert_format'
>> 10) 'kunit_assert_hexdump'
>> 11) 'kunit_mem_assert_format'
>>
>> The test aims at maximizing the branch coverage for the assertion
>> formatting functions.
>>
>> As you can see, it covers some of the static helper functions as
>> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
>> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
>> corresponding definitions to `assert.h`.
>>
>> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
>> how it is done for the string stream test.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Hi! This looks great to me!
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 

Hi Rae,

Thank you so much for the review and sorry for the late reply :)

-- 
Kind regards,
Ivan Orlov


