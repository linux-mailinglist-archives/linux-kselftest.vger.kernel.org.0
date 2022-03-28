Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5F4E8CC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 06:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiC1EBl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 00:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiC1EBk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 00:01:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9804506A
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 20:59:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n207-20020a25d6d8000000b0063bd7a74ae4so4353230ybg.21
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ZanSM+z+bqiT+dazTvxIhzoTPKfBDbdIJDmpkh0ngiA=;
        b=dEZSetUwhJ77JER9uOFHsQsp76JzF2DjT1q6+REMveb9Wt4BrGDGIQgD1zzZM9bma+
         yhEZCho/DguXCN/LWIpS6/sXTLVs/7I8V57LnPEuNyRfMseJ+ScdFrLfEpJoGDWtMIFM
         t64Dd1vWRIhCANW1YNotTj71VdF86eU/Z1yZ/2P1/oZx3uAbxFDxrqLAVLQm8PT6wR0S
         qEnNzRfOZYWdnMNSE8GFnj9hFuliT0+m6mkGHNaGsEGbIMS5RBIfRao1fm6MCxklAbdl
         N8IuezzihPA3MdxNEuigRrXDRU77mTQDN2Wi23Fw13t4QVAYQLDOIAduNv28SyaFtkAo
         +W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ZanSM+z+bqiT+dazTvxIhzoTPKfBDbdIJDmpkh0ngiA=;
        b=KsJcSXIvT18l2yJpRzLGc2NTq/AjCDfnzKLCUpyQgPyiJWhkOlvI8HGBZtRkPh/gAF
         nHpSPRihYEnf5qvcX/kljuffy2wIzoQdOya+fq+XPG6JLsfA+2mb/1I0iijy8uoGpnHY
         YQmoc6A48p5WqlIgPAJkLpXj0b7dXVxOyOZPX5cWRFX12WBs8m3Q4wV8wPwWz8/1M6Io
         OCoOGYx9qexZFtAaSNRFbU2FT/ySn6l0NXUG5WeV6yvNPyCr0PorcsvlZvtpc/hEASK2
         jS/vWdk3kHR6XuQ5gy7Xv3XadTKZgoUdu/2XsoVizgIMJ43HVo3tASjWxAhSzzo8lyYD
         omTw==
X-Gm-Message-State: AOAM5317ZghE3mn6F1ahxpkUclFcFNPzHPjKW1AmX7dZdkfM7+K0QA77
        G4SaCb2tMjGNul1s2tEsVvtZwZo8gPGWzt4=
X-Google-Smtp-Source: ABdhPJxDNziGYjzb/ZRm1pevbyvVdw8eQjc7VwyCozk0n3Hczh8k36e8/hVih9NxH0h+d3gtUEehLBH2IOPtLgg=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:25c3:0:b0:633:8079:1768 with SMTP id
 l186-20020a2525c3000000b0063380791768mr21066931ybl.488.1648439997054; Sun, 27
 Mar 2022 20:59:57 -0700 (PDT)
Date:   Mon, 28 Mar 2022 03:59:39 +0000
Message-Id: <20220328035951.1817417-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [RFC v4 0/8] Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
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

Hridya Valsaraju (5):
  gpu: rfc: Proposal for a GPU cgroup controller
  cgroup: gpu: Add a cgroup controller for allocator attribution of GPU
    memory
  dmabuf: heaps: export system_heap buffers with GPU cgroup charging
  dmabuf: Add gpu cgroup charge transfer function
  binder: Add a buffer flag to relinquish ownership of fds

T.J. Mercier (3):
  dmabuf: Use the GPU cgroup charge/uncharge APIs
  binder: use __kernel_pid_t and __kernel_uid_t for userspace
  selftests: Add binder cgroup gpu memory transfer test

 Documentation/gpu/rfc/gpu-cgroup.rst          | 183 +++++++
 Documentation/gpu/rfc/index.rst               |   4 +
 drivers/android/binder.c                      |  26 +
 drivers/dma-buf/dma-buf.c                     | 107 ++++
 drivers/dma-buf/dma-heap.c                    |  27 +
 drivers/dma-buf/heaps/system_heap.c           |   3 +
 include/linux/cgroup_gpu.h                    | 139 +++++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/dma-buf.h                       |  22 +-
 include/linux/dma-heap.h                      |  11 +
 include/uapi/linux/android/binder.h           |   5 +-
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/gpu.c                           | 362 +++++++++++++
 .../selftests/drivers/android/binder/Makefile |   8 +
 .../drivers/android/binder/binder_util.c      | 254 +++++++++
 .../drivers/android/binder/binder_util.h      |  32 ++
 .../selftests/drivers/android/binder/config   |   4 +
 .../binder/test_dmabuf_cgroup_transfer.c      | 484 ++++++++++++++++++
 19 files changed, 1679 insertions(+), 4 deletions(-)
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
2.35.1.1021.g381101b075-goog

