Return-Path: <linux-kselftest+bounces-14860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE794924C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95851C214A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826E1D47D3;
	Tue,  6 Aug 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzxQZzWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5711C579D;
	Tue,  6 Aug 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952616; cv=none; b=lf23c+D3oWG/vq4yauyxKmk0BRdPk9BVvyQUwa97zC4Lp2w6fmJTg0z7Rb8X3n2xNAtrTzd57KlwAXbyj8OkFNYtmuywGBJNQVkeYNvxI+ifxxTxbzHloW6LhUewffXz4x7x66vPRnBkpi0eDJkPQWPcQ+YKpBvXNCQh9QHs90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952616; c=relaxed/simple;
	bh=P9EbeoRT60rQDkcM4qaVG4RD3YBobJKZcRP/nEPc5/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vfl/k20Ql8Be1v1SFyY3uZRboVu5VFslVfkUmMX8ahO/t9sEb/AGEjCnMMaE0vkyIrCM1PkuDiXIqW+apx0q9/sG9FLml/0B5FDR1Y7nPHlbmEczO4ggM0o9VhGjCjQSS1L4ehZZ/Es9KDBfYHYFefJ6q5O++YyPYWOwoEZ7fIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzxQZzWK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281e715904so380635e9.0;
        Tue, 06 Aug 2024 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952613; x=1723557413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGYRmrw93lyT9+EcZR8YwD5h3/xRcHadaUPb+Q7HbDM=;
        b=NzxQZzWKcHweG0y8n6N0INqEt/1u6laSogE9Vz+W4Y87IbWee2ZkCNctX746bd6+qH
         HslU8ghP2em+pvzNoUUhjcIAQZVtvB8hqBxY3NpcGuMwjvQgUYx+qdOE1JJ+bsnLnAsy
         8e13uLSuuPy8j+Bl43fVc33FF+fa1BDjMQzwC1/hFS8/4gb1FYTUaEDSmhoV/kweGmTu
         tmMreklv1ARfkyyf4d6Tp/04BQhfn/t/QFtb4ie2D2SFLRiCws5Qr/fP4Rc/Re9GX4xx
         IZxTxjUw3YzKKEXOIl+/BAib7WJ3ccgw2b4ILdTepnDSnCwiZKJNLG0rAhl0/tdyIHf0
         njoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952613; x=1723557413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGYRmrw93lyT9+EcZR8YwD5h3/xRcHadaUPb+Q7HbDM=;
        b=IEj22B0b5ZHGdigODKTTIe4E03ipp7I0VZNyKfrhK8Cu+cMlVY/stab4KlcdR0M1lq
         +8VJmsB/1+EL42eTnO0qyLoErh5yJe9nyN7aO7V+RgGh+ip3xw6Q1+vHFvL+ZC/Y8fUU
         oolt3GeS42ZNFIVJg/Kmn7W1D6DsG1ljv/VQoMgSot39jfnaNAe5icXvV5ybIwrhONcX
         bGVheqmckXXZM0n/6BOA8tUIcCvmVc7ajoWEsDUSRsYGIxCHT9f32EL8CNn+KNXFuCp0
         e46wm4HYPvuKZ2cFGWtCUaBYiFYi85MuBRGTTBRs0AbOpZaeDsBYxYPoO4tGPbu4Y3JV
         4qOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV9hBfFzMLcLTUkwqPlXG4YuZOpyaXJE5fYHoFIECX8YPT61daRQcl2IxYvHOUfleL573ZH8eOLpxMGPH6MaD5CKOGNCW2/cPZKXhuB0WoRY1TKHv6pOmCz6fYGZhcJuw8bNL53VgYAHvdd47vADTQsDaGVFFtcKvaSLJUL78cZ/QN8b4=
X-Gm-Message-State: AOJu0YzHlgRSjqm/XxNU9e23NE5IltML3xGPf7oJnoVmcYlq5pdlgZuY
	pXyYsg2/C3xUK6CUnIhi9FcrKRzzUVyzTd0eI9tv6fhKONfAt09n
X-Google-Smtp-Source: AGHT+IEY7UGmH6pDeX7ipw00m+WWJP3MfsJP+s7AIwqszU79s04STakugi2gaQ8mejKlJdjQ6BterQ==
X-Received: by 2002:a05:600c:3152:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-428ea0fd688mr64176135e9.5.1722952612705;
        Tue, 06 Aug 2024 06:56:52 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:b50e:24fa:fd17:c835? ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaaa8sm245028995e9.24.2024.08.06.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:56:52 -0700 (PDT)
Message-ID: <c5624841-fa50-4bd1-841f-071bef166fd8@gmail.com>
Date: Tue, 6 Aug 2024 14:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com, corbet@lwn.net,
 broonie@kernel.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, aholzinger@gmx.de
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
 <20240806125243.449959-4-ivan.orlov0322@gmail.com>
 <8bcfd160-8c6a-4a1f-807c-f76e7f069b49@perex.cz>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <8bcfd160-8c6a-4a1f-807c-f76e7f069b49@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/24 14:11, Jaroslav Kysela wrote:
> On 06. 08. 24 14:52, Ivan Orlov wrote:
>> Implement two ioctl calls in order to support virtual userspace-driven
>> ALSA timers.
> 
> ...
> 

Hi Jaroslav,

>> +struct snd_utimer_info {
>> +    /*
>> +     * To pretend being a normal timer, we need to know the frame 
>> rate and
>> +     * the period size in frames.
>> +     */
>> +    __u64 frame_rate;
>> +    __u64 period_size;
> 
> There should be just one timer resolution in ns member (like in struct 
> snd_timer_ginfo - not frame/period members here - it's too specific). 
> The resolution can be calculated in the user space from the rate and 
> period size.
> 

Ah, yes, I agree... Also, it should help us to avoid complex 
calculations and sanity checks in the kernel space. I'll replace these 
two fields with 'resolution' field in V4, thanks!

> Also naming - the timer API uses snd_timer prefix for structures, thus 
> snd_timer_uinfo should be more appropriate.
> 
Alright, I'll rename the structure.

Thank you so much for the review!

-- 
Kind regards,
Ivan Orlov

