Return-Path: <linux-kselftest+bounces-29067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A3A619F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC598462A36
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655E2046AA;
	Fri, 14 Mar 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GieJe+56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E222AEE1;
	Fri, 14 Mar 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978826; cv=none; b=PYMa0GKqtofFh7qCwNaKmKNV8h5Z5jq2l/iQ/eOrIW3gptciSche+2CvZVrgQxyR4dalaA7yKJ90nWrIViBVee4w9yokqAmXo3NA3g5psl9M5W2UV1/C0fWO0Sq8J8WfjstbQXs99fKRYNATZTGAXzOOl5DfWldpxsWCpmNeh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978826; c=relaxed/simple;
	bh=D0QlhNXbW/xyzK2YRcvVYmbstyauIMT/uvZG4gqT/LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm0gORj7Ksbg+UPUCgu+b6tRhWFAzbS/1I5rtTkH+Mduqi/vppP77CRyFHUsmu7VhxAzPBjbq2LUSbt5oFVw5V5P261CAkifComTPcodvZQ61IX2UBFSKWxkXwIE/iD85KFsQc+RZ5ooKZsj+HfNBo42D7uajMI248CIbUDq1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GieJe+56; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224171d6826so61123705ad.3;
        Fri, 14 Mar 2025 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741978824; x=1742583624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TttbHfEDzusPiqbLfENwtPHN2UcwDBYMxJRLAbcwVE=;
        b=GieJe+56p1TdTk8rdtLatYPLudjGkELdS8msA90p76Hw/Bs3UWB004c0qLgTAAU9Dv
         jilMvC097mKeZNBP6Y7Z2QHDy4joNcBpE6JlIx6S5kp74HIeyOJbWVo7GiMbIRyzUUN7
         53JkjH+OnVKeAtbKrumGFYtpIay4uMu4ek0fGEBQJc3g2s0SHhgzsX0/Hei60+zIk01V
         BL1bwNUL1wb+Bs/2XmCoM45ViIU3sSNJB++Y7akLva1//SUnEb3YqLWbYMU+i0mTeRA3
         fs44rhvcuY1ZHB4G4EI7IIpOyiB+Fdt/RTAPAdogDv7tMXVv2M93B8lZ5sOyaLzwlMAn
         rKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978824; x=1742583624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TttbHfEDzusPiqbLfENwtPHN2UcwDBYMxJRLAbcwVE=;
        b=P5q1h7rd564pbKRnsK6yrRj0AJV1oYB0C0J2JZhj230EZblPzWlAysFgheQbU2Li91
         Zd4i6LfaAufS92AghVbFvNRi6E58qePEUgnMafja2v7QjY3xlVfn41rIlE1GtX+CCVCv
         cJX4gvOev1g1uWZx+4EXD8R4IrDS8ageZZxJAKRbxsCkauLfZNQm8bFTaznTsDtKKfyy
         8APy34Xh1hW2uE50hKai5PY9l6mAjEuSOTcSbadQte1Ck5LXSFJdZLMYM093PIk9uKP3
         dmxBOY80PtpJnB29a1I+mZz2bfJa8OrNmdmEa9GUp4bTA4Jxs+lvT05bgNw4yR/bc1ZW
         ZxsA==
X-Forwarded-Encrypted: i=1; AJvYcCVGaGX6/vaD6CuzJx3QF57gs6SEhaU+MIIWR1XYLOjxoqIC7tm4qZrUtQubL49MwUXWUpVJ97XPmO3B+fAcBMF4@vger.kernel.org, AJvYcCVYsbFznJjYvb59+21KZa4F5ZvowPyQ/BG3euEX7Vyc88g45DLUae9LEyvO8SrIlHj79gRqHDWIKPesywZjRA==@vger.kernel.org, AJvYcCX8DhkxiKKZ3rf3MNdmcuFFwbTTn47pJz/rGVKeIa9GBCVj++Q4b9stzEwKKxciRyudljQpS8K7PjIANOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNSXXMyFYUtcmG4upX/WFBsSz8iy7zP5+JjDZ3k7lxJH4h86X
	1IWBDlP3e/IwpzkSGZ3at8smtm+OKzqY/0/fHFfPRZhUFOOLYaJRvT9d64Iu
X-Gm-Gg: ASbGncvlqdINc9JtCR4cJMDnv1qMHZgqm3p5bkrD1a/AGvZGZ5O6YY4b15mmaMSnKj8
	3GQoS1wsHeKn8iH9nTDq/UlMwr12ctavrW4C5JdLglw0LeZKJqhVjL3zHYF/gwcr6LiZTuhjDuw
	aV3nGCWNCxF7SHjmL2F1vbxeaOGrKTAoSvf/TrUhELDfRNpffXJz7UlwPF5C6z82un39TB82aPR
	/4bhGIl6tOazvVDCUFMMRTs2RQ0Gh6JGsDSsIIFd1EOu2LYKU4yE2tVf8+QZSKMWc/14RAIY/bq
	GhsSYIo3BHq886MumAukzblmf8e52ElUMKpJBTv80uP3efSZ5Y2H+bKazL2XoH3BtXGKkFrzJFw
	Js79O79hbM3mGx+n88vTF
X-Google-Smtp-Source: AGHT+IHNCKUEoQeU5JuTLB28zDQI1qq1nJ7mhk9VQYn/ahnO4Z55+xZYRRq0I3bKdFHKwOs72+RMXQ==
X-Received: by 2002:a17:902:e78b:b0:220:e1e6:4472 with SMTP id d9443c01a7336-225e0a82ca7mr38015695ad.13.1741978823899;
        Fri, 14 Mar 2025 12:00:23 -0700 (PDT)
Received: from ?IPV6:2804:d57:4e50:a700:f33d:65d1:e22e:109b? ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe8f9sm31682105ad.175.2025.03.14.12.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 12:00:23 -0700 (PDT)
Message-ID: <6d9b9394-690b-49a3-b8df-7ef510c96c00@gmail.com>
Date: Fri, 14 Mar 2025 16:00:19 -0300
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
Content-Language: en-US
From: Filipe Xavier <felipeaggger@gmail.com>
In-Reply-To: <alpine.LSU.2.21.2503141411010.4442@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 10:14 AM, Miroslav Benes wrote:

> Hi,
>
>> +start_test "trace livepatched function and check that the live patch remains in effect"
>> +
>> +FUNCTION_NAME="livepatch_cmdline_proc_show"
>> +
>> +load_lp $MOD_LIVEPATCH
>> +trace_function "$FUNCTION_NAME"
> trace_funtion() calls cleanup_ftrace() to prepare the test. Ok.
>
>> +if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
>> +	log "livepatch: ok"
>> +fi
>> +
>> +check_traced_function "$FUNCTION_NAME"
>> +
>> +cleanup_tracing
> Here, I suppose, cleanup_tracing() is called to clean up after the check
> above so that nothing stays and more tests can be added later. Right?
> Would it make sense then to call cleanup_tracing() in
> check_traced_function()? I think it would less error prone.
> If needed, check_traced_function() can always be upgraded so that it
> checks for more traced functions.

In cases where we need to check two or more functions with 
check_traced_function,

if there is cleanup_tracing, it will not be possible, make sense?

e.g: function1 call -> function2 call -> function3.

>
> Miroslav

