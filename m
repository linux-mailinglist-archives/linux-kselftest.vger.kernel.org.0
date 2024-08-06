Return-Path: <linux-kselftest+bounces-14859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D2C94923D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1FD2847CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95B20FA93;
	Tue,  6 Aug 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7LEkFXq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42021EA0BD;
	Tue,  6 Aug 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952391; cv=none; b=Nj7k2CSsOWaxlBiTcp4Wc3Ya5fhSH9oMWV83hxOBqd0xEhWJamVIEEtYHHoUGdh7nm0bSxqAgfKX5tl/eJtIxvLoTvK5qsVYHOHh/7zV7eG50BBsuVzrlzbIefcpuHaOpaD4ro8UF6QiRMU/H8Hn/TC9OwGf/xImA8xBdcofY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952391; c=relaxed/simple;
	bh=HvFHdNSXsI7+QfH5LiWr9J9QYWprpWMl/4cvaIuvVMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw7tL2b/FRjkM4pt1HNp+V6bP/8/uXtZkBxTA/dBzI6lp8RZ2U7aNnRMv8q2azbh2aoOg8HSA3WRCdpe4NUIZoi4UqqsebPYH9QBkx1o/Nx9hcqYH3tTaAd98jnP46pWDWX5Q84K/7GFUr/VlyI8ChtkS4CZAEEx2uhCAwviPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7LEkFXq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427d71e746aso123465e9.1;
        Tue, 06 Aug 2024 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952388; x=1723557188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESWuuRI+S8LlXsCQ7zsswRjv/m7jikQQ1fbrdUBF+y8=;
        b=b7LEkFXq6R1YXhE6l40e3rUz80Rlrz5Mzgm2SkJ/1QdzSshiUYpyPugUTurBesUVXH
         GmcErHGhIepuZEvyBj61Giewzu7wBRDX0ftBUlb42a+BTtGT/FK1gGHS0rJqqgzNLZZZ
         zmDgeeaqMdxuR27RJPh5inubqEaXwFHnpzaqY+nb+b6DGbTZfF46YspPqH06I7SAwLU8
         GZHH6USZyVplI628r1dmJo+UzokoCIN0eOQA+B4UmDcGe3Ufwby3hRoH0Wv5xUCuaE++
         HRYr74kJDaJm9kx6IZz8oxrvEwBcQjIql3+cTKuz1i9h7uq7uTeKQGB0TNx5flLHiOuK
         ii6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952388; x=1723557188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESWuuRI+S8LlXsCQ7zsswRjv/m7jikQQ1fbrdUBF+y8=;
        b=u748pWdoDNwQXxa1fr+Fv0O0k552XMomHC2zjgQVwFmzPSjwTIV4VhikmaOpOUPVvY
         RetvGuQBCLtlHdL6RF3fczjn31yvhg6hHzEfhK1sprtmMGCuBBV3o2xrm1iamz7OG0zD
         /UkAE1kQWugMHBtXM4wyeXqRXICQM9PehcibgCkvQV2yb2j+348+CHGhkN4Hffiqajli
         S7Eb778mM+rl/Oe2odjnFs5j++AI/NZntxEVLfnABUeF+PfAZtxfFdYSWb3UgeG/gqV7
         q/zio2j7Pr8XG9WASUgLx9JPet7ulNhS2NDjM1Cus+9leqi/1Z7Bpx0B7zJ+wAvuCH5w
         325A==
X-Forwarded-Encrypted: i=1; AJvYcCV+94qXR0kHqYzlxmNRpFXBX+8OoHjm/a95yOu+6qR5Vrvmw5a4EiBZJk7lElwGLXkwGzeUnR9EGeY=@vger.kernel.org, AJvYcCVAHHq1FTf1ywb/g4jVWdsAZt6proGY3HynkcgK82tSijxU7EYoH78REnjs+vP9KD3s33A9txCzrGhvtBps@vger.kernel.org, AJvYcCW1FawjrP2VgSCHempiQiD/CzRbpEXXXr4cf+fD3zEmTWJPXkjXzeK6Nw7y9W+RTVSnM/jwQl3/VaPAtFvvJWa+@vger.kernel.org, AJvYcCWuLLTEb+lEmHrs5jpDI1p+YH3auIcYKcIqaG5F5WSjzwtf9cBaG6EVDGxctyFuwUomsO8bQK6DZ1QuN3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTClRPijG3JFUJo2LbQqyM1IKTtuqo8SxaWCtH3xo4fLihwJNi
	qi7CBSo2sJG2CLyGmExavjQyKnPBcd3xKNSGg1tz+nz5FDjAXQ+h
X-Google-Smtp-Source: AGHT+IE3B97iqF+o2EyfNUzNzruvfVcTRIeX9q/YkXCwXDoGFn+N6ekjHInQAAjvVAVxszERARpnhA==
X-Received: by 2002:a05:600c:3b9b:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-428e6aeff6dmr65884775e9.1.1722952388042;
        Tue, 06 Aug 2024 06:53:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:b50e:24fa:fd17:c835? ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c314sm12914617f8f.12.2024.08.06.06.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:53:07 -0700 (PDT)
Message-ID: <a6be66bd-1133-48aa-b892-48b132e7a0c2@gmail.com>
Date: Tue, 6 Aug 2024 14:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests: ALSA: Cover userspace-driven timers
 with test
To: Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, aholzinger@gmx.de
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
 <20240806125243.449959-5-ivan.orlov0322@gmail.com>
 <038cb9ff-4028-4179-9722-df324e29c73d@sirena.org.uk>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <038cb9ff-4028-4179-9722-df324e29c73d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 14:04, Mark Brown wrote:
> On Tue, Aug 06, 2024 at 01:52:43PM +0100, Ivan Orlov wrote:
> 
>> -TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver
>> +TEST_GEN_PROGS := mixer-test pcm-test utimer-test test-pcmtest-driver global-timer
> 
> This is adding the timer timer tests as standard kselftests to be run by
> the wrapper script...
> 
>> index 000000000000..c15ec0ba851a
>> --- /dev/null
>> +++ b/tools/testing/selftests/alsa/global-timer.c
> 
>> +int main(int argc, char *argv[])
>> +{
>> +	int device, subdevice, timeout;
>> +
>> +	if (argc < 4) {
>> +		perror("Usage: %s <device> <subdevice> <timeout>");
>> +		return EXIT_FAILURE;
>> +	}
> 
> ...but this requires specific arguments to be run which the kselftest
> runner won't supply.  I'd expect it to be a good default to enumerate
> and test every possible device and generate a test for each.  However it
> looks like this is really intended not as a standalone test but rather
> as something run from within utimer-test, in that case it should be a
> TEST_GEN_PROGS_EXTENDED.

Hi Mark,

Yes, the 'global-timer' application is not a standalone test and it 
should be ran by 'utimer-test'. I had to extract the timer-binding 
functionality into a different application as we can't have 
'sound/asound.h' and 'alsa/asoundlib.h' in single source due to some 
declarations overlap problems.

I'll move the 'global-timer' tool into the TEST_GEN_PROGS_EXTENDED list.

Thank you so much for the review!

-- 
Kind regards,
Ivan Orlov

