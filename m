Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6660B13DB8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 14:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgAPNXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 08:23:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727032AbgAPNWY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dddkGyog6/ukNzxfITycfkaFpImnWg5YZpf57HIco9g=;
        b=eOXjQ215/8ydyfxvTnuzLQJLfhHjCHMWLO4PmwicOf340Pi91foFiJm7P2Y4N8/s9IMjaX
        ck9x+2dPQZSzwZmWhLwRDfBQZSofNYhV4dwDHkYgFUS23v5okeLAd1RYa/hq2+KYgwqiZG
        teoe+tuXCzC2HnS+PsrwJwJbwdaG66A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-2EKAn78jONebM1xbaKqI7A-1; Thu, 16 Jan 2020 08:22:20 -0500
X-MC-Unique: 2EKAn78jONebM1xbaKqI7A-1
Received: by mail-lj1-f199.google.com with SMTP id 126so5147108ljj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 05:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dddkGyog6/ukNzxfITycfkaFpImnWg5YZpf57HIco9g=;
        b=mOOjT0bsIq+No28aacz2fmSURQyR0BjY2x8LDlvthXL18301zLIQ7+N1VJn16l5AGE
         XLWnDLI6aKFC+YA3xQCZAlX+Fy5Gi/hVeckNIYLJ4OqBVGW6HL0WnvqqrCEKj8+p+UeZ
         co/GlAc6qkAZWZHWlLESEyGxXUvOab1LLHz7JlRoKqzuFXQWy8KZo1mHLf7YKYgq3ZyB
         Y+AebKw+VqTCjO2TVHr0vuO0ZK7R2nOdeAgpPASzccFYmHYRQ0vzCy983Kfy/ogCI45C
         whZAvz8f+uWutUfpRSquLOKyfAfu2ZmCAm4Y8tfR48vudsWydsRpGaIpXbd9iW4ym+Cz
         ktiw==
X-Gm-Message-State: APjAAAWxldJ7cRWKw5j2SXTNx/lhAmxcxTNgGJ+nZh+sduyGkf+iYyKZ
        3QYgqhnFPhmpc/gRRjyVebJWO2BIoxgHaapDDW/w0KmefchkCEO3lbNV/W/c7zrbtNoE2wBxEkT
        a7lHcv7fguNsx40Mn04sOHJ6kspeH
X-Received: by 2002:a19:3f51:: with SMTP id m78mr2377246lfa.70.1579180938888;
        Thu, 16 Jan 2020 05:22:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHM8ojNS2+z7RRp2C22+OxchWf4eKxJheokOyRKS33/7g/+IOIFCtNATZQpBdA7df3Cna3AQ==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr2377225lfa.70.1579180938699;
        Thu, 16 Jan 2020 05:22:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 140sm10713621lfk.78.2020.01.16.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39AED1804D7; Thu, 16 Jan 2020 14:22:16 +0100 (CET)
Subject: [PATCH bpf-next v3 04/11] tools/runqslower: Use consistent include
 paths for libbpf
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 16 Jan 2020 14:22:16 +0100
Message-ID: <157918093613.1357254.10230277763921623892.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Fix the runqslower tool to include libbpf header files with the bpf/
prefix, to be consistent with external users of the library. Also ensure
that all includes of exported libbpf header files (those that are exported
on 'make install' of the library) use bracketed includes instead of quoted.

To not break the build, keep the old include path until everything has been
changed to the new one; a subsequent patch will remove that.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile         |    5 +++--
 tools/bpf/runqslower/runqslower.bpf.c |    2 +-
 tools/bpf/runqslower/runqslower.c     |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 89fb7cd30f1a..c0512b830805 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -5,6 +5,7 @@ LLC := llc
 LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
+LIBBPF_INCLUDE := -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 
@@ -57,13 +58,13 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) -I$(LIBBPF_SRC)	      \
+	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) $(LIBBPF_INCLUDE)	      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(call msg,CC,$@)
-	$(Q)$(CC) $(CFLAGS) -I$(LIBBPF_SRC) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LIBBPF_INCLUDE) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
 
 $(OUTPUT):
 	$(call msg,MKDIR,$@)
diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 623cce4d37f5..48a39f72fadf 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include "vmlinux.h"
-#include <bpf_helpers.h>
+#include <bpf/bpf_helpers.h>
 #include "runqslower.h"
 
 #define TASK_RUNNING 0
diff --git a/tools/bpf/runqslower/runqslower.c b/tools/bpf/runqslower/runqslower.c
index 996f0e2c560e..d89715844952 100644
--- a/tools/bpf/runqslower/runqslower.c
+++ b/tools/bpf/runqslower/runqslower.c
@@ -6,8 +6,8 @@
 #include <string.h>
 #include <sys/resource.h>
 #include <time.h>
-#include <libbpf.h>
-#include <bpf.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
 #include "runqslower.h"
 #include "runqslower.skel.h"
 

