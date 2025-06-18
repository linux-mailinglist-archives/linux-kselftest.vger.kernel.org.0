Return-Path: <linux-kselftest+bounces-35323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7EADF852
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DFE4A3455
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970A223702;
	Wed, 18 Jun 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xy3wAJsP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E912222A8
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280667; cv=none; b=ccRKwbRvDzf/GGQB02wkw14rTC4NKvpeHi/LxzMe1XVe/xJ9KwadxFdaf/qmk/T/0fRSanenXUm/UWTt/O1530KJ2j9TxJluXQ633m7mc9DT6v9wL/upHLLtFz/aQgh1BL3Cw5iUZ2xJ6SwPUWAUze7CMQCmmQAXCgeNF//rBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280667; c=relaxed/simple;
	bh=eAveYdp+CJSbttksgnLzBcG/CL/sLj/02iudO8gRfds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhv/3hpzUD5QrWuBoVvYjew3Z25zzHI4GK83+C6rZwU2b838j7vYX+od+8ezDbWiKLzyJQwLi7QrSYca+z1JuT0Fioss/482wp3RgKFEhVruMwWyGJGDNpy9mzpZ8+VKfty+tnxiJoh/BUElEcZkHAfe7SaXKFQwzTthZBIawMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xy3wAJsP; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso1045145ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750280664; x=1750885464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fHWE80S/oA8e+zf9vFMy+doBrDeO1v+Go45/dwU7Dk=;
        b=Xy3wAJsP4soi8r6S3/pqUFbnpFnUgiY8ydVqM5iSi3hjPoN3/x9v1/Ohu1FJ3yf5Rt
         5qwCTQySUTHjmEIa3Hn1eVj4qxA0BXEYrk3EE/TpXH725bHuvwB+7y1qQHkmBTFKvc8p
         v0bhvouTppaAMgEe53UfecpjRgfVW8g3H/PDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280664; x=1750885464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fHWE80S/oA8e+zf9vFMy+doBrDeO1v+Go45/dwU7Dk=;
        b=PBZIzNkK/MsacZ2r3LUK4ffPehTpz4rYZRiFPBYdzSqtEIcOGt0+b+6wQCPcPzQCZw
         eo09ZkR4/1lH7dW9nqTSeGvTp1v9TSN+NvCp6TnLOAvm+iHXahuLdmJpqnRZqiKivksG
         j1ZQuoqVE80ZboUaqp/oWIS9HAY0RExDn0ftHEFwWL+Xv7E45nYYPHfl/e9vqSuOYDsR
         Um+B0eGvlKpCY5alaPXXYRCHLLJTGU1B7bSMXThdNshfExoKGVq4qXSdyYQDVIM1WARZ
         kwTO6WxdvJ3ooLyZHVFdq0MQGzgCxhjeSwDuk8nx6/AgzWduyAsemvP82qV0OzXWKrbg
         WieA==
X-Forwarded-Encrypted: i=1; AJvYcCVVJkL+wwkKxBn7tMKqo3IO0+o78D+mKBTmqtMsj69F2myzKKGwfm1+X5lY8AQUBUSOzcfQ0QftG3pwKQvlPC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWybxzCb8N5Y1lWLuywlCBFh3suxSKzgGmZpjHZnnu9qWIGNq
	/UciMGkL3Uhm/9WawV68dMetWXEGv9wNp7mdPVqcvURAFwa+wKcrVI6hj/OvsvUekKo=
X-Gm-Gg: ASbGncua+O0oooCAYEx+LFAT4yh5Hr9pkmRn9JVOriOQVwu1uxttzKgPaMxwgwQQcEa
	3JjYSxghh4W5su/mbOQWX0xOHQfFk5uLzjayQArfEDd9sSKIzGJCvU3hvdBww0s+ZEg5SflsH9S
	JKdKN6CfLU7/LM6NO2s58wFB7P1eZOVuGxJrnn5XU6kToeJ/+HZ/nVoRXhP18dnd7B3V5tLP/8k
	wc88U17YygQucT1YEKYK+yrDlW+Is5deibz+vJCiMFNZzVIWCeu/SGyqF/N3XFNaOYVBpafriCk
	1ttnrzux1CHcJ7qQRwCQYr9Nt01SoBwO/+yP2FMtwpvP5oMPi9PtxujRnrebOZyeJWSO1Z25rQ=
	=
X-Google-Smtp-Source: AGHT+IHbdu1P2zp30ZzI8fTvGWQbg/H+WwVpblhCbHcKPoROPCuCUpcjOU9o7/bfiqBZJuL/oPTtaQ==
X-Received: by 2002:a05:6e02:2482:b0:3dc:79e5:e6a8 with SMTP id e9e14a558f8ab-3de07ccd64amr249549455ab.15.1750280663962;
        Wed, 18 Jun 2025 14:04:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149b7accbsm2973662173.17.2025.06.18.14.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 14:04:23 -0700 (PDT)
Message-ID: <2606da6a-3a13-4db6-855e-8dcc61c45b45@linuxfoundation.org>
Date: Wed, 18 Jun 2025 15:04:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v13 3/3] selftests/rseq: Add test for mm_cid
 compaction
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250613091229.21500-1-gmonaco@redhat.com>
 <20250613091229.21500-4-gmonaco@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250613091229.21500-4-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/25 03:12, Gabriele Monaco wrote:
> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
> compact the mm_cid for each process. Add a test to validate that it runs
> correctly and timely.
> 
> The test spawns 1 thread pinned to each CPU, then each thread, including
> the main one, runs in short bursts for some time. During this period, the
> mm_cids should be spanning all numbers between 0 and nproc.
> 
> At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
> is selected to be the new leader, all other threads terminate.
> 
> After some time, the only running thread should see 0 as mm_cid, if that
> doesn't happen, the compaction mechanism didn't work and the test fails.
> 
> The test never fails if only 1 core is available, in which case, we
> cannot test anything as the only available mm_cid is 0.
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Mathieu,

Let me know if you would like me to take this through my tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


