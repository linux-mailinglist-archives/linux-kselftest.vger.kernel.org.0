Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0156E51E18D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444672AbiEFWJl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355054AbiEFWJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 18:09:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6027CC9
        for <linux-kselftest@vger.kernel.org>; Fri,  6 May 2022 15:05:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y32so14730055lfa.6
        for <linux-kselftest@vger.kernel.org>; Fri, 06 May 2022 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I8c/3sjcv2rRvb+sL+FxHH9fs1JGy16b0GIZuP3wpc=;
        b=XnMeCJGqpk0Xpw7/SSxwqELTSfonBs9GyEpYKwzeDgLkw0ssNvrbW5lXfRwA4h+XkZ
         aPBG8ba4rQP3w6GzY97RHdV6yNRfl+f/CzckKgGus4/zoCTq8RkcG9qCi7Ui+byiaUp7
         Xrc+89nAjoRc26ApOtqjJs6z1h9auoFak1d7CeKJLxyGjLdnrIo4OV9/g+bww2LeOqS9
         bGCm9cKTTzL47dMZhLAk7UhUAAtH60n5reuIQroav25e2qCglm187D944ZFU1VumOrsx
         jB4cWLLhGnYt2GMgaIr0e/7BReBftRMR210xKANamzjyW68szHMRt+ACrO0HnMFr3j1C
         v3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I8c/3sjcv2rRvb+sL+FxHH9fs1JGy16b0GIZuP3wpc=;
        b=E/gxvtzGkaEhyQSAMsWq/nxRjfUqxR3lQmRyunREKcL4JFOVn+MojmphwWiYbZEmai
         JE/kACvm/5FR0sEDGpRop++QQ36ras78CGY401fXYAB49XIEmeknnSrxf9i8ViQdfvnn
         KzNKj38bMAZXsRIck4PXCEQRRLyXEAflDG5DR7DpyE6neJfjD3imkbkVeJPW/XRe49nk
         THPsfW5Woc/XGu8is2L+q/mdnEVtjBKKrWzOPYOkozpJV74UbeDhRYJpCLkhVr0jUdnb
         1/B63RsRA+iHerwfukrI7PlCZfZherDgTd6LCNsLevydkKvqRFu6EI6ehL2E3ayP7BBd
         h4oQ==
X-Gm-Message-State: AOAM533Ae8rNqDeauvYMB9xLU1oQC6ssITwupEBTMM2HtQroChqsXkfG
        +nP6SPHCdvScQWG6uw2i1uZiB7RuO0Eri4xCyGh9Lg==
X-Google-Smtp-Source: ABdhPJxmVhZJlQifLIRkvtG0fE2FauaNFoDOamiDV2heBOr2VXuNiyZh26eJx3wqfXD7spbHZplF8886mVdeS23Z3O8=
X-Received: by 2002:a05:6512:3b87:b0:473:9e36:5f0d with SMTP id
 g7-20020a0565123b8700b004739e365f0dmr3936219lfv.424.1651874753928; Fri, 06
 May 2022 15:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com> <20220429235644.697372-4-cmllamas@google.com>
In-Reply-To: <20220429235644.697372-4-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 6 May 2022 15:05:42 -0700
Message-ID: <CAHRSSEynz6S-XPPrY92TewdVGW+rJ1=mHmHNMhb+aNrHtgM7Rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] binderfs: add extended_error feature entry
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
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

On Fri, Apr 29, 2022 at 4:57 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Add extended_error to the binderfs feature list, to help userspace
> determine whether the BINDER_GET_EXTENDED_ERROR ioctl is supported by
> the binder driver.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binderfs.c                                | 8 ++++++++
>  .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index e3605cdd4335..6c5e94f6cb3a 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -60,6 +60,7 @@ enum binderfs_stats_mode {
>
>  struct binder_features {
>         bool oneway_spam_detection;
> +       bool extended_error;
>  };
>
>  static const struct constant_table binderfs_param_stats[] = {
> @@ -75,6 +76,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
>
>  static struct binder_features binder_features = {
>         .oneway_spam_detection = true,
> +       .extended_error = true,
>  };
>
>  static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
> @@ -615,6 +617,12 @@ static int init_binder_features(struct super_block *sb)
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> +       dentry = binderfs_create_file(dir, "extended_error",
> +                                     &binder_features_fops,
> +                                     &binder_features.extended_error);
> +       if (IS_ERR(dentry))
> +               return PTR_ERR(dentry);
> +
>         return 0;
>  }
>
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 0315955ff0f4..9409bb136d95 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -64,6 +64,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
>                 device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
>         static const char * const binder_features[] = {
>                 "oneway_spam_detection",
> +               "extended_error",
>         };
>
>         change_mountns(_metadata);
> --
> 2.36.0.464.gb9c8b46e94-goog
>
