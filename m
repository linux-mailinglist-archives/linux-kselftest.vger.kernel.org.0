Return-Path: <linux-kselftest+bounces-35324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C67ADF8A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 23:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4359216DFEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAD27A455;
	Wed, 18 Jun 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+muPs9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78D261362
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281706; cv=none; b=SBnnaG2k6SxEJeEhy2DYCYWNiJQx+Ora5p2Z9K1uE77J/2+T1yR4zV4nq0HfA5myLp9E9N0f2jGaOJ9oniq0w7gk8m0g1j1IoS5Pf5z/I7GAAipEUnliWC9D1E5Mvp2040vWzNa7WL7dnbKJU5GNnlJqoatFvvabIFJ0SV9kzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281706; c=relaxed/simple;
	bh=3Q9A+Uy7HEpDEX/GYqxA+SpsZyCTOKE2HK1F7wsecDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkUnKHwRCUtPAmq7eCrpCb8Mn1pjYkXLcZbKl9mRwqZCYY1Lwo/eiapWiMt+//9RQtRuGkdcCSL/4hX+sLHb0cUGZqurbOWRqtG/fFs24Uy3zUM1UG6MQheq3VYpsEq/EdrgJ8mYF1Y60zIO1qPalFx/K161f3pXfCx05yXXhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+muPs9K; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddd32e3955so468165ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750281704; x=1750886504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hzjQpLH9P4msqIcMls8fz15GHsVyIhA4zncYp2T3JY=;
        b=I+muPs9K4M2rexzJQ1Rp4eTUrNd0Ha1m4qBsozNXGH2KGc40Zy5om69dh1QIDe+fxQ
         xdD7A6chgH2X4p3btPeEckxS8weZQL+bEymjJqAhmEfZMk/8nrtQK9oYyPgXtbPeUSJj
         A8yAfXLDjNraE3LUgFbARQCVPH90Zj5rAoqqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281704; x=1750886504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hzjQpLH9P4msqIcMls8fz15GHsVyIhA4zncYp2T3JY=;
        b=TygsF8KJaZswumcp5mjfzoeS2xYROXLgDOsM2qKbK2Y7LfvbC4jxefkfMEdbW82nbu
         zofGz7xnW7goj0CEiz5qYI177Kxqc1RF3eyOYui64j8i+KpDIGH8dj55FN3jquuX/JW+
         jEVbj/rsH4J7GV8h36gjCZyNomTBm5m7EO8eqJF8Yo8fbY+BSN4hdq04OzZBQ8bB3mKj
         CNf2SP7gGW31PInZ99MDGGF9jN6yjeOguJUDdbtU1waUJWsMuhOpctYHyiyt8UkPJkfI
         1hmK/ynANoJxXbzsGYI9IaWnU+23wIbT4VoiX2O/HNHZw2ajSRBGFqW52vB5twrGrB3Y
         1+gA==
X-Forwarded-Encrypted: i=1; AJvYcCXlaotRoWqf/bcmdDD9a34veo70hRpb/sL22PJQLdtO2YkOB7lttm7NlvEh08LANYTXHI2E6hiHscDarHOA8Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyD2Uygf1BYhwNjWMxyi4STO54xlwz2aa84Aygp752FeIeOlEu
	MvNTbYMT5YTzy74mDKQlq1kFWvak+y6UKH4/nf12UQp4Dm3ZWR7Bz1LTv4xb1Wgf0fE=
X-Gm-Gg: ASbGncstvvpkv9/yDBEdZqkmceu31t3HARjnGW+VSuRSlHorD4IySNpKkY2iEKnDBYD
	QCIsouAKC6dkRFIM08g8vsGtInkdPzlY+JgCcI+KvdoIYZ15hZOuateP2zHg8zG1cJ0dyr0qud9
	NLQjqd3iZ2Flt2vUbLk3h5KO5Ucm729qcdRkHeYIuTMouP8mewE9QGidxC5AgCdvLMGCZA8F+GL
	MxMpKCVYuf6J2lmBTygVobAASDNLLDBq+P6x+enCqU9oJI1hC5VohkEY2tUz9FYG3H2Acky+sL6
	NPb9SFHTsEotsLtoJU+48zZfPNtIczXVop15sXkuTaSu7vo7kR+D2JBqXFuCVKkB/2FHoMt6Ww=
	=
X-Google-Smtp-Source: AGHT+IELzvwbi9JQ7DZZenz0U1vkPgwf8oGH4UkYFmct5jt6JQyDwhZyf2BVjZryMiJrjh2k6xcFdA==
X-Received: by 2002:a05:6e02:18ce:b0:3dc:8b29:30bc with SMTP id e9e14a558f8ab-3de07cf9efcmr248982405ab.21.1750281703912;
        Wed, 18 Jun 2025 14:21:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de019b4398sm34101575ab.14.2025.06.18.14.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 14:21:43 -0700 (PDT)
Message-ID: <96c46d3d-0e0a-464a-b64c-15c2a544a974@linuxfoundation.org>
Date: Wed, 18 Jun 2025 15:21:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/memfd: clean Makefile
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020559.2797938-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250610020559.2797938-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 20:05, Chen Linxuan wrote:
> When writing a test for fusectl, I referred to this Makefile as a
> reference for creating a FUSE daemon in the selftests.
> While doing so, I noticed that there is a minor issue in the Makefile.

What happens if this change isn't made?

> 
> The fuse_mnt.c file is not actually compiled into fuse_mnt.o,
> and the code setting CFLAGS for it never takes effect.
> The reason fuse_mnt compiles successfully is because CFLAGS is set
> at the very beginning of the file.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>   tools/testing/selftests/memfd/Makefile | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
> index 163b6f68631c4..e9b886c65153d 100644
> --- a/tools/testing/selftests/memfd/Makefile
> +++ b/tools/testing/selftests/memfd/Makefile
> @@ -1,5 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -D_FILE_OFFSET_BITS=64

What's the reason for deleting the above?

>   CFLAGS += $(KHDR_INCLUDES)
>   
>   TEST_GEN_PROGS := memfd_test
> @@ -16,10 +15,9 @@ ifeq ($(VAR_LDLIBS),)
>   VAR_LDLIBS := -lfuse -pthread
>   endif
>   
> -fuse_mnt.o: CFLAGS += $(VAR_CFLAGS)
> -
>   include ../lib.mk
>   
> +$(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
>   $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
>   
>   $(OUTPUT)/memfd_test: memfd_test.c common.c

thanks,
-- Shuah


