Return-Path: <linux-kselftest+bounces-11020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B78D64B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939001F24991
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86344D8C4;
	Fri, 31 May 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btPSd/5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDA57CB4
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166517; cv=none; b=lZevb7eZ79KLpp9HLHuDup0UtvP8sEK+FREVtlOXMVy/v4PzKk41GkFWTlXu/57YWfEN30j1mQp8gEh6Q7aoOXhu6ZiY8H95QUfppg5e9lOkbxjqa/zGeEeLqwWsDRp9f051m1Kf+SHf+yOd0rVC4+ySkVCEBBB2qrCjNAXEaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166517; c=relaxed/simple;
	bh=8N4Uy4hfNGQeJYMhXwYP8HHYJUaM4nwbu6ME4Nq7pIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyuhNlZBMdLbv//m+baDxOUoF+S5bp7rp5Zwj0BEYWj99Xq9/6dLqiLkJtuByR5k4yENwhnAQkpp7dzp/T1So8dUpUjeyCzrU+rLpzT+BIfo04PTD102oDMGu2SIDliJPY58/CwmBHbdODILTQaFGEhjCpoYT12f+p6wwv8aWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btPSd/5c; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e24bcce578so13173139f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717166515; x=1717771315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPAJXLuoxd2SK/byJSfbPIINKV2PiEIqB7HOimxozzM=;
        b=btPSd/5cgXep/twtjBxlN0sPFoMYyY3x9BmuVog5I4yhFr41kzKqmuEEhwAGVTFxiE
         VhJIHuZi9d8ryj6m+dP/6J1yhVmEqDxkNZLO0iWqw4IdjTYBU5FtB7FeP/2L4XyW5N0W
         DcIDt8fM6RnuE7T+zVJAbyBWPS78ZxAw1typU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166515; x=1717771315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPAJXLuoxd2SK/byJSfbPIINKV2PiEIqB7HOimxozzM=;
        b=hmBVQ8D99oQ5uqFNxVQ+lvVH2j9sBC3BTANSyxJLmcmccLFd+V27N5Mm6LZTgewHi/
         KL+PMp2opOLQBr7bBQMthz8ySfGcDTePaTP4e6eyOTxuO6hSNPubDuFRS/7o4gO+NPxT
         TSKoKYbZtRaa7SL2W7pduSF9odxoGp89vwZ0hnCTb0D7r/7gnvEtZVk01Z7h0+zMbZy4
         QL7FpIQ9FGAi0xzMYUVRvX9MjXzrmAa8tK6WYtuxmSGtjgMcS52jgIfMbfJIwtSHlgGh
         LK2K9yzzyvwMMOdV0iRH4ECgvU40myOrh3AZCD3619qLpQ2nDkV7VSvB8kgh4FrEBX23
         Mt4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvkLg0VhdUiVSHXwdhUWLgmMLI5FhMLUzyPsvlZhtYzzVBGfqngvw9ykP8haJkRjcOGqZzGo2UsEjW1ArCK9q6TzuZV2n/+eG2flw4/R5W
X-Gm-Message-State: AOJu0YzPkveHAT+9MPN+BCurA1qCD6PwraBhiYlOANEFHQYYgAlYdoev
	h4TTDoPK/oV8xd1rhHm+oxAagMMUJ7WjoVPxKtJWRGxoyKML8cvyvKTL26z7RqCWR0l5RhSov5M
	e
X-Google-Smtp-Source: AGHT+IG3dnxtFX/O6HOtneBr+kVaD6kMk7E+Nl3USYm/ynLDRSimUh2lFGqyh96b0i8s6EO6E3NYIw==
X-Received: by 2002:a5d:8485:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaffdb5092mr237075339f.0.1717166515426;
        Fri, 31 May 2024 07:41:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48c4400afsm503109173.136.2024.05.31.07.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:41:54 -0700 (PDT)
Message-ID: <c59efdb5-26d3-43ce-8390-fef349fc9d1b@linuxfoundation.org>
Date: Fri, 31 May 2024 08:41:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/tracing: Fix event filter test to retry up
 to 10 times
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <171714860864.198407.18416314586430149538.stgit@devnote2>
 <171714861780.198407.16488694516653649947.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <171714861780.198407.16488694516653649947.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 03:43, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit eb50d0f250e9 ("selftests/ftrace: Choose target function for filter
> test from samples") choose the target function from samples, but sometimes
> this test failes randomly because the target function does not hit at the
> next time. So retry getting samples up to 10 times.
> 
> Fixes: eb50d0f250e9 ("selftests/ftrace: Choose target function for filter test from samples")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah

