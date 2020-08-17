Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16884246918
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgHQPKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Aug 2020 11:10:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729027AbgHQPKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Aug 2020 11:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597677006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRWJ1nQYsV7RoG6nBcpAZuurEW6lvg6E/asnUf9HO/8=;
        b=B9oyrt1loH0PF0nnfRoDjpEJ1OQYtAk0mJfgpkOyE4W2lBXbJo0niuePLWEPpz4EbjVWCF
        k5yu6l7ZwNibPMXGxNntUXwR10v3p32QYp/uYAERG8Vk6s5Pl1iHsSex9AnyXWoIPIvGGx
        ftGFfCPJe2Q0KFbav4PvtefNjoUHmDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-3tT6yaTqMguYghbjU2C1Zw-1; Mon, 17 Aug 2020 11:10:04 -0400
X-MC-Unique: 3tT6yaTqMguYghbjU2C1Zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FC4427C0;
        Mon, 17 Aug 2020 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87F757A3B7;
        Mon, 17 Aug 2020 15:10:01 +0000 (UTC)
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denys Vlasenko <dvlasenk@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: use "$(MAKE)" instead of "make" for headers_install
Date:   Mon, 17 Aug 2020 17:09:46 +0200
Message-Id: <20200817150946.21477-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If top make invocation uses -j4 or larger, this patch reduces
"make headers_install" subtask run time from 30 to 7 seconds.

CC: Shuah Khan <shuah@kernel.org>
CC: Shuah Khan <skhan@linuxfoundation.org>
CC: linux-kselftest@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 tools/testing/selftests/lib.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7a17ea815736..51124b962d56 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -47,9 +47,9 @@ ARCH		?= $(SUBARCH)
 khdr:
 ifndef KSFT_KHDR_INSTALL_DONE
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 endif
-- 
2.25.0

