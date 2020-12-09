Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F502D48D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgLISVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 13:21:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:3636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730119AbgLISVF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 13:21:05 -0500
IronPort-SDR: UkssI8FhQig3q0mH3IUitGWvyZS8QFtu9bTnrpeJ7edrRoDSJKAJOr0dTV5tuj/rGKZV6kfUoa
 z28s0KRzV9bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161174681"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161174681"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 10:19:18 -0800
IronPort-SDR: NNGiuJ7nu92JG+1s67+Qy/A083oWLTpQMCFqFUNpzZPlEsH/F9akP75R7WgK+gtJRAM22g59/F
 g1v/e2sgXh1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="376456131"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2020 10:19:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E93E1C8; Wed,  9 Dec 2020 20:19:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] um: Increase stack frame size threshold for signal.c
Date:   Wed,  9 Dec 2020 20:19:15 +0200
Message-Id: <20201209181915.39147-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The signal.c can't use heap for bit data located on stack. However,
by default a compiler warns us about overstepping stack frame size
threshold:

arch/um/os-Linux/signal.c: In function ‘sig_handler_common’:
arch/um/os-Linux/signal.c:51:1: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]
   51 | }
      | ^
arch/um/os-Linux/signal.c: In function ‘timer_real_alarm_handler’:
arch/um/os-Linux/signal.c:95:1: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    95 | }
       | ^

Due to above increase stack frame size threshold explicitly for signal.c
to avoid unnecessary warning.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/um/os-Linux/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..77ac50baa3f8 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -10,6 +10,8 @@ obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
+CFLAGS_signal.o += -Wframe-larger-than=4096
+
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
-- 
2.29.2

