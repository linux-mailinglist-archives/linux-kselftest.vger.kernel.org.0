Return-Path: <linux-kselftest+bounces-30449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FADA83361
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F11441777
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA1E0DE3;
	Wed,  9 Apr 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W4QKUg6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9B19ADA4
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Apr 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234236; cv=none; b=BCnc9a26rqxMTDV0H9Bb7oadskEjrgrZBS3Jy/cwAzyj5WCp2m8krNeiUQSFRQeRexfO9Z8orLkzDLxQxgNpcts40fOE/s3IJVrbt0m3EqyH9aPuCNnZBXSoDHtJhQzLKClT0m1Z+QnDbLZeXfDRfxSdbt2uPEn5l3nz1qNjQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234236; c=relaxed/simple;
	bh=Fmtm2BL8xq34y8tCWa96ME/YvgDGyr8oDQVrhOOZ00M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u810GuJQlAwgWOczeri1EpV4HAFhlI1RoOCOz1XxVYRKjlNXotuexTDK1kDkoYUJvXiASDuTI0czL7kAgj8hOCPdPl0iBTIDxuSMLXgqw/3ij64CiS+usuePUJFGtF7yc7OWL8PS+oEEz1LpVk1Qqbz6fF2BAAPO//C/VJ9WspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W4QKUg6A; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b40c7d608so17341439f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Apr 2025 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744234233; x=1744839033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/gU15risBbNmAj/+m5gUGnJ/w3Eauv7mZMDjtsuTms=;
        b=W4QKUg6AxCDtVSG7HEUMrWKXTDywvhaxvI+MyuZ9JNLcEj6clGMLgR+Wp5ktS+AtX2
         ZrOVHvOFOmgD/9qBV31sHAd57/UQZabufzXql/AHeTqbUBjiHzN9yzGO8wxm4oI+fsFb
         LFXho2AfbD9ky8fiV7ZvmLBXgns4lL8PGwfHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744234233; x=1744839033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/gU15risBbNmAj/+m5gUGnJ/w3Eauv7mZMDjtsuTms=;
        b=t0TAzyR81pEX27ODzFTE33ceylQeCsOwInJxU8vTslf77kShsHCRtDaB/Uvva61aLM
         svSIRMhnBKHNWq6hKDo8Ygplj9O6uHzrq6pD8Z4rffsYTlsftrdHWkQiWHzuUF2My31Q
         a5eeqNqXaTw7MCdYQCt8O0VEBI1cc4VX/Br00pESnubksSStykN0rNpZjxecJxUOGcsd
         H8PdhRxBfPEu5qqMRZMyqfhnIQRPenqiV21A2Br2H0xLR7R5UOzF4bpSk7srTXEHoIDP
         jP9hf0hJzgy+2LbBp2sv8tEMmNcoMKaRbM6DWKCHwWBz/QpkrrVW4kLt2T9GC9oDiAvN
         BcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnCcmzB0vchwKQI/RtJgmzJmoMKcT5jYFMd0lr1xtXB5NlTj8bvddDmsVsJIpizMA9KDK/kts3vfjiUALKdpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLyDU51cOoa2CcPfSLamNAeITGIM29q/fvkS45Pz8zBdHg9JK
	D4xcFF+LNRW6yu7+DnwYVx+PaU+vNpHLxZ/BS7l61Jc6mAzlnxt4Vh+4IY3RsawWdF6tjSys9+Y
	L
X-Gm-Gg: ASbGncvUzCZd4v5MnBkWIGNDLsYVBF5K822x3Wc7PY02VQ0LiVfHHf9o/taqlCXvmr7
	dsDcAsscIjMjyjREJRoGwwIsrzbsez71aKV+A7glrEA2uNLgmq7ugETKLBtVpeHHcYH4Az0OupQ
	cETIjoTwOEob0j4e4qJRicr3OTKMnwyhP/xCrDFIQXNjDz8PWtAcw1AbH5W55Wm3aWYwQZ0Oh+h
	D5ZDtBq1g+pU3W/uHtmfHq3wHjGgacOOdF2VYY8MNPS0FqiSDNwCrj9siB5g0XMqO/NIipIuhZm
	JyHnCsjCA46Rzr8YKMWgq4k2mcYXc1UG65ieiOviaQGSosYqoYk=
X-Google-Smtp-Source: AGHT+IGEPcb/ixlDoZaXn0uu0NvXiB9ysyL04Z/cY/mfCxM2BzLOYvyJoBHhlF5u2mWhoOymh0mv1g==
X-Received: by 2002:a05:6e02:18c8:b0:3cf:fe21:af8 with SMTP id e9e14a558f8ab-3d7e46e40f8mr8602595ab.4.1744234233489;
        Wed, 09 Apr 2025 14:30:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf8386sm432776173.7.2025.04.09.14.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 14:30:32 -0700 (PDT)
Message-ID: <87e72133-03f0-48fe-ac0d-3f2ac278357a@linuxfoundation.org>
Date: Wed, 9 Apr 2025 15:30:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] unshare_test: set nr_open using soft limit
To: Petr Vorel <pvorel@suse.cz>, lufei <lufei@uniontech.com>
Cc: viro@zeniv.linux.org.uk, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250401015557.113872-1-lufei@uniontech.com>
 <8aa78b76-b9f9-4d23-a009-97b26aefcf33@linuxfoundation.org>
 <20250409055656.GA231133@pevik>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250409055656.GA231133@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 23:56, Petr Vorel wrote:
>> On 3/31/25 19:55, lufei wrote:
>>> Set maximum file descriptor number limit by rlimit.rlim_max than
>>> nr_open(hard limit). Hard limit may cause dup2 fail.
> 
>>> Signed-off-by: lufei <lufei@uniontech.com>
> 
>> Petr, Al,
> 
>> Okay to take this patch?
> 
> LGTM, hopefully I haven't overlook anything.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> FYI Cyril Hrubis suggested a different approach (for LTP tests which is based on
> this Al's test):
> 
> https://lore.kernel.org/ltp/Z-u7yYJpTBG8Hi6A@yuki.lan/
> https://lore.kernel.org/ltp/Z-vwYZxLms8juTjX@yuki.lan/
> 
> 	filedescriptor that is >= 64 and set the nr_open to 64.
> 
> That would help to avoid using /proc/sys/fs/nr_open.
> 

Thank you for this suggestion.

lufei, Can you look into this as a solution? Also the short log
should include the subsystem: e.:

selftests:core: unshare_test: -----

thanks,
-- Shuah

