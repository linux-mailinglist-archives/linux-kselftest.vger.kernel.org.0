Return-Path: <linux-kselftest+bounces-3660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6583ED57
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 14:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D691F23545
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909C28DAB;
	Sat, 27 Jan 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC6aHYgj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B455288B6;
	Sat, 27 Jan 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362415; cv=none; b=SNOntO4GPuT3i14eT4JbyiOWDYvrjrUDfDiY+kotBKXABrzqWsLO9H/fzAKKF6JErHq3bD3jaEIsRvDWNbaz5ReYwbDZtNIvOPLVzcIQZIWWTsdV5EzbEqHrkpYNJuNhAY5p0A73Z9Jd9TB0SMBHgy1EbK6bgPQRB/mmIqtPZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362415; c=relaxed/simple;
	bh=1UkopJ/w9QgwT1rJEbONED2PCrGFE6oaWSYS0RrhFD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6UyNljn/YCoy86acTA18Q0dkGamp65HUCQ5m2/dtN4DfP6I1/OochU/X7Z4yLWYSI4oFoef+ZAwNqBpzhssprPsGgXh+3Zerac3KtMXEsmdKWccK53TTofZZl/+u8AG1TDtW34uALpoaen/g5xaXXgHYmKCSP5KNjQmnF78lDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC6aHYgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F08DC43399;
	Sat, 27 Jan 2024 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706362415;
	bh=1UkopJ/w9QgwT1rJEbONED2PCrGFE6oaWSYS0RrhFD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UC6aHYgjYifHJwEUC+83yJveRqPauqiojSB5e19zT2HtPAEtdQC+F0tck0A0B8A23
	 Nmyo9y2jFCUe7guQMKyRYfR+bHUDJWiQTj+om1sK/Ct8s68lO5snwCAvcAclfZbb0q
	 DJAEMKtflxjbl7J/qYII7PWhuYK3KSRsxkcPWTfaR8rV5orQW+tIuAPkkhk/meWGVW
	 OVLC0z0s/HgGLVxRs/0Q+/jQCkvrWqyOWSbXhxJJmwqjWXKfgee+vGf9VxKbxDz6Nv
	 o9X2F67yLdrHxYixgvCHylg9wjFQWonHcgh8Zw5d3f6kNWJC7xijxwjoOQoEa9ILjx
	 qbn3a3j3kKYuA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Make install target copy test_progs extra files
Date: Sat, 27 Jan 2024 14:33:27 +0100
Message-Id: <20240127133327.1594026-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240127133327.1594026-1-bjorn@kernel.org>
References: <20240127133327.1594026-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Currently, "make install" does not install the required test_progs
"extra files" (e.g. kernel modules, helper shell scripts, etc.) for
the BPF machine flavors (e.g. cpuv4).

Add the missing "extra files" dependencies to rsync, called from the
install target.

Unfortunately, kselftest does not use bash as the default shell, so
the globbering is limited. Blindly enabling "SHELL:=/bin/bash" for the
Makefile breaks in other places. Workaround by explicitly call
"/bin/bash" to expand the file globbing.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v3: Do not use hardcoded file names (Andrii)
v2: Added btf_dump_test_case files
---
 tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 830a34f0aa37..d66c689f0f3c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -605,14 +605,15 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 json_writer.c 		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
-		       $(OUTPUT)/liburandom_read.so			\
-		       $(OUTPUT)/xdp_synproxy				\
-		       $(OUTPUT)/sign-file				\
-		       $(OUTPUT)/uprobe_multi				\
-		       ima_setup.sh 					\
-		       verify_sig_setup.sh				\
-		       $(wildcard progs/btf_dump_test_case_*.c)
+TRUNNER_PROGS_EXTRA_FILES:= $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+			    $(OUTPUT)/liburandom_read.so			\
+			    $(OUTPUT)/xdp_synproxy				\
+			    $(OUTPUT)/sign-file					\
+			    $(OUTPUT)/uprobe_multi				\
+			    ima_setup.sh					\
+			    verify_sig_setup.sh					\
+			    $(wildcard progs/btf_dump_test_case_*.c)
+TRUNNER_EXTRA_FILES := $(TRUNNER_PROGS_EXTRA_FILES)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
@@ -740,11 +741,17 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
 
+space := $(subst ,, )
+comma := ,
+EXTRA_FILES_GLOB := {$(subst $(space),$(comma),$(notdir $(TRUNNER_PROGS_EXTRA_FILES)))}
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	@for DIR in $(TEST_INST_SUBDIRS); do		  \
-		mkdir -p $(INSTALL_PATH)/$$DIR;   \
-		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	@for DIR in $(TEST_INST_SUBDIRS); do						\
+		mkdir -p $(INSTALL_PATH)/$$DIR;						\
+		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;			\
+		rsync -a --copy-unsafe-links						\
+			$$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FILE_GLOB)")	\
+			$(INSTALL_PATH)/$$DIR;						\
 	done
 endef
-- 
2.40.1


