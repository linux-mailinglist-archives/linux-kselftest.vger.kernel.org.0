Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC17B7F09
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbjJDM1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjJDM1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:27:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666093;
        Wed,  4 Oct 2023 05:27:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0494AC433C7;
        Wed,  4 Oct 2023 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422449;
        bh=vZdeekHmX6PRJrot+PinxMvY1FiWo7fqDKl0jsBzl+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ImQPHdN5Vej8ZQgiOvsRoxKhp/zQ4Hl2xHXEjV4iyS98p1zFUHKHL50ytHlMRK484
         9hzk0/ouyrOenAmjzEdDDnUHYfH6QmpzDmo1bL4rmj8feQ7JTPlFiv8OU0V9caUc61
         IC3WjJiR2dah3NRJhNL5VcKtF0magsuCqJAVTnNZmhxEysDJC+p0Rfvb2uT2R9h1s1
         ns7MX2dQ183fjYtbfCOPvPfvlf0BA4j9YQr/LxGTtCjjYa3UicdOf3eqrUunR1dZh9
         QL5CYN/+QLMn8L1zku2UjN0HmQ/AjQeLhR9bQK0bMQArhxh3LGzK95NdheiCoQbN12
         z4jEO4wgv/U8g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 1/3] selftests/bpf: Add cross-build support for urandom_read et al
Date:   Wed,  4 Oct 2023 14:27:19 +0200
Message-Id: <20231004122721.54525-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
References: <20231004122721.54525-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some userland programs in the BPF test suite, e.g. urandom_read, is
missing cross-build support. Add cross-build support for these
programs

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 47365161b6fc..a9cbb85fa180 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -198,7 +198,7 @@ endif
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
+	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
@@ -206,7 +206,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT)  \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
-- 
2.39.2

