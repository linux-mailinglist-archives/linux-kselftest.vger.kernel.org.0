Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72F5E6B36
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIVSqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIVSqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 14:46:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC19E6A0F;
        Thu, 22 Sep 2022 11:46:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso3082683pjd.4;
        Thu, 22 Sep 2022 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=v3Ah9fb1qrCwQR4d12eExOef95OCxNIN++esA2IIF80=;
        b=Q//n0kW/Vxd52O+tZTElmxgRlsNH8mpg5vvKHQZ7tfO47xTeLDnT2F+ZqPvMxHtl9P
         QQkTNqpEnZoLpZBjQ6UZr3htLwKjNQOo7GuhIBKhr40PLylaw2CGEK4oObrItwnZI4Xr
         Pc0pX6OsoS3YDlXGv/OkC1DaJK4vAW75HN0De7QSlpopk3G5NEsEQbB1V548uNXdeASI
         Sy3F20G2Wkpreh73rcvK6qeiwh/tuJS2r+g7r6QAgbtUAeMP0iOisbGg9qVV9pwIbjRV
         z5A/MWdU5wFf+7zdS7JShq9P7q0/zeTPZm3Utt+tBzn+2IepwLWSjt999Jwnei9Lw96Z
         3woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=v3Ah9fb1qrCwQR4d12eExOef95OCxNIN++esA2IIF80=;
        b=5N1V1/moVbW4AaUbTGC5K8EpQaLhTc0QFvu+9czBaADiT2mUTpO8o3dHFZV3Osvozo
         EM6ksL3mwUSsSMHjxFjmwsWLOsx/XgZ1yGc9MZfEAmFSCdkJJQZSOq//Ej8TSa4yyR+f
         OG8/pg+s2JwshoYugSseb9WHSA6hX1HkaGIQq6ujUg4Nj+X43DCfYOzkzIxGKK64uDYl
         41lspaPmZadKL75TFFaWK/F28lHZ3GyUp9o5JJalDEiEeyxcDO6+o5sGZF2qWIjxC3B8
         ACR6+SCWovQfZOdd7g8L7KTOA2msYQOOLkJ3rWD/g9KcLb3Y6peR4/mejcNqGZCg8DWv
         o9Lw==
X-Gm-Message-State: ACrzQf2VrH4/8wkTHW1Y1NyH+18tA6MyhKD5jbKLSvbEiqqKCqa60xhq
        dwe6EuHF/EQGZ2oqP7tbkw0=
X-Google-Smtp-Source: AMsMyM7Z7+pDQSvVDGJRV52sWwM9wqk8zW95hc9sSvTRWf0JgvdpLXaeBviPsUdR211xhXYLYZNHdg==
X-Received: by 2002:a17:903:230b:b0:177:e667:7862 with SMTP id d11-20020a170903230b00b00177e6677862mr4579570plh.154.1663872411741;
        Thu, 22 Sep 2022 11:46:51 -0700 (PDT)
Received: from localhost ([98.97.34.132])
        by smtp.gmail.com with ESMTPSA id w128-20020a626286000000b0053e20a0333fsm4782822pfb.93.2022.09.22.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:46:51 -0700 (PDT)
Date:   Thu, 22 Sep 2022 11:46:49 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Qiao Ma <mqaio@linux.alibaba.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Message-ID: <632cad99e05c2_3c2b22088@john.notmuch>
In-Reply-To: <CAEf4BzbqdDUY-1mpGUBk-CpMLAC7jvgRV7rNbgvxr=5nMOsj2Q@mail.gmail.com>
References: <38269a1610deebf8d51127f15b1c55d00caa4283.1661392989.git.mqaio@linux.alibaba.com>
 <CAADnVQKm-TGJxjwByaMBcvFA_7g+wC2hB+cqkZKhSc83a2H0Pg@mail.gmail.com>
 <6308f39ddfecc_75c920884@john.notmuch>
 <CAEf4BzbqdDUY-1mpGUBk-CpMLAC7jvgRV7rNbgvxr=5nMOsj2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix incorrect fcntl call
 (test_sockmap.c)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko wrote:
> On Fri, Aug 26, 2022 at 9:24 AM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Alexei Starovoitov wrote:
> > > On Wed, Aug 24, 2022 at 7:11 PM Qiao Ma <mqaio@linux.alibaba.com> wrote:
> > > >
> > > > In test_sockmap.c, the testcase sets socket nonblock first, and then
> > > > calls select() and recvmsg() to receive data.
> > > > If some error occur, nonblock setting will make recvmsg() return
> > > > immediately, rather than blocking forever.
> > > >
> > > > However, the way to call fcntl() to set nonblock is wrong.
> > > > To set socket noblock, we need to use
> > > > > fcntl(fd, F_SETFL, O_NONBLOCK);
> > > > rather than:
> > > > > fcntl(fd, O_NONBLOCK);
> > > >
> > > > Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/test_sockmap.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> > > > index 0fbaccdc8861..abb4102f33b0 100644
> > > > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > > > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > > > @@ -598,7 +598,12 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
> > > >                 struct timeval timeout;
> > > >                 fd_set w;
> > > >
> > > > -               fcntl(fd, fd_flags);
> > > > +               err = fcntl(fd, F_SETFL, fd_flags);
> > > > +               if (err < 0) {
> > > > +                       perror("fcntl failed");
> > > > +                       goto out_errno;
> > > > +               }
> > > > +
> > >
> > > John, Jakub,
> > >
> > > Please review this.
> > > Unfortunately test_sockmap (and sockmap kernel) is broken
> > > before and after this patch,
> > > so I'm hesitant to apply it not to make thing harder to debug.
> > > Here is what I see:
> > > # ./test_sockmap

[...]

> > > and test_sockmap 'hangs' (or doing something for long time) after
> > > #31/ 6 sockhash:ktls:txmsg test drop:OK
> >
> > Thanks for spotting I'll take a look.
> 
> Friendly ping. John, did you get a chance to look at this? This patch
> is still marked as "Needs ACK" in Patchworks.


Yep thanks. We are tracking a couple fixes internally around this so should
have something pop out soon. I think we want the fix and test to go in at
the same time.

.John
