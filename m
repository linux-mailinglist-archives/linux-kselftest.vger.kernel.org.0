Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB904D28A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 07:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCIGEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 01:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCIGEs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 01:04:48 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6581131
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 22:03:51 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x200so2212645ybe.6
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 22:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IupeTBPV0CwLiSouyNsLlNej2M8VfozXJBeb1wXs4oQ=;
        b=YX63l3TuBE9WHvkLnj96DmhUI8+x1TUv5ps/J4Wdbj/N6Hyybd7haDR3I08A5pxdlA
         +l2zeiIiDOTGGSSw+XV7u0/uKlVlUuIeRltWKMYPR+536T44a6R2gqtdTILVdexRCEQy
         sP6q5P82Y9efU/Hm1lecDTdhH7rArXYU6n1dwDO9JMIXLFialuF7CPM1T+/0QIPMm2C3
         rNsB0xW69cm7H+et2JlGu2BYfFD/kkqMAr1K0zAZEVGhroj6EJf30YvKmCc02TR5tX7P
         PeVHn1U645aM4Oy1dFJ/Bv+EJYIi7kor1u1lljkqt9zvXBVPytkftVBdprPcCRKiP9K8
         YeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IupeTBPV0CwLiSouyNsLlNej2M8VfozXJBeb1wXs4oQ=;
        b=RBR82rAZJLWRScgrdRwbNE+lJswgqPBu4usm/4kOjEfoZuO3/zUx7dZHlVieZJuTTC
         WNhvAFYHQeKhEIsSwSfBhkk9FyvClrAybwdSFXSZLJsXp0WKEhiQeanACt3yd/5Ve8F7
         a1+1CiRF1OF/LBqVIDgu0D3COBGEUbph3B5lr+0vTbjRDdPlQlGQyhC/JXyRbO58o1eI
         bto/intTLnzDp6jog4mD0e7AtzDtcwHRXXw3ZpGXu+FTMdzlim4YqBcUC8F4mTheNE8S
         ROVijaozQhwtGD9fP5fGNiQ1Hpq3bG9DleYHQ6OETdFfFMXtGCbbnvWDmxW99UKjhLUn
         dc1Q==
X-Gm-Message-State: AOAM532RyInAT1ZiFmn3JQtOSHosyxnvXmFuHqI2Iel6M/i0cqMdfUgS
        YzlrwH4YW6Qc/ybpy2MEijMWsifAq6kAeNaJ2bWgj10P6jX8ZQ==
X-Google-Smtp-Source: ABdhPJwMwHfZlnKRiebptjBPF0BQZhGKq+CXkoxVgCdFKhi4kh5G6U+X3lfyayuw+aUPTtdtHmrkaM0/ZtB9jQAQcwg=
X-Received: by 2002:a05:6902:184:b0:628:233e:31fe with SMTP id
 t4-20020a056902018400b00628233e31femr14583650ybh.609.1646805830152; Tue, 08
 Mar 2022 22:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20220309014705.1265861-1-liupeng256@huawei.com> <20220309014705.1265861-3-liupeng256@huawei.com>
In-Reply-To: <20220309014705.1265861-3-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 07:03:13 +0100
Message-ID: <CANpmjNOU+M1ZaRTMPMCFE7pm8JXLKsWcMpMAsDmJXZUga3N7=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: make kunit_test_timeout compatible with comment
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, dvyukov@google.com,
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

On Wed, 9 Mar 2022 at 02:29, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> In function kunit_test_timeout, it is declared "300 * MSEC_PER_SEC"
> represent 5min. However, it is wrong when dealing with arm64 whose
> default HZ = 250, or some other situations. Use msecs_to_jiffies to
> fix this, and kunit_test_timeout will work as desired.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Does this need a:

Fixes: 5f3e06208920 ("kunit: test: add support for test abort")

?

> ---
>  lib/kunit/try-catch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 6b3d4db94077..f7825991d576 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -52,7 +52,7 @@ static unsigned long kunit_test_timeout(void)
>          * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
>          * the task will be killed and an oops generated.
>          */
> -       return 300 * MSEC_PER_SEC; /* 5 min */
> +       return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */

Why not just "300 * HZ" ?

>  }
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220309014705.1265861-3-liupeng256%40huawei.com.
