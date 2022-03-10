Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA94D4240
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 09:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiCJILf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 03:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiCJILe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 03:11:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1B1342C1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:10:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so10259218eje.10
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ig5zBgV9456yZCmUhF8sBV7DGvRjdoa/kYWf35qIWfM=;
        b=gPCSxtOtkcm9lBcjKc3oEYW0bwIOPUjo/9v8mv6bIvRIKpp5KNbPSY1T5xU3ivvuVN
         k+xyt8opyuQ3TJKg2sQUmD4PPlOP3IT7LQammSIoRfwRLzXbtMlA2VGubvJPWKUES4Gg
         aAKRsund5DIxnpC/4Etq+A4zKMFKOcBjfGEdc0i5tlN9SpgaDe1HNoH9sXxEfXph7ajw
         8K7xkbSrZj8vk3LWmiUuqrY2Omeu4u+mPdl/6uje+nXWagXWGflDpRpXvXDJvy9R+LXz
         x98cLR7hdd8fXjQy1/ZbXP7eLvEqR4tL+4apb5i8ArRvmDDNc7UYYskI0kXNcpZW+cI4
         VKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ig5zBgV9456yZCmUhF8sBV7DGvRjdoa/kYWf35qIWfM=;
        b=iho4u80d+HnjwsDrNa2RhjYdyeEqEGQA1RjXtjX5rEIKxO+DuLXER5lCUZChcpLxL1
         fdWjJA1KTZrJMfyvRwTlzIEVIoeapaL1/hbmNoQzA1dqyebHmPoOxJJhKejAHjPvykW4
         aUhup22gH9yABowqD2eezFf6KPkx2UNbNGH1LmdixBBfNFCdj50+DBWtwZ7XBxHtodk5
         dhOpKMxFHo5xlLYOdL1LIzXkXFIL4wREiKiN8KYQxOB74IUGOFCxzPqahZcV3EgjLxe5
         v/iza0OVVGXiaa4sJ8pAFkWIvmroEKLoy2oWhu4wa/nrL4HjpIGx3jSkcb0nASGfM0Tj
         pjiw==
X-Gm-Message-State: AOAM532AUtSPEBAB1tQTxHMvwljBUxYGy0WZj8ONhBnhLZ5KtToTIS4u
        7Jl7S4aqd+zFHrt4eft68LPkKdUPniyBD5L4Z/BYuA==
X-Google-Smtp-Source: ABdhPJwWjyB4q5JB3+aDamJ9NuChwaNJ1qU/nXjWsKLHQQ+N2KuIi2D9W0C1teF+lT6fDaFrqnctNJAMDW7/NepL5GQ=
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id
 o25-20020a170906289900b006d6e4791fe2mr3156352ejd.394.1646899832564; Thu, 10
 Mar 2022 00:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-3-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-3-liupeng256@huawei.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 03:10:21 -0500
Message-ID: <CAFd5g44MbyK1Dg1yc=tMys_GPri+kjLO+2Kahv0rYEcp=+JP0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: make kunit_test_timeout compatible with comment
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
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

On Wed, Mar 9, 2022 at 3:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> In function kunit_test_timeout, it is declared "300 * MSEC_PER_SEC"
> represent 5min. However, it is wrong when dealing with arm64 whose
> default HZ = 250, or some other situations. Use msecs_to_jiffies to
> fix this, and kunit_test_timeout will work as desired.
>
> Fixes: 5f3e06208920 ("kunit: test: add support for test abort")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
