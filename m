Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C82354E97
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbhDFI1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 04:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244334AbhDFI1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 04:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617697644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYGtSBURRU7WTSXl83fHRTlB7M6uxRtcmancVGQ+Jas=;
        b=iOlULQl1FYO1mUFa4NMTgczYpIQgFeAHljtOXHn+KC2tS7edf5AETRIkieIGhQjT+3EsT7
        Am7OVIc1km8DANWdVbjVhlOehEXwXCsVEHWE/17r7O6dKEv0OW08xyo1iVLfCHcReX0Nw8
        x01FxX5WKjxNgB6wmKiRB5kqXBhaQKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-e1zQkeYqNIexaNoPEd0Afw-1; Tue, 06 Apr 2021 04:27:21 -0400
X-MC-Unique: e1zQkeYqNIexaNoPEd0Afw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C974107B789;
        Tue,  6 Apr 2021 08:27:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-253.ams2.redhat.com [10.36.114.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF8745D9DC;
        Tue,  6 Apr 2021 08:27:12 +0000 (UTC)
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
Subject: [PATCH v3 3/4] selftests: add kvm_get_emulated_cpuid to processor.h
Date:   Tue,  6 Apr 2021 10:26:41 +0200
Message-Id: <20210406082642.20115-4-eesposit@redhat.com>
In-Reply-To: <20210406082642.20115-1-eesposit@redhat.com>
References: <20210406082642.20115-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the similar kvm_get_supported_cpuid(),
kvm_get_emulated_cpuid  allocates and gets
a struct kvm_cpuid2 filled with emulated features.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/lib/x86_64/processor.c      | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0b30b4e15c38..ae1b9530e187 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -353,6 +353,7 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid,
 struct kvm_msr_list *kvm_get_msr_index_list(void);
 uint64_t kvm_get_feature_msr(uint64_t msr_index);
 struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
+struct kvm_cpuid2 *kvm_get_emulated_cpuid(void);
 
 struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_set_cpuid(struct kvm_vm *vm, uint32_t vcpuid,
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index e676fe40bfe6..2ea14421bdfe 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -669,6 +669,39 @@ struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 	return cpuid;
 }
 
+/*
+ * KVM Emulated CPUID Get
+ *
+ * Input Args: None
+ *
+ * Output Args:
+ *
+ * Return: The emulated KVM CPUID
+ *
+ * Get the guest CPUID emulated by KVM.
+ */
+struct kvm_cpuid2 *kvm_get_emulated_cpuid(void)
+{
+	static struct kvm_cpuid2 *cpuid;
+	int ret;
+	int kvm_fd;
+
+	if (cpuid)
+		return cpuid;
+
+	cpuid = allocate_kvm_cpuid2();
+	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
+	if (kvm_fd < 0)
+		exit(KSFT_SKIP);
+
+	ret = ioctl(kvm_fd, KVM_GET_EMULATED_CPUID, cpuid);
+	TEST_ASSERT(ret == 0, "KVM_GET_EMULATED_CPUID failed %d %d\n",
+		    ret, errno);
+
+	close(kvm_fd);
+	return cpuid;
+}
+
 /*
  * KVM Get MSR
  *
-- 
2.30.2

