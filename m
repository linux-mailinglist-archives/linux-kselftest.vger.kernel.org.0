Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26BB787962
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbjHXUdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbjHXUdW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 16:33:22 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DEDE5E;
        Thu, 24 Aug 2023 13:33:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-48d2e2e05e7so129027e0c.3;
        Thu, 24 Aug 2023 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692909199; x=1693513999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aYYmy3awho6rAhUljjdS40H8hflSwFb0/PHFAG3tf4=;
        b=oucv5HGEu6xUpa0pKiUgtB02O+JRlIqPJoQkJYUvjfw1+9hsEiNIkfs/2lIXRHtDS0
         f9uy2ZpvrShCT72tW/ASl8UooDCnUtWBD8xHpP/cvtOUc3Au45IXcy5lvJZi2t+ropAK
         3KVBc+NmlhkIzCeKN2XGgyle9c0xCLP1B1wdlWKMjFO80/BL4l171VAVSgFMqfCBl+O/
         vibWgIzFxFTjBv7YkBppqvnbsj2rLx58NGPwJ0WSCeZwgeZrY2ZkKBKENlTOewPfxCB6
         5yTv9IlIOHZhwMWMNNF1aAdJ+75+2whUhpNvyhhqatWxW64YLFrD1QP7al03Jn6Dp6zY
         ZfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909199; x=1693513999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aYYmy3awho6rAhUljjdS40H8hflSwFb0/PHFAG3tf4=;
        b=ic897sARvl0mDO51XkjJqHiuYzV11tU47pC+CfZea451KBYxwDvYUSTaXX3PQtsDCI
         XsnnIB5H9pr6o/UMVJf9WWvVPWODCooQ1x7TSu8WorNM7Fsxw1u6UVq5EmprXa4nC07y
         LXXO39NImJ7LxGpjZTC4EJ6GX25vE+C77YexxHBlvPsn5lRwXgJo4m2gGGP8KkPLWi4G
         N+xx28iyaHEbSwdHuGradLvyoZJOySkb5GUGpMv6c68IplE8f6jU8+UmThSAY4FL8C8x
         GE9lN1egQe8kIRV6g2Q7LtwyVDlV9xKgfaKgvD1ahrouvBx2xQOAF/3YeUY5SaEadEeD
         6yRw==
X-Gm-Message-State: AOJu0YwUXI2EhsRkg8IZr69ygHlaaS8zmXTAJCzIsW8DeSI9uJeXlbQs
        Wln+0g1MiU/Wxz7vBIl7cDtgwgY2WrAOQhQg9CA=
X-Google-Smtp-Source: AGHT+IHHLuj1KUNlztQEEMp3IBzs7Iur9+fVFjFsD0XRIAwZvjsi4KnOmyqUYb3ChpHd5Fa4aF1JxjRTAtlASJe5IWE=
X-Received: by 2002:a67:ce15:0:b0:44e:a18a:2514 with SMTP id
 s21-20020a67ce15000000b0044ea18a2514mr1650062vsl.33.1692909199547; Thu, 24
 Aug 2023 13:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com> <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
In-Reply-To: <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 24 Aug 2023 16:32:43 -0400
Message-ID: <CAF=yD-+8GBB75ddvG1MECYrYpwbxH1RMcre6EYiqXo4pk_Nx5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/net: replace ternary operator with min()/max()
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc:     keescook@chromium.org, edumazet@google.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 24, 2023 at 4:25=E2=80=AFPM Mahmoud Maatuq
<mahmoudmatook.mm@gmail.com> wrote:
>
> Fix the following coccicheck warning:
> tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportun=
ity for min()
> tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportun=
ity for min()
> tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity fo=
r max()
> tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for=
 max()
>
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

I did not suggest this change.

> ---
> changes in v2:
> cast var cfg_mss to int to avoid static assertion
> after providing a stricter version of min() that does signedness checking=
.
> ---
>  tools/testing/selftests/net/Makefile          | 2 ++
>  tools/testing/selftests/net/so_txtime.c       | 7 ++++---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 7f3ab2a93ed6..a06cc25489f9 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -3,6 +3,8 @@
>
>  CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g
>  CFLAGS +=3D -I../../../../usr/include/ $(KHDR_INCLUDES)
> +# Additional include paths needed by kselftest.h
> +CFLAGS +=3D -I../

Why does kselftest.h need this? It does not include anything else?

I'd just add #include "../kselftests.h" to so_txtime.c and remove the
path change from udpgso_bench_tx.c

Fine with this approach. Just don't understand the comment

>
>  TEST_PROGS :=3D run_netsocktests run_afpackettests test_bpf.sh netdevice=
.sh \
>               rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
> diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/self=
tests/net/so_txtime.c
> index 2672ac0b6d1f..2936174e7de4 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -33,6 +33,8 @@
>  #include <unistd.h>
>  #include <poll.h>
>
> +#include "kselftest.h"
> +
>  static int     cfg_clockid     =3D CLOCK_TAI;
>  static uint16_t        cfg_port        =3D 8000;
>  static int     cfg_variance_us =3D 4000;
> @@ -93,8 +95,7 @@ static void do_send_one(int fdt, struct timed_send *ts)
>                 msg.msg_controllen =3D sizeof(control);
>
>                 tdeliver =3D glob_tstart + ts->delay_us * 1000;
> -               tdeliver_max =3D tdeliver_max > tdeliver ?
> -                              tdeliver_max : tdeliver;
> +               tdeliver_max =3D max(tdeliver_max, tdeliver);
>
>                 cm =3D CMSG_FIRSTHDR(&msg);
>                 cm->cmsg_level =3D SOL_SOCKET;
> @@ -126,7 +127,7 @@ static void do_recv_one(int fdr, struct timed_send *t=
s)
>                 error(1, 0, "read: %dB", ret);
>
>         tstop =3D (gettime_ns(cfg_clockid) - glob_tstart) / 1000;
> -       texpect =3D ts->delay_us >=3D 0 ? ts->delay_us : 0;
> +       texpect =3D max(ts->delay_us, 0);
>
>         fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
>                         rbuf[0], (long long)tstop, (long long)texpect);
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testin=
g/selftests/net/udpgso_bench_tx.c
> index 477392715a9a..6bd32a312901 100644
> --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> @@ -25,7 +25,7 @@
>  #include <sys/types.h>
>  #include <unistd.h>
>
> -#include "../kselftest.h"
> +#include "kselftest.h"
>
>  #ifndef ETH_MAX_MTU
>  #define ETH_MAX_MTU 0xFFFFU
> @@ -294,7 +294,7 @@ static int send_udp(int fd, char *data)
>         total_len =3D cfg_payload_len;
>
>         while (total_len) {
> -               len =3D total_len < cfg_mss ? total_len : cfg_mss;
> +               len =3D min(total_len, (int)cfg_mss);
>
>                 ret =3D sendto(fd, data, len, cfg_zerocopy ? MSG_ZEROCOPY=
 : 0,
>                              cfg_connected ? NULL : (void *)&cfg_dst_addr=
,
> @@ -351,7 +351,7 @@ static int send_udp_sendmmsg(int fd, char *data)
>                         error(1, 0, "sendmmsg: exceeds max_nr_msg");
>
>                 iov[i].iov_base =3D data + off;
> -               iov[i].iov_len =3D cfg_mss < left ? cfg_mss : left;
> +               iov[i].iov_len =3D min(cfg_mss, left);
>
>                 mmsgs[i].msg_hdr.msg_iov =3D iov + i;
>                 mmsgs[i].msg_hdr.msg_iovlen =3D 1;
> --
> 2.34.1
>
