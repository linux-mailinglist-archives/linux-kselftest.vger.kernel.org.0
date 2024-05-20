Return-Path: <linux-kselftest+bounces-10440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B38C9EBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B9EB203CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB631369A5;
	Mon, 20 May 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9NkebL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC813665A
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215042; cv=none; b=fOVmtEzGYBWiHHoIwka0vxuxXYoH5FTXRLn1fm4pD6lv+mNq/XW57v8RCBzs1dXcWhmN4Z6JSg/31eH+9P+D0FUrEZs+jrl7HP/PivHIIquEVN7unssxuLERwA6k5YAl4a/jG9c/u+Bzow0Pfc44d1vqTT6/CNFzStxIfMBRptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215042; c=relaxed/simple;
	bh=Kxud4rInQ/uIzpvwj6zKqD7cVG/YMxBM6hnwJWDO3Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4zsesuR9x2QHHrfF1qyOzAvLaT5eWnsXYIH48IAvg1ZjEpMVWt28AitFght/RKSXvCdqx3BgJUbEchI4J1TVeGq5TKLKo8HTSDP+3k6d0GwaNcHp4RVR157c32W5gpOXJKtArCukJg+c5Dx5SCPrkp2u8OsZO/3E7XdiJNK3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9NkebL4; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1df3c0663so14639539f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716215039; x=1716819839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBQNQ9FZZZqvjteJBWF+UbSAu8Fn4cYlBjQ/AkQ61gQ=;
        b=g9NkebL42r+8TquAQvVximMh2Xju3TT4znDAtnS3KoUJY554PkwakpV0I9st2rshqm
         xEWeQMD8WRc6AGMFwgUzuImuF2tnCu+GUB5LcKgtib1DQyjYFBOW5/fbaScTdrkY3tyz
         5hQ0aNrlF6KPwIvmd6JgNZ97XZ9MYxTgbjitw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215039; x=1716819839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBQNQ9FZZZqvjteJBWF+UbSAu8Fn4cYlBjQ/AkQ61gQ=;
        b=EsPH5FLxWgWrwRN2vgsA+WnyB9qTcMUbkahSrkg7nS67y9u29wPbdKehHudt6k5fMi
         evlHCL5vtnbkiG90qvd8PkX6Mu/a9wwMS21jKNiLDBXq87ED3ue9gqDrLbI6kivL/wT9
         t6K7kymEgEXuLsooqnffO2zfKGSjcEq/gf7fsB+zLoyvnVcNOnYpfmc4X0S41MQXn02U
         tP5U07S49NpN5nHrTnJuTg+GFD59QOtJYxwiDFE2oZpjlqk77yaYOhgmPBjoCcbsw7cI
         Ng+5RJC/1EIM97AVFMRSsuP6scmHg4ikOf1f0Bq6iJXUitDrmSu8d2TbtwPUeeLeGcMg
         fAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8t6bFHRfi3s4tlPMQiSZ8/Un9XgRL5MmAf0T15ARxKbLJdohH6Ygq7JsoSU1X9PRk33pKHnxiNWRv+g8RawaeW4sP1sHMLD/sqUS/3Mo4
X-Gm-Message-State: AOJu0Yzhm+iPcx6BRsser4Gvhsqze57XyKw3iPeF8EQQ5l7Dd8P7i5Ei
	AexXGkhFycPEtTMT1OQgmb2N+jURtsyTrI0gQmR3yM9rcZDtdv9UJRJ2GFjDjug=
X-Google-Smtp-Source: AGHT+IHOExpjLNN+4G5/kjDmKREPcV4+VDUq67A82eppucYtUYxOE/4nd3SHNqSCoiAcFlRE57sYAw==
X-Received: by 2002:a5e:c748:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e1d865e82emr2632162039f.2.1716215038950;
        Mon, 20 May 2024 07:23:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700e444sm6409930173.28.2024.05.20.07.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 07:23:58 -0700 (PDT)
Message-ID: <6b2a93f0-8521-4915-b63d-d28d1d243481@linuxfoundation.org>
Date: Mon, 20 May 2024 08:23:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/alsa: Ensure _GNU_SOURCE is defined
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
 <871q6025ut.wl-tiwai@suse.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <871q6025ut.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 02:35, Takashi Iwai wrote:
> On Thu, 16 May 2024 17:27:33 +0200,
> Mark Brown wrote:
>>
>> The pcmtest driver tests use the kselftest harness which requires that
>> _GNU_SOURCE is defined but nothing causes it to be defined.  Since the
>> KHDR_INCLUDES Makefile variable has had the required define added let's
>> use that, this should provide some futureproofing.
>>
>> Fixes: daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> The commit isn't yet in the Linus upstream tree but only in
> linux-next.  I guess it's better to put the fix in the tree (Shuah's?)
> that introduced this change.  So feel free to take my ack:
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> 
> 

Thank you. I will take this through my tree.

thanks,
-- Shuah


