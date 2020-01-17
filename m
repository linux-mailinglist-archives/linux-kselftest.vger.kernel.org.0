Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A25140B45
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgAQNnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 08:43:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727011AbgAQNnE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 08:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQICz1wSrd9+unk/KTAhm5BSjsKUGLh/wx6klsQzMyE=;
        b=NqsaibTt49DomdUQs04VT6oilDM7+4gmlAcoatEA6iQjUKYbc4GsH8R1i4fOWm7EZtx7cq
        MJ6FfGek8LrCXlrX91M763R//USk46zJgbB+a8LlXJBAdxaZGe4/L8zzFh0XMqpo6vuAfF
        iMgO99jjM8rg7qgnuuaLaqwmfu2gmx0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-0K5O89b0Pi2rZ8sPhMt64A-1; Fri, 17 Jan 2020 08:43:00 -0500
X-MC-Unique: 0K5O89b0Pi2rZ8sPhMt64A-1
Received: by mail-lf1-f72.google.com with SMTP id d6so4400662lfl.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 05:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LQICz1wSrd9+unk/KTAhm5BSjsKUGLh/wx6klsQzMyE=;
        b=RfPttz0W3RZHmdDc0kKYrwJM62shwm6b14YzfWE67F4JyVJV7XNhTb5YTeeT87EJ7M
         fhc0fsG3CFvSRAgF4mW8swb//+MZZBDZyREv+9gZnAAHSBv8BS2JBqGZ7EqSdw85A0BE
         e7agD2QORYfZI9NaTXlHnRe/EwuyvAIJMsIZYLed4QL8Dr+YaVcg7t1KuAQDwVH8wY0p
         NercMmqP1lnzxDNNpS6IKCID+qfnQRX1cCAJxYLEqBD3C4NrOgNCPbYKUFJ17zIjdH2w
         xKujVKr9sjbAU51UELEMCnl5NbSp72YPQ+G7T38U8j/3HgGZvpKEdrhumY8+B15BHjWO
         WoPg==
X-Gm-Message-State: APjAAAXPDvXLF7ddJiAcC4me7wwioXIIpBRTQhGCkKd5mZcVsxHOuJUh
        5t+4ArGanVrSXs+PrBwqK+LUEByqTWyJMSM0jbrGVISftn9kZRUh53ybKl9/COqehUz+O6dtqzu
        s/3ofy5eB4jBG3ntNRNP5rvu4f7SZ
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr5577352ljn.164.1579268578673;
        Fri, 17 Jan 2020 05:42:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHAwELWdTWp8cnKfoF73NjYLMwS9bCVGuMLhOLg/d8FS+JPMoZdDFWlWeYmTFnPvP7DqNGsg==
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr5577310ljn.164.1579268578268;
        Fri, 17 Jan 2020 05:42:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s23sm12499671lji.70.2020.01.17.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:42:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DD4BF1804D6; Fri, 17 Jan 2020 14:36:46 +0100 (CET)
Subject: [PATCH bpf-next v4 09/10] selftests: Remove tools/lib/bpf from
 include path
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
Date:   Fri, 17 Jan 2020 14:36:46 +0100
Message-ID: <157926820677.1555735.5437255599683298212.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

To make sure no new files are introduced that doesn't include the bpf/
prefix in its #include, remove tools/lib/bpf from the include path
entirely.

Instead, we introduce a new header files directory under the scratch tools/
dir, and add a rule to run the 'install_headers' rule from libbpf to have a
full set of consistent libbpf headers in $(OUTPUT)/tools/include/bpf, and
then use $(OUTPUT)/tools/include as the include path for selftests.

For consistency we also make sure we put all the scratch build files from
other bpftool and libbpf into tools/build/, so everything stays within
selftests/.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/.gitignore |    2 +
 tools/testing/selftests/bpf/Makefile   |   49 +++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1d14e3ab70be..8c9eac626996 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -39,4 +39,4 @@ test_cpp
 /no_alu32
 /bpf_gcc
 /tools
-bpf_helper_defs.h
+
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 858d4e3369ad..ac0292a82fdc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -20,8 +20,8 @@ CLANG		?= clang
 LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
-CFLAGS += -g -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR) -I$(LIBDIR)  \
-	  -I$(BPFDIR) -I$(GENDIR) -I$(TOOLSINCDIR)			\
+CFLAGS += -g -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR)		 \
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR) -I$(TOOLSINCDIR)	\
 	  -Dbpf_prog_load=bpf_prog_test_load				\
 	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
@@ -97,11 +97,15 @@ OVERRIDE_TARGETS := 1
 override define CLEAN
 	$(call msg,CLEAN)
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
-	$(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/ clean
 endef
 
 include ../lib.mk
 
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+INCLUDE_BPF := $(INCLUDE_DIR)/bpf
+
 # Define simple and short `make test_progs`, `make test_sysctl`, etc targets
 # to build individual tests.
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
@@ -120,7 +124,7 @@ $(OUTPUT)/urandom_read: urandom_read.c
 	$(call msg,BINARY,,$@)
 	$(CC) -o $@ $< -Wl,--build-id
 
-$(OUTPUT)/test_stub.o: test_stub.c
+$(OUTPUT)/test_stub.o: test_stub.c $(INCLUDE_BPF)
 	$(call msg,CC,,$@)
 	$(CC) -c $(CFLAGS) -o $@ $<
 
@@ -133,7 +137,7 @@ $(OUTPUT)/runqslower: force
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
 		    OUTPUT=$(OUTPUT)/tools/ VMLINUX_BTF=$(VMLINUX_BTF)
 
-BPFOBJ := $(OUTPUT)/libbpf.a
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
 
@@ -159,17 +163,28 @@ force:
 DEFAULT_BPFTOOL := $(OUTPUT)/tools/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 
-$(DEFAULT_BPFTOOL): force
-	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			      \
+$(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(INCLUDE_DIR):
+	$(call msg,MKDIR,,$@)
+	mkdir -p $@
+
+$(DEFAULT_BPFTOOL): force | $(BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)		\
+		    OUTPUT=$(BUILD_DIR)/bpftool/			\
 		    prefix= DESTDIR=$(OUTPUT)/tools/ install
 
-$(BPFOBJ): force
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(OUTPUT)/
+$(BPFOBJ): force | $(BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) \
+		OUTPUT=$(BUILD_DIR)/libbpf/
+
+$(INCLUDE_BPF): $(BPFOBJ) | $(INCLUDE_DIR)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) install_headers \
+		OUTPUT=$(BUILD_DIR)/libbpf/ DESTDIR=$(SCRATCH_DIR) prefix=
+
+BPF_HELPERS := $(or $(wildcard $(INCLUDE_BPF)/bpf_*.h),$(INCLUDE_BPF))
+ifneq ($(BPF_HELPERS),$(INCLUDE_BPF))
+$(BPF_HELPERS): $(INCLUDE_BPF)
+endif
 
-BPF_HELPERS := $(OUTPUT)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*.h)
-$(OUTPUT)/bpf_helper_defs.h: $(BPFOBJ)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)			      \
-		    OUTPUT=$(OUTPUT)/ $(OUTPUT)/bpf_helper_defs.h
 
 # Get Clang's default includes on this system, as opposed to those seen by
 # '-target bpf'. This fixes "missing" files on some architectures/distros,
@@ -189,8 +204,8 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
-	     -I$(OUTPUT) -I$(CURDIR) -I$(CURDIR)/include/uapi		\
-	     -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR) -I$(abspath $(OUTPUT)/../usr/include)
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(CURDIR)/include/uapi	\
+	     -I$(APIDIR) -I$(abspath $(OUTPUT)/../usr/include)
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
@@ -392,7 +407,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
 	$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)					\
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature								\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc tools)
+	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc)

