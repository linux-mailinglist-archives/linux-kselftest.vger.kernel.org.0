Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E7553B26
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 22:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352707AbiFUUKI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiFUUKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 16:10:07 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08E175B7
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:02 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1048b8a38bbso3081896fac.12
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s6LYQb1RnyOah+Vf4u3lUiqXdFXBvfMKhbfFyaK0xHU=;
        b=jB4V6Sxm/RLqUFXdLONSddQ8wIDeEJQkEFsUz+QPH8+oaNv+yg90dAH1VHVnQ8i6hI
         2lsHuKH4XmXExYZhNtG1DT1nohD8z6KdtMxTEI7O/CMtWP9/KDihM7FGAbwqbOqR+MvY
         XQDhPV+BW97Er/5quLx5ZNFsKYuR0GW/SqduRU7b4rH1eNUBk9ju53rOKpDzxlIXd9yF
         Ax6Gu3iSgWb56t++EOLdofveMck/HJRa9WJYUYtq4n42+22GdK94WCUHUuBnnJFvUNla
         LwT4xtpTTPNwuOUTpOJrkCa7INXws+VfpytWSQo7xagB+DrrZPg+1XOslp3b/eT407TW
         FunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s6LYQb1RnyOah+Vf4u3lUiqXdFXBvfMKhbfFyaK0xHU=;
        b=gpirJTKhgOueRpFTwjZdyAtaUqW7vX43WbtgfC0Q7JNtsjqgiNO6ig3RxCZiCJq9Dp
         Zfm+DLsf5jrn/LbjvGdKU5++/Uyle54UUpzi6KPzNNedqsXk+nSRkzYUd7K3V2clLYNX
         YYS0BamM+W5FwJKdH54P18cyRWdN53KOuXBPHFl6Myx8eaY0okfaf9i2e0gvmxME3qqF
         NrD0OCUBaVng4pA5e4lMGWKY1ELcmYLGOTox8Xtad+PIbQinE337TVhyspAER9v0K+U4
         Kh0NQzEqXurhGjPRHAns1MzMTlyslR8evchjHAqN1+H3oOM7lnwVSn7DXuxyR6BSg19P
         CgCQ==
X-Gm-Message-State: AJIora/XcC1Wik469JKOBy63YKwRrbUV3GrnrxdFlyb3mZ1LzIOgP92L
        XCx43iny1vlProwvF8hkUDmn+g==
X-Google-Smtp-Source: AGRyM1uicnSWZyT3v8OKH+0e43MESlWzj/5bQ9ArcRQ7M0A8PfHYAOGuromGspV1CFK8oo+b5LndDA==
X-Received: by 2002:a05:6870:339a:b0:f2:d065:be1f with SMTP id w26-20020a056870339a00b000f2d065be1fmr15712219oae.69.1655842201550;
        Tue, 21 Jun 2022 13:10:01 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o206-20020acad7d7000000b0032b7a0c5da1sm9759771oig.27.2022.06.21.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:10:01 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
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
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH v2 0/9] drm: selftest: Convert to KUnit
Date:   Tue, 21 Jun 2022 17:09:17 -0300
Message-Id: <20220621200926.257002-1-maira.canal@usp.br>
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

Hi everyone,

Here is the v2 of the conversion of DRM selftests to KUnit. Some style changes
were made to align to the drm_format_helper series [1] and the documentation [2],
as renaming the kunit_suite and the test cases to use underscores as suggested,
changing the filenames and using a generic symbol to group all tests at the
config menu.

Moreover, in the previous version of the series, the drm_cmdline_parser tests
were broken into multiple test functions. As pointed out by Shuan Khan, it made
the tests harder to comprehend. So, the refactoring was dropped and
straightforward conversion of the tests was made without any functional changes.

Thanks for your attention and any feedback is welcomed!

Best Regards,
- Maíra Canal

v1 -> v2: https://lore.kernel.org/dri-devel/20220615135824.15522-1-maira.canal@usp.br/T/

- The suites no longer end in _tests (David Gow).
- Remove the TODO entry involving the conversion of selftests to KUnit (Javier Martinez Canillas).
- Change the filenames to match the documentation: use *_test.c (Javier Martinez Canillas).
- Add MODULE_LICENSE to all tests (kernel test robot).
- Make use of a generic symbol to group all tests - DRM_KUNIT_TEST (Javier Martinez Canillas).
- Add .kunitconfig on the first patch (it was on the second patch of the series).
- Straightforward conversion of the drm_cmdline_parser tests without functional changes (Shuah Khan)
- Add David's Tested-by tags

[1] https://lore.kernel.org/dri-devel/20220620160640.3790-1-jose.exposito89@gmail.com/T/
[2] https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html

Arthur Grillo (1):
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

 Documentation/gpu/todo.rst                    |   11 -
 drivers/gpu/drm/Kconfig                       |   15 +-
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
 drivers/gpu/drm/tests/Makefile                |    6 +
 drivers/gpu/drm/tests/drm_buddy_test.c        |  748 +++++++++++
 .../gpu/drm/tests/drm_cmdline_parser_test.c   | 1078 ++++++++++++++++
 .../gpu/drm/tests/drm_damage_helper_test.c    |  633 +++++++++
 .../drm_dp_mst_helper_test.c}                 |   84 +-
 drivers/gpu/drm/tests/drm_format_test.c       |  284 ++++
 .../drm_framebuffer_test.c}                   |   25 +-
 .../test-drm_mm.c => tests/drm_mm_test.c}     | 1135 +++++++---------
 .../drm_plane_helper_test.c}                  |  103 +-
 .../test-drm_rect.c => tests/drm_rect_test.c} |  124 +-
 27 files changed, 3395 insertions(+), 4331 deletions(-)
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
 create mode 100644 drivers/gpu/drm/tests/Makefile
 create mode 100644 drivers/gpu/drm/tests/drm_buddy_test.c
 create mode 100644 drivers/gpu/drm/tests/drm_cmdline_parser_test.c
 create mode 100644 drivers/gpu/drm/tests/drm_damage_helper_test.c
 rename drivers/gpu/drm/{selftests/test-drm_dp_mst_helper.c => tests/drm_dp_mst_helper_test.c} (73%)
 create mode 100644 drivers/gpu/drm/tests/drm_format_test.c
 rename drivers/gpu/drm/{selftests/test-drm_framebuffer.c => tests/drm_framebuffer_test.c} (96%)
 rename drivers/gpu/drm/{selftests/test-drm_mm.c => tests/drm_mm_test.c} (58%)
 rename drivers/gpu/drm/{selftests/test-drm_plane_helper.c => tests/drm_plane_helper_test.c} (62%)
 rename drivers/gpu/drm/{selftests/test-drm_rect.c => tests/drm_rect_test.c} (53%)

-- 
2.36.1

