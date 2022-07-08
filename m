Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4756BFED
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiGHSXi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 14:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiGHSXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 14:23:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502B88F22
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 11:23:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id u20so20420275iob.8
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97VK5iQW+OLAMctb3bRhnVJI2Dk4NFeFeJbQXMmdP9g=;
        b=dm7gPCV+4gyiVAxSxrFBQejGH77CCYpAJBElNtgCngEA5WBI7Yc2n3yywfIFlpcCQd
         78g5turygqj6DdxWi3846rwYQBQlX8o9NVT3W8VVAhJUOgBlNd71vpPAVU7MkPRWnoyV
         mxwci8zjQG/h2zn69Vyv0HFfD7p0oOaFdBVmG/CeXp4vKGkaOR8ntd+QkwJKIvtSKtA3
         iDWXSAT7vQ0X1EGvbKQyqsp55ZEhSbF8lpjPQDRJ7aqB5JL0JpaM/9HcziOkPjuENTsi
         +vuwgM7BUKnDpoiNFCqHK6QcJ8qeVKH6wEXSEvf67S6wPwYcKKbL7mxAZlb01woQqmE6
         XTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97VK5iQW+OLAMctb3bRhnVJI2Dk4NFeFeJbQXMmdP9g=;
        b=Q3NfblyHEEd3dgUUzCD+tJ6nj04ENODzBIKC1xipKfY2yv2DsCRP1dfORXx5QIV5Lh
         zxuVAL3NaOkJ+jAVA3r5uGShFuZfExXwW71HHzsPrLQt2S32l1oQzuu/LLRfoUSuKQwo
         LAHR/bLc0dZ8y+n+XSDDaM+fCLK9VrM/vseX22YAbmoq56gVpKpzis60yT1HMVknjCGv
         9Oon8vzYxhLCXjKRUozzf8raV5ywlnZtDXVE6B70a+wWwNhh/x+xwpQDbPSISk11yt2B
         4FHf0LDR/Saw6YMKxhAVpry5Rxs983il6Ur4sjXL/b3wzhpKl+YOpnjTpGxrRA7yuhS+
         Jkbg==
X-Gm-Message-State: AJIora9LYgGg97i7oVgUqEmo77wva6rU23LovmdH13lICiMQ0c2tP/2T
        pjzMGnwzHjiQNPOrD1ljNePMbDWq1jo6xTyaJRvcSA==
X-Google-Smtp-Source: AGRyM1v951IbthTm0LElBbaQF/7RITAtzDe990vOEfJILkJ06LZs6GkFPaKHhzsiSy2JTGmWeVbLwI83+m4nwKm1Q7M=
X-Received: by 2002:a02:a105:0:b0:33f:1909:6c82 with SMTP id
 f5-20020a02a105000000b0033f19096c82mr2997602jag.278.1657304599260; Fri, 08
 Jul 2022 11:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-2-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Jul 2022 11:23:08 -0700
Message-ID: <CAGS_qxrGwVL37AOUWCxwx=qg6YvXCDSSu4p_PSt7_87N3RxJZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] kunit: unify module and builtin suite definitions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 10:10 PM David Gow <davidgow@google.com> wrote:
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..54306271cfbf 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -250,41 +250,8 @@ static inline int kunit_run_all_tests(void)
>  }
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
>
> -#ifdef MODULE
> -/**
> - * kunit_test_suites_for_module() - used to register one or more
> - *                      &struct kunit_suite with KUnit.
> - *
> - * @__suites: a statically allocated list of &struct kunit_suite.
> - *
> - * Registers @__suites with the test framework. See &struct kunit_suite for
> - * more information.
> - *
> - * If a test suite is built-in, module_init() gets translated into
> - * an initcall which we don't want as the idea is that for builtins
> - * the executor will manage execution.  So ensure we do not define
> - * module_{init|exit} functions for the builtin case when registering
> - * suites via kunit_test_suites() below.
> - */
> -#define kunit_test_suites_for_module(__suites)                         \

Deleting this bit now causes merge conflicts with Shuah's kunit
branch, due to https://patchwork.kernel.org/project/linux-kselftest/patch/20220702040959.3232874-3-davidgow@google.com/
I.e. We added in a MODULE_INFO(test, "Y") in this to-be-deleted section.

Perhaps something like this would be a fix?

  #ifdef MODULE
  #define _kunit_mark_test_module MODULE_INFO(test, "Y")
  #else
  #define _kunit_mark_test_module
  #endif /* MODULE */

  #define __kunit_test_suites(unique_array, unique_suites, ...)
          \
          _kunit_mark_test_module;
          \
          static struct kunit_suite *unique_array[] = { __VA_ARGS__,
NULL };     \
          static struct kunit_suite **unique_suites
          \
          __used __section(".kunit_test_suites") = unique_array


> -       static int __init kunit_test_suites_init(void)                  \
> -       {                                                               \
> -               return __kunit_test_suites_init(__suites);              \
> -       }                                                               \
> -       module_init(kunit_test_suites_init);                            \
> -                                                                       \
> -       static void __exit kunit_test_suites_exit(void)                 \
> -       {                                                               \
> -               return __kunit_test_suites_exit(__suites);              \
> -       }                                                               \
> -       module_exit(kunit_test_suites_exit)
> -#else
> -#define kunit_test_suites_for_module(__suites)
> -#endif /* MODULE */
> -
>  #define __kunit_test_suites(unique_array, unique_suites, ...)                 \
>         static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> -       kunit_test_suites_for_module(unique_array);                            \
>         static struct kunit_suite **unique_suites                              \
>         __used __section(".kunit_test_suites") = unique_array
>
