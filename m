Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E239F3F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfH0UVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 16:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0UVm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 16:21:42 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214E020679;
        Tue, 27 Aug 2019 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566937300;
        bh=pBt0OU1xBZ8i4okIZoN8NOx4XiV46EKgAk8Y+jV0Se0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G3+ns0lK4iIkjaNKh0RlJ/77ofU5Dxglt4Hqw4Oje8xeQIntsypB1jIik4WAsaxcB
         ctiTNP1rcJDop+z+fR4Wrbe5b4Xqn+hqtK43H6NHXcSB6CUmkigGJ4RYkO1zuc+VCk
         EYqqMZt5Q/NJo6QZW+H2oOH7MRoYAiswgpOJzISY=
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        shuah <shuah@kernel.org>
References: <20190827174932.44177-1-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
Date:   Tue, 27 Aug 2019 14:21:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827174932.44177-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 11:49 AM, Brendan Higgins wrote:
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by ifdefing out functions which
> directly depend on printk core functions similar to what dev_printk
> does.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   include/kunit/test.h |  7 +++++++
>   kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>   2 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8b7eb03d4971..339af5f95c4a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>   
>   void kunit_cleanup(struct kunit *test);
>   
> +#ifdef CONFIG_PRINTK

Please make this #if defined(CONFIG_PRINTK)

>   void __printf(3, 4) kunit_printk(const char *level,

Line these two up with const char *level,

>   				 const struct kunit *test,
>   				 const char *fmt, ...);
> +#else
> +static inline void __printf(3, 4) kunit_printk(const char *level,
> +					       const struct kunit *test,
> +					       const char *fmt, ...)

Same here.

> +{}

Either line this up or make it

const char *fmt, ...) { }

It is hard to read the way it is currently indented.

> +#endif
>   
>   /**
>    * kunit_info() - Prints an INFO level message associated with @test.
> diff --git a/kunit/test.c b/kunit/test.c
> index b2ca9b94c353..0aa1caf07a6b 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -16,6 +16,7 @@ static void kunit_set_failure(struct kunit *test)
>   	WRITE_ONCE(test->success, false);
>   }
>   
> +#ifdef CONFIG_PRINTK

Same here - if defined

>   static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
>   {
>   	return vprintk_emit(0, level, NULL, 0, fmt, args);
> @@ -40,6 +41,29 @@ static void kunit_vprintk(const struct kunit *test,
>   	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
>   }
>   
> +void kunit_printk(const char *level,
> +		  const struct kunit *test,
> +		  const char *fmt, ...)

Line the arguments up.

> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +
> +	kunit_vprintk(test, level, &vaf);
> +
> +	va_end(args);
> +}
> +#else /* CONFIG_PRINTK */
> +static inline int kunit_printk_emit(int level, const char *fmt, ...)
> +{
> +	return 0;

Is there a reason to not use
> +} > +#endif /* CONFIG_PRINTK */
> +
>   static void kunit_print_tap_version(void)
>   {
>   	static bool kunit_has_printed_tap_version;
> @@ -504,20 +528,3 @@ void kunit_cleanup(struct kunit *test)
>   		kunit_resource_free(test, resource);
>   	}
>   }
> -
> -void kunit_printk(const char *level,
> -		  const struct kunit *test,
> -		  const char *fmt, ...) > -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	kunit_vprintk(test, level, &vaf);
> -
> -	va_end(args);
> -}
> 

Okay after reviewing this, I am not sure why you need to do all
this.

Why can't you just change the root function that throws the warn:

  static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
{
         return vprintk_emit(0, level, NULL, 0, fmt, args);
}

You aren'r really doing anything extra here, other than calling
vprintk_emit()

Unless I am missing something, can't you solve this problem by including
printk.h and let it handle the !CONFIG_PRINTK case?

thanks,
-- Shuah

