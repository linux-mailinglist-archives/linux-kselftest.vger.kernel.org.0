Return-Path: <linux-kselftest+bounces-29904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D769BA7537F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57A41894547
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC731EF365;
	Fri, 28 Mar 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="awQLkTWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5C1DF747
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206318; cv=none; b=Mc5ujYG+hTJ+2iT28E17qUMFEB8BfB54xHwyCBUVjZ+Vf6OSjU/TijIO6hKXfuk6fdx+tTVJpcB0cctc9flmvIVldx7GHULzlWeKwwibSqAURkawhvasdNwEOjtxNgUWwbo3q4/vyr6zZvLKGVc7+rymaunHV1z5H72JUVwo5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206318; c=relaxed/simple;
	bh=p6m/nvz/Q2Q0JIFlNq4Hw/EgwqnEbBRnzIoKtvBxnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu2nKQld8zPtPBa6zhe2KKIRZJ6zPvAf1/zGwv3kJdI3TdFemI9KceIQ2c535KQGaQ8ToVXOhknbV8G3W5nm3TDiWb5yHBwpJK06dcnuhBdSbOCcdlKpPJw6Mn2CI+rptq6bES3yE7FXMSVcAg5jVAyrHXH1p8iShHJrsdVIKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=awQLkTWs; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso21290305ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743206316; x=1743811116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5JcEI/bdJeiO7FQkHMbOrLBwPR+IcOVIoR62S759ko=;
        b=awQLkTWs8C7VEnQn/v3pfJMmpb0HtW0XPb8TrQCBTNPVSk+y06amIUNHINHi0xv3M+
         xWzGmPaYBUiJXv9gkKzVUWLe+bO6pOwRTQbMena6R0ltMOX9jkjcYMa2Vc+afrFyxGwK
         27w1b+SsNdawssmcTVk9iG7nrfCdC2xKOo7Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206316; x=1743811116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5JcEI/bdJeiO7FQkHMbOrLBwPR+IcOVIoR62S759ko=;
        b=MFtoN2eY4FxkCVYtEPtALl7i/coTIuFcsQ8kG8h10AYpBpuwPTGWPKwMXc4+rsWEyl
         8wG1PjiNuWqUD/J31aqP+f0iYnbCXPT0w89mJqgaCbpmPm0ulbAe3P5r0ahUPmsYT9WK
         hzLCeAQbropQD3+MNsvQ6KqWIAlpOV/OH0aLH7w0zlzGD6maL9Q2dHKTR/4ex7h7WITf
         Mu7mFfE6xvf4HKt3J5HuezhiO1fBhwRRs3MsRJI2aCyYWT3tDo3kXswq6XBiNcWkr94M
         nwAAoIdzLlKLNcRT6AlqxFbXEPvjo6MpnQBViDeGUvOBYbOd2Cd+rLmdWN91B2O17O1W
         pYcA==
X-Forwarded-Encrypted: i=1; AJvYcCVK070vKTbZUt0dBVLvK8W1U827eCWZCzaD0jyE25KnO2urX2L8Ujorl6emcKoBW3BOM6gPp0fAgv4jmJZRJz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkp44GuXrcn8iwb0LWxe+xA5Phot140el05HQK1rFqhptVLsy
	Eu671GwoL+jCit7Dv8ReoGy4gHosgbt3H5YadZNbCO5m2gUe65BB5butPsBFyR0=
X-Gm-Gg: ASbGncvg/kaCCCKyXT6edYn+82tUgF3oaHYpUYDKdrcjccjjCcmSr7DrK8pHnOTbmZQ
	Q3mFvYed61lw5zsIGzs29hWh7z188qjUMjWRz3uq8fzsaMMiDCXg1y5IAw8ac4yE1nlv+wUQnyw
	8fkGh70xL8Mz5ZdOftypcni6rKzoutSkAaf/Ap17IBYnnjX+JcZtbxAkySQTzpCU4bvHdMiuvBM
	Ntz9VLfCtrDGjObBEgiUEFjvINcfmVlYxqmfIoWCij8AknGdDONXRAqfglqfNhsmze4qbl7Uok4
	YVBbG5W4u3fsUdyLUynyLzyFkym4A+bOA6RyK0+Gry6e4+25t7mkpu9O72KwwUMclQ==
X-Google-Smtp-Source: AGHT+IFk3MJlvLeFpqX0/xXhiDnhkbsvv/gybLX1nzNP/m6Tx4Ep4JZoTJEVdakXyN/Hyebwsn24Cw==
X-Received: by 2002:a05:6e02:1aa5:b0:3d4:6e2f:b487 with SMTP id e9e14a558f8ab-3d5e07e88fbmr17198845ab.0.1743206315648;
        Fri, 28 Mar 2025 16:58:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5ae2591sm7073465ab.47.2025.03.28.16.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:58:35 -0700 (PDT)
Message-ID: <92cd8fdd-30eb-479e-9c06-31d6a467cb89@linuxfoundation.org>
Date: Fri, 28 Mar 2025 17:58:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250328194230.2726862-1-csander@purestorage.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/25 13:42, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> Make the same change to the ublk selftests.
> 
> Caleb Sander Mateos (2):
>    ublk: specify io_cmd_buf pointer type
>    selftests: ublk: specify io_cmd_buf pointer type
> 
>   drivers/block/ublk_drv.c             | 8 ++++----
>   tools/testing/selftests/ublk/kublk.c | 2 +-
>   tools/testing/selftests/ublk/kublk.h | 4 ++--
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 

For selftests changes:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

