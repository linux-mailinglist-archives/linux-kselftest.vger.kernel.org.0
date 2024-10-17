Return-Path: <linux-kselftest+bounces-20072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDC9A2FF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 23:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221711F23075
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2841D63F2;
	Thu, 17 Oct 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a6ZAwRub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC11D61A7
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201261; cv=none; b=QatiMtnteYWRMEw9gpwnpTUhVVEX+Unw5Yb1yA9T44W3BtLH6+MDztZE5eOVwBwC9MLndCBoCGWIAnRSnjX/xCyo3pyRBFmyFLjkiIfQFNhll1iheQZBZhlkQqQ3r/kG5UfLQ3w/h2s5Pu/ih4SMfXGGKvVBFQpBU6b7omMLXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201261; c=relaxed/simple;
	bh=Dy+Krcn+NAwtr8XQ9BK/8dVkIlRxjcHkbLAhfwfIsww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjHUBPCiPz+UYD8pYv6VTTZUJT4Gvvba5ps0VZkP35ICa+NQ8gTd+LUerrweVSlC8fVo6A85H9nHjFJmZeiusmHSMPZIBYEQmPAcRb0DK81w307XRO3P5mIV7/lJsaA608dPC1pS5K7D+eKwqM/7I3YRrHPyeccsZCe1J2tr0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a6ZAwRub; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b1aa0e80so6013255ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729201254; x=1729806054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ll7dLpi0Jr/OVsosHkE6envnHo0rijYZjtHd0NM6laY=;
        b=a6ZAwRubN6eAEEA1Fq7vhVkJ+ziA3MxXaHEff10FZ5F5qwING0/bc2tcEfRVqsY6qd
         pxZpZWfkoomXTxF/SYFhHYVbXZgMmQOkxHlhGB7wWeKqzKDV04u8g57bFrtFn1s+D0iz
         LzYLSG8jtMHyeMvvsINg9KekBw3MwQx4EnKlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201254; x=1729806054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll7dLpi0Jr/OVsosHkE6envnHo0rijYZjtHd0NM6laY=;
        b=RU0eYTIypKcLJWM1o1R7bqNryxVH9TSlAvMNDt0HsgGrYsZTtpoIFQqX3qh2iSbD4S
         izQ8X5AxO6VY0eOOKxYym8UBpVzORLaVMfIXgBGOnE/spzupuA5ovJYA8N7cpYQcIMO/
         r9hSU+XivA7uDT0Q4SfAP9hRcXvRikT/ryOcD8jqZwUxIkuvez2HcQQScAJKqfeodiLq
         8pfonAu+nEtuXhBGw7MCtUfwyh2w/3pW/mGTUvX1bjaKlVCqquyHiDVoa5vnot/rnprb
         nyGk1nrrOCRUPcaf4jptCRjnEBw6uetLOXVqqeD5fgcyTssGSYJt7gsuPGaFRIbjQ7Lb
         k6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVNVbSm62WTnSlwXm9s/NAkF4LWL7ATaVG+NPCCXgWN7SJSapaIaHY2w0YQhHKYRBzYFWWqAz0cSeqAjalgZvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LhebCTp+DV6cn6EzanV4xRVrtdzA2eAezxZLFJBBfBZWiDs9
	8a7JK8dwT9dOLEdtgIwPTbUMRQKjP/P8zkMy5G0RVXjO35EZ3cQ0Lff1ovP+Xqw=
X-Google-Smtp-Source: AGHT+IHxewqw4CYVd2Ce6M3WdW++reuVJi6/l1j1eFwpDBwHfKcH7N2Jr8ePShvV8qjHjNbKlKlOyw==
X-Received: by 2002:a92:c56f:0:b0:3a3:b439:5d09 with SMTP id e9e14a558f8ab-3a3f4060aabmr2519305ab.11.1729201253329;
        Thu, 17 Oct 2024 14:40:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f3fe48edsm439885ab.22.2024.10.17.14.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:40:52 -0700 (PDT)
Message-ID: <9837c95a-2366-4733-b26a-9bfd27261f56@linuxfoundation.org>
Date: Thu, 17 Oct 2024 15:40:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 23/23] testing/selftest: add test tool and
 scripts for ovpn module
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-23-aabe9d225ad5@openvpn.net>
 <a86855c4-3724-43e8-9bdf-fb53743cd723@linuxfoundation.org>
 <12609df3-4459-4d86-a505-e4f2daccff93@openvpn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <12609df3-4459-4d86-a505-e4f2daccff93@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 05:27, Antonio Quartulli wrote:
> On 16/10/2024 23:14, Shuah Khan wrote:
>> On 10/15/24 19:03, Antonio Quartulli wrote:
>>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>>> kernel module.
>>>
>>> It implements the netlink API and can thus be integrated in any
>>> script for more automated testing.
>>>
>>> Along with the tool, 2 scripts are added that perform basic
>>> functionality tests by means of network namespaces.
>>>
>>> The scripts can be performed in sequence by running run.sh
>>>
>>> Cc: shuah@kernel.org
>>> Cc: linux-kselftest@vger.kernel.org
>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>
>> I almost gave my Reviewed-by when I saw the very long argument parsing
>> in the main() - please see comment below under main().
>>
>> Let's simply the logic using getopt() - it is way too long and
>> complex.
> 
> Shuan,
> 
> while looking into this I got the feeling that getopt() may not be the right tool for this parser.
> 
> The ovpn-cli tool doesn't truly excpect "options" with their arguments on the command line, but it rather takes a "command" followed by command-specific arguments/modifiers. More like the 'ip' tool (from iproute2).
> 
> The large if/else block is checking for the specified command.
> Moreover commands are *mutually exclusive*.
> 
> Converting this logic to getopt() seems quite complicated as I'd need to:
> * keep track of the first specified command (which may be in any position)
> * prevent other commands to be thrown on the command line
> * come up with an option for each command-specific argument (and make sure only those required by the specified command are present)
> 

Thank for looking into it. I would like to make a suggestion to
add a parse() routine and move this logic there instead of making
the main() very long. It will be easier to read the code as well.

> Are you sure this is the right path to follow?
> 
> The 'ip' tool also implements something similar after all.
> 

Sometimes argument parsing takes on life as new options get
added. It starts out as a couple if else conditionals and
expands - when I see a long argument parsing code, I like
to pause and ask the question. Sounds like you case is more
complex.

thanks,
-- Shuah

