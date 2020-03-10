Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84817EED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 03:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCJCvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 22:51:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726760AbgCJCvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 22:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583808674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=X5rRvUDvsTgQao4JkzzYjt+VB8uH8OR/+ZrMMAk7Ask=;
        b=iLBoYZP+w/HPf0A1m8WsMcOPAIRahlNXSsYuiMMfI1Mo/YTFG3kVzODKScBMnVkPCfQzPw
        gfMlUs7IyZPs1oEfvW88AzT2LyYSm+o2dXzmxoktNSXT4/BWVMyahdI+jWawJ711HqI/My
        Jia8lMEm2Uxj6XQKfBUYaPq8BChflgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6H4BNnzzOGSeQ8-6mYA9tw-1; Mon, 09 Mar 2020 22:51:12 -0400
X-MC-Unique: 6H4BNnzzOGSeQ8-6mYA9tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62495184C800;
        Tue, 10 Mar 2020 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 863605C1C3;
        Tue, 10 Mar 2020 02:51:07 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
Subject: [PATCH v2 1/2] selftests: kvm: Introduce the TEST_FAIL macro
Date:   Mon,  9 Mar 2020 23:50:58 -0300
Message-Id: <20200310025059.9301-2-wainersm@redhat.com>
In-Reply-To: <20200310025059.9301-1-wainersm@redhat.com>
References: <20200310025059.9301-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some tests/utilities use the TEST_ASSERT(false, ...) pattern to
indicate a failure and stop execution.

This change introduces the TEST_FAIL macro which is a wrap around
TEST_ASSERT(false, ...) and so provides a direct alternative for
failing a test.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a41db6fb7e24..903a7576d0e1 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -39,4 +39,7 @@ void test_assert(bool exp, const char *exp_str,
 		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
 } while (0)
 
+#define TEST_FAIL(fmt, ...) \
+	TEST_ASSERT(false, fmt, ##__VA_ARGS__)
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
-- 
2.17.2

