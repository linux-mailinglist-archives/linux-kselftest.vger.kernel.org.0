Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D97B10DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 04:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjI1Cnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 22:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Cnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:49 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757794;
        Wed, 27 Sep 2023 19:43:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vt.rlBx_1695869003;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlBx_1695869003)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:45 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 0/5] pstore: add tty frontend and multi-backend
Date:   Thu, 28 Sep 2023 10:42:39 +0800
Message-Id: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In public cloud scenario, if kdump service works abnormally,
users cannot get vmcore. Without vmcore, user has no idea why the
kernel crashed. Meanwhile, there is no additional information
to find the reason why the kdump service is abnormal.

One way is to obtain console messages through VNC. The drawback 
is that VNC is real-time, if user missed the timing to get the VNC
output, the crash needs to be retriggered.

Another way is to enable the console frontend of pstore and record the
console messages to the pstore backend. On the one hand, the console
logs only contain kernel printk logs and does not cover
user-mode print logs. Although we can redirect user-mode logs to the
pmsg frontend provided by pstore, user-mode information related to
booting and kdump service vary from systemd, kdump.sh, and so on which
makes redirection troublesome. So we added a tty frontend and save all
logs of tty driver to the pstore backend.

Another problem is that currently pstore only supports a single backend.
For debugging kdump problems, we hope to save the console logs and tty
logs to the ramoops backend of pstore, as it will not be lost after
rebooting. If the user has enabled another backend, the ramoops backend
will not be registered. To this end, we add the multi-backend function
to support simultaneous registration of multiple backends.

Based on the above changes, we can enable pstore in the crashdump kernel
and save the console logs and tty logs to the ramoops backend of pstore.
After rebooting, we can view the relevant logs by mounting the pstore
file system.

Furthermore, we also modified kexec-tools referring to crash-utils for
reading memory, so that pstore ramoops information can be read without
enabling pstore in first kernel. As we set the address and size of ramoops,
as well as the sizes of console and tty, we can infer the physical address
of console logs and tty logs in memory. Referring to the read method of
crash-utils, the console logs and tty logs are read from the memory,
user can get pstore debug information without affecting the first kernel
at all.

kexec-tools modification can be seen at
https://github.com/shuyuanmen/kexec-tools/blob/main/Add-pstore-segment.patch

Yuanhe Shu (5):
  pstore: add tty frontend
  pstore: add multi-backends support
  pstore: add subdirs for multi-backends
  pstore: remove the module parameter "backend"
  tools/pstore: update pstore selftests

 drivers/tty/n_tty.c                         |   1 +
 fs/pstore/Kconfig                           |  23 ++
 fs/pstore/Makefile                          |   2 +
 fs/pstore/blk.c                             |  10 +
 fs/pstore/ftrace.c                          |  22 +-
 fs/pstore/inode.c                           |  86 ++++++-
 fs/pstore/internal.h                        |  16 +-
 fs/pstore/platform.c                        | 238 ++++++++++++--------
 fs/pstore/pmsg.c                            |  23 +-
 fs/pstore/ram.c                             |  40 +++-
 fs/pstore/tty.c                             |  56 +++++
 fs/pstore/zone.c                            |  42 +++-
 include/linux/pstore.h                      |  33 +++
 include/linux/pstore_blk.h                  |   3 +
 include/linux/pstore_ram.h                  |   1 +
 include/linux/pstore_zone.h                 |   2 +
 include/linux/tty.h                         |  14 ++
 tools/testing/selftests/pstore/common_tests |   4 -
 18 files changed, 500 insertions(+), 116 deletions(-)
 create mode 100644 fs/pstore/tty.c

-- 
2.39.3

