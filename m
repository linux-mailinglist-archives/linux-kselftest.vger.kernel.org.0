Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE41F580C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFJPo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 11:44:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727910AbgFJPo4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 11:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591803895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uLvH8zEFZY1KRuBInn1TdRSK/ogUjKzscMti6QJ2sY0=;
        b=hIfFOo+mXrXxdSGd99Gt+OKb2SpKRMjRbx2qe3wbGoMPzgf7bqlnfef9z77Rjk/3Hc6sLg
        Lka2quu9j7tCbn9aUZwAMRR47KCkLxKZ3R6GCF4WneMGucCVwItWj2wW5busane1kVPOf+
        wQqNsUAejEmfo+hu0SLC6bLZoQn9lIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-6-x7pXxcOiCHHVYqISxEdA-1; Wed, 10 Jun 2020 11:44:50 -0400
X-MC-Unique: 6-x7pXxcOiCHHVYqISxEdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3F0107ACF5;
        Wed, 10 Jun 2020 15:44:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2115D9D3;
        Wed, 10 Jun 2020 15:44:48 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest: runner: fix TAP output for skipped tests
Date:   Wed, 10 Jun 2020 11:44:47 -0400
Message-Id: <20200610154447.15826-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to the TAP specification, a skipped test must be marked as "ok"
and annotated with the SKIP directive, for example

   ok 23 # skip Insufficient flogiston pressure.
   (https://testanything.org/tap-specification.html)

Fix the runner script to match this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 676b3a8b114d..f4815cbcd60f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -77,7 +77,7 @@ run_one()
 		echo "ok $test_num $TEST_HDR_MSG") ||
 		(rc=$?;	\
 		if [ $rc -eq $skip_rc ]; then	\
-			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
-- 
2.26.2

