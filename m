Return-Path: <linux-kselftest+bounces-14589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74098943921
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DC91C2117B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AC16D9AF;
	Wed, 31 Jul 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQrt5S6b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38516D31F
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466593; cv=none; b=m8A9SnpehOu+vLRW/qVlmK6WkYHEO3jN8qnqE/xs8FMs1s9x6ywLRXk7ozYqsg+WIb9hBwOZGKSNWmG3ItCbsNC4Mjd82lEOYQ1mn2SdOm0eEJiYz7td6yj3EEjYzXJOKMTggNkeY5PwAcsabOW2j31Iy4YW0yx5gETdLJWLTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466593; c=relaxed/simple;
	bh=Ebosq3cwyBruwiE9aeSWL/53cRFfmjfzUGrFTcpmIpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBryV2OvvWsel1RBFJplXEcsy3aynI7BwofR2enIAQR1mDbYyytoeqg1bAim9WyV/OaS0EDVvFIyOViBFuxudwNAcxjLctSKZp4Fr0q2QQRcef5eku4bEOp4XvJcAA7sBEjP8g8YoOLcrz0DaFrzKEBBfgh1MRq5OxfrrN7iC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQrt5S6b; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38252b3a90eso1491105ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722466589; x=1723071389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsGqV04G2H9TtXqt68J+lGioNnr8QfMZ/BUMYQBEazI=;
        b=FQrt5S6bxBz+raveuUNwV+ixdjlcS9Xg+MljzOJXQhkHmdWP9jiIND2c/jYRhiMRS0
         igPDwS+pKHEug1kLC9Qv6uUbBtROZ8efEmMV9Sq9duk1hXS3RlswnBdEpg8+i22uQyY8
         OajyFQgnvHZK0hfexC9NLBrFzZP0/0PU4elnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466589; x=1723071389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsGqV04G2H9TtXqt68J+lGioNnr8QfMZ/BUMYQBEazI=;
        b=jOm0KhoRv0cCMKk0m86h2RWBA6CGMSiI1kuiK15JP2IL3YwHnRFRqHF/0cNNMKcrXX
         SDAnKkW4mVzDOEETB49mXKlLx8Fn/H/sARDCbvJYhob2YETl4BKCoRZQnXfP5EFDfLv7
         kNa2Ry03cW7P8dYT1mp0QNb6BOK2+POI539rsYzaW2Bdc2vZ8rdRFZI9IgmHzeQ6KY8p
         m9Yp0UlF1pX58h0Zkezg4+sebis3ZPclCgdJi6hoWx5l3dqRHCaCvecLZ1imav9Aa+DW
         pBDWyCZnhB4SY17EQRAU77sF0WaxcEwBGgGll0Nfa+I+ZOs/7cfIlEoJ73N4nAB2OtFV
         LYuw==
X-Forwarded-Encrypted: i=1; AJvYcCU5thNT4UcrvfEw0ub11ZSapYZUF48okAvoVsHpXYT63t0Zb1+orQaShKQ2/pmzwjkXme4KdFtpFswLIk4XTv0qsp3pxW1uJ4evVRH2ev2w
X-Gm-Message-State: AOJu0YxX/mXQN0HeajXgdAkkfjBuJS62o4VGR+mrOgvxipmkn/fuQUlU
	PYIALg6ffRFBHOtJDYm9LaIDfnetJHl5P2JeMKbQO8NtuqjW1wtdJSQaVB+ZSik=
X-Google-Smtp-Source: AGHT+IFk6x+qB+GTV+ysQrTShT6g6IwHZ/ny273g/2Uq6eWdA30AiD9pAfjELmXhs3BUfTPkSYxX8A==
X-Received: by 2002:a05:6e02:1547:b0:39a:eba6:69f8 with SMTP id e9e14a558f8ab-39b184c57eemr4190315ab.3.1722466589625;
        Wed, 31 Jul 2024 15:56:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39aef99c7f4sm39799725ab.87.2024.07.31.15.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 15:56:29 -0700 (PDT)
Message-ID: <24794ab4-d22f-41ae-bb1c-83175835e509@linuxfoundation.org>
Date: Wed, 31 Jul 2024 16:56:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tools/nolibc: add support for [v]sscanf()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/24 12:32, Thomas Weißschuh wrote:
> The implementation is limited and only supports numeric arguments.

It would help to add more details on why this is needed especially
in the commit log.

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (2):
>        tools/nolibc: add support for [v]sscanf()
>        Revert "selftests: kselftest: Fix build failure with NOLIBC"
> 
>   tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
>   tools/testing/selftests/kselftest.h          |  5 --
>   tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
>   3 files changed, 152 insertions(+), 5 deletions(-)
> ---
> base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
> change-id: 20240414-nolibc-scanf-f1db6930d0c6
> 
> Best regards,


