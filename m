Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA31B525A4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 05:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376866AbiEMDoM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 23:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376851AbiEMDoJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 23:44:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300526CC5D
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 20:44:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so13765506ejj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bHsWM+Jemo/IE4V7RB9cRdmEwCfy/dzIlfh2KyXi40c=;
        b=dqoqhLTVommukWekYXATDCaajEGXoveHVJmfJOKBRldg0JkH4yFwr2l/vQj5BS97A9
         rTE2HKI8YMS4d/BBQJYi8PV2Xu+6CeAv6NQ1cUu7H2cN1JYq7xRWmcS0+2US8Rr7zlsH
         OzLSSGQ2v/1eFDvg8T13gqwohDRs9o8pe82KgEHBthUwlYbRd/pI5cgIXPmpkg+n5onV
         f9w/U2YFs6VFgaf8XeKnhDaCQqmYU0OAq49VXMalEEsW0GipsQNm4eJcukacT8AMi3Vl
         PWyBTDGEl7JI0LagbJfAT7VQicCGnLaX6ZKI5KP4duD6OPAgmrMUvYCYFE+tla8aJ/V0
         LSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bHsWM+Jemo/IE4V7RB9cRdmEwCfy/dzIlfh2KyXi40c=;
        b=XABrn91GMYRhYITZQr4cEuExfqV190I8UzM8JypS735kFphV9yWmUO3ponksy1VU2P
         j4zAscosQjuHX++bzqbjZSxlxUjfAeHOKTYZcovxxVGtcHTRmJ4PSGL+qNNgmZBmHvLC
         XZ100Jr3/+pOMcGqiljYvPjYFRwIjW9BgGIbGI0prnff279laL4BBmWythjd6QUNXEtb
         QMivujQCFZLRTZXLPmZbSREVeqNNvcsLtkG47KIeX5ZSD3lxhGHH9alNEdmBfgJVfW6W
         tK0V4Fv++fkN+YvsfctxhU8ODxrDC7c5KNEuJZufepcs25GjKaJGnTJVtbUc/2zHYEYm
         IBEQ==
X-Gm-Message-State: AOAM531XxPVITox/KY0qK/zIgJmAAcx+TCAglV/8uPSEp7I9spHDOCyH
        NysDN1JiDSOIxpC1TExlwQpZL3GPk0z3lBfUpAZ8jg==
X-Google-Smtp-Source: ABdhPJwFWNh6XhDKKc51rh3sa/hEc/yEhfmKOtpU/oxW7nRCQ8tw7lmd0fC7np1TYyHXTpHiZPSDwI53NnVsPAxmJaA=
X-Received: by 2002:a17:906:6a0f:b0:6f5:15cf:2e5 with SMTP id
 qw15-20020a1709066a0f00b006f515cf02e5mr2476733ejc.584.1652413444067; Thu, 12
 May 2022 20:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com> <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
 <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com> <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
In-Reply-To: <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 12 May 2022 20:43:52 -0700
Message-ID: <CABdmKX2LxZ6zZR=fhXfnuWCB2BR+gzDd1-t1DD2A2XP24wvuGQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, May 12, 2022 at 6:10 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 11 mai 2022 =C3=A0 13:31 -0700, T.J. Mercier a =C3=A9crit :
> > On Wed, May 11, 2022 at 6:21 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > >
> > > Hi,
> > >
> > > Le mardi 10 mai 2022 =C3=A0 23:56 +0000, T.J. Mercier a =C3=A9crit :
> > > > This patch series revisits the proposal for a GPU cgroup controller=
 to
> > > > track and limit memory allocations by various device/allocator
> > > > subsystems. The patch series also contains a simple prototype to
> > > > illustrate how Android intends to implement DMA-BUF allocator
> > > > attribution using the GPU cgroup controller. The prototype does not
> > > > include resource limit enforcements.
> > >
> > > I'm sorry, since I'm not in-depth technically involve. But from readi=
ng the
> > > topic I don't understand the bound this creates between DMABuf Heaps =
and GPU. Is
> > > this an attempt to really track the DMABuf allocated by userland, or =
just
> > > something for GPU ? What about V4L2 devices ? Any way this can be cla=
rified,
> > > specially what would other subsystem needs to have cgroup DMABuf allo=
cation
> > > controller support ?
> > >
> > Hi Nicolas,
> >
> > The link between dmabufs, dmabuf heaps, and "GPU memory" is maybe
> > somewhat of an Androidism. However this change aims to be usable for
> > tracking all GPU related allocations. It's just that this initial
> > series only adds support for tracking dmabufs allocated from dmabuf
> > heaps.
> >
> > In Android most graphics buffers are dma buffers allocated from a
> > dmabuf heap, so that is why these dmabuf heap allocations are being
> > tracked under the GPU cgroup. Other dmabuf exporters like V4L2 might
> > also want to track their buffers, but would probably want to do so
> > under a bucket name of something like "v4l2". Same goes for GEM
> > dmabufs. The naming scheme for this is still yet to be decided. It
> > would be cool to be able to attribute memory at the driver level, or
> > even different types of memory at the driver level, but I imagine
> > there is a point of diminishing returns for fine-grained
> > naming/bucketing.
> >
> > So far, I haven't tried to create a strict definition of what is and
> > is not "GPU memory" for the purpose of this accounting, so I don't
> > think we should be restricted to tracking just dmabufs. I don't see
> > why this couldn't be anything a driver wants to consider as GPU memory
> > as long as it is named/bucketed appropriately, such as both on-package
> > graphics card memory use and CPU memory dedicated for graphics use
> > like for host/device transfers.
> >
> > Is that helpful?
>
> I'm actually happy I've asked this question, wasn't silly after all. I th=
ink the
> problem here is a naming issue. What you really are monitor is "video mem=
ory",
> which consist of a memory segment allocated to store data used to render =
images
> (its not always images of course, GPU an VPU have specialized buffers for=
 their
> purpose).
>
> Whether this should be split between what is used specifically by the GPU
> drivers, the display drivers, the VPU (CODEC and pre/post-processor) or c=
amera
> drivers is something that should be discussed. But in the current approac=
h, you
> really meant Video memory as a superset of the above. Personally, I think
> generically (to de-Andronized your work), en-globing all video memory is
> sufficient. What I fail to understand is how you will manage to distingui=
shed
> DMABuf Heap allocation (which are used outside of Android btw), from Vide=
o
> allocation or other type of usage. I'm sure non-video usage will exist in=
 the
> future (think of machine learning, compute, other high bandwidth streamin=
g
> thingy ...)
>
Ok thank you for pointing out the naming issue. The naming is a
consequence of the initial use case, but I guess it's too specific.
What I want out of this change is that android can track dmabufs that
come out of heaps, and drm can track gpu memory. But other drivers
could track different resources under different names. Imagine this
were called a buffer cgroup controller instead of a GPU cgroup
controller. Then the use component ("video memory") isn't tied up with
the name of the controller, but it's up to the name of the bucket the
resource is tracked under. I think this meets the needs of the two use
cases I'm aware of now, while leaving the door open to other future
needs. Really the controller is just enabling abstract named buckets
for tracking and eventually limiting a type of resource.

P.S. I will be unavailable starting tomorrow, but I'll be back on Monday.




> >
> > Best,
> > T.J.
> >
> > > >
> > > > Changelog:
> > > > v7:
> > > > Hide gpucg and gpucg_bucket struct definitions per Michal Koutn=C3=
=BD.
> > > > This means gpucg_register_bucket now returns an internally allocate=
d
> > > > struct gpucg_bucket.
> > > >
> > > > Move all public function documentation to the cgroup_gpu.h header.
> > > >
> > > > Remove comment in documentation about duplicate name rejection whic=
h
> > > > is not relevant to cgroups users per Michal Koutn=C3=BD.
> > > >
> > > > v6:
> > > > Move documentation into cgroup-v2.rst per Tejun Heo.
> > > >
> > > > Rename BINDER_FD{A}_FLAG_SENDER_NO_NEED ->
> > > > BINDER_FD{A}_FLAG_XFER_CHARGE per Carlos Llamas.
> > > >
> > > > Return error on transfer failure per Carlos Llamas.
> > > >
> > > > v5:
> > > > Rebase on top of v5.18-rc3
> > > >
> > > > Drop the global GPU cgroup "total" (sum of all device totals) porti=
on
> > > > of the design since there is no currently known use for this per
> > > > Tejun Heo.
> > > >
> > > > Fix commit message which still contained the old name for
> > > > dma_buf_transfer_charge per Michal Koutn=C3=BD.
> > > >
> > > > Remove all GPU cgroup code except what's necessary to support charg=
e transfer
> > > > from dma_buf. Previously charging was done in export, but for non-A=
ndroid
> > > > graphics use-cases this is not ideal since there may be a delay bet=
ween
> > > > allocation and export, during which time there is no accounting.
> > > >
> > > > Merge dmabuf: Use the GPU cgroup charge/uncharge APIs patch into
> > > > dmabuf: heaps: export system_heap buffers with GPU cgroup charging =
as a
> > > > result of above.
> > > >
> > > > Put the charge and uncharge code in the same file (system_heap_allo=
cate,
> > > > system_heap_dma_buf_release) instead of splitting them between the =
heap and
> > > > the dma_buf_release. This avoids asymmetric management of the gpucg=
 charges.
> > > >
> > > > Modify the dma_buf_transfer_charge API to accept a task_struct inst=
ead
> > > > of a gpucg. This avoids requiring the caller to manage the refcount
> > > > of the gpucg upon failure and confusing ownership transfer logic.
> > > >
> > > > Support all strings for gpucg_register_bucket instead of just strin=
g
> > > > literals.
> > > >
> > > > Enforce globally unique gpucg_bucket names.
> > > >
> > > > Constrain gpucg_bucket name lengths to 64 bytes.
> > > >
> > > > Append "-heap" to gpucg_bucket names from dmabuf-heaps.
> > > >
> > > > Drop patch 7 from the series, which changed the types of
> > > > binder_transaction_data's sender_pid and sender_euid fields. This w=
as
> > > > done in another commit here:
> > > > https://lore.kernel.org/all/20220210021129.3386083-4-masahiroy@kern=
el.org/
> > > >
> > > > Rename:
> > > >   gpucg_try_charge -> gpucg_charge
> > > >   find_cg_rpool_locked -> cg_rpool_find_locked
> > > >   init_cg_rpool -> cg_rpool_init
> > > >   get_cg_rpool_locked -> cg_rpool_get_locked
> > > >   "gpu cgroup controller" -> "GPU controller"
> > > >   gpucg_device -> gpucg_bucket
> > > >   usage -> size
> > > >
> > > > Tests:
> > > >   Support both binder_fd_array_object and binder_fd_object. This is
> > > >   necessary because new versions of Android will use binder_fd_obje=
ct
> > > >   instead of binder_fd_array_object, and we need to support both.
> > > >
> > > >   Tests for both binder_fd_array_object and binder_fd_object.
> > > >
> > > >   For binder_utils return error codes instead of
> > > >   struct binder{fs}_ctx.
> > > >
> > > >   Use ifdef __ANDROID__ to choose platform-dependent temp path inst=
ead
> > > >   of a runtime fallback.
> > > >
> > > >   Ensure binderfs_mntpt ends with a trailing '/' character instead =
of
> > > >   prepending it where used.
> > > >
> > > > v4:
> > > > Skip test if not run as root per Shuah Khan
> > > >
> > > > Add better test logging for abnormal child termination per Shuah Kh=
an
> > > >
> > > > Adjust ordering of charge/uncharge during transfer to avoid potenti=
ally
> > > > hitting cgroup limit per Michal Koutn=C3=BD
> > > >
> > > > Adjust gpucg_try_charge critical section for charge transfer functi=
onality
> > > >
> > > > Fix uninitialized return code error for dmabuf_try_charge error cas=
e
> > > >
> > > > v3:
> > > > Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz
> > > >
> > > > Use more common dual author commit message format per John Stultz
> > > >
> > > > Remove android from binder changes title per Todd Kjos
> > > >
> > > > Add a kselftest for this new behavior per Greg Kroah-Hartman
> > > >
> > > > Include details on behavior for all combinations of kernel/userspac=
e
> > > > versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Ha=
rtman.
> > > >
> > > > Fix pid and uid types in binder UAPI header
> > > >
> > > > v2:
> > > > See the previous revision of this change submitted by Hridya Valsar=
aju
> > > > at: https://lore.kernel.org/all/20220115010622.3185921-1-hridya@goo=
gle.com/
> > > >
> > > > Move dma-buf cgroup charge transfer from a dma_buf_op defined by ev=
ery
> > > > heap to a single dma-buf function for all heaps per Daniel Vetter a=
nd
> > > > Christian K=C3=B6nig. Pointers to struct gpucg and struct gpucg_dev=
ice
> > > > tracking the current associations were added to the dma_buf struct =
to
> > > > achieve this.
> > > >
> > > > Fix incorrect Kconfig help section indentation per Randy Dunlap.
> > > >
> > > > History of the GPU cgroup controller
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > The GPU/DRM cgroup controller came into being when a consensus[1]
> > > > was reached that the resources it tracked were unsuitable to be int=
egrated
> > > > into memcg. Originally, the proposed controller was specific to the=
 DRM
> > > > subsystem and was intended to track GEM buffers and GPU-specific
> > > > resources[2]. In order to help establish a unified memory accountin=
g model
> > > > for all GPU and all related subsystems, Daniel Vetter put forth a
> > > > suggestion to move it out of the DRM subsystem so that it can be us=
ed by
> > > > other DMA-BUF exporters as well[3]. This RFC proposes an interface =
that
> > > > does the same.
> > > >
> > > > [1]: https://patchwork.kernel.org/project/dri-devel/cover/201905011=
40438.9506-1-brian.welty@intel.com/#22624705
> > > > [2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.w=
elty@intel.com/
> > > > [3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwl=
l.local/
> > > >
> > > > Hridya Valsaraju (3):
> > > >   gpu: rfc: Proposal for a GPU cgroup controller
> > > >   cgroup: gpu: Add a cgroup controller for allocator attribution of=
 GPU
> > > >     memory
> > > >   binder: Add flags to relinquish ownership of fds
> > > >
> > > > T.J. Mercier (3):
> > > >   dmabuf: heaps: export system_heap buffers with GPU cgroup chargin=
g
> > > >   dmabuf: Add gpu cgroup charge transfer function
> > > >   selftests: Add binder cgroup gpu memory transfer tests
> > > >
> > > >  Documentation/admin-guide/cgroup-v2.rst       |  23 +
> > > >  drivers/android/binder.c                      |  31 +-
> > > >  drivers/dma-buf/dma-buf.c                     |  80 ++-
> > > >  drivers/dma-buf/dma-heap.c                    |  38 ++
> > > >  drivers/dma-buf/heaps/system_heap.c           |  28 +-
> > > >  include/linux/cgroup_gpu.h                    | 146 +++++
> > > >  include/linux/cgroup_subsys.h                 |   4 +
> > > >  include/linux/dma-buf.h                       |  49 +-
> > > >  include/linux/dma-heap.h                      |  15 +
> > > >  include/uapi/linux/android/binder.h           |  23 +-
> > > >  init/Kconfig                                  |   7 +
> > > >  kernel/cgroup/Makefile                        |   1 +
> > > >  kernel/cgroup/gpu.c                           | 390 +++++++++++++
> > > >  .../selftests/drivers/android/binder/Makefile |   8 +
> > > >  .../drivers/android/binder/binder_util.c      | 250 +++++++++
> > > >  .../drivers/android/binder/binder_util.h      |  32 ++
> > > >  .../selftests/drivers/android/binder/config   |   4 +
> > > >  .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++=
++++
> > > >  18 files changed, 1632 insertions(+), 23 deletions(-)
> > > >  create mode 100644 include/linux/cgroup_gpu.h
> > > >  create mode 100644 kernel/cgroup/gpu.c
> > > >  create mode 100644 tools/testing/selftests/drivers/android/binder/=
Makefile
> > > >  create mode 100644 tools/testing/selftests/drivers/android/binder/=
binder_util.c
> > > >  create mode 100644 tools/testing/selftests/drivers/android/binder/=
binder_util.h
> > > >  create mode 100644 tools/testing/selftests/drivers/android/binder/=
config
> > > >  create mode 100644 tools/testing/selftests/drivers/android/binder/=
test_dmabuf_cgroup_transfer.c
> > > >
> > >
>
