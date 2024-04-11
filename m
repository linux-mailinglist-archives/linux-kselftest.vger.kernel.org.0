Return-Path: <linux-kselftest+bounces-7731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE68A20B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2181C215AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3C33062;
	Thu, 11 Apr 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9Z2wqZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A417582
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869871; cv=none; b=ipHZE+xqv5Il8HHwoMExUr0uyC6t6JH/aIEOIMKV3Zi/rI4cjWbVYzVXm8jza6QOSQbb/pB0VlE5Dd6jQypd8TiN8zkMEPymBD//GXMJQCVCUDkGuyHaFAtLOhznZDhE7CC92YyDzjX9A92g5SGSgChj4+4KVCkeQ0CPHtBlLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869871; c=relaxed/simple;
	bh=IEBJoFDSC/xhmN89SjQvJVuzGWr9gyS0EGlcaOZ8eMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hghdoa3dbUE5BfJ+CH8GCV+T/ljfot15152Ld9Ix7aYOQZUYydslCnZJG4yxfH3tB1snvLfwINob53v/7JAvFNjzNwBy3SiEMNu9031F9tI7wGma9HRGjKrO/NhNkQtD/Hg1oNpXsdz/xnMj9VHuxrkOKi2H6FSuV2+TiZfE3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9Z2wqZK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso2935639f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869868; x=1713474668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38LeeLy9B9nLfzSgbJxSutTG0T1HzptAeGhsMkzO9sI=;
        b=R9Z2wqZKlDPndBsAvIivYDjvNSev/rgLBf4LwV3Kni+m23IgN+pDY7fFz4kNLdy9oI
         vGm+hpHztC/B5G2tl4YXlLW/fLuLYOKO20cS9sFLm30Q16Nb8SB0NH1z/qQUZSSgRvFN
         CuBaI4aGvrwTEqpRTBQfPPwmf8GqNLPCSzznU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869868; x=1713474668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38LeeLy9B9nLfzSgbJxSutTG0T1HzptAeGhsMkzO9sI=;
        b=WnMdXp2rPcEWtLKwPRxVNZjUeKu9c1nk1twpARpu4dV9g0YeWAcAFwV/N4ThRqGAY6
         qJYHbbtZIsiZq3MhkYtXQRxSxfo4YTD0G3VXD7YN8Y9SqNhpM62hw+cONdZDm2EN+piL
         x92P2QoQT2knk0ACeCbZA1jwByRPdtSDvKdNJlDxA2v9bROtoNV5YVbpvbWKeXnz++qA
         BzMaTjFBLFqgj8Apa4xJF9AU3OXXSH6LRO+G37BBF3zvXw2JK/Llxf06M5//UgPZNAsO
         JcWp6QL19GDXFI0UtpeUo/TP6CnavED3VloVIZ/KQCJtRmgLPyS5rWoBYcN8MNLagZfU
         ElRA==
X-Forwarded-Encrypted: i=1; AJvYcCWlX9gl9z8dTD7cgPNcYoZ5uKSIdqNw1kyhIkYEWWinXJMvIaa2iYj0DtUEhCMlJfvomvENT8JxJ3DXKgR1zV35ML/qhqIiO7pwiA0/QDH7
X-Gm-Message-State: AOJu0YyBqREDDMQ/k3ADyuYeIjF8L1iwTxw/paixucZ1TkYMUieRcaHl
	VVU6ij7tQ2hMqjT+FMFN45udxkvrSfNJyF40xfKftxScyLIGDtWANVt3SgVBWhE=
X-Google-Smtp-Source: AGHT+IEvOEEya92osbmmTcRV/7dhRZrlPtPgQIc4ZlZO618j3bCXYpmIxG7Z7CY+DhVW9kJ6yy/Esw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr1040368iof.0.1712869868075;
        Thu, 11 Apr 2024 14:11:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bv21-20020a056638449500b0048075de1461sm598414jab.90.2024.04.11.14.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:11:07 -0700 (PDT)
Message-ID: <8254ab4d-9cb6-402e-80dd-d9ec70d77de5@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:11:07 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: Mark functions that unconditionally call
 exit() as __noreturn
To: Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de,
 shuah@kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: oleg@redhat.com, anna-maria@linutronix.de, frederic@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev,
 John Stultz <jstultz@google.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 12:45, Nathan Chancellor wrote:
> After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
> check_timer_distribution()"), clang warns:
> 
>    tools/testing/selftests/timers/../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
>      398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>          |             ^~~~~~~~~~~~
>    tools/testing/selftests/timers/../kselftest.h:401:9: note: uninitialized use occurs here
>      401 |         return major > min_major || (major == min_major && minor >= min_minor);
>          |                ^~~~~
>    tools/testing/selftests/timers/../kselftest.h:398:6: note: remove the '||' if its condition is always false
>      398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>          |             ^~~~~~~~~~~~~~~
>    tools/testing/selftests/timers/../kselftest.h:395:20: note: initialize the variable 'major' to silence this warning
>      395 |         unsigned int major, minor;
>          |                           ^
>          |                            = 0
> 
> This is a false positive because if uname() fails, ksft_exit_fail_msg()
> will be called, which unconditionally calls exit(), a noreturn function.
> However, clang does not know that ksft_exit_fail_msg() will call exit()
> at the point in the pipeline that the warning is emitted because
> inlining has not occurred, so it assumes control flow will resume
> normally after ksft_exit_fail_msg() is called.
> 
> Make it clear to clang that all of the functions that call exit()
> unconditionally in kselftest.h are noreturn transitively by marking them
> explicitly with '__attribute__((__noreturn__))', which clears up the
> warning above and any future warnings that may appear for the same
> reason.
> 
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
> Reported-by: John Stultz <jstultz@google.com>
> Closes: https://lore.kernel.org/all/20240410232637.4135564-2-jstultz@google.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I have based this change on timers/urgent, as the commit that introduces
> this particular warning is there and it is marked for stable, even
> though this appears to be a generic kselftest issue. I think it makes
> the most sense for this change to go via timers/urgent with Shuah's ack.
> While __noreturn with a return type other than 'void' does not make much
> sense semantically, there are many places that these functions are used
> as the return value for other functions such as main(), so I did not
> change the return type of these functions from 'int' to 'void' to
> minimize the necessary changes for a backport (it is an existing issue
> anyways).
> 
> I see there is another instance of this problem that will need to be
> addressed in -next, introduced by commit f07041728422 ("selftests: add
> ksft_exit_fail_perror()").

Thank you. Assuming this is going through tip/timers/urgent

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Usama, please send patch fixing this problem in next on top of

commit f07041728422 ("selftests: add
> ksft_exit_fail_perror()").

thanks,
-- Shuah


