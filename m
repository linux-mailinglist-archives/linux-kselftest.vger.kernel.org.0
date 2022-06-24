Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61955A276
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFXURN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFXURM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 16:17:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDC7C840
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 13:17:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so6852641eja.8
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7KsArznjDszXEtjfLGnA6REJfLUYfQ3Oszk2m5SudA=;
        b=DysS05ypy7Dj7deDljGrAOAbGl2Xyt4/z99Z0sAnWou95elElB1LSY5/Ts4Ksh/mXP
         DLv6fOZpbapyMhr7MkdZvU+yZ2/QnFZ1mpgFnWqAY41HyRd5w3WAVUbpmAQFwqme6Ilf
         NCYlIIWT8tJDBPd7kF3JbEbHU58J7PTZbpGK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=A7KsArznjDszXEtjfLGnA6REJfLUYfQ3Oszk2m5SudA=;
        b=QYXjGz5Lc9UBbZejgc7jgmmqAt/bR96f4lbWUJ4Ao7+3jmLSx/cZw7EsJYVMYYAKna
         yHBYEPzYVJYSaX/oZq2/ZE1WrRk/b6xA64LxxChw1LaTD/xdbfQg3Omt0Zjw6AW3h52Y
         eW6hxco8wQ4sgLe3g2KKrG4jw+h67avc+DpjoYXd1SEiEXrbn2Yohfimvb2z9/SI2sjR
         lZVL+awm/WmPK91yzjyPjmEFTRvjm/2IUjJiW885gCJw1Xur8W1g3/xlZjoi60rZIHhc
         QFSDgF3lnZCfqcWCMqfuruff8fcnGtfR2nqezsk2YguERS5a0hqCORYkza2gFsVdoxsf
         6QUw==
X-Gm-Message-State: AJIora9oXC2fEqsCfcBvnOKXWwQML1VHnPYRY7mZeVUFS9lAh8rjMVVK
        km0x87O1EawQxzP2rkKSbSxWGQ==
X-Google-Smtp-Source: AGRyM1tbrhSpLiAB9dqU6edRxuLbyecMJr7L30I5wUrP26zUyqvNNkEwbuedAAWD5HRC48ej/oEHbg==
X-Received: by 2002:a17:907:7d88:b0:726:2adb:2073 with SMTP id oz8-20020a1709077d8800b007262adb2073mr778546ejc.466.1656101829623;
        Fri, 24 Jun 2022 13:17:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w20-20020aa7dcd4000000b0042dc882c823sm2642667edu.70.2022.06.24.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:17:08 -0700 (PDT)
Date:   Fri, 24 Jun 2022 22:17:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
Message-ID: <YrYbwu0iIAJJGXVg@phenom.ffwll.local>
Mail-Followup-To: "T.J. Mercier" <tjmercier@google.com>,
        Tejun Heo <tj@kernel.org>, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, Shuah Khan <shuah@kernel.org>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>, kernel-team@android.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kselftest@vger.kernel.org
References: <20220510235653.933868-1-tjmercier@google.com>
 <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org>
 <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
 <YodHjYlMx1XGtM2+@slm.duckdns.org>
 <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
 <CABdmKX0WV8VWgeafVGJ++nJ4xsJD7Wpz=3KX=BW1du=huttfvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX0WV8VWgeafVGJ++nJ4xsJD7Wpz=3KX=BW1du=huttfvw@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 15, 2022 at 10:31:21AM -0700, T.J. Mercier wrote:
> On Fri, May 20, 2022 at 9:25 AM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > On Fri, May 20, 2022 at 12:47 AM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> > > > Thanks for your suggestion. This almost works. "dmabuf" as a key could
> > > > work, but I'd actually like to account for each heap. Since heaps can
> > > > be dynamically added, I can't accommodate every potential heap name by
> > > > hardcoding registrations in the misc controller.
> > >
> > > On its own, that's a pretty weak reason to be adding a separate gpu
> > > controller especially given that it doesn't really seem to be one with
> > > proper abstractions for gpu resources. We don't want to keep adding random
> > > keys to misc controller but can definitely add limited flexibility. What
> > > kind of keys do you need?
> > >
> > Well the dmabuf-from-heaps component of this is the initial use case.
> > I was envisioning we'd have additional keys as discussed here:
> > https://lore.kernel.org/lkml/20220328035951.1817417-1-tjmercier@google.com/T/#m82e5fe9d8674bb60160701e52dae4356fea2ddfa
> > So we'd end up with a well-defined core set of keys like "system", and
> > then drivers would be free to use their own keys for their own unique
> > purposes which could be complementary or orthogonal to the core set.
> > Yesterday I was talking with someone who is interested in limiting gpu
> > cores and bus IDs in addition to gpu memory. How to define core keys
> > is the part where it looks like there's trouble.
> >
> > For my use case it would be sufficient to have current and maximum
> > values for an arbitrary number of keys - one per heap. So the only
> > part missing from the misc controller (for my use case) is the ability
> > to register a new key at runtime as heaps are added. Instead of
> > keeping track of resources with enum misc_res_type, requesting a
> > resource handle/ID from the misc controller at runtime is what I think
> > would be required instead.
> >
> Quick update: I'm going to make an attempt to modify the misc
> controller to support a limited amount of dynamic resource
> registration/tracking in place of the new controller in this series.
> 
> Thanks everyone for the feedback.

Somehow I missed this entire chain here.

I'm not a fan, because I'm kinda hoping we could finally unify gpu memory
account. Atm everyone just adds their one-off solution in a random corner:
- total tracking in misc cgroup controller
- dma-buf sysfs files (except apparently too slow so it'll get deleted
  again)
- random other stuff on open device files os OOM killer can see it

This doesn't look good.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
