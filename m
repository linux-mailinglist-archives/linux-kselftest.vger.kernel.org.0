Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC6142BAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgATNHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 08:07:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728827AbgATNGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO0YZDCYDI2J/1ujIzZCIdgWpSFgOqfh62+GspZ7r0s=;
        b=I4bfVCcM8iS2yt9wgWzwkZRPDB/MB4s5uGP3tJrJwqV1cI83rvpXZcS6tsWw3XBsiG2qQb
        H/yPsqPpMOBi1B3+14POy9mxxYvcLJ8gmLOvjWqHuzRKeyWiffLt4I1Jms7RIn2h6JDkhu
        oXy56C1gUew00hAg1eCfAXdK28VIiPw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-cmNfIR0hNiiPOe8nd6yhQQ-1; Mon, 20 Jan 2020 08:06:48 -0500
X-MC-Unique: cmNfIR0hNiiPOe8nd6yhQQ-1
Received: by mail-lj1-f198.google.com with SMTP id r14so7507653ljc.18
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 05:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FO0YZDCYDI2J/1ujIzZCIdgWpSFgOqfh62+GspZ7r0s=;
        b=aiLDv8jbEE0mnBr4a9UJKr8dPsj8P2B/rUiyuqVTdX4oJ0GMMQGs1Hlg7t78W95Dcr
         yRPt6zNMXNlRf95o77Y0CRHcHOykOISa2JuLn6B84QEhdgRqQbKbA+nQTfy73MaPcRZJ
         HxifrQcXsEmO908Ojx3xOkHF+2oc7Kb62J49Y5a/PMs0vm2FxQHZi9HjZfwWdmHie6Rm
         iRkWL57Zj86G8qkvgMQja8ny0A5RUP+P3203cHgaizaLPQuU/fbgUDcaLbkPgdz4mvz3
         g6dLY5pChfjIe6/NGA97WjW7K6Co1H9xQekjEaQsHPK4XLrtem9Imtz0cdTvi/CTVc73
         pxwQ==
X-Gm-Message-State: APjAAAXvilDAMgI9+10ixhOk/+/3NvwApX0QthwSIDFBH2sH8RVrzOK8
        AJVVoISren69iWSBRi7DDqaSzgTFvZLDiw5MChcpiBN1HNjNxBEz9GoGmT8M7UK44RxgczyzN8+
        92H5i96GwH4EwRTbOFp2zI+LaEHRO
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr13288174ljj.243.1579525606543;
        Mon, 20 Jan 2020 05:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2KwgfqhZ3/kgpwvu4ucvjAcbXYeXmUKFWMhAUlmDBXohA1PpkILdg2v6ESrPD9/+UsXHfOg==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr13288163ljj.243.1579525606301;
        Mon, 20 Jan 2020 05:06:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g24sm16765412lfb.85.2020.01.20.05.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A70281804D6; Mon, 20 Jan 2020 14:06:44 +0100 (CET)
Subject: [PATCH bpf-next v5 04/11] tools/runqslower: Use consistent include
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
Date:   Mon, 20 Jan 2020 14:06:44 +0100
Message-ID: <157952560457.1683545.9913736511685743625.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile         |    5 +++--
 tools/bpf/runqslower/runqslower.bpf.c |    2 +-
 tools/bpf/runqslower/runqslower.c     |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 3242ab874ac0..b7b2230f807b 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,6 +6,7 @@ LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
@@ -51,13 +52,13 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf -I$(OUTPUT) -I$(LIBBPF_SRC)	      \
+	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
 $(OUTPUT)/%.o: %.c | $(OUTPUT)
 	$(call msg,CC,$@)
-	$(Q)$(CC) $(CFLAGS) -I$(LIBBPF_SRC) -I$(OUTPUT) -c $(filter %.c,$^) -o $@
+	$(Q)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
 
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
 

