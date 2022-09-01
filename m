Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D45AA07C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiIATzX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiIATzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 15:55:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9184B3AE5B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 12:55:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h78so15518550iof.13
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Sep 2022 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=seI1koEC25ypVGd7T1UjIwUU3cFD+MV5D0arikaOKag=;
        b=mzcebpbWdcmzlubeGcDuaw+53g7e5bWwmRlay5XuQCuH3R/t0JaasCCMwM64OhQ8C0
         Qj8qMRkKOagiQjpH+nVAooZugFtBFIZcSUg/ZoOIEeiF+ewsGDfW5Xojf9q5HCf4t956
         PFhD3GO7Z/XVxDSRp5TuShiPr/FFsO9VDyAwZ7plwo+K5WQ0gFWxLBD/6x4a2LKPbz8j
         BiFNQ+f/1SKSq9n+C1xM3Zej61fBZKP0ddqpVHJJoDvqdQbB82KS514IxM3cVsORj0X6
         2qGXWXJrP3ahNVwr4ON0I31cXTL/f6Up+m0FJxwLrZnqHmDuAmgHF8t8sj+xxtUA1yzv
         H7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=seI1koEC25ypVGd7T1UjIwUU3cFD+MV5D0arikaOKag=;
        b=PRTMq8UlWaojkeXSboY47/RQafHyi7D7S4MvcsmWIZuqIcVloy+bOrgtL/6rrOleGY
         E6qsPqnCoD3njrS9Zh0EbJJ0EQnYjZWwDkzzE/vivpbd7Zg34LjRftmeWNePL0gUHA/F
         ZQ+4fOXXX/jQKGgprytC3hJkZu9EeSxMoxYe+YFTBFiiseHS2ZhmiiHXMPfHSyJX9aUU
         7UctBzMz1dYHOoczfy4rvYjH2LTfLLYqmO6HJmZ8fo56v2fP9n9O69HqUhjEeNv0rciY
         m6xr+2Oyb7k2tRWd+2vvPAE1TeM6a1YsqCeExF40SC2SxkktJ3bgypMz8ks4UDGskJvi
         fM/A==
X-Gm-Message-State: ACgBeo3etmFuJnRWmuEKRMyHCYM7BKKrQ0yhU6nye539e4dP7IIndS+A
        9yGjrDPEgrwKLPfvLdo5z2VvKX84okQRLm021LA2CejHuQY=
X-Google-Smtp-Source: AA6agR6E8CWIjgzNAAEwAB1E6jFOLB0toIoj0r0vr72SzwiSp/lagdot9Pv8Elb1B+6+1/bL+SDvb2Xedw6RH/MYQ+o=
X-Received: by 2002:a5d:8b47:0:b0:689:a436:81d2 with SMTP id
 c7-20020a5d8b47000000b00689a43681d2mr15417264iot.138.1662062118567; Thu, 01
 Sep 2022 12:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220901092315.33619-1-tsahu@linux.ibm.com>
In-Reply-To: <20220901092315.33619-1-tsahu@linux.ibm.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 1 Sep 2022 12:54:42 -0700
Message-ID: <CAJHvVciwa4x8sQag0a5dmq2GbmpMs3bYEVCW4g_Ro_o_GVtQTg@mail.gmail.com>
Subject: Re: [PATCH] selftest: vm: remove deleted local_config.* from .gitignore
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, aneesh.kumar@linux.ibm.com
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

Thanks for the cleanup! For what it's worth:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Thu, Sep 1, 2022 at 2:23 AM Tarun Sahu <tsahu@linux.ibm.com> wrote:
>
> Commit d2d6cba5d6623245a80cc151008cce825c8b6248 ("selftest: vm: remove
> orphaned references to local_config.{h,mk}") took care of removing
> orphaned references. This commit remove local_config from .gitignore.
>
> Parent Patch
> Commit 69007f156ba7aead6c75b0046958ad3396f5aed1 ("Kselftests: remove
> support of libhugetlbfs from kselftests")
>
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/.gitignore | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 31e5eea2a9b9..7b9dc2426f18 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -30,7 +30,6 @@ map_fixed_noreplace
>  write_to_hugetlbfs
>  hmm-tests
>  memfd_secret
> -local_config.*
>  soft-dirty
>  split_huge_page_test
>  ksm_tests
> --
> 2.31.1
>
