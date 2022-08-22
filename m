Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6859B7AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiHVCae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiHVCaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:21 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B120BD4;
        Sun, 21 Aug 2022 19:30:20 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a10so3819584uas.7;
        Sun, 21 Aug 2022 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9bmUDAeYwYNk7Lncy4qn1xUrVgxGePb5aTQwwrrNPmQ=;
        b=NE3inPhDNx3gdUKcuM+tPMg+JUMuH1247ytZb8zccgs4NtyzyjgLmtFhykXBEMYz2U
         6WgYdpj0PrKFmF5D89cWm9fAdR3HNDr2bp1ALAWYSzSDRQARmHaoi13LQVd7CzBRFR5x
         sRnstKwOjNAboq4d6LWVGdA/Q86Xr8CqNZGMAjsu7E6bjvO//7p8SYJcTf6omnKjoVP2
         zbWNwnNxn9gNUbzTuxmlKCnZ+7NYa3xhP1apfSUstVH8Z0XT2KNHtJmm7/1+VlSRLvDx
         o2n2RSdmLvqGnHfKIXP2KizE2FLK1fMrN3tP4BjDxm9uA8CMAGrpcYzzhnbivMmbZuhn
         h8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9bmUDAeYwYNk7Lncy4qn1xUrVgxGePb5aTQwwrrNPmQ=;
        b=O+w2Xs1Zq4Cj8LxduBLp75oPHPUQuwRIXzO+01R4A22FIBGfpczUjxFK9dhgQ1Njgj
         cnW8Ez13VvwypiII9rSCF7vaxVkOPl3ZgQUoT/fpsvPpnSA9x86rcXyzlt4ZaaiR5LZg
         S7kVi36u7u+e3bAne2pBuLM1HUauOYoL/TQSSAoQPOG6tFEEY8pfUA+iGtVSvC8IY2C9
         oDlUFTGsQgHmIFqJ9LlBcwG5aU1XTIRqW4T5q5xTV0slvGvz45Hva5OT9qGKSUJPpFas
         2grdVeuRdjnzjhk4UijWi3BEkvxmneBRzPnfMOJOsIV+l+gKGfOVAxgGe8orRIS2iy55
         uR7A==
X-Gm-Message-State: ACgBeo2/bTL0GT5Qom1mZbg3QWoXuVXpNfslHsmpqMuMWDPw304FjPdW
        hBOaDf4Md9GGjXvjFNUMm7hmwfp3BaHLWQ==
X-Google-Smtp-Source: AA6agR4qhRBZubNlPLUdvrgppeNgtv4/VVy6ftdTKy7n/whZbDUXhZFI7ne3SDfMCYRq+5a4JZKBKA==
X-Received: by 2002:ab0:23c9:0:b0:39b:52f0:810d with SMTP id c9-20020ab023c9000000b0039b52f0810dmr5666296uan.46.1661135419616;
        Sun, 21 Aug 2022 19:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:19 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 0/8] Documentation: Kunit: clean kunit-tool.rst and start.rst
Date:   Sun, 21 Aug 2022 23:26:38 -0300
Message-Id: <20220822022646.98581-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Continuing the documentation refactoring started by Harinder Singh[1],
removes kunit-tool.rst, which had its information rearranged into run_wrapper,
and employs further work in the index and the getting-started guide.

This series was written on top of another[2] that haven't got applied yet,
but the only dependency it has is the "kunit-on-qemu" anchor used in start.rst.

Changelog:

v1 -> v2:

- Update expected output for `kunit.py run` from "Generating .config ..." to
"Configuring KUnit Kernel ..."
- Update run_wrapper titles as suggested by Sadiya Kazi
- Remove confusing recommendation from start.rst intro, highlighted by Tim Bird
- Fix grammars nits pointed by Maíra Canal and Sadiya Kazi
- Add some reviewed-by

Thanks again for your feedbacks,
Tales

[1] https://lore.kernel.org/r/20211217044911.798817-1-sharinder@google.com/
[2] https://lore.kernel.org/r/20220813042055.136832-1-tales.aparecida@gmail.com/

Tales Aparecida (8):
  Documentation: KUnit: remove duplicated docs for kunit_tool
  Documentation: KUnit: avoid repeating "kunit.py run" in start.rst
  Documentation: KUnit: add note about mrproper in start.rst
  Documentation: KUnit: Reword start guide for selecting tests
  Documentation: KUnit: add intro to the getting-started page
  Documentation: KUnit: update links in the index page
  lib: overflow: update reference to kunit-tool
  lib: stackinit: update reference to kunit-tool

 Documentation/dev-tools/kunit/index.rst       |  16 +-
 Documentation/dev-tools/kunit/kunit-tool.rst  | 232 ------------------
 Documentation/dev-tools/kunit/run_wrapper.rst |  34 +--
 Documentation/dev-tools/kunit/start.rst       | 136 ++++++----
 lib/overflow_kunit.c                          |   2 +-
 lib/stackinit_kunit.c                         |   2 +-
 6 files changed, 117 insertions(+), 305 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
prerequisite-patch-id: b794218cd939a6644aaf5fb2a73997c56a624c80
prerequisite-patch-id: ccd24491ae99152ebdc6dcb8ddb9499d3456a4a0
prerequisite-patch-id: cc17b80d42fd5f5049e144da5c04e922036a33eb
prerequisite-patch-id: ba7edd270c6f285352e0e17bfe65ff6119192113
-- 
2.37.2

