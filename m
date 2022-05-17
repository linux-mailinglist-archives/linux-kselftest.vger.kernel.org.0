Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4752AE94
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 01:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiEQXau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 19:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiEQXas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 19:30:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F21658C
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 16:30:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk15so607766ejc.6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kje1fxePklyTYdwuahnUd7jrh3kjOYPr65ooSYjVE44=;
        b=BZgE0jkbkeLVvFmb8ruOV8av8A5Vi/cJesgkFUe7yW3/UIFp5JuLCAIksYmq6dxaPC
         UTmFxH4fn4hS3/gzRePwOA9Zgz2QoeR/e7KsL6wHOQMvCBYOzvoW2yP96YAu1wlsdo/W
         OYW4HOnAUXA1JVGJiazKgXoK/bUipg6BPRZaPd0iU4I6XDCU9CWewInibc8sy+vWJYxb
         GbGtI+anWZDqWuOTylV0pzWc9p1n+hpH4zF0jqzCG43N/eDSdV5LLd69UT0bGeoGyGse
         0mKYTvfzrYVwqtPqL3gqbyjVL7SFmO6Pfdv96YRbeDf3urkh47YcrQa2GcXbFgbNtfr9
         LXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kje1fxePklyTYdwuahnUd7jrh3kjOYPr65ooSYjVE44=;
        b=l/jTll4kGztppmFOAQXkS+slGIdO8Ig9bvagDAxF+AaFT0/8/tB8hnLdZuT/12Cbj9
         1btPv8kkoG5l93rYLhwU163jI6U/Xcswluc1qbrA4qsDXvuCUN0jFI3Jq0dA3ohxIrKx
         oXqj2bZuQDEs/MGULE4wpvMQQ6K2oPDyt872WMdj/G51c2ou5D2c9PKu2Xd5vm7+7d4Y
         p/qknflDHG7F3x5RFk3qLZk1XMJJROuDpKSPTpcVNOmZwE9U3EQxpOVnUAqrxFbdy6zv
         5IhW1ekd16ta/5uKOrpjL3tDKw3dpSZd4vCsG0w2pdb/UjkC84+WFTamh0mcJjLof4Fj
         4/Kg==
X-Gm-Message-State: AOAM5337BlraYtSZdFpILpuz6U2FhZmrOIEUWiSLYeQuFNDqF9j8wkhv
        LoowHH7rwyUyC81IWrpVFfk81MdKwlxXhIKXs4nNKg==
X-Google-Smtp-Source: ABdhPJynpuiODXlilJ4ccPPw09Oypx2Cww6BUXEGpKKQ1/r4bC3SNcHdzpBPpWcDWLBl7XOueU5+lIF135DZSaWqEEs=
X-Received: by 2002:a17:906:6a10:b0:6f5:5e4:9d5 with SMTP id
 qw16-20020a1709066a1000b006f505e409d5mr21615657ejc.122.1652830241187; Tue, 17
 May 2022 16:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com> <Yn6DpUsoSz1/15Kc@slm.duckdns.org>
In-Reply-To: <Yn6DpUsoSz1/15Kc@slm.duckdns.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 17 May 2022 16:30:29 -0700
Message-ID: <CABdmKX1xvm87WMEDkMc9Aye46E4zv1-scenwgaRxHesrOCsaYg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
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
        Shuah Khan <shuah@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
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

On Fri, May 13, 2022 at 9:13 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, May 12, 2022 at 08:43:52PM -0700, T.J. Mercier wrote:
> > > I'm actually happy I've asked this question, wasn't silly after all. I think the
> > > problem here is a naming issue. What you really are monitor is "video memory",
> > > which consist of a memory segment allocated to store data used to render images
> > > (its not always images of course, GPU an VPU have specialized buffers for their
> > > purpose).
> > >
> > > Whether this should be split between what is used specifically by the GPU
> > > drivers, the display drivers, the VPU (CODEC and pre/post-processor) or camera
> > > drivers is something that should be discussed. But in the current approach, you
> > > really meant Video memory as a superset of the above. Personally, I think
> > > generically (to de-Andronized your work), en-globing all video memory is
> > > sufficient. What I fail to understand is how you will manage to distinguished
> > > DMABuf Heap allocation (which are used outside of Android btw), from Video
> > > allocation or other type of usage. I'm sure non-video usage will exist in the
> > > future (think of machine learning, compute, other high bandwidth streaming
> > > thingy ...)
> > >
> > Ok thank you for pointing out the naming issue. The naming is a
> > consequence of the initial use case, but I guess it's too specific.
> > What I want out of this change is that android can track dmabufs that
> > come out of heaps, and drm can track gpu memory. But other drivers
> > could track different resources under different names. Imagine this
> > were called a buffer cgroup controller instead of a GPU cgroup
> > controller. Then the use component ("video memory") isn't tied up with
> > the name of the controller, but it's up to the name of the bucket the
> > resource is tracked under. I think this meets the needs of the two use
> > cases I'm aware of now, while leaving the door open to other future
> > needs. Really the controller is just enabling abstract named buckets
> > for tracking and eventually limiting a type of resource.
>
> So, there hasn't been whole lot of discussion w/ other GPU folks and what
> comes up still seems to indicate that we're still long way away from having
> a meaningful gpu controller.
>
Yes, and I would still be happy to collaborate.

> For your use case, would it make sense to just
> add dmabuf as a key to the misc controller?
>
Thanks for your suggestion. This almost works. "dmabuf" as a key could
work, but I'd actually like to account for each heap. Since heaps can
be dynamically added, I can't accommodate every potential heap name by
hardcoding registrations in the misc controller.

> I'm not sure it makes sense to
> push "gpu controller" forward if there's no conceptual consensus around what
> resources are.
>
> Thanks.
>
> --
> tejun
