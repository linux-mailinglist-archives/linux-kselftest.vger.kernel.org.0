Return-Path: <linux-kselftest+bounces-17121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D657B96BC54
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064151C2272E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C651D88D0;
	Wed,  4 Sep 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hS99z/vR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDA1D0963
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453013; cv=none; b=qwssOkbiNQIZhrsNcnDgSsxAp4YElP0gj98eQUlNQvS3h4ubo0+Bw2+RX6my3v/S2iPfAKkbJL/6mXdXMaOZsnHYfo5Y++olXKpWo78Z3mVe7RIR7hVyoZihkYSJmWV9lg4eD7yRqUhpH7Hmzx01VWCTt+jZ9OTpLTOfSLIv3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453013; c=relaxed/simple;
	bh=S8tp7lkb8GGDlX4xOw5IoF2rv0WHcmF6JVJUfHNHjtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdpZhD5jY/la6RmxJmmMsgynBuQot5kPlDbhxQ6oCquRsoT4LVuhcnwUwsl9K3ogQPnRDlDH4m6y3ps1tbZ+wlOmX2P7j5XP+faq8KxknEgh7zftN2blngKYZvRxSaSmNGG6O0qVJNN3dEe7PhcBd6bgnc50YFGBqimMl+U+mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hS99z/vR; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a151ac935so246947339f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725453010; x=1726057810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usEPQSwhAatU/XjCvKnSXWVbPmOpMNa/s55C3sVgfW8=;
        b=hS99z/vRwDDjMtRBiH/bn0aUnBRG2nAvAjEDGF6KxPMHxf8mzRZZU4yL33gm/oY+1K
         55NjSDnPN/i8Dqzjh6Upv43TQjsMaFUKuKphnn3rA7MePDgV82TKAMOu2LhV1m0ddPfe
         JvMCgVwZTS6MGZjfscuVzWmaSS1zCM6lehetc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725453010; x=1726057810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usEPQSwhAatU/XjCvKnSXWVbPmOpMNa/s55C3sVgfW8=;
        b=O67Kyf8VTJnHwqOgQNOZKzNRjGYX/m+MlOh4ZO0qKechDPNuOG+9b8Q3gyMDumWj2s
         g9aliBCbB6WHrYETACAs4Rqc0q1RNLqmzy1EGau0lBX+31axsNhDKhExXWt072oUz/R8
         EiC6s0kJMOvR4E0guWlbWK335Q3QV1NjtNork27IyDyaQEHj+wyKX9mZrFCAoXncfccQ
         +9MQVH6O7OdUQpI46ui/0+nuo8mC5l1pEvh8cPO+JZ3WP6GsQcsIiKCcxDLl7W3Byv5O
         1QmpGnp+Rvv1AnS+OnjuAPUOAWNCoxyuG1bLXaO3FyicER6xtx/TuCAHkSy5xl0zYmOt
         2F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUlrxiXWOP3QDXDIjTjq4RxmQde044kLigt4vXgsZCs+OiIK8A/Gq/LBm5xCsXUKx6HV3pLxfOjxbZmJO9+00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoWfOU0m0z62lV7S5FWjtvNKy1AZ3P+Nw+qWuvuWbJBJoNJmg
	8MYJzXM3T1q17mjY0U8nKWnAcft4tVprU2Crzggg3I1kef+fo+iUeZTk6v22XA8=
X-Google-Smtp-Source: AGHT+IErkaekMAoEqD8vy7bFOcNN9vzjjNJyAMe/MvYvOZaErtNhirWL/LMC/nL98LpJNUXyA+R53w==
X-Received: by 2002:a05:6602:1647:b0:827:a979:87e4 with SMTP id ca18e2360f4ac-82a3751d83fmr1743483439f.10.1725453010160;
        Wed, 04 Sep 2024 05:30:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a5d0f80sm353176139f.54.2024.09.04.05.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 05:30:09 -0700 (PDT)
Message-ID: <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
Date: Wed, 4 Sep 2024 06:30:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Reinette Chatre
 <reinette.chatre@intel.com>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu
 <fenghua.yu@intel.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
 <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
 <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 06:18, Ilpo Järvinen wrote:
> On Tue, 3 Sep 2024, Shuah Khan wrote:
> 
>> On 9/3/24 08:45, Ilpo Järvinen wrote:
>>> This series first generalizes resctrl selftest non-contiguous CAT check
>>> to not assume non-AMD vendor implies Intel. Second, it improves
>>> selftests such that the use of __cpuid_count() does not lead into a
>>> build failure (happens at least on ARM).
>>>
>>> While ARM does not currently support resctrl features, there's an
>>> ongoing work to enable resctrl support also for it on the kernel side.
>>> In any case, a common header such as kselftest.h should have a proper
>>> fallback in place for what it provides, thus it seems justified to fix
>>> this common level problem on the common level rather than e.g.
>>> disabling build for resctrl selftest for archs lacking resctrl support.
>>>
>>> I've dropped reviewed and tested by tags from the last patch in v3 due
>>> to major changes into the makefile logic. So it would be helpful if
>>> Muhammad could retest with this version.
>>>
>>> Acquiring ARCH in lib.mk will likely allow some cleanup into some
>>> subdirectory makefiles but that is left as future work because this
>>> series focuses in fixing cpuid/build.
>>
>>>
>>> v4:
>>> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>>>     (would cause __cpuid_count() related build fail otherwise)
>>>
>> I don't like the way this patch series is mushrooming. I am not
>> convinced that changes to lib.mk and x86 Makefile are necessary.
> 
> I didn't like it either what I found from the various makefiles. I think
> there are many things done which conflict with what lib.mk seems to try to
> do.
> 

Some of it by desig. lib.mk offers framework for common things. There
are provisions to override like in the case of x86, powerpc. lib.mk
tries to be flexible as well.

> I tried to ask in the first submission what test I should use in the
> header file as I'm not very familiar with how arch specific is done in
> userspace in the first place nor how it should be done within kselftest
> framework.
> 

Thoughts on cpuid:

- It is x86 specific. Moving this to kselftest.h was done to avoid
   duplicate. However now we are running into arm64/arm compile
   errors due to this which need addressing one way or the other.

I have some ideas on how to solve this - but I need answers to
the following questions.

This is a question for you and Usama.

- Does resctrl run on arm64/arm and what's the output?
- Can all other tests in resctrl other tests except
   noncont_cat_run_test?
- If so send me the output.

thanks,
-- Shuah

