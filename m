Return-Path: <linux-kselftest+bounces-46020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33862C7136C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6EDD428F57
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831442FF656;
	Wed, 19 Nov 2025 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL6RO35V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8A28C5B1
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589726; cv=none; b=bx0A4jkaxo63FTLm2yRa1c+LMLdP+BlEev3VXt5T51VzsAHSiLLtnv2z1qBKlck+z96j+mM9q00fhI4zAK+w0QLHICX3jPal66/l3iNRr8jw5ENFma6IIvvP/M9XXhty6cd0Hjlh2WNtC9p0HJL1aoNkQKZruT9O3BPGIifhSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589726; c=relaxed/simple;
	bh=MMOCd6+pmZhKhYK3yL9W+pUiedqJaSbBe6IADG4ykIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDf5Ls07RSgvuCmXmdUhLORt2WZxlXIroLiC4oTxZf6F5PPCrO4mClz49eTtrKkzyENL4T+l8YqM54qsjAGfepljFJ31WLHwcalVIiRmMSn0wRIdBlW+hoMtUPDDhePohIBaAcPwZP/2afRKxyfbbIecv1gzIjKDf6rnf8fcJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL6RO35V; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-433692bbe4fso1738615ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763589724; x=1764194524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y69g14VVZfoTlrhxJgLGJZ6gluiFhhzpz4/9gY8TxIU=;
        b=HL6RO35VkTXila4JC00dxjFDhEs/2yhAITk+oRTwIqKK0i2G0dOs21wWTHk9nKEL4P
         l/1rAunVY7QlzkRtVuJUCrPCBeIUZcufhbTSOYvA/bokaj2i2jbUMNII7fhCcowOKtbU
         /h79T1cHzZDtQFabVj+MsIsKKJOTKXLZLAn/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763589724; x=1764194524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y69g14VVZfoTlrhxJgLGJZ6gluiFhhzpz4/9gY8TxIU=;
        b=J4P/rT7GegD+Bm14JVxCCrQUtIl+KRE0WpdglXtWhBPiFyizLJ30URX2d98iJbcDnK
         9+D+cIfqZVjbl3GjJO8Xt051A0vckclAAxa/EvQcDoQtYmfxf9fSqLzYxP+JXJ+mbBsq
         WBeQK25u7zcX/eXmIkAN/XaAkqHRPwwC8DjIBiTsSfxf5WyIzNSJHd+GLKFnKqMkXtBA
         An6XR1MJ6BP1feO3b99b6Rp67a1in9r+AnU7Ic5h/DpI8BAzEzlG6+r4iYtVqIS1dXHd
         gTyDncM+/aw9AGgC81sfOpRdi0J1g9iw/zpk4aYyrW/D+ydnFhT8weymnO87QAq4N+IJ
         5q6A==
X-Forwarded-Encrypted: i=1; AJvYcCXviJZIiE846irtxyPNjcn5/4oEGvjGNASuhGy4wIrm7GQYM1/PmyhXlMb0VclrOjKsyzC6snZaLOdkbLANn30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIKB3Eh7II0/TXmqBsQlt/O8xFeoXkbSUFNEydRZXysU4frBQ
	OHFxIKYfoBpsU8yV9QMhBdqTPcFJZ33lT1HWypMvj0vKUlelUc4wtFNz60ek87yOPAU=
X-Gm-Gg: ASbGnct6Lco4F6kq82KrK27VWb6U/mdBuwqD8edHaiy2bn/xQvHwUkQSY9VFumwwuKE
	buWRniv1GVOmmNihOxR9vCkhRJ0VLHvKJrYuIhrWj3f3oRQrHg2fFj/OJugFW4G///c3twO/SjB
	V3+8OOew2MqX2jPYqkcRnJ4tGMgEiu/O19yylvPiA4l4PRlsZRSweXNIo0lgqCSnJMRfKVnBipC
	nr1Br8Y4lNewHqyzf9qJQJXeydlfvtVSmPk41pVsPumqanU/MfAMzZRSZUgxL9lIAXfmiA7VAks
	eKinQ1gufSGpcU5Zi+kni5witmPx85kjqEY3v+jwZo3VCCbd54Fm3rhU528qO9EUnx9b1kwW7pL
	LBk5bFHQLyLbbIP+vaKdVcl9E7dT0uM7YWUcgy0PaXxokPn86247wfovBh+5hJKE+BprFZ7STvC
	6vhMJwEH40ZOKkE+EmD/yIJew=
X-Google-Smtp-Source: AGHT+IGHtDnd+/05cJuQbIXypyVXpRrNNuziZo8lUC/Z43Rg9Fkp+rKdsOA2miYs+V4Cuy0Sr4EuTg==
X-Received: by 2002:a92:c266:0:b0:434:96ea:ff4d with SMTP id e9e14a558f8ab-435a9e22196mr5350095ab.38.1763589723888;
        Wed, 19 Nov 2025 14:02:03 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9069247sm3163765ab.15.2025.11.19.14.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:02:02 -0800 (PST)
Message-ID: <3da29510-0441-4abd-aaa9-bd085844876b@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:02:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma_map_benchmark: fix incorrect array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Cc: dmaengine@vger.kernel.org, linux-kselftest@vger.kernel.org,
 vkoul@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
 <20251107015604.2029-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251107015604.2029-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 18:55, Zhang Chujun wrote:
> On Tue, Nov 05, 2025 at 08:30:00PM +0800, Zhang Chujun wrote:
>> The printf statement attempts to print the DMA direction string using
>> the syntax 'dir[directions]', which is an invalid array access. The
>> variable 'dir' is an integer, and 'directions' is a char pointer array.
>> This incorrect syntax should be 'directions[dir]', using 'dir' as the
>> index into the 'directions' array. Fix this by correcting the array
>> access from 'dir[directions]' to 'directions[dir]'.
> 
> Hi Shuah,
> 
> Thanks for your patience.
> 
> I found this issue while carefully reading the code in
> `dma_map_benchmark.c`. The expression `dir[directions]` stood out because
> `dir` is an integer (enum or int), while `directions` is a string array —
> so using `dir` as the index into `directions` is the correct form.
> Although C allows `a[b]` and `b[a]` syntactically due to pointer arithmetic,
> in this context `dir[directions]` is logically wrong and would print an
> unexpected (likely garbage) string, since it treats the address of the
> string array as an array indexed by a small integer.
> 
> The compiler doesn’t warn because `dir[directions]` is technically valid
> C (equivalent to `*(directions + dir)`), but semantically it’s backwards
> and breaks the intended output.
> 

Applied to linux-kselftest next for Linux 6.19-rc1

thanks,
-- Shuah

