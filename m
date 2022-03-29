Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664B4EB2F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiC2RyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiC2RyQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 13:54:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB31E7A50
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 10:52:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bi12so36742871ejb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6WzK0iEK1tA2vwWOojnK+sRWtG13aOccwS9qWJMzFmw=;
        b=eRTnso2DqyGizkbBzNBOPjTRvAPn3ud895nlnWhPZ4UjGAm0OZxfB37FkU+nLvw6Cx
         OjNt45Va6PSjR4jK/bub1G1Q3eTo2GeQB+9pmTpO4CEGMm7rql+cSZ6Fk7LljiP+p10C
         lxPJry/Sh5OS2akJE+Ov36FPSfFSIUMNK+CUkcmjeNbw5ebd8aKUtviSH7NrYxnUal9v
         ZfK1nt8TTht/oGsn1JXKfPS1WbWw3Q7+dKjy0p0lvMt7OfpCHQtlvvmCSVRY3NAuMarF
         eEYs9Y4FfbPI1RoXStyWd/49c6fAbwgFa8ui0Ba0QbKPeSvOkII27LGSKggdYimqvZpK
         U24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6WzK0iEK1tA2vwWOojnK+sRWtG13aOccwS9qWJMzFmw=;
        b=vtxDY39gf4g94cFWBFsC6Dp7LA98R79fRg28hh3Z6KF/vE6rkJPUadXMg+eDZnR7l2
         I9Ch1QqrokD0qTun9316r9r6QEVLk55npCm/FTYVOz+L9vPVLej4najzSSqYsGuYU8Zg
         bUUHxrdIBYf3Xmoozdr4eLTfedoRW39PPOe3I7G6rfnr8Rz5qyBGlhsmWUtgU9utHZ+8
         0WuhRe2N3HkRFl69lbpBMuDmnwA4YyjwW8/PkU2aZem/7jzRyvbqcbqz6AxOitl/BixR
         0memDl0BhBQz69ax7YKgmgAowoSZQNitDHrBlCJXTYob2WBrXP34/4H6sjn4ziL4KqqO
         ItEQ==
X-Gm-Message-State: AOAM530tr0F4UqVMNuwscs25znJnZ09mCYXXcL4o7abJZSuC98zZPGmL
        qRDzoxJv/22/hUYOYtzGQOv5dACqMiFGJt5MjXV5Kg==
X-Google-Smtp-Source: ABdhPJzx0jIB+gd95cXgDa86T7iu7mfLoNBMM7kkuNLnofhq390upFsiPfmT/1TUlLYpMv2RfthsZvb3eTbeyPWrUYk=
X-Received: by 2002:a17:906:5d08:b0:6da:b4ea:937 with SMTP id
 g8-20020a1709065d0800b006dab4ea0937mr37059399ejt.446.1648576349854; Tue, 29
 Mar 2022 10:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-5-tjmercier@google.com> <YkHH/0Use7F30UUE@phenom.ffwll.local>
 <CABdmKX01p6g_iHsB6dd4Wwh=8iLdYiUqdY6_yyA5ax2YNHt6tQ@mail.gmail.com> <YkLGbL5Z3HVCyVkK@phenom.ffwll.local>
In-Reply-To: <YkLGbL5Z3HVCyVkK@phenom.ffwll.local>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 29 Mar 2022 10:52:18 -0700
Message-ID: <CABdmKX3gTAohaOwkNccGrQyXN9tzT-oEVibO5ZPF+eP+Vq=AOg@mail.gmail.com>
Subject: Re: [RFC v4 4/8] dmabuf: heaps: export system_heap buffers with GPU
 cgroup charging
To:     "T.J. Mercier" <tjmercier@google.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
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

On Tue, Mar 29, 2022 at 1:42 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Mar 28, 2022 at 11:28:24AM -0700, T.J. Mercier wrote:
> > On Mon, Mar 28, 2022 at 7:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Mon, Mar 28, 2022 at 03:59:43AM +0000, T.J. Mercier wrote:
> > > > From: Hridya Valsaraju <hridya@google.com>
> > > >
> > > > All DMA heaps now register a new GPU cgroup device upon creation, a=
nd the
> > > > system_heap now exports buffers associated with its GPU cgroup devi=
ce for
> > > > tracking purposes.
> > > >
> > > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > >
> > > > ---
> > > > v3 changes
> > > > Use more common dual author commit message format per John Stultz.
> > > >
> > > > v2 changes
> > > > Move dma-buf cgroup charge transfer from a dma_buf_op defined by ev=
ery
> > > > heap to a single dma-buf function for all heaps per Daniel Vetter a=
nd
> > > > Christian K=C3=B6nig.
> > >
> > > Apologies for being out of the loop quite a bit. I scrolled through t=
his
> > > all and I think it looks good to get going.
> > >
> > > The only thing I have is whether we should move the cgroup controller=
s out
> > > of dma-buf heaps, since that's rather android centric. E.g.
> > > - a system gpucg_device which is used by all the various single page
> > >   allocators (dma-buf heap but also shmem helpers and really anything
> > >   else)
> > > - same for cma, again both for dma-buf heaps and also for the gem cma
> > >   helpers in drm
> >
> > Thanks Daniel, in general that makes sense to me as an approach to
> > making this more universal. However for the Android case I'm not sure
> > if the part about a single system gpucg_device would be sufficient,
> > because there are at least 12 different graphics related heaps that
> > could potentially be accounted/limited differently. [1]  So that
> > raises the question of how fine grained we want this to be... I tend
> > towards separating them all, but I haven't formed a strong opinion
> > about this at the moment. It sounds like you are in favor of a
> > smaller, more rigidly defined set of them? Either way, we need to add
> > code for accounting at points where we know memory is specifically for
> > graphics use and not something else right? (I.E. Whether it is a
> > dma-buf heap or somewhere like drm_gem_object_init.) So IIUC the only
> > question is what to use for the gpucg_device(s) at these locations.
>
> We don't have 12 in upstream, so this is a lot easier here :-)
>
> I'm not exactly sure why you have such a huge pile of them.
>
> For gem buffers it would be fairly similar to what you've done for dma-bu=
f
> heaps I think, with the various helper libraries (drivers stopped
> hand-rolling their gem buffer) setting the right accounting group. And
> yeah for system memory I think we'd need to have standard ones, for drive=
r
> specific ones it's kinda different.
>
> > [1] https://cs.android.com/android/platform/superproject/+/master:hardw=
are/google/graphics/common/libion/ion.cpp;l=3D39-50
> >
> > >
> > > Otherwise this will only work on non-upstream android where gpu drive=
rs
> > > allocate everything from dma-buf heap. If you use something like the =
x86
> > > android project with mesa drivers, then driver-internal buffers will =
be
> > > allocated through gem and not through dma-buf heaps. Or at least I th=
ink
> > > that's how it works.
> > >
> > > But also meh, we can fix this fairly easily later on by adding these
> > > standard gpucg_dev somwehere with a bit of kerneldoc.
> >
> > This is what I was thinking would happen next, but IDK if anyone sees
> > a more central place to do this type of use-specific accounting.
>
> Hm I just realized ... are the names in the groups abi? If yes then I
> think we need to fix this before we merge anything.
> -Daniel

Do you mean the set of possible names being part of the ABI for GPU
cgroups? I'm not exactly sure what you mean here.

The name is a settable string inside the gpucg_device struct, and
right now the docs say it must be from a string literal but this can
be changed. The only one this patchset adds is "system", which comes
from the name field in its dma_heap_export_info struct when it's first
created (and that string is hardcoded). The heap gpucg_devices are all
registered from one spot in dma-heap.c, so maybe we should append
"-heap" to the gpucg_device names there so "system" is available for a
standardized name. Let me make those two changes, and I will also
rebase this series before resending.



>
> >
> > >
> > > Anyway has my all my ack, but don't count this as my in-depth review =
:-)
> > > -Daniel
> >
> > Thanks again for taking a look!
> > >
> > > > ---
> > > >  drivers/dma-buf/dma-heap.c          | 27 +++++++++++++++++++++++++=
++
> > > >  drivers/dma-buf/heaps/system_heap.c |  3 +++
> > > >  include/linux/dma-heap.h            | 11 +++++++++++
> > > >  3 files changed, 41 insertions(+)
> > > >
> > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.=
c
> > > > index 8f5848aa144f..885072427775 100644
> > > > --- a/drivers/dma-buf/dma-heap.c
> > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > @@ -7,6 +7,7 @@
> > > >   */
> > > >
> > > >  #include <linux/cdev.h>
> > > > +#include <linux/cgroup_gpu.h>
> > > >  #include <linux/debugfs.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/dma-buf.h>
> > > > @@ -31,6 +32,7 @@
> > > >   * @heap_devt                heap device node
> > > >   * @list             list head connecting to list of heaps
> > > >   * @heap_cdev                heap char device
> > > > + * @gpucg_dev                gpu cgroup device for memory accounti=
ng
> > > >   *
> > > >   * Represents a heap of memory from which buffers can be made.
> > > >   */
> > > > @@ -41,6 +43,9 @@ struct dma_heap {
> > > >       dev_t heap_devt;
> > > >       struct list_head list;
> > > >       struct cdev heap_cdev;
> > > > +#ifdef CONFIG_CGROUP_GPU
> > > > +     struct gpucg_device gpucg_dev;
> > > > +#endif
> > > >  };
> > > >
> > > >  static LIST_HEAD(heap_list);
> > > > @@ -216,6 +221,26 @@ const char *dma_heap_get_name(struct dma_heap =
*heap)
> > > >       return heap->name;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_CGROUP_GPU
> > > > +/**
> > > > + * dma_heap_get_gpucg_dev() - get struct gpucg_device for the heap=
.
> > > > + * @heap: DMA-Heap to get the gpucg_device struct for.
> > > > + *
> > > > + * Returns:
> > > > + * The gpucg_device struct for the heap. NULL if the GPU cgroup co=
ntroller is
> > > > + * not enabled.
> > > > + */
> > > > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> > > > +{
> > > > +     return &heap->gpucg_dev;
> > > > +}
> > > > +#else /* CONFIG_CGROUP_GPU */
> > > > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> > > > +{
> > > > +     return NULL;
> > > > +}
> > > > +#endif /* CONFIG_CGROUP_GPU */
> > > > +
> > > >  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *e=
xp_info)
> > > >  {
> > > >       struct dma_heap *heap, *h, *err_ret;
> > > > @@ -288,6 +313,8 @@ struct dma_heap *dma_heap_add(const struct dma_=
heap_export_info *exp_info)
> > > >       list_add(&heap->list, &heap_list);
> > > >       mutex_unlock(&heap_list_lock);
> > > >
> > > > +     gpucg_register_device(dma_heap_get_gpucg_dev(heap), exp_info-=
>name);
> > > > +
> > > >       return heap;
> > > >
> > > >  err2:
> > > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> > > > index ab7fd896d2c4..752a05c3cfe2 100644
> > > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > > @@ -395,6 +395,9 @@ static struct dma_buf *system_heap_allocate(str=
uct dma_heap *heap,
> > > >       exp_info.ops =3D &system_heap_buf_ops;
> > > >       exp_info.size =3D buffer->len;
> > > >       exp_info.flags =3D fd_flags;
> > > > +#ifdef CONFIG_CGROUP_GPU
> > > > +     exp_info.gpucg_dev =3D dma_heap_get_gpucg_dev(heap);
> > > > +#endif
> > > >       exp_info.priv =3D buffer;
> > > >       dmabuf =3D dma_buf_export(&exp_info);
> > > >       if (IS_ERR(dmabuf)) {
> > > > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > > > index 0c05561cad6e..e447a61d054e 100644
> > > > --- a/include/linux/dma-heap.h
> > > > +++ b/include/linux/dma-heap.h
> > > > @@ -10,6 +10,7 @@
> > > >  #define _DMA_HEAPS_H
> > > >
> > > >  #include <linux/cdev.h>
> > > > +#include <linux/cgroup_gpu.h>
> > > >  #include <linux/types.h>
> > > >
> > > >  struct dma_heap;
> > > > @@ -59,6 +60,16 @@ void *dma_heap_get_drvdata(struct dma_heap *heap=
);
> > > >   */
> > > >  const char *dma_heap_get_name(struct dma_heap *heap);
> > > >
> > > > +/**
> > > > + * dma_heap_get_gpucg_dev() - get a pointer to the struct gpucg_de=
vice for the
> > > > + * heap.
> > > > + * @heap: DMA-Heap to retrieve gpucg_device for.
> > > > + *
> > > > + * Returns:
> > > > + * The gpucg_device struct for the heap.
> > > > + */
> > > > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)=
;
> > > > +
> > > >  /**
> > > >   * dma_heap_add - adds a heap to dmabuf heaps
> > > >   * @exp_info:                information needed to register this h=
eap
> > > > --
> > > > 2.35.1.1021.g381101b075-goog
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
