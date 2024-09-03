Return-Path: <linux-kselftest+bounces-17066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE996AA09
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336D12811D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69572126C1A;
	Tue,  3 Sep 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMPpyzA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D31126BF8
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Sep 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398689; cv=none; b=bRaOvv+H6zdP6ZZczbnoWTZ+LBvCDur5qByNIjJtLqLmRc103GGyTzAPUXRrtdVvb1X6E4Gs1pO34sIxaN4URBbiWklIfX6/wifAhNyh4vgXkJK/76Bvwq1/D4qhRlrZ/9lAp15O+7wV32xVXFXhp3Bx1LJ9IcNX2/Ep7VQY8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398689; c=relaxed/simple;
	bh=5Y0EfzLXDTbgzAG1r4O3ziDUSqjx8unhEbyzQrV0/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNtWwgDBqvvVJyOgui/vPHT8OnzdkUJnx1hQpMdoGECqQvP3OkN4MPXo/LiyYTq1mq07LD4waaLKPOvA02zYR+J4apw22fLd+eds5GtJCacvTrlLQKidkYx8Bi0QMjOzUOyh3hO4rTAPuV+WJvWWulOaglVH+qAevAEFXikdyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMPpyzA/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f4827a07aso15016075ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725398685; x=1726003485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVCLBn12rNJQYK6IvDPibD8b2IIiRiXGWkQUmUgIuLA=;
        b=XMPpyzA/Mt0Yte5hE5ERT10jd4jx29F1idFtOwQ1a9eAHz0nEw0zKt/ZrpOv4/h3nm
         bWXt4qhs3kl1ZYEPEbSfnUkf0bBeZBCvD0xZ4Iu7IzREpLOTqdHahL8r3jJATXrgSzLm
         KBxlloZzMtuJR913bxC6hpb2u8TsrSKp1Neu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398685; x=1726003485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVCLBn12rNJQYK6IvDPibD8b2IIiRiXGWkQUmUgIuLA=;
        b=j0uIbgQZFl5xojg/1IZYlvYfCxo4b98TTzd6dr53gngrKIT0lnspZNBW57PBCUsL55
         GukV/z8m7QMLT5zO/tAnBqokRQ3RWIins07p9d88CRAzN2Tyuq0fppX57ji25LTnq4/c
         F5r2u5GiBk341/Rhe3OBazxn77DHVqJUqU01GOG5Cky3ZtsheCmnEjMGQB9a5d/9DwBm
         tfLPje/3gPW+mrH4qX4ewSFhAuI9lpHcajZNFgEhG7PDYbfcdfmC5KYkTZ0Wkbx9csd2
         o8r+AZ+zW3xuqj3Bn3zZldkNzwoaqY5pM1KOZPnXZIptGfgHVeVg7Ivq4BTy/zjn6hPE
         yS4w==
X-Forwarded-Encrypted: i=1; AJvYcCVGgpCG0rm/sOytm7BJqHcldDUCX0Bvuk+F3HJznS1AePgN9ffeD4wJd0WLD4L2GUv65LdDcJmbCGobz1iFMNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6bcn9UMDpXxJUmonhUFLAgJK1RRRQLPXdPUPJmtLC57t1kxB
	rdDx6IzI7UNfiETxC/IcVuUFEetJK1HcKQ33xg1oNkZcKd1wHrOaxhpj4KVbFYtzW32802E/sb1
	q
X-Google-Smtp-Source: AGHT+IHdA3J8imNuPn1PmrGvvcfBwCu+ZkptHHXmFQlcrLBo+gIjosUQW9ALClJl/O+WhrEXbTHk9Q==
X-Received: by 2002:a05:6e02:1606:b0:39b:28c0:9427 with SMTP id e9e14a558f8ab-39f4f68d790mr111347785ab.8.1725398685424;
        Tue, 03 Sep 2024 14:24:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm33476515ab.37.2024.09.03.14.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 14:24:45 -0700 (PDT)
Message-ID: <1886e4a4-7c19-4a0f-9689-9edda970d508@linuxfoundation.org>
Date: Tue, 3 Sep 2024 15:24:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
To: Fangrui Song <maskray@google.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240815032614.2747224-1-maskray@google.com>
 <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
 <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
 <CAFP8O3JyU6HaHfrRSoSuqvKY3z50mOfwtoAvftFc2PG+2i5pKQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAFP8O3JyU6HaHfrRSoSuqvKY3z50mOfwtoAvftFc2PG+2i5pKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/24 07:37, Fangrui Song wrote:
> On Tue, Aug 27, 2024 at 10:12 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 8/26/24 00:07, Xi Ruoyao wrote:
>>> On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
>>>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>>>> obsoleted for more than one decade in many Linux distributions.
>>>>
>>>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>>>
>>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>>> ---
>>>
>>> Ping.
>>>
>>> Some context: I'd change LoongArch vDSO to use the toolchain default
>>> instead of forcing DT_HASH (note that LoongArch is launched decades
>>> after all major distros switched to DT_GNU_HASH), but without the
>>> selftest support we'll lose test coverage.
>>>
>>> And now ARM64 has already lost test coverage after commit 48f6430505c0.
>>>
>>
>> I am seeing several checkpatch errors - please fix them and send me v2.
>>
>> thanks,
>> -- Shuah
>>
> 
> The applicable change is:
> 
> --- i/tools/testing/selftests/vDSO/parse_vdso.c
> +++ w/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -177,7 +177,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
>          if (vdso_info.gnu_hash) {
>                  vdso_info.nbucket = vdso_info.gnu_hash[0];
>                  /* The bucket array is located after the header (4
> uint32) and the bloom
> -                  filter (size_t array of gnu_hash[2] elements). */
> +                * filter (size_t array of gnu_hash[2] elements). */
>                  vdso_info.bucket = vdso_info.gnu_hash + 4 +
>                                     sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
>          } else {
> 
> 
> Other checkpatch.pl output is not actionable. `ELF(Sym) *sym` instead
> of `ELF(Sym) * sym` has the correct spacing (used in this file and
> elsewhere ElfW in the code base).
> 
> 

Okay. Send v2 with the actionable change.

thanks,
-- Shuah




