Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45733E01BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhHDNQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 09:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237972AbhHDNQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 09:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628082983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QQWzlNAvDX3CBz9123+3877NRKt0zUCupiGO/GvWHHA=;
        b=dQ6EUMKaWRAvH3VYh+JbfzD1wQfI2TpTFcr50MTjWfuAWmiroCM1ymeEk944aZez2QFsnd
        lmYiB3Hzr6gkthj3Sths7fz7ukKu2triR+pzQX/Ic78e0hdpeqyAzrQ3fHN/gF9mXdpIN0
        kos8kwfp8tqYc75MrcCACZJiOkrUD10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-3NrtuPaYNgusT6oMQ0ogAg-1; Wed, 04 Aug 2021 09:16:22 -0400
X-MC-Unique: 3NrtuPaYNgusT6oMQ0ogAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579FA192D78B;
        Wed,  4 Aug 2021 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2766060240;
        Wed,  4 Aug 2021 13:16:17 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] KVM: selftests: fix hyperv_clock test
Date:   Wed,  4 Aug 2021 16:16:16 +0300
Message-Id: <20210804131616.463572-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test was mistakenly using addr_gpa2hva on a gva
and that happened to work accidentally.

commit 106a2e766eae ("KVM: selftests:
Lower the min virtual address for misc page allocations")
revealed this bug.

Fixes: 2c7f76b4c42b ("selftests: kvm: Add basic Hyper-V clocksources tests")

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

