Return-Path: <linux-kselftest+bounces-29387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE0A67F25
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419D37A85A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D0202C5C;
	Tue, 18 Mar 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSdchWb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974011A01D4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334845; cv=none; b=Ogd3XVWMnMgYgrA4aIwGwAubGObT+hrjzEZ/jO65R6HOOeLWTc++bkY+Kj9j7PtopZ87pcMvbF1RFi+OZPiehuQ4iEKKzEha2hYIuZAFch/7gLcQlJ3Fjlr4fEr2YSjanmS8MeczOdxHOxFo3kyK8myO5hA/45/lH3WR8/N5uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334845; c=relaxed/simple;
	bh=E01oUPRU7VYPXC52Cw+IBLdQw8X8eORmEUPDXHOk0wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubVrlMZf0mXdkoZhkpCJSwlxptczzaZNa8ofo+sFd1FvYv/3dTtx/nGhtPxi9so4dFvICsTjaAdQrkA1h8A7B4iZj1J53B1mq1A659JydzMcfpSTy6UyH/CwSr0Tv/E9h5+JDTKHLhCKvQxWlD/5fxXv7U8q1Lt8rHW2bFhbxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSdchWb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742334842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5b2zp+keJQwfbLWX1UZyFBC4It1uz9YJmwqtHLj4wpM=;
	b=BSdchWb5As4M2PIfP1+54eP6krRv6VBnp/+1maqdnyh6wKTyf1/dPCRR6ORC2x4UNOlGbE
	FlIVIR3EZGRDfnTgTqEGC+lwG5wuc6jxdijUEQEZKU22j+lrb6cDu2TMQ9NEvlOME+gVuW
	N5q3Vlh0ds3C6csPGhbUkH+4oAIi1yk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-c8fgr2_ZNKKksoekLZv2Ag-1; Tue, 18 Mar 2025 17:54:01 -0400
X-MC-Unique: c8fgr2_ZNKKksoekLZv2Ag-1
X-Mimecast-MFC-AGG-ID: c8fgr2_ZNKKksoekLZv2Ag_1742334840
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54e7922a1so1429845385a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 14:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334840; x=1742939640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b2zp+keJQwfbLWX1UZyFBC4It1uz9YJmwqtHLj4wpM=;
        b=u99v7rQW48hL9qsx/xG3Ms9rmPhpk+IHwFbOa4M9YTe8fpUN3oqQyaZt5wilwlUaSd
         FavaT7PIR1R6leSqhLkb1tqozhhqFlr0TNYV3lHqnNbTEuXy4QIlDzCsLzardRwvpUU8
         2d2O3kflI46l4VtAuAMRLqBL8kG8BKRrLxSVabDdP6KX4It874cOkD52YOFQak9TKC3Z
         Wd3g0OBwfdDtK+0s0IVTcOHaqYanyLcH39mhz7mzzurXAR0rYtNlC+LvnEyag0VjwO2y
         kK8V6ldFhmB8jSnzO1Z75AMOnMD6MqMVbTdjFGwNsGe2WU/XWpmNYC5jS+sqZpgRbfJq
         SLGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRXCF3b0CraqrX6bKsShlMcAKLsOoE3tUj/Ykr8LuWz2b90a4dFSFApt5xLnmTI5N6AKu75xUwh2qdqDzYYKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15VbQVdnvqGk9Pp08CbpyN3ScWPYI/lfjIISWynF5QhONST19
	r0YyGoqZPELrsM8WaJJB0iZSj0huvgepUkR8O/mLUoyU37vFBCVMZaqbXA+tJMDlUUd4t6Ktik6
	tCwCtWDbJa78KK5ptVJuH4dROS/4pjCBAYo890PcfGDLI0CdlufoER8WyPyUWoGh6aA==
X-Gm-Gg: ASbGnctFBt+Zmd5qQNLUo2JoQYQ+DJeoYB/IQyimyBHqe3LgK22M51QfYiTPejV/WJe
	StvxIkcufA4643TBMWss+83Ddob8rB1otwuD6n1J2tLYkze6gUp0ynuWAVmYOxt40jzJcf5apPy
	dJvz9AzEi0ri73iVK8mPrjgd9RFaGlfsQP8En8rvz+fjtsqTMr+FVPJE56mRDhD7bTELIobX5cU
	4e4GjjPP8WB5zcJWlEWQINzHLe5+O7Gf4SlWZ+2wzgQ40YPw+7ZvoRHxWCW4FSuLUcc6ES2EFua
	IQygraMGEmVNPb7aX8ecsxYca69WGqeuO4DEgvPiaab7wb3mdr8ID/nAHQ==
X-Received: by 2002:a05:620a:25cf:b0:7c5:5883:8fb3 with SMTP id af79cd13be357-7c5a818798emr38798985a.8.1742334840659;
        Tue, 18 Mar 2025 14:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnPSwaYy7RF/Yi1xWOgmTzmgAypt0b9Ow/O7ph/4lN7lJxXTrNsEF8wjcC8pJEAUjjd22AYg==
X-Received: by 2002:a05:620a:25cf:b0:7c5:5883:8fb3 with SMTP id af79cd13be357-7c5a818798emr38797285a.8.1742334840238;
        Tue, 18 Mar 2025 14:54:00 -0700 (PDT)
Received: from athena.aquini.home (c-76-23-219-111.hsd1.me.comcast.net. [76.23.219.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5205bsm775298485a.3.2025.03.18.14.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:53:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:53:58 -0400
From: Rafael Aquini <raquini@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] selftests/mm: Speed up split_huge_page_test
Message-ID: <Z9nrdmIh-0RP4gDk@athena.aquini.home>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
 <20250318174343.243631-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318174343.243631-3-ryan.roberts@arm.com>

On Tue, Mar 18, 2025 at 05:43:41PM +0000, Ryan Roberts wrote:
> create_pagecache_thp_and_fd() was previously writing a file sized at
> twice the PMD size by making a per-byte write syscall. This was quite
> slow when the PMD size is 4M, but completely intolerable for 32M (PMD
> size for arm64's 16K page size), and 512M (PMD size for arm64's 64K page
> size).
> 
> The byte pattern has a 256 byte period, so let's create a 1K buffer and
> fill it with exactly 4 periods. Then we can write the buffer as many
> times as is required to fill the file. This makes things much more
> tolerable.
> 
> The test now passes for 16K page size. It still fails for 64K page size
> because MAX_PAGECACHE_ORDER is too small for 512M folio size (I think).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 3f353f3d070f..499333d75fff 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <assert.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> @@ -361,6 +362,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>  {
>  	size_t i;
>  	int dummy = 0;
> +	unsigned char buf[1024];
>  
>  	srand(time(NULL));
>  
> @@ -368,11 +370,12 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>  	if (*fd == -1)
>  		ksft_exit_fail_msg("Failed to create a file at %s\n", testfile);
>  
> -	for (i = 0; i < fd_size; i++) {
> -		unsigned char byte = (unsigned char)i;
> +	assert(fd_size % sizeof(buf) == 0);
> +	for (i = 0; i < sizeof(buf); i++)
> +		buf[i] = (unsigned char)i;
> +	for (i = 0; i < fd_size; i += sizeof(buf))
> +		write(*fd, buf, sizeof(buf));
>  
> -		write(*fd, &byte, sizeof(byte));
> -	}
>  	close(*fd);
>  	sync();
>  	*fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
> -- 
> 2.43.0
> 
> 

Acked-by: Rafael Aquini <raquini@redhat.com>


