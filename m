Return-Path: <linux-kselftest+bounces-10296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FD8C78B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEAF2818F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA114B961;
	Thu, 16 May 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BODhy19q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC5145FEB
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871236; cv=none; b=f7kXuxnMyTAptqafNvsnr3OEAQTEF9JbFcT8zR552itS3Kng1wu/NmbJ02zdf2hBi4kTo5SNRmRlTrO/gXW0XY1FCPg9sSzeTUAmV2KhMbyimYHk+BUJVO49uKozqcfVbPF2cLnQxvJObRf0mNB726QEU18k3810wfzh104U8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871236; c=relaxed/simple;
	bh=EqQJNFBHmj9w7MIcTajMGZzjrM+m3hk8PDoy6QI4uQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4DcoIf9xKSy3v9l4tA/TXT0RC1lheaOFT4JtKLR6YHuwGOXQXdzb9zxw2WYm5GQxlQrtOZQ0l1NAB3yP3vnaYzAvugj9YnGkWpkVCr6OJvwRsQjymKypUC5ADl57q5XN+a3KWUBYCHy4r+h05sdnMG95DQ0aGkDkXQ+1lBxxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BODhy19q; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e195fd1d8eso6004639f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715871234; x=1716476034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yzmjOEeTllPQipyUqGuhVVU46tl95GvKs67H4ACCeQ=;
        b=BODhy19qTIlnwMa4JQUPLSrQ+7bVnik4DdK8YAqhGTLZ2/RTbwAUSJgSkl6IrhIebp
         qw++IgzRhlKT+mDyWLpi0mPsyt91vAD/xCyQ4NX341oBTiuq8c7mkM0gWWOAHCPYWs/R
         tyRXXO2d4/FjPmUl8O9S7GBGIuFdYoiLjAewA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871234; x=1716476034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yzmjOEeTllPQipyUqGuhVVU46tl95GvKs67H4ACCeQ=;
        b=kCpAaTz0ROX5TqOuTxaPIoQOFSAhYgX4O5BXJwxZW+zsRck0CeXuo2V6yLPU9M4M7j
         qjON2U+1UYEMGWFiYXyXOE3qEEqcDICvCmp/UiABqCmVzAz4JfCavNj3PiI2y5WWRxX1
         EoAmBTKiyzJdW8rk+dIKZIxR1o9jqnrbjVxyW81TYBrVWrLZj4G4OpaOqo8RU/KXe5an
         dmyK56ozURLz/yFSqyEFyqPBZSaF6JTAQk+jmyAsqsJom6EQ2mGJqPLQQnu8yzvRM0OI
         oUweYvZ5bug4u7jjSrZMtLvUdWNxIaNxlgialKCDJ7WNAdj1vBTuES3QNV4R0LjokTJT
         lp9A==
X-Gm-Message-State: AOJu0YxYEhg44ESDB62jfPRPfe3dXLq3NFjPrJTwAYs9QhgpcpuasRfd
	ELsCmQcGy5pcF8ohVYbcSGML/zYb6vDUz2TZEonzHjzRKWIb0Z2vrdtdEkuleYw=
X-Google-Smtp-Source: AGHT+IFuYNy5AYIeI+Knw58Q5Nb/tmOtO2xa02G5M0FcI0DiEBBGEYAZ74T6O9maNc+jx5GFDx01FQ==
X-Received: by 2002:a92:cb0f:0:b0:36c:532c:d088 with SMTP id e9e14a558f8ab-36cc1391118mr187451305ab.0.1715871233575;
        Thu, 16 May 2024 07:53:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d3f9afsm37771045ab.6.2024.05.16.07.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 07:53:53 -0700 (PDT)
Message-ID: <71d1f2bf-2e18-4adb-988f-665675fc803b@linuxfoundation.org>
Date: Thu, 16 May 2024 08:53:52 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -D_GNU_SOURCE kselftest breakage in mainline
To: Mark Brown <broonie@kernel.org>, Edward Liaw <edliaw@google.com>,
 John Hubbard <jhubbard@nvidia.com>
Cc: linux-kselftest@vger.kernel.org, torvalds@linux-foundation.org,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <d33973a1-4d49-473e-99b6-f0a5174458e7@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d33973a1-4d49-473e-99b6-f0a5174458e7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 08:02, Mark Brown wrote:
> Hi,
> 
> I'm seeing quite a lot of breakage in mainline as a result of
> daef47b89efd0b7 ("selftests: Compile kselftest headers with
> -D_GNU_SOURCE") and daef47b89efd0 ("selftests: Compile kselftest headers
> with -D_GNU_SOURCE") - thus far I've found that the use of
> static_assert() is triggering build breaks where testsuites aren't
> picking up the addition of _GNU_SOURCE (including stopping installing
> the other tests in the same directory), and there's a bunch of tests
> which #define _GNU_SOURCE in their code and now trigger build warnings.
> I'm looking at fixes and mitigations now.
> 

Would it be better to revert this for now and get this for now? I wouldn't
want you to extra busy work to workaround this.

> The build failures are taking out the ALSA tests entirely which has
> caused my personal CI to explode badly :/
> 

This has been in next for a while and I didn't see any failures. These
kind of changes are tricky. On second thought, I probably should have
delayed picking this up.

thanks,
-- Shuah



