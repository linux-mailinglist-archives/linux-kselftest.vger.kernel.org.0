Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549E8787A4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjHXVXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243691AbjHXVWl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 17:22:41 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07951BCC;
        Thu, 24 Aug 2023 14:22:38 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44e3a4d0a6fso135522137.0;
        Thu, 24 Aug 2023 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692912158; x=1693516958;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZvcG589l1AbddG8/t0ALjJZ+ZBC/3SPsKCiVH6+/H4=;
        b=W3U/+wyH0NSyqy5A4DWxab172DSS0fWPGnd+061PkzfcfZiHqBRYmoptLeXllY660/
         CLk65bWCPuHFt+V1VyjsxpnJ4+9KpWWYEt3Gh9gtFLL19ORxx4vYwxzlbsrmxrVwzo7n
         bftKaNTh0uolpOiEf5LkhSK/skyQa3A2D57qJh2l7HxtEU48E0jeaCHde8FB+nS/za9Q
         ZS8ZGt49RxHYy7Rf/xjsID0+vs6NIdg3YgRiEDvdL/wkHD8XULAfz6apzGXHX1rkCpGh
         3+e+qcXpocKYuJ09DvRb/SxRyKwA9tuVFOvuBNc3wuRkrgHuxDcbcIGhf05IBPrkhAd3
         n1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912158; x=1693516958;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZvcG589l1AbddG8/t0ALjJZ+ZBC/3SPsKCiVH6+/H4=;
        b=Z0X5wcOccZ4eSKMadRDmPJbXmBQr3vaopFoZzRHqAGjkXHX7N1n5rRrZmVd+JwQspW
         Ol7qyC6AmI9IeN9RvSA1+NIgu1mceunClK0faf1eBwIfcc62ZLlL5gaLKVDWmX3IEANA
         U+bzyIjaRZZX7qgu5W4pzjhwv7+DnIC6XapC6pMaM0J57+rZfG/ygY1uTB4cB3k7bqRY
         UQhOf7y2WvchUdN5SQXPie3kwFXj1GcceFLiwxaxcfnVti6Ob1uNmnsDyb+4NeByq4jO
         oR6Mqve5J4bW4PjPAGTcNbw2Ia9e59UjxzKEl/1raJHanlulXPd2ica74pOQwskcigCv
         pMjQ==
X-Gm-Message-State: AOJu0Yy6578dEQ9CFy/WLy3U2/AVlq3rZT/XrCqEb/MZyIkEnLTN/4/A
        4SBjTNN77kNH7jSzDSpbh9bmgKcPFJnC8VmAGDwtBnx7
X-Google-Smtp-Source: AGHT+IFndlTlMUYFyhuwlLiW1PSdaGai48rzrDmPVINH0uPZwsoPG2zpYKClvZxDe3ulnATQ5l1/8haEcW0cAfST37w=
X-Received: by 2002:a05:6102:448:b0:44e:9168:918e with SMTP id
 e8-20020a056102044800b0044e9168918emr4822386vsq.29.1692912157771; Thu, 24 Aug
 2023 14:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <20230824202415.131824-2-mahmoudmatook.mm@gmail.com> <CAF=yD-+8GBB75ddvG1MECYrYpwbxH1RMcre6EYiqXo4pk_Nx5g@mail.gmail.com>
 <20230824211332.bnyvxda7a2ws75ep@mmaatuq-HP-Laptop-15-dy2xxx>
In-Reply-To: <20230824211332.bnyvxda7a2ws75ep@mmaatuq-HP-Laptop-15-dy2xxx>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 24 Aug 2023 17:22:01 -0400
Message-ID: <CAF=yD-JPL6M9_q_W2OZH=4wis3GSfpYAo5Y7Jp+SyhA+NLeE3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/net: replace ternary operator with min()/max()
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        keescook@chromium.org, edumazet@google.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org
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

On Thu, Aug 24, 2023 at 5:13=E2=80=AFPM Mahmoud Matook
<mahmoudmatook.mm@gmail.com> wrote:
>
> On 08/24, Willem de Bruijn wrote:
>
> > On Thu, Aug 24, 2023 at 4:25=E2=80=AFPM Mahmoud Maatuq
> > <mahmoudmatook.mm@gmail.com> wrote:
> > >
> > > Fix the following coccicheck warning:
> > > tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING oppo=
rtunity for min()
> > > tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING oppo=
rtunity for min()
> > > tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunit=
y for max()
> > > tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity=
 for max()
> > >
> > > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >
> > I did not suggest this change.
> >
> the suggestion i meant here is about the following part
> "Note that a more strict version that includes __typecheck would
> warn on the type difference between total_len and cfg_mss. Fine
> with changing the type of cfg_mss in the follow-on patch to address
> that."
> as mentioned here https://lore.kernel.org/all/CAF=3DyD-+6cWTiDgpsu=3DhUV+=
OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com/
> I tried to change the type of cfg_mss but it creates a different warn
> at udpgso_bench_tx.c:354 between cfg_mss and left that's way i casted
> instead.
> apology if i misunderstood your point.

Thanks. It's fine to avoid changing the type or cast if it does not
set of any alarms.

I think Suggested-by is for when the main idea of the patch is
someone's suggestion. Not a big deal, but please drop in v3. It's your
hard work and yours only. I'll add my Reviewed-by.



> > > ---
> > > changes in v2:
> > > cast var cfg_mss to int to avoid static assertion
> > > after providing a stricter version of min() that does signedness chec=
king.
> > > ---
> > >  tools/testing/selftests/net/Makefile          | 2 ++
> > >  tools/testing/selftests/net/so_txtime.c       | 7 ++++---
> > >  tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
> > >  3 files changed, 9 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/sel=
ftests/net/Makefile
> > > index 7f3ab2a93ed6..a06cc25489f9 100644
> > > --- a/tools/testing/selftests/net/Makefile
> > > +++ b/tools/testing/selftests/net/Makefile
> > > @@ -3,6 +3,8 @@
> > >
> > >  CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g
> > >  CFLAGS +=3D -I../../../../usr/include/ $(KHDR_INCLUDES)
> > > +# Additional include paths needed by kselftest.h
> > > +CFLAGS +=3D -I../
> >
> > Why does kselftest.h need this? It does not include anything else?
> >
> > I'd just add #include "../kselftests.h" to so_txtime.c and remove the
> > path change from udpgso_bench_tx.c
> >
> > Fine with this approach. Just don't understand the comment
> >
>
> the comment here is wrong and it should be changed to include path
> needed to include kselftest.h or to be deleted
>
> > >
> > >  TEST_PROGS :=3D run_netsocktests run_afpackettests test_bpf.sh netde=
vice.sh \
> > >               rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
> > > diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/=
selftests/net/so_txtime.c
> > > index 2672ac0b6d1f..2936174e7de4 100644
> > > --- a/tools/testing/selftests/net/so_txtime.c
> > > +++ b/tools/testing/selftests/net/so_txtime.c
> > > @@ -33,6 +33,8 @@
> > >  #include <unistd.h>
> > >  #include <poll.h>
> > >
> > > +#include "kselftest.h"
> > > +
> > >  static int     cfg_clockid     =3D CLOCK_TAI;
> > >  static uint16_t        cfg_port        =3D 8000;
> > >  static int     cfg_variance_us =3D 4000;
> > > @@ -93,8 +95,7 @@ static void do_send_one(int fdt, struct timed_send =
*ts)
> > >                 msg.msg_controllen =3D sizeof(control);
> > >
> > >                 tdeliver =3D glob_tstart + ts->delay_us * 1000;
> > > -               tdeliver_max =3D tdeliver_max > tdeliver ?
> > > -                              tdeliver_max : tdeliver;
> > > +               tdeliver_max =3D max(tdeliver_max, tdeliver);
> > >
> > >                 cm =3D CMSG_FIRSTHDR(&msg);
> > >                 cm->cmsg_level =3D SOL_SOCKET;
> > > @@ -126,7 +127,7 @@ static void do_recv_one(int fdr, struct timed_sen=
d *ts)
> > >                 error(1, 0, "read: %dB", ret);
> > >
> > >         tstop =3D (gettime_ns(cfg_clockid) - glob_tstart) / 1000;
> > > -       texpect =3D ts->delay_us >=3D 0 ? ts->delay_us : 0;
> > > +       texpect =3D max(ts->delay_us, 0);
> > >
> > >         fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
> > >                         rbuf[0], (long long)tstop, (long long)texpect=
);
> > > diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/te=
sting/selftests/net/udpgso_bench_tx.c
> > > index 477392715a9a..6bd32a312901 100644
> > > --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> > > +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> > > @@ -25,7 +25,7 @@
> > >  #include <sys/types.h>
> > >  #include <unistd.h>
> > >
> > > -#include "../kselftest.h"
> > > +#include "kselftest.h"
> > >
> > >  #ifndef ETH_MAX_MTU
> > >  #define ETH_MAX_MTU 0xFFFFU
> > > @@ -294,7 +294,7 @@ static int send_udp(int fd, char *data)
> > >         total_len =3D cfg_payload_len;
> > >
> > >         while (total_len) {
> > > -               len =3D total_len < cfg_mss ? total_len : cfg_mss;
> > > +               len =3D min(total_len, (int)cfg_mss);
> > >
> > >                 ret =3D sendto(fd, data, len, cfg_zerocopy ? MSG_ZERO=
COPY : 0,
> > >                              cfg_connected ? NULL : (void *)&cfg_dst_=
addr,
> > > @@ -351,7 +351,7 @@ static int send_udp_sendmmsg(int fd, char *data)
> > >                         error(1, 0, "sendmmsg: exceeds max_nr_msg");
> > >
> > >                 iov[i].iov_base =3D data + off;
> > > -               iov[i].iov_len =3D cfg_mss < left ? cfg_mss : left;
> > > +               iov[i].iov_len =3D min(cfg_mss, left);
> > >
> > >                 mmsgs[i].msg_hdr.msg_iov =3D iov + i;
> > >                 mmsgs[i].msg_hdr.msg_iovlen =3D 1;
> > > --
> > > 2.34.1
> > >
