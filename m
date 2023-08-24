Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0568787A08
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjHXVNv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbjHXVNn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 17:13:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EC1BC9;
        Thu, 24 Aug 2023 14:13:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401187f8071so2324375e9.0;
        Thu, 24 Aug 2023 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692911620; x=1693516420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgSSTPGOahDUdKUCKHMcDGGgo1CRIF6AOb3J+pq5kDs=;
        b=QNgbU/UKMHOiYsiKZjwMcnwGu7KhDoVvtPNa+stmp7QROfXmCGnrCmGh7YeTQEt7os
         5ApUTPjfvUdHNRK7GPJMlavDqDucPnb0yJgz1r1p5tAgIJK0H0mRxOTGOaruIFGW8QFK
         6dzWOgen2Y5isRKjO4Ni0GHB8Q9giKiZwGFL1Q41Zpqv5WYOMg8uJzgM1jhFPuLDhNE9
         C/GyLDQRrz9KcnAbONNRSQiLYp2DM9gGvFKq9Vlka/fSVWt2nez+kpmbC0WelViYU9Oj
         9btWhgSJ2BMQhQKlo2oUrPS6VGUPzvSbHjYRNgeP1PQHMX/1gwB33ZcHZ7fHs46ti1X9
         mohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692911620; x=1693516420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgSSTPGOahDUdKUCKHMcDGGgo1CRIF6AOb3J+pq5kDs=;
        b=H/1XIQ1B2r/bpxEyV2yd5bVjeNeIe2Of9gPdPydkaLKeouFkK/YpLe7v1C724CyhFN
         n9u2xayJNfJsoBrBHys6jiZA72e2H6sukDMegofZun7dYodIJQF9pfCceGdAWirxtfi0
         O49iGLrK40Ir1EeDxpdVXIyN/GKD9luW78PZUknaZoBXAQChV2iYrOK0b/IB4KVrZmi5
         4UDCSE4Ky0Lc7rFo3YNv1JVYEZnxNTsGelGgsA0j2gMzhZLh7giCNHvTAxikfW5tjF0n
         /NB20WORLtLytLOcvFGY3LtyZbB5U6DxB+mMtPa86GXtjPAf1ko8Hr89PZjbp0Dhk6k6
         2JjA==
X-Gm-Message-State: AOJu0Yzcl33muyt15vVSSI6DeaAvzAs5cgabtr/OH+LppuPLgEFwjeJh
        MRcFe7WlgK2XWDUaQJ5Cs0A=
X-Google-Smtp-Source: AGHT+IFxNNn45+YXuwHokxbJuJNMfGh4lON/L0d9aSX+d2S6/cBdxzFYK9H7liLE32C6hAqKxNLFMw==
X-Received: by 2002:a05:600c:3582:b0:401:b24b:8279 with SMTP id p2-20020a05600c358200b00401b24b8279mr1232646wmq.1.1692911619419;
        Thu, 24 Aug 2023 14:13:39 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:806e:f960:7197:6afd:b6ed])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003fed630f560sm413257wmc.36.2023.08.24.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 14:13:38 -0700 (PDT)
Date:   Fri, 25 Aug 2023 01:13:32 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     keescook@chromium.org, edumazet@google.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 2/2] selftests/net: replace ternary operator with
 min()/max() =?ISO-8859-1?Q?=1B=1B?=
Message-ID: <20230824211332.bnyvxda7a2ws75ep@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        keescook@chromium.org, edumazet@google.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <20230824202415.131824-2-mahmoudmatook.mm@gmail.com>
 <CAF=yD-+8GBB75ddvG1MECYrYpwbxH1RMcre6EYiqXo4pk_Nx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-+8GBB75ddvG1MECYrYpwbxH1RMcre6EYiqXo4pk_Nx5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/24, Willem de Bruijn wrote:

> On Thu, Aug 24, 2023 at 4:25 PM Mahmoud Maatuq
> <mahmoudmatook.mm@gmail.com> wrote:
> >
> > Fix the following coccicheck warning:
> > tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportunity for min()
> > tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportunity for min()
> > tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity for max()
> > tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for max()
> >
> > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 
> I did not suggest this change.
> 
the suggestion i meant here is about the following part
"Note that a more strict version that includes __typecheck would
warn on the type difference between total_len and cfg_mss. Fine
with changing the type of cfg_mss in the follow-on patch to address
that."
as mentioned here https://lore.kernel.org/all/CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com/
I tried to change the type of cfg_mss but it creates a different warn
at udpgso_bench_tx.c:354 between cfg_mss and left that's way i casted
instead.
apology if i misunderstood your point.
> > ---
> > changes in v2:
> > cast var cfg_mss to int to avoid static assertion
> > after providing a stricter version of min() that does signedness checking.
> > ---
> >  tools/testing/selftests/net/Makefile          | 2 ++
> >  tools/testing/selftests/net/so_txtime.c       | 7 ++++---
> >  tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index 7f3ab2a93ed6..a06cc25489f9 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -3,6 +3,8 @@
> >
> >  CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> >  CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
> > +# Additional include paths needed by kselftest.h
> > +CFLAGS += -I../
> 
> Why does kselftest.h need this? It does not include anything else?
> 
> I'd just add #include "../kselftests.h" to so_txtime.c and remove the
> path change from udpgso_bench_tx.c
> 
> Fine with this approach. Just don't understand the comment
>

the comment here is wrong and it should be changed to include path
needed to include kselftest.h or to be deleted

> >
> >  TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
> >               rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
> > diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
> > index 2672ac0b6d1f..2936174e7de4 100644
> > --- a/tools/testing/selftests/net/so_txtime.c
> > +++ b/tools/testing/selftests/net/so_txtime.c
> > @@ -33,6 +33,8 @@
> >  #include <unistd.h>
> >  #include <poll.h>
> >
> > +#include "kselftest.h"
> > +
> >  static int     cfg_clockid     = CLOCK_TAI;
> >  static uint16_t        cfg_port        = 8000;
> >  static int     cfg_variance_us = 4000;
> > @@ -93,8 +95,7 @@ static void do_send_one(int fdt, struct timed_send *ts)
> >                 msg.msg_controllen = sizeof(control);
> >
> >                 tdeliver = glob_tstart + ts->delay_us * 1000;
> > -               tdeliver_max = tdeliver_max > tdeliver ?
> > -                              tdeliver_max : tdeliver;
> > +               tdeliver_max = max(tdeliver_max, tdeliver);
> >
> >                 cm = CMSG_FIRSTHDR(&msg);
> >                 cm->cmsg_level = SOL_SOCKET;
> > @@ -126,7 +127,7 @@ static void do_recv_one(int fdr, struct timed_send *ts)
> >                 error(1, 0, "read: %dB", ret);
> >
> >         tstop = (gettime_ns(cfg_clockid) - glob_tstart) / 1000;
> > -       texpect = ts->delay_us >= 0 ? ts->delay_us : 0;
> > +       texpect = max(ts->delay_us, 0);
> >
> >         fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
> >                         rbuf[0], (long long)tstop, (long long)texpect);
> > diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> > index 477392715a9a..6bd32a312901 100644
> > --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> > +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> > @@ -25,7 +25,7 @@
> >  #include <sys/types.h>
> >  #include <unistd.h>
> >
> > -#include "../kselftest.h"
> > +#include "kselftest.h"
> >
> >  #ifndef ETH_MAX_MTU
> >  #define ETH_MAX_MTU 0xFFFFU
> > @@ -294,7 +294,7 @@ static int send_udp(int fd, char *data)
> >         total_len = cfg_payload_len;
> >
> >         while (total_len) {
> > -               len = total_len < cfg_mss ? total_len : cfg_mss;
> > +               len = min(total_len, (int)cfg_mss);
> >
> >                 ret = sendto(fd, data, len, cfg_zerocopy ? MSG_ZEROCOPY : 0,
> >                              cfg_connected ? NULL : (void *)&cfg_dst_addr,
> > @@ -351,7 +351,7 @@ static int send_udp_sendmmsg(int fd, char *data)
> >                         error(1, 0, "sendmmsg: exceeds max_nr_msg");
> >
> >                 iov[i].iov_base = data + off;
> > -               iov[i].iov_len = cfg_mss < left ? cfg_mss : left;
> > +               iov[i].iov_len = min(cfg_mss, left);
> >
> >                 mmsgs[i].msg_hdr.msg_iov = iov + i;
> >                 mmsgs[i].msg_hdr.msg_iovlen = 1;
> > --
> > 2.34.1
> >
