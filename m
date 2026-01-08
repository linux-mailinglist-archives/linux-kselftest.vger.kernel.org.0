Return-Path: <linux-kselftest+bounces-48558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C48D0631A
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 22:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD6D301FB62
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AF3321AA;
	Thu,  8 Jan 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DE2PoDs8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5C32C33E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906216; cv=none; b=S4Q8IUWkkqNAMY3CtNeSqixGmORqEybxsK3yF3jqR+/yhoZf5QxS8QzA5MdUjBMAc4kpnomES4e5j+HykDzLGGxP6GiumjcYhiPHz/BXEfmpI8XAoHuovo0Cg03WgKHTQ6YlLhkrr0m6HQe3+qrOWM7wNQLJPtcb4CBVT9t64k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906216; c=relaxed/simple;
	bh=/rZyep19aQDD9WNH/j+FEROaPE6P/Ny2r5xve7NTOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBTspm0DokBIVr2Id7v/w/gUUZw68cos6ukTvOJ7/JS31idsF4KXZVFaCpviLGcZJGSGeRPZ/F66QeZXXhRl4m6s7OLpDPtTgWmgUh3rLdDsQxc5f8hpFVlFP/hjzhmM+eJspYO/lvo1qP2NXlTc/vCydrc1MRxAI4f8IGlgbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DE2PoDs8; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-659848c994bso1837977eaf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767906213; x=1768511013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWJ9wlAAp+rcwWYxQycgsvIbLJCcypF3l4SCpiLlS3U=;
        b=DE2PoDs8metig6VptJu3LZaTInpnm0Z+DtAuqPIovbHXtrpz01rIyk768FlPX0As/y
         hXReRW5eXUNzeOvz7T+b22ASJRuncV9IjRfnePkn69qcq3jlaFtbI5LujHr+zAc7XXiB
         BhwHpRyrtP0yAZr9tddXC1NHeKxhpesJOaBLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906213; x=1768511013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWJ9wlAAp+rcwWYxQycgsvIbLJCcypF3l4SCpiLlS3U=;
        b=ILu6uTSn5hEJtMEblTgJdQpwfJIZSviD+V79zB/u314xZnre+depnWcSFl0grjBBSK
         sjtjVU9090tfYRr8tgDoCSTCR0RiUFyGY+7jN/Ee63x2o1IJMbBdFyxywo3ET8E/vR8F
         pdUxczt7AV8Gch1coA8mtdmqWQ7vJvbXt1cGny2MjwLHGXV8SCtH7z3O1X1FLM+UMYVH
         3i7nKFSm4/sxpak9L5db3CA4FuqcPZQMDZA75nB5Xf785wqoaUNrwFTbs+g7gmjLaAgP
         Jtu+bFvHge9haV5VdLx6jpSe65DAwoQpqZqEN+doOp4J7XAP/gAsaix70mRDEfLY5dcS
         7I9A==
X-Forwarded-Encrypted: i=1; AJvYcCUcfkK5ZLKZcwTvVKyekmyokMIdlQL4CMZsi4GHrrleATiq5GF9vemFxbHdYWd/Ss39t1lhT6/P7S1F9F3u52k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfh8TSifNcZLp1vHlDRmN/qqypfL90YuWvJxfS5fK6kTs2RB+1
	7MhUXDOXQ5JbZE8jdQ9ePTrsn4Ic2lHVUQrZn0qZYUn2liATLFe7uadP8OnHnH9mfBY=
X-Gm-Gg: AY/fxX7/mKNXxQT5yojbv+DTlWIAhkx7IYjT26WuIzt9hGrYCij8hzRkN3EIc3Gsbbo
	hr/a3in38sVnKy4Mgi8vPPVeHvMJkwVLKrtYA7BJalarUVobqZ5dcs1zZcS1w3Rw3a5I7loZwTx
	CBvi8TFS+W+kFSqaxoXnR2lhsV4aU6sbtHdZBGgwnnomVuJYsS/7eKp9bWN9rWAsDvBcssH/LVR
	wfJyIezkkCLgMXJoEnZ5BKuLF58hz5RRk/H4P7aFcKzglCuDILJIE8vSH8ETrT8OG6mRZS8xEx4
	5vjcA3mQIUET5ngQOFiMpKnTRvDY4ZuZJ+kGTj+EO0NqveD1+vAATJB3A7wr7IFaXQ81m/++Ycx
	/UbkQXjeEZJdQQVT3Y1NTwalb+PEIuDCxdOoc2dizn5XRs+wo+RGgjVNsvqgGIkUxpGtFRo9gCv
	cpuoUfStg8eYfjJWgnKo+Kyvo=
X-Google-Smtp-Source: AGHT+IF7oBTAj1SQq5E7x4Lp2yS5G+05oiI4AeWK5URw/2g45YlRqYJG+eRpLe6BMKwkyiOICkHLfA==
X-Received: by 2002:a05:6820:160c:b0:65f:1038:1310 with SMTP id 006d021491bc7-65f54ed4383mr3499680eaf.6.1767906213554;
        Thu, 08 Jan 2026 13:03:33 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48beb796sm3583117eaf.7.2026.01.08.13.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 13:03:33 -0800 (PST)
Message-ID: <3d31087c-ce86-4ce2-9b70-f955720a7311@linuxfoundation.org>
Date: Thu, 8 Jan 2026 14:03:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
To: Steven Rostedt <rostedt@goodmis.org>, Shuah <shuah@kernel.org>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, wangfushuai@baidu.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
 <20260107034914.22315-1-fushuai.wang@linux.dev>
 <20260107101846.61c182e0@gandalf.local.home>
 <4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
 <20260108144842.0663008c@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260108144842.0663008c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 12:48, Steven Rostedt wrote:
> On Thu, 8 Jan 2026 11:27:26 -0700
> Shuah <shuah@kernel.org> wrote:
> 
>> Yes I can take this through and send this for rc5 or rc6.
>> But first the following warning needs fixing before I can
>> apply the patch
>>
>> WARNING: From:/Signed-off-by: email address mismatch: 'From: Fushuai Wang <fushuai.wang@linux.dev>' != 'Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>'
> 
> Hmm, do emails have to match? There's times I used a different SoB than the
> From. The From is different than the SoB. The important part I found was to
> make sure the name is the same. But I didn't think the email address was
> important. And this will become more of an issue, as gmail blocks my
> goodmis.org account, so I send with my kernel.org account when my goodmis
> is the only one I sign off with. Thus this restriction will fail for me on
> my patches.

I go by the warning - I don't take patches unless From address
matches the SoB.

thanks,
-- Shuah

