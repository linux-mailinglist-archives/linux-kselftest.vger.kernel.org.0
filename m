Return-Path: <linux-kselftest+bounces-34001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BBAC7F8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 16:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B779E584D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC91DB924;
	Thu, 29 May 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRPze3B2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837318991E;
	Thu, 29 May 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528333; cv=none; b=dSe1BR62LO7vaEoe1IEZv9DRHrpoOBaBKQ2GDJbe/lY+2v6ktrJ+stzJn8GIVHq394sHRZhsvUVoE2YEtdwOzEdKrJkmgkv6PcjWz2fB9y+XUt37eRisPVQAPfx+SuEpvnml0Vl/oR24bguNfimZAnUTO1auXtY+rgraiI9zWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528333; c=relaxed/simple;
	bh=LhuJp43UHfuJgWopEZQdZcVMhYlqjgvaLlH7RK+ujuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6zECdog6mAHBvKo76stoCTg6xidzG7D+/POGPyhwzNX2MJG0uKdWNeHxg8HwMAdKWEyOKzHiHvemAF7+t+DVop4iSfNnnpicvqov7daNsoN4Rlf7I4yd3lK05LbBR4jmsP9lRxQB+aQu5tbG9SzGXxfBhoGsL9EieQ2xldkRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRPze3B2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso761106b3a.2;
        Thu, 29 May 2025 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748528331; x=1749133131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRunouiRwWVQHZctMk1xqRA0wapXHcwDRKo88A9IWqc=;
        b=BRPze3B2fDFDJUTgMAoYXSD5RsLkmHdJ3xqEpyjuDQ2Tgk4sJL3k1sAGmbxIAX2HF+
         tovkkx3PYT3jm7kd8rfEnVtPomSLBpQqd++yy/hDIPnjWxOHgi+3x3b8Jfd4tRIUKQeQ
         lVi8Igk7JWfq/5ibryfAy8v7vuk7mUjeXgqrUTa3baSFDU1ukRm0aFgTy6hN1R6G5d57
         0E8TWKgn4/CVsh0ZJvxVml6b0Ho8Jtxv0KVxoZc4/E2PqlfrmOyGS2FSy0CotzXwCiA+
         vTAJLnlRr/YscQJwcRzj9NB/rz6MZv3zWzRZz5XBLuPdqnxOm9W1BUjuiG/3KmK2oqZ5
         l5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748528331; x=1749133131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRunouiRwWVQHZctMk1xqRA0wapXHcwDRKo88A9IWqc=;
        b=XrZYUJ4TpBltPLYcK4is0HeqvgnFxYEJF+CovYb4k/r2aZ/7XDxBcD8eFfmQ4o24fw
         bNTZj7rtSUGDBpsufYgiCF+RGg6L+VG0SCZzp4wRbsxkLDjlNYtAJeEFeVLICvDbC4dS
         CH+AjfFbQcT23Ke1+WNhcUrvf5VkEFfCzE5XPj4OAguW+zy6prtd/9F7oh13J7qxmCBS
         R9CXeyOSIklm+HVvd1eduxvxXiVHX3pk0DiFeeNRv9oNocGKapZeVnzGDLPcTQeZDIrR
         kQBjA9kWqRDS6rG5NHTXAjX/zppVrW9koj7nItpdhPDqpsRZrfPnfKnN+s97ZcEGZkfx
         DKRA==
X-Forwarded-Encrypted: i=1; AJvYcCVjaWckY5Lfz2n7EcVWzun3qImhy29NeFkxB9YhoSq1hcbcVZPrRhB3CrYt7FzYyeJ2iFwEhh5i2kCXGv8=@vger.kernel.org, AJvYcCW3Dj+oSwcktU4q73f8D4KzcccYBhtSMGjtnR46Bs+bNXiie7ZhRHh5ONovs1UPhLN3qZKssZOCrEmhB+XZjcRN@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGU/oGsWwKnwtvwqCT8dtgUhM3O9RqjyLhTWFQpACmmMIkkSW
	ydXan3pMP/N0uuqTzYLJxMRQFDb0jmSx1ehWupGfZCIxm0lsLauZpAYK
X-Gm-Gg: ASbGnct2BuVdWGKzymIhuOwkEA8xx869GXD3yOUkWJc+9i/YNsqWjTDd410tpUry1kB
	Xobcc2/1Wkt6FxkM/SvUsU8S+5B+JVglM305AD64Nq+LcV0WmUF6KGAqw2MXFnTk5pIAJ9y+tCe
	aOpBRGATXjK0dcR0z1g/mIZrP6pddY+XqHAPbbjGoMq4x1ej8QqZkxFT1u/HJtrJOcyQbZnJUIm
	KdVYDV1e3RGevjZ2QHyBl745zJ6+rnBaGmkc60IV2caLDWJnvg+QfdyFkQDJs9o48fg3SxePtgI
	yJ9lvjqhxIAhA/hTDVL7/rFBa5bMowAbdHQ4CmzRmsO49CX64VKbPj64yu2abDjXjxKlj11l2xx
	7E+qliDYevAzXP23pEy4ZqGY4t0BbPd0xcEXH6ZWe
X-Google-Smtp-Source: AGHT+IGfdfLI5yrqu3uRNs3TViw/L6x3XqNUSvANWhwkKKz496Sf8YJMkWbG86CqufgLVaRSKCX2WA==
X-Received: by 2002:a05:6a21:330b:b0:217:feb5:631d with SMTP id adf61e73a8af0-2188c360125mr32385169637.26.1748528331316;
        Thu, 29 May 2025 07:18:51 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9? ([2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe966c7sm1381268b3a.8.2025.05.29.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 07:18:50 -0700 (PDT)
Message-ID: <06e27b37-1d70-4e93-bd12-05e3222adeee@gmail.com>
Date: Thu, 29 May 2025 21:18:46 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: build net/lib dependency in all
 target
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Philip Li <philip.li@intel.com>, oliver.sang@intel.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250529070536.84491-1-minhquangbui99@gmail.com>
 <20250529103221.GN1484967@horms.kernel.org>
 <da0339d6-b6a3-44d8-8ed4-b99249fa0fd1@gmail.com>
 <20250529133424.GP1484967@horms.kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250529133424.GP1484967@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 20:34, Simon Horman wrote:
> On Thu, May 29, 2025 at 06:04:17PM +0700, Bui Quang Minh wrote:
>> On 5/29/25 17:32, Simon Horman wrote:
>>> On Thu, May 29, 2025 at 02:05:36PM +0700, Bui Quang Minh wrote:
>>>> Currently, we only build net/lib dependency in install target. This
>>>> commit moves that to all target so that net/lib is included in in-tree
>>>> build and run_tests.
>>> Hi,
>>>
>>> The above describes what is being done.
>>> I think it would be good to also describe why.
>> Hi,
>>
>> Currently, when building net related selftests, we need to
>>
>>      make install
>>
>> so that the net/lib is compiled. In case we do
>>
>>      make
>>
>> or
>>
>>      make run_tests
>>
>> the net/lib is not compiled. So I move the INSTALL_DEP_TARGETS which is
>> net/lib if the selftests is net related to all. As a result, all make/make
>> install/make run_tests will have the net/lib compiled.
> Thanks for the explanation, it is much appreciated.
>
> I think it would be good to include something along those lines
> in the commit message of the patch.
>
> Please note, that if you post a v2, before doing so you should allow 24h to
> elapse since the posting of v1.
>
> https://docs.kernel.org/process/maintainer-netdev.html

Thanks for your review and for pointing me the document.

Quang Minh.


