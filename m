Return-Path: <linux-kselftest+bounces-35216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A6ADD100
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D813188CB76
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD852E8894;
	Tue, 17 Jun 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry/r1+nq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BE20C001
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172859; cv=none; b=gAxbkmlUs9MoDQ3o0rsIKEKcrDFUh9l+sryhDVf7NBM4zdJ4J/ct7o/hzIqHXrSLY8vceI3T2aD3cJSGnrvJtQOUWYxOXpxITr+QcL73S4TNbVbLjtBmUGuMPADD1oHumgZyqNWFXQWAFjhGeLg4ON9haP+mgIyFOcbTPJLrxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172859; c=relaxed/simple;
	bh=pf3mbNNCBaoa+Q8rkyFdnWm1f//ZilqgGf8nwGrFL50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VinV8XoSDh/Gi1i6NQTBx3g+A8DHt2bARF9yySdrAsBZqvZuLs5ojfTl7+7Bql6B8pSUK6ziuOlxb62M0+SAMvlapW9SqTCEX/m6LZ9/lKjPCdLQQ7Sfa9bvb9ycoKhg1Bak2v5XA/cyEwXCKBFrIXGshNiYeB3D8m2jgUrasrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry/r1+nq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so33088055e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750172855; x=1750777655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILCJmIUaqb1ZxYNljoCiDSpEgRAkdZcWul2gnHHS/uI=;
        b=Ry/r1+nqtYhFYjET2QNPM+jFZ2M3klU41N2rEBOX6Nab9gdsoOCQ9cHeo3gW4Snm2f
         N0jQrtv/y/DNMyLmUw6LdiLG2wMAkPUwOeVeY5MStpiWqae1JLz0JRugS7zgiVVnChUu
         +nfoeGOmgSWWOJ36zRiYhfhIx2e1dFZiWYgRiJKPWl1UmXF9yEY4HJeW/AJkcDsOIe7W
         fBLfjf1xLzgF/vdmesx3WcEq4rp9nOrcZIUWI6eWv50W5V1sWtGgv+jatJmodTLoaVC0
         9b4LYDGQn47p4134GVoR1CdEaCExHgqcoEKZ2vexU3r3GaJUCd+pA398K6hxOi+bjacn
         wnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750172855; x=1750777655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCJmIUaqb1ZxYNljoCiDSpEgRAkdZcWul2gnHHS/uI=;
        b=TJo4TAm+Nd+EQEHpO8UYWSw7g01xytKCUdgrXBlgCK3puknr/BwujnwWCAgBJKVCRP
         cY5zxZuyfwQpF9O/fQurpcESKE/bkHPZQqpkwvdzmKvkYcFQQ7P/UdIxUPi7IwAS4QVd
         iJPjF173yqEkAOX5BejTefXvJCbVRjBW6bonEeXfJIpnefJWCAeEuZkq5AtTWabUavvC
         IKUnHSC8ptlk8ek/dy/FjYDx1QtkIzLu7Wa16EsWj5CA+y9VC+gbdFtmleOjMRlo9r9P
         uNAGLzpcZ8Mlc1ajORHPdFO6FSI5S8L1fqPf6Ec1tvl7az2GDiqHV22UU+o4A7QXfk4n
         EVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdI5bBLGrR6UqD+XLbU5PfnS275V1JfnzwHgsEwwACCpznnRfh2RB7jJrhheajGxG88QiEqJbtW458bJK3V8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC55TwWdcqBsHcYjf83J31I1alpHMjQLUFKP76Mz74Y6h4L9+D
	8dUmOn1zI6BZfyIKdkgriyP1ZLoEHpYVx3eUNuzUYNTCS9+vCEif8enQeKPaubx5JJE=
X-Gm-Gg: ASbGncsmyZumwP0oerFgSS2uk8pPwFkd8J/m3mTK0VfP9m7lzdnoOFWCMzDRAsuWQ7d
	+52Pag/Bz/eSLHTwsz7o3Xm4ExqEEbTyCe+BDIR4X37qXg+s6YfMLaJUm5VZ/9QdcJYzvEqhey3
	SenjjFw2YIJl5kHmcpSQUlrQVCByQASObowBP1vxpR/ogLwJRqWjj6KdVYCzs1DJQGW4q3hwSAu
	G1gtYrCSNDrgfVZ8aNNK3zhzmZt8/nByTTx7kxwChf2UK7uPmCkwzXtE+EHCeZJQgSubl0Ra7NE
	V5VMriXm7GQS2OExPBtJ8vDCrtS5lPCR3d9owEk8VgulYVLvYGCjCzNsFd8TlCEqwxZ/IsHa1XI
	X
X-Google-Smtp-Source: AGHT+IFvJAhymz+MlrW7YQcbajgL5kYk/RtK6I3q6YaocDMYQM4Sy3QB0kS30GlFXiWwssZmFhkdPg==
X-Received: by 2002:a05:600c:a07:b0:453:99f:b1b0 with SMTP id 5b1f17b1804b1-4533caa5c1fmr112862035e9.20.1750172854807;
        Tue, 17 Jun 2025 08:07:34 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1cc5sm183871865e9.16.2025.06.17.08.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:07:34 -0700 (PDT)
Message-ID: <1f175340-d109-41c2-be1e-1c5261f9e0d9@suse.com>
Date: Tue, 17 Jun 2025 17:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
 <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>
 <20250617095936-50d985a4-ea18-49cf-9d16-dfd0dd0b627f@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250617095936-50d985a4-ea18-49cf-9d16-dfd0dd0b627f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/17/25 10:39 AM, Thomas Weißschuh wrote:
> On Tue, Jun 17, 2025 at 09:44:49AM +0200, Petr Pavlu wrote:
>> On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
>>> The function stubs exposed by module.h allow the code to compile properly
>>> without the ifdeffery. The generated object code stays the same, as the
>>> compiler can optimize away all the dead code.
>>> As the code is still typechecked developer errors can be detected faster.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>
>> I'm worried that patches #2 and #3 make the code harder to understand
>> because they hide what is compiled and when.
>>
>> Normally, '#ifdef CONFIG_XYZ' or IS_ENABLED(CONFIG_XYZ) directly
>> surrounds functionality that should be conditional. This makes it clear
>> what is used and when.
> 
> #ifdef is discouraged in C files and IS_ENABLED(CONFIG_MODULES) does not work
> (here) without patch #2.
> 
>> The patches obscure whether, for instance, kunit_module_notify() in
>> lib/kunit/test.c is actually used and present in the resulting binary
>> behind several steps. Understanding its usage requires tracing the code
>> from kunit_module_notify() to the definition of kunit_mod_nb, then to
>> the register_module_notifier() call, and finally depends on an ifdef in
>> another file, include/linux/module.h.
> 
> I agree that it is not completely clear what will end up in the binary.
> On the other hand we can program the happy path and the compiler will take care
> of all the corner cases.
> We could add an "if (IS_ENABLED(CONFIG_MODULES))" which does not really change
> anything but would be clearer to read.
> 
>> Is this really better? Are there places where this pattern is already
>> used? Does it actually help in practice, considering that CONFIG_MODULES
>> is enabled in most cases?
> 
> This came up for me when refactoring some KUnit internal code.
> I used "kunit.py run" (which uses CONFIG_MODULES=n) to test my changes.
> But some callers of changed functions were not updated and this wasn't reported.

I see.

> 
> The stub functions are a standard pattern and already implemented by module.h.

Stub functions are ok, I have no concerns about that pattern.

> I have not found a header which hides structure definitions.

It seems you're right. I think that makes patch #2 acceptable, it is
consistent with other kernel code.

> 
> Documentation/process/coding-style.rst:
> 
> 	21) Conditional Compilation
> 	---------------------------
> 
> 	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> 	files; doing so makes code harder to read and logic harder to follow.  Instead,
> 	use such conditionals in a header file defining functions for use in those .c
> 	files, providing no-op stub versions in the #else case, and then call those
> 	functions unconditionally from .c files.  The compiler will avoid generating
> 	any code for the stub calls, producing identical results, but the logic will
> 	remain easy to follow.
> 
> I should add the documentation reference to patch #2.

This part discusses stub functions. I feel patch #3 stretches the
intention of the coding style described here. As discussed, the patch
somewhat hides when the functions are actually used, which might not be
desirable, but I'll leave it to the kunit folks to decide what they
prefer.

-- 
Thanks,
Petr

