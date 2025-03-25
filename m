Return-Path: <linux-kselftest+bounces-29759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35039A7041D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439D516AA27
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97C25B66D;
	Tue, 25 Mar 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzHL+9nt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281925A350;
	Tue, 25 Mar 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913979; cv=none; b=AeRHW/pOha+oP7t5l8+MJtzCFYgLCkXG7lciQUrF2nkiaUuohubJ1vwZsWs2HwvKPivvMOd5Uo77MSSD9GmGNHuWsaWoOGhiF2mSrooOguTGYzDM5E7NG/tHP2MynORo/YZH0gKLvjCGRqv9ZHuArbxo2W0RKa07llUXro1FEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913979; c=relaxed/simple;
	bh=7HO4LfHgdUMbfSOwKtIo/xttp3NoZ8ybprysTSQ9FO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZizjxfd71XoaZ1ei84929yG7AHClOTzAKO4iNOIoCpFb9IFWHj59bTkKxTHH5lcEvyVM5mjuplkLQXRSd1OApc3V0e7zufTMQzdFrcMt7LzJlId8jj4tB/fQQvGuwcgvQOCkYuBFQ42NPiLXpo3Zh5CHYXYvpXXOIQW66BNG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzHL+9nt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso112536645ad.2;
        Tue, 25 Mar 2025 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913976; x=1743518776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HO4LfHgdUMbfSOwKtIo/xttp3NoZ8ybprysTSQ9FO0=;
        b=lzHL+9ntxXGwoWbzAR/R/WPEk/zdTKNxx3IQeN/s5dKVclD4RZ918VqbC0/B6WGxGJ
         9p381WSSqXWUZPhLR0+t04Dbi/LI8UtY/xsuCvPO6HcXLtu0VZusYxE2lxQMNIATTzrz
         hDNKkPekopNvE464RslKGcbCVSlGNGsB6Uk8UnqYHCpc/CAEVzMUuaV8s2Dnkk2zNwah
         fjzJCac/xxsczQrTfUubb3FDcMf3wMwDafRHx28/dPNltvilqBlBQkAQqMN05MuMWNk2
         246n8IdjY4b7r8RR4kGNWiBrQp9X58dRHIkVfVwY2nEQB72sNM4H4ENFrD9LPU2lsqag
         fj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913976; x=1743518776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HO4LfHgdUMbfSOwKtIo/xttp3NoZ8ybprysTSQ9FO0=;
        b=wJCHB3mKqPFoRMbImYPp7v5FmrSavyOf7VZW16Fi7JEVdj7yqHTGl2jCQVVyCoKyMS
         ZOh0MlXnygoA7GC3DobchqYyTbZuRMX9h5R5XFedEoSqsDZuzLYvGyhkSmnF+v/q9V6b
         veP/+VL4VnaXXBAAiW2HJCv/XtKiyZfZnJvqdzUNoH1+NqeA/O3Rv+SSzs6cjvZhZphW
         TYAj4oiZcNacUIDhWr5bvRKmF+9ARu8HwjSRvLSKeRaDFJE5kQC42wTtDVcAS3icgYnu
         4+Dk3c9279NaFRu4fu9mn7JV+M0L/+gabNe3IG4KaWbhErhiReh9GgWl+izY4+CU49GL
         v2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUWHub7LtDun/qEdse1O3fwjJmy9EkLhpd+jktP4JXvVVNit5FYRw6FO4wHbAnbcafXjQcSCwYw37pUElIPDZim@vger.kernel.org, AJvYcCUmqyvDVBB8JRX+4/HJvmXdxoyMupJRhsDUkQEKCvSpcFFW2B/pQY15AVV+8GmnBzvWHQLFomwUhGHcy5o/cA==@vger.kernel.org, AJvYcCWwXkr/Sbgn+ouO3QadCWr9W5CxyJ69F6FFEObL6cyLsPzIvAKsLmXjh4U9ISiktb2uCrqeyoRViDevYLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Yx9VOsP1OileHbAui0tb/3eeMzPFFdkEUl52HlgZfUH3n1kK
	nykvEiJurkUlkdArmFRBdg1VRfdKlquNdesPAexsO4CL62e4+CHk
X-Gm-Gg: ASbGncvawLca11SO0W94Y6mAuRBfHUD5cgrUPKWouFRDq9hqnZMe6k8e2IWGLtLnMzE
	ejFDXTWuPhhz1NGBVZVR3KyrBuy7G4fgM6Zwlk/oIJOEQ94lfYEfevwU1fVCoy7xrsd+f13l2Vg
	S6agYuE5Fq5c/Fh75r1LNjG97B01E5mfHthFxclyKYNw2fmTLYo76XMRykg6UW5OYbmf4vd+t+6
	7+zYCdRHLOMg7HRTYH6U/PS4aF4/q+hZbBNFvnIeVX+/AxPWPjMunzqM+pvXYb8T+siN3cq/cIi
	LpZ29/SZO2mAxpK+YGLoZu2RJdkqrbrWZCt6uhBwpJ2UuliMLFndBQUnMIPZLDkkVqiiqPjzTxs
	oQVOr/3Vjp+41Tsnhsz/i
X-Google-Smtp-Source: AGHT+IFa2XSNVkCxARtKu+IwYbdQXmTFoM2Q3riEQ3/rLLdNaaJXokPqFNf3Ss3lT7dT44CZtb5WLA==
X-Received: by 2002:a17:902:ecd0:b0:223:3b76:4e22 with SMTP id d9443c01a7336-22780c535demr211768695ad.6.1742913976347;
        Tue, 25 Mar 2025 07:46:16 -0700 (PDT)
Received: from ?IPV6:2804:d57:4e50:a700:f33d:65d1:e22e:109b? ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2b1fsm90851765ad.144.2025.03.25.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:46:15 -0700 (PDT)
Message-ID: <4602769a-6b5b-47f3-9505-d528ef2ae8de@gmail.com>
Date: Tue, 25 Mar 2025 11:46:11 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>,
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, felipe_life@live.com
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
 <Z-K3S4G5BtdP1Q-H@pathway.suse.cz>
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <Z-K3S4G5BtdP1Q-H@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 11:01 AM, Petr Mladek wrote:

> On Mon 2025-03-24 19:50:17, Filipe Xavier wrote:
>> This patchset add ftrace helpers functions and
>> add a new test makes sure that ftrace can trace
>> a function that was introduced by a livepatch.
>>
>> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
>> Acked-by: Miroslav Benes <mbenes@suse.cz>
> JFYI, the patchset has been committed into livepatching.git,
> branch for-6.15/ftrace-test.
>
> I had a dilemma whether to push it for 6.15 or postpone it.
> But it is a selftest and quite trivial. And it has been
> reviewed by several people. And it seems to work well
> so I think that we could push it for 6.15.

It sounds good to me, thank you all very much for the support.

Cheers,

Filipe

> Best Regards,
> Petr

