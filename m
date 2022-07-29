Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B71584BDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiG2GaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiG2GaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 02:30:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BAF08
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:30:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso4347160pjd.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANvlGc2tcOj/ARFqImFQ7yhjDB+jN4jIvGcrZLLwcsQ=;
        b=aPKEHipM7DtWpVKB58Rt3XGgq25g2noB1E3l7y0ngybKMOHr/cl17p9ZQ4Y1yuuVWZ
         apvQwO/m1Dmk3w1elRpGKCyovPMyuVzKF3bxDk+ujXS87fkCAt8vjjHTimb2STrlMka6
         Soo7XFEvstbvxJ5Swy+xQtPgRegNCUzSUzsNTYXTGbSqG33ZbtAtv06KMmfgxTSOk6Zi
         vzdwZ0C/MfVLva9v/5k7oSY/q0omGHrBzifiGMkPRV8/Ld+oOhqHPrmF2SADWY1I4cdW
         w/gu2nVBzyQPZv72y6IhxyWR7ok09QCeErDsEoIJ6REpD/SX4Xkx33xuwdZqHTNtVXFw
         Rp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANvlGc2tcOj/ARFqImFQ7yhjDB+jN4jIvGcrZLLwcsQ=;
        b=Ipr7LTfadn3bQw3BGSNoURo39aV20kzfQV/eI7s4OC0YD9+A/seR9t20s2fVoE7Sm5
         BakS5EuTZ/hF0GWqPaLVsWy4Ex7MS6sSlC3U35qbmloh6efY16zboVeCSy7FHjizAxwp
         TtRZwR66hrd9SCjNQAsgCzT2SeCINBL61dadA0dX/0PX7UiXeqoi++wNKbt4+ovVhTPL
         HzjesdShNIpixIOkEUDui5C4A5NKDpG7kMPejOfMtKLKDW2xZXjTjir+k54CqHJqiYvc
         gDYe92OwAYcddSfIHEpn3V9NnFBn/X1JZGC5dctM1e/FbUBBGrvqp9O/JJrLmcRnzX9K
         c9aA==
X-Gm-Message-State: ACgBeo1iZIndT4NujPgGDbA7RIdnWdAyHRKX2I2fNHk71P42z7UYvLrO
        qSfd1RHwmVnFqFv1wYsDPdJ48f6Fif7O67N4dnLBEHlzvHmcAA==
X-Google-Smtp-Source: AA6agR4qr7ol8vLKsJJGTkBvZ/GDFcU29Uy3w2bTmKEQI6ogifuBJE6+Cx5lCQRBjHyPEKDkjU0vDVnYKILAqpCizoE=
X-Received: by 2002:a17:903:32c6:b0:16d:328f:898d with SMTP id
 i6-20020a17090332c600b0016d328f898dmr2323434plr.143.1659076216913; Thu, 28
 Jul 2022 23:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org>
 <20220729061504.744140-1-jeffxu@google.com> <20220729061504.744140-2-jeffxu@google.com>
In-Reply-To: <20220729061504.744140-2-jeffxu@google.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 28 Jul 2022 23:29:40 -0700
Message-ID: <CALmYWFtMBF1q+9ZV2VEuo-+PQ8DEfL9ywnbyML3+SLoN7LMQZA@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/memfd: add tests for MFD_NOEXEC
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

> > + /* Create with NOEXEC and ALLOW_SEALING */
> > + fd = mfd_assert_new("kern_memfd_noexec",
> > +    mfd_def_size,
> > +    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);


> Don't we need to check fd here?


mfd_assert_new will abort() if fd is not valid, so we don't check fd here.

Jeff


On Thu, Jul 28, 2022 at 11:15 PM Jeff Xu <jeffxu@google.com> wrote:
>
> From: Daniel Verkamp <dverkamp@chromium.org>
>
> Tests that ensure MFD_NOEXEC memfds have the appropriate mode bits and
> cannot be chmod-ed into being executable.
>
> Co-developed-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 1d7e7b36bbdd..4906f778564e 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -36,6 +36,10 @@
>  #define MAX_PATH 256
>  #endif
>
> +#ifndef MFD_NOEXEC
> +#define MFD_NOEXEC     0x0008U
> +#endif
> +
>  /*
>   * Default is not to test hugetlbfs
>   */
> @@ -1006,6 +1010,35 @@ static void test_seal_exec(void)
>         close(fd);
>  }
>
> +/*
> + * Test memfd_create with MFD_NOEXEC flag
> + * Test that MFD_NOEXEC applies F_SEAL_EXEC and prevents change of exec bits
> + */
> +static void test_noexec(void)
> +{
> +       int fd;
> +
> +       printf("%s NOEXEC\n", memfd_str);
> +
> +       /* Create with NOEXEC and ALLOW_SEALING */
> +       fd = mfd_assert_new("kern_memfd_noexec",
> +                           mfd_def_size,
> +                           MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);
> +       mfd_assert_mode(fd, 0666);
> +       mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +       mfd_fail_chmod(fd, 0777);
> +       close(fd);
> +
> +       /* Create with NOEXEC but without ALLOW_SEALING */
> +       fd = mfd_assert_new("kern_memfd_noexec",
> +                           mfd_def_size,
> +                           MFD_CLOEXEC | MFD_NOEXEC);
> +       mfd_assert_mode(fd, 0666);
> +       mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
> +       mfd_fail_chmod(fd, 0777);
> +       close(fd);
> +}
> +
>  /*
>   * Test sharing via dup()
>   * Test that seals are shared between dupped FDs and they're all equal.
> @@ -1179,6 +1212,7 @@ int main(int argc, char **argv)
>
>         test_create();
>         test_basic();
> +       test_noexec();
>
>         test_seal_write();
>         test_seal_future_write();
> --
> 2.37.1.455.g008518b4e5-goog
>
