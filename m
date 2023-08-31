Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668A78F151
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbjHaQaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbjHaQae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 12:30:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC912CDB;
        Thu, 31 Aug 2023 09:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78FD7B82345;
        Thu, 31 Aug 2023 16:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAF8C433C8;
        Thu, 31 Aug 2023 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693499405;
        bh=Yc26o0/FY2D6dfkAPvN4YeN+YrHn6pS0APrtvKi+iJY=;
        h=From:To:Cc:Subject:Date:From;
        b=GDhWBuBscGEAJYnkRo1z17fL4qXj3Yg/oY523IeIFbdDGS+aOE2gzrrL5vKEw2t7a
         2JPJZJQ0Ey7q4Bjd+OUgo3fTtwN0YDKNCG2crMzIHElbdJ0uHNEzzehmA+FPcXAjKr
         bzH2OBA5Zh6EV02Q4JRxlNDGArUuF+8EwCyGtGs+C8mtZN5nveKGJchpB+dUZMyWZw
         jAqvyPIlDAyUmoZOAvGIlfEx0wrDUHUpMKMpjkJ4zX6cS/V2nxS4PWcUXUSrfYTljF
         key1DDeceUlJgqrZjxK53E2mkqC3ajlvf1oHphVJCLbgJkQIMN+I3vOfI2jzwNn7BW
         5MzAOJwqMkC3g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Include build flavors for install target
Date:   Thu, 31 Aug 2023 18:29:54 +0200
Message-Id: <20230831162954.111485-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

When using the "install" or targets depending on install,
e.g. "gen_tar", the BPF machine flavors weren't included.

A command like:
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
  |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
  |    -C tools/testing/selftests gen_tar
would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.

Include the BPF machine flavors for "install" make target.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
  v1->v2: Rename the subdir variable, and define/populate it at more
  clear locations. (Daniel)
---
 tools/testing/selftests/bpf/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef49fcd23e..caede9b574cb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -50,14 +50,17 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
+TEST_INST_SUBDIRS := no_alu32
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
+TEST_INST_SUBDIRS += bpf_gcc
 endif
 
 ifneq ($(CLANG_CPUV4),)
 TEST_GEN_PROGS += test_progs-cpuv4
+TEST_INST_SUBDIRS += cpuv4
 endif
 
 TEST_GEN_FILES = test_lwt_ip_encap.bpf.o test_tc_edt.bpf.o
@@ -714,3 +717,12 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
+
+DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
+override define INSTALL_RULE
+	$(DEFAULT_INSTALL_RULE)
+	@for DIR in $(TEST_INST_SUBDIRS); do		  \
+		mkdir -p $(INSTALL_PATH)/$$DIR;   \
+		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	done
+endef

base-commit: d11ae1b16b0a57fac524cad8e277a20ec62600d1
-- 
2.39.2

