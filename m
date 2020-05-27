Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F71E3A2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgE0HRI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:17:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53721 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728989AbgE0HRI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2SQc7Kw0tOOlWxNV9I62/TRj+qmAVOcVhm20UoLLYM=;
        b=A2dqnZV2flOzsylnFGQCA8jJtqKDUk5R1m70ZhVw/FDbkCnZOKgwtyr2mo+4j+xrmuZUxs
        Qlk0/wrJ8sJDwNsnsgfx5SDYgWxCCnamlM4XZG5W4f3Y4szX1jDa2O6oiKAynRwLc/chkI
        NEH3eXAq6kS0XTcnQwgtb73YJSo0WUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-RVfEtrgwMY2QDPSzfbDXqQ-1; Wed, 27 May 2020 03:17:05 -0400
X-MC-Unique: RVfEtrgwMY2QDPSzfbDXqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF498EC1A2;
        Wed, 27 May 2020 07:17:04 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 796055C1B0;
        Wed, 27 May 2020 07:17:03 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     jbenc@redhat.com, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [RESEND PATCH 2/3] selftests: fix condition in run_tests
Date:   Wed, 27 May 2020 10:16:58 +0300
Message-Id: <20200527071659.63426-2-yauheni.kaliuta@redhat.com>
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

The check if there are any files to install in case of no files
compares "X  " with "X" so never false.

Remove extra spaces. It may make sense to use make's $(if) function
here.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5b82433d88e3..7a17ea815736 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -70,7 +70,7 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then \
+	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-- 
2.26.2

