Return-Path: <linux-kselftest+bounces-29349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05EA673EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 13:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE07D3BCF07
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D020C026;
	Tue, 18 Mar 2025 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTrh2mK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08D206F30;
	Tue, 18 Mar 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301123; cv=none; b=oYbb0jzjoLvh5FWMG1hmUs7Y1jsrQEHqMW47zOdKH6GPtJgplLJz2xLUS/8lZz015L0IQSIi/eTtnDaqdfDGLW8VIhsNUW4610XDaizLySiYLAxkZZJo+qKFIxjM1z+KDztoL2a5XooEZvvmCb5c4bs3u07+mb4AsmrUKYXL1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301123; c=relaxed/simple;
	bh=cLfm+4fK+s6zWJcATQySnUaOdZ8yuPQAZU5AfUUt7WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqLGQsnC4ZpNGHUCPVcQgS3DIbheZ+Z3iID5/RaMfWl1nrBQgulq54d/JiN7GEhUqXyUsPXDk6+vNwvSR1bKRFOAkJjiIuSDd7G5+GOKtfJVwRBj7xDqRHGXXOvtgvvm9C+o1XM2JOTqoJkRz25EjL8WqSYfrFJjdQmaA1fRlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTrh2mK9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a7065ff8so7384755ad.0;
        Tue, 18 Mar 2025 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742301121; x=1742905921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNO5RhKHoNM/Et9CKdfMz2CoHIP7I9oIlTXW6Ic7ssM=;
        b=XTrh2mK9nMIutknyBqDbwDaq7rTIjgAIxcHmxOjNz16aifEGNkIdD42wEzzvreLW8c
         BVBYvAPrBQ4VwLXragLvZIh38K/xpgVkKk4/72hT+Q/ZdJ3H0BytnVxltqtajlHxxngP
         fn+XKRKvPCR3Pjv6xsRrF40C31jJGz2s00CNjrJ5uXKeG3mhbivSx7YxqEDkAWLrGelT
         k20mANK4TWNXY90cEmWlF0HAL89zngHFJMzvNJ1a/sJ9alGSkrb78E5WbpLO+Prwuslk
         7B0WKIOtRsoLQevJew6Z6dT8txS567urCoL3cKaghGBlxkQiMFeUSolShuNe5NbaFvet
         B59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742301121; x=1742905921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNO5RhKHoNM/Et9CKdfMz2CoHIP7I9oIlTXW6Ic7ssM=;
        b=NU3K4o1m7QQW33k31m4uvgaYP8aG6pTJvNZTu67sp2/5ttwcmp3CjkTtbCcvW1unNM
         G+as8DtGVJlTrG2c7GtV16erN7+LR1eNENz98s5HNm+d4hvOieFGsA9C+vm5pWQtd1YT
         rfM2CGjXXYeq3HTKe7vjWtmGQerY0j3y1NuEGR45VELN6ZmXljtUth81daYESuNNxyaK
         q6+nc/XhLqYS9WQ/fC80pWMI55Om3seSmcEltJ3aDAt8DwvuMMkK+rsQf7M/MoeWpDri
         2nOqqH4EWANX3QgcSdHmZyPAzwb6M5cANXEpVCAPS15LzUcb+bru69o7C9qPprMGgDgb
         wNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUpVDyc+nSB9Th2qMMr3kOl8+Ti652lOAT0UccGC/duGOt2dJF1ohz2+6V1CNTQF5B6ZpkiePbSp1/2Fyq71P3w@vger.kernel.org, AJvYcCV9FnuGBpMBi496tstll3vbRIziB2GjVqLwhX/6D0E49AmmSYw32zdwPIXaMw9+wbAmI95eyGOxIoW/51cseA==@vger.kernel.org, AJvYcCWeBFhgVBO5gX8No3ir4QbatB9D/Qvs2eagTbieemRztHL5SfjWfkeluFE6JLhf7GBSte0E5bGH2ckbZig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2Yig7z1VxvhfnzLQkISwlZ8mk4nM+MdH/dRo4A47gPqseTP+
	X607+YJ45KWfKAa0BPVxg80NXgZBGd1e8DCMYFnaCZP7I37PZflq
X-Gm-Gg: ASbGncsDfIAaGTPZ4ZtnkxOlQsOYNIwAill/lvhA4pN0VNivB04lnCsjuePp6Bmg0Q+
	wQXplFSIirIsi567xs670akPpzmlPg/L6J2BaHp4wcdJoIZJS1hkDe26EcS4QsyKvSN3+efculh
	c764jir+hGr0FBDqtsD1vPEHXFHeeHDCJwmvSQ1ium4xamSWI3pDwOUUV5gBo3/NSoYu2rbnABK
	ldmF7W5E9EFSybXHGkh/wtSbJ8mXWxp4+TpOnUY4kiuRZklkaDiOqxZgU7z2UDxvC37Qz91Lm/Z
	YHKX4Syr9Flf/0iri8chk4VBageBNkDU3/irZ8dcs25EVCN0E/pHHSWgN/Fy5QnrCBaivl7ibWs
	Si3afnlqVhRr/A0/oJDMu
X-Google-Smtp-Source: AGHT+IGgFaAuldrGzn86KbwFdf8C1DRylZSl04Q0/ZSbeO8+Fqz622IjQfP1AC2cNkgt1PnP0zgqSg==
X-Received: by 2002:a17:903:3c6f:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-225e0a62f48mr232648405ad.1.1742301121378;
        Tue, 18 Mar 2025 05:32:01 -0700 (PDT)
Received: from ?IPV6:2804:d57:4e50:a700:f33d:65d1:e22e:109b? ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a448fsm92895865ad.72.2025.03.18.05.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:32:01 -0700 (PDT)
Message-ID: <a0ec3ad3-1e49-42a3-90f2-add786f13b25@gmail.com>
Date: Tue, 18 Mar 2025 09:31:57 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH 2/2] selftests: livepatch: test if ftrace can trace
 a livepatched function
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>,
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, felipe_life@live.com
References: <20250306-ftrace-sftest-livepatch-v1-0-a6f1dfc30e17@gmail.com>
 <20250306-ftrace-sftest-livepatch-v1-2-a6f1dfc30e17@gmail.com>
 <alpine.LSU.2.21.2503141411010.4442@pobox.suse.cz>
 <6d9b9394-690b-49a3-b8df-7ef510c96c00@gmail.com>
 <alpine.LSU.2.21.2503171006260.4236@pobox.suse.cz>
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <alpine.LSU.2.21.2503171006260.4236@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 6:07 AM, Miroslav Benes wrote:

> On Fri, 14 Mar 2025, Filipe Xavier wrote:
>
>> On 3/14/25 10:14 AM, Miroslav Benes wrote:
>>
>>> Hi,
>>>
>>>> +start_test "trace livepatched function and check that the live patch
>>>> remains in effect"
>>>> +
>>>> +FUNCTION_NAME="livepatch_cmdline_proc_show"
>>>> +
>>>> +load_lp $MOD_LIVEPATCH
>>>> +trace_function "$FUNCTION_NAME"
>>> trace_funtion() calls cleanup_ftrace() to prepare the test. Ok.
>>>
>>>> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live
>>>> patched" ]] ; then
>>>> +	log "livepatch: ok"
>>>> +fi
>>>> +
>>>> +check_traced_function "$FUNCTION_NAME"
>>>> +
>>>> +cleanup_tracing
>>> Here, I suppose, cleanup_tracing() is called to clean up after the check
>>> above so that nothing stays and more tests can be added later. Right?
>>> Would it make sense then to call cleanup_tracing() in
>>> check_traced_function()? I think it would less error prone.
>>> If needed, check_traced_function() can always be upgraded so that it
>>> checks for more traced functions.
>> In cases where we need to check two or more functions with
>> check_traced_function,
>>
>> if there is cleanup_tracing, it will not be possible, make sense?
>>
>> e.g: function1 call -> function2 call -> function3.
> I meant... check_traced_function() (or check_traced_functions() in this
> case) can have multiple arguments. You would loop over them inside and
> then clean up. Or did I misunderstood?

I hadn't thought of it that way, it makes perfect sense. I'll send a new 
version with this adjustment.

>
> Miroslav

