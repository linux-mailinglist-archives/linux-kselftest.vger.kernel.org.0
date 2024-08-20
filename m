Return-Path: <linux-kselftest+bounces-15785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4D958DA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 19:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462F31F23E1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247671C0DFE;
	Tue, 20 Aug 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIYjgZTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAA18FC9E;
	Tue, 20 Aug 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176503; cv=none; b=tPQ0h/IZmk+mLJNu1LXeo+FL9Rdr4BGpuDwUOO9w824aHQQC4uyGBFrKkKMDnlF/bULjvYp8NxxS8JrppJKUP7PUTBDQATJcgWX+dLiZuZBr9enQO7zmRVOVcrUc+KfFDkGixN9ak2P+B2XUui+rfY9HzBnL+Q5OheEnP/pqHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176503; c=relaxed/simple;
	bh=ivLmsXrNxkgw/7EmN9OO2jK/NMu3cLUR1EDZkAA5DRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5DgUg0ms0S8lzrw41NodOgScKXvlLuzgmI018rSBKmDagk4dTWQLiXSB/pTrglmtcvC3EUXJI8hSLUzpUXeH28eulN4cFiDkEXccUZFyFO8pSHoqohLtV/yoGCZ9qXgLn4lLV2sBDcUrf1ShgvXvtysz4eTXEmwkbPS7A/gsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIYjgZTd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-530e22878cfso6008117e87.2;
        Tue, 20 Aug 2024 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724176499; x=1724781299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAx7Ozo2+fX0DMhLoV9detSsDy6Rf9KorjwEP7pVTXk=;
        b=IIYjgZTdKSEZj6W8rWXNtXxnMDu+Pd3FPHzKdW+M/qQNi43CvQpEdDjbjom2ptv8z+
         D/0begC1AHOGvZnxpuSz2SrJZTYUKvxvjxNTIiADxoHvr35jvQU9dvhHk4qJr9bvc20q
         uDW+pzTf6NYwXhh+rYrJ0rUQUujk6HVhKCibtAuV/pOoEL6QOeX8hnj/ambFBzFxbl4u
         iRjYeqL/zoRrs1JMKR1DksGq6kih7Hzx6Wt208RQX5dwvCL7VYdhuqZiKYEiOPEKoQ90
         n7PN/7WY113+ZXh/b7ILM2gqyEnZvaCTXQe3tvRV4ASyqNrtv1HpqM3m/phNe/Gbj+5E
         jmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724176499; x=1724781299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAx7Ozo2+fX0DMhLoV9detSsDy6Rf9KorjwEP7pVTXk=;
        b=Ek9SYPJc6kyKb97klKIzCY5RLOmdoF50Zo4rAyTLtI3Q9ZVY6m8OR7jytmXfCO9OlB
         nyk6IWponfFoll3pAzmMsgqnd67Mf+LVfKjSZCYLBI1qOh3Dxkmimysp0aBlYitnvOG1
         jYPqzdeeMWr6zY2bp3Ez4iDlJ0hVGDjcCxpw9AIid+81a1iW26pir0c/TmOBD2i40Fdh
         NX1Ze+8HYQaE8GL/WaXxuu1G2h6fd+jmZGHae6M3/HrWijuEHMM6LJi7gLd/TmbC39xB
         CD2c6OGGrXzaA6OZYTIxKFZxKqUpQYHxZB3Jzr8lWXJAxFWXnsapMmclyKxusHT6CvM/
         YJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU76tnbvTCnAT5hEDJvdvcS0IkDobMOOp1pg+hfB2mNv72yC0PbvgjJZvAtzHISaecdf1zv/AvIfV5TF8D6n1zu@vger.kernel.org, AJvYcCVZqwLTtcXKhC+eDDGWSjMccji2S76JTpxy32+60FSv5OtOneV5mMYOC4XwFBokSsgRGJtiPZ2XzddXoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKIiRYNp6uLWEeEFwtaJypfpdJUigZX3VwPFJL39Q8qu8uctZ
	jqO1auW0WcniJ3Itl3R/jmF4Ro/mLICq2S+Uv3u99Ul7NJfi0eTJ
X-Google-Smtp-Source: AGHT+IGpiTloKKX1k0+8EYzJZ6lJ+EhkA4fDVW/Z+02sqJiFsjYGkKhqZ6xoo5GnGoOlLwaOcLtS2A==
X-Received: by 2002:a05:6512:10cb:b0:52e:9dee:a6f5 with SMTP id 2adb3069b0e04-5331c6dcca9mr9083737e87.46.1724176498930;
        Tue, 20 Aug 2024 10:54:58 -0700 (PDT)
Received: from ivan-HLYL-WXX9 ([2a00:23c6:5496:1d01:67d:62c1:f9a2:2de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935636sm786869666b.108.2024.08.20.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:54:58 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:54:54 +0100
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Nico Pache <npache@redhat.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2] kunit: Device wrappers should also manage driver name
Message-ID: <20240820175454.orwzn72ojenwv47m@ivan-HLYL-WXX9>
References: <20240816045123.1934387-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816045123.1934387-2-davidgow@google.com>

On Fri, Aug 16, 2024 at 12:51:22PM +0800, David Gow wrote:
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index e2a1f0928e8b..5ac237c949a0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -28,6 +28,7 @@
>  #include <linux/types.h>
>  
>  #include <asm/rwonce.h>
> +#include <asm/sections.h>
>  
>  /* Static key: true if any KUnit tests are currently running */
>  DECLARE_STATIC_KEY_FALSE(kunit_running);
> @@ -480,6 +481,53 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>  	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>  
> +
> +/**
> + * kunit_kfree_const() - conditionally free test managed memory

Hi David,

Minor nit, but I believe the description of the 'test' parameter should
be here as well (like it is done in kunit_kstrdup):

```
  @test: The test context object
```

> + * @x: pointer to the memory
> + *
> + * Calls kunit_kfree() only if @x is not in .rodata section.
> + * See kunit_kstrdup_const() for more information.
> + */
> +void kunit_kfree_const(struct kunit *test, const void *x);
> +
> +/**
> + * kunit_kstrdup() - Duplicates a string into a test managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * See kstrdup() and kunit_kmalloc_array() for more information.
> + */
> +static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp)
> +{
> +	size_t len;
> +	char *buf;
> +
> +	if (!str)
> +		return NULL;
> +
> +	len = strlen(str) + 1;
> +	buf = kunit_kmalloc(test, len, gfp);
> +	if (buf)
> +		memcpy(buf, str, len);
> +	return buf;
> +}
> +
> +/**
> + * kunit_kstrdup_const() - Conditionally duplicates a string into a test managed allocation.
> + *
> + * @test: The test context object.
> + * @str: The NULL-terminated string to duplicate.
> + * @gfp: flags passed to underlying kmalloc().
> + *
> + * Calls kunit_kstrdup() only if @str is not in the rodata section. Must be freed with
> + * kunit_kfree_const() -- not kunit_kfree().
> + * See kstrdup_const() and kunit_kmalloc_array() for more information.
> + */
> +const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..520c1fccee8a 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -89,7 +89,7 @@ struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
>  	if (!driver)
>  		return ERR_PTR(err);
>  
> -	driver->name = name;
> +	driver->name = kunit_kstrdup_const(test, name, GFP_KERNEL);
>  	driver->bus = &kunit_bus_type;
>  	driver->owner = THIS_MODULE;
>  
> @@ -192,8 +192,11 @@ void kunit_device_unregister(struct kunit *test, struct device *dev)
>  	const struct device_driver *driver = to_kunit_device(dev)->driver;
>  
>  	kunit_release_action(test, device_unregister_wrapper, dev);
> -	if (driver)
> +	if (driver) {
> +		const char *driver_name = driver->name;

Also a minor nit (and I haven't found anything in the kernel code style
regarding it), but probably the declaration should be moved into
beginning of the function (as it is done in the rest of the file)

Thanks!

--
Kind regards,
Ivan Orlov

