Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCC59CA52
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiHVUrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiHVUrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 16:47:18 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0272558DE
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:47:16 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id p123-20020a4a4881000000b0043cd86b5434so2129255ooa.8
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CiUQYh3VkiWrk7tILV4WC/5iJ5EWLzTZ3MjP1qEF7c8=;
        b=Hsb8llLcCL5ye2Z1lqzLqQ5cJaN623wjXgZbZAKSVPUcaGQ4lifDMMvfKYdSBd9dH0
         kjK+6CYpgcUhbQwCp6AbH3VLnrFqtgHOeiApzuGxkpLvYQ0bkd8DvTjlqcYrDaC945/R
         nM3dtwz+EtI8WFzTTDhrNWStQ+Y1BEqOcEhG6ehcdarjul31QtQXTt5HybvYGHtJ7p0h
         ONu9mpBTlJQXWdRZ5NZTLHtqp2BQS6Ldo/bqOUaHeI6dPKvCFu7s/fsYhI8j9KYixQbo
         pOgibeL86RlnEusH1XgtmvKa7rrIJSuP7W1DOkt2OG+vsEWTffdHCVkPiFHhwwWj2hqq
         +9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CiUQYh3VkiWrk7tILV4WC/5iJ5EWLzTZ3MjP1qEF7c8=;
        b=hmmsPCw+9Q/4CyIEg6h+BA1Fao1rZfIrpQ2zCTdklsOxwQQdsi/WiF7dQt/8kaCOHJ
         xiKZC0q3P54Oj11OcA1IiMKOXw9vMliFSK4knTuH5+qCgMmnkuYWGQeoOK7KCeK4WBWJ
         XLgVXH7kK7IU0BsMgFWbSSjEZrJkWMOBOeQLRc8eCRcYDW6QhkwPDL0c2ivMYV3RtYl4
         5fb0Y6K3UzxMOw/QZVD/MyYLcHBwaU+wuH+ftwf3o1R2Hv6t2O8WyHA0sZ5i/VtjfwJl
         HUDoKRTCiybNGVHQDC2V2VshjhEe65LmlxG1sysaymkxW1k6lN3d7OQGfpvZJCL3DnA3
         cmaA==
X-Gm-Message-State: ACgBeo28eo+LWSRuZNn8s4XF/ATeMxR3kmaMI3/h+Y8kJvAaZ6FjQmuV
        HWAxCdpOmIWDq0HGXwynSDikXZyBolgD+yrZpNaY
X-Google-Smtp-Source: AA6agR4W34m/vYq0DZq0hZL9WLXp7hmQ13PfWphv2yMytGfb/PPKXo++l1OmQuvD/SmBi1dHMG7JW9KoymzW1Zcy9HI=
X-Received: by 2002:a4a:94a6:0:b0:435:f61e:d7a1 with SMTP id
 k35-20020a4a94a6000000b00435f61ed7a1mr7144494ooi.82.1661201236122; Mon, 22
 Aug 2022 13:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com>
 <20220817164851.3574140-3-joefradley@google.com> <CABVgOSkRRMDz14cpsYBi7SaefbOhGc9V+z+pY_tULkk12Fb-EA@mail.gmail.com>
In-Reply-To: <CABVgOSkRRMDz14cpsYBi7SaefbOhGc9V+z+pY_tULkk12Fb-EA@mail.gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Mon, 22 Aug 2022 13:47:05 -0700
Message-ID: <CAF-60z2dc=5A9+3a8+v7F-CunKKesUD+2Q6OTEpmrpUa1SvcDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: no longer call module_info(test, "Y") for
 kunit modules
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 19, 2022 at 1:34 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, Aug 18, 2022 at 12:49 AM Joe Fradley <joefradley@google.com> wrote:
> >
> > Because KUnit test execution is not a guarantee with the kunit.enable
> > parameter we want to be careful to only taint the kernel only if an
> > actual test runs. Calling module_info(test, "Y") for every KUnit module
> > automatically causes the kernel to be tainted upon module load. Therefore,
> > we're removing this call and relying on the KUnit framework to taint the
> > kernel or not.
> >
> > Signed-off-by: Joe Fradley <joefradley@google.com>
> > ---
>
> Thanks!
>
> This definitely fixes an assumption I'd had about KUnit-usage which
> definitely doesn't hold: that all KUnit tests would be in their own
> modules (or at least that those modules wouldn't need to be loaded on
> otherwise production systems). Given this isn't the case for a number
> of modules (thuderbolt, apparmor, probably soon amdgpu), it makles
> sense to get rid of this and only taint the kernel when the test is
> actually run, not just when it's loaded.
>
> This could be considered a fix for c272612cb4a2 ("kunit: Taint the
> kernel when KUnit tests are run"), as it'd already be possible to
> load, e.g., thunderbolt, but prevent the tests from executing with a
> filter glob which doesn't match any tests. That possibly shouldn't
> taint the kernel.

Great, thank you for the review.

>
> Reviewed-by: David Gow <davidgow@google.com>
> Fixes: c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
>
> Cheers,
> -- David
>
> >  include/kunit/test.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index c958855681cc..f23d3954aa17 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -251,7 +251,6 @@ static inline int kunit_run_all_tests(void)
> >  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> >
> >  #define __kunit_test_suites(unique_array, ...)                                \
> > -       MODULE_INFO(test, "Y");                                                \
> >         static struct kunit_suite *unique_array[]                              \
> >         __aligned(sizeof(struct kunit_suite *))                                \
> >         __used __section(".kunit_test_suites") = { __VA_ARGS__ }
> > --
> > 2.37.1.595.g718a3a8f04-goog
> >
