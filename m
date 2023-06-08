Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2A7279D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjFHIVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjFHIVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 04:21:34 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65942685
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 01:21:32 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43b28436ebeso61205137.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686212492; x=1688804492;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6tWt9hq7oJWIK0sNaWAHnzAJvTEXAfk0DnS35SM/QQw=;
        b=TxPpjwlI5V2V/STEYIyNogdtw0Tnl81nLYK7nEXOwxx9KyXd755BC2+Y/ZPdcCYzgb
         sP7CWPOAwODC4hj9MlqsBCFj1TNpoYhMNxp3ExYyRA0LQ6odGDeeh6tXIZll/KbPQrON
         6RQq12QuuGppcHXR3OzV/dnojaVWESC1HYfWIemlzIMpI8pdbmwy1AmJvRNvlu/s8p7e
         6MuFQ7S7k8UZWUHgmgWgvBgDvLv3VpU+bX7qL1+bTxTarbWk83jE7bHI6IvjsLiLndlU
         K8yv4v/SgmKdyl57TCLh0B6i5LjCw8wNjKCC5Y4Aq07QEgD7vbZr+yDQNbvbQAdNZ9/s
         gadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686212492; x=1688804492;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tWt9hq7oJWIK0sNaWAHnzAJvTEXAfk0DnS35SM/QQw=;
        b=PayQS6jpmmifwbIrRByyKL5WxI7iNb7guHQNISOpoIuLR/F1WjnRKW/PZwIkRPlLK4
         18P12AZRGwLGLhWcJ5jlOkXeSN1EZnCz8QZ1//JPSDgJgmFlzCfRvsXHtYTvZCFmD+m1
         eYh93HlO4ss1axBOCMt082B1x1w/NzIou2QCAHVe82LsBD6n6MuksP1iL/j0jGE83fnw
         VpSpXtQDL+lj9hUDrmWsDdgheZFnLsI9a+iV1lDnc6W+rSG/lfK2Nl80SKuFqCrPFrIN
         krZ9L4YDRB4RC76WaDC2b8QzWJaKBKt7lxnEEBs6v1G/o2VoZOscVptGf7ZkEiGIi5aZ
         fu+g==
X-Gm-Message-State: AC+VfDzFzOcYB0qRIWqaoeK/qqm6CHzl8fbFqbRnrXOTVkPKHpRRasac
        H82Ehfr+ewLSVw0KwGFd6LDYGEA5PyHUaqnvhGaDRw==
X-Google-Smtp-Source: ACHHUZ5LnBh74TZNJm+lPfZOtPEO8qBk+wfhEKNBUuSAJ7GJzh5GFnoTm8SYNEhtLtYsxRZYxlPmqcMaPOju8PDgpcI=
X-Received: by 2002:a05:6102:3a72:b0:43b:56af:df85 with SMTP id
 bf18-20020a0561023a7200b0043b56afdf85mr1466008vsb.15.1686212491646; Thu, 08
 Jun 2023 01:21:31 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Jun 2023 13:51:20 +0530
Message-ID: <CA+G9fYueMV2gFF0sYR4Lf3btcEoxMpOy0_YvpjvS26WFZ2pcBA@mail.gmail.com>
Subject: selftests: -e error: missing kernel header files. Please run this and
 try again
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The make kselftest-install failed on Linux next 20230608.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build
INSTALL_PATH=/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest_install
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang'
'CC=sccache clang' LLVM=1 LLVM_IAS=1 kselftest-install

make[3]: Entering directory '/builds/linux/tools/testing/selftests/alsa'

-e error: missing kernel header files.
Please run this and try again:

    cd /builds/linux/tools/testing/selftests/../../..
    make headers

make[3]: Leaving directory '/builds/linux/tools/testing/selftests/alsa'
make[3]: *** [../lib.mk:77: kernel_header_files] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links,
===
https://storage.tuxsuite.com/public/linaro/lkft/builds/2QsWmEgSFF9iwodTUrWsdopV4Qp/

--
Linaro LKFT
https://lkft.linaro.org
