Return-Path: <linux-kselftest+bounces-13991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD428939128
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 16:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149651C216B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED116DEC7;
	Mon, 22 Jul 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCI/FFt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8B16DEC0
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660336; cv=none; b=U3FeByO4wnif2UZ8a9cuSqL6oXnpUQVQ0A+MW1DnHAZlLk15C2TK88ZG1pDNTjFgV4jF4xyZv6NQTBILHBftHvaBkfxQqLDdMP0LiCVIYW8KneGLrACQsMvbvHI0LFevFYnMKZXP8ohXgbyNhAxApSWv1sfrPc3HKo9zVBekuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660336; c=relaxed/simple;
	bh=EUN/EFBzMSj9bfwI9Rdnkw9XfkRSrfVtimnnZX/5Vpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKrS4qGsUKV+G5cuLxKVTYU94+2wmyWfdPDe7VdAXJnUvRr11gwNGLzgg9QISsklQWBFtKQDE5ZOxYtGl9r2Yq4tJ0nCqO5gZzpfwNKFi52/47+qF8eOuZNMZoluuJ9+bHeGI/6ECJQF+BL4DhHuLzkBmlV1ix6EguyreP1oLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCI/FFt3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81d05359badso5961339f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721660334; x=1722265134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqEpUgjYDMhs4NiIbC8QW5rU1D12mQytz+Zvkq4z7CU=;
        b=HCI/FFt3Hn4SlsAL+gYlm8gOODIPoPrJXom+FuRVHFjtQFBAyFL4w6W3xkvnZlyPgw
         32MAqVFFBHOnGYXmUaZEQRrTz6X+DR9O36bkLpVxW+VTqahkiqVLThL+bZtq18CECM51
         cuEFcEkVpUcZbo23nwryXguIQjPMVPfIqF1LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660334; x=1722265134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqEpUgjYDMhs4NiIbC8QW5rU1D12mQytz+Zvkq4z7CU=;
        b=eONnCajogtBvil9fjJut8S+aCp8GrqzoN1V7Qq+89V0Ch/NZeHjCmp1dkfJXR1Tye8
         g/b/QMTSoj69+FQ0TDdUCk8feyz55vqMXED08d8EmrXwkxA8G1qxhQa9ccntwZP4RI8V
         fqn20t1CzH6VhDOJ6DG19wKiBuhHo30mwF8CeGMO2ii1mDbM6DQHfSsQjHOFOeAhWEoB
         Oe95DCxxNNYSOtlVdRZAh8zhrf3RGudz/5nXmtPsnmRiyEocTVR9vdK7hO65fHKNOl0u
         BzzR09OmYJiQY/JqvzD7QSpdvH+kHF4klzEq5fgcO6Y0YAAtGUhRlVcvQXaHfe+/Oapa
         mCiw==
X-Forwarded-Encrypted: i=1; AJvYcCUco7m9EVpU4q3mFGzGT8pSAPDZCbVPerlIWNUCW7kWs+ZOOlALA/bRj+1JKKwguaRMHHj8jyY5bU5Iysu9w3M7BWnsBNKhLRaRwlqL5KB2
X-Gm-Message-State: AOJu0Yxf4sWTW+rSRAXW4SxVM35BZTUFUljNmjhSkcewzGDBhH3MRMsz
	1IH6dR5YpUhiLrTLWJ/rePjvu5aguCFwILJsZztBin00FR4UhkNPD7VGFDJjqUo=
X-Google-Smtp-Source: AGHT+IHVUmuSI77YkBQTWMgdoiRJ7f/wHcI98WIUvKQkJ8yqY43v1AsZHcsxHALnP0Uhpf6QBi4OsQ==
X-Received: by 2002:a05:6e02:20c3:b0:375:a202:253b with SMTP id e9e14a558f8ab-398e7bfdademr41342265ab.3.1721660333887;
        Mon, 22 Jul 2024 07:58:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d15e0290bsm3380251b3a.140.2024.07.22.07.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:58:53 -0700 (PDT)
Message-ID: <abd97c85-c9d9-43c9-b0c2-36f6f0e442e0@linuxfoundation.org>
Date: Mon, 22 Jul 2024 08:58:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
To: Dev Jain <dev.jain@arm.com>, Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
 <20240630151808.GA13321@redhat.com>
 <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/24 05:49, Dev Jain wrote:
> 
> On 6/30/24 20:48, Oleg Nesterov wrote:
>> I see nothing wrong, but perhaps this test can be simplified?
>> Feel free to ignore.
>>
>> Say,
>>
>> On 06/27, Dev Jain wrote:
>>> +void handler_usr(int signo, siginfo_t *info, void *uc)
>>> +{
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * Break out of infinite recursion caused by raise(SIGUSR1) invoked
>>> +     * from inside the handler
>>> +     */
>>> +    ++cnt;
>>> +    if (cnt > 1)
>>> +        return;
>>> +
>>> +    ksft_print_msg("In handler_usr\n");

This message isn't very useful. Why do you need this message?

>>> +
>>> +    /* SEGV blocked during handler execution, delivered on return */
>>> +    if (raise(SIGSEGV))
>>> +        ksft_exit_fail_perror("raise");>>> +
>>> +    ksft_print_msg("SEGV bypassed successfully\n");
>> You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and check if
>> SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == NULL.
>>
> 
> IMHO, isn't raising the signal, and the process not terminating, a stricter test? I have already included your described approach in
> the last testcase; so, the test includes both ways: raising the
> signal -> process not terminating, and checking blockage with sigprocmask().

thanks,
-- Shuah


