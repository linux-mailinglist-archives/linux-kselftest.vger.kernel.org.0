Return-Path: <linux-kselftest+bounces-32423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD0FAA9B72
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B54D3BD791
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1B26FA47;
	Mon,  5 May 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wcQdYPMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21926F46C
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469199; cv=none; b=nvv869BoXN0g6NT29z3aveDcgvkKuMeC+6geLouPgMKfhR7Dyau+ot0Oanwq3QJ/mEgmwZyAyZ4Q2pYHmDxcVAzF6IDFh02MrEIYF3eUHgIHU6N5D7VEKqM3Qqg3BoPxU5eNrN3P6rsdMGosKekFNvkIUoeLeX36HrwnZY5VxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469199; c=relaxed/simple;
	bh=8pRu+3AHVgzwTzcQCeJYJhr4rld9Ynb0/Nk9xfx6dNA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ahpxKpKGkH6zA69XlL0qjrSPtv2rXL9cD4USbY+0xsKOKYDs1OVgbRSs0Fjzg8cpYzEa5o7K7HDAhqjvJhgoaFMnZA1ynVFn+qRv8HzdXqMQ9tpLbigCDmM34tVxrqqYsyQXx6PZk2sld1OeNrwxkQL4ju+vbK+4EH1J1lZlTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wcQdYPMU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b98acaadso4538693b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746469197; x=1747073997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJ22LSlzWo9zjR0Ke3Tjb1iwiGFv2JDlljbA0HY39X0=;
        b=wcQdYPMUSy9mfti3ASoBGVl7oxj4aBZLFqOgch7glG9hEHQTzYL2kzqcmi/Oo79yoW
         r6M6c+zuv/N7CJoebgEC2MbKLyFw1QXgYQ21CvJD/HRLjXfExms+OS9Xnp53TUtrfwIX
         KHCqWPXxbPaaSUKVkGNp08uErqDQwdQb+wEbKhWnjiHjSAGCEy7BK29dY2HbgWLpIw3D
         zOE+QEDmSNjXbZ4xEJ1a07SNtGHOjCP5NtTt05nXg26/iWFggYfpM9qkzuPe4dcxpSGs
         Hpc1H2/nxUSj0T7C/BflffrnUIEpYChdMUUiNQ/iItdoezwOxXhLbshkV6rUWP3W5GmH
         Lqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469197; x=1747073997;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ22LSlzWo9zjR0Ke3Tjb1iwiGFv2JDlljbA0HY39X0=;
        b=AOt2FbLUASrXRVFJluWdzwioFymC/5mF/EGqypOmz5JfDzxGHHPDZSSJ9V6BkLWQHe
         d2R8L2RgGSNLFv/NYPQOvX8dkEsehvZ28aqPccNVYETEmYIa6iBPbcL7gLdknnKvGyLa
         JoCahNB0smBQDbfLfejXZibnNVLg2nJTBrN6quANJlA1sTC6/GVw1Hge2D396vy5jP34
         Debe7PQCBrOQf6PZqTSoJd6WsUsrU7d+673NZ2Qbm7mCZ9tf7kTttW3oNqUl7y5hYKJA
         JJRuJ3H0T1gcSmjGb0ulNZsUUmh7svWuCtRIkqjfNMPwpHJ/vT4tj2MlsOr3rZSgdvZR
         jubQ==
X-Forwarded-Encrypted: i=1; AJvYcCU23HcqAzQx+WkxntO0/nNznbdN+4YXXnoE0Jz2f90fahKqTZ6hVSlJmWNZAVoin7hvhXjbj8QijSgQHV31EmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUIxsoTxI2cuJFTgtqwjZ6HAEnd7gIW3e/AmigJ3qWS14/7k6
	4JyMm/dPis4GIwMtH8evVmL8kLm9102yVGWRPwJ0WAmzx5bZefIo4dPdi8se/1c=
X-Gm-Gg: ASbGncudq5VDa75s8s/cXVG1Deb+RVdp0QbBwgcnStnFi9PPKLogUAomfUj5pcEVSjs
	duxB2x2naxo3/P0Aj6dK39NAosPdJOJ93B/gwshcKSLTp53xc6ZVEGILv4xpoa4XxH92k/oY62u
	jqLLuyZV61jnA4cSILKDjJRhBm5BJ7poD2QIqHuPioZAadgvP3W8EbqNKh8mrcWr1y5svyEffoI
	Z1pmfTG3Ya7TLjSE5stlRM4sXbV3bLI2W90RXEMk9VUEFmRkwhE4Lz74O6DDEOIRdb484rcdS2Q
	cF1nuu0rTor/omOTUu5jN5HsVt20A6hwNMfFFWAB0+6kzM5k+8NqnIF8dB2wl4XlpOAGWe4ohP0
	st8JcOnhA
X-Google-Smtp-Source: AGHT+IEapW8WA3wa6nPG3XSgLZVM4TOM6EuOUKg6vkSoyhhO2JGUwnM6WkjNKzhz0AtpNzZ15SyWug==
X-Received: by 2002:a05:6a00:395:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-74091b01fecmr136804b3a.23.1746469196925;
        Mon, 05 May 2025 11:19:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905fce9sm7164497b3a.128.2025.05.05.11.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 11:19:56 -0700 (PDT)
Message-ID: <0007aabd-629d-44cc-9398-902cd86d7eb3@davidwei.uk>
Date: Mon, 5 May 2025 11:19:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-3-mohsin.bashr@gmail.com>
 <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
 <20250505104701.10d3eb14@kernel.org>
 <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Content-Language: en-US
In-Reply-To: <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/25 11:12, David Wei wrote:
> On 5/5/25 10:47, Jakub Kicinski wrote:
>> On Fri, 2 May 2025 21:54:11 -0700 David Wei wrote:
>>>>    def _test_v4(cfg) -> None:
>>>> -    cfg.require_ipver("4")
>>>> +    if not cfg.addr_v["4"]:
>>>> +        return
>>>
>>> What if cfg.remote_addr_v['4'] doesn't exist?
>>
>> Not sure if its super pythonic but it's set to None in the lib
>> if user doesn't provide the config.
> 
> Ah okay. I'm concerned about the next line:
> 
>>         cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"]) 
> 
> If cfg.remote_addr_v["4"] is None by default then Python will complain:
> 
>    >>> a = "foo test bar" + None
>    Traceback (most recent call last):
>      File "<stdin>", line 1, in <module>
>    TypeError: can only concatenate str (not "NoneType") to str

NVM, it's obviously checked for.

