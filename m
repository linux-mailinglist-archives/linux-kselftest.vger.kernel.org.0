Return-Path: <linux-kselftest+bounces-22873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A029E5AB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A583216BAFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134B19342F;
	Thu,  5 Dec 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NK4OrzcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE11B59A
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414807; cv=none; b=ZB4pqUT/Uxjdv9mcMvNa2EeMT37fT/Gpl0kC26nF0Yc8r1O5CAEY7SlrCRDKTAej2+Vp0L7lEKP5OAvqH7mCmNmyaHgIci2WC2IdzNIAeWEMXZgCdcDUJ8E0rfLcvaCwLGzUxEAzyq+uvvk/FV0AdhWtCSYlyWk+lFu84MQLmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414807; c=relaxed/simple;
	bh=A2DnTOze90pmj6g5vc3azSV/Ln9IgzLkSP0Xv7QklXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9QO1IQNN26R4RbpA0dXRvMbygbJJxefzSgqBu/6V0Q33Ksc75wwGZBDpLnPamhdtJ6OIQFN+4cBxgiIK7F53ojOlRvdzyNUwo2peliQC9p73b6P+P7M//yFxFQdOLxC/8OKMesWIXv3gXPKZEvmOdU+hOpw3vUxjKSDIt9PXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NK4OrzcX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7dcbdf1cdso7589815ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733414804; x=1734019604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7E/0K/5K1BjOut5mLlzCa+24O07aK8RA1Bdk2pEJFM=;
        b=NK4OrzcXhegQ2guYPm8vkhfQ6ZnqrEEGeafEDW0Hy5rqNhvnm4ENDTIF9HkKheblf5
         apjMe7CkhN4zFNg6BNlV1ACwu+vcqFMlThTNSlpN85rKe6R8q6232ni6jciOfFK6Vytt
         Dee7afaB97MHYXC3qJkTlgg74pkp0rKZ9DIRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414804; x=1734019604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7E/0K/5K1BjOut5mLlzCa+24O07aK8RA1Bdk2pEJFM=;
        b=UbezJWjsdsVNrR2B1U2MFbdhgM7MEFUXdqpRupLQ+uAh3pKXEFw20uPAZqrHnmvV1O
         NZKOXV4THeUW8HmNdykQhfz2XWRNra56qdrZ4LTbc14zVje1jHVaAwd7NK4tyqIiqQT9
         QiDLSxRXxCSE0T7CaJY1SLUyl1tIXBXY3W0Yy/bX1j7C5H9vxsSLE0tR1L9DEWv/Sfuj
         bBGOFnyKBWpTjT+nxtdT8q4SzRzs31675fedxW+CPXX/KQM3D8txP0ZIL9Rd0ip//Hyr
         kR0OwAMN1hsjveSuAua0dwQVc1glTmjJv9hRIxCY8rrd9KY+Ts7+JjriN3QDk3EKzJU8
         AiQg==
X-Forwarded-Encrypted: i=1; AJvYcCV3IUfyiws+5sVkIfz/6R4PzC570TpkPPfKUIodkYU1+Y6Ydub7it+bnisazPUtbhcqBqvaZO6gkcWk0SA4TJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHdfD5rRo7qIbyiD5NMJLqK0bqmmMGtQI9yOdIIiJrE2Zk62R
	/ug5eQdE6DyDyZ7sZ3hgg7Z4GjiYC12vujVkOljDgUVm2zFhzN5Oh45csRBh88U=
X-Gm-Gg: ASbGncs5MqXryGLM0wqh0NpeKgxp3UXJ52ws+3SyRY3bAjjbpgFKZ39VZ7JluxO4/+e
	hrbuyH+DWIRTHD5G7LUzyipQy4SipFTKOavTH6jucE2E3AYiJSJKnQsTwraj9z6cEuefF8MxAEI
	8Eo2aK8bl6+rhfbBcdc/mA4AhAal3bRWeR9XnOdQDRjym/XH6ssmeT3jQRofaOM7pcNBXf0c534
	jqQZ4T7e8ZEFIR8+F2X3MtWVhtMrCK7trESaLMx5fDENH4TI1wYLQtAST+xcw==
X-Google-Smtp-Source: AGHT+IECQoo3AU1H3Cux4NWyUqkEkqx386V5pN6kVl0r6Wn3PSuY9bnBffRQmWJX+QbbsEJHmnHHEA==
X-Received: by 2002:a92:c56a:0:b0:3a7:dfe4:bd33 with SMTP id e9e14a558f8ab-3a7fecc82b3mr114487405ab.6.1733414804406;
        Thu, 05 Dec 2024 08:06:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e286224210sm337614173.161.2024.12.05.08.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:06:43 -0800 (PST)
Message-ID: <d9467ba5-ec01-4683-8078-d85574b2506c@linuxfoundation.org>
Date: Thu, 5 Dec 2024 09:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax
 error test
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Naveen N. Rao"
 <naveen@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129202621.721159-1-hbathini@linux.ibm.com>
 <20241202144111.75d1bb3b@gandalf.local.home>
 <fa1e747f-1823-4d20-86c0-b85a3b959952@linuxfoundation.org>
 <20241203202008.1f30a266@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241203202008.1f30a266@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/24 18:20, Steven Rostedt wrote:
> On Tue, 3 Dec 2024 18:01:06 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 12/2/24 12:41, Steven Rostedt wrote:
>>> On Sat, 30 Nov 2024 01:56:21 +0530
>>> Hari Bathini <hbathini@linux.ibm.com> wrote:
>>>    
>>>> In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
>>>> `vfs_read+X` except function entry offset (0) fits the criterion,
>>>> even if that offset is not at instruction boundary, as the parser
>>>> comes before probing. But with "ENDBR64" instruction on x86, offset
>>>> 4 is treated as function entry. So, X can't be 4 as well. Thus, 8
>>>> was used as offset for the test case. On 64-bit powerpc though, any
>>>> offset <= 16 can be considered function entry depending on build
>>>> configuration (see arch_kprobe_on_func_entry() for implementation
>>>> details). So, use `vfs_read+20` to accommodate that scenario too.
>>>>
>>>> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>>
>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> Shuah,
>>>
>>> Can you take this through your tree?
>>
>> Yes I can take it. I do have question about whether this is
>> a fix - sounds like it is from the change log.
>>
>> Clearly stating that it is a fix will help so it can be picked
>> up for stables.
> 
> I would say it's a fix, as the test currently fails in certain scenarios
> for powerpc.
> 
> You can add:
> 
> Fixes: 4231f30fcc34a ("selftests/ftrace: Add BTF arguments test cases")
> 

I applied this to linux-kselftest fixes - will send it up for rc2 or rc3

thanks,
-- Shuah


