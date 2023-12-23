Return-Path: <linux-kselftest+bounces-2412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EA81D232
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 05:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6870F285251
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 04:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1052F37;
	Sat, 23 Dec 2023 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EWn5DSx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028417E4;
	Sat, 23 Dec 2023 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/nDUTaF2Haha1knmP1FS+N8wAbIojrAqSVH9+4HCMLg=; b=EWn5DSx6ldKRSKiZpfFSJSjED8
	s+q6sqErHigArGVSAXrNbpJBfqmNoK6k817MY8JP/XztDXLCgcy6Qmp3n95edXFChD+IW7rSL7/GQ
	gpvpirNEeUeEUWhCgfSpF0X2NnTFi3exIPpf753/AnkIWSY5mRkvqrQhYJLLifTg3QWojViM+atho
	4kWkzXdJVDI6c53tzBSm6e/85LzDGEBYY1HA1lIekPdg62oEus8RPhA5Sy6S3QSbh+0UmJMqClIm8
	3JxSUfqSGyJZBV9/EJXzV4sDQHgAQqnk+pVni0F7QI2H0TG/iU+A6jqsaWWnSMfflYjQhUmUglBOP
	XO7VX4oQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGtXo-007Koz-36;
	Sat, 23 Dec 2023 04:23:24 +0000
Message-ID: <29ef2f6b-f184-4913-a47d-32b175a2bd6a@infradead.org>
Date: Fri, 22 Dec 2023 20:23:24 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Fix some comments which were mistakenly kerneldoc
Content-Language: en-US
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Rae Moar <rmoar@google.com>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
 kernel test robot <lkp@intel.com>
References: <20231223041858.1991349-1-davidgow@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223041858.1991349-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 20:18, David Gow wrote:
> The KUnit device helpers are documented with kerneldoc in their header
> file, but also have short comments over their implementation. These were
> mistakenly formatted as kerneldoc comments, even though they're not
> valid kerneldoc. It shouldn't cause any serious problems -- this file
> isn't included in the docs -- but it could be confusing, and causes
> warnings.
> 
> Remove the extra '*' so that these aren't treated as kerneldoc.
> 
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312181920.H4EPAH20-lkp@intel.com/
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  lib/kunit/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 1db4305b615a..f5371287b375 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -60,7 +60,7 @@ static void kunit_device_release(struct device *d)
>  	kfree(to_kunit_device(d));
>  }
>  
> -/**
> +/*
>   * Create and register a KUnit-managed struct device_driver on the kunit_bus.
>   * Returns an error pointer on failure.
>   */
> @@ -124,7 +124,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>  	return kunit_dev;
>  }
>  
> -/**
> +/*
>   * Create and register a new KUnit-managed device, using the user-supplied device_driver.
>   * On failure, returns an error pointer.
>   */
> @@ -141,7 +141,7 @@ struct device *kunit_device_register_with_driver(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(kunit_device_register_with_driver);
>  
> -/**
> +/*
>   * Create and register a new KUnit-managed device, including a matching device_driver.
>   * On failure, returns an error pointer.
>   */

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

