Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF9B78F455
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjHaVBd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHaVBc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:01:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD690C0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 14:01:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso915e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693515688; x=1694120488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slky7vuIuAflk+z++waQUpLjNigpLDKO4kVSm5QfF7E=;
        b=mNSScD8fx6rJ876CxSyU+F0amtBD5102lWx3Q2BRtL7e7MGYNxVyv3aCZe7NixgyiL
         bqdYF9FbJXD/+kbojHMW762h19knPbV2EH2gMRDK9M99d6in73bZmwvCd9z6VJelWrwX
         H11ntdrsTlF1yQbQTdmgSm4pjPKS0buuwxou2qmb9IJ0iRX8tOf7fSlT5xrSPWtQRiZI
         u+AUCLUXp2h2f5mz9Vtl+vjg8F9SeVj8K30HXfIM7WB8Wamu4qJ/6hDdOrJ6uhz2/b4e
         sJVKlaQBrIVbioZjLWqzEZk+cne40eKd+bNM8xnWHcOXWXG1pnot+RIUiOYCGonf+B/3
         o5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515688; x=1694120488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slky7vuIuAflk+z++waQUpLjNigpLDKO4kVSm5QfF7E=;
        b=hxviwjpXlF5KjCg9wVr26GxW/lTtGAN9LZi0HHSSNppGCxM7KA04wGolTAZAENqwPy
         GbjEWUq3GjExQM/+WSES4UJB2zK/cxCI74iQ8GlrmgWinPHSoFUdp6D/8QctEA686WzY
         tyXxhI7bj6Qr8LD8DflFqtokmhPvHJ0ZB2cl+pAMYT7Q81CrQL4e1/ZsDsFdAT6lvIBw
         WEYn61n03RScE2bbXbUzXWP1pZR/K/ChT1bPhcFEASheCYXd2Hwli0LjHdDqHiPYCAGW
         JflvaMiGhpGGILphOq4B3boCNIO3cmPJDr82qjeXHmIeukaYAW1DQgqPTmDhbqDsVx2B
         rHNg==
X-Gm-Message-State: AOJu0YyepaRLYFgADTIaW+wosYJlBvYaEvT6XB3Z/0SLDoYhuJhUXco+
        9zH9gFbBni7RsoM/hxoAXD34O3vfZtEA40iKTcW5fK+xAL4ZyZFT4+gbIP7e
X-Google-Smtp-Source: AGHT+IFmvrUz4c+FDX+0PnSrmEFgw+/mqliPfR6a5qXTN50W288atmoarb9N9KTjV2boTZxZZPPT7F4hQqwBhzY4bic=
X-Received: by 2002:a05:600c:1e06:b0:401:a494:2bbb with SMTP id
 ay6-20020a05600c1e0600b00401a4942bbbmr13534wmb.5.1693515688225; Thu, 31 Aug
 2023 14:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-4-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-4-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 31 Aug 2023 17:01:13 -0400
Message-ID: <CA+GJov5hZ_ZHZbDHXhSwMAhjos2u-sjY6J6MkWmq4kLtg9Vzjg@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, jk@codeconstruct.com.au,
        dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 31, 2023 at 3:17=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If both filter_glob and filters are not NULL, and kunit_parse_glob_filter=
()
> succeed, but kcalloc parsed_filters fails, the suite_glob and test_glob o=
f
> parsed kzalloc in kunit_parse_glob_filter() will be leaked.
>
> Fixes: 1c9fd080dffe ("kunit: fix uninitialized variables bug in attribute=
s filtering")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

Thanks for catching this! I just had two concerns listed below.

-Rae

> ---
>  lib/kunit/executor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 25ce8d6e5fe7..7654c09c1ab1 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -176,10 +176,8 @@ kunit_filter_suites(const struct kunit_suite_set *su=
ite_set,
>         if (filters) {
>                 filter_count =3D kunit_get_filter_count(filters);
>                 parsed_filters =3D kcalloc(filter_count, sizeof(*parsed_f=
ilters), GFP_KERNEL);
> -               if (!parsed_filters) {
> -                       kfree(copy);
> -                       return filtered;
> -               }
> +               if (!parsed_filters)
> +                       goto err;

When this goes to the "err" label this will likely enter the if
(filter_count) statement and attempt to free parsed_filters. Since
parsed_filters is NULL in this case, it could be a cleaner practice to
set a new label, maybe "filter_err", to skip over that if statement.
Although, I realize this may require the order of the patches to
switch.

Additionally, the value of *err should definitely be set here before
"goto err". The kunit_run_all_tests() function checks this err value
in order to produce the correct error message and to prevent any
attempt to run tests. I would suggest: *err =3D -ENOMEM;

>                 for (j =3D 0; j < filter_count; j++)
>                         parsed_filters[j] =3D kunit_next_attr_filter(&fil=
ters, err);
>                 if (*err)
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230831071655.2907683-4-ruanjinjie%40huawei.com.
