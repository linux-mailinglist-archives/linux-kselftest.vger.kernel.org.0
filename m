Return-Path: <linux-kselftest+bounces-24086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F92A06961
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 00:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E791889382
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8E2046B7;
	Wed,  8 Jan 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCHxWQpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDF203717
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378598; cv=none; b=XZRstKLr9W/l/m148ZhmmaCyMjfkMxMe+pdObgB0+o8D4GnoO5WjckztED50t3BJlL8oEfcLZPCCXpxrys4mkGL0TQqMGLOYNW2G70MsljVEj5qyODbnydLAqWzdkgxOLjH4MnKjEVLV6uQq87igiCo08F3lotrHlH6pO4HeLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378598; c=relaxed/simple;
	bh=YWSZYRuIOr1i0hoeKfTzR3n/6mxUtpAWZAjkf1WBpuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqHus8x5gPrdsVNRXmqiU2P/aNSEv3I+QsTCo9oD5hh62RTDDnDvRL2xPyf3rjufpzwnsyIX+66AGQEFiUz2ArBhnV7dGzhlQarpKCeTntVzFrY27Ewkv5YGcaoEvorjGAQiPuc3chWXndz9fNBaUQyr95K+dGWhzxbRmhQ33cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCHxWQpe; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so22161839f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736378596; x=1736983396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mzn00ZfytrdNeZqAzFwZC/i104dlV8ULO69Ct63d0jQ=;
        b=aCHxWQpe1U8lCoxJ2h5T7EAL3UgufVBTDu4pdxw4ff4ei6K+kSPetr8zwIHcH33UPY
         /i1O51okqj3lBpu5XJ2O3NMdUEDtRLhiv89Fdh5Jm79C69YTM/KilCd21e3AplqecCHR
         jYmtGWgyids9x9SNQfqi9QuMkGOip2h+UTE9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736378596; x=1736983396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzn00ZfytrdNeZqAzFwZC/i104dlV8ULO69Ct63d0jQ=;
        b=CmqFG6WJzZxE7Q7SdoZXB4F23CC+PUnl/PymKjNB8t4epxeT91KW/K4o6Kv7Q1392Z
         ShaZvaQG/7jy0eJmjfCYlLWYSyz5sg2es8HRUjnYRVt7aZzSrfYUObBe4FCkJWsntLp3
         zjlUGSv64+FZFl9HB1KpQzGfkrMlhTijKbRLCVkGyxaNHTp00qMja6Co0e8ZchjwajBc
         R6fqmwh/3LJpiyPHF5+6Hmzb8GDpbBfK33fNfzJXWuAqQxXWL6Jitom/lhK+5phakX3z
         HtIpn3BxtNixhdRztgOztSs2Va4mdiB50QAjMKsu/TMwPnjfyKth9YkXpwF3E1zCTmip
         723Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgvANLiR2q83rlyNMwBkkOgLLFa508z/DC3g0bE3TESiCtPw/N4B9H+W+iw9vEZYA/35iL1cvK3d5Qzie5Yv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKJw8xhrRk3cgO2v4BU8YB7fT+RPeZAdsNa2HD0T3QsVY+05Y
	9j/+8u1BmvQALqlkQPnelAS0Ap4S+ugeCfC+br4QVbiweHjiMhyCv9w00hCws4Y=
X-Gm-Gg: ASbGncuXSeO188Rofenx8ZSnAVJNzUEAJW3rw/vKPfR9zeb/JjDxG4wKKcRlhWoBZV7
	xF+v5I9JU34vOA9s1Tkxw/GDpJ89nsQC1N8536crlxpQsYmTVPYzm858I/xEiwIDP6H1Rw6EoQV
	VLE/DMGoeM6JOdTkHo3d9A4CFIb069RXWM3VCcwWsBuT1l8VBU97A3psDQwnabQ43BWwNq9/gJc
	WYDgmb68ha+5YsLmS2rgZxzLwyezWo0KjlV8qN/YGe8dzx9Ok3+Cdk21pLGp/kBXBz1
X-Google-Smtp-Source: AGHT+IGwSBFteg1yBzTr+ht0Vs+wiAvXeihmvJdKOSSEhZm+icx0U5LWV6uYJxFPhp36KnRBX2lrSA==
X-Received: by 2002:a05:6602:6cc6:b0:843:e8d0:a728 with SMTP id ca18e2360f4ac-84ce0092d9dmr490122039f.4.1736378595899;
        Wed, 08 Jan 2025 15:23:15 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b6292ccsm18029173.73.2025.01.08.15.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 15:23:15 -0800 (PST)
Message-ID: <cefadfa1-7702-4cf9-9f4e-c89ed9a131e4@linuxfoundation.org>
Date: Wed, 8 Jan 2025 16:23:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: harness: fix printing of mismatch values in
 __EXPECT()
To: Kees Cook <kees@kernel.org>, "Dmitry V. Levin" <ldv@strace.io>
Cc: Shuah Khan <shuah@kernel.org>, Gabi Falk <gabifalk@gmx.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250108170757.GA6723@strace.io>
 <202501081357.BE10EC4403@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202501081357.BE10EC4403@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 14:57, Kees Cook wrote:
> On Wed, Jan 08, 2025 at 07:07:57PM +0200, Dmitry V. Levin wrote:
>> intptr_t and uintptr_t are not big enough types on 32-bit architectures
>> when printing 64-bit values, resulting to the following incorrect
>> diagnostic output:
>>
>>    # get_syscall_info.c:209:get_syscall_info:Expected exp_args[2] (3134324433) == info.entry.args[1] (3134324433)
>>
>> Replace intptr_t and uintptr_t with intmax_t and uintmax_t, respectively.
>> With this fix, the same test produces more usable diagnostic output:
>>
>>    # get_syscall_info.c:209:get_syscall_info:Expected exp_args[2] (3134324433) == info.entry.args[1] (18446744072548908753)
>>
>> Fixes: b5bb6d3068ea ("selftests/seccomp: fix 32-bit build warnings")
>> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> 
> Ah nice, thanks!
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

Thank you. Applied to linux-kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah

