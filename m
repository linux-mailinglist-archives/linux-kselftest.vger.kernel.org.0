Return-Path: <linux-kselftest+bounces-26910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C4A3ACBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DAB3B08D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D61DE3D2;
	Tue, 18 Feb 2025 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRo5pY/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0E1D8A0D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922366; cv=none; b=RUamVzZnIEPFYbM9ip0yKgij8f4WrtSz8xFPUb+auOtg01g0twwzupKYi4pRTJzmxXZlJRwrlJ7RWPt+UKsm4Il0/xDt7oE7knoKL+DcFPaPSx3msItf/SGETbM4avY3R/vGKj7rLKi8Wc34sDI2FZoEWSQx90NAGiOYrja/OOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922366; c=relaxed/simple;
	bh=mhhc0wf/ONFLZ2bacaNQx9TROcDDQUvNWScsp27PYbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+kqmCU6MqdzaamyWrS3srrSw6NbCzgBzim3VFbPLB0JwFl/sGmbC3C0YssdYC/qREkDbaWZDWYxxddpsVgsnk2SYUTv/6pAmM8gotluu60q9FOIX4aP80/B2e3GueNqTzNsOpdjnKmGT1dsPCIenZEl9sioAcU7d4XUS+w5/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRo5pY/S; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so15879355ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739922360; x=1740527160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1PBftf4f0RNI82zXcvqxBwywoZCddwy1ySCBhloYSU=;
        b=cRo5pY/S2ICDo7Ir5UGMrUqR9M0LxuDcZVWVmqLu6Cdpt3iM1dOr6KfBe0808Ovjev
         Hko4rwohBP1gerYN0wQNIxcTU8Dc/wkTGk8pkAbE23FyZ5USsuAmF50G0Is0mMW2Y57w
         2PO1uvpMHm2px1jvP30SzeLwumYSe4+s1qh5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739922360; x=1740527160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1PBftf4f0RNI82zXcvqxBwywoZCddwy1ySCBhloYSU=;
        b=doR43zoTta16TNQQY8DL1aDrVIgVteNVsiVskb+RJohJ2/FoghNRuG0Zypur+BJcKQ
         kgqW32l3Mj778jhB0FFeD7bEvSrOD9paajEzFIUoJ6NChGGnadk6T5fZpaGrSa4wF/Z0
         Cr88YMSXFy1AdHS8HsGzP7ZvSUYJ1iPo8YXxgOJpNMgem5pzX682XO7056kqmWnfUdWl
         TaJp5/qFlT2OlRvZwduzyZFH+bnUlBPnMB4yKrukQl7licwITftG25FWwYOaMaXXDGbv
         VH8KiyCbrKmNj+TVsbJNdIDlGvXoJ505lASvukFjHqm/fOAw1i4Jqg5B17YN9KyAmOSh
         OD6A==
X-Forwarded-Encrypted: i=1; AJvYcCWpIciFfAobWjrSU9XJp6VWdj05Qnprbx8ximLbyAxaI8Y686+EmiHxBM+/SIL0+HzOrua/tN807TYgPAOCXs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEAMdGYsgokVa0+i6K9iQppxTwwzux5nsCeM0nU7g/qnxtJz2
	5s8w4esYLyxqnBlzbGBj257yZ/Kzk0ByYVY/WFkkNFK7kH2qachgyX8119pMnCA=
X-Gm-Gg: ASbGncu+U28s5xFmP1+zvOJiuVkU4w3SZgBtSJH+QyU89gfHSpqs5yHpl4OYa10fmjE
	RtlMKG07xiwI2v6k3bMMHKZ+4C53VcJbRrFqpUcu+X/tB4J7O2j/5ji8vvLxetS/VHXCDkjAcDp
	65LUWmgbtUcyp7fqUpN/YkYx1AC9x9uamwIaEMEmRqlHRO2xVMKu9JyvNGm2sptOnTNgAsyrOPi
	9lJ19Zd/+arBkFek7cS7rBz37yRMZ8KAlH6wxsqsdauIVmm5IPq238Zbx90oICMBMJY6pJdZhsa
	5l0P3R1ryt7K+IWMeE2194GXzw==
X-Google-Smtp-Source: AGHT+IHR4e0nSCl3q8XbogddW2PD8peUhLro/fUpaufhjp9VugG2dLz/OZnLfqrqVUKTOw6xptXN2g==
X-Received: by 2002:a05:6e02:194c:b0:3d2:1206:cab4 with SMTP id e9e14a558f8ab-3d2b535b5d9mr14592745ab.16.1739922360524;
        Tue, 18 Feb 2025 15:46:00 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea0f29de7sm995514173.27.2025.02.18.15.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 15:45:59 -0800 (PST)
Message-ID: <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
Date: Tue, 18 Feb 2025 16:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
To: Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250210075703.79125-1-gmonaco@redhat.com>
 <20250210075703.79125-4-gmonaco@redhat.com>
 <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
 <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/10/25 08:25, Gabriele Monaco wrote:
> 
> 
> On Mon, 2025-02-10 at 15:53 +0100, Mathieu Desnoyers wrote:
>> On 2025-02-10 08:57, Gabriele Monaco wrote:
>>> A task in the kernel (task_mm_cid_work) runs somewhat periodically
>>> to
>>> compact the mm_cid for each process. Add a test to validate that it
>>> runs
>>> correctly and timely.
>>>
>>> The test spawns 1 thread pinned to each CPU, then each thread,
>>> including
>>> the main one, runs in short bursts for some time. During this
>>> period, the
>>> mm_cids should be spanning all numbers between 0 and nproc.
>>>
>>> At the end of this phase, a thread with high enough mm_cid (>=
>>> nproc/2)
>>> is selected to be the new leader, all other threads terminate.
>>>
>>> After some time, the only running thread should see 0 as mm_cid, if
>>> that
>>> doesn't happen, the compaction mechanism didn't work and the test
>>> fails.
>>>
>>> The test never fails if only 1 core is available, in which case, we
>>> cannot test anything as the only available mm_cid is 0.
>>>
>>> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>
>> tiny nit below:
>>
>>> +		usleep(RUNNER_PERIOD);
>>> +	curr_mm_cid = rseq_current_mm_cid();
>>> +	/*
>>> +	 * We select one thread with high enough mm_cid to be the
>>> new leader
>>
>> Missing punctuation here (...new leader.  All other...)
> 
> I guess I'm allergic to those ;) Thanks for finding it!
> I wonder if checkpatch should be able to catch this kind of problem,
> but that's for another day.
> 
> Do I need to send a v6 for this or just reply here with the fixed
> patch?

Please send v6 with the suggested changes. Also change the commit
summary to

"selftests/rseq"

thanks,
-- Shuah

