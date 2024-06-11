Return-Path: <linux-kselftest+bounces-11683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75F903F9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC582849D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503245579F;
	Tue, 11 Jun 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2YWHNa+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E33A27B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118269; cv=none; b=e/7IDZvmTq/XHhMLEHrbqxbblfFHlQLRNCQaCvXnHTcy3nU0OdH7ywOZ3y1EiNB75DpPvhVjzWRhnUBhOLOwl1briIjdOKRiL0QFlOugflffTZBIh8EqzH2XKy5nMtn408LXCPUvy/HFpftlJarZgFBq2wMFL4mBYsP5fIm00iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118269; c=relaxed/simple;
	bh=AkUd3nITwa1Nsrx5FGIDh+oFc9gDF9r3YGUNfEDGOdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsreyYotAjTn5Td/C7FqCxb39ygBfJM/jR8NRvHzKu6zKkZoTU12sdRJDopsunYWMkfEGiKhI5ECQmqr4seHMq9EDIZdqB7CxBrBAlyWLXCUMpqyV3G18iaZ/PPOxS9aO97T+pwaYalNTlY57chz46OSsMaN3Fn95KSaxx4gLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2YWHNa+; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d21e7aab20so214551b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718118266; x=1718723066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1vw+2ACNqWtSlz7WiuesM2J8QxhMf27utzH+YpcgUU=;
        b=f2YWHNa+NzKq6p06NcHmTrhmFPxBNtf57gmsdOhfH8ZMkjt7WXez7KiFFABFba2guQ
         E7R9Hk3EWcEqvvov7f37ydSrEy0UyhahCv+hphrtrbf/ghRwesyD9P3jOjFUKYTuFWkb
         5VyPBtCQk4a45pX81xHF894pzb9xnol4pxoRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118266; x=1718723066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1vw+2ACNqWtSlz7WiuesM2J8QxhMf27utzH+YpcgUU=;
        b=B3vdsm5Qr+pU2bjnFkPlFfwuqrVB0OPSNcz7pztFZvJGJ9riF/sZkw3tbAyHxMWo21
         PxHZ5+mifot6ZyOJuT6THOMWkWe60jHIxRA3aGaChQXOgJyJehNmXDz+MKweax42vzV8
         Nj1tHcRRzBtMFPvuUXkO3jAOStMR8GJT5f6uXrw6VpWLKMOm/WN2qvAq6pJ1mf8MQJfg
         BSp3r5jHn4nj/S6z31xDjMWfE4L7x6nbX/wfqwyLzSW85aUI5rdFZBfIaYX9aDvKJBNK
         rAZF8uSjkymVG3ZGQnt+egX0QwYxrAS4FxgLWdpv2VW7j87MrkgyHqz26EzwtrDCWGoG
         LKiA==
X-Forwarded-Encrypted: i=1; AJvYcCX68KHEnOxzjQB3AFyMF4eVkOgXF7V5poJjNC59G/CHdIEDSw9yaVulDLU6ZNbvkXV+vihvwfLg+M0XQ1iuU4xu+KvtfJ4hxGtc674W+hpm
X-Gm-Message-State: AOJu0YzZbKD0kkZCPA00JddIaws1TdzNmopu2+YMJ+xakScHYwm4hTBW
	POO723K2Gisb/RytOyFEUrb+7fB0eVCdljwA1SuSJsjudGTptA+a8iQnZhUqV2qTl40VKVvLLfQ
	V
X-Google-Smtp-Source: AGHT+IGlfmuk878CG8En5W5lnHLDlQmd3V99IlMUJd8rH48VkCqYhG6rTzSfb4MZ//slpZJu5TCXQw==
X-Received: by 2002:a05:6808:1b08:b0:3d2:2356:d271 with SMTP id 5614622812f47-3d22356d368mr9188713b6e.1.1718118266435;
        Tue, 11 Jun 2024 08:04:26 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccacadc00sm20643537b3.1.2024.06.11.08.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:04:26 -0700 (PDT)
Message-ID: <0556ee55-6bdf-4392-8933-03539768f671@linuxfoundation.org>
Date: Tue, 11 Jun 2024 09:04:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: proc: remove unreached code and fix build
 warning
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <202404010211.ygidvMwa-lkp@intel.com>
 <20240603124220.33778-1-amer.shanawany@gmail.com>
 <14f55053-2ff8-4086-8aac-b8ee2d50a427@p183>
 <20240604202531.5d559ec4daed484a7a23592c@linux-foundation.org>
 <eb9b2d6e-91eb-4fdc-b352-b3d0c290da2f@p183>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <eb9b2d6e-91eb-4fdc-b352-b3d0c290da2f@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/24 09:25, Alexey Dobriyan wrote:
> On Tue, Jun 04, 2024 at 08:25:31PM -0700, Andrew Morton wrote:
>> On Mon, 3 Jun 2024 17:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>
>>> On Mon, Jun 03, 2024 at 02:42:20PM +0200, Amer Al Shanawany wrote:
>>>> fix the following warning:
>>>> proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
>>>
>>>> --- a/tools/testing/selftests/proc/proc-empty-vm.c
>>>> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
>>>> @@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)
>>>
>>>> -	if (0) {
>>>> -		write(1, buf, rv);
>>>> -	}
>>>
>>> no thanks
>>
>> Why not?
>>
>> Why does that code exist anyway?  It at least needs a comment.
> 
> OK, whatever.
> 
> If test fails, it better record buggy output somewhere (to coredump or to terminal).

+1 on reporting results - the best way to do this is to add a meaningful message
for users to understand what went wrong.

Please suggest how you would like this warning addressed and report the error.

thanks,
-- Shuah

