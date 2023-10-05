Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B437BA4CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjJEQK5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbjJEQJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696E7D00D;
        Thu,  5 Oct 2023 08:55:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47217C433C9;
        Thu,  5 Oct 2023 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696521359;
        bh=kepJfzWT2D89KAm/FDIV534BRNofr3W/Lz1wk8g0krs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HnUuOuzjNB341ryqf37ET9waEJFD4OEbRSkt58uo71aNC1WoiXy7is9q72cbwS5Tz
         SZ50W1L08BUJ/edZCoLF4UOwRx5Zt4xWotbQFJLxP1OGqC4JarwYi55Masjfbefb9S
         GFifXWrWEAbpbck2iBnj+P8lemYql/QHhfmW+e6kbdexb7e+kIYqssod9ufTTTyYgB
         fPPQ5loVxqlSCW+B90qS4C4AloshshD19pkhMoAfXCSK8WeerCkE7xC4EIXInN5Go/
         V56k38HZ4JkB8TiRhS4DB8U7Qv2yeM1FSksk3hrmKnU/OFivm3JN/b4E9BKV+HXrgI
         9YU2jeRNrTCTw==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Thu, 05 Oct 2023 17:55:33 +0200
Subject: [PATCH v3 2/3] selftests/hid: do not manually call headers_install
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v3-2-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696521351; l=2048;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=kepJfzWT2D89KAm/FDIV534BRNofr3W/Lz1wk8g0krs=;
 b=3Bfa0moweoyJ3qG17TuFnAal4lGdBVWJl4DArxBAd0uyM+iv6oT+49A+bz0vOaTutlhSNd3ej
 5Mr7rMhGV02Dli/kpbWgaihnS3rKk5PHBj1kPouo4ijqH4KRYe3sW2N
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"make headers" is a requirement before calling make on the selftests
dir, so we should not have to manually install those headers

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Build
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2e986cbf1a46..a28054113f47 100644
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

