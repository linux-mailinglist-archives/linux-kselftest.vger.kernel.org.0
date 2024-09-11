Return-Path: <linux-kselftest+bounces-17756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236159757F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF139285E83
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A971AB6D2;
	Wed, 11 Sep 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhdS3fDi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEF19CC05
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070864; cv=none; b=irBKQ3waT3rnvCMhYmyrMRdp1hscjGKo/l91cat12/2J2CHF723vNj/jZzodx5OckqZCjAs72O0Y/iR2rCFsqi8G7QhvDWPg4+8aoM4Tnap4xc8SN+KMh5F6FUpAReS4bHAQuYMJRvw/D+rttWfuC4wGpp2WXRecmNf6CFlD3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070864; c=relaxed/simple;
	bh=gGSZGUKeQVT4ZwzLlokUxbSN1eRYqJmr3gBNVK+rgJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEpqP8g/vpffCnSFRHgEM1WwTU2gvS8duVlCd6iOSxPQn/Gu0e2fLnObugLIUHyx6oi+eX2sfu+pacdqlbQwDOXEtMnEdHIkx/jLgj26SMz7zSBO0tjljTnYDLYC1laf0xvrnjY32TQ1U8fCYfY7XJA6yvfY4uqM9nYMUSJhmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KhdS3fDi; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso316213139f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726070862; x=1726675662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KatlnqVDdtDHNzA3/VvJS4Anj9gvfC556sbE+09mqc=;
        b=KhdS3fDiMMLr6ieI2Ou4nUYXcnKrBA1uRtI0AiQDUBM1FVIaBfBfoTSlySlSn3DQxs
         RtqlMXTkCFX35HaxIhdYYPmWVbdMW82Rj4r30St1BlaZVcZSxBuvYcoLOJcdUO4q6cnu
         EslasYnnZrUsD+DzLGO2V2ujjgdH5oEQUu+nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070862; x=1726675662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KatlnqVDdtDHNzA3/VvJS4Anj9gvfC556sbE+09mqc=;
        b=llEkEQoR8YnUl1tGnnkuG3aZ1cYuWzco4T9L7YWIw1K8Dfm+yc+MlwAhwGuU/uSW5z
         +xYiTyjGBdzpqVxF9S3vNfTcOxlRMvNwa7CKCAax8XD4QnmRwbYxYrZasU3ptvNh62ZC
         wF1LC/bikBnbE6Ojb6JVvdUcH80Qq/DYSVoboSMHsr7aEL7mQHbtl1t/SP1T1cHNmjHy
         rQmDwb68oWTE7aGMihW3qtpzwDWhRRixIF8iHn0H8DF9i65HtbUH5Ekh/zrO6eontlAH
         Z0PyvfEYUpqUHL2cbkzgVtfF58oqicAkI/sxNAUVhp7el0tGBDjTe+ZCwPjY9ZV6PJfR
         CuFw==
X-Forwarded-Encrypted: i=1; AJvYcCWndHNbTHxhrJur0FA0ZXlowGOpP0OcYvvC5Xo5g/7W1icSaHZKocAXnuXnIyd+DInqv7PKTqtiDZfDGk+9VDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVceW4ISmJrArrcASkSjyvX/Gu5NtTbpyqztZ6rl+0S65ZDeI
	LIMUp9BXfwi74mvif62P1I5WxXmX+ab8XmMvIMHWvrgYH1NfOXXaNrvDfaaoYho=
X-Google-Smtp-Source: AGHT+IEtx7ZNKIzeVnQ3i3tBxUubPcG6cNPINitY1trPy3JPEme5x005QR3erw4KJL1JQ4gK9UAsaw==
X-Received: by 2002:a05:6e02:1ca8:b0:39d:300f:e8fd with SMTP id e9e14a558f8ab-3a04f06c881mr206357585ab.2.1726070861691;
        Wed, 11 Sep 2024 09:07:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8da6cdsm56731173.121.2024.09.11.09.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:07:41 -0700 (PDT)
Message-ID: <2df38d7a-682e-4af5-be01-67adb6fdd5b0@linuxfoundation.org>
Date: Wed, 11 Sep 2024 10:07:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger
 than the system
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-3-vdonnefort@google.com>
 <20240910124555.180428eb@gandalf.local.home>
 <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bf48db12-1e97-4690-b733-bad6b2363edb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 12:50, Shuah Khan wrote:
> On 9/10/24 10:45, Steven Rostedt wrote:
>>
>> Shuah,
>>
>> Can you take this through your tree?
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Yes I can take it through my tree.
> 
>>
>> -- Steve
>>
>> On Tue, 10 Sep 2024 17:23:35 +0100
>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>
>>> Handle the case where the meta-page content is bigger than the system
>>> page-size. This prepares the ground for extending features covered by
>>> the meta-page.
>>>
>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>> Cc: linux-kselftest@vger.kernel.org
>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Vincent,
> 
> Can you please rebase these on linux-kselftest next branch and
> resend. This patch doesn't apply.
> 
> Also please fix the subject to say:
> 
> selfttests/ring-buffer

Once this is fixed:

Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

