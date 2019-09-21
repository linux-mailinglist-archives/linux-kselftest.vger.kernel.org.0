Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349ECB9B97
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2019 02:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407377AbfIUAVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 20:21:02 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47821 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436995AbfIUATW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:22 -0400
Received: by mail-qk1-f201.google.com with SMTP id y189so10206559qkb.14
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
        b=Sgz7213+qbN86RpnjYxwE7eAvRTa0YN6r1fXC9nQwi+bQLfmJ0RS4WpN0N81z/odi6
         XGU7gCUSbBUdgle5NaqiHXybHGODmoKDWh/0HAkn64T1Co7SCCYmXUpCIrrnRh6Jb2Ll
         XjhlpTMqtnLolZQwP4aDBcCgL59XhMxAa5lJCd2J1Bs9Ujfs0mesiC80xjKZ798sbyV+
         vVOclVVTpXfND0vcjZ+oQRPMBJniMNy5trFLGfHLvvfXmpzxMSeWVg1bhaD800YWS3Zv
         cO7oaTS4ubnNeNZIACnRD79K40w8Hjvmr0YhQlHzIcQKEkRRSV52zVfDjQ/PSTjPN9NX
         xkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
        b=MyCtR1KoaF9Dpdi5NNDixX4WLet1PHRLhx73MZAOfZYe0Sn8svmaKM7lK6WXs/6fOT
         5PkRLqw67JAWIsqBRR2sXI+qzB+ZbKYGe0Es2IlVHo4zhWOpScfjCHMDzs8GPbngjHG6
         o/o7x/S8XgabtrjVc5LF74SdHFNMiim4gnhvl3YzYcYBPSwR+C0DflT+3Y9g5OB56bjs
         KBIfVzydWLX7ijotVzP5M/0gF0hUTz+hR4f7Y6kpf3K+5SUcrwxpp1T3HkflP45lvbw/
         D+nN0Khuk0GqYP+4UcxFDWsu1Bii9SLpAPA9nSBD+GcltaPG9o+snl5M7CWtSZsFEVZg
         UZcg==
X-Gm-Message-State: APjAAAXN02UYuYzR1uERN+AtVgouksfNR6qj2bUw4FchGm+w83LVSIqT
        /J+Y3834e+LEz/JDuThyLdi45lCsmqTHTTzV0DDVsw==
X-Google-Smtp-Source: APXvYqyhYc2gzw2zw7hNHJ45JP5rJlx8noEcdat85g5q14wTmwmkyJ6JmxX9AzFR4w2ah2LgF306gHYAybhUcuUrVrOySQ==
X-Received: by 2002:a0c:9792:: with SMTP id l18mr12691255qvd.79.1569025161226;
 Fri, 20 Sep 2019 17:19:21 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:42 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 06/19] lib: enable building KUnit in lib/
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the lib Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 2 ++
 lib/Makefile      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..1c69640e712f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1681,6 +1681,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "lib/kunit/Kconfig"
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..67e79d3724ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
+obj-$(CONFIG_KUNIT) += kunit/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
-- 
2.23.0.351.gc4317032e6-goog

