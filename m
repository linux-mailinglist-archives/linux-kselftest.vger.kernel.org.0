Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C45093E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 01:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383294AbiDTXzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383289AbiDTXzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 19:55:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9163DDDE
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 16:52:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ebf1d99068so29449167b3.9
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=WCvt67lICr/Yuj88iOpNjknsfyrSj02eDdei0Ztr4rU=;
        b=PHp312CvTRWed1qeu49duubCaKZ5ru59t1UpzP4ri0+yr6PwVAlL336j+PM9F11x5Y
         su6AZsETCH/0Dz/02RJxJBMCiB9A04TTbNki31e2j81/0pVQuUNeec3fxOPR1CpTt0eJ
         eeLiND8WZ9vssDi3VrLxqYYEYlPfdNWvqL04gxaQIcz+BejkP5Cp6J/VK8vucRhkXIjg
         L8k2X2LHssmgjIkV/pS8pZ8kPskg7XKaZ/OYbRU7WIASoAJyTo+s5IajhUDa0MWwK7EA
         ZGOf6Retq+9rwOjFKEDG9Qng/LV5PoAeYzd2SghVzYTthgFFkfjcf1tgvbQeE0dyzIbe
         qmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=WCvt67lICr/Yuj88iOpNjknsfyrSj02eDdei0Ztr4rU=;
        b=qrWCRQDLEd8nO44Oy9QM2VyJ8KFblKiiW/ZVPxJjnTzvR9aQF7z+XI3sxV4+E+MRKp
         EsYDpVuKjAbPYWsUEoEvJwj3ZZFCqdDPuVxx+MaSp2YGSYqfulK42Ev4RzrLGAejIi4e
         7bdFrVUonZ0gKwK6tRXzxjx1sUzv0qR7uPDqGpgN7oJucujCJ4jqkCq9mX/+XQ6Rt/Ne
         g6psQ+w4XES7dl2M6psvL/ZxUmG1TY7UwR73gc08mFTm2fOijHFDJ8VadFw+kwFT3fi0
         cvqE/kKSGydKuSrWCNBkEow8q9V1BGJ23AoMZDvZNYJqNr57nRCdEOWf3/WJN0lhyBQC
         Tm5w==
X-Gm-Message-State: AOAM532IBj6JsRkuqj6MZRytJgRsNXBcHEG/QXEdcpdsHloZyu6CrIiC
        Q1VUJ8K/95PJopPCVkKBx0GutYzPtidjgyA=
X-Google-Smtp-Source: ABdhPJyoY6BIkI1JYH1e0MtBXl4CNKiZNaINnToAGUb5Aug0fm/CUYe9nPA4yvyZh+s+1dQLEV9XRwPwq51lT5E=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:52:b0:645:bd1:970e with SMTP id
 m18-20020a056902005200b006450bd1970emr16436884ybh.413.1650498751492; Wed, 20
 Apr 2022 16:52:31 -0700 (PDT)
Date:   Wed, 20 Apr 2022 23:52:18 +0000
Message-Id: <20220420235228.2767816-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [RFC v5 0/6] Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, daniel@ffwll.ch, tj@kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
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
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     jstultz@google.com, cmllamas@google.com, kaleshsingh@google.com,
        Kenny.Ho@amd.com, mkoutny@suse.com, skhan@linuxfoundation.org,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

 Documentation/gpu/rfc/gpu-cgroup.rst          | 190 +++++++
 Documentation/gpu/rfc/index.rst               |   4 +
 drivers/android/binder.c                      |  27 +-
 drivers/dma-buf/dma-buf.c                     |  80 ++-
 drivers/dma-buf/dma-heap.c                    |  39 ++
 drivers/dma-buf/heaps/system_heap.c           |  28 +-
 include/linux/cgroup_gpu.h                    | 137 +++++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/dma-buf.h                       |  49 +-
 include/linux/dma-heap.h                      |  15 +
 include/uapi/linux/android/binder.h           |  23 +-
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/gpu.c                           | 386 +++++++++++++
 .../selftests/drivers/android/binder/Makefile |   8 +
 .../drivers/android/binder/binder_util.c      | 250 +++++++++
 .../drivers/android/binder/binder_util.h      |  32 ++
 .../selftests/drivers/android/binder/config   |   4 +
 .../binder/test_dmabuf_cgroup_transfer.c      | 526 ++++++++++++++++++
 19 files changed, 1787 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/gpu/rfc/gpu-cgroup.rst
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
2.36.0.rc0.470.gd361397f0d-goog

