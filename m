Return-Path: <linux-kselftest+bounces-14567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509C943579
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3B728315C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0E433B1;
	Wed, 31 Jul 2024 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRbGUqW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C182032A
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449660; cv=none; b=e5E+Rg5e51GgSmHFfeF2OUWGhZq/0563aAQVsrvnf8gjHYJurjAqIS0xyaK2nH/7GdxbAiga2E8rAd8kxls7SDycEAlrX+aTcM2H2a6H3+YquZRySTppQ7QZWjpDhD3kH6mvYGUvsCe22HgLBFatpdEGMsYcjyYjuuJ69dq76e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449660; c=relaxed/simple;
	bh=o+obLVrQ5csLF2wGeTp3KnAdR4khlOmzk77O8qwH0jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqKFUrRUrKDlzJN9nIsV6THCEfnl4BVDqScOZaLGnStpPDhTXf7xyIzjFSKFOxH8yUVxhVCojHrl4bCapM6wEZhVDbApIvHb76PwtJ008hmTlUg17iE/3hZOz013H+UbCd9+GG6lkjiT+Ap6yxhLy2gOQ5zFkwm2m92wLWCHPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRbGUqW1; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f7faff04dso38400839f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722449657; x=1723054457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cndA4LS1PO0dhLlbipUiByrOJ6DdKdLCJA7x5MGr9Uw=;
        b=VRbGUqW1iC8fV/116K6AD9c5MG5vixx0t6EwCUBl7jShiNJoCsg5yNnAl7zoJBn5Cr
         5PcS+aIpSRn/1TRSHBROUJ8mOFTvp2b/OaBonoFfl/Z16EvDBhKxvYhoUDSp7GGZbZ0z
         HZOTvyGVm5LrKMoZUZM8Nr7c4ZybdulQUlDsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449657; x=1723054457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cndA4LS1PO0dhLlbipUiByrOJ6DdKdLCJA7x5MGr9Uw=;
        b=Ousq91nqu0ZXoesJe0yGlw5w9FGmjBIXDIeerYGKjSMI/8sCxxzdQO1h9zk2/H9tLh
         vjEBb8PmfUgvHTcZU9jEtjJ90YHQLpPwiKwPbc67ljgC/AAmlSOyRbXTLt9dg6rQfRaq
         K9yVlFcgrurt1ovVThvy+EQCQqs0b6wLAierj3q3JgTMgLJ9ei4N4zSHgY4KEyZjTKHu
         tw8+MARhcWmUu5hU88Q2NlFlQwTfu6kgMI5XBSo/pESGiMvKFsnqIhBeARgYy42oaWrM
         Q7/JQly5tyDjkKG+uaAPjtrslORWPUzyPbetptPVye2Fo909gWcmjLo06AdCwlTjWxzO
         CW6A==
X-Forwarded-Encrypted: i=1; AJvYcCWPHptCrtYlxqInL5XItkeBjvoJsXtthod29mn5Lx1QAQjQWiTZu2apg79IPWzNQ7Kvrc7TxeJm7M4eZVFINvpopFIa+Pin3TIfTr1KZ4/b
X-Gm-Message-State: AOJu0Yzehye59YroZkR75qugsNKYegOgEhJ/lt7ktL3o1wl5FTscrn1t
	yc3oSruu9f/J6yuaxcVxZib5KHLYWrAx58HkLSb7jx0O7Q+gILWXefUlGrSd1vL5brs7tPbvB9o
	m
X-Google-Smtp-Source: AGHT+IEYLRmfG+6zYEE37VcIgp/begbK0OdeNCE1ZQ0GgaiIHvcfPhQ8HmkYZPnlxIf3BFx+F9Pf5Q==
X-Received: by 2002:a05:6602:586:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fcc17995bmr7402539f.3.1722449657018;
        Wed, 31 Jul 2024 11:14:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa983f8sm3328074173.47.2024.07.31.11.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 11:14:16 -0700 (PDT)
Message-ID: <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>
Date: Wed, 31 Jul 2024 12:14:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
 <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> Kind reminder
> 
> On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
>> Kind reminder

Top post ???

>>
>> On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
>>> There are no maintainers specified for tools/testing/selftests/x86.
>>> Shuah has mentioned [1] that the patches should go through x86 tree or
>>> in special cases directly to Shuah's tree after getting ack-ed from x86
>>> maintainers. Different people have been confused when sending patches as
>>> correct maintainers aren't found by get_maintainer.pl script. Fix
>>> this by adding entry to MAINTAINERS file.
>>>
>>> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>>>

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah


