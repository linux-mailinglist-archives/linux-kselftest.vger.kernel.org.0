Return-Path: <linux-kselftest+bounces-14740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FB9464F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AAD1C2093F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257749634;
	Fri,  2 Aug 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgzVJ5Ry"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9197D07D
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633655; cv=none; b=rbTGYDti24zvyG+pMrMdMDmCw9HMWRdNfYOmoi+9xsh0RZFh+HP9GLJ3T4aIT4L+8ItzgR1fr2uGQ8KXHlkhpUL8D+/nhZ/TeJVJydTIAk1/75+zebd3VEIB9z47LYffh5eKmY8NPtnOZFAqsiU1vO0H3W+D2kGCOqJbDm8c6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633655; c=relaxed/simple;
	bh=hPTm8twJbQwP1gA57rf1nLexQTY1IA3FxQkljDvuAUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksYS1pKGCd+FbqYg/Vj0VcqQfVbGPciaAbsMKxWxkTaPgyk+lMJ4N4V/2oNG1HR6EPWu4P45s5Zjgh8MZWufT4bHE1qNFfa9dW5w7e7jwBwPtd6gUQmFCJ3V56gcMPDS8upO8Fe+8EA/59sO1+n/0gyUCLmxgwLVB3+QKfgzXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgzVJ5Ry; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39aecad3ea7so1623115ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722633652; x=1723238452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUVOjx3qvNsCDEecpqknYfmTs+/UlFgyedU0CA/KD7A=;
        b=hgzVJ5RypqIelpgQWFyI5/qk8DueP5zFQsYMVzlCdZStrFG08ZxyQGiy+6H3qsGJub
         ofuZ3NytAB/cdLxvQKJU0gD6kUU+dHD9tjYTBlEpaUyS8wClDEy23NoAOqDag+detChD
         a9LHLqvTp1GLaGZPZ5rY9ETgTfVjDkipvDluY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633652; x=1723238452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUVOjx3qvNsCDEecpqknYfmTs+/UlFgyedU0CA/KD7A=;
        b=qRlrARaFAEDM9jrQWSv8uwBHHDVzS0PwdYpo5Y8hMJEx8saGTmNWeCNuge0Rq5M+yr
         6l2pSczTr+FctrtvS2hEYljAseSODoSMKavl6S6HDEWcGNU7Nb+edEopmPJZAYkPy+AM
         G6i9yA+ngA67PZlsULu1YrGKSWjq+/wW6V7I0iLsD/HtC9v4U3XdMH+H29Y8EsWRC2Li
         N5Wz53ZPworfyUfJKJP/gXxjk+azKBzpaWFKq5a79fWQVh9Q9uNbXwVgodDHbUV/kYYG
         /GR7dChw+dh179Yu0gSbJ1PXVZ63/v8L8qBd4zpbzHXMblMuyX6MjgqA9UDsViIL3Wff
         zbdg==
X-Forwarded-Encrypted: i=1; AJvYcCWSZf0FcGZpMn2Pu9u06vSSjNWwjsypsziTB3lfNvAOr/TlTHoixGLO50K1V3ZwupDEYqarc9RFO1ruDHpnqm2qVicVnAKutG/EVOWla5T6
X-Gm-Message-State: AOJu0Ywym5uRvn94Qr+1Lo6fz943kwKoUwK7x2SNTPlOgkziQ9u+DKFY
	b2v6dqK49LGZ5YvU+3u08vdxIYGqXb1bVK1E6Tx+vgjBPttxFzyHy58bYm+2dKQ=
X-Google-Smtp-Source: AGHT+IFVau0I++EGUzffsnsNKUNWsupcmCH5zGbYtBcWlZKAnldqk0URodLsZDCVj07G8p0H5y1gIw==
X-Received: by 2002:a6b:f415:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81fd4395206mr364445939f.2.1722633652288;
        Fri, 02 Aug 2024 14:20:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d3a1e2sm71986339f.26.2024.08.02.14.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:20:51 -0700 (PDT)
Message-ID: <fc8a6e83-98fa-4809-8b05-ea9f94dd2c71@linuxfoundation.org>
Date: Fri, 2 Aug 2024 15:20:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
 <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
 <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>
 <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/2/24 09:48, Thomas Weißschuh wrote:
> On 2024-07-31 17:01:09+0000, Shuah Khan wrote:
>> On 7/31/24 12:32, Thomas Weißschuh wrote:
>>> The implementation is limited and only supports numeric arguments.
>>
>> I would like to see more information in here. Why is this needed
>> etc. etc.
> 
> Ack.
> 
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
>>>    tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
>>>    2 files changed, 152 insertions(+)
>>>
>>> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
>>> index c968dbbc4ef8..d63c45c06d8e 100644
>>> --- a/tools/include/nolibc/stdio.h
>>> +++ b/tools/include/nolibc/stdio.h
>>> @@ -348,6 +348,99 @@ int printf(const char *fmt, ...)
>>>    	return ret;
>>>    }
>>> +static __attribute__((unused))
>>> +int vsscanf(const char *str, const char *format, va_list args)
>>
>> Is there a reason why you didn't use the same code in lib/vsprintf.c?
>> You could simply duplicate the code here?
> 
> lib/vsprintf.c is GPL-2.0-only while nolibc is LGPL-2.1 OR MIT,
> so code reuse isn't really possible.
> Furthermore I think the vsprintf.c implements the custom kernel formats,
> while nolibc should use posix ones.

Ack.

> 
>> With all these libc functionality added, it isn't nolibc looks like :)
> 
> Well :-)
> 
> The main motivation is to provide kselftests compatibility.
> Maybe Willy disagrees.
> 
>>> +{

>>> +done:
>>> +	return matches;
>>> +}
>>> +
>>> +static __attribute__((unused, format(scanf, 2, 3)))
>>> +int sscanf(const char *str, const char *format, ...)
>>> +{
>>> +	va_list args;
>>> +	int ret;
>>> +
>>> +	va_start(args, format);
>>> +	ret = vsscanf(str, format, args);
>>> +	va_end(args);
>>> +	return ret;
>>> +}
>>> +
>>>    static __attribute__((unused))
>>>    void perror(const char *msg)
>>>    {
>>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
>>> index 093d0512f4c5..addbceb0b276 100644
>>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>>> @@ -1277,6 +1277,64 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
>>>    	return ret;
>>>    }
>>> +static int test_scanf(void)

Is there a rationale for the return values 1 - 14. It will be
easier to understand if there are comments in the code.

>>> +{
>>> +	unsigned long long ull;
>>> +	unsigned long ul;
>>> +	unsigned int u;
>>> +	long long ll;
>>> +	long l;
>>> +	void *p;
>>> +	int i;
>>> +
>>> +	if (sscanf("", "foo") != EOF)
>>> +		return 1;
>>> +
>>> +	if (sscanf("foo", "foo") != 0)
>>> +		return 2;
>>> +
>>> +	if (sscanf("123", "%d", &i) != 1)
>>> +		return 3;>>> +
>>> +	if (i != 123)
>>> +		return 4;
>>> +
>>> +	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
>>> +		return 5;
>>> +
>>> +	if (i != 123)
>>> +		return 6;
>>> +
>>> +	if (u != 456)
>>> +		return 7;
>>> +
>>> +	if (p != (void *)0x90)
>>> +		return 8;
>>> +
>>> +	if (sscanf("a    b1", "a b%d", &i) != 1)
>>> +		return 9;
>>> +
>>> +	if (i != 1)
>>> +		return 10;
>>> +
>>> +	if (sscanf("a%1", "a%%%d", &i) != 1)
>>> +		return 11;
>>> +
>>> +	if (i != 1)
>>> +		return 12;
>>> +
>>> +	if (sscanf("1|2|3|4|5|6",
>>> +		   "%d|%ld|%lld|%u|%lu|%llu",
>>> +		   &i, &l, &ll, &u, &ul, &ull) != 6)
>>> +		return 13;
>>> +
>>> +	if (i != 1 || l != 2 || ll != 3 ||
>>> +	    u != 4 || ul != 5 || ull != 6)
>>> +		return 14;
>>> +
>>> +	return 0;
>>
>> Can we simplify this code? It is hard to read code with too
>> many conditions. Maybe defining an array test conditions
>> instead of a series ifs.
> 
> I tried that and didn't find a way.
> Any pointers are welcome.

I played with this some and couldn't think of way to simplify
this without making it hard to read. It would help adding
comments though.

thanks,
-- Shuah

