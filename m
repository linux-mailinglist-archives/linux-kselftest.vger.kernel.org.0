Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C011117AD2C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 18:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCERZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 12:25:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727722AbgCERZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 12:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583429157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=jKNSxLmMS1+TC7wrcKR5f9MZfVifwBf0zoemzoIpDZ4=;
        b=JhhviSFkfGfaSZxXHeKyrvNMExflgbqFH+42oKT3viAMLKRji27AXnHXDcmHs43L9dueMB
        aD83F77rXSdmOYpywvwVgzpsWeAVWo6xBejYKxqJDwDiJ/hDThwpBeUhaEG5INficqB0vi
        QBnbNUVTCmYKcSpsEBukYejSSBmenCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-3ZC_uy4VOi-n-Fq54ncYwQ-1; Thu, 05 Mar 2020 12:25:54 -0500
X-MC-Unique: 3ZC_uy4VOi-n-Fq54ncYwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0F8800D50;
        Thu,  5 Mar 2020 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98B505C290;
        Thu,  5 Mar 2020 17:25:46 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     shuah@kernel.org, tglx@linutronix.de, thuth@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] kvm: selftests: Add TEST_FAIL macro
Date:   Thu,  5 Mar 2020 14:25:32 -0300
Message-Id: <20200305172532.9360-2-wainersm@redhat.com>
In-Reply-To: <20200305172532.9360-1-wainersm@redhat.com>
References: <20200305172532.9360-1-wainersm@redhat.com>
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
 tools/testing/selftests/kvm/dirty_log_test.c             | 7 +++----
 tools/testing/selftests/kvm/include/test_util.h          | 3 +++
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222a6628..137c1cfec2cc 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -166,10 +166,9 @@ static void *vcpu_worker(void *data)
 			pages_count += TEST_PAGES_PER_LOOP;
 			generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		} else {
-			TEST_ASSERT(false,
-				    "Invalid guest sync status: "
-				    "exit_reason=%s\n",
-				    exit_reason_str(run->exit_reason));
+			TEST_FAIL("Invalid guest sync status: "
+				  "exit_reason=%s\n",
+				  exit_reason_str(run->exit_reason));
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a41db6fb7e24..336b16500b0f 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -39,4 +39,7 @@ void test_assert(bool exp, const char *exp_str,
 		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
 } while (0)
 
+#define TEST_FAIL(fmt, ...) \
+        TEST_ASSERT(false, fmt, ##__VA_ARGS__)
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 63cc9c3f5ab6..501d6217b9ed 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -101,12 +101,12 @@ int main(int argc, char *argv[])
 			vcpu_sregs_set(vm, VCPU_ID, &sregs);
 			break;
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
+			TEST_FAIL("Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
 			break;
 		case UCALL_DONE:
 			goto done;
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 
-- 
2.17.2

