Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1D1E3A2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgE0HRM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:17:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728611AbgE0HRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeFCFQKYr22MWNIUPQRp475JW512YZ2vYFblYXBP+94=;
        b=TmpIRbMii+GE5EeVl2TdVbsFurSYaRQviR6vti0dy3UQhGbRp2kytZFPZsoQBnrSOVwlv4
        8SEYrEYwN1zEM0Ml0o1kfaWdbmSphAEroQ5ZQX+w6qyUd4aplQ2iu3iYPlCd/hBGrXm8j+
        gTJ38myKqBHYCuNvapvnjgJ1Cre4sXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-_kTiZn9_PW6LPz8VayOF5A-1; Wed, 27 May 2020 03:17:09 -0400
X-MC-Unique: _kTiZn9_PW6LPz8VayOF5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD8618A0760;
        Wed, 27 May 2020 07:17:08 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39DDE5C1B0;
        Wed, 27 May 2020 07:17:05 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     jbenc@redhat.com, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [RESEND PATCH 3/3] selftests: simplify run_tests
Date:   Wed, 27 May 2020 10:16:59 +0300
Message-Id: <20200527071659.63426-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200527071659.63426-1-yauheni.kaliuta@redhat.com>
References: <20200527071629.63364-1-yauheni.kaliuta@redhat.com>
 <20200527071659.63426-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove redundant check for TEST_PROGS and use the same command for
in- and out-of-source builds, and

fix bug with adding $(OUTPUT)/ to first $(TEST_PROGS) element only:

1) use $(addprefix ...) function to add $(OUTPUT). In case of blank
$(TEST_PROGS) it will be expanded to blank, so no need for extra
check;

2) $(OUTPUT) is always initialized to current dir or supplied value,
so it does not make any harm to add it unconditionally.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/lib.mk | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7a17ea815736..fac4f7de37fb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -73,14 +73,9 @@ ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
-	else \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
-	fi
-else
-	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
+	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
+			   $(addprefix $(OUTPUT)/,$(TEST_PROGS)))
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-- 
2.26.2

