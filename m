Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733EB72DB7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjFMHtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbjFMHtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 03:49:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62B10CC
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 00:49:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f620583bc2so6219094e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642575; x=1689234575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moJN+g8UiI2hq78ltZSSLuP9Xu72wgPasq355As9aLA=;
        b=jOjKffaHPlrXbRTvLrrGNPnl+MXhW2iVgyKxsqO/GF/igHOtyq4n0fpXrJdvfXsllM
         QUemy3UwuRMz1DALtR4jszRFg4IWG+fIacrlX93aHyC7+8oXwZjP5l1LPYFpLA3VtHMF
         wcFSpX6k24IKLvljp4MUGmlv0mwqS/DEju2uDPHvsoPqanW8K1r0gMwxVesGNgPlgSFj
         zAaSuyiNiezWxRCugqlTI2nRVCp8VU7IU87VWLAWoPN4/6Pm0tqvLElsN7uz5CUEFGXs
         8H6G0guic+grViobw+IjXjatk64VX6mJzldZ1IQL8IDVK07P1e8MOLtsqTvViSXuS54f
         /ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642575; x=1689234575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moJN+g8UiI2hq78ltZSSLuP9Xu72wgPasq355As9aLA=;
        b=k68G8xCVfIG2ps6GvM8u57JUNsGur9avGviObSNzhIs7UDd0ioXsP8M5AFE5Heu3Gf
         i68AB30tpjPwU2blevxgG3/II/LLamMsdYLT56TyLMNN2mUntRp9R59GkGXuw4uZLQEq
         RQFDTAjf3MPeknEipGDvmHjEN8ajK2VfaV02Qg9zruvFHhnwb46Hd7sZ+Ddup1jEKEXm
         gsApHtmPyVVTgTvX6Qy73M6SDW8oBW6l4uSp64OykGOPnBm04+iTY72W7NgtLuZ7/kxf
         UCIsoiwBxzOzeWQYD9tdAXvjFIo+W/fXhZ2RToFPnl3LHnwWx6QaJTdBq4UrF4yriVBq
         5eFQ==
X-Gm-Message-State: AC+VfDyIHl8PwJww2367SdDBiIa3P9w4du6k6HcPOWjzMLijwjfnK2aA
        WBtW3zETXkigDiBLPbuE6JXLPg==
X-Google-Smtp-Source: ACHHUZ4Brvk4VUnI5nNu7VvfinjgpGhKWNRerS/+/J5dQ9SyiAb7NBLslJsBtFOOC/fTBvmyUkOYCg==
X-Received: by 2002:a2e:918a:0:b0:2ad:8929:e8f4 with SMTP id f10-20020a2e918a000000b002ad8929e8f4mr4071464ljg.43.1686642574978;
        Tue, 13 Jun 2023 00:49:34 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9a87000000b002adb10a6620sm1990220lji.107.2023.06.13.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:49:34 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        usama.anjum@collabora.com, jhubbard@nvidia.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: lib.mk: fix out-of-tree builds
Date:   Tue, 13 Jun 2023 09:49:31 +0200
Message-Id: <20230613074931.666966-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since commit ("selftests: error out if kernel header files are not yet
built") got merged, the kselftest build correctly because the
KBUILD_OUTPUT isn't set when building out-of-tree and specifying 'O='
This is the error message that pops up.

make --silent --keep-going --jobs=32 O=/home/anders/.cache/tuxmake/builds/1482/build INSTALL_PATH=/home/anders/.cache/tuxmake/builds/1482/build/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- V=1 CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
make[3]: Entering directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'

-e [1;31merror[0m: missing kernel header files.
Please run this and try again:

    cd /home/anders/src/kernel/next/tools/testing/selftests/../../..
    make headers

make[3]: Leaving directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
make[3]: *** [../lib.mk:77: kernel_header_files] Error 1

Fixing the issue by assigning KBUILD_OUTPUT the same way how its done in
kselftest's Makefile. By adding 'KBUILD_OUTPUT := $(O)' 'if $(origin O)'
is set to 'command line'. This will set the the BUILD dir to
KBUILD_OUTPUT/kselftest when doing out-of-tree builds which makes them
in its own separete output directory.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/lib.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b8ea03b9a015..d17854285f2b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -44,6 +44,10 @@ endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
+ifeq ("$(origin O)", "command line")
+  KBUILD_OUTPUT := $(O)
+endif
+
 ifneq ($(KBUILD_OUTPUT),)
   # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
   # expand a shell special character '~'. We use a somewhat tedious way here.
-- 
2.39.2

