Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9952F784
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 04:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiEUCTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiEUCTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 22:19:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50C195EB0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 19:19:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n13so16660495ejv.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sQlK8EPAE1nmulIIgv5jRhcGPrhGOTgo4V3rKxqmaH4=;
        b=rnCv4bfcViQifT0EnuLazBJP+RPyjJedUNb+XaGcQSXhNUZkgOYt7ievywxjV1c2EE
         MJycHcYkWvToUmN9fth48vtDpbQ8998jU959vlLAp8q+kxszB9zEEIou0KXawjZ0tTVy
         gIKIwNNtpdmIBb2uKjvJhKJoClgHdIw4qEo3rWw4wDzrYVOCXfuwX/+junNVwel4K6KY
         DZMasQmbk8jAgtbeKOxbDF7OHmI6gInClz5ODkttVNJ9T4h+dbgBVX+8jOUQt572JzP/
         q1QAJRiIxjo0ghtkLxdrCVDrXpSQXDQivzghlBw2O5NyNSWzB32vrSjS7mHu9XuiTqWp
         PU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sQlK8EPAE1nmulIIgv5jRhcGPrhGOTgo4V3rKxqmaH4=;
        b=ihhJplcJAauYnY0HgcG3YkXHfxl7mhuz2c8hgx/C7N9Fv0jsv6cNKLkt+U5qhj5QOS
         vZWB6xxWTs+QhRKa0wUNiB6+LQ75soc/K28ZHSUj7/yFPYjKRDuWZbHy5nKXhzOEPWJH
         2Ep4qV1mS2JW9do706YKWHT3ex7B1zuP7IOrIdZInvaDIz4upvvyAwHH94U70+KYPjgo
         6aodm6wAqL138aRAwHA3KzBq2n4E/BwT9LXYB7O0NfDI5Y64wRFWpVouJpQ20haauh2n
         XwrCh53BBoUMAI8aJs2/cw3uawWHyLwAjIyTS7YLuDC1nJfosouZKUH6GZpnfVrwIOzJ
         /2+Q==
X-Gm-Message-State: AOAM5317jyU+y8nBUbtjnSw+etFFA5QG1RGAqWG+DE+N1rBXLdIEeyTT
        AU79Wsx66jTz3/iQE1fGE9qrZyt2cB/XhNdFdyBMVA==
X-Google-Smtp-Source: ABdhPJzma20Jw8z2jDhsEaXVdc6gwk7GyQZeyDajs1P9GPAR8KSzzRz5P+0if2lufkSUvXOh/v8I91ajvbIFbhkcjPg=
X-Received: by 2002:a17:906:6a0f:b0:6f5:15cf:2e5 with SMTP id
 qw15-20020a1709066a0f00b006f515cf02e5mr10844216ejc.584.1653099569797; Fri, 20
 May 2022 19:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <20220519093034.541481-1-eballetbo@kernel.org>
In-Reply-To: <20220519093034.541481-1-eballetbo@kernel.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 20 May 2022 19:19:18 -0700
Message-ID: <CABdmKX17aS3nh0UHf+FoM3VPdvMn5NvrZTkGSisznDgjZyeQxw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] gpu: rfc: Proposal for a GPU cgroup controller
To:     eballetbo@kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tejun Heo <tj@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Mark <lmark@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Laura Abbott <labbott@redhat.com>, cgroups@vger.kernel.org,
        kernel-team@android.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Carlos Llamas <cmllamas@google.com>,
        Daniel Vetter <daniel@ffwll.ch>, Kenny.Ho@amd.com,
        linux-kselftest@vger.kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        John Stultz <jstultz@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 19, 2022 at 2:31 AM <eballetbo@kernel.org> wrote:
>
> From: Enric Balletbo i Serra <eballetbo@kernel.org>
>
> On Tue, 10 May 2022 23:56:45 +0000, T.J. Mercier wrote:
> > From: Hridya Valsaraju <hridya@google.com>
> >
>
> Hi T.J. Mercier,
>
> Many thanks for this effort. It caught my attention because we might have=
 a use
> case where this feature can be useful for us. Hence I'd like to jump and =
be part
> of the discussion, I'd really appreciate if you can cc'me for next versio=
ns.
>
Hi Enric,

Sure thing, thanks for engaging.

> While reading the full patchset I was a bit confused about the status of =
this
> proposal. In fact, the rfc in the subject combined with the number of ite=
rations
> (already seven) confused me. So I'm wondering if this is a RFC or a 'real=
'
> proposal already that you want to land.
>
I'm sorry about this. I'm quite new to kernel development (this is my
first set of patches) and the point at which I should have
transitioned from RFC to PATCH was not clear to me. The status now
could be described as adding initial support for accounting that would
be built upon to expand what is tracked (more than just buffers from
heaps) and to add support for limiting. I see you have also commented
about this below.

> If this is still a RFC I'd remove the 'rfc: Proposal' and use the more ca=
nonical
> way that is put RFC in the []. I.e [PATCH RFC v7] cgroup: Add a GPU cgrou=
p
> controller.
>
> If it is not, I'd just remove the RFC and make the subject in the cgroup
> subsystem instead of the gpu. I.E [PATCH v7] cgroup: Add a GPU cgroup
>
> I don't want to nitpick but IMO that helps new people to join to the hist=
ory of
> the patchset.
>
> > This patch adds a proposal for a new GPU cgroup controller for
> > accounting/limiting GPU and GPU-related memory allocations.
>
> As far as I can see the only thing that is adding here is the accounting,=
 so I'd
> remove any reference to limiting and just explain what the patch really
> introduces, not the future, otherwise is confusing an you expect more tha=
n the
> patch really does.
>
> It is important maintain the commit message sync with what the patch real=
ly
> does.
>
Acknowledged, thank you.

> > The proposed controller is based on the DRM cgroup controller[1] and
> > follows the design of the RDMA cgroup controller.
> >
> > The new cgroup controller would:
> > * Allow setting per-device limits on the total size of buffers
> >   allocated by device within a cgroup.
> > * Expose a per-device/allocator breakdown of the buffers charged to a
> >   cgroup.
> >
> > The prototype in the following patches is only for memory accounting
> > using the GPU cgroup controller and does not implement limit setting.
> >
> > [1]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty=
@intel.com/
> >
>
> I think this is material for the cover more than the commit message. When=
 I read
> this I was expecting all this in this patch.
>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> > v7 changes
> > Remove comment about duplicate name rejection which is not relevant to
> > cgroups users per Michal Koutn=C3=BD.
> >
> > v6 changes
> > Move documentation into cgroup-v2.rst per Tejun Heo.
> >
> > v5 changes
> > Drop the global GPU cgroup "total" (sum of all device totals) portion
> > of the design since there is no currently known use for this per
> > Tejun Heo.
> >
> > Update for renamed functions/variables.
> >
> > v3 changes
> > Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz.
> >
> > Use more common dual author commit message format per John Stultz.
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 69d7a6983f78..2e1d26e327c7 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2352,6 +2352,29 @@ first, and stays charged to that cgroup until th=
at resource is freed. Migrating
> >  a process to a different cgroup does not move the charge to the destin=
ation
> >  cgroup where the process has moved.
> >
> > +
> > +GPU
> > +---
> > +
> > +The GPU controller accounts for device and system memory allocated by =
the GPU
> > +and related subsystems for graphics use. Resource limits are not curre=
ntly
> > +supported.
> > +
> > +GPU Interface Files
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +  gpu.memory.current
> > +     A read-only file containing memory allocations in flat-keyed form=
at. The key
> > +     is a string representing the device name. The value is the size o=
f the memory
> > +     charged to the device in bytes. The device names are globally uni=
que.::
> > +
> > +       $ cat /sys/kernel/fs/cgroup1/gpu.memory.current
>
> I think this is outdated, you are using cgroup v2, right?
>
Oh "cgroup1" was meant to refer to the name of a cgroup, not to cgroup
v1. A different name would be better here.

> > +       dev1 4194304
> > +       dev2 104857600
> > +
>
> When I applied the full series I was expecting see the memory allocated b=
y the
> gpu devices or users of the gpu in this file but, after some experiments,=
 what I
> saw is the memory allocated via any process that uses the dma-buf heap AP=
I (not
> necessary gpu users). For example, if you create a small program that all=
ocates
> some memory via the dma-buf heap API and then you cat the gpu.memory.curr=
ent
> file, you see that the memory accounted is not related to the gpu.
>
> This is really confusing, looks to me that the patches evolved to account=
 memory
> that is not really related to the GPU but allocated vi the dma-buf heap A=
PI. IMO
> the name of the file should be according to what really does to avoid
> confusions.
>
> So, is this patchset meant to be GPU specific? If the answer is yes that'=
s good
> but that's not what I experienced. I'm missing something?
>
There are two reasons this exists as a GPU controller. The first is
that most graphics buffers in Android come from these heaps, and this
is primarily what we are interested in accounting. However the idea is
to account other graphics memory types more commonly used on desktop
under different resource names with this controller. The second reason
predates my involvement, but my understanding is that Hridya tried to
upstream heap tracking via tracepoints but was asked to try to use GPU
cgroups instead, which led to her initial version of this series. So
this is a starting point. Any commentary on why this controller would
our would not work for any use cases you have in mind (provided the
appropriate charging/uncharging code is plugged in) would be
appreciated!

By the way, discussion around earlier proposals on this topic
suggested the "G" should be for "general" instead of "graphics", I
think in recognition of the breadth of resources that would eventually
be tracked by it.
https://lore.kernel.org/amd-gfx/YBp4ap+1l2KWbqEJ@phenom.ffwll.local/



> If the answer is that evolved to track dma-buf heap allocations I think a=
ll the
> patches need some rework to adapt the wording as right now, the gpu wordi=
ng
> seems confusing to me.
>
> > +     The device name string is set by a device driver when it register=
s with the
> > +     GPU cgroup controller to participate in resource accounting.
> > +
> >  Others
> >  ------
> >
> >
> Thanks,
>  Enric
>
