Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1609513C20
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiD1Tig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD1TiA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 15:38:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BBB5AECF;
        Thu, 28 Apr 2022 12:34:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 41C745C00BC;
        Thu, 28 Apr 2022 15:34:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Apr 2022 15:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651174470; x=1651260870; bh=FZ2ZMuL/Lp
        bRzXpzd8eL6QW8bLX6uuX0IBW3S/wms2M=; b=jqe3D6dszG+9pWsC+SEYq8CVEQ
        EvJGYVJMmm/o58el8L7aYmMBI2QUtUHdS5QGXCxZrizvOvTARRBrZkiN2BeqCTov
        wpJhhOjtniEt0WvceN88+2kIyxln86q1Odu3FmrWNvKqk95NTzCLFoF336WrF10l
        opZ7vPsD2N91mRzZvr2sVmObZ46OdmmyPofjYRorOYiOO3GnLorP12UZ8sZyXaqX
        kVUclyH+SgpZf5P8USKv5b1yNziuyjUFP+JiWzxu1W1T610euiFxSczWuNwnXher
        6lVFHWNDNc9T6opcwnfCyQcbiPQ06H/HKTuGfaEfD/kBtIcB8dkE5kQFF73w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651174470; x=
        1651260870; bh=FZ2ZMuL/LpbRzXpzd8eL6QW8bLX6uuX0IBW3S/wms2M=; b=q
        QdEQuyzyn1jVuUGKX5SbRZz/tDb9ry79I1j/VzxrfxtIdeuc0ksgMVpu/ByCSVJP
        kUE+cCXUuuzB6HmfBJQtgOxYl4kjTw1vD40ZVJY1aA4p0VYtTymFVnmCeBBhtcc7
        A67PoeeG+ntgVumeLfOEBxARM2/DYAJolKQOME2xgghSqygC5JmRc/Nx7dKEK92k
        MDf00JDHyqP1tOjUVhqV8iXOJletxQynmKRjepZZu7D6yQ2SRFKOvqhXp/1uflzh
        gmSLHd1X9qyxJf0z0lRyFB+K+9nXOTxEFptgB4Rd+BRs/+svg9j2h2VqLaI4M0th
        va6swbQRv+TgpjxKGu9Bw==
X-ME-Sender: <xms:RexqYtBq6PMfZvY18peTJTWFzgaOj6L3hmeboHxSFAe4VeCJ74JwbA>
    <xme:RexqYrh2osn09kcC279wbfUjWAwH6fXzc1UDZ8Yp3Tz3ZIhJf38Fts3C2a4Iggy1j
    ynif_n-0YmXAi3HhBc>
X-ME-Received: <xmr:RexqYok01slwbmnSGw0XP5-OkUBnEZTHiraTpoR0NdMlMesVybCR0LjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:RexqYnzgluTg-4s794mKFe6IPl_7CkLpiG6qn1e_EEThFDRBTIqMYw>
    <xmx:RexqYiTBgJiWBqysDJv79T2w5lAzJNZU3xJXXAcT97kuw5IlNqeC-Q>
    <xmx:RexqYqYwb2LLQp_Q51y-_ECQ5K2KW7T53RJXc9Xk654T41jI5sIWHA>
    <xmx:RuxqYoPNqfqCOU-GCve-Wy9cS7kDCs0JQSjIoKwVPhkqJAsuinTixA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Apr 2022 15:34:28 -0400 (EDT)
Date:   Thu, 28 Apr 2022 13:34:25 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/seccomp: Ensure that notifications come in
 FIFO order
Message-ID: <YmrsQZ2lNGHjGK6i@cisco>
References: <20220428015447.13661-1-sargun@sargun.me>
 <20220428015447.13661-2-sargun@sargun.me>
 <YmqTh68UkjVsTnUX@cisco>
 <CAMp4zn-725wHy2su_Dz8pEdzUv7tG=gQ+9=7hj5PXfZpQeOLjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn-725wHy2su_Dz8pEdzUv7tG=gQ+9=7hj5PXfZpQeOLjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 28, 2022 at 09:38:10AM -0700, Sargun Dhillon wrote:
> On Thu, Apr 28, 2022 at 6:15 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > > +     for (i = 0; i < ARRAY_SIZE(pids); i++) {
> > > +             pid = fork();
> > > +             if (pid == 0) {
> > > +                     ret = syscall(__NR_getppid);
> > > +                     exit(ret != USER_NOTIF_MAGIC);
> > > +             }
> > > +             pids[i] = pid;
> > > +     }
> > > +
> > > +     /* This spins until all of the children are sleeping */
> > > +restart_wait:
> > > +     for (i = 0; i < ARRAY_SIZE(pids); i++) {
> > > +             if (get_proc_stat(pids[i]) != 'S') {
> > > +                     nanosleep(&delay, NULL);
> > > +                     goto restart_wait;
> > > +             }
> > > +     }
> >
> > I wonder if we should/can combine this loop with the previous one, and
> > wait for the child to sleep in getppid() before we fork the next one.
> > Otherwise isn't racy in the case that your loop continues to the next
> > iteration before the child processes are scheduled, so things might be
> > out of order? Maybe I'm missing something.
> >
> > In any case, this change seems reasonable to me.
> >
> > Tycho
> It's okay if the child processes are started out of order. The test just
> verifies that the calls are delivered in FIFO order according to when
> the syscall was called (not when the process was started), and we do
> this by just looking at the notification ID. It doesn't care about which
> process generated the notification.

I totally missed that you don't this, I just assumed you did. Thanks.

Anyway, you can add:

Acked-by: Tycho Andersen <tycho@tycho.pizza>

to both patches.

Tycho
