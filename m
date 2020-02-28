Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC658172E27
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 02:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgB1BU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 20:20:59 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35328 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgB1BU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 20:20:59 -0500
Received: by mail-pl1-f202.google.com with SMTP id v24so741466plo.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 17:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gfPIObcjKoc/X97Hku0RqtasQR2kVC34gv6DKj0xOtc=;
        b=VXCVjRFV1YqUz/8wn7l00lvSHg2xQqUpVRtpFdlra5OC8OF0q0/3b0I8oE3nzS0B4c
         tupmvt08U9uuorUzoZ1eYDtNg1U63jqDJ0ibGa1taWf7raFaAzoV4BPv3Tg2m4KnmZov
         V6tpQRa0TMh7UERsCUCTWUWO8SYLoaBeDSCw/OQ+60WXxiMfaBmIcZRNfSDrrnjURMK6
         m5775Jw2akrEorxQ6H656cKfbZOHEhm9xqa5dDLNBIKMPYG/okbS3dxAbLcir1Asizeo
         EmLpGy2DdoKfflEyZLFp6qL14aA0ICqAugWB/JNN5PCwqLQlbpj/EvCmMHCfEdUzY9iN
         cWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gfPIObcjKoc/X97Hku0RqtasQR2kVC34gv6DKj0xOtc=;
        b=VFOk2FdDNrPYSoQIpCpBMhr3vHxPj0T6bryudx03/yhvt8J9Kaw8AD7dqiX2He+hMB
         dYanatFOoLATQ35BqY13BVTn3/lxCoaQopcP7HBJxo73LkVKatu2zftrvQGx7HmYh1Je
         i8mt5nguRFuyvD0V6AjuUNu2k+DDctK/7/HQc29vGMtlQlEW/UxPsLZ1q0k3oE0G2Nvu
         zB18BzwAVhnIWhENRF2miuqog8Lb1+qq3HT1t6h/pvbW88yijUdihMERxG9GXYGuYzxd
         tinsCUZD4YlnTe//53S6eEULrkoHrdFhBuzldkEeSH5LzR02nblXpYo6oyojoc1dJ7Xr
         nEiQ==
X-Gm-Message-State: APjAAAVy1xXqI3j67vACmOv7g4VRcRFmObhhFTOmxn5xUgyTEs6ooSGZ
        GcaZ0BRHOisB6PnVc6bW85Y9ekps/3IZLBAcuzpAMA==
X-Google-Smtp-Source: APXvYqypNGxK7wTo1FTf1mIFjhr0aXSAgo4WiptbW+IYOxodMeIGcqOB36P6zCIg73RrYOnWUywb6RzPCsqA6rNjpwfVnA==
X-Received: by 2002:a63:7f17:: with SMTP id a23mr2129453pgd.47.1582852857820;
 Thu, 27 Feb 2020 17:20:57 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:30 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a linker section where KUnit can put references to its test suites.
This patch is the first step in transitioning to dispatching all KUnit
tests from a centralized executor rather than having each as its own
separate late_initcall.

Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4f..99a866f49cb3d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -856,6 +856,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TEST_SUITES						\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
@@ -1024,6 +1031,7 @@
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		KUNIT_TEST_SUITES					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
-- 
2.25.1.481.gfbce0eb801-goog

