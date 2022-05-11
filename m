Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A7523424
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiEKNWV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiEKNWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 09:22:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC75B885
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 06:21:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p3so2051577qvi.7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=2iODird8x/BZrqTa4Iuj7D6s9MjuDZsxdzue4KwvOeA=;
        b=r7f0FY/4IwO3yzB9eJxHW7qT2sRXh2JrXmFGOKGcRiOlaoGVwWtzM5egP2Pri5Xprh
         hZkvDIA5w80yhNS6F7RIDAGS6dZzuX35Qdo5XVxzb37gIo+Lxll3tSsSVCESkrEZyTlK
         9/5wRpBRgiiPGONpfquzxVz89YvIfhXWM+Ef5ZiFpn8hS1X2WiYT9R1CI2MKiljYfsup
         OQPJZfUOp3oURb5I8CS1j/JZJFJU8J1fwCVIzw74hyIk2F62BBtJiz5k/xqAPAE3XNKA
         dMIe3OAVmt2/OoMBe0VS4EcdjQx3UHm6ppN8sqrBFlow4yt0eZ9/21Z1BGZFy9Auu6QU
         Z3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=2iODird8x/BZrqTa4Iuj7D6s9MjuDZsxdzue4KwvOeA=;
        b=ykMjVxP5fIzq/zMo729Y9OqOCRwwYKB5XEnRpZHHETwtjJjHhgh2nmJnsqy6OYWDit
         GKhDS+7ASrLLZqU/iFP5rEu/U3Ct7aSHWpYlTo7Ix0phVbnqpgTX9+qloyFsSz/8DZWq
         5pASLHwRB8zSY/NZ317vRyKQeNk2GxK7+egkqxPOEf77xekLfHnvbOJQnJFnX3WpQxhT
         qe5/fiuHmuJ+CrXtv8hA8it7pG7rhPA/dw+NdLEvBMcNniCF62L2hFpH3nou3k8/+1uQ
         q0Lzj3iyRMA+9sGyHKNBP8B9k8qCnc+dIdFsITklFaPx3aQJR+CMRaoy7gHMZ9YLn/Uz
         /Now==
X-Gm-Message-State: AOAM530D2odKKcOyaMbs8EQiYD9vePbnGWSEntd35YsyQ7NZDcT05BKv
        V1J0/hGwmRRu4rEjI0mDpU+gsQ==
X-Google-Smtp-Source: ABdhPJx1J+0Hxhf/anNC9wgHSzXinmeOWtD8RSs5P4tduqzYgwzQJnWgWruvLzhaQ7YIAGkUO6gd7Q==
X-Received: by 2002:ad4:5bc1:0:b0:42c:531c:ef12 with SMTP id t1-20020ad45bc1000000b0042c531cef12mr22412148qvt.15.1652275283277;
        Wed, 11 May 2022 06:21:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b0069fc13ce207sm1230564qkp.56.2022.05.11.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:21:22 -0700 (PDT)
Message-ID: <3365cd1d750e84fedc8e75d646a77ffd85619d35.camel@ndufresne.ca>
Subject: Re: [PATCH v7 0/6] Proposal for a GPU cgroup controller
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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
        Shuah Khan <shuah@kernel.org>
Cc:     daniel@ffwll.ch, jstultz@google.com, cmllamas@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kselftest@vger.kernel.org
Date:   Wed, 11 May 2022 09:21:20 -0400
In-Reply-To: <20220510235653.933868-1-tjmercier@google.com>
References: <20220510235653.933868-1-tjmercier@google.com>
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

Hi,

Le mardi 10 mai 2022 =C3=A0 23:56 +0000, T.J. Mercier a =C3=A9crit=C2=A0:
> This patch series revisits the proposal for a GPU cgroup controller to
> track and limit memory allocations by various device/allocator
> subsystems. The patch series also contains a simple prototype to
> illustrate how Android intends to implement DMA-BUF allocator
> attribution using the GPU cgroup controller. The prototype does not
> include resource limit enforcements.

I'm sorry, since I'm not in-depth technically involve. But from reading the
topic I don't understand the bound this creates between DMABuf Heaps and GP=
U. Is
this an attempt to really track the DMABuf allocated by userland, or just
something for GPU ? What about V4L2 devices ? Any way this can be clarified=
,
specially what would other subsystem needs to have cgroup DMABuf allocation
controller support ?

>=20
> Changelog:
> v7:
> Hide gpucg and gpucg_bucket struct definitions per Michal Koutn=C3=BD.
> This means gpucg_register_bucket now returns an internally allocated
> struct gpucg_bucket.
>=20
> Move all public function documentation to the cgroup_gpu.h header.
>=20
> Remove comment in documentation about duplicate name rejection which
> is not relevant to cgroups users per Michal Koutn=C3=BD.
>=20
> v6:
> Move documentation into cgroup-v2.rst per Tejun Heo.
>=20
> Rename BINDER_FD{A}_FLAG_SENDER_NO_NEED ->
> BINDER_FD{A}_FLAG_XFER_CHARGE per Carlos Llamas.
>=20
> Return error on transfer failure per Carlos Llamas.
>=20
> v5:
> Rebase on top of v5.18-rc3
>=20
> Drop the global GPU cgroup "total" (sum of all device totals) portion
> of the design since there is no currently known use for this per
> Tejun Heo.
>=20
> Fix commit message which still contained the old name for
> dma_buf_transfer_charge per Michal Koutn=C3=BD.
>=20
> Remove all GPU cgroup code except what's necessary to support charge tran=
sfer
> from dma_buf. Previously charging was done in export, but for non-Android
> graphics use-cases this is not ideal since there may be a delay between
> allocation and export, during which time there is no accounting.
>=20
> Merge dmabuf: Use the GPU cgroup charge/uncharge APIs patch into
> dmabuf: heaps: export system_heap buffers with GPU cgroup charging as a
> result of above.
>=20
> Put the charge and uncharge code in the same file (system_heap_allocate,
> system_heap_dma_buf_release) instead of splitting them between the heap a=
nd
> the dma_buf_release. This avoids asymmetric management of the gpucg charg=
es.
>=20
> Modify the dma_buf_transfer_charge API to accept a task_struct instead
> of a gpucg. This avoids requiring the caller to manage the refcount
> of the gpucg upon failure and confusing ownership transfer logic.
>=20
> Support all strings for gpucg_register_bucket instead of just string
> literals.
>=20
> Enforce globally unique gpucg_bucket names.
>=20
> Constrain gpucg_bucket name lengths to 64 bytes.
>=20
> Append "-heap" to gpucg_bucket names from dmabuf-heaps.
>=20
> Drop patch 7 from the series, which changed the types of
> binder_transaction_data's sender_pid and sender_euid fields. This was
> done in another commit here:
> https://lore.kernel.org/all/20220210021129.3386083-4-masahiroy@kernel.org=
/
>=20
> Rename:
>   gpucg_try_charge -> gpucg_charge
>   find_cg_rpool_locked -> cg_rpool_find_locked
>   init_cg_rpool -> cg_rpool_init
>   get_cg_rpool_locked -> cg_rpool_get_locked
>   "gpu cgroup controller" -> "GPU controller"
>   gpucg_device -> gpucg_bucket
>   usage -> size
>=20
> Tests:
>   Support both binder_fd_array_object and binder_fd_object. This is
>   necessary because new versions of Android will use binder_fd_object
>   instead of binder_fd_array_object, and we need to support both.
>=20
>   Tests for both binder_fd_array_object and binder_fd_object.
>=20
>   For binder_utils return error codes instead of
>   struct binder{fs}_ctx.
>=20
>   Use ifdef __ANDROID__ to choose platform-dependent temp path instead
>   of a runtime fallback.
>=20
>   Ensure binderfs_mntpt ends with a trailing '/' character instead of
>   prepending it where used.
>=20
> v4:
> Skip test if not run as root per Shuah Khan
>=20
> Add better test logging for abnormal child termination per Shuah Khan
>=20
> Adjust ordering of charge/uncharge during transfer to avoid potentially
> hitting cgroup limit per Michal Koutn=C3=BD
>=20
> Adjust gpucg_try_charge critical section for charge transfer functionalit=
y
>=20
> Fix uninitialized return code error for dmabuf_try_charge error case
>=20
> v3:
> Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz
>=20
> Use more common dual author commit message format per John Stultz
>=20
> Remove android from binder changes title per Todd Kjos
>=20
> Add a kselftest for this new behavior per Greg Kroah-Hartman
>=20
> Include details on behavior for all combinations of kernel/userspace
> versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Hartman.
>=20
> Fix pid and uid types in binder UAPI header
>=20
> v2:
> See the previous revision of this change submitted by Hridya Valsaraju
> at: https://lore.kernel.org/all/20220115010622.3185921-1-hridya@google.co=
m/
>=20
> Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
> heap to a single dma-buf function for all heaps per Daniel Vetter and
> Christian K=C3=B6nig. Pointers to struct gpucg and struct gpucg_device
> tracking the current associations were added to the dma_buf struct to
> achieve this.
>=20
> Fix incorrect Kconfig help section indentation per Randy Dunlap.
>=20
> History of the GPU cgroup controller
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The GPU/DRM cgroup controller came into being when a consensus[1]
> was reached that the resources it tracked were unsuitable to be integrate=
d
> into memcg. Originally, the proposed controller was specific to the DRM
> subsystem and was intended to track GEM buffers and GPU-specific
> resources[2]. In order to help establish a unified memory accounting mode=
l
> for all GPU and all related subsystems, Daniel Vetter put forth a
> suggestion to move it out of the DRM subsystem so that it can be used by
> other DMA-BUF exporters as well[3]. This RFC proposes an interface that
> does the same.
>=20
> [1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140438.=
9506-1-brian.welty@intel.com/#22624705
> [2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@i=
ntel.com/
> [3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.loca=
l/
>=20
> Hridya Valsaraju (3):
>   gpu: rfc: Proposal for a GPU cgroup controller
>   cgroup: gpu: Add a cgroup controller for allocator attribution of GPU
>     memory
>   binder: Add flags to relinquish ownership of fds
>=20
> T.J. Mercier (3):
>   dmabuf: heaps: export system_heap buffers with GPU cgroup charging
>   dmabuf: Add gpu cgroup charge transfer function
>   selftests: Add binder cgroup gpu memory transfer tests
>=20
>  Documentation/admin-guide/cgroup-v2.rst       |  23 +
>  drivers/android/binder.c                      |  31 +-
>  drivers/dma-buf/dma-buf.c                     |  80 ++-
>  drivers/dma-buf/dma-heap.c                    |  38 ++
>  drivers/dma-buf/heaps/system_heap.c           |  28 +-
>  include/linux/cgroup_gpu.h                    | 146 +++++
>  include/linux/cgroup_subsys.h                 |   4 +
>  include/linux/dma-buf.h                       |  49 +-
>  include/linux/dma-heap.h                      |  15 +
>  include/uapi/linux/android/binder.h           |  23 +-
>  init/Kconfig                                  |   7 +
>  kernel/cgroup/Makefile                        |   1 +
>  kernel/cgroup/gpu.c                           | 390 +++++++++++++
>  .../selftests/drivers/android/binder/Makefile |   8 +
>  .../drivers/android/binder/binder_util.c      | 250 +++++++++
>  .../drivers/android/binder/binder_util.h      |  32 ++
>  .../selftests/drivers/android/binder/config   |   4 +
>  .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++++++
>  18 files changed, 1632 insertions(+), 23 deletions(-)
>  create mode 100644 include/linux/cgroup_gpu.h
>  create mode 100644 kernel/cgroup/gpu.c
>  create mode 100644 tools/testing/selftests/drivers/android/binder/Makefi=
le
>  create mode 100644 tools/testing/selftests/drivers/android/binder/binder=
_util.c
>  create mode 100644 tools/testing/selftests/drivers/android/binder/binder=
_util.h
>  create mode 100644 tools/testing/selftests/drivers/android/binder/config
>  create mode 100644 tools/testing/selftests/drivers/android/binder/test_d=
mabuf_cgroup_transfer.c
>=20

