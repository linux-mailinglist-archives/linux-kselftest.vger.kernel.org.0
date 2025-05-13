Return-Path: <linux-kselftest+bounces-32905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D7AB5974
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF51166BD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15A2BE7CB;
	Tue, 13 May 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRyPXIXu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C581A9B40
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152749; cv=none; b=EfYAPadqdJqLvsd30jfe69eAIOPH8HIbk2y4XRkZ2aUYyUSXBZZhc4max68w0RVp7F5s0FCKyhValm1AbK+6h/yrEYxrOvrue6mqgY6nVtl4J100fswH7zF+TsuIfTRPuVAKzYHFbxcNosMFe8G5da/9YpVR4TcPR6zgXn2vnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152749; c=relaxed/simple;
	bh=dKXRdlHk9jdPedokAkdTX4cKzRar1ssOdF/9x0yTzlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNUkwQbKJ7RVommuuYhU2jkulmjOa/NnSTCtE6LEX6C2i1D4LyirvyH2Tj70KzsjMGbfIZfyKyvqC4POFw8YSpmkUvmV7/V8aW5q2RUwqCoT8pxUAIyD7wMcJCzOtkP7C0GGxvBZqF4OEfusf+mmPxI0qaEVYMNrv5D6h4ux+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRyPXIXu; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b728052c-a5c0-490a-ac4d-64ea43c3e35d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747152745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB1tsZVS6yD5HkJNxg9XSkBp0FbT6BoDERBRNVRnToY=;
	b=pRyPXIXuuRYvMOpWts12XZY/CdoQMx3vR5k0fTqe4IHJHbQPMa7iG64K0zClznCU8SsJfm
	yUS4QwU6OiFFJ22sOOi+BJEXs6x4IEUVMDquQjjHQa9MFOFbdgc2j44WDmxY+yP7U84DlI
	HHbYTvyAJVs3Ih41JIOnxHj1rxkOy+E=
Date: Wed, 14 May 2025 00:12:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/eventfd: correct test name and improve messages
To: Ryan Chung <seokwoo.chung130@gmail.com>, shuah@kernel.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250513074411.6965-1-seokwoo.chung130@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20250513074411.6965-1-seokwoo.chung130@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Thanks.

Reviewed-by: Wen Yang <wen.yang@linux.dev>

--
Best wishes,
Wen


On 2025/5/13 15:44, Ryan Chung wrote:
> - Rename test from  to
> 
> - Make the RDWR‐flag comment declarative:
>    “The kernel automatically adds the O_RDWR flag.”
> - Update semaphore‐flag failure message to:
>    “eventfd semaphore flag check failed: …”
> 
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>   tools/testing/selftests/filesystems/eventfd/eventfd_test.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> index 85acb4e3ef00..72d51ad0ee0e 100644
> --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> @@ -50,7 +50,7 @@ TEST(eventfd_check_flag_rdwr)
>   	ASSERT_GE(fd, 0);
>   
>   	flags = fcntl(fd, F_GETFL);
> -	// since the kernel automatically added O_RDWR.
> +	// The kernel automatically adds the O_RDWR flag.
>   	EXPECT_EQ(flags, O_RDWR);
>   
>   	close(fd);
> @@ -85,7 +85,7 @@ TEST(eventfd_check_flag_nonblock)
>   	close(fd);
>   }
>   
> -TEST(eventfd_chek_flag_cloexec_and_nonblock)
> +TEST(eventfd_check_flag_cloexec_and_nonblock)
>   {
>   	int fd, flags;
>   
> @@ -178,8 +178,7 @@ TEST(eventfd_check_flag_semaphore)
>   	// The semaphore could only be obtained from fdinfo.
>   	ret = verify_fdinfo(fd, &err, "eventfd-semaphore: ", 19, "1\n");
>   	if (ret != 0)
> -		ksft_print_msg("eventfd-semaphore check failed, msg: %s\n",
> -				err.msg);
> +		ksft_print_msg("eventfd semaphore flag check failed: %s\n", err.msg);
>   	EXPECT_EQ(ret, 0);
>   
>   	close(fd);

