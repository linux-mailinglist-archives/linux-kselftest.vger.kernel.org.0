Return-Path: <linux-kselftest+bounces-35326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647ADADF8AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 23:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2316163E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F25F27A935;
	Wed, 18 Jun 2025 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K5j37Qgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4B27A451
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281813; cv=none; b=t22fnIRWJvW/IA7bffeZo5l3en+ZLZrQTL2xOP/SpS5WoSsg42e0ScEne6QgRpFAM4+JEBUemPpWzgK/ln1IlxqcDHcC5ZzVwm3Nyy1/zR/93HIENKmHsr6kCTG1Fc0AZGfcUILcK1eTwkIImqZwCUR5WaPggt1Kd7B4DoNfbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281813; c=relaxed/simple;
	bh=aWzheBExx605/kaS9Wbo1Kq/Oc9iZj7k073g4/QWCyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9uw20aUWQf/3VZQSxK08ZTc8hFpnYopQX0VQbcySp3yzBE0ttTlrqu3ItYKhc11U4L5qhQJkNzbAi4DB+QPLgLph7EuHtw+E28ti2FJN87RL7uSj7JxSK8vek9FN4zcGrCpxxn8dnpzQ7NHdCbZMHi2weJbF+qLReymQ0HDhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K5j37Qgy; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso1215465ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750281810; x=1750886610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6sV7qHQdKaHhxnC4ETSYEcVnc7jr9HhyL4rG2dvMmY=;
        b=K5j37QgyzzYS0ie9cQz2THNOA5vezejcvyOquxoT0PdV481EHbQoMfMTyOyvNb+9y9
         7UhVHXYDnRNv3T+8Ns1t6IWOaaF359VV/ASe+yxDCg6UwcR5RwtsEPi831evA5ZP8/rv
         nBraNhF/JgFg96m9XEkq62+Pj6HjUMv3jgq4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281810; x=1750886610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6sV7qHQdKaHhxnC4ETSYEcVnc7jr9HhyL4rG2dvMmY=;
        b=oWz8jnLUqGyepDpZKikgfUY4IH8B3teCnc5KsxyQchsHZtTu79UfoEj9nu2Ejas9rv
         tWVdHVHq9MWMqMbTVOx13eEahB4bgnoRW+/w65CGf9qpaHuLw9ViarXfClbIbcmLgKbc
         MTH5I59kVpRdLQBV/nF0I75zirsUmk0YS21Of0RRw7JBMoG1XHw1FzBYMpghEk1k3SuT
         DazC/r4/NR3Q/Saz1Dg3KHn8U70eAUFGSBKXrSgFBpom39qJwWMxXmw0+NocK9MA2vWU
         GNH6FWaRtBFP0OvBQ+L3Aw2BbrkJDPeYxqzpknWjTRajS4eLHSQ3Q6gLVyUYXjlDLmvY
         vokA==
X-Forwarded-Encrypted: i=1; AJvYcCVCZpKQ5WMZUnAD4ZFiSiI+YzM/F6XUOHRUhSbqT5KbrNuRr2rKEyfPDCX/GIZG8IExZEER+7n4hi4GQhGx9Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIReQFWhFCadgMrkzELFPsJ/jlTXaa5f7KGQ2nFGqZ0cRBJHc
	2J6uHkjLkz9uVkicnQCEAyJMP3Ir4XGYmUFbeb90MfsNdBIwTXp9GM7GF3l2p2TvOlQ=
X-Gm-Gg: ASbGncu8zrYP3pmrUYtvOMUI7LR4iAxHNF3NK/dlWhNcJufvkjOqCLenUXunvQqigRr
	sKNR5kuNuzvlKH2VZ7RXjhU/6Xgk6U1k6qagybJwPInEuDD/iEgVix5TqhMDeG8zGJxpC5U8Q0e
	ULGgKFCz+sPxa9CHdjPBL7pWnNk2PbRtfMY910bR65FlwUXHVmVOTAg7HeUw5wbEVfOPYwqNlIv
	O7QsGw4/78rSmfrpG7XozXZsFryyq8aNX1J7Ej9LBZg025R5gDtcZWkVsiuO7Wy7SCvFaEst9tm
	P9jxZcvY2NUjRbghdcEmPSElGgTmWFTXtA/J7CiJ8UxUD2dK93orHzMjPjaoWyJJmUV6aNFvyQ=
	=
X-Google-Smtp-Source: AGHT+IE23eybjXWS4z/bT19rttKU6h/MoxCD5Grs4L8zPPCXAZT6lQYFoKXILDtwTt9KHVMd1reIhA==
X-Received: by 2002:a05:6e02:16cb:b0:3dc:8109:d64b with SMTP id e9e14a558f8ab-3de07c3fd0bmr215112015ab.5.1750281810365;
        Wed, 18 Jun 2025 14:23:30 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de019b43fbsm34884495ab.6.2025.06.18.14.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 14:23:29 -0700 (PDT)
Message-ID: <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
Date: Wed, 18 Jun 2025 15:23:29 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Jan Kara <jack@suse.cz>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/25 20:07, Chen Linxuan wrote:
> When running `make kselftest`, the following compilation warning was encountered:
> 
> mount-notify_test.c: In function ‘fanotify_rmdir’:
> mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>    490 |                 chdir("/");
>        |                 ^~~~~~~~~~
> 
> This patch addresses the warning by
> explicitly suppressing the unused result of the `chdir` function.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>   .../selftests/filesystems/mount-notify/mount-notify_test.c    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 63ce708d93ed0..34afe27b7978f 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
>   	ASSERT_GE(ret, 0);
>   
>   	if (ret == 0) {
> -		chdir("/");
> +		// Suppress -Wunused-result
> +		// Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
> +		(void) !chdir("/");

Why not fix the problem the right way by checking the return value.
Suppressing the error isn't useful.


>   		unshare(CLONE_NEWNS);
>   		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>   		umount2("/a", MNT_DETACH);

thanks,
-- Shuah

