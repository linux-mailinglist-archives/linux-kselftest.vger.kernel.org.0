Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137C01E3A29
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgE0HRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:17:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728989AbgE0HRG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CddcCML9u77RP1qItK3WVdNaZvzlZ+4uDdw9FYA4Ktg=;
        b=BxGeobD34usd9FTKKjVQ+yf/pjCNeuaNP8HK+9P6SIQ4IQRQbsirCX0jfPfs6rBnpT4A6W
        FHLLEo7ntMWKOEmsnzrHgTcyt4KWWCpKOf2U6WzlB+mBilfk0iDExIXBy5SxB6qbRFjIh/
        eLK7nYfF5Ls3i2Z10mUSbHCa2S+T+MY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-BKM9Wne5OaGnz_K7qGU5bg-1; Wed, 27 May 2020 03:17:04 -0400
X-MC-Unique: BKM9Wne5OaGnz_K7qGU5bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7A818A0760;
        Wed, 27 May 2020 07:17:03 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B858E5C1B0;
        Wed, 27 May 2020 07:17:01 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     jbenc@redhat.com, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [RESEND PATCH 1/3] selftests: do not use .ONESHELL
Date:   Wed, 27 May 2020 10:16:57 +0300
Message-Id: <20200527071659.63426-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
References: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Using one shell for the whole recipe with long lists can cause

make[1]: execvp: /bin/sh: Argument list too long

with some shells. Triggered by commit 309b81f0fdc4 ("selftests/bpf:
Install generated test progs")

It requires to change the rule which rely on the one shell
behaviour (run_tests).

Simplify also INSTALL_SINGLE_RULE, remove extra echo, required to
workaround .ONESHELL.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b0556c752443..5b82433d88e3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -59,9 +59,8 @@ else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
-.ONESHELL:
 define RUN_TESTS
-	@BASE_DIR="$(selfdir)";			\
+	BASE_DIR="$(selfdir)";			\
 	. $(selfdir)/kselftest/runner.sh;	\
 	if [ "X$(summary)" != "X" ]; then       \
 		per_test_logging=1;		\
@@ -71,22 +70,21 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then
-		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
+	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then \
+		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	@if [ "X$(TEST_PROGS)" != "X" ]; then
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
-	else
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
+	@if [ "X$(TEST_PROGS)" != "X" ]; then \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
+	else \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 	fi
 else
-	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
+	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
-	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_RULE
-- 
2.26.2

