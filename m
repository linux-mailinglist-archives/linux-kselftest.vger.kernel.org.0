Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525275FEB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGXSET (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXSES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 14:04:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342C18D;
        Mon, 24 Jul 2023 11:04:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b8392076c9so65236011fa.1;
        Mon, 24 Jul 2023 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221855; x=1690826655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PMWehFMZvbk2xf8tY0y8u/pgKG1KcRSfvrbvLOT7Z4=;
        b=odRmqTs3LH+/X1SRqOKZRonsMr4xoVid28yxjd9SgkVuFAU/jW4ox/pkN85Ij8h9XI
         7XVza9c+4japLHxd5HRYDgOgCLI5pCk04S5W4RhksTDP2RgFQKQ7320qHlWHh0145wjo
         GzoDL4VZMgjJ+RGeVQbcjdqY87+IB2Ar1L2o87YwlR/7cbwBiJSrrg9llLl+0Pdq+2/r
         UwQ2nKQr5cyxqBVwYaCD4KUwXMJyPutsDuGFu29qkbktCwR9a54FK7vXzCi83i2UPNq0
         Tyc49T/BVusdUR8SZVpY4ZNGRZz7U68xWgSoobgvfHslVNqBjwgR7eZc/SkZNx15gILc
         ccNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221855; x=1690826655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PMWehFMZvbk2xf8tY0y8u/pgKG1KcRSfvrbvLOT7Z4=;
        b=MwIUaw5RoGp8qfJAz0HfFKgoF9ulT71fp6BbrbBgfMsiPXDSPIXqIbQ5avp2XOw1i0
         NHrk9u0rLTo4Gh+Z1h3AwQVMAEg8Q8ODsbqOz1mBMigNOeCpKoJgEI+3AiqmYuY1SyhP
         twKSFOKdPmE7yEabTybDKhoQ4xdlgdCbWliwUw6VMHTqWcw+GnrMx8wYliVZrW+KC4l3
         Da69vglhcovY6nBgjls7jsPtFM1KESJBDmdz4vb0F4zWqw5SbWe/uyCZVSdo3IY1SkPo
         1anNqlqfEkvf6+rBLyaPx4/r4Gfwa54WRyjMp6mqySomMwefgmOgWptun20iS5eNFC4y
         PNWg==
X-Gm-Message-State: ABy/qLYu3vpsNjKZ55pWcnzbqNywvTqU7kKZXVyXk7YUfUzJ1rzqgmuy
        n/E8smw8mcMpGDRVGjXMLFpaFyhc/wTDmO1yS90=
X-Google-Smtp-Source: APBJJlGpD8jSoPQKAMxYJ3oCKN4xLFvwl4+ahXeikaglH6MeZrL6kPt9e2V1d55IknUvqBC5UWa4Oj+J/uJsbzuYFEA=
X-Received: by 2002:a2e:808a:0:b0:2b3:4ea3:d020 with SMTP id
 i10-20020a2e808a000000b002b34ea3d020mr6539375ljg.17.1690221855066; Mon, 24
 Jul 2023 11:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230723093806.2850822-1-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230723093806.2850822-1-mahmoudmatook.mm@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Jul 2023 11:04:03 -0700
Message-ID: <CAADnVQKPmUxv6or76-KBVtaD2i+aRpX_qKxr1v7cwdOhWH6QLQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix build errors if CONFIG_NF_CONNTRACK_MARK
 not set.
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 23, 2023 at 2:38=E2=80=AFAM Mahmoud Maatuq
<mahmoudmatook.mm@gmail.com> wrote:
>
> 'mark' member in 'struct nf_conn' is conditionally defined
>  by CONFIG_NF_CONNTRACK_MARK
>  so any reference to it should follow the same.
>
>  $ make -C tools/testing/selftests/bpf
>         progs/test_bpf_nf.c:219:12: error: no member named 'mark' in 'str=
uct nf_conn'
>                                 if (ct->mark =3D=3D 42) {
>                                     ~~  ^
>         progs/test_bpf_nf.c:220:9: error: no member named 'mark' in 'stru=
ct nf_conn'
>                                         ct->mark++;
>                                         ~~  ^
>         progs/test_bpf_nf.c:221:34: error: no member named 'mark' in 'str=
uct nf_conn'
>                                 test_exist_lookup_mark =3D ct->mark;
>
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/test_bpf_nf.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_nf.c
> index 77ad8adf68da..0b285de8b7e7 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -157,7 +157,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, stru=
ct bpf_sock_tuple *, u32,
>                 struct nf_conn *ct_ins;
>
>                 bpf_ct_set_timeout(ct, 10000);
> -               ct->mark =3D 77;
> +               #if defined(CONFIG_NF_CONNTRACK_MARK)
> +                       ct->mark =3D 77;
> +               #endif
> +
>
>                 /* snat */
>                 saddr.ip =3D bpf_get_prandom_u32();
> @@ -188,7 +191,9 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struc=
t bpf_sock_tuple *, u32,
>                                 bpf_ct_change_timeout(ct_lk, 10000);
>                                 test_delta_timeout =3D ct_lk->timeout - b=
pf_jiffies64();
>                                 test_delta_timeout /=3D CONFIG_HZ;
> -                               test_insert_lookup_mark =3D ct_lk->mark;
> +                               #if defined(CONFIG_NF_CONNTRACK_MARK)
> +                                       test_insert_lookup_mark =3D ct_lk=
->mark;
> +                               #endif
>                                 bpf_ct_change_status(ct_lk,
>                                                      IPS_CONFIRMED | IPS_=
SEEN_REPLY);
>                                 test_status =3D ct_lk->status;
> @@ -210,10 +215,12 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, str=
uct bpf_sock_tuple *, u32,
>                        sizeof(opts_def));
>         if (ct) {
>                 test_exist_lookup =3D 0;
> -               if (ct->mark =3D=3D 42) {
> -                       ct->mark++;
> -                       test_exist_lookup_mark =3D ct->mark;
> -               }
> +               #if defined(CONFIG_NF_CONNTRACK_MARK)
> +                       if (ct->mark =3D=3D 42) {
> +                               ct->mark++;
> +                               test_exist_lookup_mark =3D ct->mark;
> +                       }
> +               #endif

That's not a fix.
The test has to have CONFIG_NF_CONNTRACK_MARK enabled in the kernel.
Make sure your kernel is built with _all_ configs specified in
tools/testing/selftests/bpf/config*
