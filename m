Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9024D18460F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 12:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMLkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 07:40:39 -0400
Received: from sym2.noone.org ([178.63.92.236]:39912 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMLkj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 07:40:39 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 07:40:39 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48f3RY57VNzvjdW; Fri, 13 Mar 2020 12:31:05 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] tools/bpf: move linux/types.h for selftests and bpftool
Date:   Fri, 13 Mar 2020 12:31:05 +0100
Message-Id: <20200313113105.6918-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for
profiler build") added a build dependency on tools/testing/selftests/bpf
to tools/bpf/bpftool. This is suboptimal with respect to a possible
stand-alone build of bpftool.

Fix this by moving
tools/testing/selftests/bpf/include/uapi/linux/types.h to
tools/include/uapi/linux/types.h

This requires an adjustment in the include search path order for the
tests in tools/testing/selftests/bpf so that tools/include/linux/types.h
is selected when building host binaries and
tools/include/uapi/linux/types.h is selected when building bpf binaries.

Verified by compiling bpftool and the bpf selftests on x86_64 with this
change.

Fixes: fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for profiler build")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Quentin Monnet <quentin@isovalent.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/Makefile                                 | 1 -
 .../{testing/selftests/bpf => }/include/uapi/linux/types.h | 0
 tools/testing/selftests/bpf/Makefile                       | 7 ++++---
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/{testing/selftests/bpf => }/include/uapi/linux/types.h (100%)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9ca3bfbb9ac4..f584d1fdfc64 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -129,7 +129,6 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
 skeleton/profiler.bpf.o: skeleton/profiler.bpf.c $(LIBBPF)
 	$(QUIET_CLANG)$(CLANG) \
 		-I$(srctree)/tools/include/uapi/ \
-		-I$(srctree)/tools/testing/selftests/bpf/include/uapi \
 		-I$(LIBBPF_PATH) -I$(srctree)/tools/lib \
 		-g -O2 -target bpf -c $< -o $@
 
diff --git a/tools/testing/selftests/bpf/include/uapi/linux/types.h b/tools/include/uapi/linux/types.h
similarity index 100%
rename from tools/testing/selftests/bpf/include/uapi/linux/types.h
rename to tools/include/uapi/linux/types.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index da4389dde9f7..074a05efd1ca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -20,8 +20,9 @@ CLANG		?= clang
 LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
-CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR)	\
+CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) -I$(CURDIR)		\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR) -I$(TOOLSINCDIR)	\
+	  -I$(APIDIR)							\
 	  -Dbpf_prog_load=bpf_prog_test_load				\
 	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
@@ -194,8 +195,8 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
-	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(CURDIR)/include/uapi	\
-	     -I$(APIDIR) -I$(abspath $(OUTPUT)/../usr/include)
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
+	     -I$(abspath $(OUTPUT)/../usr/include)
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
-- 
2.24.0

