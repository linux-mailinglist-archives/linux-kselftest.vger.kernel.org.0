Return-Path: <linux-kselftest+bounces-48431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF88CFF97F
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 19:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD073019E1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029737E2F2;
	Wed,  7 Jan 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e3CuH5eB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B8376BD1
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806912; cv=none; b=f7t76V8RWT7U1IwsW5o9sAAIr73f6oB/kyRjY28ZdeMWVdyJmIkM/b9KriJE0OomggQvOlXYm9DxVkY7pE2CWXApzvfujfzBPzDHmvOQkSTt1zWjd/lb0pg1C7p7gUbKJOgr+BCqW+ztqH+UI5bqS928Xf6E4odS2tvO9WXmxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806912; c=relaxed/simple;
	bh=oyXEsXlh7BGPUY9HjT3nxQ6TtZhcHPwF00+7QY+04oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDsWAhw54j/TEJBtEdjo7uttAcL3EulSsG4iksej2pNe8L5yZw5yO+TPTFW6GQgtJ2+d5TAjHW4enjSnGOqXf0rx7rrwrJ5YQRNh1VgLasi8lODV3V5TKbcn5ZO/b0vQmJ8LF3r8TBSEL4URTG+SO5teMou3e5Pt9U594JEBcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e3CuH5eB; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cdae63171aso1575890a34.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 09:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767806899; x=1768411699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFfDcQX8Wu0We08AMqEf4Lbij99od42IKWQOPTmhZ/s=;
        b=e3CuH5eB54kEpXUzVxTI3WU9ScfttwTCQDxzmyU1jaZd8HJLd4rvtqcUn3eG76Yr7w
         lqXAiWWaA3FjGD8IL2AhbQCb/pet37yxVQvtuahKyhBHLKqly5TPqI5xKAm0r6IEFjM4
         mMDzc+MdHry10b8gQlBrZpE88jdf43RkzHEqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806899; x=1768411699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFfDcQX8Wu0We08AMqEf4Lbij99od42IKWQOPTmhZ/s=;
        b=t7Rma8GJc0xTNp7zWLTmZFSWnxWQR+ec2cU2P950sb43KggzfHG3aTeUb/fEIlvkNV
         yK8rzaZrmmIc+0guR4un7LWgeVvFCJusOwor0zkCCfykmVJ83iIvuNphADKP/r5yD3WP
         ZU9ljTZWa86XwoYTRbItKg8ctFw7sR05MhYa7ajR+qj993sLhv2GOixhPEr5PqH7k4oR
         e9GCvo3sNLUPejpfx/d1CqR3eaFblBNgsmZchGCz3LbG2NH9foe0J68fCItzoOC6xa0F
         WdDMITs73nxuWKusormuqn4wnAfqJw5aC17LoMkHKrynkYMhqOuKlmVD2dwkd/KCsIap
         umlA==
X-Gm-Message-State: AOJu0YyB8zcrwQw9LkaK7MZvFRf4ESxOXRP+1cUnPbXcw1EMxcQSc5qq
	20+yzDD3gsLguKE1/2W/IDNdt6WYLci4Jzj34Le+chF6ptVclI/uPgYSi5kyA5IliWc=
X-Gm-Gg: AY/fxX57/lTwEpCOzTIZwm0mf/9xvtlO19uapIQfd05hqC3lIHfNROCWx9c1m/L/1KP
	Ku1+XKKp8S5bs1fFtMKD0qMxjIsYNCFw+pgWOD6ro8yoxfeffJ+9z1PcNAUSeUdJphbKRwgwhGm
	6+srTsiyjNHRg4hYvG/mfmbQ4A/Czz63h7HnB41yKJ9rwZwjtj7ncug/eVdMjVIZbHN2IjNdBQR
	i2Kksum8dVKdnIx2szsAAnCK6J9zmt6VCVUE8DAh+uZd+6ne/G3ECPG3sWAKdozEZSL+Mc+RGMS
	l4wixUVDnAP2Vh56GNepSazIA6R8J7n/Ry9S2FGNnxy2c36Zuli63NHYldHtZquc7m0jv4JMSqM
	NHM11UL5Og5tttwqOT1sEwshDzaVdgboqjsrNSLkM2hxmnOK4IItYATkOtMPc9zzXi0SNVxMpS7
	JP1+MHFlgdU+ZuQ35/YcIE5VY=
X-Google-Smtp-Source: AGHT+IGY01vSxeVDGeg8pnh4TwvBfewX0HCW4RQqLDBrFqGx39ZRnomVQXopJ3yhbzyX7t84YcdlrA==
X-Received: by 2002:a05:6830:411f:b0:7c7:6850:81a2 with SMTP id 46e09a7af769-7ce50b57c2cmr1792295a34.24.1767806898931;
        Wed, 07 Jan 2026 09:28:18 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4762eefbsm4098985a34.0.2026.01.07.09.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 09:28:18 -0800 (PST)
Message-ID: <8f7a03a1-7c5a-4a98-978d-e5ae9c926036@linuxfoundation.org>
Date: Wed, 7 Jan 2026 10:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kunit: tool: test: Rename test_data_path() to
 _test_data_path()
To: David Gow <davidgow@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260107015936.2316047-1-davidgow@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260107015936.2316047-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/26 18:59, David Gow wrote:
> From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Running the KUnit testsuite through pytest fails, as the function
> test_data_path() is recognized as a test function. Its execution fails
> as pytest tries to resolve the 'path' argument as a fixture which does
> not exist.
> 
> Rename the function, so the helper function is not incorrectly
> recognized as a test function.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20251230-kunit-pytest-v1-1-e2dae0dae200@linutronix.de/
>   - Rebase on top of "kunit: tool: Add test for nested test result
>     reporting"
>     https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=0c5b86c67fb6898d02c8f92de884186297fd302f
> 

Thank you.

Applied to linux kselftest kunit repo for Linux 6.20-rc1

thanks,
-- Shuah

