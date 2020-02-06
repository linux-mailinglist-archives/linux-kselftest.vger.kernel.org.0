Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4F4154077
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBFIlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 03:41:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727780AbgBFIlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 03:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580978468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sWBRIqy8LX1iIGpLYev/Jsg37sChoA1EQYV7ieqtHKk=;
        b=CIjA8FqRLkkOrWIKk2UDKB8nvhh51D2qI05uC13mkWplw2Y3NMGn87RRFabybUziaDKVTK
        SytNy3+uuS5hDwO4FpP0ILR3mVBS20tsXseJRzF8Sj+mQiQ+smtGa8/ICT5G3xQ3Izk9HY
        zsNt6boGEqilL6ucMLn0ZGsN/k/Hrkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-OTFRL9D9OhaSY2Gj5DEjWw-1; Thu, 06 Feb 2020 03:41:06 -0500
X-MC-Unique: OTFRL9D9OhaSY2Gj5DEjWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D3D8010F1;
        Thu,  6 Feb 2020 08:41:05 +0000 (UTC)
Received: from griffin.upir.cz (ovpn-204-182.brq.redhat.com [10.40.204.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F5B38F;
        Thu,  6 Feb 2020 08:41:01 +0000 (UTC)
From:   Jiri Benc <jbenc@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH] selftests: fix too long argument
Date:   Thu,  6 Feb 2020 09:40:52 +0100
Message-Id: <615569048a0ff1561962aacc947674d92d52cc9c.1580978204.git.jbenc@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With some shells, the command construed for install of bpf selftests becomes
too large due to long list of files:

make[1]: execvp: /bin/sh: Argument list too long
make[1]: *** [../lib.mk:73: install] Error 127

Currently, each of the file lists is replicated three times in the command:
in the shell 'if' condition, in the 'echo' and in the 'rsync'. Reduce that
by one instance by using make conditionals and separate the echo and rsync
into two shell commands. (One would be inclined to just remove the '@' at
the beginning of the rsync command and let 'make' echo it by itself;
unfortunately, it appears that the '@' in the front of mkdir silences output
also for the following commands.)

Also, separate handling of each of the lists to its own shell command.

The semantics of the makefile is unchanged before and after the patch. The
ability of individual test directories to override INSTALL_RULE is retained.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Tested-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 tools/testing/selftests/lib.mk | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..3ed0134a764d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -83,17 +83,20 @@ else
 	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
+define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+
 define INSTALL_RULE
-	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then					\
-		mkdir -p ${INSTALL_PATH};										\
-		echo "rsync -a $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(INSTALL_PATH)/";	\
-		rsync -a $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(INSTALL_PATH)/;		\
-	fi
-	@if [ "X$(TEST_GEN_PROGS)$(TEST_CUSTOM_PROGS)$(TEST_GEN_PROGS_EXTENDED)$(TEST_GEN_FILES)" != "X" ]; then					\
-		mkdir -p ${INSTALL_PATH};										\
-		echo "rsync -a $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(INSTALL_PATH)/";	\
-		rsync -a $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(INSTALL_PATH)/;		\
-	fi
+	$(eval INSTALL_LIST = $(TEST_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
 endef
 
 install: all
-- 
2.18.1

