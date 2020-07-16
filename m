Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25AC221A16
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 04:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGPCeR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jul 2020 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGPCeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jul 2020 22:34:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497BC08C5CE
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so2969574pfn.12
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBHFrLP+zznPw6dlb+xXG2h+uzB263gsWgoLrOM5A/U=;
        b=iBaOVvOBp/8cpWJBRzkHXXsvpirEoq1CjGUnb1KIpi1G+rcRPDkFLIFlGBCVL54pKM
         s7xII+/8u3NGU8VPmuhB1E288OtTD10FzrwznllqHJ7H13zf+muLeTiFCh3hmbfAJ7bU
         rkAfVlG5pbOycj9rqP2MwkqPEtLXoqGt4BkMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBHFrLP+zznPw6dlb+xXG2h+uzB263gsWgoLrOM5A/U=;
        b=M20bzh/h3c+4gRizEMc8/00YeMOJaxpKd2PMLG2uNfYoOT2m7Hw7tflTbpwML3Vr2J
         KNL97M+MER1SnLFoWfdSOvGuU0EVblRbnTgDuW0afHVaQ68wWAZwew5QliRlRn+EYECq
         Y3YGPTTX0RAhtqmLlf93f2VUZU3fL34Kru2uxXxwBQujU8bkih4GeSAHgwVjSLClpPFI
         WlYT6+csjGqwgLAgYz/JjNANcTKMo+6VSUYud+i9i3fts4rhG9O5H5StRvqC/kA+4Yem
         Eme84R8fM3cjbpDX7qtdqApGatlPKmFdTAia5YYNgIkTFpfkC+/otrazXpujPgNRqpsU
         7qDw==
X-Gm-Message-State: AOAM533AS0bMzH2ePF/eDZs7IGQ0L1gRi7U92LWMWkNhH9gNpVWr5XQq
        vsuGufJb+7MgYlAOXvS+qxCvKb0Job8=
X-Google-Smtp-Source: ABdhPJwT2W5XcXGiXUbSxWDU3H1XbGT7OIjiB+N9Wb/ir/tyFHQzD+xKtJnodqbNxpjPU8gbPlwKtA==
X-Received: by 2002:aa7:8597:: with SMTP id w23mr1732977pfn.219.1594866848006;
        Wed, 15 Jul 2020 19:34:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c139sm3047867pfb.65.2020.07.15.19.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:34:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 19:34:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC 3/3] lib: Convert test_user_copy to KUnit test
Message-ID: <202007151929.7A4E04E@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
 <20200715031120.1002016-4-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715031120.1002016-4-vitor@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 15, 2020 at 12:11:20AM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_user_copy fuctions,
> from `lib/test_user_copy.c`to KUnit tests.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> [...]
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/vmalloc.h>
> +#include <kunit/test.h>
>  
>  /*
>   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> @@ -31,26 +32,16 @@
>  # define TEST_U64
>  #endif
>  
> -#define test(condition, msg, ...)					\
> -({									\
> -	int cond = (condition);						\
> -	if (cond)							\
> -		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> -	cond;								\
> -})
> -
>  static bool is_zeroed(void *from, size_t size)
>  {
>  	return memchr_inv(from, 0x0, size) == NULL;
>  }
>  
> -static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> +static void test_check_nonzero_user(struct kunit *test, char *kmem, char __user *umem, size_t size)
>  {
> -	int ret = 0;
>  	size_t start, end, i, zero_start, zero_end;
>  
> -	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> -		return -EINVAL;
> +	KUNIT_EXPECT_FALSE_MSG(test, size < 2 * PAGE_SIZE, "buffer too small");

I think this could be a much smaller diff if you just replaced the
"test" macro:

#define test(condition, msg, ...)					\
({									\
	int cond = !!(condition);					\
	KUNIT_EXPECT_FALSE_MSG(kunit_context, cond, msg, ##__VA_ARGS__);\
	cond;								\
})

-- 
Kees Cook
