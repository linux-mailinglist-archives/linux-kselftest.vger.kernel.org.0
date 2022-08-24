Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A471359FF22
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiHXQJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiHXQJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 12:09:22 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D082FA6;
        Wed, 24 Aug 2022 09:09:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n21so13037633qkk.3;
        Wed, 24 Aug 2022 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=C+yrvCC+MYWfpBYPz3pAHpswC7Wg1dOwcWCBS2OjYIg=;
        b=OWPRwznhsZ38zaLBPBZkh4KLkbcmynlAE8W0na7s561GvXY05lH11QUbv9xmkyfyA/
         OFPRMJ1SNHXl1kUiJHLx6tWBj390QOOly3GdIYYNfyhezL0/Q3lNbskRl+ZqxEt+mDFP
         a1D0sIhrDR0nEUkhr/gXQwgOJq3+mg2nYR+cgHTscJpnzfVyaBU3bHm2d8irzJyPzRjU
         WhY+4B0nR0d2ukiNCt2KVMgi7sL9t0nKJKzfJZpOfMtvK19N0kWKsjZ8HOhJzbNxye+Y
         YYTOHSBY5GK3P0In2weaTOqYeg0RcQHM6jeDgFe9gntSj86g9bkKWKMiigCxMS5AoYAT
         cQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=C+yrvCC+MYWfpBYPz3pAHpswC7Wg1dOwcWCBS2OjYIg=;
        b=l9Y9ivuxjwnawEXZSTjIBbhnS1dUIxXA6FcOlAT3/NbrjzWz0wq9cJnRWW27Rmv2fK
         rdOEjntsilAR/BmCEW52yZJ3w2EZ+oLl4oDqnNoHbEM0yuBxG+AI9N+VNrz7SeObJpdE
         LXTz+7Z4XaWpO8aXs3c7cH7teaviX26OPR/dxcfHpkm0/llcJV1CadmjRhodAQPFSFTd
         cS9doXsbOOaDCvGSW/pj0f3j5HXHO13buI1InDt9s6IZeZp7S/fsSWAGcUW7KQcbMXTj
         rvl1BhCHAV9ieiioXiivSTEwhekPmuLJbObNbCYcgNAAerVRWTLTco5Tmd+LD5aAcj8L
         FgBQ==
X-Gm-Message-State: ACgBeo1mVbd6coBbhcR0UYZ+w9YTe4SayO+yE7YaT/4ZTg/lZI0FruIj
        hbjWYLq9XUbC2fmNqCIcPKw=
X-Google-Smtp-Source: AA6agR6/XUcNtz9VCbNwJhPMwON6SXtPHx7FPUBzAmSpCjOilPc1kUd4GMWH1EA9yAMSQ3afzwq+bg==
X-Received: by 2002:a37:9a8c:0:b0:6ba:c06f:bc1d with SMTP id c134-20020a379a8c000000b006bac06fbc1dmr20011063qke.193.1661357359590;
        Wed, 24 Aug 2022 09:09:19 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b61b2cb1d2sm15520464qkp.46.2022.08.24.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:09:19 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:09:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] cpumask: KUnit test suite fixes and improvements
Message-ID: <YwZNLoHtm7b6t4y2@yury-laptop>
References: <cover.1661234636.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661234636.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 08:12:17AM +0200, Sander Vanheule wrote:
> This series fixes the reported issues, and implements the suggested
> improvements, for the version of the cpumask tests [1] that was merged
> with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
> suite").
> 
> These changes include fixes for the tests, and better alignment with the
> KUnit style guidelines.

Applied in bitmap-for-next.

Thanks,
Yury
 
> [1] https://lore.kernel.org/all/85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net/
> 
> Changes since v2:
> Link: https://lore.kernel.org/lkml/cover.1661007338.git.sander@svanheule.net/
> - Update commit message of "lib/test_cpumask: drop cpu_possible_mask
>   full test"
> - Use *_MSG() macros to only print mask contents on failure
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
>  lib/Kconfig.debug                       |  7 +++-
>  lib/Makefile                            |  2 +-
>  lib/{test_cpumask.c => cpumask_kunit.c} | 52 +++++++++++++++----------
>  4 files changed, 38 insertions(+), 24 deletions(-)
>  rename lib/{test_cpumask.c => cpumask_kunit.c} (58%)
> 
> -- 
> 2.37.2
