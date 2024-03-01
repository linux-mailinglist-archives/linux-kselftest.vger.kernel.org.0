Return-Path: <linux-kselftest+bounces-5727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2790286E335
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF63283D5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59156F066;
	Fri,  1 Mar 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OarTwtzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6436EF0B;
	Fri,  1 Mar 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302881; cv=none; b=QDJexqvSbDCiWQn5JHEFw2iSG7ryppcMGGSRU5iwfJynyJwDNIWK03fiosBdijMb2k8XXMQe40rWYZM61W3yJHXNKQ7oqM3G5IZHbsns2R402nvOfZgvPD9MOcEKb7XtefBeyRhYicoEMrfQv1tq4kvCbfbTE44F1alJ1dxfLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302881; c=relaxed/simple;
	bh=udLEyhFlle918jMDpugSYsT1ztgbuuWE8/UQvqTOgvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcqnpAtYGWNqM38FdQ8fAje+R9jiDuIzpp8PwGi0q68Lnea34gyB1N/UcnWCv8SnoimAPVoItcOdZSQKrfuDqnDOAjM4o6cx6WsBwESOMs+1MnfQYj/ES5318MT64Xg7xhwTQJ9BwR/Khp4xu9pmLjGg+nlMdwx/bck9HrhUQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OarTwtzf; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68fb71fc886so8780966d6.3;
        Fri, 01 Mar 2024 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302879; x=1709907679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoAmmdskcDEXNaQow37B4LW3k1Xhhw94dVezbr43csY=;
        b=OarTwtzfzXszR6upx0uojY90zspHsAxHYVZI0sfEMIU3Og2z0s4pWbQUFLEs43TPCR
         Jk8QTCDsfxOir9I93NSOTtTqY1c3VKpSeKI0qh7Q9iyEFGLe/R8qj5HK1/EAH7BiIl5o
         Qx9MTLU45FxvXN38w0KAodO8GrR5PzGI9zYsGHRNU3ChlABd00Zj4Q1rRpjyI6hSjTyE
         4RE0pk0aRlGYelx1NsB04y5wVa7CVwmKoxz2iYy9Iw6QaW5qJGuNt/fhxg+FpVSPkXCO
         Wcr5Dp2mR0mmpakf1MauhKtQsf9qvLBwiAPXjB29dh051+1neZD1yd1PAUbRoYXSt+xn
         LrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302879; x=1709907679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoAmmdskcDEXNaQow37B4LW3k1Xhhw94dVezbr43csY=;
        b=xGJ4VVaA9091+bxWC+eY2ggbQ3W+FwU2MhQBJiMR9nZO6Z/gvm58AHgD5cpQDpZbrC
         UXuGFlNV3NRAwQKiI37bZ7ddTZo8oyn61bBM0pexr5O1kXbTpT6bNqDbAYgJsXUXY+Xr
         FE7DBjUNFcavqFJQP0RsXW4fD6KJkDi70+RYwc624f4PZeQjM9V5F6SWGwi1NJMlsdlb
         N3MQKEzDxiESeUP9LN2HCUbIZ1mIT9aTS81GhM6LD3Ea64bO9LTN/Pm5rRt0ljV/T5o9
         jY4N0X2ko+Vf2XL02GoFjSMLQHpLjzGPQ827Q/szXxV8Jc3n9LiKqpl8cVED+aIgTLRW
         QaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUAQ4OiFJbCJ4ZR3HSYJNgq+wHdpmjsh3qQS6vKXELnKwnisbXWxELoy4KLkL028PWNAzRF1x4UoCj/FTEhbBVgAdoOxrASdI0r0zBr103N2j7G3QeXT9aTdQ39iSADYxLxpDusqoNHGisYu8MkIJecCnhBBlCLlu3gtf597YZOSGJadJlyN/b
X-Gm-Message-State: AOJu0YzpcNiytE9LpRRTSuJ90Inf3WTXIz/uAqPCUsKZXlgIqshRfzWx
	f0k2JDNtvB94h5rkrhX3jgkgtioZZMWnDclfm8icV2EPfXkAREIX
X-Google-Smtp-Source: AGHT+IGUka20RbGSTdt31weLyZD5CrTDkIoL5pB4A7Y1ldsaQGmBLLgCExV8/nV3WHdz4i56V+bA9Q==
X-Received: by 2002:ad4:44a7:0:b0:68f:3dbd:466f with SMTP id n7-20020ad444a7000000b0068f3dbd466fmr1814520qvt.39.1709302879223;
        Fri, 01 Mar 2024 06:21:19 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id em19-20020ad44f93000000b0068fdb03a3a3sm1900825qvb.95.2024.03.01.06.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 06:21:18 -0800 (PST)
Message-ID: <f8d45e8f-81ca-432f-9494-441e9a44b390@gmail.com>
Date: Fri, 1 Mar 2024 16:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <44ae0339-daf1-4bb9-a12d-e3d2e79b889e@gmail.com>
 <9183479f-eea8-493e-9a56-9f3f778e3034@sirena.org.uk>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <9183479f-eea8-493e-9a56-9f3f778e3034@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 4:07 PM, Mark Brown wrote:
> On Fri, Mar 01, 2024 at 12:27:13PM +0200, Nikolai Kondrashov wrote:
>> On 2/29/24 10:21 PM, Linus Torvalds wrote:
>>> I would suggest the CI project be separate from the kernel.
> 
>> It is possible to have a GitLab CI setup with the YAML files in a separate
>> repository. And we can start with that. However, ultimately I think it's
>> better to have it in the same repo with the code being tested. This way you
>> could submit code changes together with the required tweaks to the CI to keep
>> it passing, making development smoother and faster.
> 
>> With that in mind, and if you agree, where else would you say we could put it?
>> Under "scripts"? Or "Documentation"? And where it would be best for the
>> various subsystems to put theirs? Or could we have the top-level "ci" dir and
>> pile all the different setups there? Or would you like to wait and see how
>> adoption goes, and then decide?
> 
> If we were going to put bits of this in tree how about something like
> tools/testing/forges?  I'd hope that things could be shared by multiple
> services, if not we could always have subdirs I guess.  We could put
> glue bits like defining how to run kunit, checkpatch or whatever with
> these systems in there so people can share figuring that bit out.
> Individual trees or CI systems using these forge based systems could
> then reference these files when defining what specific tests they want
> to run when which seems more like where the differences will be.
> 
> I'm not super familiar with this stuff, the above is based on it looking
> like there's an OK degree of separation between the "what to run" and
> "how to run" bits.  I might be misreading things, and it's not clear to
> me how often it'll be useful to be able to update things in tree.

Yes, facilitating reuse and collaboration between CI setups, even if they're 
largely different, is another good reason to have it inside the kernel repo.

Nick

