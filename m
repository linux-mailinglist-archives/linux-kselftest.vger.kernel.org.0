Return-Path: <linux-kselftest+bounces-11104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9C8D80DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B31F212DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96983CD9;
	Mon,  3 Jun 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEMLzZI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04D433AE;
	Mon,  3 Jun 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413483; cv=none; b=PkvJV0hYR6rXBLpASsCllNEw3wNCVsSba1PUZLHc/npRFnCaf2BtbYbBwZWL+SUXMoCMJrDl5K3CRWEDitgKvIm5aUJMT9KN1WxgBznZnL2RZIqjv7C8597eO5x/vV60fIfmoHre/3m8Q3m9dhCxcLHxHNc1vub3oRBS5D+yH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413483; c=relaxed/simple;
	bh=fNXSMsIfpEIa8xVCHoOcoT1rEHej/fTjnMleI/hRA2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IvlgPEhD1xGmeuOe7k7qd+Xm4zwYxZuKkvZEIE9blmnHz8XFGcT/DKdGczx7GoXTouluadsXltAL+37d9pydbxt2Th+fe+R/h0jeM/z4LT6Mi3wp0kVPI/XMk+VW/6yLQE0JWRq6qe0C0FlN+Vg9B+e9wWCOkzHHfdgkKJfiA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEMLzZI6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a68b0a229so480258a12.3;
        Mon, 03 Jun 2024 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717413480; x=1718018280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tl3ulKo5GJTw7HBOMHVnR1dxMRxq4LpVBTOeiObvY4Q=;
        b=iEMLzZI6L0psMOZFXxkDtgFer225An3XKA5K0llVIC3UKC1xS9sJVhW79I+3wTjAEQ
         vsBHKd2eIL+L4hL098uBSejQFeRj7Dq9uiL2TUHuUuQgp23tYFCpIfwBubqurnh13pAF
         dTDl5tCRr1Uhwwsoyd49ICbB1A9nO9z/+2Y+HX1PMSmTIyFO0TZ/hJ+/S2xPiZK0Ap5L
         eE906ZqFW5DUU6YvqrkFN0l+NW4Qaxd+Ho3I9O9zM1ayGF7Cr2ZqijOpDLmXxG/gFQNi
         jG1+yg6CyNsyMevvJ+QjGaNpevyk88rpa4o5zuZaqiN4oPeAAmnmz6ZWDwDSnPJXhvT/
         W0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413480; x=1718018280;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl3ulKo5GJTw7HBOMHVnR1dxMRxq4LpVBTOeiObvY4Q=;
        b=amGcQltsGvM4Crb2dHJGrOgBeL/JsSsDGulGlZ3GZD32zk0Dix+N+pDcfQ/1ewMMRS
         9UhvEp2hC7fm/tZlhMIKinYbLJBJ8TZRrRj8MpJNlcp3qmvlhTi8QQodV+Jf1m5pFa4j
         xQinpoVu3Jd+TbyZg3rnB+UP5/N4X7IFeeHqJavMHkKrNNWJzXyLkhiE80DMZpQkYgN6
         i+Re8LowP2eFuIDeZ1qkk07+c9pi6pI+Uv1+1x5/kjEpa9W4PvpedNGgy5upR8ud+hmg
         oH0dtWYc7FOu9uz+Z0jZzrLAOQb00vMokIKRt7ajV1yCmhQtI3MW22tc/wTX3EkRl+Ti
         8e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6aUy3XN73lsZ4K2Pl0TS55C1FETRuoNd+KHgKQ0WHJbI/UnpnWeqWo5N/N2vWiZEETI5usOJCNx6RzgIyc8SYh7Hi4yVOTB72yUpK0r9NBsKBsnsKM8a7dh2zh5X5xU22FC5uw3X5Zkm3LePl
X-Gm-Message-State: AOJu0YyGN7NXhQjwyCxQFWadscFsVxUx2esJS0DzepxKFS+uMwtyYFu1
	K6Ya74IDkupbKjUUX41ToVbuAJTkUNHV4TeIgXKQVev8ge7YUlEDol6boc9iRgA=
X-Google-Smtp-Source: AGHT+IH7ThME1P861evYzO3bn2mTV8SABwp5+HfMTEHS3eGeHuOpJXkBBO7KLO0pwIaFoGiwWdKZqw==
X-Received: by 2002:a50:935c:0:b0:57a:4af6:3197 with SMTP id 4fb4d7f45d1cf-57a4af63298mr3451951a12.10.1717413479962;
        Mon, 03 Jun 2024 04:17:59 -0700 (PDT)
Received: from [10.67.234.135] ([91.90.123.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99c42sm5074007a12.17.2024.06.03.04.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 04:17:59 -0700 (PDT)
Message-ID: <5dfdfa17-d3b3-408e-a8a6-b8dc0756eac3@gmail.com>
Date: Mon, 3 Jun 2024 13:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240417184913.74734-1-amer.shanawany@gmail.com>
 <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
 <0910d537-c2e8-4932-8b0e-b5ce381e1ee1@gmail.com>
Content-Language: en-US
In-Reply-To: <0910d537-c2e8-4932-8b0e-b5ce381e1ee1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/4/24 19:17, Amer Al Shanawany wrote:
> On 4/19/24 18:41, Muhammad Usama Anjum wrote:
>> On 4/17/24 11:49 PM, Amer Al Shanawany wrote:
>>> Fix the following warnings by adding return check and error messages.
>>>
>>> statmount_test.c: In function ‘cleanup_namespace’:
>>> statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>   128 |         fchdir(orig_root);
>>>       |         ^~~~~~~~~~~~~~~~~
>>> statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>   129 |         chroot(".");
>>>       |         ^~~~~~~~~~~
>>>
>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>
>>> ---
>>>  .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> index e6d7c4f1c85b..e8c019d72cbf 100644
>>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> @@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
>>>  
>>>  static void cleanup_namespace(void)
>>>  {
>>> -	fchdir(orig_root);
>>> -	chroot(".");
>>> +	int ret;
>>> +
>>> +	ret = fchdir(orig_root);
>>> +	if (ret == -1)
>>> +		ksft_perror("fchdir to original root");
>>> +
>>> +	ret = chroot(".");
>>> +	if (ret == -1)
>>> +		ksft_perror("chroot to original root");
>>> +
>>>  	umount2(root_mntpoint, MNT_DETACH);
>>>  	rmdir(root_mntpoint);
>>>  }
> Hi,
>
> Can you please consider this patch?
>
> Thank  you
>
> Amer
>
>
>
Hello,

Could you please consider this simple patch for fixing build warnings for kselftest ?

Thank you

Amer

