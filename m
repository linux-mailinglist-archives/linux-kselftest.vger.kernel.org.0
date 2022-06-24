Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B555A367
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiFXVSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFXVSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 17:18:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C421640A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 14:18:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so7081526ejc.11
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOvhoEpSE/InAZniXEti7vxsLeyf1a5ZFLlDrYfEPAA=;
        b=M1hPxnJUFy/KS9mddV1ZPCrOTUCJOFrbdOpyi7j0ftrXkyhBEEnYliwfUMRIJpc302
         UerGSaJuJ0U+ZQOOBbu9YnTTWBPqzn6BGm20kcHK021zUKyUQcLbeROv76yKvkCA4wL5
         TKPV/NeXPSFred9jnh+TebuOPhqPca6DgiiGGp4t7notg/0HrutadjdFHCaRzrR60/SS
         kEf+UPdtfuMWWyAGy3sWvPgk2BDAIWToAkVEoiSpYe94Nv1jd3nvOoAgAb/ln/G4XSiC
         GAFPYKei8IcLsfKWZvc/9gQfNai9RmMKWnJqWlZq+QZRlzREX3RhLKN999kWcpZY7b77
         80Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOvhoEpSE/InAZniXEti7vxsLeyf1a5ZFLlDrYfEPAA=;
        b=bh7sfAg9VgHwf/s234SQ3Hh3aT6f+aaYNW9+xz/pvNSDei1KXaGvBSom8kIuaJQbe8
         J3CFrwD7G3/Vza5TG3wlyIXxOiaBt5cCek+jKYL9WQw5plx9saDY+k+PXGDUa2fhk6oO
         MNTwauNrwdBtsRYhh6osVlo6SM53iUA7r/El+phs65RL47b8gVsGSwNTPyTONDwl8ZrS
         85LqDKO4c1NJ+htfouQg/hsbKT5ndIMVGFIr/4NA13900OaSUph7DLGMdrSM7GtiQVZB
         RNHHlj0+QzA5F8xllPRC7blX4dcfxSW15fdqkQxxIwRx2KiMSRSxnMZQjZHpmOYShdkY
         WPeQ==
X-Gm-Message-State: AJIora8YvlcPXyOKgDomJdQWkhx5/HXap3eqZU3/TcAjjxUZ1qPcRWet
        +/HZdv8fARpCwXqmXg3EEVRbrSzoSopCgqbtQtq2EQ==
X-Google-Smtp-Source: AGRyM1sSg7LIinwzTB+qnSxgsQphAXAb9tAoVzunteBdzvrsgIwf9MXdDqBKLlkpEVBLtUpHvFPPJdLDYUqh2lPKgqo=
X-Received: by 2002:a17:907:d25:b0:711:ea61:63aa with SMTP id
 gn37-20020a1709070d2500b00711ea6163aamr992776ejc.584.1656105480525; Fri, 24
 Jun 2022 14:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
 <Yn6DpUsoSz1/15Kc@slm.duckdns.org> <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
 <YodHjYlMx1XGtM2+@slm.duckdns.org> <CABdmKX2Ok023rN1drQgXVZLKUO_DVYrzmEamCgMMu6BPO67yhQ@mail.gmail.com>
 <CABdmKX0WV8VWgeafVGJ++nJ4xsJD7Wpz=3KX=BW1du=huttfvw@mail.gmail.com>
 <YrYbwu0iIAJJGXVg@phenom.ffwll.local> <CANDhNCqGjaq-SFvWwkqnEFj4tJcRqCYupZ03wLyCexqTH5MqMg@mail.gmail.com>
 <YrYgWCTtZqfvCt5D@phenom.ffwll.local>
In-Reply-To: <YrYgWCTtZqfvCt5D@phenom.ffwll.local>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 24 Jun 2022 14:17:49 -0700
Message-ID: <CABdmKX0bJDLwK7JEDGVb=KHtoVbZgnXYr8UE5eUpLYuAyiWwyw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
To:     John Stultz <jstultz@google.com>,
        "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 1:36 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jun 24, 2022 at 01:32:45PM -0700, John Stultz wrote:
> > On Fri, Jun 24, 2022 at 1:17 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 10:31:21AM -0700, T.J. Mercier wrote:
> > > > On Fri, May 20, 2022 at 9:25 AM T.J. Mercier <tjmercier@google.com> wrote:
> > > > >
> > > > > On Fri, May 20, 2022 at 12:47 AM Tejun Heo <tj@kernel.org> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Tue, May 17, 2022 at 04:30:29PM -0700, T.J. Mercier wrote:
> > > > > > > Thanks for your suggestion. This almost works. "dmabuf" as a key could
> > > > > > > work, but I'd actually like to account for each heap. Since heaps can
> > > > > > > be dynamically added, I can't accommodate every potential heap name by
> > > > > > > hardcoding registrations in the misc controller.
> > > > > >
> > > > > > On its own, that's a pretty weak reason to be adding a separate gpu
> > > > > > controller especially given that it doesn't really seem to be one with
> > > > > > proper abstractions for gpu resources. We don't want to keep adding random
> > > > > > keys to misc controller but can definitely add limited flexibility. What
> > > > > > kind of keys do you need?
> > > > > >
> > > > > Well the dmabuf-from-heaps component of this is the initial use case.
> > > > > I was envisioning we'd have additional keys as discussed here:
> > > > > https://lore.kernel.org/lkml/20220328035951.1817417-1-tjmercier@google.com/T/#m82e5fe9d8674bb60160701e52dae4356fea2ddfa
> > > > > So we'd end up with a well-defined core set of keys like "system", and
> > > > > then drivers would be free to use their own keys for their own unique
> > > > > purposes which could be complementary or orthogonal to the core set.
> > > > > Yesterday I was talking with someone who is interested in limiting gpu
> > > > > cores and bus IDs in addition to gpu memory. How to define core keys
> > > > > is the part where it looks like there's trouble.
> > > > >
> > > > > For my use case it would be sufficient to have current and maximum
> > > > > values for an arbitrary number of keys - one per heap. So the only
> > > > > part missing from the misc controller (for my use case) is the ability
> > > > > to register a new key at runtime as heaps are added. Instead of
> > > > > keeping track of resources with enum misc_res_type, requesting a
> > > > > resource handle/ID from the misc controller at runtime is what I think
> > > > > would be required instead.
> > > > >
> > > > Quick update: I'm going to make an attempt to modify the misc
> > > > controller to support a limited amount of dynamic resource
> > > > registration/tracking in place of the new controller in this series.
> > > >
> > > > Thanks everyone for the feedback.
> > >
> > > Somehow I missed this entire chain here.
> > >
> > > I'm not a fan, because I'm kinda hoping we could finally unify gpu memory
> > > account. Atm everyone just adds their one-off solution in a random corner:
> > > - total tracking in misc cgroup controller
> > > - dma-buf sysfs files (except apparently too slow so it'll get deleted
> > >   again)
> > > - random other stuff on open device files os OOM killer can see it
> > >
> > > This doesn't look good.
> >
> > But I also think one could see it as "gpu memory" is the drm subsystem
> > doing the same thing (in that it's artificially narrow to gpus). It
> > seems we need something to account for buffers allocated by drivers,
> > no matter which subsystem it was in (drm, v4l2, or networking or
> > whatever).
>
> This is what the gpucg was. It wasn't called the dmabuf cg because we want
> to account also memory of other types (e.g. drm gem buffer objects which
> aren't exported), and I guess people didn't dare call it an xpu.
>
> But this was absolutely for a lot more than just "gpu drivers in drm".
> Better names welcome.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

From an API perspective the two approaches (misc vs GPU) seem similar
to me. Someone comes up with a name of a resource they want to track,
and it's added as a key in a cgroup interface file as drivers register
and perform accounting on that resource. Considering just the naming,
what do you see as the appeal of a controller named GPU/XPU vs one
named Misc? Folks seem to have assumptions about the type of resources
a "GPU" controller should be tracking, and potentially also how
different resources are grouped under a single resource name. So is
your thought that non-graphics related accounting of the same sort
should be using a differently named controller, even if that
controller could have the same implementation?

My thought is that the resource names should be as specific as
possible to allow fine-grained accounting, and leave any grouping of
resources to userspace. We can do that under any controller. If you'd
like to see a separate controller for graphics related stuff... well
that's what I was aiming for with the GPU cgroup controller. It's just
that dmabufs from heaps are the first use-case wired up.

I haven't put much time into the misc controller effort yet, and I'd
still be happy to see the GPU controller accepted if we can agree
about how it'd be used going forward. Daniel, I think you're in a
great position to comment about this. :) If there's a place where the
implementation is missing the mark, then let's change it. Are the
controller and resource naming the only issues?
