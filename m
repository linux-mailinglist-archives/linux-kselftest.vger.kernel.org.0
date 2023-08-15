Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1D77D6A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 01:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHOX0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 19:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjHOX0H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 19:26:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989010F0;
        Tue, 15 Aug 2023 16:26:06 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34992058e95so24926645ab.1;
        Tue, 15 Aug 2023 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692141966; x=1692746766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuFOXmtSNny9sLwdulB8nAUmEQZyFm5IBCtyhhdlg5o=;
        b=jqvg+OKU+BdVajqZOkReX1+RHnXR+7InhHkL9knqU8H+lVM7RvKDa0TlQ8r601XW5I
         CIUrbY6VfQbRzLZ9Y3QYE3j5J3cBRALQFFk8XAGUl+Y3VvQqsahzwmSzQ+TqYi1gOojd
         Ss0dSqXBSABfMwAw9jgaGR7GIhYxwz1quyTMTTbScu4cmanMO/02pMSxAACh5idnHyHa
         TLtscM2wLm29gPRZo2crI3qkhI3hboBUsoDgMfx1n1oE3PQi8YZPpPUSu4GiCmCZVuoq
         lBHipjBXNFOaALK+fu2yPwwelGsgYdTxKKw+1FtGi/bDfic77M9vQUzU721TkMmK+Cpo
         dyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692141966; x=1692746766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuFOXmtSNny9sLwdulB8nAUmEQZyFm5IBCtyhhdlg5o=;
        b=ZDj/SMQW6BUX82wWaegzxzD+MBkKOxyZRnekjN5HVEEoPwMuqspqOBQYOqAMVjA9kW
         AlKR+KLGIAObe3qfJcszZckwMiGyCjuYx8QBfXED64S1LSWRHyqi7uLbBYcAtDqwckZ+
         tmiUYHqDnTWqR8zo91fpCobVCe73C52Vc/s686VOXAagUqslbdL2iImgZXugej5qvPd6
         S3E3j1J7tI+DFPZCo5sc5H9Bs4sWvq7pb6+rx/Ji/jGaR+5Up0U3CoECRBiIkzTRu0X9
         lad9yc3kLNB8H7cg+FvbjL7bEwAmOxD/vZHZim0cny3y2kewjJC0ENQ71TycnqPGLBQU
         YCqQ==
X-Gm-Message-State: AOJu0YwKvNdNNInAnbQxviXQs5OukFF4M37FR7poee8e941PonvKErzX
        CSSfZilnvMZ6j7Hijp3OAM11/stOs3ZNP1IaQkxpAPyr6FEz/g==
X-Google-Smtp-Source: AGHT+IH8BU95JCOFeRU6qCQ9pPnR0FH1UKm37FfLUUA0ybas4MbPzgqExxhQqNeCSW7tJt8xpgtaVNsczjD1HmMaGBM=
X-Received: by 2002:a05:6e02:f45:b0:349:77c7:2ab4 with SMTP id
 y5-20020a056e020f4500b0034977c72ab4mr496504ilj.30.1692141965799; Tue, 15 Aug
 2023 16:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230815155612.2535947-1-andre.przywara@arm.com> <20230815155612.2535947-4-andre.przywara@arm.com>
In-Reply-To: <20230815155612.2535947-4-andre.przywara@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 15 Aug 2023 16:25:54 -0700
Message-ID: <CAKEwX=NvBCiy6WxJWg9EYyTwKTQY35G6=3T2L8KKEe46xg82rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: cachestat: test for cachestat availability
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 8:56=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> As cachestat is a new syscall, it won't be available on older kernels,
> for instance those running on a build machine. In this case, a run
> reports all tests as "not ok" at the moment.
Interesting - I was under the assumption that if you backported the
selftests for cachestat, you would also backport the syscall's implementati=
on
and wiring.

But yeah, I guess if you build with !CONFIG_CACHESTAT_SYSCALL,
these tests would fail.
>
> Test for the cachestat syscall availability first, before doing further
> tests, and bail out early with a TAP SKIP comment.
>
> This also uses the opportunity to add the proper TAP headers, and add
> one check for the syscall error handling (illegal file descriptor).
Thanks for the addition!
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index a5a4ac8dcb76c..77620e7ecf562 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -15,6 +15,8 @@
>
>  #include "../kselftest.h"
>
> +#define NR_TESTS       8
> +
>  static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
>         "/proc/version", "/proc"
> @@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
>
>  int main(void)
>  {
> -       int ret =3D 0;
> +       int ret;
> +
> +       ksft_print_header();
> +
> +       ret =3D syscall(__NR_cachestat, -1, NULL, NULL, 0);
> +       if (ret =3D=3D -1 && errno =3D=3D ENOSYS) {
nit: if (ret && errno =3D=3D ENOSYS) sounds cleaner, but up to you.
> +               printf("1..0 # Skipped: cachestat syscall not available\n=
");
nit: perhaps ksft_print_msg()?
> +               return KSFT_SKIP;
> +       }
> +
> +       ksft_set_plan(NR_TESTS);
> +
> +       if (ret =3D=3D -1 && errno =3D=3D EBADF) {
> +               ksft_test_result_pass("bad file descriptor recognized\n")=
;
> +               ret =3D 0;
> +       } else {
> +               ksft_test_result_fail("bad file descriptor ignored\n");
> +               ret =3D 1;
> +       }
Nice!
>
>         for (int i =3D 0; i < 5; i++) {
>                 const char *dev_filename =3D dev_files[i];
> --
> 2.25.1
>
Nitpicking aside:
Acked-by: Nhat Pham <nphamcs@gmail.com>
