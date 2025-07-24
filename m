Return-Path: <linux-kselftest+bounces-37955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B38B110D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28C23AA367
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9E2EBDD7;
	Thu, 24 Jul 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VzrLbIo/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C72EBB81
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381585; cv=none; b=V0Gs4V9O2dPQBjnQ4zykwKw2u6GmA7W3106euLCdBQQviNQ1qwVlRSDGyQQrw6wzHMpiw/oo5iYtK4hQiS2ySHr1Tyw/b0FgoOf4sWv3PMU5L6KJnu0MNnpIjOfYhkrOCWIT3U9tYxkcJr3691uNGW+heuN5xRWJS33Y/6CZPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381585; c=relaxed/simple;
	bh=TXNQ1dQYoFfA5ydiwjnJAvHRo1WgmH9K/hwSeP3YA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubRR4Z9MgjZvgliasjHrX2s9nNXhMwxUEQBsi3GpFy5lq7L2R57tHl9xWzY5OEj94EUkZnfayC8qMW3vWhp0Ji4QkxSkNu9WINlAk13u+AgCRMDi0WUQM7mKiqGGPU9drPYETEAwJD0bXc3Sbrfjft/Xr2S6zvlYeiTsOGPYq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VzrLbIo/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so10016485ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753381582; x=1753986382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP/Q9c1F0J5OzCcFyiKpcsCDFDVLpA+plFcxQ8cGq2k=;
        b=VzrLbIo/M5f/x1QHBKiT1A25YoW6GtYUkFAEJr/WY9drHPN9TnWHE+0M+H59Sr8WPD
         Sxdons+LLO7x3xKTST623W2+ZsnmFXtSLbirnLyagkuioCJ6/erjou7e3l+/pKbZT7WW
         JZnG3VBXA/AiJou5cy4gZtAHZUrZQmDtI13sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381582; x=1753986382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP/Q9c1F0J5OzCcFyiKpcsCDFDVLpA+plFcxQ8cGq2k=;
        b=k7YlSwQjonWE81Qubi+BCsnu04ZYUW3RbO2xSsRzqBpGTs5FkDFtzNKWMX/cGleVkN
         9JMvbUngTS6KqC+HD1Ig/bie1czzFXxmf2Z7uMgWRxDeVBV/yq8ZZXkxRwJm2yb2y83Y
         u4cgB941WimAUlnjdbLW+KxsLI/UT1/LXI4pZUV5FcpLKyPYjsad6wxajEsxtmO11saI
         OQ5l3QG1ivaM98Bp48RWmOyeR6Odvozszafv4jwPUhGuAgdQY4DE+ytz0hjGCXBzA1Ez
         9auwIAxmSrWim8/C1cuKMxvmW7lwgkt8pPwhEYkpt7m95aHQFEbxxJoBAh8jI6ljBRo9
         pnDw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQLIJ87WqgkzjXcJtdJTTAxEoaXHxDc40wIOUehQa+2sSKCEQIqdnH8fcWhga7MuZ72rt6ubozzpZiL1hiDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZlbIAgJyZqB24GEBRVMtMsXOrNUpzoFZl2UeOxBiqxnBYrFR
	wpp+3OojWzp0/WITi/psqAJlQkF6WXXXvofPCyOU2/CO/T4M4vifwR+Wfl6QO9dlYHY=
X-Gm-Gg: ASbGncsbZSoog8RZO5ENInZK2DJywAei4LQT/QIqRH4Qo5TYxEFYpEqGGBbOLzP+T3/
	9DE4naL5cLavt/uSw/8+nyDz686+7AzCh9hN/RRKcR5d5T122RMlSltDrxJRzPoZoRzm+NfOHUv
	/cYOxdOoVs9S9jp0QxwbTMdmvyFA7dWWFEH57kJ1RZqGAFtRXY4Ibcvxbm5zFS73pQ1d3craBFm
	q38zKHPiL5UhBi2NusTRIW+205jifV25PBbqRL+TFmdtoWoLkFKYw8mi/7ElW60S6gsrHL4+Lpk
	yo0WpvNQOrxqTcikXsLKS814CKjY6UzLl5jerCjdOa9n9gLcejPaDF6JgXM2i2C72qezp1ea0iP
	uXnAnBJ9vJNzRZhQzi9zDfrMe4MCPa18stA==
X-Google-Smtp-Source: AGHT+IGxGg2PimE89nzDS27+nd+r7DTRhNNw6kwLpoYVpMTkB9Sco1x4a5uD4TwwRC93Q4bw645b2g==
X-Received: by 2002:a05:6e02:338e:b0:3e2:9bc2:8be7 with SMTP id e9e14a558f8ab-3e3354de804mr125742155ab.10.1753381582336;
        Thu, 24 Jul 2025 11:26:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3b7012bb0sm7810905ab.0.2025.07.24.11.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:26:21 -0700 (PDT)
Message-ID: <90c793c3-91fd-4808-8fea-cbd07d2098e0@linuxfoundation.org>
Date: Thu, 24 Jul 2025 12:26:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
To: paulmck@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
 <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
 <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>
 <cc7e4fe7-299f-4bf3-af46-df6551d61997@paulmck-laptop>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cc7e4fe7-299f-4bf3-af46-df6551d61997@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 17:13, Paul E. McKenney wrote:
> The pidfd selftests run in userspace and include both userspace and kernel
> header files.  On some distros (for example, CentOS), this results in
> duplicate-symbol warnings in allmodconfig builds, while on other distros
> (for example, Ubuntu) it does not.
> 
> Therefore, use #undef to get rid of the userspace definitions in favor
> of the kernel definitions.
> 
> Other ways of handling this include splitting up the selftest code so
> that the userspace definitions go into one translation unit and the
> kernel definitions into another (which might or might not be feasible)
> or to adjust compiler command-line options to suppress the warnings
> (which might or might not be desirable).
> 
> [ paulmck: Apply Shuah Khan feedback. ]

Looks good to me.

thanks,
-- Shuah

