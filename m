Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F018F45F116
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbhKZPzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:55:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:34122 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378337AbhKZPxV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:53:21 -0500
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 10:53:20 EST
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1mqd9R-0000FR-T0; Fri, 26 Nov 2021 16:28:37 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Igor Mammedov <imammedo@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: page_table_test: fix calculation of guest_test_phys_mem
Date:   Fri, 26 Nov 2021 16:28:31 +0100
Message-Id: <52e487458c3172923549bbcf9dfccfbe6faea60b.1637940473.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

A kvm_page_table_test run with its default settings fails on VMX due to
memory region add failure:
> ==== Test Assertion Failure ====
>  lib/kvm_util.c:952: ret == 0
>  pid=10538 tid=10538 errno=17 - File exists
>     1  0x00000000004057d1: vm_userspace_mem_region_add at kvm_util.c:947
>     2  0x0000000000401ee9: pre_init_before_test at kvm_page_table_test.c:302
>     3   (inlined by) run_test at kvm_page_table_test.c:374
>     4  0x0000000000409754: for_each_guest_mode at guest_modes.c:53
>     5  0x0000000000401860: main at kvm_page_table_test.c:500
>     6  0x00007f82ae2d8554: ?? ??:0
>     7  0x0000000000401894: _start at ??:?
>  KVM_SET_USER_MEMORY_REGION IOCTL failed,
>  rc: -1 errno: 17
>  slot: 1 flags: 0x0
>  guest_phys_addr: 0xc0000000 size: 0x40000000

This is because the memory range that this test is trying to add
(0x0c0000000 - 0x100000000) conflicts with LAPIC mapping at 0x0fee00000.

Looking at the code it seems that guest_test_*phys*_mem variable gets
mistakenly overwritten with guest_test_*virt*_mem while trying to adjust
the former for alignment.
With the correct variable adjusted this test runs successfully.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 tools/testing/selftests/kvm/kvm_page_table_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 3836322add00..ba1fdc3dcf4a 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -280,7 +280,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 #ifdef __s390x__
 	alignment = max(0x100000, alignment);
 #endif
-	guest_test_phys_mem = align_down(guest_test_virt_mem, alignment);
+	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
 
 	/* Set up the shared data structure test_args */
 	test_args.vm = vm;
