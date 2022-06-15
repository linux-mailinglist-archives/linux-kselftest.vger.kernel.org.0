Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F654CA86
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353817AbiFON7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353788AbiFON7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 09:59:16 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9427B3A
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so8886025otg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtsboVTHSE/bkA7u3/jbXe0vzCJv+VUAjBvhjsMRO98=;
        b=mpSXxXmFCTMA/3nFJ4hzQIM91fTrCxP3+7WEvIzazeD7EJmSJT6aqC5BPE+KaWdGTy
         tqHeivqZD2o8hv9xrpyCqlKYQNbIZTE9fEt4EF6lKzd9GiR2c+wVtWwFanyrL9Vs61ut
         LlVrMrWDQ2IrERN6/GEnzd37ofFlEA27kIkJdHYcqTV94bKpEcv5aboRr7/MyVNzLRd1
         ktqO0Pj3MDhnU6TZZhGNpLJzIerX/wtfHMZTNGeGpNODgyHpSuP+qg2k7PcATRBskFrX
         pcfHktKZ93+5UAF+cuAMRVPHdj8PZesv4zKl4KEPct14KAfiaYYmOiuFMrC//rARPEuv
         bZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtsboVTHSE/bkA7u3/jbXe0vzCJv+VUAjBvhjsMRO98=;
        b=8EbQj7gyN4wog9CQkliQouij2oZ9gjfr7KjEEzVloLrFyFTxPDUaCvvs8sG1eT7MnI
         HkfpPQNwwp7gDC8T7H0Tb2ih/gJbDFNnuBMoYYUH2MdnjjjfHU9bvCCdg59Cm3/o4Bo6
         UIgwSKR/1dCFQCxlRWdIF7z48I0RqlhWizHPUqygpG8P+wBN0Y7vDGkBwozUjdvMYs+C
         hd0wJtJwUPTQxjEi7Wc3hK+E8F0pwTtT1KbMkyWO8COufO4jpFDTlxPX7PpQSYq0LRC/
         vYvMrD2Ziec0GSlvn5W9uhIRH8ZwU7L2Igl68fDQs1O7Cvjt4gC5OOuwb1IWl9Ax8aq3
         SEuA==
X-Gm-Message-State: AOAM530kd0nvzWNuuZY+bH29LwmuJh3nGjpSooL+ICHoKR4sCHqpTuuk
        MDBLypfKxBjMKMhvvez2hSwn4A==
X-Google-Smtp-Source: ABdhPJwjIm/CMZuWBN+ZybqgyeNh5zv9KD4psXkuwZd9KZ/7TwjK3tnggP/9fFvwHZRdeYQXIanA0A==
X-Received: by 2002:a05:6830:87:b0:60c:2c2c:adaa with SMTP id a7-20020a056830008700b0060c2c2cadaamr4254321oto.188.1655301548845;
        Wed, 15 Jun 2022 06:59:08 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id u7-20020a056830248700b0060bfebb96e5sm6056928ots.35.2022.06.15.06.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:59:08 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH 00/10] drm: selftest: Convert to KUnit
Date:   Wed, 15 Jun 2022 10:58:14 -0300
Message-Id: <20220615135824.15522-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit unifies the test structure and provides helper tools that simplify
the development of tests. The basic use case allows running tests as regular
processes, which makes it easier to run unit tests on a development machine
and to integrate the tests into a CI system.

That said, the conversion of selftests for DRM to KUnit tests is beneficial
as it unifies the testing API by using the KUnit API.

KUnit is beneficial for developers as it eases the process to run unit tests.
It is possible to run the tests by using the kunit-tool on userspace with the
following command:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests --arch=x86_64

For CI system, it is possible to execute during the build. But, we also think
about IGT: we are developing a patch to introduce KUnit to IGT.

These patches were developed during a KUnit hackathon [0] last October. Now,
we believe that both the IGT side and the Kernel side are in good shape for
submission.

If you are willing to check the output, here is the Pastebin with the output
and execution times [1].

[0] https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
[1] https://pastebin.com/FJjLPKsC

- Arthur Grillo, Isabella Basso, and Maíra Canal

Arthur Grillo (2):
  drm: selftest: refactor drm_cmdline_parser
  drm: selftest: convert drm_mm selftest to KUnit

Maíra Canal (8):
  drm: selftest: convert drm_damage_helper selftest to KUnit
  drm: selftest: convert drm_cmdline_parser selftest to KUnit
  drm: selftest: convert drm_rect selftest to KUnit
  drm: selftest: convert drm_format selftest to KUnit
  drm: selftest: convert drm_plane_helper selftest to KUnit
  drm: selftest: convert drm_dp_mst_helper selftest to KUnit
  drm: selftest: convert drm_framebuffer selftest to KUnit
  drm: selftest: convert drm_buddy selftest to KUnit

 drivers/gpu/drm/Kconfig                       |   20 +-
 drivers/gpu/drm/Makefile                      |    2 +-
 drivers/gpu/drm/selftests/Makefile            |    8 -
 .../gpu/drm/selftests/drm_buddy_selftests.h   |   15 -
 .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
 drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
 .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
 drivers/gpu/drm/selftests/drm_selftest.c      |  109 --
 drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
 drivers/gpu/drm/selftests/test-drm_buddy.c    |  994 --------------
 .../drm/selftests/test-drm_cmdline_parser.c   | 1141 -----------------
 .../drm/selftests/test-drm_damage_helper.c    |  667 ----------
 drivers/gpu/drm/selftests/test-drm_format.c   |  280 ----
 .../drm/selftests/test-drm_modeset_common.c   |   32 -
 .../drm/selftests/test-drm_modeset_common.h   |   52 -
 drivers/gpu/drm/tests/.kunitconfig            |    3 +
 drivers/gpu/drm/tests/Kconfig                 |  130 ++
 drivers/gpu/drm/tests/Makefile                |   10 +
 drivers/gpu/drm/tests/test-drm_buddy.c        |  748 +++++++++++
 .../gpu/drm/tests/test-drm_cmdline_parser.c   |  799 ++++++++++++
 .../gpu/drm/tests/test-drm_damage_helper.c    |  633 +++++++++
 .../test-drm_dp_mst_helper.c                  |   82 +-
 drivers/gpu/drm/tests/test-drm_format.c       |  284 ++++
 .../test-drm_framebuffer.c                    |   25 +-
 .../drm/{selftests => tests}/test-drm_mm.c    | 1135 +++++++---------
 .../test-drm_plane_helper.c                   |  101 +-
 .../drm/{selftests => tests}/test-drm_rect.c  |  124 +-
 27 files changed, 3240 insertions(+), 4331 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/Makefile
 delete mode 100644 drivers/gpu/drm/selftests/drm_buddy_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_buddy.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
 create mode 100644 drivers/gpu/drm/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/tests/Kconfig
 create mode 100644 drivers/gpu/drm/tests/Makefile
 create mode 100644 drivers/gpu/drm/tests/test-drm_buddy.c
 create mode 100644 drivers/gpu/drm/tests/test-drm_cmdline_parser.c
 create mode 100644 drivers/gpu/drm/tests/test-drm_damage_helper.c
 rename drivers/gpu/drm/{selftests => tests}/test-drm_dp_mst_helper.c (73%)
 create mode 100644 drivers/gpu/drm/tests/test-drm_format.c
 rename drivers/gpu/drm/{selftests => tests}/test-drm_framebuffer.c (96%)
 rename drivers/gpu/drm/{selftests => tests}/test-drm_mm.c (58%)
 rename drivers/gpu/drm/{selftests => tests}/test-drm_plane_helper.c (62%)
 rename drivers/gpu/drm/{selftests => tests}/test-drm_rect.c (53%)

-- 
2.36.1

