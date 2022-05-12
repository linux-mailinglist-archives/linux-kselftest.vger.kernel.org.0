Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66E524DD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354174AbiELNKK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbiELNKG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 09:10:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64C24F217
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 06:10:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hh4so4204830qtb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=RBA5iYSHu9+0TYIYrBGNppT49jXTmNkB4+A2Po1Nus8=;
        b=3eBFlCCHPRxkzPZ0s8KZjMicvMtmgL+oe/KrY5MKDSXcjQwLbcXkaduM7++YpUA55d
         auo6swNXasvTsK3hhnOsCxf7T2SHW9FzAMBSKTJe/ufAs5+Cx85VNXf2xt48DwLkz14l
         Gg7HSyQjgfSgnfEBrgiK8uGWHf0rWcv+UCOWgyHiOyT4JTKwbJZVaSr509src58ZzFSD
         7NJB9D5MBw+fHof1VNKLRvVEgiUFBf4MvCs6oVrfokAyCWOQx9XKF03oRjBw0ZFadjap
         VXC2Glu3iKcmppInO6+yumJld1Kco9x2F2fGdOXjV6B+9FYZ+/e0bFv1flHl1gi4nr19
         0Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=RBA5iYSHu9+0TYIYrBGNppT49jXTmNkB4+A2Po1Nus8=;
        b=MA8FP0oeyeghdIWakAFcSsDYOR5/vD21RA5UduGJcR2bUUVJpaI83ogYWCx1pqxPeP
         bXe3HrYdEbItQZpyI+aHHeoMoP0eNf4rJpgKVcM+dF4ZnjYKQ1aAwqI8e8Ox+W16RK7I
         xrTUd8VTTqrrww/axlvwg1Hj8Kw9xv/DyOlegf9KvahyDCw27QGcm54ZT/mH1BsSuwE/
         2CtpD5VVBZvNRkYh1AvgwSX+H+swAZY1d9XxSxlmQQZfRWv7zm/3rt+X/YLbjOQIkPif
         FGlvbHYvNvxbFyllKzFI+KOv0J6pOccdLuGTsb/NdxQ7rnLSs5PDs7HjEgJ8Q3pPHEfj
         l5Fg==
X-Gm-Message-State: AOAM5338MQLyWQO5GdXPa8CZd+MLEIt5YIGc3lgfj9LEJL8cTz71BB3z
        JLAuKJBwgFBhABR+NPbaB6SUyA==
X-Google-Smtp-Source: ABdhPJz5CKwhlE8d7bTTHW0wg3txErQtYCpOVtChIjACpnnxUq2VanDb8ocB/1nkSkvCRgs6MnSb/g==
X-Received: by 2002:a05:622a:5d0:b0:2f3:c650:19cc with SMTP id d16-20020a05622a05d000b002f3c65019ccmr28598110qtb.0.1652361003426;
        Thu, 12 May 2022 06:10:03 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id l14-20020ac8148e000000b002f39b99f68dsm2864002qtj.39.2022.05.12.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:10:02 -0700 (PDT)
Message-ID: <81026ef07c1ce20f8673b75b17bab79a2b39c548.camel@ndufresne.ca>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        John Stultz <jstultz@google.com>,
        Carlos Llamas <cmllamas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Date:   Thu, 12 May 2022 09:09:59 -0400
In-Reply-To: <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
References: <20220510235653.933868-1-tjmercier@google.com>
         <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
         <CABdmKX3ZV6-u-oLvW_wWavAMBfrsZ=C_rCgK_Uz4VjxcRvRFew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Le mercredi 11 mai 2022 =C3=A0 13:31 -0700, T.J. Mercier a =C3=A9crit=C2=A0=
:
> On Wed, May 11, 2022 at 6:21 AM Nicolas Dufresne <nicolas@ndufresne.ca> w=
rote:
> >=20
> > Hi,
> >=20
> > Le mardi 10 mai 2022 =C3=A0 23:56 +0000, T.J. Mercier a =C3=A9crit :
> > > This patch series revisits the proposal for a GPU cgroup controller t=
o
> > > track and limit memory allocations by various device/allocator
> > > subsystems. The patch series also contains a simple prototype to
> > > illustrate how Android intends to implement DMA-BUF allocator
> > > attribution using the GPU cgroup controller. The prototype does not
> > > include resource limit enforcements.
> >=20
> > I'm sorry, since I'm not in-depth technically involve. But from reading=
 the
> > topic I don't understand the bound this creates between DMABuf Heaps an=
d GPU. Is
> > this an attempt to really track the DMABuf allocated by userland, or ju=
st
> > something for GPU ? What about V4L2 devices ? Any way this can be clari=
fied,
> > specially what would other subsystem needs to have cgroup DMABuf alloca=
tion
> > controller support ?
> >=20
> Hi Nicolas,
>=20
> The link between dmabufs, dmabuf heaps, and "GPU memory" is maybe
> somewhat of an Androidism. However this change aims to be usable for
> tracking all GPU related allocations. It's just that this initial
> series only adds support for tracking dmabufs allocated from dmabuf
> heaps.
>=20
> In Android most graphics buffers are dma buffers allocated from a
> dmabuf heap, so that is why these dmabuf heap allocations are being
> tracked under the GPU cgroup. Other dmabuf exporters like V4L2 might
> also want to track their buffers, but would probably want to do so
> under a bucket name of something like "v4l2". Same goes for GEM
> dmabufs. The naming scheme for this is still yet to be decided. It
> would be cool to be able to attribute memory at the driver level, or
> even different types of memory at the driver level, but I imagine
> there is a point of diminishing returns for fine-grained
> naming/bucketing.
>=20
> So far, I haven't tried to create a strict definition of what is and
> is not "GPU memory" for the purpose of this accounting, so I don't
> think we should be restricted to tracking just dmabufs. I don't see
> why this couldn't be anything a driver wants to consider as GPU memory
> as long as it is named/bucketed appropriately, such as both on-package
> graphics card memory use and CPU memory dedicated for graphics use
> like for host/device transfers.
>=20
> Is that helpful?

I'm actually happy I've asked this question, wasn't silly after all. I thin=
k the
problem here is a naming issue. What you really are monitor is "video memor=
y",
which consist of a memory segment allocated to store data used to render im=
ages
(its not always images of course, GPU an VPU have specialized buffers for t=
heir
purpose).

Whether this should be split between what is used specifically by the GPU
drivers, the display drivers, the VPU (CODEC and pre/post-processor) or cam=
era
drivers is something that should be discussed. But in the current approach,=
 you
really meant Video memory as a superset of the above. Personally, I think
generically (to de-Andronized your work), en-globing all video memory is
sufficient. What I fail to understand is how you will manage to distinguish=
ed
DMABuf Heap allocation (which are used outside of Android btw), from Video
allocation or other type of usage. I'm sure non-video usage will exist in t=
he
future (think of machine learning, compute, other high bandwidth streaming
thingy ...)

>=20
> Best,
> T.J.
>=20
> > >=20
> > > Changelog:
> > > v7:
> > > Hide gpucg and gpucg_bucket struct definitions per Michal Koutn=C3=BD=
.
> > > This means gpucg_register_bucket now returns an internally allocated
> > > struct gpucg_bucket.
> > >=20
> > > Move all public function documentation to the cgroup_gpu.h header.
> > >=20
> > > Remove comment in documentation about duplicate name rejection which
> > > is not relevant to cgroups users per Michal Koutn=C3=BD.
> > >=20
> > > v6:
> > > Move documentation into cgroup-v2.rst per Tejun Heo.
> > >=20
> > > Rename BINDER_FD{A}_FLAG_SENDER_NO_NEED ->
> > > BINDER_FD{A}_FLAG_XFER_CHARGE per Carlos Llamas.
> > >=20
> > > Return error on transfer failure per Carlos Llamas.
> > >=20
> > > v5:
> > > Rebase on top of v5.18-rc3
> > >=20
> > > Drop the global GPU cgroup "total" (sum of all device totals) portion
> > > of the design since there is no currently known use for this per
> > > Tejun Heo.
> > >=20
> > > Fix commit message which still contained the old name for
> > > dma_buf_transfer_charge per Michal Koutn=C3=BD.
> > >=20
> > > Remove all GPU cgroup code except what's necessary to support charge =
transfer
> > > from dma_buf. Previously charging was done in export, but for non-And=
roid
> > > graphics use-cases this is not ideal since there may be a delay betwe=
en
> > > allocation and export, during which time there is no accounting.
> > >=20
> > > Merge dmabuf: Use the GPU cgroup charge/uncharge APIs patch into
> > > dmabuf: heaps: export system_heap buffers with GPU cgroup charging as=
 a
> > > result of above.
> > >=20
> > > Put the charge and uncharge code in the same file (system_heap_alloca=
te,
> > > system_heap_dma_buf_release) instead of splitting them between the he=
ap and
> > > the dma_buf_release. This avoids asymmetric management of the gpucg c=
harges.
> > >=20
> > > Modify the dma_buf_transfer_charge API to accept a task_struct instea=
d
> > > of a gpucg. This avoids requiring the caller to manage the refcount
> > > of the gpucg upon failure and confusing ownership transfer logic.
> > >=20
> > > Support all strings for gpucg_register_bucket instead of just string
> > > literals.
> > >=20
> > > Enforce globally unique gpucg_bucket names.
> > >=20
> > > Constrain gpucg_bucket name lengths to 64 bytes.
> > >=20
> > > Append "-heap" to gpucg_bucket names from dmabuf-heaps.
> > >=20
> > > Drop patch 7 from the series, which changed the types of
> > > binder_transaction_data's sender_pid and sender_euid fields. This was
> > > done in another commit here:
> > > https://lore.kernel.org/all/20220210021129.3386083-4-masahiroy@kernel=
.org/
> > >=20
> > > Rename:
> > >   gpucg_try_charge -> gpucg_charge
> > >   find_cg_rpool_locked -> cg_rpool_find_locked
> > >   init_cg_rpool -> cg_rpool_init
> > >   get_cg_rpool_locked -> cg_rpool_get_locked
> > >   "gpu cgroup controller" -> "GPU controller"
> > >   gpucg_device -> gpucg_bucket
> > >   usage -> size
> > >=20
> > > Tests:
> > >   Support both binder_fd_array_object and binder_fd_object. This is
> > >   necessary because new versions of Android will use binder_fd_object
> > >   instead of binder_fd_array_object, and we need to support both.
> > >=20
> > >   Tests for both binder_fd_array_object and binder_fd_object.
> > >=20
> > >   For binder_utils return error codes instead of
> > >   struct binder{fs}_ctx.
> > >=20
> > >   Use ifdef __ANDROID__ to choose platform-dependent temp path instea=
d
> > >   of a runtime fallback.
> > >=20
> > >   Ensure binderfs_mntpt ends with a trailing '/' character instead of
> > >   prepending it where used.
> > >=20
> > > v4:
> > > Skip test if not run as root per Shuah Khan
> > >=20
> > > Add better test logging for abnormal child termination per Shuah Khan
> > >=20
> > > Adjust ordering of charge/uncharge during transfer to avoid potential=
ly
> > > hitting cgroup limit per Michal Koutn=C3=BD
> > >=20
> > > Adjust gpucg_try_charge critical section for charge transfer function=
ality
> > >=20
> > > Fix uninitialized return code error for dmabuf_try_charge error case
> > >=20
> > > v3:
> > > Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz
> > >=20
> > > Use more common dual author commit message format per John Stultz
> > >=20
> > > Remove android from binder changes title per Todd Kjos
> > >=20
> > > Add a kselftest for this new behavior per Greg Kroah-Hartman
> > >=20
> > > Include details on behavior for all combinations of kernel/userspace
> > > versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Hart=
man.
> > >=20
> > > Fix pid and uid types in binder UAPI header
> > >=20
> > > v2:
> > > See the previous revision of this change submitted by Hridya Valsaraj=
u
> > > at: https://lore.kernel.org/all/20220115010622.3185921-1-hridya@googl=
e.com/
> > >=20
> > > Move dma-buf cgroup charge transfer from a dma_buf_op defined by ever=
y
> > > heap to a single dma-buf function for all heaps per Daniel Vetter and
> > > Christian K=C3=B6nig. Pointers to struct gpucg and struct gpucg_devic=
e
> > > tracking the current associations were added to the dma_buf struct to
> > > achieve this.
> > >=20
> > > Fix incorrect Kconfig help section indentation per Randy Dunlap.
> > >=20
> > > History of the GPU cgroup controller
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > The GPU/DRM cgroup controller came into being when a consensus[1]
> > > was reached that the resources it tracked were unsuitable to be integ=
rated
> > > into memcg. Originally, the proposed controller was specific to the D=
RM
> > > subsystem and was intended to track GEM buffers and GPU-specific
> > > resources[2]. In order to help establish a unified memory accounting =
model
> > > for all GPU and all related subsystems, Daniel Vetter put forth a
> > > suggestion to move it out of the DRM subsystem so that it can be used=
 by
> > > other DMA-BUF exporters as well[3]. This RFC proposes an interface th=
at
> > > does the same.
> > >=20
> > > [1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140=
438.9506-1-brian.welty@intel.com/#22624705
> > > [2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.wel=
ty@intel.com/
> > > [3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.=
local/
> > >=20
> > > Hridya Valsaraju (3):
> > >   gpu: rfc: Proposal for a GPU cgroup controller
> > >   cgroup: gpu: Add a cgroup controller for allocator attribution of G=
PU
> > >     memory
> > >   binder: Add flags to relinquish ownership of fds
> > >=20
> > > T.J. Mercier (3):
> > >   dmabuf: heaps: export system_heap buffers with GPU cgroup charging
> > >   dmabuf: Add gpu cgroup charge transfer function
> > >   selftests: Add binder cgroup gpu memory transfer tests
> > >=20
> > >  Documentation/admin-guide/cgroup-v2.rst       |  23 +
> > >  drivers/android/binder.c                      |  31 +-
> > >  drivers/dma-buf/dma-buf.c                     |  80 ++-
> > >  drivers/dma-buf/dma-heap.c                    |  38 ++
> > >  drivers/dma-buf/heaps/system_heap.c           |  28 +-
> > >  include/linux/cgroup_gpu.h                    | 146 +++++
> > >  include/linux/cgroup_subsys.h                 |   4 +
> > >  include/linux/dma-buf.h                       |  49 +-
> > >  include/linux/dma-heap.h                      |  15 +
> > >  include/uapi/linux/android/binder.h           |  23 +-
> > >  init/Kconfig                                  |   7 +
> > >  kernel/cgroup/Makefile                        |   1 +
> > >  kernel/cgroup/gpu.c                           | 390 +++++++++++++
> > >  .../selftests/drivers/android/binder/Makefile |   8 +
> > >  .../drivers/android/binder/binder_util.c      | 250 +++++++++
> > >  .../drivers/android/binder/binder_util.h      |  32 ++
> > >  .../selftests/drivers/android/binder/config   |   4 +
> > >  .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++++=
++
> > >  18 files changed, 1632 insertions(+), 23 deletions(-)
> > >  create mode 100644 include/linux/cgroup_gpu.h
> > >  create mode 100644 kernel/cgroup/gpu.c
> > >  create mode 100644 tools/testing/selftests/drivers/android/binder/Ma=
kefile
> > >  create mode 100644 tools/testing/selftests/drivers/android/binder/bi=
nder_util.c
> > >  create mode 100644 tools/testing/selftests/drivers/android/binder/bi=
nder_util.h
> > >  create mode 100644 tools/testing/selftests/drivers/android/binder/co=
nfig
> > >  create mode 100644 tools/testing/selftests/drivers/android/binder/te=
st_dmabuf_cgroup_transfer.c
> > >=20
> >=20

