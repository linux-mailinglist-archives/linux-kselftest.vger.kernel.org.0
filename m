Return-Path: <linux-kselftest+bounces-37050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13409B00D13
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A9F5C27E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065D4307484;
	Thu, 10 Jul 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4VXMUj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4333306DB8
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179142; cv=none; b=qTR78cYAthOyj1VkHvAfqQ0VQ5EZkYua3AqG5KAbUKG3AKgkexcvcCXarGJ6rqCOVlCX45skqk8c3FbkMjEEe948I9w+3xpo4XgFR3LnFHqBko9u/IejPfn0PgZHVXB6lsUKDEFCapt3s/vE0Ex4Vj4OTcO/FDgdmfC1QhTUf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179142; c=relaxed/simple;
	bh=dpAvXXm8l9op444PryNU84jOrFviRRWTvceQmBQJj7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmgVdRpNJo6TS5ssG147/IhxcX2g5XCC3QhyqsVgW3EmZ6OhbbIgxVVAgUzGBX8Sb0iZrQBOgS5rQc/nL+LgnskOYpUlAOndg4nWoUR23bF6BOo633l1QW23ap1/kGmUhA6I+f2uNucX/8OQl3WagwnWFWOFTJNHKZrQVJmNcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4VXMUj0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e13a58191eso11441715ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752179140; x=1752783940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOW545cnbFCjCw58sZPhZTZK+ICYR+NAj71Tm0cVR1c=;
        b=I4VXMUj0R8NIbRQnVuwJWK8PrblaXKN9R9z4QUznOgnc9i+bwH6CMwDUdwG7IbHyEA
         ypo2N4NNJnoAupyWhU8JGZqXBbteLu5tvU1oP4fi8mBvnzOThtn40JV7RhWPmF58mRuo
         /0RDmIlkII/7J3DqCyMR36zkYIy6jWIjs8gWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179140; x=1752783940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOW545cnbFCjCw58sZPhZTZK+ICYR+NAj71Tm0cVR1c=;
        b=bXahAZ1vC+Kf4f6Gx3n4R/AjTIZ8+LsjeqabD2ScMlpfqAQ/2cvoW6jSGQbkytf/D3
         dM55sYC7ilID3azSJqipVa09GB/lTLi5PtcLN8go7LODlaGrmu1YZfpDfkIKcBYUVFNG
         VsHH+kvuO4z1/N2BimbtHRix5nv1NSFzCKiBqT8FsKGBfYrG7BFF5G00YAmimoSloZ1P
         coIX8wNqZkz/4LISlzk6Y+N6HzcOb+x5c25tjHVBMVeflJnbdgpKxepAinWakEXrGDOu
         6DvZb4Mt6MCPT/mFaiOSl8l8RM93mxezadXRRIaB+atjyBLpU6YWLC54DjtPEN89SS8w
         x8hw==
X-Forwarded-Encrypted: i=1; AJvYcCW0BzaILE9A3Z5wdY3AbreazE3Kq9hXfpYQ5MUIcMo7zZgSsG2WNLCfOI6Z0fHbeFJ8YFrnliEaUqJi/25lBXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkReLOJQqk1a3oMki/0OmaEsNDMWb9nd/LoLPFL3o65Azed0B
	H3k6+0LtfJl4EjEsrhofgQT3MX4XQ6n2bh32EpwK8nhFA7v3wUuqPJpN0XgkO7alG1c=
X-Gm-Gg: ASbGncsN9F30D+ES95QoTucsem7P9YF8sCve587Zgd5zlAB6W98e9xOf+h2JpZixHtq
	vgZWBlch7NcZ7hSj6gJrUOuKaGpojmw/I19i9OiaW838khQsjbtH8RkdrAqsn16fdGAldjkNKVE
	sLZOJI4lsnyJnhA1f1R+md/VrulSMmw4jrP6DVKm9rddolO6ETFNv19aj1mNFKhhkxyjpQmqrO7
	Qa/W/mo7PPd6mRu7hvz2h652SeQGUCagMVlSez9CI5mzfb49glsr5KDZQdfOfKupwx58Ev/C5nd
	7zrQ9PgVcIzfLkmllgSRNC8RLdE+63JZt3AVBT8+l9EPQI/dMWR6oZz9dSSOwMRL3ilTn7AtLA=
	=
X-Google-Smtp-Source: AGHT+IHzlWsf/jsE9z63MA8RnwflOpfP+qTaGsCEOAMrn0ovuDzhRAv3fYk2H2SczvZO524QmmMh8g==
X-Received: by 2002:a05:6e02:3420:b0:3df:3b77:1ed8 with SMTP id e9e14a558f8ab-3e25329bb7dmr10180025ab.7.1752179139748;
        Thu, 10 Jul 2025 13:25:39 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2462422bfsm7371645ab.60.2025.07.10.13.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 13:25:39 -0700 (PDT)
Message-ID: <78cd5960-ea18-4e18-9f13-fb3c513014f2@linuxfoundation.org>
Date: Thu, 10 Jul 2025 14:25:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: breakpoints: use suspend_stats to reliably
 check suspend success
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, shuah@kernel.org
Cc: yifei.l.liu@oracle.com, zhujun2@cmss.chinamobile.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 13:16, Moon Hee Lee wrote:
> The step_after_suspend_test verifies that the system successfully
> suspended and resumed by setting a timerfd and checking whether the
> timer fully expired. However, this method is unreliable due to timing
> races.
> 
> In practice, the system may take time to enter suspend, during which the
> timer may expire just before or during the transition. As a result,
> the remaining time after resume may show non-zero nanoseconds, even if
> suspend/resume completed successfully. This leads to false test failures.
> 
> Replace the timer-based check with a read from
> /sys/power/suspend_stats/success. This counter is incremented only
> after a full suspend/resume cycle, providing a reliable and race-free
> indicator.
> 
> Also remove the unused file descriptor for /sys/power/state, which
> remained after switching to a system() call to trigger suspend [1].
> 
> [1] https://lore.kernel.org/all/20240930224025.2858767-1-yifei.l.liu@oracle.com/
> 
> Fixes: c66be905cda2 ("selftests: breakpoints: use remaining time to check if suspend succeed")
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---

Applied to linux-kselftest next branch for Linux 6.17-rc1

thanks,
-- Shuah

