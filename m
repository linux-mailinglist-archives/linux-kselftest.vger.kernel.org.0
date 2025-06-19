Return-Path: <linux-kselftest+bounces-35379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678AAAE0B9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5237E188473A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C328C853;
	Thu, 19 Jun 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sonx0FZw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B50232379
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352433; cv=none; b=bzK0sh9PxJG5i/qtn58u3t6h4d0xhhSO9O6lcHJ6kY5NfVjj5Y0qyyeQ+KRBkSZS68MlH8lheuTFSuAlROtHLAvtROKzx0Wg24P4kRpt3lsOghgc76lRwfE0X/OgtQZAUFIbbyfLMfzpeNqvYGehNn+lhklTaRzmu3a8UIaWj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352433; c=relaxed/simple;
	bh=uPybVpLsIsMyFgfJdsImZ2N7HnQRhF+PVpjFAbF0Dzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlvfodCJ5EiFFp/UHCj5IqSkiON9Alup4Ilo2ueAN0BXZEMvOCZfLQwzSc4/koJym2KOArE/Vb4i5t92MRTgpzZoth1iUGD7Bt8botgSRpRq05ffQTjp+8MRHvaJTAFIG1S7lVmS4MtcX/+pUi1LtJd+rXNszgFH1aAeY0Fnkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sonx0FZw; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-875dd57d63bso31653039f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750352429; x=1750957229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrGR3A/MzTERsKAHEw5tuDyqCBHYEq2BNnp9hGfCb0Y=;
        b=Sonx0FZwFxO7DDUgRfsbE71X2YidBC1KGYpWanRQnPhu/M+nqKtyDEj+jlkiwMKD4T
         sf5cq1GNQoZHX7tyB2WaBV7iKRS2oNkP4zLZ48uXD9olIUAqm98cbJER6ef6wFCSkuIw
         cka7f/DmEReRA5mCvoZer2wnjJ7L7ahyMiVIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352429; x=1750957229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrGR3A/MzTERsKAHEw5tuDyqCBHYEq2BNnp9hGfCb0Y=;
        b=EyUc/JMzMuUmhhtkTqqSqVlqfLM5CMRz7z7lDnmkZKCm37oqfNOoNIuGr3i5wFFEwC
         67ozBo5lmuosWiVkExKW9DJoCzUihYDshU+pvf1EnCt5aptY3gfTeQs0hSFA/FgYoM+j
         3VqXe+N9Ebq5yLxeZ34iHya/NEmdNE8eb1Z6E1wtd66aX29z/BP+EU3yMxNyiLilDjwr
         KbwnBVYOxTiB1u7YPlfR3KCp1fGqHW3ZkW/euVdEPWjN3areHZUOqsg7OT+euiqb5lL8
         LjYp2VXFopZ9W63PM9IDC0fY8xdAEnJtw1sicijKIAsJvNm1zaWtCrbDoWnkxjLdZGex
         Bd6g==
X-Forwarded-Encrypted: i=1; AJvYcCXkaIZFLK+k6ewA++kBvu6o7nup78tls9Qq4oR/EwxwgmGaRSIi4btAuG0C9W78YCtZv9AYbBq6cFB4I5m7uh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjlkILJMVA0zqeCoowpAHBYoVDHQ0drxHrBagk9r7HS9bYHJb
	TYHGNxbLDrkWxB+NsDr/AdjkJ4f4kHQkQmRIL0PAPsCv8S4P4luTHjjng3jbYvFJtME=
X-Gm-Gg: ASbGncswL9prnTtbPF/gqbL45NxZ8sBA60D9mpGFIUOrUC6FEPVQmbIASBkUUz1Lt3/
	yGyjx1CmQSBe5L9ZbqB2/c9mfMXPCvozZ+/Kw6qXYdYzYASWsX2tVxO8G2B7qQWa+/NKdYmz09q
	eiJELCdBR/UeERGuCQ1S0DK45nkbmhl1cMr9XuW1QDyaIrhCdujMbINVgMsHPVdGVTTyfXbWVrw
	oEWgvyCyaQ3t5h/LhdaZL4aZdwxpaQTBo+kF2JYRBV4MED5DehtKr+58O0OftnS91G7RiNOg+tD
	qC9/b9eVgOwLDrD78y40eob3WJdupA669MqUTlSETE+NEDlX22xd2GJmHcQavXOMb5hydES6fw=
	=
X-Google-Smtp-Source: AGHT+IFxdRrSy/zh8FxTysdpmdEMQQKEznUBpGiYumC8QbbatcxTKtl5mzopCeH8zCCCO6iYvZa4RA==
X-Received: by 2002:a05:6602:6426:b0:85e:73da:c56a with SMTP id ca18e2360f4ac-8761b782975mr392275039f.3.1750352427918;
        Thu, 19 Jun 2025 10:00:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5019deef1c6sm52140173.35.2025.06.19.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 10:00:27 -0700 (PDT)
Message-ID: <265ebc1f-b0c0-4c57-92b2-41714469c7f5@linuxfoundation.org>
Date: Thu, 19 Jun 2025 11:00:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
 zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
 <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
 <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/25 01:46, Chen Linxuan wrote:
> On Thu, Jun 19, 2025 at 5:23 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/9/25 20:07, Chen Linxuan wrote:
>>> When running `make kselftest`, the following compilation warning was encountered:
>>>
>>> mount-notify_test.c: In function ‘fanotify_rmdir’:
>>> mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>     490 |                 chdir("/");
>>>         |                 ^~~~~~~~~~
>>>
>>> This patch addresses the warning by
>>> explicitly suppressing the unused result of the `chdir` function.
>>>
>>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>>> ---
>>>    .../selftests/filesystems/mount-notify/mount-notify_test.c    | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> index 63ce708d93ed0..34afe27b7978f 100644
>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
>>>        ASSERT_GE(ret, 0);
>>>
>>>        if (ret == 0) {
>>> -             chdir("/");
>>> +             // Suppress -Wunused-result
>>> +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
>>> +             (void) !chdir("/");
>>>> Why not fix the problem the right way by checking the return value.
>> Suppressing the error isn't useful.
> 
> The code is already handling cleanup in error cases,
> and I don't think checking the result of chdir would be useful here.

We check for chdir() in several tools in the kernel. Add a check for
it instead of suppressing the [-Wunused-result] - suppressing doesn't
do any good.

thanks,
-- Shuah



