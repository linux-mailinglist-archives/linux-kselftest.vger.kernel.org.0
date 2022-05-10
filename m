Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366A5227DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 01:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiEJX5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiEJX47 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 19:56:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622AD209B42
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:56:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g129-20020a25db87000000b0064b0d671050so420812ybf.6
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=8wgwWyWBAO6K1kQcjl7QjLCZGLS4aKj0FBaC6WwhJdI=;
        b=qAYLyisyyXSk7BzH3nmLvQXdJt3d5qR4CpwkUlSCAlxxvdtqzVN1xC/GBhDcXQ+AHX
         bLOvEu+XGuKU/81vlK/f3FLcJ/0slTtnfXChNkgikt5dQIFy5MGBu1PwluanOmrMHu7o
         vb0Xq1aNl917Wu+eUXiInx9Y2/cfGlqvNqwFQCwtsK22jdhOyD5pHpCcpJrIlCLur5cy
         cBoJbiNkMqktkKvNFP8kg/UJY/Kwaa5lGVLiDC0KnZ3rmrPZNN5K0Gn946fuXQOHi9xU
         XmSllLF/cK9feAy13MLeQK4E0M7s/CowRGV4L06o2Ql4CZBs9ImveHZrPy4lgBm0ZkSh
         oZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=8wgwWyWBAO6K1kQcjl7QjLCZGLS4aKj0FBaC6WwhJdI=;
        b=qmsdttGYvigCMmQPPGL3OMZl/k/eogh/3IPwNPLeG+7Vmo2x5lwQnzkWuXpNh8LXhL
         Z8Im/TOWpmcef0jEfPrkBq0KtxIjmmxJpd/og5wkIZQEzQGWzwl32hyynXMLsUXKJYmA
         j++PtOFX20JUZTR3CaIe87qPGE+49t7c0m6KrfEgco1qWn3LwWe9lNyk7W/TupXIv7ud
         bnkV7E2qXFft4KQuYMTYKSYESedinSJmrVfJcxbeo4huQb8Xu8zwRxQb8jGH7fYgYDvw
         n+C9DWBjRtblNivbSDE1z/4NXF4C7U3eKzEOfLAhVDppf92PmSlZyRmQ+A8x1kFGrhRz
         eXSQ==
X-Gm-Message-State: AOAM532LMU0BGd4Fevegx+19zZFjc/U3aZfTMxnRRdA9FLOS5oylw4bJ
        0+N4+xfXf+mW6fWjzHkGxy0D5AkDYBqXq4g=
X-Google-Smtp-Source: ABdhPJyZR0O/8AupKmR01gHh61HAtkD5xAJaldtC8LToa0+jnj8dKE8fUnC5FYCiGlTORM73cmJPf004bVzHQl0=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:f414:0:b0:624:33e:e486 with SMTP id
 q20-20020a25f414000000b00624033ee486mr20434667ybd.361.1652227016337; Tue, 10
 May 2022 16:56:56 -0700 (PDT)
Date:   Tue, 10 May 2022 23:56:44 +0000
Message-Id: <20220510235653.933868-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v7 0/6] Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series revisits the proposal for a GPU cgroup controller to
track and limit memory allocations by various device/allocator
subsystems. The patch series also contains a simple prototype to
illustrate how Android intends to implement DMA-BUF allocator
attribution using the GPU cgroup controller. The prototype does not
include resource limit enforcements.

Changelog:
v7:
Hide gpucg and gpucg_bucket struct definitions per Michal Koutn=C3=BD.
This means gpucg_register_bucket now returns an internally allocated
struct gpucg_bucket.

Move all public function documentation to the cgroup_gpu.h header.

Remove comment in documentation about duplicate name rejection which
is not relevant to cgroups users per Michal Koutn=C3=BD.

v6:
Move documentation into cgroup-v2.rst per Tejun Heo.

Rename BINDER_FD{A}_FLAG_SENDER_NO_NEED ->
BINDER_FD{A}_FLAG_XFER_CHARGE per Carlos Llamas.

Return error on transfer failure per Carlos Llamas.

v5:
Rebase on top of v5.18-rc3

Drop the global GPU cgroup "total" (sum of all device totals) portion
of the design since there is no currently known use for this per
Tejun Heo.

Fix commit message which still contained the old name for
dma_buf_transfer_charge per Michal Koutn=C3=BD.

Remove all GPU cgroup code except what's necessary to support charge transf=
er
from dma_buf. Previously charging was done in export, but for non-Android
graphics use-cases this is not ideal since there may be a delay between
allocation and export, during which time there is no accounting.

Merge dmabuf: Use the GPU cgroup charge/uncharge APIs patch into
dmabuf: heaps: export system_heap buffers with GPU cgroup charging as a
result of above.

Put the charge and uncharge code in the same file (system_heap_allocate,
system_heap_dma_buf_release) instead of splitting them between the heap and
the dma_buf_release. This avoids asymmetric management of the gpucg charges=
.

Modify the dma_buf_transfer_charge API to accept a task_struct instead
of a gpucg. This avoids requiring the caller to manage the refcount
of the gpucg upon failure and confusing ownership transfer logic.

Support all strings for gpucg_register_bucket instead of just string
literals.

Enforce globally unique gpucg_bucket names.

Constrain gpucg_bucket name lengths to 64 bytes.

Append "-heap" to gpucg_bucket names from dmabuf-heaps.

Drop patch 7 from the series, which changed the types of
binder_transaction_data's sender_pid and sender_euid fields. This was
done in another commit here:
https://lore.kernel.org/all/20220210021129.3386083-4-masahiroy@kernel.org/

Rename:
  gpucg_try_charge -> gpucg_charge
  find_cg_rpool_locked -> cg_rpool_find_locked
  init_cg_rpool -> cg_rpool_init
  get_cg_rpool_locked -> cg_rpool_get_locked
  "gpu cgroup controller" -> "GPU controller"
  gpucg_device -> gpucg_bucket
  usage -> size

Tests:
  Support both binder_fd_array_object and binder_fd_object. This is
  necessary because new versions of Android will use binder_fd_object
  instead of binder_fd_array_object, and we need to support both.

  Tests for both binder_fd_array_object and binder_fd_object.

  For binder_utils return error codes instead of
  struct binder{fs}_ctx.

  Use ifdef __ANDROID__ to choose platform-dependent temp path instead
  of a runtime fallback.

  Ensure binderfs_mntpt ends with a trailing '/' character instead of
  prepending it where used.

v4:
Skip test if not run as root per Shuah Khan

Add better test logging for abnormal child termination per Shuah Khan

Adjust ordering of charge/uncharge during transfer to avoid potentially
hitting cgroup limit per Michal Koutn=C3=BD

Adjust gpucg_try_charge critical section for charge transfer functionality

Fix uninitialized return code error for dmabuf_try_charge error case

v3:
Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz

Use more common dual author commit message format per John Stultz

Remove android from binder changes title per Todd Kjos

Add a kselftest for this new behavior per Greg Kroah-Hartman

Include details on behavior for all combinations of kernel/userspace
versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Hartman.

Fix pid and uid types in binder UAPI header

v2:
See the previous revision of this change submitted by Hridya Valsaraju
at: https://lore.kernel.org/all/20220115010622.3185921-1-hridya@google.com/

Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig. Pointers to struct gpucg and struct gpucg_device
tracking the current associations were added to the dma_buf struct to
achieve this.

Fix incorrect Kconfig help section indentation per Randy Dunlap.

History of the GPU cgroup controller
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The GPU/DRM cgroup controller came into being when a consensus[1]
was reached that the resources it tracked were unsuitable to be integrated
into memcg. Originally, the proposed controller was specific to the DRM
subsystem and was intended to track GEM buffers and GPU-specific
resources[2]. In order to help establish a unified memory accounting model
for all GPU and all related subsystems, Daniel Vetter put forth a
suggestion to move it out of the DRM subsystem so that it can be used by
other DMA-BUF exporters as well[3]. This RFC proposes an interface that
does the same.

[1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140438.95=
06-1-brian.welty@intel.com/#22624705
[2]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@int=
el.com/
[3]: https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/

Hridya Valsaraju (3):
  gpu: rfc: Proposal for a GPU cgroup controller
  cgroup: gpu: Add a cgroup controller for allocator attribution of GPU
    memory
  binder: Add flags to relinquish ownership of fds

T.J. Mercier (3):
  dmabuf: heaps: export system_heap buffers with GPU cgroup charging
  dmabuf: Add gpu cgroup charge transfer function
  selftests: Add binder cgroup gpu memory transfer tests

 Documentation/admin-guide/cgroup-v2.rst       |  23 +
 drivers/android/binder.c                      |  31 +-
 drivers/dma-buf/dma-buf.c                     |  80 ++-
 drivers/dma-buf/dma-heap.c                    |  38 ++
 drivers/dma-buf/heaps/system_heap.c           |  28 +-
 include/linux/cgroup_gpu.h                    | 146 +++++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/dma-buf.h                       |  49 +-
 include/linux/dma-heap.h                      |  15 +
 include/uapi/linux/android/binder.h           |  23 +-
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/gpu.c                           | 390 +++++++++++++
 .../selftests/drivers/android/binder/Makefile |   8 +
 .../drivers/android/binder/binder_util.c      | 250 +++++++++
 .../drivers/android/binder/binder_util.h      |  32 ++
 .../selftests/drivers/android/binder/config   |   4 +
 .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++++++
 18 files changed, 1632 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/cgroup_gpu.h
 create mode 100644 kernel/cgroup/gpu.c
 create mode 100644 tools/testing/selftests/drivers/android/binder/Makefile
 create mode 100644 tools/testing/selftests/drivers/android/binder/binder_u=
til.c
 create mode 100644 tools/testing/selftests/drivers/android/binder/binder_u=
til.h
 create mode 100644 tools/testing/selftests/drivers/android/binder/config
 create mode 100644 tools/testing/selftests/drivers/android/binder/test_dma=
buf_cgroup_transfer.c

--=20
2.36.0.512.ge40c2bad7a-goog

