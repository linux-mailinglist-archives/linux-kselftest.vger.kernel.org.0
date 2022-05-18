Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96F52B3A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiERHcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiERHcv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 03:32:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26261600
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:32:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lb8-20020a17090b4a4800b001df6e0cee58so2779936pjb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iQ99kfljfaTYAW2ip5rvwd86TKnP6A3rksjwxYstBo4=;
        b=ETFp28WBtIw6zb/DJo7OGxpWaRVPCwEwQt9Z2hKeNmR/PJKNghF1UGsbkeHcvdUDJn
         T3wCFW937vAzCH71CfXie9HSan7MicV1ubc2z928O1NfYC573yFGkTLcetWL9usAYSfE
         ZF3bXnDxVkPd8KmzaKepQtytaxixa2yQKQ6wKkRr/wK3u2S0rqiyI+rtSnjtQI31VfBA
         y6U2mbADctk6jti3nOtYQ1Vhi7dSVW9NE9Ba4jFfu20gFzOkjym6Ui/GYWZnSzd8amsB
         lcMBvit9jCohmiTRQfhmjbwnoFc39D8JRRyOA1y3iQqcvbK7KQJ5rj2vMwtkbNb/vmEC
         522g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iQ99kfljfaTYAW2ip5rvwd86TKnP6A3rksjwxYstBo4=;
        b=kF1rVhvGoLI4Z6aumCdScfYlSTkYhUsxgOgafn9ynQPMcu5Nj4prF7lejMuKgqEURe
         KAxbMzCuHjVZe+ir/3CzcmuLgz+qMaEf/d6v6Kf24b+TpthX2HMU3DogDFSypS4Y5FwW
         /swvHNOC3WQiUxIwDOtbUqxseiFchy6Lz4M74G2rW+2aFwR7K9OkxRu55ZsJO2hyVfkP
         q712bXMmYOX7xdcpvOKpuJPLB1mKH6xju3gSPRD86Lehtl4mbyxQlZ38TPTgawPykCpQ
         FolwKuPupSP0vcAwJxko8PrXP+UqXGUASnhjJ3UstiQ+Fk9UzFtP/FkMyA283L+E7lsn
         Mnmw==
X-Gm-Message-State: AOAM532ncyu3HewFO0J3ZecDByUE1VJ3rkEh6QM4HNYs0vQ+QEPRFqau
        x9TVOq3Wc2kWde5TdTA4yifQXjZVCX+ayw==
X-Google-Smtp-Source: ABdhPJzYuK9WCyWsUpBLz7QPszl6IDdlhu2s0sQHA/ptFulSvFsKkAlDK/HkIvTDFn7wZyynWOx9yXPeagmfpw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:b4f:b0:518:161a:ed40 with SMTP
 id p15-20020a056a000b4f00b00518161aed40mr3418498pfo.19.1652859170621; Wed, 18
 May 2022 00:32:50 -0700 (PDT)
Date:   Wed, 18 May 2022 15:32:31 +0800
Message-Id: <20220518073232.526443-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
8-cpu SMP setup. No other kunit_tool configurations provide an SMP
setup, so this is the best bet for testing things like KCSAN, which
require a multicore/multi-cpu system.

The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
KCSAN to run with a nontrivial number of worker threads, while still
working relatively quickly on older machines.

Signed-off-by: David Gow <davidgow@google.com>
---

This is based off the discussion in:
https://groups.google.com/g/kasan-dev/c/A7XzC2pXRC8

---
 tools/testing/kunit/qemu_configs/x86_64-smp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/kunit/qemu_configs/x86_64-smp.py

diff --git a/tools/testing/kunit/qemu_configs/x86_64-smp.py b/tools/testing/kunit/qemu_configs/x86_64-smp.py
new file mode 100644
index 000000000000..a95623f5f8b7
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/x86_64-smp.py
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
+			   kconfig='''
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SMP=y
+			   ''',
+			   qemu_arch='x86_64',
+			   kernel_path='arch/x86/boot/bzImage',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=['-smp', '8'])
-- 
2.36.0.550.gb090851708-goog

