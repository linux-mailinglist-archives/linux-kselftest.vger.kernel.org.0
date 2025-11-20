Return-Path: <linux-kselftest+bounces-46132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E3C75739
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9AA64E050A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717941805E;
	Thu, 20 Nov 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qna/Gj5W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53126F2AB
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656833; cv=none; b=qtViHno5INASpaQYZtazdXh9qLsnVe+dCkWr2H+61oyV2XVY5HjVQ1+rgC7CZpt6w/tzVAWtJKXsj+rSSTTVhNt8KzjqYTF4MnsssqpJv2TsuQ4kk3J2CmSY82aJ+o+DJR15fAYuIN1+m0nn0HkxkP++2hpal4oth/h6sNNQ+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656833; c=relaxed/simple;
	bh=0rLW36iyOf5x4MMAHLt7ZJRKB7UhffR6LbUm9J0KINk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qT0Vqn3b5HQLekyP89+maDkVAA+jNmajopCufoL9ZQQWFN45KZYVR2r5p89is1IuprwJFxNsIH0+Ka81fhg1TkzHwJM2KlnjxzDPJcLUbyNdYFZQHUqo3LTzxzg9G6+ccvW9/aEB1IUTEIr+4nA00AvxpK7D90fCKqqCGTttFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qna/Gj5W; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9490b441c3bso46754839f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763656831; x=1764261631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aa1AkRLymUeMfi+gvxg2H2c9FzoNzzQchV4cefwGG74=;
        b=Qna/Gj5WikmcXneAJgNzupCB7vXhKIHbcGbe4Bih3eqOVfOfgFryRU/AxsvGtM+Y6M
         AZJB+QdIlY8/Hr5Ru+9kN+wWZjQiwIRrKy0P86l4zGtK4nF1cgI9U1453OyhrGuSm7UX
         ystIrTkBybvrwjkPtQiYsHpV0uFpDNe5/VEO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656831; x=1764261631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa1AkRLymUeMfi+gvxg2H2c9FzoNzzQchV4cefwGG74=;
        b=CsDKONWs7XZynAhRm9vPUlvUbE43usgAnBou6wFYdBC5H43nvLWD0oJ8GM+D0Uzbfl
         XsaKK+adnrChsMcgiyXWip3SEjTDw0MXgTK1j5rIKShcqiXM5KLfsntvsqjegduxE77Y
         QsktEps2D340VN4zOz5XEzDe8yFP9a/3fVqzQ8ca8db837NTj0DwnCfJF1qb9H6ufjWx
         nqboNf6VUfBXGd87g1kD1pJ9rw6VnoJsgYZadTFhKXUT1TkaDrCLRM4/fjvcq4yoc6gn
         5LFUHYxasd11bXFn4ccBJ/WrjrG0snuJMLZqr9PI0IKYYKrxX/E/dcXYDH7jP7rH+fiW
         aZSg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/afd3T1O4jsGQZ9failWktEgwsJm2vKum7Xk7JpEbvZQv4UGVBS961ysB0WMWrOwZ9ML3JK5qSez7kSKLic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TrdZqHMiAvjp6cg3L1oH9k+hQkvkwF4ihtcEnEozT1qbC5vK
	rWHtjJWkXekRn1lgPJACLocMUaRrnlETHecx/O4N6Xiu8zqv36Oh+QO8DLbR+qCUn3EXap2gDm8
	HQ4Jc
X-Gm-Gg: ASbGncvw24kyBGnk7gg5woSjn0anAyzhEA65iYEjQ//pIUZQyJQtHOihA//YF78nVb7
	PPM4tMvx1t5uGE3kIumW7wwftMVOA1M2HgxVljH4YR5lUeRYcHei2zGWkOWrRZt/nDLcMQQ/+5r
	o+kM8IBycQenrolx8cY+tTUyQ1Ab3RE/UGXylhPdTXZ1S9BFYgvGW/LdnMJ6eSD4zuplJkVCWbl
	kNZBPugALBcAa/W7B8inRbLre+0A9KU2Q03MPc6iAsLPzaxK+W/wsnPm7KKyDERNeUnYFFBJiEG
	ubEWROX4b3zc05puoqRYPU0w1G0FIQhOjahlUYRSBbAfqPS8qZdYncgOjQaPPELUf4tseadykrR
	fgM8D1XBUFzWraEBcJDfHSnJr1LJdisw7Rn6YITGH6Tl8pb6Hy9bvDm1ro3VS/U7jNPGyxlN+lh
	wlmriRWGSm55UjV+fKzy4XGWU=
X-Google-Smtp-Source: AGHT+IFsgTAAQrcv0Z7q9/prVRarkjR54xZam1Bd2zaiU428gFS16ceXIp7y0FoUhB6GTW5mK9UwtQ==
X-Received: by 2002:a05:6602:371a:b0:949:15f:6226 with SMTP id ca18e2360f4ac-94938ad740fmr250309839f.16.1763656830706;
        Thu, 20 Nov 2025 08:40:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385d34a9sm108901139f.8.2025.11.20.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 08:40:30 -0800 (PST)
Message-ID: <f0774852-fe3c-4236-91b1-f38045ea26f7@linuxfoundation.org>
Date: Thu, 20 Nov 2025 09:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Add tprobe enable/disable testcase
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176252610176.214996.3978515319000806265.stgit@devnote2>
 <f5f272e1-e164-4bb1-bfd0-42edd5a125c5@linuxfoundation.org>
 <20251119170611.6eff8df7@gandalf.local.home>
 <b61a339e-f80f-4ecd-861e-e9bb834d5101@linuxfoundation.org>
 <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251120102526.e5e9332fcab1db3ce18c6d15@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 18:25, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Nov 2025 15:56:57 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/19/25 15:06, Steven Rostedt wrote:
>>> On Wed, 19 Nov 2025 14:44:22 -0700
>>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>> On 11/7/25 07:35, Masami Hiramatsu (Google) wrote:
>>>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>>
>>>>> Commit 2867495dea86 ("tracing: tprobe-events: Register tracepoint when
>>>>> enable tprobe event") caused regression bug and tprobe did not work.
>>>>> To prevent similar problems, add a testcase which enables/disables a
>>>>> tprobe and check the results.
>>>>>
>>>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>
>>>> Steve, do you want me to take this through my tree?
>>>
>>> Yes please. Masami's an official maintainer and mostly handles all things
>>> "probe" related. This is his domain ;-)
>>>
>>> Thanks,
>>>
>>> -- Steve
>> Applied to linux-kselftest next for Linux 6.19-rc1.
> 
> Thanks Shuah! This and other regression fixes is better to go
> through selftests tree because those are checking existing
> features. Maybe better to add [PATCH -selftests] or something
> like that?
> 

Let me know which ones you would like to pick up and apply to my tree.

thanks,
-- Shuah

