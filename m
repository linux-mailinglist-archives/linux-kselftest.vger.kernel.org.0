Return-Path: <linux-kselftest+bounces-18141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160897CD5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F23F1C21DCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77E1A2561;
	Thu, 19 Sep 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XADkpour"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B21A00D6
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768495; cv=none; b=tGN8rHt+eKSwSs7mtTpX22uNID42wyj/WfirsaZPjGv4Bt5wGP60DxWuEs0/5r9YbSnvhKDNIBkwNcQF3e/fX6oHs0XxuuGm4B87JHXn9OVRK1n2b/d3FZGoxAdcpkpAppI/QPEnbyS4dPhYbcpz1JV95yoB1AafGzRaVJ68Vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768495; c=relaxed/simple;
	bh=+uSHXyeK9o2xt9zzLMo0Jc/jKcrLzDC6sQDqXaS0k/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLXKUrxbq/GbuG0IhoII92TYp5YPfH9IeS3nwCKPl//DHK1ltqyLLvNQU9Yds8FUszrIlCOAyu61hOjiaV+StT/W3kkQnMj0bzMtkl7hRrT+mNzWTCAn6yVC3NlUyYSl61DiFt0pH/yi28t2NzmM16sIH47+ZTeaje5+dWtFC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XADkpour; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82cec47242eso73913939f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726768492; x=1727373292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWbHnu0GkwdDDrDlGgJSAqJLAQE3SbHqZr6NKWo/pX4=;
        b=XADkpourIgZJmvVfgvZtIGqGIhNxEFYCCfN3OZSMRTF6MyJTvGzm13anlOLpXrYZj+
         444QNwL2T9+9uplWK6/lpW4LSSmi0c6z3T9h0gf6gS6pglQJyzHSeEH/sLmvKmabfs1O
         ZCD+79v44Y62mUiGcMiS1hmHi2aiyse1NKxts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726768492; x=1727373292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWbHnu0GkwdDDrDlGgJSAqJLAQE3SbHqZr6NKWo/pX4=;
        b=q3ENOANl5tO3JjmxWjzqsnFQByD7mb3NQDKz0yaCpNNG5Obi+YS3je8PM0ua7fpgQZ
         Vsy7zClanShrTEaHPwae2kDeZyUab+jdgI38TGlDeIc5EjRZBTQzMLfQ/mvtwmo8Nkmb
         YaUE+TecX+XzlVqnq+FnsftcQ/aosBSM+4YRSAgnR3AI0Qv6XpnnCNxl//NhZsXEeixZ
         cpWGltaDyK7qpmaIYOTmduu/NsFS0qPxT4JSs4tJb1GE7EfduDwi4FYRK+JsK/H0o9OQ
         vMy4odobmBEHm+ahSJc3g3jCloxnXyzagk7ENngbF16BDByniiJqcm44+bf0j7rNwKrT
         3aIQ==
X-Gm-Message-State: AOJu0Yyf0Zcyi6uSVES1+u58NHUJR5dGMgpgwnk0rOoGuUX3xuZykgpk
	av8AEJX6+ZucrnnPdGXWgykVrOykJpLdwRASMeCbh4anJOh1IZPDaTz8Qs0y1D8=
X-Google-Smtp-Source: AGHT+IFLqc5b8Len2m8KMBL2kbppQL/8WXYSVXRuBSJX72Q0tMxMeM4QltJPMqnnWdlYUrtxj+9DSA==
X-Received: by 2002:a05:6e02:152a:b0:3a0:9f36:6bf1 with SMTP id e9e14a558f8ab-3a0befa3b42mr29411775ab.9.1726768492309;
        Thu, 19 Sep 2024 10:54:52 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed34d9bsm3095263173.129.2024.09.19.10.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 10:54:51 -0700 (PDT)
Message-ID: <713d7e8d-e6d1-4438-a47b-6bb95a4e1c61@linuxfoundation.org>
Date: Thu, 19 Sep 2024 11:54:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Fix clock_adjtime for newer 32-bit
 arches
To: John Stultz <jstultz@google.com>, Khem Raj <raj.khem@gmail.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240918004731.3295870-1-raj.khem@gmail.com>
 <CANDhNCoY=tvhWFmY_dZGqPdCiTZSDX3cet7qQ00zvSUBFHXLNQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCoY=tvhWFmY_dZGqPdCiTZSDX3cet7qQ00zvSUBFHXLNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/24 02:58, John Stultz wrote:
> On Wed, Sep 18, 2024 at 2:47 AM Khem Raj <raj.khem@gmail.com> wrote:
>>
>> Newer 32-bit architectures e.g. riscv32 are using 64-bit time_t
>> from get go, they have not wired __NR_clock_adjtime at all
>> valid-adjtimex testcase fails to compile on such architectures.
>> if this condition is found then use 64-bit adjtime syscall
>>
> 
> No major objections here. Though I'm feeling a little forgetful as to
> why the test is calling the syscall directly instead of going through
> libc.
> I suspect it's likely due to the test being written prior to the libc
> implementation being common?
> 
> So I wonder if a better fix would be just to drop the local
> clock_adjtime implementation here, as I'm sure the libc has similar
> logic to what's being added here?
> 

The proposed solution works better than adding local clock_adjtime implementation
here.

thanks,
-- Shuah


