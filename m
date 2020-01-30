Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4FC14E5EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA3XId (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 18:08:33 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:42128 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgA3XId (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:33 -0500
Received: by mail-pj1-f73.google.com with SMTP id s6so3104270pjn.7
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=AfGGk98bnxyyqHcpetjQvX41oGap4DIh7+0oNSJEg2O3R1PQCiDZZtdDhFMDnBhxK0
         /1IpRPnzmNWZWCdDA+YmoH11+yZ8yuUmpOyt1a1C6USU6lfL8qgBToLhsSsLZNa22qcw
         DeN090IVkvjCCffCPn/5OAPM2nRoarPWAvvLk+KM9KuY5bXHOlv/eW4GgopiPEam5w1U
         OoY2SAfbLPxbM5Od+4uzT/fCGGx4M5wAozv3qmR20QB92nwmZRbSl5NMzEqnr0ikTRje
         jyRldGQ6k5yB9GzKUFfikjYirdZINEHE5zYwOZsqejJsbcphEn8KaagiB3vqxnjMBUIk
         K+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=nQLhBnSRtbHAiMKCwlp3LQhBAea5dR+/0WbK2zIdCIoCGW3OUNsyPCUYhRK9kQ8PCy
         66XIkE1NvbWVi1nY4Y3ZzmEM6ScIjABn3crxyfTj3qcsw4GW4f1xSWQCfQbIrnDYti0l
         jVfHTgxA9Ix7bRDeys7nOczbGDoeTkGzM8VMzAinjWj4DaFDvzdj7YrnnuX1ncDpGI5t
         G1yIuezuZ4rBXpfGRu2MJ4PJmaQrJl2UnG2WSXR67Ce8hEa2VowaVUqLx3f2Lyc88n1w
         8SwzXFHSCkduXPl7QXvFIm1bVm7J+y3yCjK/wm8hdF+FFa9xuHD3IfgzKzk8GlpC1q9V
         GYLg==
X-Gm-Message-State: APjAAAWupM9pCjqfayaUCl1UCR5D4qm66g3H17cIPShKDELZ7qHqfges
        d/h3mRxXvbVVpzRgRPEHZM9lDtPCj/PTeZ6nA+MdPg==
X-Google-Smtp-Source: APXvYqzSRoUUWeQ2bKif6Z40xm7qv0HYLPbmPInMedOryPT9s0Chn/fw7nXAk5QeONDTypQImuUErdEfZqufShGTpuizag==
X-Received: by 2002:a63:e649:: with SMTP id p9mr7159890pgj.15.1580425711922;
 Thu, 30 Jan 2020 15:08:31 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:06 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/7] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
2.25.0.341.g760bfbb309-goog

