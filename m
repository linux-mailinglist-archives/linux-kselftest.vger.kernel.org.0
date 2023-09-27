Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF787B0D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjI0UqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI0UqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 16:46:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CE122
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 13:46:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053f24c900so11715e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695847569; x=1696452369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiWv8zF03DQVTTRi4wE0QRJ+TeCqVzE2qQ9Nguz4Rx0=;
        b=nHwkXiVts9TyH0GlK8Y/09+6sz1GexZVW6cizDexxhd8PnZI5JdG2PWIoqQvhi1V9D
         Ph88qt1ahrATqtBXyDMPAIaqgRIOGPyZt2GUvY7JjQyH/rGz2uZ20+/QovWo8YmbmmnY
         aBQmO+IxpKp5x55VPfWybG/xeksDRkDvvdxjbh5CXDSgIHqkgAArcqYi8rTaRQcCCUFT
         CkBxDU137sZvWurP7F7+KK+DPt+s3YsYjJmq5oC7yib1XTAeF18lVQRZeprPi2aYjx0F
         MD79gsnOLT9xkHfW9E7V0HV+AOYByWyGDFknePeRi6jQ5czQ6gCAk7nuoJTOkYaP8ER6
         nCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847569; x=1696452369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiWv8zF03DQVTTRi4wE0QRJ+TeCqVzE2qQ9Nguz4Rx0=;
        b=LfWWgpFsen94akmGkmGujceOWsGUQF+sCnRVdPu+Wb76kRd51JNU14zWQDCRsGZOl6
         jchQsWfHFLqY1JmOLOIyhOx4iN+71Ax5d32mdoNzXze/g91ysh0jZYWIEC8JZ/4kcFux
         JQTnIIqmmW8H4TBfdAcMtZlqpG62wKADLr8Zbm5Eni9XxM1GhUsZXQgzhaFydsadFFca
         TeZjwbHIo1gOOSFtYBM5GpfUU3AGHigX4aclz2X5NOKPP+mzfpp6ks79Xoh9f8iNDeFn
         zqcMouhd0mnqSHf2Cy0HA/YNUvEnJZ8sLZTQ26wE8KfTZs5x9iGBroucvb749IRad/nK
         fUYg==
X-Gm-Message-State: AOJu0Yz5EhQEeU0viWHyc60kyhKr/PGNxwIMvS+pWzhGtEbkGKlfobje
        Wc7+h8wFD1qby0C5CfaGrRd8fw5e2THgn1nP0Mw6YQ==
X-Google-Smtp-Source: AGHT+IHruQy5cdas8SjBkxKLT3MeHevaL7Rji2zWlQjZNute8nnAiRLP7qehqyrprjOZMwxahWBZR26kdSaGYdeYMmA=
X-Received: by 2002:a05:600c:1d9d:b0:3f6:f4b:d4a6 with SMTP id
 p29-20020a05600c1d9d00b003f60f4bd4a6mr252199wms.7.1695847569143; Wed, 27 Sep
 2023 13:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230927165058.29484-1-rf@opensource.cirrus.com>
In-Reply-To: <20230927165058.29484-1-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 27 Sep 2023 16:45:57 -0400
Message-ID: <CA+GJov5BP7O6RYWrvqFuFpH9dUevwBRrEEX6Hs3vri+NSwGK_A@mail.gmail.com>
Subject: Re: [PATCH] kunit: debugfs: Handle errors from alloc_string_stream()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 12:51=E2=80=AFPM 'Richard Fitzgerald' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> In kunit_debugfs_create_suite() give up and skip creating the debugfs
> file if any of the alloc_string_stream() calls return an error or NULL.
> Only put a value in the log pointer of kunit_suite and kunit_test if it
> is a valid pointer to a log.
>
> This prevents the potential invalid dereference reported by smatch:
>
>  lib/kunit/debugfs.c:115 kunit_debugfs_create_suite() error: 'suite->log'
>         dereferencing possible ERR_PTR()
>  lib/kunit/debugfs.c:119 kunit_debugfs_create_suite() error: 'test_case->=
log'
>         dereferencing possible ERR_PTR()
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")

Hi!

I've tested this and this all looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
Rae

> ---
>  lib/kunit/debugfs.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 270d185737e6..73075ca6e88c 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -109,14 +109,27 @@ static const struct file_operations debugfs_results=
_fops =3D {
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         struct kunit_case *test_case;
> +       struct string_stream *stream;
>
> -       /* Allocate logs before creating debugfs representation. */
> -       suite->log =3D alloc_string_stream(GFP_KERNEL);
> -       string_stream_set_append_newlines(suite->log, true);
> +       /*
> +        * Allocate logs before creating debugfs representation.
> +        * The log pointer must be NULL if there isn't a log so only
> +        * set it if the log stream was created successfully.
> +        */
> +       stream =3D alloc_string_stream(GFP_KERNEL);
> +       if (IS_ERR_OR_NULL(stream))
> +               goto err;
> +
> +       string_stream_set_append_newlines(stream, true);
> +       suite->log =3D stream;
>
>         kunit_suite_for_each_test_case(suite, test_case) {
> -               test_case->log =3D alloc_string_stream(GFP_KERNEL);
> -               string_stream_set_append_newlines(test_case->log, true);
> +               stream =3D alloc_string_stream(GFP_KERNEL);
> +               if (IS_ERR_OR_NULL(stream))
> +                       goto err;
> +
> +               string_stream_set_append_newlines(stream, true);
> +               test_case->log =3D stream;
>         }
>
>         suite->debugfs =3D debugfs_create_dir(suite->name, debugfs_rootdi=
r);
> @@ -124,6 +137,12 @@ void kunit_debugfs_create_suite(struct kunit_suite *=
suite)
>         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>                             suite->debugfs,
>                             suite, &debugfs_results_fops);
> +       return;
> +
> +err:
> +       string_stream_destroy(suite->log);
> +       kunit_suite_for_each_test_case(suite, test_case)
> +               string_stream_destroy(test_case->log);
>  }
>
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230927165058.29484-1-rf%40opensource.cirrus.com.
