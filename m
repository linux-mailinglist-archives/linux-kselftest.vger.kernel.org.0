Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4466350038
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhCaM1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235506AbhCaM1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617193628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIbQKQiXIoTeHIEctRDJOzv7hWKMM1QPTTDvevPM1vE=;
        b=TL/YGiU4+NvQAi96s92HJNBT5khwUmGRNv4EUioWq4RYttdQn8CmkoZ5Wg8XcMU8MGEKOU
        oSeVMoeFGUCquVFrHGv24547eqHYYyDLpb3IgCK2OGV0HZF3sGSQgfC2Nctx3zyrLYxXa/
        ghYiv9f5EOeigGSpjpzA4C+tA0sd8TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-B8Jnwc57PViAsuTEdAVRxg-1; Wed, 31 Mar 2021 08:27:06 -0400
X-MC-Unique: B8Jnwc57PViAsuTEdAVRxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71F521922961;
        Wed, 31 Mar 2021 12:27:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-218.ams2.redhat.com [10.36.114.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2307F51C39;
        Wed, 31 Mar 2021 12:26:57 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] kvm: cpuid: adjust the returned nent field of kvm_cpuid2 for KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
Date:   Wed, 31 Mar 2021 14:26:46 +0200
Message-Id: <20210331122649.38323-2-eesposit@redhat.com>
In-Reply-To: <20210331122649.38323-1-eesposit@redhat.com>
References: <20210331122649.38323-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
a nent field inside the kvm_cpuid2 struct to be big enough to contain
all entries that will be set by kvm.
Therefore if the nent field is too high, kvm will adjust it to the
right value. If too low, -E2BIG is returned.

However, when filling the entries do_cpuid_func() requires an
additional entry, so if the right nent is known in advance,
giving the exact number of entries won't work because it has to be 
increased by one.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/x86/kvm/cpuid.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6bd2f8b830e4..02a51f921548 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -567,34 +567,34 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 
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
+	entry.function = func;
+	entry.index = 0;
+	entry.flags = 0;
 
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
+		entry.flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+		entry.eax = 0;
+		entry.ecx = F(RDPID);
 		break;
+	default:
+		goto out;
 	}
 
+	if (array->nent >= array->maxnent)
+		return -E2BIG;
+
+	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
+
+out:
 	return 0;
 }
 
@@ -975,6 +975,7 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 
 	if (cpuid->nent < 1)
 		return -E2BIG;
+
 	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
 		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
 
-- 
2.30.2

