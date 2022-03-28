Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD234E9EF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiC1SaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiC1SaT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 14:30:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5913E1C
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 11:28:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so30466820ejd.5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WaH8oTp9zQ4RiMod88tKNM8FNGzolc7NDGliqXEyFM=;
        b=RA1LFZlyqYnQKlZhfG5eW4EytFq6FXGfsjb2/DOkWkAoisIvQquLsZTwb8nBtNlht8
         ZHqiJ/MOFhcB+HyYDg4DOrCFHvXKNreT5wQEPJ7PzPnMoI2QrObdeAd08uOLLZhCsV8Y
         oo/fwNelFB8E06amjBdYhwsR2VhATbyd3kx12XlxxP1sGczHl+YWk9N47mzb48HohD17
         d9HYqBqtvUEw1TYZH7O9tEkaSoRyqnabxydRHWLDA8W6lAvtHgHxiIUB7dc49IG+TBgi
         G8ykTzQvXQ9aD4+tQHre6cRAhm0yoObw1rfkn0AAPUuFF1ZU/BUjCdEdRxBpKxz80uJg
         RymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WaH8oTp9zQ4RiMod88tKNM8FNGzolc7NDGliqXEyFM=;
        b=fCDT/fuMHGRwh3KUg3ju6vWxL7mLIhSS0IQvDd4gk6jWTHKNyxCyQBcpk8P9P0DcDe
         ifEejpR7mZ85nrV32CN/e0mC029OU80NyOwfjhmIzHEIB+Y8bC8vXh0jggQZi23aN0nW
         iGdYDaA3wdmTl0eOchvR4WHwuBVDOdxU+WXLFCsKn+4jTtqyPqzJdTwXZt5Bgad37nWw
         EBQVB97rIOAQkgO/eHDbWWTgBmonVUmQG3QiD0xaPEP2zE0+OzkiSa6Ht2Pdz0PazLi6
         UxrJgwd4vc1Yf6EBoY+j1pqbxSKJDCgBhqf9DqSlHQbKPOe7n5jv2KLZ3bSlqb15fS4F
         mOxA==
X-Gm-Message-State: AOAM531iSCfM+Aznxj4vLUzKQJk1zr9PI6CpRHE4EHa2OjAXF8aMfTBp
        W3YAcygoKOm4iJ6QLi6frsjUPHjrDt37ZpIdlok/yQ==
X-Google-Smtp-Source: ABdhPJz3R1rYGKfMgCT8Xw+uvi6MQu9Vw8tO6cBRgeUu+llCkBBC4HKzRw85BEQANrPE+Bd5D9ZFeLO+o1zCssURxAk=
X-Received: by 2002:a17:906:9754:b0:6da:7d72:1353 with SMTP id
 o20-20020a170906975400b006da7d721353mr29368499ejy.273.1648492115577; Mon, 28
 Mar 2022 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-5-tjmercier@google.com> <YkHH/0Use7F30UUE@phenom.ffwll.local>
In-Reply-To: <YkHH/0Use7F30UUE@phenom.ffwll.local>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 28 Mar 2022 11:28:24 -0700
Message-ID: <CABdmKX01p6g_iHsB6dd4Wwh=8iLdYiUqdY6_yyA5ax2YNHt6tQ@mail.gmail.com>
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

On Mon, Mar 28, 2022 at 7:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Mar 28, 2022 at 03:59:43AM +0000, T.J. Mercier wrote:
> > From: Hridya Valsaraju <hridya@google.com>
> >
> > All DMA heaps now register a new GPU cgroup device upon creation, and t=
he
> > system_heap now exports buffers associated with its GPU cgroup device f=
or
> > tracking purposes.
> >
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >
> > ---
> > v3 changes
> > Use more common dual author commit message format per John Stultz.
> >
> > v2 changes
> > Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
> > heap to a single dma-buf function for all heaps per Daniel Vetter and
> > Christian K=C3=B6nig.
>
> Apologies for being out of the loop quite a bit. I scrolled through this
> all and I think it looks good to get going.
>
> The only thing I have is whether we should move the cgroup controllers ou=
t
> of dma-buf heaps, since that's rather android centric. E.g.
> - a system gpucg_device which is used by all the various single page
>   allocators (dma-buf heap but also shmem helpers and really anything
>   else)
> - same for cma, again both for dma-buf heaps and also for the gem cma
>   helpers in drm

Thanks Daniel, in general that makes sense to me as an approach to
making this more universal. However for the Android case I'm not sure
if the part about a single system gpucg_device would be sufficient,
because there are at least 12 different graphics related heaps that
could potentially be accounted/limited differently. [1]  So that
raises the question of how fine grained we want this to be... I tend
towards separating them all, but I haven't formed a strong opinion
about this at the moment. It sounds like you are in favor of a
smaller, more rigidly defined set of them? Either way, we need to add
code for accounting at points where we know memory is specifically for
graphics use and not something else right? (I.E. Whether it is a
dma-buf heap or somewhere like drm_gem_object_init.) So IIUC the only
question is what to use for the gpucg_device(s) at these locations.

[1] https://cs.android.com/android/platform/superproject/+/master:hardware/=
google/graphics/common/libion/ion.cpp;l=3D39-50

>
> Otherwise this will only work on non-upstream android where gpu drivers
> allocate everything from dma-buf heap. If you use something like the x86
> android project with mesa drivers, then driver-internal buffers will be
> allocated through gem and not through dma-buf heaps. Or at least I think
> that's how it works.
>
> But also meh, we can fix this fairly easily later on by adding these
> standard gpucg_dev somwehere with a bit of kerneldoc.

This is what I was thinking would happen next, but IDK if anyone sees
a more central place to do this type of use-specific accounting.

>
> Anyway has my all my ack, but don't count this as my in-depth review :-)
> -Daniel

Thanks again for taking a look!
>
> > ---
> >  drivers/dma-buf/dma-heap.c          | 27 +++++++++++++++++++++++++++
> >  drivers/dma-buf/heaps/system_heap.c |  3 +++
> >  include/linux/dma-heap.h            | 11 +++++++++++
> >  3 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 8f5848aa144f..885072427775 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <linux/cdev.h>
> > +#include <linux/cgroup_gpu.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> > @@ -31,6 +32,7 @@
> >   * @heap_devt                heap device node
> >   * @list             list head connecting to list of heaps
> >   * @heap_cdev                heap char device
> > + * @gpucg_dev                gpu cgroup device for memory accounting
> >   *
> >   * Represents a heap of memory from which buffers can be made.
> >   */
> > @@ -41,6 +43,9 @@ struct dma_heap {
> >       dev_t heap_devt;
> >       struct list_head list;
> >       struct cdev heap_cdev;
> > +#ifdef CONFIG_CGROUP_GPU
> > +     struct gpucg_device gpucg_dev;
> > +#endif
> >  };
> >
> >  static LIST_HEAD(heap_list);
> > @@ -216,6 +221,26 @@ const char *dma_heap_get_name(struct dma_heap *hea=
p)
> >       return heap->name;
> >  }
> >
> > +#ifdef CONFIG_CGROUP_GPU
> > +/**
> > + * dma_heap_get_gpucg_dev() - get struct gpucg_device for the heap.
> > + * @heap: DMA-Heap to get the gpucg_device struct for.
> > + *
> > + * Returns:
> > + * The gpucg_device struct for the heap. NULL if the GPU cgroup contro=
ller is
> > + * not enabled.
> > + */
> > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> > +{
> > +     return &heap->gpucg_dev;
> > +}
> > +#else /* CONFIG_CGROUP_GPU */
> > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> > +{
> > +     return NULL;
> > +}
> > +#endif /* CONFIG_CGROUP_GPU */
> > +
> >  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_i=
nfo)
> >  {
> >       struct dma_heap *heap, *h, *err_ret;
> > @@ -288,6 +313,8 @@ struct dma_heap *dma_heap_add(const struct dma_heap=
_export_info *exp_info)
> >       list_add(&heap->list, &heap_list);
> >       mutex_unlock(&heap_list_lock);
> >
> > +     gpucg_register_device(dma_heap_get_gpucg_dev(heap), exp_info->nam=
e);
> > +
> >       return heap;
> >
> >  err2:
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index ab7fd896d2c4..752a05c3cfe2 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -395,6 +395,9 @@ static struct dma_buf *system_heap_allocate(struct =
dma_heap *heap,
> >       exp_info.ops =3D &system_heap_buf_ops;
> >       exp_info.size =3D buffer->len;
> >       exp_info.flags =3D fd_flags;
> > +#ifdef CONFIG_CGROUP_GPU
> > +     exp_info.gpucg_dev =3D dma_heap_get_gpucg_dev(heap);
> > +#endif
> >       exp_info.priv =3D buffer;
> >       dmabuf =3D dma_buf_export(&exp_info);
> >       if (IS_ERR(dmabuf)) {
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index 0c05561cad6e..e447a61d054e 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -10,6 +10,7 @@
> >  #define _DMA_HEAPS_H
> >
> >  #include <linux/cdev.h>
> > +#include <linux/cgroup_gpu.h>
> >  #include <linux/types.h>
> >
> >  struct dma_heap;
> > @@ -59,6 +60,16 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
> >   */
> >  const char *dma_heap_get_name(struct dma_heap *heap);
> >
> > +/**
> > + * dma_heap_get_gpucg_dev() - get a pointer to the struct gpucg_device=
 for the
> > + * heap.
> > + * @heap: DMA-Heap to retrieve gpucg_device for.
> > + *
> > + * Returns:
> > + * The gpucg_device struct for the heap.
> > + */
> > +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap);
> > +
> >  /**
> >   * dma_heap_add - adds a heap to dmabuf heaps
> >   * @exp_info:                information needed to register this heap
> > --
> > 2.35.1.1021.g381101b075-goog
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
