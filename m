Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1522287C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgGPQm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgGPQmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:42:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B5C08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:42:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so2971738qvj.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LMlqxALUY61jlVk3BUiDy9VLg6DTugrK02O4xaMAXeE=;
        b=l4b5Hqho974uh2PmbRJzJutQgFImeAJVlHlLkooGLhdZe1nS7mvf+x6gt/QOZw/qL9
         A84pVZc5FD32JGLt4LlnzFB06rz+hmPXLaI8hDe2fLxz/921s2jVMy4thipSXuNctzI7
         HkMqqpSinh/agWeAyLOt/K2QJIn1uTWJuHTPMTVpaO76a66+rxTTbLjEM8mQcObpOs2+
         8BUxyfhfHcFtYnPUbTfLKKZrZtVMp7BOCDW5a6netEOHL7Wv1pCOt9WjfJdZ1HyHyp9F
         K/0MQrVQdEzKi3vmuBUuhAa8yjbOADZqvUk0N5rSn5dQnSeMoHx9kweWpQy1527gH79c
         KhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LMlqxALUY61jlVk3BUiDy9VLg6DTugrK02O4xaMAXeE=;
        b=pdmYIhm8E5hnPbR3wLCJ+gxDG7D5W37MvBVF9gZ+tbKllCMmER/iJzY9hx8X4gyJWP
         34FWqRWUv6IazmddIYIy9ntX2PC4CEXIzmcf/V77KdLt1Nov95oWyVFIEUJ0GYGaIgxl
         7yaYZyH56sHNPn55Fs22yZpzngB75zbv7pzarYraIdn++I87vHWgjiapgd1gWA/iHyv0
         1eTNRERn8ggSb1ASeh9kF+yNCNO5XfAShxMWBYC7OLXKhHiDN+h+VijSs0qmvmOspL67
         crrkXFAxR3cV14F7aSjzN6Ubwuea3eyc+1OPOMBnh4iT9lapiun/0DH+rFLM6j6+6HPz
         hXOQ==
X-Gm-Message-State: AOAM531dcJiNFhpwSEOYKOX633o501/JOA2Y/AXwOl+iLfD7yKTsQC7m
        EgF1ALU/GExhew2XLodJIwTBKg==
X-Google-Smtp-Source: ABdhPJw8zMN/1FPYzX107TEkRXoQDL7PDsO3bU5e/CmgTIDO5o48Z06Nsfr79DuiczClK4visvbI1A==
X-Received: by 2002:a0c:dc07:: with SMTP id s7mr5275693qvk.122.1594917744190;
        Thu, 16 Jul 2020 09:42:24 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id u68sm8060659qkd.59.2020.07.16.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:42:23 -0700 (PDT)
Message-ID: <b3703bfd299c4156e44e5887dcc47e7dcc88dae7.camel@massaru.org>
Subject: Re: [RFC 3/3] lib: Convert test_user_copy to KUnit test
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:42:20 -0300
In-Reply-To: <202007151929.7A4E04E@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <20200715031120.1002016-4-vitor@massaru.org>
         <202007151929.7A4E04E@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 19:34 -0700, Kees Cook wrote:
> On Wed, Jul 15, 2020 at 12:11:20AM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_user_copy
> > fuctions,
> > from `lib/test_user_copy.c`to KUnit tests.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > [...]
> > @@ -16,6 +16,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/vmalloc.h>
> > +#include <kunit/test.h>
> >  
> >  /*
> >   * Several 32-bit architectures support 64-bit {get,put}_user()
> > calls.
> > @@ -31,26 +32,16 @@
> >  # define TEST_U64
> >  #endif
> >  
> > -#define test(condition, msg, ...)					
> > \
> > -({									
> > \
> > -	int cond = (condition);						
> > \
> > -	if (cond)							\
> > -		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
> > -	cond;								
> > \
> > -})
> > -
> >  static bool is_zeroed(void *from, size_t size)
> >  {
> >  	return memchr_inv(from, 0x0, size) == NULL;
> >  }
> >  
> > -static int test_check_nonzero_user(char *kmem, char __user *umem,
> > size_t size)
> > +static void test_check_nonzero_user(struct kunit *test, char
> > *kmem, char __user *umem, size_t size)
> >  {
> > -	int ret = 0;
> >  	size_t start, end, i, zero_start, zero_end;
> >  
> > -	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> > -		return -EINVAL;
> > +	KUNIT_EXPECT_FALSE_MSG(test, size < 2 * PAGE_SIZE, "buffer too
> > small");
> 
> I think this could be a much smaller diff if you just replaced the
> "test" macro:
> 
> #define test(condition, msg, ...)					
> \
> ({									
> \
> 	int cond = !!(condition);					\
> 	KUNIT_EXPECT_FALSE_MSG(kunit_context, cond, msg,
> ##__VA_ARGS__);\
> 	cond;								
> \
> })
> 

Sure, I'll do it.

Thanks.

