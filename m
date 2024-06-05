Return-Path: <linux-kselftest+bounces-11269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA08FD9FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07713284D14
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2500015FD07;
	Wed,  5 Jun 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmbIgzsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C352E64C
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627520; cv=none; b=XdiclSsd5zb9OuqGxyVWn52F9kWQr67Y4P7GAk3oT4ilXZmqXshJuszDhMEz2gQmGSJBpu06/hID9jml4Da4KQaNWy8vFfw1dqwB6nDqIiSnHUsP59ErzkW7EHtFx0c/br6HXIwYeiZItUFG4VKTQeQvNkQyPTgbdyRG7migZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627520; c=relaxed/simple;
	bh=j5XNJ7qUSi4GOebAuUL6hEQaPBtrzJwnimSGC15Ifv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOdySKOYDhG4ea1sgU6VITenLDDThNyFm+iFGX7rjlnnnmwdl9Rnd8+7rMJpjyANX8f/hzBf79q5C3dA4Lg30bNqdT159IEailWEqk9pC0iibSYncNfe8mZJcbvbcUpLTAautmGz0Tfsx/gatRPEmiJciQN9hiE44XVEBXhjvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmbIgzsB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c4926bf9bbso212010a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627518; x=1718232318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFSJCEy6u4uqWSm/uIbCw8MODebn4cqaARhTPhnxhUo=;
        b=LmbIgzsBJNEblNEe6FuXNqtPKXjbO538JrLAOO2zAU3F/mDYbBDThiDKp5yHsOGtPS
         TYm4c2ZFHRlU+DjsnWB1wgv4LBwBeGJceqjhUJHUNFTf48fhNPWbsRrX82upWtWzqo0w
         iKGlq9hZUbZCWdp74+zVCWaNSnjG1aMAkRZcAY9otjKiYcpfmloEX/o9eHWnFalaJzBv
         gWpan9KotgUllXmHRf4omzF4XCPXuEUxQYLpvZOFzj+Ml71Tv1MOiUMy8mYa2gJcJGjf
         E2xRN6jtdzRdJrAuLSTrLgvXVn7bALds85OYT6szZOpav4etxrG49/mdyKhsnmRuKvw9
         jr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627518; x=1718232318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFSJCEy6u4uqWSm/uIbCw8MODebn4cqaARhTPhnxhUo=;
        b=MuZeitvDzuABgh/lggeS+PJLJPUGpavXX3Azx5r38zndyAMHeLxXyZSpHAn6XG4ljI
         rBvlFseQ/i4e8MUORnhzIa0hKBKwCCEqKbEZtQBmm6VitxZR9yM89AlGWDP6Q8GFtWZi
         SlzBskQmLYnUkK+wDEToeaXeQbjZGX2VRjO9SUvZD5fFRhCMWqE8+kp0QC1stZxe2eaa
         EsGEZ1BDKUXkZVxs4ELJ46wqDgd6HBKvNrbndrUqIQCIG6zi3K/3/0s2OdvG+QMDFtiL
         6TpSySiCbUKjNTw67jx+zKsMar6/Ui0OISMx34LEgaKLwiFg5Lv//iztDpcBBTeHvM8d
         CSdA==
X-Forwarded-Encrypted: i=1; AJvYcCX8lrsFRbb4itnllTXNIo8O5OrU9+Mo/lgYEJQ1rxDqD4Br6k0WZub6PxCHGBs+awXKvN5/Miyo/xUjHZHMjNNH2PUEfu1HeuyInVbupIts
X-Gm-Message-State: AOJu0YxIdkr+PmyqaYXNvljfwuKltEAGot73WLSVsKcvRN9GJVt569ue
	RQ9MqMTe3Ff95cCBrWWEv++6KNEfg5RIoh14Kr+9gYNIOfvOxCcMxJB8a7bI1w==
X-Google-Smtp-Source: AGHT+IFjCDvYFFF2wgJdE13PmmXi1cL2xUEC6TiDuuPu1y0FqnGaQUW2DXAfSAA3tRUDfbCP/YT6+g==
X-Received: by 2002:a05:6a20:2590:b0:1af:d4dd:65e5 with SMTP id adf61e73a8af0-1b2b6f94b13mr4916867637.21.1717627517578;
        Wed, 05 Jun 2024 15:45:17 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4f8847sm16039b3a.171.2024.06.05.15.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:45:17 -0700 (PDT)
Date: Wed, 5 Jun 2024 22:45:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] selftests/mm: Include linux/mman.h
Message-ID: <ZmDqeakspyvpXpLh@google.com>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-2-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605223637.1374969-2-edliaw@google.com>

On Wed, Jun 05, 2024 at 10:36:34PM +0000, Edward Liaw wrote:
> thuge-gen defines MAP_HUGE_* macros that are provided by linux/mman.h
> since 4.15. Removes the macros and includes linux/mman.h instead.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index ea7fd8fe2876..034635317935 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -15,6 +15,7 @@
>  
>  #define _GNU_SOURCE 1
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <sys/ipc.h>
> @@ -28,10 +29,6 @@
>  #include "vm_util.h"
>  #include "../kselftest.h"
>  
> -#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_SHIFT  26
> -#define MAP_HUGE_MASK   0x3f
>  #if !defined(MAP_HUGETLB)
>  #define MAP_HUGETLB	0x40000
>  #endif
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 

This makes sense to me, particularly when other mm selftests are using
the same include pattern.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

