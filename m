Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C638358245
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhDHLns (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 07:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhDHLnr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 07:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617882216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OOkthL+koEr5R8pUMKCXf6426WciB8ikuZyFtZRx7o=;
        b=XV/hpKJCQumP4DzN04rKQOiyQlwemrBd4rc7KyvOC+vSRIEMm/3xCYn/7hLjzzhQeQz94m
        3dti5OJyJmJ2AJ26ykFRwnWremmr4qPhBxkHtWngNGj9BWHucXLX29mseyuTz/Z2R2QHhN
        c8hBE8BBOrc6bzZf5fCKrJvtZI73bWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-NXKLR0kxOXyBL5yjGG989g-1; Thu, 08 Apr 2021 07:43:32 -0400
X-MC-Unique: NXKLR0kxOXyBL5yjGG989g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B3A4801814;
        Thu,  8 Apr 2021 11:43:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-155.ams2.redhat.com [10.36.113.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15E05B4A8;
        Thu,  8 Apr 2021 11:43:12 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/4] KVM: x86: Fix a spurious -E2BIG in KVM_GET_EMULATED_CPUID
Date:   Thu,  8 Apr 2021 13:43:00 +0200
Message-Id: <20210408114303.30310-2-eesposit@redhat.com>
In-Reply-To: <20210408114303.30310-1-eesposit@redhat.com>
References: <20210408114303.30310-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When retrieving emulated CPUID entries, check for an insufficient array
size if and only if KVM is actually inserting an entry.
If userspace has a priori knowledge of the exact array size,
KVM_GET_EMULATED_CPUID will incorrectly fail due to effectively requiring
an extra, unused entry.

Fixes: 433f4ba19041 ("KVM: x86: fix out-of-bounds write in KVM_GET_EMULATED_CPUID (CVE-2019-19332)")
Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/x86/kvm/cpuid.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6bd2f8b830e4..d30194081892 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -567,34 +567,33 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 
 static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
 {
-	struct kvm_cpuid_entry2 *entry;
-
-	if (array->nent >= array->maxnent)
-		return -E2BIG;
+	struct kvm_cpuid_entry2 entry;
 
-	entry = &array->entries[array->nent];
-	entry->function = func;
-	entry->index = 0;
-	entry->flags = 0;
+	memset(&entry, 0, sizeof(entry));
 
 	switch (func) {
 	case 0:
-		entry->eax = 7;
-		++array->nent;
+		entry.eax = 7;
 		break;
 	case 1:
-		entry->ecx = F(MOVBE);
-		++array->nent;
+		entry.ecx = F(MOVBE);
 		break;
 	case 7:
-		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		entry->eax = 0;
-		entry->ecx = F(RDPID);
-		++array->nent;
-	default:
+		entry.flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+		entry.ecx = F(RDPID);
 		break;
+	default:
+		goto out;
 	}
 
+	/* This check is performed only when func is valid */
+	if (array->nent >= array->maxnent)
+		return -E2BIG;
+
+	entry.function = func;
+	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
+
+out:
 	return 0;
 }
 
-- 
2.30.2

