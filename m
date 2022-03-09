Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343DB4D290B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 07:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiCIGin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 01:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCIGim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 01:38:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2165FB8
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 22:37:44 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbd8777564so12745747b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 22:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OpR5YHkvilOZNO+UTT2Vvr8SNVAoIkBjKa4z5Ar1Ok=;
        b=pL4xjYO6ifYImKrhlBZ6+DsAPJsjayriSQUscyVIJK/EmqZJSUaqbzTtCX6mk7WGMt
         PKNwmtywhYZEUrx3u15IzKnaoYaZodxMLLv2uTJNtsQcajWrZGI+AwCkDBtRL8cJkmgw
         qfOHHYTQzuBU6Av+HwfhZLI/ZEoJJKq8FX9l8RIH5wnXUAo7/N7cWGddPjFIX8KXTia1
         0+ZfohPy53l54BoAoR8Bi8St46hf3WArazeb4x5RJ5M2eQxpbsyTC51DfR/pRkeHOlg6
         ncyfOCZS/5AojQ8cP0GfmS4GM2L12LwiCM0+J/5mjEf+egIYUnYHz7/JFRoAhpsNfIIL
         ALyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OpR5YHkvilOZNO+UTT2Vvr8SNVAoIkBjKa4z5Ar1Ok=;
        b=zmmh928ZnP/TCLnht3i8LF+6S+oAPFY3vWq6GtrtsuxAe1QoTedfaRxvZCjply0bo0
         BtA+BRSsnGHW7Vw3v3mOsg+IOwtNANe30ckcBGuVi1PsQ/ioDimwB3w7q9ljRCOBjejq
         mF+FGSTAgplVw4zumb1Lu1qFZFUxiVWAvYwbP8fmrkgeS15wgbQ5xsnF6n9+Ipk6GRBq
         mGiKpNoe++TsTfpULeteQFkNP1mn/Hb4cb9ZBdkUt947hlZWeczOWva3jouaqLHGyT9E
         44cdFqevcEv4JZqL0ZHbedqZ6RIfDgh3swYKU+KQjkgkPo+6wCfU9tNuLitVyzMCjKcv
         OcDQ==
X-Gm-Message-State: AOAM530MeOjFhQDNYfJswXfZrTuMw9cq5F+mPA8mL5gyYHV7bFBvy16U
        jDVFt0+XsVsEDHd5QrXKO2fyb+TWyw4RYz7oRKpuHQ==
X-Google-Smtp-Source: ABdhPJweVIVh/bwUjwQHJzlpZD/71O08fS140+bfO64b8oKxkwUwNSvIbfpZTktmAeDoC5XQFCiUH4v/a/675Cw+Vlo=
X-Received: by 2002:a0d:cac2:0:b0:2db:fc7f:7dfa with SMTP id
 m185-20020a0dcac2000000b002dbfc7f7dfamr16012861ywd.362.1646807863492; Tue, 08
 Mar 2022 22:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20220309014705.1265861-1-liupeng256@huawei.com>
 <20220309014705.1265861-3-liupeng256@huawei.com> <CANpmjNOU+M1ZaRTMPMCFE7pm8JXLKsWcMpMAsDmJXZUga3N7=A@mail.gmail.com>
 <0423ef8e-bfd0-3a4b-78a5-17dc621660d2@huawei.com>
In-Reply-To: <0423ef8e-bfd0-3a4b-78a5-17dc621660d2@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 07:37:06 +0100
Message-ID: <CANpmjNNQtODYy7wBuLAOm2GaHNGB10LP=X=xp04DCNiY+KM8ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: make kunit_test_timeout compatible with comment
To:     "liupeng (DM)" <liupeng256@huawei.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 9 Mar 2022 at 07:32, liupeng (DM) <liupeng256@huawei.com> wrote:
>
> Thank you for your advice.
>
> On 2022/3/9 14:03, Marco Elver wrote:
> > On Wed, 9 Mar 2022 at 02:29, 'Peng Liu' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> >> In function kunit_test_timeout, it is declared "300 * MSEC_PER_SEC"
> >> represent 5min. However, it is wrong when dealing with arm64 whose
> >> default HZ = 250, or some other situations. Use msecs_to_jiffies to
> >> fix this, and kunit_test_timeout will work as desired.
> >>
> >> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> > Does this need a:
> >
> > Fixes: 5f3e06208920 ("kunit: test: add support for test abort")
> >
> > ?
>
> Yes, I will add this description.
>
> >> ---
> >>   lib/kunit/try-catch.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> >> index 6b3d4db94077..f7825991d576 100644
> >> --- a/lib/kunit/try-catch.c
> >> +++ b/lib/kunit/try-catch.c
> >> @@ -52,7 +52,7 @@ static unsigned long kunit_test_timeout(void)
> >>           * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
> >>           * the task will be killed and an oops generated.
> >>           */
> >> -       return 300 * MSEC_PER_SEC; /* 5 min */
> >> +       return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
> > Why not just "300 * HZ" ?
>
> Because I have seen patch
>
> df3c30f6e904 ("staging: lustre: replace direct HZ access with kernel APIs").
>
> Here, both "msecs_to_jiffies(MSEC_PER_SEC)" and "300 * HZ" is ok for me.

I see - let's keep as-is and use msecs_to_jiffies().

Thanks,
-- Marco
