Return-Path: <linux-kselftest+bounces-20114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A59A385F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AB9285D80
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83618CC13;
	Fri, 18 Oct 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PGObKaIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052518C939
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239630; cv=none; b=fGL136YvZ89rm5MEyCIAbt/bRSEHbq1CS7pH/BbG+e+d1R0QKkjwKdlld5TqIokHRLJfC1ri7mKw6YWKTmMYmojmpESfwYFgiX7TtGGTK0SOtJ1cJrUkX895J5XQZYt6Q1fPy3WiO+Xx08v5UYu9+aUbh5O35mLe+kQXOCK1qcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239630; c=relaxed/simple;
	bh=fv4S11jckR2IKANtiqDjpLwmjQ40Sn5yGK77sulA+7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9Sap4E3ZPZX/Q0/ExpeENDMqSBm29S+DM8XVKJjsGs5hG1DcvRKIQUZ+2kbxv+TYdf1ltvb2iH6y5fzCEawH9RJ8pxVu70OYbYJlOhiFlAXqbhTvq0BQSy1AG8VHEjXsEc2tLEWrmGCMp4aiWv9oyxIQmmarbH38jtjAwt6X68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PGObKaIp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f8490856so2187863e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729239625; x=1729844425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FRjvf5MP+13+6LLbAr9owLWnQDfNe4pqw2wzXAHPLsY=;
        b=PGObKaIpYPaNM2v/axHC+ACBneJYDmtt4zbfv+gRx87Do9ss2uihVPvL7zjBrw8lAU
         irPXLA8X23k4ntmM5kv/cYuceGGuYbcdRFDCOYOv0C0VC+OkyzEa/OXoMD9Mjjy5eE27
         Hn5nfOU8R8Z6nU8Al+osH1Wt72KB8ZiLMcIGJ5WuGTItqZjVbFpiBnEmuMvhb1/lmq+T
         K97wrzrKGd1AMZvZtRl26eAgOj2XNd3hXe4WWoLYWrhZ5S21R0Z7iS8KEsuVY3EIIj9n
         RRjBmXU83ovY59gZDoj/Hsb6FXHoVG3M9SChZR5a7UPsbtsSveidf2X+84QVVOir0IWm
         lmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239625; x=1729844425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRjvf5MP+13+6LLbAr9owLWnQDfNe4pqw2wzXAHPLsY=;
        b=IYgUakilWp29MFAyjCZj2zQqeib36tJFKd+kYFl4XdVwR/qby3sitNzlGGjH7ouDIV
         PmCDbFiFaphA5d7x21Yk836FcDwqHdBmJZAPWQ/SJNGXM9oMJOHO9tsGBkZ2TEG1l/nv
         bov+Aj4bHW9UGOOZT8nkXTKx35/G3kGYFB5cjenzmF50KuB3FUBrEYeAmdkDvQq/CPlO
         i8OmXOtCRrcBlpZo4ZdJLDUw4tFMofZCOeAF0PBfVM8iaQdsMWFEKCWYJL30gKIXCmrx
         7XQ2/+yv/o9JlKp+HyInWqUnqmo3L59F1rPfLM7blwpqMQtRY4CuNUtAnOQ/raNf2DRM
         fIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ7waZaaGjxnU/xq83JjOwhj+YIe2VJhQQw65hmrP3sxplJ571q1duHpoFAwjLh/OKhmdb6WNEkziUlIuecM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRh86w/GcLrA+haFMG7xwXDWF0kT4xz+sD4rNr+ek5ei/tYKi
	CpbG4j7k0j6+bs1Gah3l0idb8Wfrgf9zjmsSoztCls8antIQQYKGcRz7pWGk9mY=
X-Google-Smtp-Source: AGHT+IHUti02UynMz6KQkKP/PaiU628/OtrvvF5LEx3K146nBh2AmiKAhJ/cnKXScSVkIacS+1jdHg==
X-Received: by 2002:a05:6512:3b96:b0:539:fb49:c489 with SMTP id 2adb3069b0e04-53a1543edaamr753930e87.9.1729239624870;
        Fri, 18 Oct 2024 01:20:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b27a:eeb:2c33:713c? ([2001:67c:2fbc:1:b27a:eeb:2c33:713c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc5300sm61622866b.112.2024.10.18.01.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 01:20:24 -0700 (PDT)
Message-ID: <ad45c95c-c5dc-42e5-b270-4dd0a1d0aa75@openvpn.net>
Date: Fri, 18 Oct 2024 10:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 23/23] testing/selftest: add test tool and
 scripts for ovpn module
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-23-aabe9d225ad5@openvpn.net>
 <a86855c4-3724-43e8-9bdf-fb53743cd723@linuxfoundation.org>
 <12609df3-4459-4d86-a505-e4f2daccff93@openvpn.net>
 <9837c95a-2366-4733-b26a-9bfd27261f56@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <9837c95a-2366-4733-b26a-9bfd27261f56@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 23:40, Shuah Khan wrote:
> On 10/17/24 05:27, Antonio Quartulli wrote:
>> On 16/10/2024 23:14, Shuah Khan wrote:
>>> On 10/15/24 19:03, Antonio Quartulli wrote:
>>>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>>>> kernel module.
>>>>
>>>> It implements the netlink API and can thus be integrated in any
>>>> script for more automated testing.
>>>>
>>>> Along with the tool, 2 scripts are added that perform basic
>>>> functionality tests by means of network namespaces.
>>>>
>>>> The scripts can be performed in sequence by running run.sh
>>>>
>>>> Cc: shuah@kernel.org
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>
>>> I almost gave my Reviewed-by when I saw the very long argument parsing
>>> in the main() - please see comment below under main().
>>>
>>> Let's simply the logic using getopt() - it is way too long and
>>> complex.
>>
>> Shuan,
>>
>> while looking into this I got the feeling that getopt() may not be the 
>> right tool for this parser.
>>
>> The ovpn-cli tool doesn't truly excpect "options" with their arguments 
>> on the command line, but it rather takes a "command" followed by 
>> command-specific arguments/modifiers. More like the 'ip' tool (from 
>> iproute2).
>>
>> The large if/else block is checking for the specified command.
>> Moreover commands are *mutually exclusive*.
>>
>> Converting this logic to getopt() seems quite complicated as I'd need to:
>> * keep track of the first specified command (which may be in any 
>> position)
>> * prevent other commands to be thrown on the command line
>> * come up with an option for each command-specific argument (and make 
>> sure only those required by the specified command are present)
>>
> 
> Thank for looking into it. I would like to make a suggestion to
> add a parse() routine and move this logic there instead of making
> the main() very long. It will be easier to read the code as well.

Ok, I get your point. Let me work something out :)
Thanks again for your feedback!

Regards,

> 
>> Are you sure this is the right path to follow?
>>
>> The 'ip' tool also implements something similar after all.
>>
> 
> Sometimes argument parsing takes on life as new options get
> added. It starts out as a couple if else conditionals and
> expands - when I see a long argument parsing code, I like
> to pause and ask the question. Sounds like you case is more
> complex.
> 
> thanks,
> -- Shuah

-- 
Antonio Quartulli
OpenVPN Inc.


