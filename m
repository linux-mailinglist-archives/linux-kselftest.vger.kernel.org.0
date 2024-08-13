Return-Path: <linux-kselftest+bounces-15195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1C94FE58
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 09:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773C71C22513
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435143165;
	Tue, 13 Aug 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqZn3uf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7024C81;
	Tue, 13 Aug 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532594; cv=none; b=Pnl2Vs1cJkW3I6M+R4y/vh24achqnWXAYrKkL4ugeyaAAxCxuLihh0UQ1shMfX287tohJKY+C1rybEa8nE1WWHDxBFZEIxjLoz+m1BZlu/rAtLQYkbqFlGodmPjt7jGYa4WVamLJL2GVcqUTUwbTzRtWAEaATgBmehNFdgcbeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532594; c=relaxed/simple;
	bh=dTbZzkcHiIl7NTbNr43zH/Q3LxjRB6jnEClIJdvOAc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTkJYIevSR2flFQ0aWuM/L0wTcdu2v4p7ooa2q3NsOj9qZXFuQOmGzsUZVqPqkRT352ydSHQbxu/4E3al6uxkpwz73yJp8I3wzKAm3MomfTuJMaC70ZFY2H9J+HRooxst59mNbGthmHffhdv7CYpo95m9e7RMfx6mEQjgGntNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqZn3uf9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280921baa2so6080715e9.2;
        Tue, 13 Aug 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723532592; x=1724137392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIOwaxibfjy8pBTYozQ1M2vGi8fc4Fhd8E64F9TTN1c=;
        b=lqZn3uf9No77Lcl/HaWu9SM/hQlLxUzMqCy3F1d72B/iOaFF8ecRdNbdfR+CkrLzjD
         h8nqBtGbBTuct8Mgqk9dm4a40UkYs0RZBipF23sPbLpvqPtxCDLLQ/R1VIj1IHaETmM5
         1GZJvq2IWy+TJXHw4f9ZWQ+V/G1uORMa2ROYSQf5bMO25ZOmFNIChb2WruuW0h+Foyk9
         CdmuGgQ+6FKLMvl4e7jwQ8go9nUNAwCx08/YDwZEKkCeJmimwhtTXwxpLpi9nFkWaDxf
         5f6qkEuudBipfB1lXPHznx95oJEVWczOHTDixYjK1LnKVXfw2t+2UZpi7UKufHf9jou6
         b/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532592; x=1724137392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIOwaxibfjy8pBTYozQ1M2vGi8fc4Fhd8E64F9TTN1c=;
        b=A5sjc/roDlGfcX/msWRGM80TtxG/w/iIO9ZXoezVIYPvRVe8VQDpR+YtgcRKDVrr8V
         g85apelAfph7mfgUp8h1CThyRBxdix0nTrVY6NNPTWLctxyw9vC3vJr41+yWTICAD+wh
         CCZXnutZGcT+7eWMUNdkQxzJIbjivoBZf0ZmG4dUEhWRY5WbA1mJaKa6PVZfBSC+xLVC
         Q0YTU1pct50EJuDgeO2ICZvuA0LajidMSeyXPuwNe1kPKfTUwwx2UrMqynTMiCRipXs8
         Jlb6WGSYKPUWg51Kiprw0hlS9CgZzQAPqCCJBu47IIATqBIE4jd17c7FPa0UnEYboAbq
         1p9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZN/ZsEA+WZmXrHvbcmF3J4RWXwqkFeF3OvtB+2I50YGYtjrrOOABAsa1DI1IrBtV3g2JGbY4fl9sPZ+8brhFeUVcGpoZS7+kJDVpSb6acAPVqijeIup7uJrqM5MADLop0akzcHzEiag4p4MWGFRkVTNRYBcZNRbBHaKQuhwLUS89WHW7vYr2UONNUOriZwRzinvuZmvZu5T9pRfyK+8IlACv6Ag=
X-Gm-Message-State: AOJu0YwcPabRvynW2Y38AhIxpFsin8rXg6ELgCH1kXKsK65yDymVoUce
	uIFjp2LH6po730fkF01BdXxCKWD7hJAZo+Dmx+M37LO1o4kQAnxp
X-Google-Smtp-Source: AGHT+IFT7bLnTaW+ZuudccrGn/oo/3z70x/uR+WhXxRNGyeNLZQD80eh8G9IROEtYFJM2/ZFfGELGQ==
X-Received: by 2002:a05:600c:1c16:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-429d760e0e5mr5749905e9.3.1723532591311;
        Tue, 13 Aug 2024 00:03:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31? ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c751a554sm130564965e9.22.2024.08.13.00.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 00:03:10 -0700 (PDT)
Message-ID: <93b5b1ce-8b40-473d-a2c4-2b1d2612cd67@gmail.com>
Date: Tue, 13 Aug 2024 08:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 aholzinger@gmx.de
References: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
 <20240811202337.48381-4-ivan.orlov0322@gmail.com>
 <87ikw5c644.wl-tiwai@suse.de>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87ikw5c644.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 07:02, Takashi Iwai wrote:
> On Sun, 11 Aug 2024 22:23:36 +0200,
> Ivan Orlov wrote:
>> +static int snd_utimer_ioctl_create(struct file *file,
>> +				   struct snd_timer_uinfo __user *_utimer_info)
>> +{
>> +	struct snd_utimer *utimer;
>> +	struct snd_timer_uinfo *utimer_info __free(kfree) = NULL;
>> +	int err;
>> +
>> +	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
>> +	if (IS_ERR(utimer_info))
>> +		return PTR_ERR(no_free_ptr(utimer_info));
>> +
>> +	err = snd_utimer_create(utimer_info, &utimer);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	utimer_info->id = utimer->id;
>> +
>> +	err = copy_to_user(_utimer_info, utimer_info, sizeof(*utimer_info));
>> +	if (err) {
>> +		snd_utimer_free(utimer);
>> +		return -EFAULT;
>> +	}
>> +
>> +	return anon_inode_getfd(utimer->name, &snd_utimer_fops, utimer, O_RDWR | O_CLOEXEC);
> 
> Wouldn't utimer be left unfreed if this returns an error?
> 

Hi Takashi,

Ah, yes, it will... :( Thanks!

-- 
Kind regards,
Ivan Orlov

