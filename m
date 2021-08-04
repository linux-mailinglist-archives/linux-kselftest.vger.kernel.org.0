Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F833E0011
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhHDLVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 07:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237469AbhHDLVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 07:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628076065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Go3xSyOZAVuhtZkvJhM1Zcpvk93XR2WRi/A1Qg4IR2c=;
        b=D3J1/afNSveqMwOavrw8C+dcQeKfqgAzKxxt+C1Y1cjHHjlhJogkrDbfKk3pgb1HZklPK1
        bS6Eayb3tb7OpB8AH0FjOD+mfLxjtntz7EZEtYRUtyCI8ntuiRozFHkx7R5/ENNMY99lAv
        STxPX2f3RNzdWai9WEY4hesJWQRLqJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-GuF6KnNRNtmO4YVzzdNdzQ-1; Wed, 04 Aug 2021 07:21:02 -0400
X-MC-Unique: GuF6KnNRNtmO4YVzzdNdzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BA9587D542;
        Wed,  4 Aug 2021 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E306717B73;
        Wed,  4 Aug 2021 11:20:58 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH] KVM: selftests: fix hyperv_clock test
Date:   Wed,  4 Aug 2021 14:20:57 +0300
Message-Id: <20210804112057.409498-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test was mistakenly using addr_gpa2hva on a gva
and that happened to work accidentally.

commit 106a2e766eae ("KVM: selftests:
Lower the min virtual address for misc page allocations")
revealed this bug.

Fixes: 106a2e766eae ("KVM: selftests: Lower the min virtual address for misc page allocations")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index bab10ae787b6..e0b2bb1339b1 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -215,7 +215,7 @@ int main(void)
 	vcpu_set_hv_cpuid(vm, VCPU_ID);
 
 	tsc_page_gva = vm_vaddr_alloc_page(vm);
-	memset(addr_gpa2hva(vm, tsc_page_gva), 0x0, getpagesize());
+	memset(addr_gva2hva(vm, tsc_page_gva), 0x0, getpagesize());
 	TEST_ASSERT((addr_gva2gpa(vm, tsc_page_gva) & (getpagesize() - 1)) == 0,
 		"TSC page has to be page aligned\n");
 	vcpu_args_set(vm, VCPU_ID, 2, tsc_page_gva, addr_gva2gpa(vm, tsc_page_gva));
-- 
2.26.3

