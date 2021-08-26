Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3043F8356
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbhHZHul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 03:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240107AbhHZHuj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629964192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v+49LJmy/7FSLBXj9zbLKQa0QcR9o6rQg+TaWgD2How=;
        b=BeRgy76cr5GGBSekB6cAVZl678qkJOKbL3PoXLjRed4KwSMjmFaDS3Pob/5Pd0ZeHK7EzP
        zUqXGM94QLsiqEc1tRVW7dcfAKCcjNnpNUB7pg1ZDLNelAc6wmdbITsNwmRVc7/WsphaVm
        OhndcBEkJArCVnDYjv3iWkNUlhErDtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-zGN-SUMRPbyVN50FKWPmkQ-1; Thu, 26 Aug 2021 03:49:48 -0400
X-MC-Unique: zGN-SUMRPbyVN50FKWPmkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC39193F560;
        Thu, 26 Aug 2021 07:49:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBE726A8F8;
        Thu, 26 Aug 2021 07:49:42 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, Wei Huang <wei@redhat.com>
Subject: [PATCH] KVM: selftests: Fix kvm_vm_free() in cr4_cpuid_sync and vmx_tsc_adjust tests
Date:   Thu, 26 Aug 2021 09:49:28 +0200
Message-Id: <20210826074928.240942-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kvm_vm_free() statement here is currently dead code, since the loop
in front of it can only be left with the "goto done" that jumps right
after the kvm_vm_free(). Fix it by swapping the locations of the "done"
label and the kvm_vm_free().

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 3 +--
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index f40fd097cb35..6f6fd189dda3 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -109,8 +109,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	kvm_vm_free(vm);
-
 done:
+	kvm_vm_free(vm);
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 7e33a350b053..e683d0ac3e45 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -161,7 +161,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	kvm_vm_free(vm);
 done:
+	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.27.0

