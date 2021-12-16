Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF64779A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 17:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhLPQuu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhLPQut (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 11:50:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED1C06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so45299789wrd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 08:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSj7odpkITXsYB6KPKrMVfI/4wK2fmXegdumHZrochE=;
        b=dFx0Hwhzmk2igT16BZ1rlhq6dmsS0U34aPp3se+PKa/ZzjcDBS4H2B6kjCKxkKkUnm
         o6bbpnrimMR8LF6ECf0WtkhDh2EwsMnPD6NRoVWZ3Tp4DtDLktxL0iVIpTPJq2V9Qwv6
         EDxc97Zgs3TzNCmdnVAg6l87mbVeDbDElCjbimhMjpYcC+UqtEaWuZuyaDlBvmrhV5H0
         LRsmVCx6Se20pdD0St80++FeXjiaE5H5VQbQWFA1Q/Letg6FRFrHEiDgCnA3MCGh4ySD
         9Lz7jsukzN4m0l8WSFRE3c+xHkqiPX22/GW9xWqMudL/aDViMXN4MXRY7GYpluZ56GZy
         ZNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSj7odpkITXsYB6KPKrMVfI/4wK2fmXegdumHZrochE=;
        b=Rd5tGPxt1+KtuTPdelez2DTB5E8eyvEziHxr/0q6rW/tICOlemY/jPD/q9iQn0K8T4
         4NA0w5pZoagaoFPjIwIp5U7POSEqbLLh7iY6grYzelVAUxS+d2xltxJUtZkQpoiSkO+h
         Q5m7moewNxr/HH+lXEQ2c343dyWSHxDQOxN6eYFKqzYnBSgp/KfXNRadzivoCs3JaLbM
         ZtriRAHzji82nujDJ4c4YU6qZDLbTDUHgk1O73olW5KohJx1Ws05ZEmy1trA4+4ENMU+
         w2HIFXv4181QFBTGBINJVHV/oXpNTkAVKe8dxJV/uK5c+e2mHUh+RJOfhpcdgdFr2ZKg
         v9rQ==
X-Gm-Message-State: AOAM53126KLZxFS3ZMF9VM0MPXw+LRr0Qs3oZMSu6XFQR4nNwsyBF2aY
        weJpy+Maro9RPwO0BYU0+Tvk0Q==
X-Google-Smtp-Source: ABdhPJx+P9oqyIfuP9A1UsCS0C6AIk2H9RaJ+5KI1+5kFgW3KWUsbTT45+vSVithjhZ/h43RdNIdIQ==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr2043375wrq.294.1639673447321;
        Thu, 16 Dec 2021 08:50:47 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id y15sm7438906wry.72.2021.12.16.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:50:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 1/6] tools: Help cross-building with clang
Date:   Thu, 16 Dec 2021 16:38:38 +0000
Message-Id: <20211216163842.829836-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163842.829836-1-jean-philippe@linaro.org>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cross-compilation with clang uses the -target parameter rather than a
toolchain prefix. Just like the kernel Makefile, add that parameter to
CFLAGS when CROSS_COMPILE is set.

Unlike the kernel Makefile, we use the --sysroot and --gcc-toolchain
options because unlike the kernel, tools require standard libraries.
Commit c91d4e47e10e ("Makefile: Remove '--gcc-toolchain' flag") provides
some background about --gcc-toolchain. Normally clang finds on its own
the additional utilities and libraries that it needs (for example GNU ld
or glibc). On some systems however, this autodetection doesn't work.
There, our only recourse is asking GCC directly, and pass the result to
--sysroot and --gcc-toolchain. Of course that only works when a cross
GCC is available.

Autodetection worked fine on Debian, but to use the aarch64-linux-gnu
toolchain from Archlinux I needed both --sysroot (for crt1.o) and
--gcc-toolchain (for crtbegin.o, -lgcc). The --prefix parameter wasn't
needed there, but it might be useful on other distributions.

Use the CLANG_CROSS_FLAGS variable instead of CLANG_FLAGS because it
allows tools such as bpftool, that need to build both host and target
binaries, to easily filter out the cross-build flags from CFLAGS.

Acked-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Most tools I looked at needed additional changes to support cross-build
with clang. I've only done the work for bpf tools.
---
 tools/scripts/Makefile.include | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 071312f5eb92..b0be5f40a3f1 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -87,7 +87,18 @@ LLVM_STRIP	?= llvm-strip
 
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
-endif
+
+else ifneq ($(CROSS_COMPILE),)
+CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
+ifneq ($(GCC_TOOLCHAIN_DIR),)
+CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
+CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
+CLANG_CROSS_FLAGS += --gcc-toolchain=$(realpath $(GCC_TOOLCHAIN_DIR)/..)
+endif # GCC_TOOLCHAIN_DIR
+CFLAGS += $(CLANG_CROSS_FLAGS)
+AFLAGS += $(CLANG_CROSS_FLAGS)
+endif # CROSS_COMPILE
 
 # Hack to avoid type-punned warnings on old systems such as RHEL5:
 # We should be changing CFLAGS and checking gcc version, but this
-- 
2.34.1

