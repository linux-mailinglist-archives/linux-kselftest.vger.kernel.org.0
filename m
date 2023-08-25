Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8478823B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbjHYIhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbjHYIgr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C6019AC;
        Fri, 25 Aug 2023 01:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230A365A22;
        Fri, 25 Aug 2023 08:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E58CC433C7;
        Fri, 25 Aug 2023 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692952604;
        bh=SoOIZhPy+BH1lhh+PkibmCi/a28e+9FwfvE7RWdGdTc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=l8zFt9TnpPicBKDMUvdOLhXOmD0jypML3YAdrq07kg9QizPhjHluajOQkrOCuj9jg
         8a8xpdCd+ywjdbeVd8bu5PLwcRLwypSQ3IhZ2wsgwlaBnSoT/xadaXFoXZJfBlxxbi
         OkEeTAAp5uw+xKuqWYmvNnfJm/RUlr/wC49kcl1kKc1cmv/OJx58+Z08Cq+OpoYdAd
         fHHCB2elSPTEf9YKOXbVV2Ouic9MUfF3XK5Ktyxh75rTJl2UrUiDN8PKZrJD3o5UkF
         dImrZjg8bCp2P8MlX54lOUvF/MjTU6TYsMpNQ1oVCaiYGLnYq3af36hn++tq6vZawL
         VC6dDlqTRx1Dg==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Fri, 25 Aug 2023 10:36:32 +0200
Subject: [PATCH 2/3] selftests/hid: do not manually call headers_install
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-2-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=1935;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SoOIZhPy+BH1lhh+PkibmCi/a28e+9FwfvE7RWdGdTc=;
 b=R9Znvk2sGB/OjwoSxK6aPdlfboNJEpepCTlCc1wBNAygDf9Fbz1fE3Gv4qJ5OQpVYiwWg35tY
 WeEjnIWm+7sAYt+lui27uQf+gzDSerrE+pvsqGmnHb3ypUwo/+3XkCU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"make headers" is a requirement before calling make on the selftests
dir, so we should not have to manually install those headers

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 01c0491d64da..c5522088ece4 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
 
-CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(KHDR_INCLUDES) -I$(OUTPUT)
+CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
@@ -65,7 +65,6 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
-KHDR_INCLUDES := $(SCRATCH_DIR)/uapi/include
 BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 ifneq ($(CROSS_COMPILE),)
 HOST_BUILD_DIR		:= $(BUILD_DIR)/host
@@ -151,9 +150,6 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(KHDR_INCLUDES)/linux/hid.h: $(top_srcdir)/include/uapi/linux/hid.h
-	$(MAKE) -C $(top_srcdir) INSTALL_HDR_PATH=$(SCRATCH_DIR)/uapi headers_install
-
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
@@ -231,7 +227,7 @@ $(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
 	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
 	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
 
-$(OUTPUT)/%.o: %.c $(BPF_SKELS) $(KHDR_INCLUDES)/linux/hid.h
+$(OUTPUT)/%.o: %.c $(BPF_SKELS)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 

-- 
2.39.1

