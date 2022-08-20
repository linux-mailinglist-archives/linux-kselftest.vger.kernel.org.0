Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001FE59B0A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 00:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiHTWGQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHTWGP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 18:06:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1F2B1AA;
        Sat, 20 Aug 2022 15:06:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cb8so5656331qtb.0;
        Sat, 20 Aug 2022 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hPF2tPmw3K8jX//Zt96eJO5o67QhshkUTXLYOp1ebaE=;
        b=jCLAk2EQvh5CButLb5gwQc1c/4Osf8P6VY4Fsz59VCQ3L+c0nS4hLwo+b+KKeQY74R
         lfNH2aEAs9tlrtPsBrfOIkwL0YLjK9q2T83h6U0JF1sfEQZBH+pE8FEJ4INPPoHBWMWP
         jjowk0fJSqqAPYpNqhpuLF3DtZ6fHs0Ww0xF48jr+eO52gUSZ4l8YEQ72K6jpSAXJLCX
         Dz7bb1MzMi6HVtzT4lnsZEe3vRNuIELew1UJ/tXWPpqKEs6Fd4KIWfd2fAlqYZAYShYd
         Yqvd1iGRZY7/2dE8bPQBvubiWhQKMW6TPxGJyF0WWhQQFBMOKG4MCwlkJnyY2MXQPLdP
         v2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hPF2tPmw3K8jX//Zt96eJO5o67QhshkUTXLYOp1ebaE=;
        b=ZxS/5z2gdjScThffEzJ/FCS/J2X+cEz1V38Q7oWvTi+BItGgPkHNzOyhBflktOen0I
         Jxwr6T81TQXZmMM3IKLUNOjFn7w439dt3NswJkoTBuJ0jpSh1AXu/Jk3fi842xpu6fQq
         vaV1YPu4Iq+/AGGBeEBPA3hpkisTB5S757PLWu619rkM/Wf8uX2gpAkjOn5eHn599r2i
         BKKkq7FwlTc73PLHJw7lv3KG49W01wTRUBSAWlBEKSro4/TyFEsI2ZY4EcrkJEVrLu9J
         S9su3u2AQniNgeB+uQ301tZ+XwIpp9wcwuHdumxQE8kVjprDUDFlozWeGdxx6oufnNM6
         Ou1w==
X-Gm-Message-State: ACgBeo1mt4ECP6rVj+BOJXsw5HrFI+I1gDqe2LhGQL3UbtwtQACDbGMb
        OvKu26WR18pMtFuBl4E1c30=
X-Google-Smtp-Source: AA6agR6QPOqr8jXIkiaqAapfnigs0qcIIWtP3yYIvvOjOPVBaTSWSWHN70080ZaXH2TwK+3n1MKzFw==
X-Received: by 2002:a05:622a:14f:b0:343:6951:41d2 with SMTP id v15-20020a05622a014f00b00343695141d2mr10823615qtw.254.1661033173638;
        Sat, 20 Aug 2022 15:06:13 -0700 (PDT)
Received: from localhost ([172.58.171.171])
        by smtp.gmail.com with ESMTPSA id p11-20020ac8740b000000b00342fcdc2d46sm5632144qtq.56.2022.08.20.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 15:06:13 -0700 (PDT)
Date:   Sat, 20 Aug 2022 15:06:11 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] cpumask: KUnit test suite fixes and improvements
Message-ID: <YwFa0xiM/b0N5X0w@yury-laptop>
References: <cover.1661007338.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661007338.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 20, 2022 at 05:03:08PM +0200, Sander Vanheule wrote:
> This series fixes the reported issues, and implements the suggested
> improvements, for the version of the cpumask tests [1] that was merged
> with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
> suite").
> 
> These changes include fixes for the tests, and better alignment with the
> KUnit style guidelines.

I wrote a couple comments, but the series looks OK to me in general.
So for 2, 3 and 5:
Acked-by: Yury Norov <yury.norov@gmail.com>

It's named as 'fix', but it fixes a test, and the kernel code itself
looks correct. So, do you want to take it into 6.0-rc, or in 6.1?

I'm OK to do it this way or another, but for later -rc's it may look
too noisy. And I'm not sure where to put a threshold.

Thanks,
Yury
 
> [1] https://lore.kernel.org/all/85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net/
> 
> Changes since v1:
> Link: https://lore.kernel.org/lkml/cover.1660068429.git.sander@svanheule.net/
> - Collect tags
> - Rewrite commit message of "lib/test_cpumask: drop cpu_possible_mask
>   full test"
> - Also CC KUnit mailing list
> 
> Sander Vanheule (5):
>   lib/test_cpumask: drop cpu_possible_mask full test
>   lib/test_cpumask: fix cpu_possible_mask last test
>   lib/test_cpumask: follow KUnit style guidelines
>   lib/cpumask_kunit: log mask contents
>   lib/cpumask_kunit: add tests file to MAINTAINERS
> 
>  MAINTAINERS                             |  1 +
>  lib/Kconfig.debug                       |  7 +++++--
>  lib/Makefile                            |  2 +-
>  lib/{test_cpumask.c => cpumask_kunit.c} | 13 +++++++++++--
>  4 files changed, 18 insertions(+), 5 deletions(-)
>  rename lib/{test_cpumask.c => cpumask_kunit.c} (90%)
> 
> -- 
> 2.37.2
