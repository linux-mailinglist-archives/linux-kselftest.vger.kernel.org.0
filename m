Return-Path: <linux-kselftest+bounces-36127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A8AEE886
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 22:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CB817D189
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB21E32D6;
	Mon, 30 Jun 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJNalNJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2449620;
	Mon, 30 Jun 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316470; cv=none; b=WNWJwjLXyhZZAgQfQVSFsu9MHMUAUt1R9Eq8Vp/Dhpep0QsSxYf2Pi0mpdnaTPXWEajRkT897mAGKwK2qJ5yENPnpT1aMyaxKU9kw58WFUQnADFdsc36fPhJ2v82+XVpO2tObXVBkEA3uriPHZJcLwm0bwUPpjJUc9xM9OzmHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316470; c=relaxed/simple;
	bh=GEaL8rcdBdjMqjq9nsz7JSU5+s6+Xa55AiDvV1Tu7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMFpkzBnZ0EqJ8GhkSU6Ev2j0q83XmyWv9DfFr0lnzwd0vTDm3j4jEHhcySbT6crphl2Qr9BrhF3e7qWMwh/XwBSsTyPAsKBGogo/cQanY0TijjTjl+gP/fFy/Uf6jrMcMZHpD+fi4dGv6y41yEcWaH5cbT3MHCKDE1wtZxXKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJNalNJp; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e73e9e18556so4923988276.0;
        Mon, 30 Jun 2025 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316468; x=1751921268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luntcRknwz6cxo7wxJHZIgNu/w/o1CsgItFUyxf5d4Q=;
        b=WJNalNJpgiSwyC2rw07lyPQnUnG3Vkur2hXUUgZ8kmEYbr2Qv4+hUKwD+g3nnUAmWM
         a9/Q8yTM68+m4LcJfNJM/dmGP7OEZhhNNqFAkP844K6DwmG1dM7OfE+NdSCzZxSgU2qH
         pV9pB8d5CpbX7y9GaIy+0/IwAMlUci1FyMnTNuOowYTn+LlRAiaS/ulfDjOU5Q9ifQRu
         qQMbqARyhNHdxmZM+qbz/xFNTEVwQx9ES/+LCbUuGchOerJj71+vJ/3qy3FavtAcD00a
         S8SzoiaSqo2jDurCBbo8jrWC05NOcVZ++AO6aCkZaxeeXbRVh5g5LQRWOU4uMYu5nCql
         0ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316468; x=1751921268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luntcRknwz6cxo7wxJHZIgNu/w/o1CsgItFUyxf5d4Q=;
        b=CO+wUHPuRahoCbw0adH6eZIZfsDEHwBi+m64ejWxuDzrZikIfEcSOhErfVoq35IWtd
         JV+J/JKNL/GRksvJtcmypXtKoO0Kvvtwp7I62wy0+dYCOG7891tJTrm4kB1HacWQuNKo
         3NgSfcI4FtK8EJWQQBWRxa3+9RKt4Pbo9crZmVdHYaDgav9ySprcxvgOGdkA63xoDGZM
         BgKvk80L9MxxDw7u5Ri6BmI6deeO1YmimToX3fRpKdEabfdUXpciqqM+vRd3ZU2TJXa2
         lb32iL8Jj5JaXmCC/sqSzxZONx6U0+MYX4j8OK9kp4gASzC4RWkEIZM3F9Q/TR5WDWYZ
         P4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv/zeQ8b67yiMpml6+so25Rj+ReqZcM1CO92W5kbK91KLaSXG3K01TuToMw6/vt/pUSgSnOXz4QlDzNBW1VVJB@vger.kernel.org, AJvYcCW5hlMdI3PrPF0IXBZwFjmQnltQq8p8E0vJNA5eCAItfxp3ReFxArEoI5aLxHbu4K2KLjni/rUCLWUX61Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOATCaFPDbW0lXrJ8aS5xNFy7XVfirRiSBCqqJV62qRtJPxbS3
	TVWFQKVCz7NelLRJQ797TfMW9D+d/wQKQn6/FJJeFcqd/Wq5G8MeI1/u
X-Gm-Gg: ASbGncu4flgly/V0SFlH7dWrtx7sDGxy5kuKx2HVNoxhssg9Saezd1LTxPfZOhwwhPv
	AmQl262lKhu6PPSooczXAzF9baIzP/GmiPCivqNcnZP2GGtFEtvfCsIhZECDh1IYWa3DqNzf5K/
	ekSRTRmhKGdJBKhpOD2s3KEliN9uQO0LB4APwRZq1uGVB2Utx2ZdHsk30BIOjmqZD/1Oba0JWV2
	Oo7+rmiD4ONgKr3Vg5Zgg8DCM0LTaAtULJTI+GcPPP8eWpP8bk1HyR+hvwX3s0FWf7SBG0US7nB
	dzgu7GQqLpaPWdaysOLH2X4k2dKdfZrQHWgvj/Rkwj9kn0EOnUTZNLDr1Z/eFg==
X-Google-Smtp-Source: AGHT+IHquH1SFomNj3I5uzYfR2v3NP5BKEXajHPCZ5A3PFOxIUkmSJNhnAqoanz5VhUyME4mdqYpxw==
X-Received: by 2002:a05:6902:18d0:b0:e87:aa7f:6e15 with SMTP id 3f1490d57ef6-e896ee91671mr1733295276.4.1751316466280;
        Mon, 30 Jun 2025 13:47:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6be3ce5sm2560516276.38.2025.06.30.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:47:45 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cachestat: add tests for mmap
Date: Mon, 30 Jun 2025 13:47:43 -0700
Message-ID: <20250630204744.1581380-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250630180803.12866-1-suresh.k.chandrappa@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 23:38:03 +0530 Suresh K C <suresh.k.chandrappa@gmail.com> wrote:

> From: Suresh K C <suresh.k.chandrappa@gmail.com>
> 
> Add a test case to verify cachestat behavior with memory-mapped files
> using mmap(). This ensures that pages accessed via mmap are correctly
> accounted for in the page cache.
> 
> Tested on x86_64 with default kernel config

Hi Suresh,

Thank you for writing this patch! I'll let Nhat or Johannes comment more on the
patch, but just had a few thoughts. Before going into the code, I wanted to
note that it would be helpful in the future to note where this patch comes
from. I saw there were a few iterations of this before, so it would help
reviewers track what changed between the versions and what the motivation
for new versions are. 

[...snip...]

> -		ksft_print_msg("Unable to create shmem file.\n");
> +		ksft_print_msg("Unable to create file.\n");
>  		ret = false;
>  		goto out;

Maybe we don't want to lose information about this -- it would be helpful
to see why the test failed. It doesn't seem like there are any other
indicators that would let users know if it was shmem or mmap that failed, so
users would basically be guessing as to which of these two test failed.
(And the same feedback aplies to the next two print statements)

>  	}
>  
>  	if (ftruncate(fd, filesize)) {
> -		ksft_print_msg("Unable to truncate shmem file.\n");
> +		ksft_print_msg("Unable to truncate file.\n");
>  		ret = false;
>  		goto close_fd;
>  	}
>  
>  	if (!write_exactly(fd, filesize)) {
> -		ksft_print_msg("Unable to write to shmem file.\n");
> +		ksft_print_msg("Unable to write to file.\n");
>  		ret = false;
>  		goto close_fd;
>  	}

I'm curious if we need this part down below. It seems like we already call
write_exactly above, which should fill the file descriptor with random
things up to filesize. Maybe it makes more sense to have these two options
(write_exactly vs. directly modifying the contents) in a switch statement?
It seems a bit redundant to do both for FILE_MMAP.

> +	if (type == FILE_MMAP){
> +		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		if (map == MAP_FAILED) {
> +			ksft_print_msg("mmap failed.\n");
> +			ret = false;
> +			goto close_fd;
> +		}
> +		for (int i = 0; i < filesize; i++) {
> +			map[i] = 'A';
> +		}
> +		map[filesize - 1] = 'X';

I'm also curious what the point of having the last character be different
here. It doesn't seem like there is any validation code to check the contents
of the file, so it seems a bit redundant to me as well. 

Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

