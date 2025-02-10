Return-Path: <linux-kselftest+bounces-26213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5BA2F95F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD13A958D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C324C66F;
	Mon, 10 Feb 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0YrPpU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64B24C662
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216785; cv=none; b=mv3B4LmBQBjt5r6/Nl0U2ulnQEt4nHFiCLleT/HP1KDkL42SjOFDXf2x/qjXt+I4iSqbPLi2W1wYP/TEq73v6VEn97LDLsc5PAEnFuUonzq0FC6BVrXzA0BG4li+zkZv42b7vWVkp1bEZrnwv01CPWV2EiSGOWY+3I1ARh0DL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216785; c=relaxed/simple;
	bh=gdSjpmBAJv3XPCV7Nq/cINpCzJqad3ipQcGcpiRGnh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiI4xkko07JDTc90sfEwtnNhZFr3Ahtum+VFa8jmxDW47RR7kUDKZ1/vAdUGGijUtjMPJioLFHfDR4lCv6lrOu9OSsMEWW4Adg+mwvGYCWQc5tMbmk7Fpq9nmmKoMiRBlYnxDd4wHKC8W0BnqqCsI88YvcnPY0mj0dOqRBpnX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0YrPpU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJ3dn2m14q3JZC0SZ/m8U9BYHLX1xfnAh1A/zsPGM6o=;
	b=cV0YrPpUPVFh8c3b/Q8eeK1s2q8nPn8IQaWy2eqZOqv+juRHNu52wbFjnEFkZA9FxEXp82
	q1Ft8RA7PwKnCl1O1G4dEue+EWtK/xYSQbWCcw4Z79tDEIRFsVfKE3Jxd501PWG09GkyJ6
	77Gnuessk507+cmXqFnMKGwt87/bq2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-YUIDQ5F_N96P7zTYE28jJg-1; Mon, 10 Feb 2025 14:46:20 -0500
X-MC-Unique: YUIDQ5F_N96P7zTYE28jJg-1
X-Mimecast-MFC-AGG-ID: YUIDQ5F_N96P7zTYE28jJg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so3423795e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 11:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216779; x=1739821579;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJ3dn2m14q3JZC0SZ/m8U9BYHLX1xfnAh1A/zsPGM6o=;
        b=aJXVM4guk4OrA4QuPR3KOj3hbM583UqQ4AHBfNhkrji5BqaVaQUVAhR/qzUSTv/G1X
         3uKm/+pHbo6RbsCjtSSjEi1GekI1pauR9DQlyGcdwDVQku5bf1ESWrGb0p2FOv4ezSBK
         hmmYV+Ud0ykT/PVk9KCL9Gcrov+HG+63nE9GSsiM6NO4ZP/za9kBDFIvVga3PUtR6qDz
         hYuJS0Zs3m/vD2++3C/ADXiF4x/UowI2KLjj1LNGzus6at/P8mioeBPEPm0p/gIPhuvp
         ajRAods6etxjOnBwlgJ3z/olE20+dtOioZsn5QSIHUfys75LGhEl+jXkZirNk4gzZHEr
         XDGg==
X-Forwarded-Encrypted: i=1; AJvYcCWa2j4cc2QgBfbvQXbWfUjhT5eMJq/X9hRMOYJUmYsDs9PCAmYYfKpvBTejqUVyvfVxfqcYOP2sCU2fP9WAIBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KOnWXFRczF4COl25mD37Ckc596463zl15sdO844Bk+le3XCQ
	Z8+FXhsGnfx7/ycuE4wQ2NBX2qW6R9vxlsaehpHz8+k3zefCrVwS+ElVn2heWhgscldLq4iIMJJ
	tMCofhnlOO6FYiOR0RO7IeSWWZ+RdgRdZICv9xQN3rnFfbFx/igt0SGMOqv5pYmt21A==
X-Gm-Gg: ASbGnctw16cAYSVgOeZAF5Dzuep9naLoK9jrO/o1PK7hFDPEORDw1wlNwK/PfiGKUPf
	UYF8F6Nxrp4PbLELvid22JKe/5Ag2fMOOA2GLdpJg2xcnovxxmZqA3bmHeskCpj/DQDHTKgYRHA
	6UiQ4s7J6zQ+EQLE0R3dtAVIOUV73O2ZyfjbndWvU+PUazKOSeymFDnwWOowZrKGKm91+ZJes5L
	KgHNT8+tIdcU18x0QbCyU7IMjvrR0HVZJbs1bIs9ULfVfDmutw1N4PWhX3GeUhvSbA6H6714xqZ
	+fKRF8lkojjB6tHUBWbGRx2A1VaCkpqXhnc7PbgaG/PFQ8aXsW2OdxRoV6JCx/O9TQGY9TlZDZQ
	GMo7q/D1PrZ6HsUuEo+sENGgwaUsg1Wbt
X-Received: by 2002:a05:600c:a0d:b0:439:4355:2f69 with SMTP id 5b1f17b1804b1-4394355322dmr52600635e9.6.1739216778685;
        Mon, 10 Feb 2025 11:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCZVh/MEtqHC+Z/EILrF/9sgQe7D5pYK8P8qD6dHN0xGfT768AmNEonlQrcYjmGWj/KHPJeQ==
X-Received: by 2002:a05:600c:a0d:b0:439:4355:2f69 with SMTP id 5b1f17b1804b1-4394355322dmr52600495e9.6.1739216778239;
        Mon, 10 Feb 2025 11:46:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da965b3sm159736065e9.5.2025.02.10.11.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:46:17 -0800 (PST)
Message-ID: <8b4bb4f0-37fc-4215-a3a9-3771394f065f@redhat.com>
Date: Mon, 10 Feb 2025 20:46:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: John Hubbard <jhubbard@nvidia.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Yury Norov <yury.norov@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Brad Figg <bfigg@nvidia.com>,
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Nico Pache <npache@redhat.com>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad>
 <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.02.25 20:35, John Hubbard wrote:
> On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
>> On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
>>> On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
>>>> On 7/27/24 12:35 AM, Shuah Khan wrote:
> ...
>>>> The crux of the argument seems to be that the config help text is taken
>>>> to describe the author's intent with the fragment "at boot". I think
>>
>> IMO, "at boot" is a misnomer, as most tests can be either builtin
>> or modular.
> 
> Right.
> 
>>
>>> KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
>>> on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
> 
> OK so I just bought a shiny new test machine, and installed one of the
> big name distros on it, hoping they've moved ahead and bought into the kunit
> story...
> 
> $ grep KUNIT /boot/config-6.8.0-52-generic
> # CONFIG_KUNIT is not set
> 
> ...gagghh! No such luck. One more data point, in support of Yuri's complaint. :)
> 
>>
>> I think distros should start setting CONFIG_KUNIT=m.
> 
> Yes they should! kunit really does have important advantages for many use
> cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the main
> obstacle.
 > > Let me add a few people to Cc who might be able to influence some 
distros.
> 
> thanks,


Fedora has it.

CS-10 has it (-> RHEL-10):
redhat/configs/common/generic/CONFIG_KUNIT:CONFIG_KUNIT=m

https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/blob/main/redhat/configs/common/generic/CONFIG_KUNIT?ref_type=heads

CS-9 has it (-> RHEL-9):
redhat/configs/common/generic/CONFIG_KUNIT:CONFIG_KUNIT=m

https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/blob/main/redhat/configs/common/generic/CONFIG_KUNIT?ref_type=heads

So I think from the RH side everything is properly set?

Let me CC Nico, he did some KUNIT work in the past.


-- 
Cheers,

David / dhildenb


