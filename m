Return-Path: <linux-kselftest+bounces-18900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26B98D7C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D83A1C21EA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47911D043E;
	Wed,  2 Oct 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4v5w9e9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4329CE7;
	Wed,  2 Oct 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877173; cv=none; b=JxTzGnpwUlZRGOn9q3N/3WQNxbI3rn3B7oKneJOKeE7zd4V4mRCx5iPQLbZ48SpRYAcEeSj4YBp72LaHGNdXtOwZI+VV+TO+PkMegHBjEzlMAB6i+MFkrAoT99p83QmTZutzjwXTwO+OEi/A4vKGWt5v4V9n/V0vN6wwTmXG610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877173; c=relaxed/simple;
	bh=QWG2oMZSKK/EHyYp3T9/GL6XS4WciUGdzokAMrW7hYs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Umfw1o5cJv+UNqpPQ7TjFYMVRkXiGFruRmkoSCpKCRjji/tPTErX3Itdcsy7a3WNsoOEB6Cq52Szgizi4wCZCIDzD66u3fYPJuxHJsCFdtpQNb0jlZkNLvC/WcbLKS0nLOFB+AmXoV4V0SSlx/wU4FiD4m4rUVJ4z1Th1fv3JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4v5w9e9; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e033e66a31so4130569b6e.0;
        Wed, 02 Oct 2024 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877171; x=1728481971; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYhYS2mO6Eb7fOP56sjDXSwsQEVfFIT6TLidIyZGpoE=;
        b=F4v5w9e9PJ/cN3TGPK4D6JFu5Ge5zeGrQp1FbQfcoeW4ADN64S+01/BN9YeqchcjRz
         wzFPDl8DPQR1XlL5/ja4nSHGfwV/BlZsGak8sGT3Dxm5tddn9wnoQFCn7tGKBuIOCMID
         JsS1J8Cta4b5eoQy5KBvwrFdVdEYKNTwx8Mm8pd9YgvWQpLwgAt5MGevVmX/xcYO5Suw
         CQwL4rRVZ4ARr/y27YqEuKrgaKzNDJfMHPCdenRYuZgEMeyn2SVfoA11E1W0zPWI81v+
         gQUPcLmZvFRaUakZAyI2P2WNINeXRU2he3NK7/b9KfYT8nJ67OQejjOKgw60ZB4BsUcV
         dcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877171; x=1728481971;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYhYS2mO6Eb7fOP56sjDXSwsQEVfFIT6TLidIyZGpoE=;
        b=mFY421TP9VG3Dukxs70qg/tm1+bd9dU3QW668F7iD+LJ2uwLsRjMAypo8hmy72Hmp5
         3Nh0CcO/wR4vVD+5cXWR1vwMEpK6TMeWrEbc2br8IzBN/XC90IHz6ksdJbYm/AaTeA97
         x4/BaEhTuidsjk/tvFaaNWzbkvXshNQ8yhIKis2RQIh8V1DIErxqV5ZSMs1l/dXgFFdd
         fdB9ycUtWu9zv7TGSaCBgN6+z+FXxadH0X60i08RLk3Sy7CyL+R93FYTKHUWOlxdJccN
         LUv/AkMruMx3LQkVfwlVaeqRXawFTTE3o/PKTsk+fTbb/euAkdiKV1bHmTTQ+r017p/N
         W3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkKa2s0kIxIk3/C+wgpYWZHBxSvtRqwO/iuu2Zgci4H8rWsVIitByiBcgfHmfKfJaTKZE3GFgNMYfudOg=@vger.kernel.org, AJvYcCUrn2AC35s8Q6xZAcplxStnuyQw7vmNjXn+UC2fo+s/NfAkSZzsMH6cYV34XSgGjofy941D4do/lxVhZBK5WW07@vger.kernel.org, AJvYcCXH1SK1RzmUaOu2guA/X33XBJAp+eFYaYmewzGTp7tA99gzFcaRfjOSZzFm7jHbMKhABWcR@vger.kernel.org
X-Gm-Message-State: AOJu0YwryOuKAwF3r/b/d8jQCgN1Zwhv2YKqUTVhE4D08uxyxrwNkuEC
	pnaZbNkngthQDi2NdbrWv/F8HsvJLx56Jbh6zhLiB6XqsB78t7Ei
X-Google-Smtp-Source: AGHT+IGotTr0KtwobEKqfAI47Z8jShb0d6RpGkgX2LwCYdbTe1yUKDwAfIHVgPoY+tLXhIoZDwG5lQ==
X-Received: by 2002:a05:6808:1a26:b0:3e0:4e8e:aa2b with SMTP id 5614622812f47-3e3b40ff0ddmr2762938b6e.11.1727877171031;
        Wed, 02 Oct 2024 06:52:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db610fd3sm10116575a12.82.2024.10.02.06.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:52:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Type: multipart/mixed; boundary="------------pTh8JCwDZm0XtF0xsDgn7zyM"
Message-ID: <87f2fe09-ba6a-4405-b716-5325bb6a223b@roeck-us.net>
Date: Wed, 2 Oct 2024 06:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes v2 2/2] slub/kunit: skip test_kfree_rcu when
 the slub kunit test is built-in
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 rcu@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
 <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
 <80d0cd70-c00a-475c-a028-e842fb86403b@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <80d0cd70-c00a-475c-a028-e842fb86403b@suse.cz>

This is a multi-part message in MIME format.
--------------pTh8JCwDZm0XtF0xsDgn7zyM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 03:26, Vlastimil Babka wrote:
> On 10/1/24 18:20, Vlastimil Babka wrote:
>> Guenter Roeck reports that the new slub kunit tests added by commit
>> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
>> test_leak_destroy()") cause a lockup on boot on several architectures
>> when the kunit tests are configured to be built-in and not modules.
>>
>> The test_kfree_rcu test invokes kfree_rcu() and boot sequence inspection
>> showed the runner for built-in kunit tests kunit_run_all_tests() is
>> called before setting system_state to SYSTEM_RUNNING and calling
>> rcu_end_inkernel_boot(), so this seems like a likely cause. So while I
>> was unable to reproduce the problem myself, skipping the test when the
>> slub_kunit module is built-in should avoid the issue.
>>
>> An alternative fix that was moving the call to kunit_run_all_tests() a
>> bit later in the boot was tried, but has broken tests with functions
>> marked as __init due to free_initmem() already being done.
>>
>> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
> 
> I hope you can confirm it helps, because the commit added two tests and I've
> only skipped one of them, as it's the one using kfree_rcu(), which is
> suspected. But the other is responsible for the (now suppressed)
> kmem_cache_destroy() warning, and maybe I'm missing something and it was
> actually that one causing the lockups.
> 

Everything works with your patches applied, so we are good.

> Since you mentioned the boot lockups happened on some x86_64 too, do you
> have a .config of the lockup case? I've tried tweaking some rcu options but
> still nothing.
> 

I have a bunch of debug options enabled. Configuration (generated using
"make savedefconfig") for x86_64 is attached.

Thanks,
Guenter

--------------pTh8JCwDZm0XtF0xsDgn7zyM
Content-Type: application/gzip; name="defconfig.gz"
Content-Disposition: attachment; filename="defconfig.gz"
Content-Transfer-Encoding: base64

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
t1cez7FznEzbS0JzbmH3Z/I/rqxbkNEnAAA=

--------------pTh8JCwDZm0XtF0xsDgn7zyM--

