Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7B4E99D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiC1Oie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiC1Oid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 10:38:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CE5DE56
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 07:36:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d7so20709070wrb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v/hbcKwqx1gvBKjVXl56S5be+OnNXrcnFIQY2VQf+GQ=;
        b=P3s83mzPAy1oHFyyIJNDomqrIFEN+HTK2X/xxvM6jHZRRhY1ia7LMcyS1CUq2WRLIt
         5SoYJ0xl/ZAWRBo9MGjmVgpPNSAyN2Cue489qnIcE9rOOsVfG8KpauNpaa5c3+CHpQSK
         gw9dIkAY9rZoEPI7OMXBY9dnJLfptFfKQMVcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=v/hbcKwqx1gvBKjVXl56S5be+OnNXrcnFIQY2VQf+GQ=;
        b=yTkyzhSiEU6RjOE+44zdYq4pnr9E1d+p+zRJaIQojyh+qy4+fz8o/+fs3AN+L7nlD/
         WDx7ZYI0iBN3c2oWwZDHR9BQ7+mi2pKN1hh2S4p5HYHMT8jCvEskNHehlxpwf/SmnRed
         YLHR8HeIrHiUnYLWsQEOXpoBmbXoNIeh7dWqIfF7jVP9B8LTnbnWkdqMSF5eTRYLM5d8
         yVbDnJbe21avAFVnfAY5xVlQdvw+xE2twtHC+ZWrDmLVOffZUHR7mlNhz7Bk0DpSmCFj
         3ubBixLERXNUmfMd/sfqGE/A+5Wx88V01BDTfGVbhJfR8nLW8mhO4TeQVOagUFgONtd3
         78SA==
X-Gm-Message-State: AOAM531zqpTP4acCxWcLG6bHDPmkb6wYrU7zHYkb7t96xdsgzG9MFA7c
        r8vjo4nnZx2A4bdS3DaZP9B6CQ==
X-Google-Smtp-Source: ABdhPJy2uVCV4k6lowv1jCTyfpTR0BZIIfD37/lbvSmV0qb6ifIlu4g+nMA4zLZtNKGFclvcpohivw==
X-Received: by 2002:a5d:6d8a:0:b0:204:909:2d9a with SMTP id l10-20020a5d6d8a000000b0020409092d9amr25002730wrs.435.1648478210133;
        Mon, 28 Mar 2022 07:36:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm16778890wms.30.2022.03.28.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:36:49 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:36:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, kaleshsingh@google.com,
        Kenny.Ho@amd.com, mkoutny@suse.com, skhan@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC v4 4/8] dmabuf: heaps: export system_heap buffers with GPU
 cgroup charging
Message-ID: <YkHH/0Use7F30UUE@phenom.ffwll.local>
Mail-Followup-To: "T.J. Mercier" <tjmercier@google.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
        kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220328035951.1817417-1-tjmercier@google.com>
 <20220328035951.1817417-5-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220328035951.1817417-5-tjmercier@google.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 28, 2022 at 03:59:43AM +0000, T.J. Mercier wrote:
> From: Hridya Valsaraju <hridya@google.com>
> 
> All DMA heaps now register a new GPU cgroup device upon creation, and the
> system_heap now exports buffers associated with its GPU cgroup device for
> tracking purposes.
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> 
> ---
> v3 changes
> Use more common dual author commit message format per John Stultz.
> 
> v2 changes
> Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
> heap to a single dma-buf function for all heaps per Daniel Vetter and
> Christian König.

Apologies for being out of the loop quite a bit. I scrolled through this
all and I think it looks good to get going.

The only thing I have is whether we should move the cgroup controllers out
of dma-buf heaps, since that's rather android centric. E.g.
- a system gpucg_device which is used by all the various single page
  allocators (dma-buf heap but also shmem helpers and really anything
  else)
- same for cma, again both for dma-buf heaps and also for the gem cma
  helpers in drm

Otherwise this will only work on non-upstream android where gpu drivers
allocate everything from dma-buf heap. If you use something like the x86
android project with mesa drivers, then driver-internal buffers will be
allocated through gem and not through dma-buf heaps. Or at least I think
that's how it works.

But also meh, we can fix this fairly easily later on by adding these
standard gpucg_dev somwehere with a bit of kerneldoc.

Anyway has my all my ack, but don't count this as my in-depth review :-)
-Daniel

> ---
>  drivers/dma-buf/dma-heap.c          | 27 +++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/system_heap.c |  3 +++
>  include/linux/dma-heap.h            | 11 +++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 8f5848aa144f..885072427775 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/cdev.h>
> +#include <linux/cgroup_gpu.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
> @@ -31,6 +32,7 @@
>   * @heap_devt		heap device node
>   * @list		list head connecting to list of heaps
>   * @heap_cdev		heap char device
> + * @gpucg_dev		gpu cgroup device for memory accounting
>   *
>   * Represents a heap of memory from which buffers can be made.
>   */
> @@ -41,6 +43,9 @@ struct dma_heap {
>  	dev_t heap_devt;
>  	struct list_head list;
>  	struct cdev heap_cdev;
> +#ifdef CONFIG_CGROUP_GPU
> +	struct gpucg_device gpucg_dev;
> +#endif
>  };
>  
>  static LIST_HEAD(heap_list);
> @@ -216,6 +221,26 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  	return heap->name;
>  }
>  
> +#ifdef CONFIG_CGROUP_GPU
> +/**
> + * dma_heap_get_gpucg_dev() - get struct gpucg_device for the heap.
> + * @heap: DMA-Heap to get the gpucg_device struct for.
> + *
> + * Returns:
> + * The gpucg_device struct for the heap. NULL if the GPU cgroup controller is
> + * not enabled.
> + */
> +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> +{
> +	return &heap->gpucg_dev;
> +}
> +#else /* CONFIG_CGROUP_GPU */
> +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_CGROUP_GPU */
> +
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  {
>  	struct dma_heap *heap, *h, *err_ret;
> @@ -288,6 +313,8 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  	list_add(&heap->list, &heap_list);
>  	mutex_unlock(&heap_list_lock);
>  
> +	gpucg_register_device(dma_heap_get_gpucg_dev(heap), exp_info->name);
> +
>  	return heap;
>  
>  err2:
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index ab7fd896d2c4..752a05c3cfe2 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -395,6 +395,9 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	exp_info.ops = &system_heap_buf_ops;
>  	exp_info.size = buffer->len;
>  	exp_info.flags = fd_flags;
> +#ifdef CONFIG_CGROUP_GPU
> +	exp_info.gpucg_dev = dma_heap_get_gpucg_dev(heap);
> +#endif
>  	exp_info.priv = buffer;
>  	dmabuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dmabuf)) {
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> index 0c05561cad6e..e447a61d054e 100644
> --- a/include/linux/dma-heap.h
> +++ b/include/linux/dma-heap.h
> @@ -10,6 +10,7 @@
>  #define _DMA_HEAPS_H
>  
>  #include <linux/cdev.h>
> +#include <linux/cgroup_gpu.h>
>  #include <linux/types.h>
>  
>  struct dma_heap;
> @@ -59,6 +60,16 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
>   */
>  const char *dma_heap_get_name(struct dma_heap *heap);
>  
> +/**
> + * dma_heap_get_gpucg_dev() - get a pointer to the struct gpucg_device for the
> + * heap.
> + * @heap: DMA-Heap to retrieve gpucg_device for.
> + *
> + * Returns:
> + * The gpucg_device struct for the heap.
> + */
> +struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap);
> +
>  /**
>   * dma_heap_add - adds a heap to dmabuf heaps
>   * @exp_info:		information needed to register this heap
> -- 
> 2.35.1.1021.g381101b075-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
