Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535555A79E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 09:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiFYHBz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiFYHBy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 03:01:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF83B3DD
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jun 2022 00:01:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so2635900wms.3
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jun 2022 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIzeczDw2HvlDp1in7hfvtjJE68cxyFabNgETqBrjSY=;
        b=VylczFOBbptMSiVzl7Unj/HgXYpOmX4X+cLiLsNknVs4rLzN/kU7WfuubVyTHUkl2e
         MCx21RS9GsfbSscOWyR/m0G+IJmSjVEEG8KoYAKyG+BRZ1NNn2O3orxga+MMHre9qtS1
         d4FTBvw0JD9+nn8ehMJ9gCAKYWhxv2PiYzSl77z4yP89/OCYiwQ/2lhkUHTyOl76muU6
         5pVJNQnAI+7y3oKVIh/3sgEMkx5qnW61XK9zMs/fWhEblFC6WmMqlu2S3r18ZNG2ynWD
         BImErw14Adb97J3EhQKMn9FW2m2jCoU8VuDnNeUv0OQqc86ySVr1fVvloepdBG/rUnm2
         7NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIzeczDw2HvlDp1in7hfvtjJE68cxyFabNgETqBrjSY=;
        b=DTmGbtmceHVgbEmh/UBw1aWnTrOXm7Noxj0Hul1ArzeLljfKHu/S2lqItVlUaA4k8B
         1SXPG0MmQRU0jjJ/RA+9pLFpZK9SgPc8L5x2YTONOpIm8TzkCHwgSibPG96MYU7UyaCW
         HMzpG9+V3YRo+sKmcNmMkeJvRwL6o9xfPhk4Dw2JRL4OqTElGQXUH+J2rknqAtKNWbWh
         zC2Wtnn4qAPtmBqnUB/UbrO7qAapLp+9BBqW5bAjecKVxj1vHAmqwYCYgnIIi8LGMpZz
         XHacSRpLKRBmYaaNRz3mcT5smoi4wuA/cU6VNUtWBTGV8m47jWHAFbCh0ekUNNDrrzEc
         +Zyw==
X-Gm-Message-State: AJIora/dy7f/hoYarEGhZnqL0BBWRvFnuUWYEU2kSv+oekqrjmDVbs8z
        gAVYbUKEr/wlq33Zzxzh1AMlyeuX6DqCjLgwIZbNnQ==
X-Google-Smtp-Source: AGRyM1sCZ2q61qZAr4YPDz2NLd9Jztv8w7KFU0MBQYhc4ZGZTD8bDlAaUGV+j5Rfp9P89xTWY+F62rLXnINfik05az8=
X-Received: by 2002:a05:600c:34ce:b0:3a0:3b4b:9022 with SMTP id
 d14-20020a05600c34ce00b003a03b4b9022mr3055176wmq.66.1656140512499; Sat, 25
 Jun 2022 00:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220520224200.3764027-1-dlatypov@google.com> <CABVgOSkNpaY1HsygqkWC8LVO+XTqGwNxFNgne-ajoTiPqCnrkg@mail.gmail.com>
 <CAGS_qxqQiWDRwOJcU+1X31SgdKGFMLT8tA7EJXN9JUmKOhYfxw@mail.gmail.com>
In-Reply-To: <CAGS_qxqQiWDRwOJcU+1X31SgdKGFMLT8tA7EJXN9JUmKOhYfxw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Jun 2022 15:01:41 +0800
Message-ID: <CABVgOSnKsto0xrVzgNMcDjL71w_=65EyzszVSsQCNCFTEjy0wA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: refactor internal kconfig handling, allow overriding
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Sat, Jun 25, 2022 at 4:24 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 12:55 AM David Gow <davidgow@google.com> wrote:
> > >
> > > +       def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
> > > +               return set(self._as_entries()) - set(other._as_entries())
> > > +
> >
> > It took me a couple of goes to realise that this was looking at the
> > difference between sets, not trying to set the difference. Maybe
> > different_entries() or something like that'd be clearer, but I can't
> > say it bothers me enough to be worth a new version.
>
> Wdyt about `set_difference()`?
> Or maybe adding a verb: `get_set_diff()`, `compute_set_diff()`?
>
> But we do want to make it clear it has set (asymmetric) difference
> semantics, see below.
>

I like adding a verb, personally.

> >
> > Then again (as noted below), the direct set difference isn't exactly
> > what we want, it's more the equivalent of is_subset_of(). The
> > follow-up repeated-kunitconfig patch adds differing_options(), which
> > is closer to what we'd want, I think:
> > https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/
>
> differing_options() does not have the right semantics.
> For this, we do explicitly want a set difference.
>
> Context: This is the func used to print out these warnings:
> $ .../kunit.py run --kconfig_add=CONFIG_PCI=y
> ...
> Missing: CONFIG_PCI=y
>
> That comes from
>   invalid = self._kconfig.set_diff(validated_kconfig)
> Using differing_options() to get our version of the configs:
>   invalid = (want for want, got in
> self._kconfig.differing_options(validated_kconfig))
> we instead get an empty list.
>
> The problem is that differing_options() only shows config options that
> are explicitly to different values.

Ah, yep: my mistake. I was mixing up the (!b && value=n) check in
is_subset_of with the (b && value != b) in differing options. Whoops.

But, thinking about it, the special handling of "=n" in set A not
needing an equivalent in set B should fall out from the set difference
anyway. So no problem here at all.

> There's probably a way I can name these functions better to make the
> difference more clear.

How about "conflicting_options" versus "missing_options"?

> Or perhaps we should move set_diff() out of this class and have
> kunit_kernel.py itself due the computation.
>
> E.g.
>   // make as_entries() "public", s/invalid/missing
>   missing = set(self._kconfig.as_entries()) - set(validated_config.as_entries())
>
> Thoughts?

Fair enough point:

>
> Daniel
