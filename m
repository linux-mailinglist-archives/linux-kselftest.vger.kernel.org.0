Return-Path: <linux-kselftest+bounces-9468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1D8BBD66
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DFD1F20C95
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEFA5A7AB;
	Sat,  4 May 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX4cAUdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB281E871;
	Sat,  4 May 2024 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714843033; cv=none; b=IKOhb0UsvGtDkMLVgZKE0bZUiuEGdRZ+inqLjiHEgmXuos85Lkp+fKEYfOvv1nPDzQWklhnXGWRVxZ6frTDV0ZtSt14NErLwWWHHhdADiZMvVBvahTxE1oa18eY07ZSIFBMf+flN+BFBFku8xpNcnmvtqkMaNAQz3qhL0INyR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714843033; c=relaxed/simple;
	bh=CHwURKhOVjoyYyUjhiWmlLKA/tlrP8KbElQ4Ku0JlQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMstSrXwmI+ZpkpHhy8oLwjhUyLCk9Cmt3aHVSIUJKfHA4mW3+iD2Hs7myVIAndc+l7LTfW/Ru7zjSDYSlvga2p04v9r4q02ckFZvAjnupNjrhTssYY/U9Un+qsxeIz19JUf5KJ5eM2n/j0/U2CKa6I2Fd64XgPLqSj8HybieNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX4cAUdE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5200afe39eso144757466b.1;
        Sat, 04 May 2024 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714843030; x=1715447830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9B1yS7dr1hXa9Yb30wcZ4uAWT7TVNCN9CZxLiBerBs=;
        b=mX4cAUdEPcCZdw6os1N1G+0pqOoFaTRjkJISg7DqFy2ak7uCOoh6buVFJnrlsQMYsy
         pVfwPoUKnYrxm5JngYo96XSzv2rc78uaZUtaoKUQO+oPZzoqTX9dJbkAnpn6FQMZndK+
         9ro5uJZgHRQCEV2VbyIOM6NKWciNKnTmArhlmpKHg69Qv16Pylo2W4DFKJAKa+nbJ3BV
         AXbIgRsS2Q6+wN2rajQS4WOjyn7c0Bu8yuzJEKFL9Md7LdsG61hswPrFT6QrUfdYuckT
         M7EcsGasr8xRvtwZUzXK9mtV0PkzYKNq1G+WMygeyvDCYzwlWsRCKvElm6nsCCEYKuT+
         wEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714843030; x=1715447830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9B1yS7dr1hXa9Yb30wcZ4uAWT7TVNCN9CZxLiBerBs=;
        b=R9eN4y81V3aCLt20q9aDu1ap/iKYxk16hPG9YBvSjFgCBAu3pd3W7cHknenhMB5CIl
         4cB20qbFV9zahStahBjEkX5X620TAngAWi+nLX9o24tRo3B4Zukv3fgJ9zKRvMuHDRD4
         PP7aXaYNxR261Qbauqjd6r5S4mZy+Xp+c/RNEGERsgG1FLpyTvHDElT83lZMY+nKQ1MA
         cJC+ve6JaOltmSYSQb+fjAodFaMWEl9rhQoSsQ3fite65L7U7z7oOOEw2CQKokSI+HZX
         +xyoNh1kqmucJ1dTuKekPn2LglGXrDuajVPWhhJeQBlRjqrsnWLjtPvH254xT8lW/yuB
         AQPA==
X-Forwarded-Encrypted: i=1; AJvYcCWVk+CB9WtymTs4ARRxt2Yp3ssNgsQfXeTdCCCwoVsIcUkEIdtNOC9i2P+qXD4G1zVKW34UIaGTL3rZFGDdYW4efAUmIPQBbrP6GFSeCuyjH96ruvUeJbcy+Fd8GXpAOR3Ua0xGxKllJm1UQQhs
X-Gm-Message-State: AOJu0YzkxbdrR+6o5X9NYE/mQ7OXBo7YsIJoqaJMWjSpnDjThIop3AFM
	A5LgZOaZSBQhHOpnL6xmlDUPA1AC8V12A9xTjjE44gznwVE/Hq67qmYZgxaPwcZGsM6B
X-Google-Smtp-Source: AGHT+IHJSobgUVfPrytId4RzTuvXfHlNHsRRimrIEzItdJZxbxdhkx1mULmzvRgrMpSWoPGwJ64fuQ==
X-Received: by 2002:a17:906:7acd:b0:a59:70d2:91b7 with SMTP id k13-20020a1709067acd00b00a5970d291b7mr4950325ejo.13.1714843029767;
        Sat, 04 May 2024 10:17:09 -0700 (PDT)
Received: from [10.67.234.135] ([194.110.115.30])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a59bf41edbesm318ejb.146.2024.05.04.10.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 10:17:09 -0700 (PDT)
Message-ID: <0910d537-c2e8-4932-8b0e-b5ce381e1ee1@gmail.com>
Date: Sat, 4 May 2024 19:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240417184913.74734-1-amer.shanawany@gmail.com>
 <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
Content-Language: en-US
From: Amer Al Shanawany <amer.shanawany@gmail.com>
In-Reply-To: <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/19/24 18:41, Muhammad Usama Anjum wrote:
> On 4/17/24 11:49 PM, Amer Al Shanawany wrote:
>> Fix the following warnings by adding return check and error messages.
>>
>> statmount_test.c: In function ‘cleanup_namespace’:
>> statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>   128 |         fchdir(orig_root);
>>       |         ^~~~~~~~~~~~~~~~~
>> statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>   129 |         chroot(".");
>>       |         ^~~~~~~~~~~
>>
>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>> ---
>>  .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> index e6d7c4f1c85b..e8c019d72cbf 100644
>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> @@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
>>  
>>  static void cleanup_namespace(void)
>>  {
>> -	fchdir(orig_root);
>> -	chroot(".");
>> +	int ret;
>> +
>> +	ret = fchdir(orig_root);
>> +	if (ret == -1)
>> +		ksft_perror("fchdir to original root");
>> +
>> +	ret = chroot(".");
>> +	if (ret == -1)
>> +		ksft_perror("chroot to original root");
>> +
>>  	umount2(root_mntpoint, MNT_DETACH);
>>  	rmdir(root_mntpoint);
>>  }
Hi,

Can you please consider this patch?

Thank  you

Amer


