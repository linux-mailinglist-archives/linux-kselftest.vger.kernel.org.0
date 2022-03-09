Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B554D35A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiCIRFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiCIRD5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 12:03:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6F1B50D6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 08:52:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v1-20020a25fc01000000b006289a83ed20so2137701ybd.7
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=b9rEV04bDQiBKY+clzVAAUwX0PEEzTz5v0uyyD6Ky9s=;
        b=XPzsQHeRUNiY59+5nJm7mrBdRIxBkcExNssQMplqKGecYVGAuoWNOzfsQ/CRHGT3Eb
         L8N78lNgsuxsZppqNYdkHimSfJaRLuWqSnEH8yK3GxU8bsscjb4ePNbipVnp6tCT8IVF
         UaUIxl8y648Eqm5tHOyCh2213Fk/nnv9V9GWAOVVkJeRQIHfCE/FgeEvesm4pyz9OWp/
         jT/gMhsLrbq/1Tv7Gt/fcrwf/RPUzCl8lb+iIaUhtm6WEF9fuNYOWUF4Z36cCRwe+NRS
         IxH3+7RqukqcHYT+xGqH3TFqjhzJCVwErPB8Qpl0MdPoc7qtVg+T57NWV82loz0fFGAg
         92Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=b9rEV04bDQiBKY+clzVAAUwX0PEEzTz5v0uyyD6Ky9s=;
        b=ojKuN0VaCpFciVYR9Trphr0BIaU5PlS7ZBEb7uTzjwSR1VGu0PEBsm+gHzqADWT/g1
         oxsMRyJiRETPNCRInkWb+UhcaUb/mWpr2NvN52ohtr6N00S0J2710DmcECiqRcQcRqSZ
         ptAE6mW/HezYXHBG2YwZwmNApdwO9x3Yvx5yLfJsLo2vt8EMhXeYSrMcAGUxMv8rYutQ
         g0Erv2QHJzJ7/aqtU7ZUTsrrpEXVuSywWpt5vWJYmW1kP/ilwNi6qWqg0+jElRAd5E+x
         D38zO0Ghq5y57sgoAl7Ny8Bt4neLLYhERs3y4xSahUnIPzXz5ecMz6z+/yiU1d2l3rod
         ZLyw==
X-Gm-Message-State: AOAM533gklVdVJypBeF5ZvQTU8wKHmCibMdmiXClBMFovwmo4WbAiyC7
        CF5Y1xGtb+GzvpJyiF3VVGuukwbHrmgI2+k=
X-Google-Smtp-Source: ABdhPJwRyTuMCrRO/Vp1TWAVYo92UjVf5vBh6X32/4NRRO9jJMcVfdRLSkjJkXNfpEsU2vu7P7SPJtB45/CUe/4=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:3494:0:b0:628:7de8:fe8c with SMTP id
 b142-20020a253494000000b006287de8fe8cmr566332yba.68.1646844747351; Wed, 09
 Mar 2022 08:52:27 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:52:10 +0000
Message-Id: <20220309165222.2843651-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [RFC v3 0/8] Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
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
 drivers/dma-buf/dma-buf.c                     | 100 ++++
 drivers/dma-buf/dma-heap.c                    |  27 +
 drivers/dma-buf/heaps/system_heap.c           |   3 +
 include/linux/cgroup_gpu.h                    | 127 +++++
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/dma-buf.h                       |  22 +-
 include/linux/dma-heap.h                      |  11 +
 include/uapi/linux/android/binder.h           |   5 +-
 init/Kconfig                                  |   7 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/gpu.c                           | 304 +++++++++++
 .../selftests/drivers/android/binder/Makefile |   8 +
 .../drivers/android/binder/binder_util.c      | 254 +++++++++
 .../drivers/android/binder/binder_util.h      |  32 ++
 .../selftests/drivers/android/binder/config   |   4 +
 .../binder/test_dmabuf_cgroup_transfer.c      | 480 ++++++++++++++++++
 19 files changed, 1598 insertions(+), 4 deletions(-)
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
2.35.1.616.g0bdcbb4464-goog

