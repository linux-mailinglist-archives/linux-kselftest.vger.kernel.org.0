Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EAE55A2AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFXUdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiFXUdA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 16:33:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09589E26
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 13:32:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so4585584wra.5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOawYYsMmXVXjmJlEQmmHixFMSNq4rwAUlbsY6fSBgM=;
        b=tg7SyNOOcpVv7QNLGjiD5KPi52/+81+/GdcF4vMbyPBIUjBBrCNv+tyegVY20uye/I
         8Vyz/JGoeTKB1w5QEdFMlq0X9w98WbqAaklpSLN4EHbesVPHavlkpHILt1ZfuYLKpZ8W
         QWm+Maw4GPgy2ApKPUsawPdD52CVDNryzSvuJBVG/RGE1Y030n422Z6wuG4tFFvBcR27
         LjOjXsrh4klnn1DcCwwhoI0t8TTxE908V6t7zZjTqlwnAGdcuAOVwj1XL6eJ5KD7NEWR
         SUf/6y2OeRLz1/Liz1zYe+r9C1qmHOr6YxgkPxXUsGyjo51BPVTKh4OJcFsWrx7rdii2
         KEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOawYYsMmXVXjmJlEQmmHixFMSNq4rwAUlbsY6fSBgM=;
        b=OHG1H1Cf2+xXVQZvK32t6/V2ux1jL5txg16+3dFKFPBp7OdWTTxSykbq1u7r+Tyb/v
         TGFZaW9w4y3bSAqazMZ7/vX/TP6nUus9f8ZAVKuDMQ/9WAQegjmg3GJUR/wZZxGtOpCh
         q9Jd2efBxF2K3XsVnbksxLZHM14sfIi+Emk9DzA9/TRp725yaV9jt6R9b0NWeGFJ8DZu
         SVhzAUdqw81ZraFXjKl+FrcX210JsgSEPxz42gh6EefR3ogKJtzxwYuljB54ZmDOehNa
         yuyOhzBrNxdVfkoBKY1ottQqWgwhv2bEPpOxoZrw1UMJsgX2bEvuYM552ZnFN8Dcy4d8
         au8g==
X-Gm-Message-State: AJIora+PehaSEVhLK2vZFcRjac6HMJq7VvR0MMwLYmgxScsr6dWGUJZE
        qP2zA3nteBujKCJT4UMYfmUljMP1NMq0J7Kr8cL6
X-Google-Smtp-Source: AGRyM1sLPS9VvP6ADwx2J+StFzJT3dvaf4MBsF0swSWZC7Xkp/3biNCnrEVvva/rSqr0ebVtvt4hYokyoFIu+/3DmQ4=
X-Received: by 2002:adf:efd2:0:b0:21b:91ae:68ca with SMTP id
 i18-20020adfefd2000000b0021b91ae68camr833768wrp.514.1656102776455; Fri, 24
 Jun 2022 13:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org> <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
 <YodHjYlMx1XGtM2+@slm.duckdns.org> <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
 <CABdmKX0WV8VWgeafVGJ++nJ4xsJD7Wpz=3KX=BW1du=huttfvw@mail.gmail.com> <YrYbwu0iIAJJGXVg@phenom.ffwll.local>
In-Reply-To: <YrYbwu0iIAJJGXVg@phenom.ffwll.local>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 24 Jun 2022 13:32:45 -0700
Message-ID: <CANDhNCqGjaq-SFvWwkqnEFj4tJcRqCYupZ03wLyCexqTH5MqMg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
To:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 1:17 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 15, 2022 at 10:31:21AM -0700, T.J. Mercier wrote:
> > On Fri, May 20, 2022 at 9:25 AM T.J. Mercier <tjmercier@google.com> wrote:
> > >
> > > On Fri, May 20, 2022 at 12:47 AM Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> > > > > Thanks for your suggestion. This almost works. "dmabuf" as a key could
> > > > > work, but I'd actually like to account for each heap. Since heaps can
> > > > > be dynamically added, I can't accommodate every potential heap name by
> > > > > hardcoding registrations in the misc controller.
> > > >
> > > > On its own, that's a pretty weak reason to be adding a separate gpu
> > > > controller especially given that it doesn't really seem to be one with
> > > > proper abstractions for gpu resources. We don't want to keep adding random
> > > > keys to misc controller but can definitely add limited flexibility. What
> > > > kind of keys do you need?
> > > >
> > > Well the dmabuf-from-heaps component of this is the initial use case.
> > > I was envisioning we'd have additional keys as discussed here:
> > > https://lore.kernel.org/lkml/20220328035951.1817417-1-tjmercier@google.com/T/#m82e5fe9d8674bb60160701e52dae4356fea2ddfa
> > > So we'd end up with a well-defined core set of keys like "system", and
> > > then drivers would be free to use their own keys for their own unique
> > > purposes which could be complementary or orthogonal to the core set.
> > > Yesterday I was talking with someone who is interested in limiting gpu
> > > cores and bus IDs in addition to gpu memory. How to define core keys
> > > is the part where it looks like there's trouble.
> > >
> > > For my use case it would be sufficient to have current and maximum
> > > values for an arbitrary number of keys - one per heap. So the only
> > > part missing from the misc controller (for my use case) is the ability
> > > to register a new key at runtime as heaps are added. Instead of
> > > keeping track of resources with enum misc_res_type, requesting a
> > > resource handle/ID from the misc controller at runtime is what I think
> > > would be required instead.
> > >
> > Quick update: I'm going to make an attempt to modify the misc
> > controller to support a limited amount of dynamic resource
> > registration/tracking in place of the new controller in this series.
> >
> > Thanks everyone for the feedback.
>
> Somehow I missed this entire chain here.
>
> I'm not a fan, because I'm kinda hoping we could finally unify gpu memory
> account. Atm everyone just adds their one-off solution in a random corner:
> - total tracking in misc cgroup controller
> - dma-buf sysfs files (except apparently too slow so it'll get deleted
>   again)
> - random other stuff on open device files os OOM killer can see it
>
> This doesn't look good.

But I also think one could see it as "gpu memory" is the drm subsystem
doing the same thing (in that it's artificially narrow to gpus). It
seems we need something to account for buffers allocated by drivers,
no matter which subsystem it was in (drm, v4l2, or networking or
whatever).

thanks
-john
