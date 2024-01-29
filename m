Return-Path: <linux-kselftest+bounces-3682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E616783FEDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 08:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CCDB23460
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 07:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366C51C35;
	Mon, 29 Jan 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl2HRExV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEF51C30;
	Mon, 29 Jan 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512167; cv=none; b=cobYvNqCNf0C3P89tIg32jQiCqpaXdJ2dY9RGr+vm3/Kxtg8yfxFiFjAIUkI4WY+PK0HfC13/pjZuTfCjHMXL5rLlDcZope8+9sQplxes3tGECxTAdRtrhuvUPmqKRPU4tEVHcI+ya8hijhTuXTqAQ6CoyYEeOIiGvu/IQyZzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512167; c=relaxed/simple;
	bh=JtYKGXPxAZKfTh92wrNBh/LSJK6mCdpFeDczxNfiSOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST6GMOtTebDJs9C4E0JgOOpnrrXnkLYdDZGDEyu9DGQkeF5QYCGVVR9PmF7tLg6YNQuOYv1F0Gpz9w5NH7sUWG7LL42LFnQRdb5hOmsPi48SsxwyvubZ147XI5gaDizJF7G4uxv1WFoddxzPVWMqE7EOpQG+Q+KQWmAeqVd/qGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl2HRExV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60CBC433F1;
	Mon, 29 Jan 2024 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706512166;
	bh=JtYKGXPxAZKfTh92wrNBh/LSJK6mCdpFeDczxNfiSOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tl2HRExVsGzGPWAmFGvfJYH2Ip1vQANmOLZmWQcdYuogKUkJ9fLwruHzssCzwT+KQ
	 A2lfr2Q5n4knZg9maRl/mL58NPSWRrdoy1tvO/ftnUoFMO1NAb2ZOeyytE2tTPembM
	 j15b1471fWKOI/l/AsagqQ9r5IJdYsRkX+Z9uA2WJIFql5PS+TcIdaHM6TFAWMMyQf
	 7zDvwJMvMClGfhFABbHvhf0Xi84Q+Zv1gwMaNp+/zPkOIZ6WUy9hXbJAsl1AlpENsQ
	 UqPiH0EY60tHy96MJGfITW9UjqenTuEqbWr0nLiwmH3KFx362NvWbUKSi4aXpCQM/Y
	 O3pBiizlOEU8w==
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
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Make install target copy test_progs extra files
Date: Mon, 29 Jan 2024 08:09:15 +0100
Message-Id: <20240129070916.1639008-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129070916.1639008-1-bjorn@kernel.org>
References: <20240129070916.1639008-1-bjorn@kernel.org>
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
 tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 830a34f0aa37..c3c5b85f7dae 100644
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
+			$$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FILES_GLOB)")	\
+			$(INSTALL_PATH)/$$DIR;						\
 	done
 endef
-- 
2.40.1


