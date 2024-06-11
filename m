Return-Path: <linux-kselftest+bounces-11685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7A903FE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04571B238DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CE2C694;
	Tue, 11 Jun 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KoCMf8Bv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85322331
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119404; cv=none; b=P0MHvPwp9Hi7r00HUQFKZqf6i8GiDCRSNznQAdst7mWHyNGaxUMhmtmIhv1KpSuRWT1pOr00YUU+cHn2Wa8cDBZKwaVL6p8XK9b+b9agPkhQMcfPFXJ3fc7phPjAomrj/7W633mea7s8gtj1k+xF23p0bgzZmxGUUDkvRxAnNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119404; c=relaxed/simple;
	bh=ZEJOzWLv67Lt9koj3wAP6SNyrkJMfABaIM3Sukt+QDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6yERir4FIH2TIB9K+ki6k4+0nmZHG+H92ZczDoAbT2o3E0mAGT7F89hXHU87mnJu8M7c9cFjOmKYmGW32YNrPIAaGlSUNewqll8u7vAAHtsBP54nWZgfrk2eOGXXooYFqBdfoHIczAZ4dsk3ghrJ4JTuprtVd5VGwIst8TcZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KoCMf8Bv; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfb1ac0f03cso231001276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718119400; x=1718724200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdCqb4jwOd5pvnTn6Ox/jiqyDLoaZHnkqS07QEcqzS8=;
        b=KoCMf8BvvVkBBxeWOcoScOs/UWAWHnNp8zu801CsFL/f9NUM3eW/fhXwJVCUe+gcEC
         AZjZ5W+mUPaZyZyxfXcQTjHmR2K3Bth4FFMGTDGAu+4F2l3WDYf3y++XuIQcwGBkm9Fs
         LNJC79ntThtW9/bEvE3vz0oPT//eF8Dbyepww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119400; x=1718724200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdCqb4jwOd5pvnTn6Ox/jiqyDLoaZHnkqS07QEcqzS8=;
        b=C6rtXgah5esxS6imCxzk0E75o401h5HnL7ogsmam6pn/cpCAzTtXO7iNmudeHvZA2j
         uTmWNHHEdwRxGitUwS2JRKjybbDLh2AGC3rBCmflqRcWm+lChmOMbJl43930awcnTNmf
         BS3i8BURhFZn6OFFd0niXAJg7EGCunRjpf27DilItOCbhBSLUgHhTXPmhiRUIMNX7nbR
         XIyyjnAEsSOkbHoFeQCeif8Rs5G629KBMWjMfX+enMnS+AkWDlA6ugphKM9sdEy4B+4F
         d5bdu17j6nIEYMfd5onVcVAkb0UJWoXW0rGFV5lvpiM65sMWxCV/BTmh5d4Rrs3lA0SY
         c1hw==
X-Forwarded-Encrypted: i=1; AJvYcCVpDv6tWpmKaC6d6WFpIxnQqE6/IlZCenl7q0LLBVCzdXydm7cKU24lSDH+F8FizwEIR7TlPDTcG0935phBYA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetwaldA0Os9pBdwTRr912YKp1fStNSQG7QjFLxjJHauNQF7pO
	WArDYQuYijz7a2+jh/vwZOjIvlFFLGKZAD+kteWNfIEJcdcaAVEwGL2jA0stvGg=
X-Google-Smtp-Source: AGHT+IForU65yRH2mMmwK2Lm8iJCItX19a8sBLN/kbwf7a2g2EOmV4suGjU+wzNEWJkCVA6F0nsC2g==
X-Received: by 2002:a25:ab2d:0:b0:dfa:fcb9:8201 with SMTP id 3f1490d57ef6-dfafcb983admr10061824276.6.1718119399856;
        Tue, 11 Jun 2024 08:23:19 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfb0823b4f8sm1469795276.47.2024.06.11.08.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:23:19 -0700 (PDT)
Message-ID: <61f322f5-8b4b-4f5b-8226-e44846e10c09@linuxfoundation.org>
Date: Tue, 11 Jun 2024 09:23:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240417184913.74734-1-amer.shanawany@gmail.com>
 <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
 <0910d537-c2e8-4932-8b0e-b5ce381e1ee1@gmail.com>
 <5dfdfa17-d3b3-408e-a8a6-b8dc0756eac3@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5dfdfa17-d3b3-408e-a8a6-b8dc0756eac3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/24 05:17, Amer Al Shanawany wrote:
> On 5/4/24 19:17, Amer Al Shanawany wrote:
>> On 4/19/24 18:41, Muhammad Usama Anjum wrote:
>>> On 4/17/24 11:49 PM, Amer Al Shanawany wrote:
>>>> Fix the following warnings by adding return check and error messages.
>>>>
>>>> statmount_test.c: In function ‘cleanup_namespace’:
>>>> statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
>>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>>    128 |         fchdir(orig_root);
>>>>        |         ^~~~~~~~~~~~~~~~~
>>>> statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
>>>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>>    129 |         chroot(".");
>>>>        |         ^~~~~~~~~~~
>>>>
>>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>
>>>> ---
>>>>   .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
>>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> index e6d7c4f1c85b..e8c019d72cbf 100644
>>>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>>> @@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
>>>>   
>>>>   static void cleanup_namespace(void)
>>>>   {
>>>> -	fchdir(orig_root);
>>>> -	chroot(".");
>>>> +	int ret;
>>>> +
>>>> +	ret = fchdir(orig_root);
>>>> +	if (ret == -1)
>>>> +		ksft_perror("fchdir to original root");
>>>> +
>>>> +	ret = chroot(".");
>>>> +	if (ret == -1)
>>>> +		ksft_perror("chroot to original root");
>>>> +
>>>>   	umount2(root_mntpoint, MNT_DETACH);
>>>>   	rmdir(root_mntpoint);
>>>>   }
>> Hi,
>>
>> Can you please consider this patch?
>>
>> Thank  you
>>
>> Amer
>>
>>
>>
> Hello,
> 
> Could you please consider this simple patch for fixing build warnings for kselftest ?
> 
> Thank you
> 
> Amer

Applied to linux-kselftest fixes branch for the next rc.

thanks,
-- Shuah




