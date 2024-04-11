Return-Path: <linux-kselftest+bounces-7721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AD8A1F12
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5511D1C229C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7ED205E1C;
	Thu, 11 Apr 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZGYLFH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654017584;
	Thu, 11 Apr 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862339; cv=none; b=lqk3AZWdeGQN+1FoU30WSf7t1nrLvkQbrW6hrbMR9Evzpp49Oa+s6pwql6TLUgYfzjTnqPUSjOF+/GisYTa68sekhdv2+xd8MNLMfn1XJAcrnJhcwUPC/KWHPQRMdKD7KyUpA/cKBJZIpKZ8AbAaUONyskD7/CRqN+o4P3lYl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862339; c=relaxed/simple;
	bh=fVQl7RCtOg4AqxawSMWY3ZrEfOU3fHC6NAhZRb8dlLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUoeeICm9F2NjXIgg1Omc66z7JIezMwzyGSSAwBtu+9cF5CBjWcX7iEN8HM2ojrWNQ9txk2r/pUCRsj4Si8SA5hT0A3uYH9RsUZxCqKYtLDoLJ03BCkn4GnywxvlhkztKOXuVeBsEjS+B9hYMLb9euDVboQH/Hj5I/jcKl2cJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZGYLFH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C7C072AA;
	Thu, 11 Apr 2024 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862339;
	bh=fVQl7RCtOg4AqxawSMWY3ZrEfOU3fHC6NAhZRb8dlLE=;
	h=From:To:Cc:Subject:Date:From;
	b=tZGYLFH3+un2LnOtwMq36Ug9++Qbs4WH4Ak+di9V71wmQ+EhwQ5Oc5Sj+J1HMaLov
	 w0dbyIkhAviXl/Wt6Mxt/ncH/KVQ0+le/8rBGPxebqqPccS5jXmf46vECERs4bH4Fa
	 cW+v6QjAbDY8IOGmBr93wEmfzCFTyP51vR/sy+mgqHLItnULvFfBddE44mI0KGCFzg
	 ROUH6xrANvOXSqjl7puANuoKS8ZdraEuUf9QAzEu8m+jHzBpjPQpetLvvGNBZUA0aL
	 U4OBHorixX4pykuMG6tQJrJWW5+E7tXslyN0t9VKJB2aPvVWFXne/EgP6fk5dsQ2Q/
	 Y4Z1NzEd0V2cg==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: adopt BPF's approach to quieter builds
Date: Thu, 11 Apr 2024 12:05:34 -0700
Message-ID: <20240411190534.444918-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selftest build is fairly noisy, it's easy to miss warnings.
It's standard practice to add alternative messages in
the Makefile. I was grepping for existing solutions,
and found that bpf already has the right knobs.

Move them to lib.mk and adopt in net.
Convert the basic rules in lib.mk.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
If this is okay with everyone, can we possibly apply it to net-next?

CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@google.com
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: mykolal@fb.com
CC: shuah@kernel.org
CC: nathan@kernel.org
CC: ndesaulniers@google.com
CC: morbo@google.com
CC: justinstitt@google.com
CC: bpf@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
CC: llvm@lists.linux.dev
---
 tools/testing/selftests/bpf/Makefile | 13 +------------
 tools/testing/selftests/lib.mk       | 17 ++++++++++++++++-
 tools/testing/selftests/net/Makefile |  9 ++++++---
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b0be07f29dde..f06c527eee34 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -135,18 +135,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
-# Emit succinct information message describing current building step
-# $1 - generic step name (e.g., CC, LINK, etc);
-# $2 - optional "flavor" specifier; if provided, will be emitted as [flavor];
-# $3 - target (assumed to be file); only file name will be emitted;
-# $4 - optional extra arg, emitted as-is, if provided.
-ifeq ($(V),1)
-Q =
-msg =
-else
-Q = @
-msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
-MAKEFLAGS += --no-print-directory
+ifneq ($(V),1)
 submake_extras := feature_display=0
 endif
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index da2cade3bab0..aeeac5f83492 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -44,6 +44,20 @@ endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
+# msg: emit succinct information message describing current building step
+# $1 - generic step name (e.g., CC, LINK, etc);
+# $2 - optional "flavor" specifier; if provided, will be emitted as [flavor];
+# $3 - target (assumed to be file); only file name will be emitted;
+# $4 - optional extra arg, emitted as-is, if provided.
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+MAKEFLAGS += --no-print-directory
+endif
+
 ifeq ($(KHDR_INCLUDES),)
 KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
@@ -176,7 +190,8 @@ endif
 ifeq ($(OVERRIDE_TARGETS),)
 LOCAL_HDRS += $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
 $(OUTPUT)/%:%.c $(LOCAL_HDRS)
-	$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
+	$(call msg,CC,,$@)
+	$(Q)$(LINK.c) $(filter-out $(LOCAL_HDRS),$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
 	$(COMPILE.S) $^ -o $@
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a3c781cb8367..7e7f243d0ab2 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -125,7 +125,8 @@ BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 
 MAKE_DIRS := $(BUILD_DIR)/libbpf
 $(MAKE_DIRS):
-	mkdir -p $@
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
 
 # Get Clang's default includes on this system, as opposed to those seen by
 # '--target=bpf'. This fixes "missing" files on some architectures/distros,
@@ -149,13 +150,15 @@ BPF_PROG_OBJS := $(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o \
 	$(OUTPUT)/sample_map_ret0.bpf.o $(OUTPUT)/sample_ret0.bpf.o
 
 $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
-	$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
+	$(call msg,BPF_PROG,,$@)
+	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
 	-c $< -o $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
-	$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/     \
+	$(call msg,MAKE,,$@)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
-- 
2.44.0


