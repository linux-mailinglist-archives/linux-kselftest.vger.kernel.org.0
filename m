Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58AF77D186
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbjHOSJx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjHOSJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:09:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AA106;
        Tue, 15 Aug 2023 11:09:22 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-349a1cf0ae2so20195865ab.0;
        Tue, 15 Aug 2023 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122961; x=1692727761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUTkeUiSYRZcU5Me9frBPWYrk1Agc7yrnJKvjQH2y5Q=;
        b=Zb+6EOo/4l+LM3Rgdm5UnqxiYtIKLc4eLXK0xtkAfRymYk+ayEIMX2a4iFza6uZ6bO
         vJN08JYjKNO/3sObQjkcgaqrfYLJy1Q0ql3b5aUoZpOm79Yox3mKopZ4FAQVQbyGwwMv
         /ZqiylRBt7Ei09ppRWQFP5jeirjV7pbwjK4n9aHc8tMR6keCKVWFg2xVDWPXu8aOByr1
         aPPmjTZyiIBKgIWyP/KnjJpNkLOmtKIuOwFNAU2keqoc/xGemIJ7qpxifExdEtE6omE8
         wn5NTBnsYgglIudV7tazHlfaJnshUCITxp0VxlZLx4kHcd1ta6ecv9z7Qz0avqcQQ2fG
         DIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122961; x=1692727761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUTkeUiSYRZcU5Me9frBPWYrk1Agc7yrnJKvjQH2y5Q=;
        b=A4QooDzcR6MhotUtPXzEfIugom0nLrDO6JgDLqWerCGuNKpluTbDXaNHulazEwxRrB
         ++nWovMtyWZuzJh3C75j5pnP7xHwmJXZinEU+MY3dSjpF7Xz1rTmyKoQDJoldF0mn+FC
         vc0jxGhCZJDhujOUMWjdpvDN5jAzeRncrTDShgw7FlCCs4m+7m5k7APpejUzckExKYNy
         psK6oYDYCweGc1iDBKIjGFp71kf3zR6L9pPFief55LFe+M3dUG8u3c4IGf41MzJM+Zhc
         zN5ps4aiL0h3UOfYOP6nGUl3uCOoAvAIefw7q8UaEwCOXUD2c5PNGDK6CMpORyd7nDxz
         eGhg==
X-Gm-Message-State: AOJu0YwTxFNkykqAX2n7mc3C/5q+eRtN5CGtKNPdXmPtQ/+ADwjbY628
        SPpBp1te/0/rq2Gwq7lLO0MYp4aWtOCgLo1Ixr4=
X-Google-Smtp-Source: AGHT+IGRTQYv7CsT8Fs4KvCqDa1g2VSZFmEY69btb4LNTnIZwsRQ6OArrN7wFiNo3ssygDBmv/toau7cbyVLZ5QITEs=
X-Received: by 2002:a05:6e02:ecc:b0:34a:9120:d7a with SMTP id
 i12-20020a056e020ecc00b0034a91200d7amr11414230ilk.26.1692122961590; Tue, 15
 Aug 2023 11:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230815155612.2535947-1-andre.przywara@arm.com> <20230815155612.2535947-3-andre.przywara@arm.com>
In-Reply-To: <20230815155612.2535947-3-andre.przywara@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 15 Aug 2023 11:09:10 -0700
Message-ID: <CAKEwX=Pr37R839NP1BQ2sO_x=fDER8KhYvcLvCNGJRZrKd9EUg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests: cachestat: use proper syscall number macro
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
> At the moment the cachestat syscall number is hard coded into the test
> source code.
> Remove that and replace it with the proper __NR_cachestat macro.
> That ensures compatibility should other architectures pick a different
> number.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  tools/testing/selftests/cachestat/test_cachestat.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 54d09b820ed4b..a5a4ac8dcb76c 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -19,7 +19,6 @@ static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
>         "/proc/version", "/proc"
>  };
> -static const int cachestat_nr =3D 451;
>
>  void print_cachestat(struct cachestat *cs)
>  {
> @@ -126,7 +125,7 @@ bool test_cachestat(const char *filename, bool write_=
random, bool create,
>                 }
>         }
>
> -       syscall_ret =3D syscall(cachestat_nr, fd, &cs_range, &cs, 0);
> +       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>
>         ksft_print_msg("Cachestat call returned %ld\n", syscall_ret);
>
> @@ -152,7 +151,7 @@ bool test_cachestat(const char *filename, bool write_=
random, bool create,
>                         ksft_print_msg("fsync fails.\n");
>                         ret =3D false;
>                 } else {
> -                       syscall_ret =3D syscall(cachestat_nr, fd, &cs_ran=
ge, &cs, 0);
> +                       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_r=
ange, &cs, 0);
>
>                         ksft_print_msg("Cachestat call (after fsync) retu=
rned %ld\n",
>                                 syscall_ret);
> @@ -213,7 +212,7 @@ bool test_cachestat_shmem(void)
>                 goto close_fd;
>         }
>
> -       syscall_ret =3D syscall(cachestat_nr, fd, &cs_range, &cs, 0);
> +       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>
>         if (syscall_ret) {
>                 ksft_print_msg("Cachestat returned non-zero.\n");
> --
> 2.25.1
>

Oops something I forgot to fix. Thanks, Andre!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
