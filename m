Return-Path: <linux-kselftest+bounces-4941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7085AC84
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BC51C23B0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C450276;
	Mon, 19 Feb 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iupmz7xJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3554F8E
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372423; cv=none; b=bdZK701x7iFrNK+BfivdinJDfGklupkbPBsw5RzpSKRrQ6lYjsAJQxXZX1QG9H+NMmw3lnsIG6FcXSsqZxbwKSlom3tqza4YLt68DdlM82w9URQO6jf/9baK2j4tH8ybo75EBw1wXCUEDB+sP3usSbOUY1+WTjS15rVKSRbNy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372423; c=relaxed/simple;
	bh=xRF6IP6+Qyj7w49L3UyPpp7etx2SyE80USQtA1e7Ifk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2Glgj1zBQBUOaxgEG5jVr25SRmiUBXmXvQk6q+NQFDtSwyOuFIhl1kEBhnzR5Qs6n4OasDHAniLzTq5C1j8xlE7IyGUKSHrrl8a3kMexDFNcOjfqHd0dHVjrPw4hpRPmcodgCqWRIB4N3KC5TWhKpnQs204AUsV/bRPw9KgOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iupmz7xJ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso74785839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708372421; x=1708977221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuLg0IbCSIPyRDvH7Eqd7ZiKvYS8Y/iQqj1sH/FWiwk=;
        b=Iupmz7xJpVKdaVmvJmVby3tk5XZh9hRPAl2/drhETlh0KAezkz1Zj1OW0p43Cp4O+3
         PyWr2DYtLBxQ93pBUArsxwWaxlKvQhJDNyQEio+vnLk9MdxgBgPq19kYnghCcGbMTej6
         XSAoDu7V0vpnHBJfqWQQ25MeDqRuXbfIPOsfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372421; x=1708977221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLg0IbCSIPyRDvH7Eqd7ZiKvYS8Y/iQqj1sH/FWiwk=;
        b=wr+irEi4hvqLAvbHwYxpBxEWMCgyBAN/tqqa4i2fWBQrRpU071ZePceaLo2strijaP
         PuZtGFTU6Ob5LdNJyaYHkWhCg+nupVLDWTsCNtj2tqkLP10wwsS9cZWDk/t5KeWtlcZt
         PYnWA6oGzqxneiwNfrKIcWXwX2bOlF3JRJnfTHo0oWPnqt5OkWWUfmoSaqxHu4xHgedF
         9n1jLxlUlTOXFb/7IxNvAo9Ga046wm3h9iwZL2zutgUKGnF7Hmawr3EOn/k39ocM9x6O
         +tnEnYv/wHKUemh93B8pKCpj9dnCjhrrw8tczNGZa3u+UK/y/5ONJzzFAVSDdAH4pYNL
         D7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHFC2GVA0mZzM4RK4oO7EEHZeUMl97YSERO21BUW8hZjhLPKKkg7fwW1tCGW3kY9qWNLxPq49VMtXHyDJy/IJC7VOyjjvRWJM/VoPqxF8r
X-Gm-Message-State: AOJu0YzoN5Ps1txrZbugeNRByn/MlufyVEF8YSpYblTIFfFZss7Cl+eA
	2Q88PNn99bfPthYkpsmh+ruKnQ81A170fCoZIJa3dei8MGVUlKO6fDl5Qqs7i9g=
X-Google-Smtp-Source: AGHT+IEA0iXaRO5AptbyLnqA3kgEJ97WB43vkHqs86F9UJsCE8n8B7SKJKHskChxe9Tl3OM6H63n3Q==
X-Received: by 2002:a5d:9a07:0:b0:7c7:4128:420c with SMTP id s7-20020a5d9a07000000b007c74128420cmr4738433iol.0.1708372421424;
        Mon, 19 Feb 2024 11:53:41 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f4-20020a056638022400b00474224734a3sm905386jaq.107.2024.02.19.11.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 11:53:41 -0800 (PST)
Message-ID: <e2d3807c-96f2-4062-a91e-015a083687d6@linuxfoundation.org>
Date: Mon, 19 Feb 2024 12:53:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: fuxex: Report a unique test name per run of
 futex_requeue_pi
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Mark Brown <broonie@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
 <87a5nwjvj7.ffs@tglx>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87a5nwjvj7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 08:58, Thomas Gleixner wrote:
> On Tue, Feb 13 2024 at 19:06, Mark Brown wrote:
>> The futex_requeue_pi test program is run a number of times with different
>> options to provide multiple test cases. Currently every time it runs it
>> reports the result with a consistent string, meaning that automated systems
>> parsing the TAP output from a test run have difficulty in distinguishing
>> which test is which.
>>
>> The parameters used for the test are already logged as part of the test
>> output, let's use the same format to roll them into the test name that we
>> use with KTAP so that automated systems can follow the results of the
>> individual cases that get run.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thank you. I will pick this up for Linux 6.9-rc1

thanks,
-- Shuah



