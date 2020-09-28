Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCF27B636
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgI1U1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgI1U05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:26:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C348C0613D5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so1377855pjg.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84Wkm7II+zR8a1S1XbEc0SAaLAitSu9by2LK3K8LLZY=;
        b=jzjFbeQC0BOwC59BlIVN2ZD9Bjg+kpxXoCamP3rbFMeNXlT5A44rhrBi1/hP2VR/2N
         Yz4xMvTvF/IVCMTawSARPCrWJFAyxjqHWONLjXci0pBwHhpp+qK7flV9anmFW0vYRW97
         kRVlk0d7tppB+g7b5R7BN30fkEEi2ATsg6ztU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84Wkm7II+zR8a1S1XbEc0SAaLAitSu9by2LK3K8LLZY=;
        b=gTKsTmBYpfthIjDJ++tiWSSkHflY2tOw74PCZdmkIVQrVYUTk923g57aua+ldnEdcZ
         1VlX6UyuTcvZ6jrlxP0clasIjl+bRRgvZzgK01nzECgmAa7WioBbIa5VoiBlx5wAnp7M
         UghVzS3hl0s648+Q7CbnEsurt2I0IW8EDMhj20IFpgQopSfPlvnBo/CJtqP8GtqhbTbj
         41bxtT172xGPSNZAsf7xF+NdmMUCFScFocSfX/SPKFmhV8xfaOq0me2Hl/KbLsLoDbEO
         Y1SQR3g5IgRvAy5AiSdNV2tH11+dGW2wHbns0dPt6Dt6QQD8je2I+qDFCFvaMK6Rkix0
         ajjw==
X-Gm-Message-State: AOAM533KiArREj47zoqAWM8MDzNApRKXbVoWvd37/XO3L3ZmuEDjwUF9
        PpV+7V1KxXVOoVZqsnE13IHD5A==
X-Google-Smtp-Source: ABdhPJzunOfjF8LprL3XY61w3FvvpSkqtHIqXlVfnXXgRC88QVU+My/W354njw01Dr7RLCEJWbZv+Q==
X-Received: by 2002:a17:90a:e38a:: with SMTP id b10mr817027pjz.17.1601324815742;
        Mon, 28 Sep 2020 13:26:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16sm2107828pgl.78.2020.09.28.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:26:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/3] doc: dev-tools: kselftest.rst: Update examples and paths
Date:   Mon, 28 Sep 2020 13:26:50 -0700
Message-Id: <20200928202650.2530280-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928202650.2530280-1-keescook@chromium.org>
References: <20200928202650.2530280-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the installation commands and path details, detail the new
options available in the run_kselftests.sh script.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/dev-tools/kselftest.rst | 35 +++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 469d115a95f1..a901def730d9 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -125,32 +125,41 @@ Note that some tests will require root privileges.
 Install selftests
 =================
 
-You can use the kselftest_install.sh tool to install selftests in the
-default location, which is tools/testing/selftests/kselftest, or in a
-user specified location.
+You can use the "install" target of "make" (which calls the `kselftest_install.sh`
+tool) to install selftests in the default location (`tools/testing/selftests/kselftest_install`),
+or in a user specified location via the `INSTALL_PATH` "make" variable.
 
 To install selftests in default location::
 
-   $ cd tools/testing/selftests
-   $ ./kselftest_install.sh
+   $ make -C tools/testing/selftests install
 
 To install selftests in a user specified location::
 
-   $ cd tools/testing/selftests
-   $ ./kselftest_install.sh install_dir
+   $ make -C tools/testing/selftests install INSTALL_PATH=/some/other/path
 
 Running installed selftests
 ===========================
 
-Kselftest install as well as the Kselftest tarball provide a script
-named "run_kselftest.sh" to run the tests.
+Found in the install directory, as well as in the Kselftest tarball,
+is a script named `run_kselftest.sh` to run the tests.
 
 You can simply do the following to run the installed Kselftests. Please
 note some tests will require root privileges::
 
-   $ cd kselftest
+   $ cd kselftest_install
    $ ./run_kselftest.sh
 
+To see the list of available tests, the `-l` option can be used::
+
+   $ ./run_kselftest.sh -l
+
+The `-c` option can be used to run all the tests from a test collection, or
+the `-t` option for specific single tests. Either can be used multiple times::
+
+   $ ./run_kselftest.sh -c bpf -c seccomp -t timers:posix_timers -t timer:nanosleep
+
+For other features see the script usage output, seen with the `-h` option.
+
 Packaging selftests
 ===================
 
@@ -160,9 +169,9 @@ different system. To package selftests, run::
    $ make -C tools/testing/selftests gen_tar
 
 This generates a tarball in the `INSTALL_PATH/kselftest-packages` directory. By
-default, `.gz` format is used. The tar format can be overridden by specifying
-a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_ option
-is supported, such as::
+default, `.gz` format is used. The tar compression format can be overridden by
+specifying a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_
+option is supported, such as::
 
     $ make -C tools/testing/selftests gen_tar FORMAT=.xz
 
-- 
2.25.1

