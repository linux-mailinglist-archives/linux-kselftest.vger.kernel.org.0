Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A322745958A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhKVT1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Nov 2021 14:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhKVT1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Nov 2021 14:27:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38994C06175B
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso512221wmh.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Nov 2021 11:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20odS1sGlZOVOTVJ+h0ATXc3IjCp4ghIzYe7OtypAl4=;
        b=Tn1lU0bD88IO+9yCRA6my8Iwn8DdSi2yjmwKm6kCVat9P4MZbf8fk8q1VWneE0TQMr
         xnQSOZ+OGzgQUnaQRhJrBVw8vuNdWTbTKFLwx/nlO5xCaGq/zFUzcaPK9h51bWJxQ3ik
         Per+P/IB5wRUmmxGrykwQfiRNOBPXSvqCf2mp0Pg+peiE5PtpEZCvU3IzL9SXBgoDSJT
         9MjphdkIt/a4BQLYOUr3f4akQA/F2Zlwj5jXh+48xjNpBUj3LphtLWGQY7+K7piMHFmt
         nk95BeGVt1G9J6C34OPzChTKQfutYPiyse4sOcDVW+7TmgMR8d6h5nhk55JdaisCqkwi
         pgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20odS1sGlZOVOTVJ+h0ATXc3IjCp4ghIzYe7OtypAl4=;
        b=wiL+asekPOlwJBUEi/+V7sc84x2aSuROWIIzt9SMgcpEj5XBkbPks+3CvxtRM6l0Rv
         hxu3gMr5SrshAefZmblA8FRRYUdfPk8Sj8WemCg8cUACSjfjZVI8WDL6i8S2VrsT6CwW
         ezxu9kN6I+e6Q/jSax66hzud1FCHREXkcE/2eshniGHkELqcQelkCCSLewxDaVydW7uN
         bkZlOXzZsFdRlq6+WW2EN0+LBE0v4KJN0zlTOcLdrXOonkZi8RWpZu9mp4QcpDRmtTwU
         2nYLne+ahLoWFL/NJCXGFppU1xTHat+AyL+N6D/QNHWw5CRyyVfEwL3q0XlUfpBmOsQX
         u01w==
X-Gm-Message-State: AOAM532wugjgTyzCx209OsRhVH/O7SUUcY/Rr1rMH1BvRsL3UFPT/3Pr
        llZN+TQe9VPlZvrGQYafsQMofA==
X-Google-Smtp-Source: ABdhPJwO+fR7TuysSgJw95qlWY88C/MS5DSdhnBIyjOi33oxzKHfxJ2yjFeNCmhCvb1o8azdpWmQhw==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr33464993wmb.131.1637609030871;
        Mon, 22 Nov 2021 11:23:50 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id b188sm9916150wmd.45.2021.11.22.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:23:50 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 5/6] tools/runqslower: Enable cross-building with clang
Date:   Mon, 22 Nov 2021 19:20:19 +0000
Message-Id: <20211122192019.1277299-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122192019.1277299-1-jean-philippe@linaro.org>
References: <20211122192019.1277299-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cross-building using clang requires passing the "-target" flag rather
than using the CROSS_COMPILE prefix. Makefile.include transforms
CROSS_COMPILE into CLANG_CROSS_FLAGS. Add them to CFLAGS, and erase
CROSS_COMPILE for the bpftool build, since it needs to be executed on
the host.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8791d0e2762b..da6de16a3dfb 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -12,7 +12,7 @@ BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
 BPF_DESTDIR := $(BPFOBJ_OUTPUT)
 BPF_INCLUDE := $(BPF_DESTDIR)/include
 INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
-CFLAGS := -g -Wall
+CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
@@ -88,4 +88,4 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OU
 
 $(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
-		    CC=$(HOSTCC) LD=$(HOSTLD)
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)
-- 
2.33.1

