Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496562350A7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgHAFeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Aug 2020 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgHAFeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Aug 2020 01:34:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62017C06174A;
        Fri, 31 Jul 2020 22:34:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so10534328plk.13;
        Fri, 31 Jul 2020 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1TQDWlhtOphocCqRWnO12Oowtj66Ozztswpjd6Br1ME=;
        b=P10FY8t9DFhbP2LrF/seKSO64NGjM0Fxh8iyoxHYEka9Cjs31RQSglzPn7M9K1PSHE
         tNFbvxBTwG89WvCNZRTNvksbKApNNNUb3TRfWjnRLF6FNi515lD7h9x0364dRr2AJxkz
         GVytwGczXN8CEV2ds8VLJeGY2E2Regz9SGYUdkD2HExdUKXG6K9b0HXnSGtEpl4jZmM3
         I9daV2466gKRtOKZKE4clHILqgLMQG1vQnp01W+B5gKBZ+hzTE8TVWBDx1dK3sDlkS4B
         pcYvD8vyCwTj7bdDVX7WsUtIo5rwRWI1CEg0rO8e5DzYn5BmYvZh/pxxcAjQmO+W8+yL
         uxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TQDWlhtOphocCqRWnO12Oowtj66Ozztswpjd6Br1ME=;
        b=M7Mgo4A9qbMMSLZzLXnAxn30uVBjy0hOcrZCPmvkBnTYxvOTyn5aqW2Ksra639fY39
         GniGCkRGrqlNiDx1lvzhIRcPqKoExAknaWLU9v6EqgqpaYhT+tB8njS6EfBHf+hW8y8/
         pTPrH6fc98MexEh/NyeR1HK3VCGLOSYNa966XlBJlC2d3PwzYCLDxn60czEPyINpfGsV
         5Et22KUhxctb1fcVIykBvdRTc85CMsLXLlrLTwNRJe3seUMtMNQm5rLLT0uSkO+V9rGf
         46mSDD0F/EO/zTrFlSe2fFNn2eM38bDox4UDjMlz2JK/6aXsGoVYJTmLio+cuCpj2dPk
         Xvdw==
X-Gm-Message-State: AOAM530i3e2Wq6vwvpAXpbe1+g98BlB1JhHs6v9dZ344ECSnQDvWNOPL
        pwNj0tIZTfNrYtOHHdPxJc0=
X-Google-Smtp-Source: ABdhPJynN7v62CK8YvHCBJB81lE9wGVDwVtkZZiIaUMWckfcBezDzoCoI13qYX9ssOHoQcD+9CfhNA==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr7498920pjb.229.1596260045906;
        Fri, 31 Jul 2020 22:34:05 -0700 (PDT)
Received: from [192.168.86.81] ([49.206.12.123])
        by smtp.gmail.com with ESMTPSA id 144sm8745967pfx.116.2020.07.31.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 22:34:05 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200730121656.45302-1-98.arpi@gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <4747b45c-0429-bf2e-8c64-3f4bc6b95749@gmail.com>
Date:   Sat, 1 Aug 2020 11:04:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730121656.45302-1-98.arpi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/07/20 5:46 pm, Arpitha Raghunandan wrote:
> Converts test lib/test_uuid.c to KUnit
> 
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
>  lib/Kconfig.debug                 |  7 +--
>  lib/Makefile                      |  2 +-
>  lib/{test_uuid.c => uuid_kunit.c} | 84 +++++++++----------------------
>  3 files changed, 28 insertions(+), 65 deletions(-)
>  rename lib/{test_uuid.c => uuid_kunit.c} (48%)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f174f8887ae7..330c0d1de50b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2070,9 +2070,6 @@ config TEST_BITFIELD
>  
>  	  If unsure, say N.
>  
> -config TEST_UUID
> -	tristate "Test functions located in the uuid module at runtime"
> -
>  config TEST_XARRAY
>  	tristate "Test the XArray code at runtime"
>  
> @@ -2273,6 +2270,10 @@ config BITS_TEST
>  
>  	  If unsure, say N.
>  
> +config UUID_KUNIT_TEST
> +	tristate "KUnit test for functions located in the uuid module at runtime"
> +	depends on KUNIT
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index 032cc6c71a3a..62ef383c7563 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -81,7 +81,6 @@ obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>  obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
>  obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
> -obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
>  obj-$(CONFIG_TEST_PARMAN) += test_parman.o
>  obj-$(CONFIG_TEST_KMOD) += test_kmod.o
> @@ -342,5 +341,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
>  obj-$(CONFIG_BITS_TEST) += test_bits.o
> +obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
>  
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
> diff --git a/lib/test_uuid.c b/lib/uuid_kunit.c
> similarity index 48%
> rename from lib/test_uuid.c
> rename to lib/uuid_kunit.c
> index cd819c397dc7..f7f219ddecc2 100644
> --- a/lib/test_uuid.c
> +++ b/lib/uuid_kunit.c
> @@ -3,6 +3,7 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <kunit/test.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -39,95 +40,56 @@ static const char * const test_uuid_wrong_data[] = {
>  	"0cb4ddff-a545-4401-9d06-688af53e",	/* not enough data */
>  };
>  
> -static unsigned total_tests __initdata;
> -static unsigned failed_tests __initdata;
> -
> -static void __init test_uuid_failed(const char *prefix, bool wrong, bool be,
> -				    const char *data, const char *actual)
> -{
> -	pr_err("%s test #%u %s %s data: '%s'\n",
> -	       prefix,
> -	       total_tests,
> -	       wrong ? "passed on wrong" : "failed on",
> -	       be ? "BE" : "LE",
> -	       data);
> -	if (actual && *actual)
> -		pr_err("%s test #%u actual data: '%s'\n",
> -		       prefix,
> -		       total_tests,
> -		       actual);
> -	failed_tests++;
> -}
> -


I have removed the above test_uuid_failed function while converting to KUnit, as mentioned earlier. Is this required?

