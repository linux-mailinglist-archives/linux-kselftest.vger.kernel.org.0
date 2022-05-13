Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEE5266D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381756AbiEMQO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381684AbiEMQNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 12:13:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9534552F;
        Fri, 13 May 2022 09:13:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i17so8371184pla.10;
        Fri, 13 May 2022 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n4Ua5qSAHgvrptVTXpgV4jY28Fp/1ApPJcGYkkazweE=;
        b=dh+CcTt4AjCORsqV1ZODlBqFq+OvMka9auOOZykOuG9GwHD05RDvn63lEcsItiN2eH
         nH+MkFBQ8v1tdeWUMN4BRvaW+7Q1uwmQiOctS5wPsQLKRk5Ykt9si+fUFSf6n/at1dmY
         4JOHexwRERxmPXQVd5EWv4mWhFA3BXiW4pCX0ZdVzHtYoUWHmurH8uIA0uBpYInyofFZ
         pNEuW8xEgDqjAmuzWH27jn+y85YMNek74F2xgDatREWDoXEvBkL4SnO/axBiM7vQgUS4
         gbWP9yrJI2fCACw+ngKTCewWFxR85tswkrdeT3TpOZ3UiGjOL9rgao5yscsrH/9y3/bl
         VBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n4Ua5qSAHgvrptVTXpgV4jY28Fp/1ApPJcGYkkazweE=;
        b=QcsytHXlMbPTEHIYFvpnQDkGksrZ4wabpvWRsXAT2RgqsbxfmSlmSamGthRC9S/PDz
         mmgpmAjPFz0JpDvkg9BuABJxKgKuE+l8IRaLRUCj5oFqtZLe9P9za9AJHpAr/V4Oyg3E
         BAm2ptrGTLLFB+n/+yg4VwWeVYZfh1Uf74vSWF+Z+PW77xIVD75tk2waNk8AzGckea6L
         hEP3Z7sIw4rRwf5ye22GhKy7ssQsCLvVJwjDZfSIBBx9QjO2pQShpv7pxWsLR9Jwq3fQ
         gQeD7UFwkGxsGjk4bQtspjwrLp6IxFViZGlY/wNSj/e7qdM0+ssS7W31NHvUrKu+yHRv
         qSqg==
X-Gm-Message-State: AOAM531ktAfLKnLfVG9t7Q1On4bEYj0w7wx0itA1fhgeHk86GyWO5S4E
        3awW5GrZ/SEDAKBVvooj4g8=
X-Google-Smtp-Source: ABdhPJx/E0j2BSOqlsmETv4JaHt8kQAXKtx8000l3ywPW9tmB75Cv/mYY002CdT2AqHaPSsO5Oy1mQ==
X-Received: by 2002:a17:90b:17c4:b0:1de:c92c:ad91 with SMTP id me4-20020a17090b17c400b001dec92cad91mr5642606pjb.169.1652458407026;
        Fri, 13 May 2022 09:13:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:5607])
        by smtp.gmail.com with ESMTPSA id ip14-20020a17090b314e00b001d81a30c437sm1796573pjb.50.2022.05.13.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:13:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 May 2022 06:13:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
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
Message-ID: <Yn6DpUsoSz1/15Kc@slm.duckdns.org>
References: <20220510235653.933868-1-tjmercier@google.com>
 <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
 <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
 <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Thu, May 12, 2022 at 08:43:52PM -0700, T.J. Mercier wrote:
> > I'm actually happy I've asked this question, wasn't silly after all. I think the
> > problem here is a naming issue. What you really are monitor is "video memory",
> > which consist of a memory segment allocated to store data used to render images
> > (its not always images of course, GPU an VPU have specialized buffers for their
> > purpose).
> >
> > Whether this should be split between what is used specifically by the GPU
> > drivers, the display drivers, the VPU (CODEC and pre/post-processor) or camera
> > drivers is something that should be discussed. But in the current approach, you
> > really meant Video memory as a superset of the above. Personally, I think
> > generically (to de-Andronized your work), en-globing all video memory is
> > sufficient. What I fail to understand is how you will manage to distinguished
> > DMABuf Heap allocation (which are used outside of Android btw), from Video
> > allocation or other type of usage. I'm sure non-video usage will exist in the
> > future (think of machine learning, compute, other high bandwidth streaming
> > thingy ...)
> >
> Ok thank you for pointing out the naming issue. The naming is a
> consequence of the initial use case, but I guess it's too specific.
> What I want out of this change is that android can track dmabufs that
> come out of heaps, and drm can track gpu memory. But other drivers
> could track different resources under different names. Imagine this
> were called a buffer cgroup controller instead of a GPU cgroup
> controller. Then the use component ("video memory") isn't tied up with
> the name of the controller, but it's up to the name of the bucket the
> resource is tracked under. I think this meets the needs of the two use
> cases I'm aware of now, while leaving the door open to other future
> needs. Really the controller is just enabling abstract named buckets
> for tracking and eventually limiting a type of resource.

So, there hasn't been whole lot of discussion w/ other GPU folks and what
comes up still seems to indicate that we're still long way away from having
a meaningful gpu controller. For your use case, would it make sense to just
add dmabuf as a key to the misc controller? I'm not sure it makes sense to
push "gpu controller" forward if there's no conceptual consensus around what
resources are.

Thanks.

-- 
tejun
