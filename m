Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC65B0AF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIGREp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIGREo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 13:04:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178D10575
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 10:04:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3454e58fe53so78050087b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hLyrjDAXFGcKrBQvO2vsySR9eSdav05DqWhM1DrTM6w=;
        b=kzTpMwICMFv0pmARBUEcUnfZg1NJ3terhdZgPs0jgweZObfTivz+51xhwcI+eGtziI
         SPo4Vt3ENKnX06k7No8dIPawE+AXH8ekiD5rpIOH5Tah0qXfmTbVx6ip1lP8sNcTD0bw
         tDJ2CbO0PAu9y4Y4mAfjPn/5Ve7iQ+LwEhahTG3JUP2t6Xnze7VGpnyD+Kh35+Hvn/vl
         wIQhj/fLXTyoj/SR5oczmY0rKeQvGC4mROOVeES80WaiTiNcSSNP8ux08F4+S9FTpfiF
         6a0e7HrNRcWPh3UEylSZYZGNb2wKeE/KFU3tU+qHsBjwoKot5MHwRb83I8G5IHuxrC3f
         ft7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hLyrjDAXFGcKrBQvO2vsySR9eSdav05DqWhM1DrTM6w=;
        b=PfkZk5extYLMXG7KeVHCSfhGf8zdAdn2Jn4wmjStGz8MU0g28/G5VlAlnOhzPRCCnA
         E+pFOtn5uFEy5Yn7uoboh2B+fA3DhUMC6neAkiARaUUqoLFSCevU8axy22ROnDUkgAnn
         Cq/w9rBHEbBgf6jC7FczHLmmTQuazbcLAWluMd18Xpw7HLYelna9paEFeR6CRUNw0g3O
         lIIGG55j4lCKWdgAOxSBK7HaU3TTUWAjwcjKmQWlbocBo16IV8zgxi7/2JtLxQjNErZh
         pwY1Z0fYptLGRYwWS9RtOjU0Yl6gib/LYuigIyRXISUDrgtOfz+hYyT7yqzX8wsxus1e
         u/PA==
X-Gm-Message-State: ACgBeo1wnCPOhSJlv18kcTg0Z2IqU/SoUWO0g2vIGkyCQRoAuf3tESMG
        wNPsnlNXEJp1XWrfhHT6qcqgBHmXoZYHmWTLp8a8KA==
X-Google-Smtp-Source: AA6agR7jgcXkTjKkoU/wI+WaEwUj+8Y4DmQn8qZkFiDWBQX8ngt7el8mfF55JYy4izxDZLf8Q0ntXsx1UWAci0wEAxE=
X-Received: by 2002:a81:4fce:0:b0:344:fba8:cb88 with SMTP id
 d197-20020a814fce000000b00344fba8cb88mr4110212ywb.278.1662570279401; Wed, 07
 Sep 2022 10:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662361354.git.cdleonard@gmail.com> <298e4e87ce3a822b4217b309438483959082e6bb.1662361354.git.cdleonard@gmail.com>
 <CANn89iKq4rUkCwSSD-35u+Lb8s9u-8t5bj1=aZuQ8+oYwuC-Eg@mail.gmail.com> <b951b8fb-f2b3-bcbb-8b7f-868b1f78f9bb@gmail.com>
In-Reply-To: <b951b8fb-f2b3-bcbb-8b7f-868b1f78f9bb@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 7 Sep 2022 10:04:28 -0700
Message-ID: <CANn89iJ9XGKHV1F1uhKmWqyOdDjiBebo0FOb6SfCxcvE5XzJPQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/26] tcp: authopt: Disable via sysctl by default
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Philip Paeps <philip@trouble.is>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Caowangbao <caowangbao@huawei.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 9:53 AM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> On 9/7/22 02:11, Eric Dumazet wrote:
> > On Mon, Sep 5, 2022 at 12:06 AM Leonard Crestez <cdleonard@gmail.com> wrote:
> >>
> >> This is mainly intended to protect against local privilege escalations
> >> through a rarely used feature so it is deliberately not namespaced.
> >>
> >> Enforcement is only at the setsockopt level, this should be enough to
> >> ensure that the tcp_authopt_needed static key never turns on.
> >>
> >> No effort is made to handle disabling when the feature is already in
> >> use.
> >>
> >> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> >> ---
> >>   Documentation/networking/ip-sysctl.rst |  6 ++++
> >>   include/net/tcp_authopt.h              |  1 +
> >>   net/ipv4/sysctl_net_ipv4.c             | 39 ++++++++++++++++++++++++++
> >>   net/ipv4/tcp_authopt.c                 | 25 +++++++++++++++++
> >>   4 files changed, 71 insertions(+)
> >>
> >> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> >> index a759872a2883..41be0e69d767 100644
> >> --- a/Documentation/networking/ip-sysctl.rst
> >> +++ b/Documentation/networking/ip-sysctl.rst
> >> @@ -1038,10 +1038,16 @@ tcp_challenge_ack_limit - INTEGER
> >>          Note that this per netns rate limit can allow some side channel
> >>          attacks and probably should not be enabled.
> >>          TCP stack implements per TCP socket limits anyway.
> >>          Default: INT_MAX (unlimited)
> >>
> >> +tcp_authopt - BOOLEAN
> >> +       Enable the TCP Authentication Option (RFC5925), a replacement for TCP
> >> +       MD5 Signatures (RFC2835).
> >> +
> >> +       Default: 0
> >> +
>
> ...
>
> >> +#ifdef CONFIG_TCP_AUTHOPT
> >> +static int proc_tcp_authopt(struct ctl_table *ctl,
> >> +                           int write, void *buffer, size_t *lenp,
> >> +                           loff_t *ppos)
> >> +{
> >> +       int val = sysctl_tcp_authopt;
> >
> > val = READ_ONCE(sysctl_tcp_authopt);
> >
> >> +       struct ctl_table tmp = {
> >> +               .data = &val,
> >> +               .mode = ctl->mode,
> >> +               .maxlen = sizeof(val),
> >> +               .extra1 = SYSCTL_ZERO,
> >> +               .extra2 = SYSCTL_ONE,
> >> +       };
> >> +       int err;
> >> +
> >> +       err = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> >> +       if (err)
> >> +               return err;
> >> +       if (sysctl_tcp_authopt && !val) {
> >
> > READ_ONCE(sysctl_tcp_authopt)
> >
> > Note that this test would still be racy, because another cpu might
> > change sysctl_tcp_authopt right after the read.
>
> What meaningful races are possible here? This is a variable that changes
> from 0 to 1 at most once.

Two cpus can issue writes of 0 and 1 values at the same time.

Depending on scheduling writing the 0 can 'win' the race and overwrite
the value back to 0.

This is in clear violation of the claim you are making (that the
sysctl can only go once from 0 to 1)

>
> In theory if two processes attempt to assign "non-zero" at the same time
> then one will "win" and the other will get an error but races between
> userspace writing different values are possible for any sysctl. The
> solution seems to be "write sysctls from a single place".
>
> All the checks are in sockopts - in theory if the sysctl is written on
> one CPU then a sockopt can still fail on another CPU until caches are
> flushed. Is this what you're worried about?
>
> In theory doing READ_ONCE might incur a slight penalty on sockopt but
> not noticeable.

Not at all. There is _no_ penalty using READ_ONCE(). Unless it is done
in a loop and this prevents some compiler optimization.

Please use WRITE_ONCE() and READ_ONCE() for all sysctl values used in
TCP stack (and elsewhere)

See all the silly patches we had recently.

>
> >
> >> +               net_warn_ratelimited("Enabling TCP Authentication Option is permanent\n");
> >> +               return -EINVAL;
> >> +       }
> >> +       sysctl_tcp_authopt = val;
> >
> > WRITE_ONCE(sysctl_tcp_authopt, val),  or even better:
> >
> > if (val)
> >       cmpxchg(&sysctl_tcp_authopt, 0, val);
> >
> >> +       return 0;
> >> +}
> >> +#endif
> >> +
>
> This would be useful if we did any sort of initialization here but we
> don't. Crypto is initialized somewhere completely different.
