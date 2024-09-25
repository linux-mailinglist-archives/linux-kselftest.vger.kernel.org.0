Return-Path: <linux-kselftest+bounces-18358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5C98639F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7482917BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3817BB4;
	Wed, 25 Sep 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uzt28pqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C43B796
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278153; cv=none; b=emj3qCJl0G7LVEx1RKgUo6lze9Z2UA4y7hymgx15Hk8g8WphW1pRvjYDIdjrAKvJfbFPiDHzIzcwQOnQPw8k0pr5DXDJKfH9gNSQeDXkS1IkMcTE1t1s7YvVdsTOkKW4B+JffykaxkzbXLLdHXyuOXTMMxZvIB8axatW0Sl2h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278153; c=relaxed/simple;
	bh=awUb+63RtxxR3p0ghGoxn+GAKa9yv1HStrK0WvOwAGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+31ot4gcYn9DCGpR9ZjVXOrZzYwEN4b3ApModFTK8iEDW/muVhc0p6CQky+gV7pVaUKEmxv33oo5Fz/pD1SQhzliwZgRBPLXxt1vafI2gJ7xz4q+zFLE+X0ghwApkOA/vy7GPi5zp6jJeiueMIEWG88laD5YSZVPegzMI+ClCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uzt28pqu; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so19351215ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727278151; x=1727882951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7ojFoyh79dJqXkUovYSl140R+kqroy7gdR2sYzeq1o=;
        b=Uzt28pqu+8NJcMXYkzXCknPgo0yI5PZrr/Alnu0Tid/whC/Q0YWgZXeSSjLvbyPEAJ
         7+OAxlk9CAbhoZaWGljJpCG19GxStqyskkcIz3cY6XmJLtlrW/HuhUJYzj3ERVd6IMT4
         Jwsu2kzDKhirlxghUae3FcZ7bkfq8Jl1o1oNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278151; x=1727882951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ojFoyh79dJqXkUovYSl140R+kqroy7gdR2sYzeq1o=;
        b=fER+Qeaq2S+CQXZUvdcWhxEUnzbO3EwlrTJSq9l/fTYF+DMAIk4KTskmg9Mp0ZnlWP
         YuhNhbSsOM786yF66xoG9yYo/rN57kSRVFwAtzIQVfBstRxyF52oJ/22shtQqdmSTLQL
         KE5Lidi4T1kRFmc9K1lJDAG4moxVWjFPILSoMDKpDQqeJGZ7FQX372uWScoiWLlKGEzV
         aq+xWBULVxRpNGGRifnFi/xxUIhLLjtPmwMEC6kEYnJjqRBvTeecDt5k2ApirHOBNFTj
         rOnsCtt5NUkIoU7OOmFqG+laDBy/ZceEOEWwN74xA/+N5FY0BIyZxQmz37wtAu4wI1uA
         Q/MA==
X-Gm-Message-State: AOJu0YydB8viMVjb2D2vZYDR8sDJs5MrVu1V5m5PNzOOPAa/tzVHGUTJ
	A9uuZmMPYa/Lsrx1LvAFxQpIh7Zc/m7Of95ymI29sdVjZDd51HNnXW23DK5va42IZVhswetAUFh
	q
X-Google-Smtp-Source: AGHT+IEyn8zxCQI4LXGAW9iUNRNo4xbikPRpAjRbgtUqaUaXloiAyB7z5cxOZVVM4/wdkLLVMNHhyA==
X-Received: by 2002:a05:6e02:164a:b0:3a0:4d72:7f5e with SMTP id e9e14a558f8ab-3a26d742c7emr38512285ab.7.1727278151258;
        Wed, 25 Sep 2024 08:29:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f12e86esm1125517173.58.2024.09.25.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:29:10 -0700 (PDT)
Message-ID: <7c7f42ec-8d9d-40b6-b275-ef139bcc4b79@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:29:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memfd: fuse_mnt: remove unused macro
To: Ba Jing <bajing@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 22:44, Ba Jing wrote:
> The macro FUSE_USE_VERSION is never referenced in the code,
> just remove it.
> 

How did you find this problem and how did you test this change?
This patch is incorrect - please see below.

When you find unused defines, do check first if they are indeed
unused checking tree wide to see what happens if you remove it.

> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/memfd/fuse_mnt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/memfd/fuse_mnt.c b/tools/testing/selftests/memfd/fuse_mnt.c
> index 6936f2a001f3..f9f06fd43c5f 100644
> --- a/tools/testing/selftests/memfd/fuse_mnt.c
> +++ b/tools/testing/selftests/memfd/fuse_mnt.c
> @@ -12,8 +12,6 @@
>    * file-system.
>    */
>   
> -#define FUSE_USE_VERSION 26
> -
>   #include <fuse.h>
>   #include <stdio.h>
>   #include <string.h>

You probably noticed https://lore.kernel.org/all/202409241613.KyXs9fiF-lkp@intel.com/
found build problems with this change.

Also you have to define this to pick up the new API from fuse.h
Removing #define FUSE_USE_VERSION 26 from this source file causes
the version 21 API to be used, hence the build errors.

/usr/include/fuse/fuse.h

/** @file
  *
  * This file defines the library interface of FUSE
  *
  * IMPORTANT: you should define FUSE_USE_VERSION before including this
  * header.  To use the newest API define it to 26 (recommended for any
  * new application), to use the old API define it to 21 (default) 22
  * or 25, to use the even older 1.X API define it to 11.
  */

#ifndef FUSE_USE_VERSION
#define FUSE_USE_VERSION 21
#endif

thanks,
-- Shuah

