Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7628419
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfEWQn0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbfEWQnZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:43:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9879630024AB;
        Thu, 23 May 2019 16:43:25 +0000 (UTC)
Received: from thuth.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD4376090E;
        Thu, 23 May 2019 16:43:22 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/9] kvm: selftests: aarch64: fix default vm mode
Date:   Thu, 23 May 2019 18:43:03 +0200
Message-Id: <20190523164309.13345-4-thuth@redhat.com>
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 23 May 2019 16:43:25 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Jones <drjones@redhat.com>

VM_MODE_P52V48_4K is not a valid mode for AArch64. Replace its
use in vm_create_default() with a mode that works and represents
a good AArch64 default. (We didn't ever see a problem with this
because we don't have any unit tests using vm_create_default(),
but it's good to get it fixed in advance.)

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index e8c42506a09d..fa6cd340137c 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -226,7 +226,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
 	uint64_t extra_pg_pages = (extra_mem_pages / ptrs_per_4k_pte) * 2;
 	struct kvm_vm *vm;
 
-	vm = vm_create(VM_MODE_P52V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = vm_create(VM_MODE_P40V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
 
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
-- 
2.21.0

