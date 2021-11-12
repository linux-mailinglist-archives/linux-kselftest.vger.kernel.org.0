Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3990044EADD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhKLP5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 10:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhKLP5B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 10:57:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F9C061767
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 07:54:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so16244505wru.13
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igm+0+5poNziS6uAO2H2/htIK5ZCHNv+uYoZuOKx4u0=;
        b=CcDre2eMGkYFUCPDNJXz31zAK7/5euuoUskgO8J9gp++N6vcZtxs6n/H/88/4lT3uD
         mHSyk64Y4g7+TmHu1UxGcsZJdGptEUNrsqd5zguyE/7SQ46zFPOwgI8dE9XDOdigBrDS
         CieJNf5XEi/2yGsOzs6Vfs11j73zGGqAmFDauaXmO103AWfhIEqDM/Ve4egZ+IdDgNmM
         Q3qbrOxpmlALW/dg1Ic4TUDaqtiRz5hpmzgZJAgCqneuTYNT9RnVr7RhSOh2ImFRWAfF
         NxHjOs9Ne4kDjHDqbETmL2QcfIflRoNMexCrrFZ6P3xs08p0XZws83a3F1Ciz0wvsb9F
         IESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igm+0+5poNziS6uAO2H2/htIK5ZCHNv+uYoZuOKx4u0=;
        b=31GBPBEkMtJ6g55zD5J0wraeE0LGGse0V1hpu9Z6jVMzw/tlSlDcPEaZiT1xKUpvhp
         Kf+6bmSz7fJQR07Cs2gnQh+v5Yk0rZMWSn4w7dgTTCovCSMbglZTlkad5BtgjPkl3lSc
         2fuyT4I0EZAMWBaY7sRKq2rfCQQqMcrRdBRzMRqfqxPtx7BkXt7pev+KNlNzSEJQy8t0
         mMMnMQ9B5RwHcl9XZY6PkbOB2jX7XSF0ZHcqIAxqf3WSuvib7BKUaP+bVDnrq7vqAyPj
         0zLwWP1dbwNREYSevoixdgRLVhHT6JsTHNJ00CiWx4D+9/yCbTzSRaMwR72yF9yLOUo1
         /mJQ==
X-Gm-Message-State: AOAM532hF9HtMIaOnuUC4L7d/mZOU8VAZaDqe0NRM9NIwlo6hUzvwk7O
        HWbFV5drQVR2fex0QWOqv50dCw==
X-Google-Smtp-Source: ABdhPJyy6Blad1EDh0YGFcFXRAZb2CNeCmvSDp9v4FkQcflWgbivs85sp+hkL6NoMoTOsMd+wMZiOQ==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr20014339wrt.131.1636732449538;
        Fri, 12 Nov 2021 07:54:09 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id h13sm6107860wrx.82.2021.11.12.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:54:09 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf] tools/runqslower: Fix cross-build
Date:   Fri, 12 Nov 2021 15:51:30 +0000
Message-Id: <20211112155128.565680-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
building") uses the target libbpf to build the host bpftool, which
doesn't work when cross-building:

  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
  ...
    LINK    /tmp/runqslower/bpftool/bpftool
  /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
  /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
  collect2: error: ld returned 1 exit status

When cross-building, the target architecture differs from the host. The
bpftool used for building runqslower is executed on the host, and thus
must use a different libbpf than that used for runqslower itself.
Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
build makes its own library if necessary.

In the selftests, pass the host bpftool, already a prerequisite for the
runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
the bpftool that's already built for selftests instead of making a new
one.

Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile        | 3 +--
 tools/testing/selftests/bpf/Makefile | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index bbd1150578f7..8791d0e2762b 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -88,5 +88,4 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OU
 
 $(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
-		    LIBBPF_OUTPUT=$(BPFOBJ_OUTPUT)			       \
-		    LIBBPF_DESTDIR=$(BPF_DESTDIR) CC=$(HOSTCC) LD=$(HOSTLD)
+		    CC=$(HOSTCC) LD=$(HOSTLD)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 54b0a41a3775..62fafbeb4672 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -187,7 +187,7 @@ DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
 		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
-		    BPFTOOL_OUTPUT=$(BUILD_DIR)/bpftool/		       \
+		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR) &&	       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
-- 
2.33.1

