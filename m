Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88081C0972
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfI0QS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:57 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47897 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfI0QS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:57 -0400
Received: by mail-pf1-f201.google.com with SMTP id t65so2224104pfd.14
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xPCv3uXlazWlSRskqsdKaxPZp5dQ/Fe6mwXEmAcpuP8=;
        b=mVYC3AcLqq7lpR19qrtmXwTpN1QH5NUWNrU1PmCycH095IpjGR1B0fdArc9tx04NQy
         pGMWOIsWinFLN73640zmBst/Id7FoEv26Q8/tyxEqSUXrvRVgapQSX/u9ZP6a+xJB2Qd
         7o+FPsaJ9JJheZHknu1tFk+FmM5xdX1i2CaW5CM0hqGjmNtIG6bWnidceMQXfke7I4eW
         h1qou1FaE/RUPacwmhPydQYy9YSbuHDy1Y3P8dyUnB4wqVRm8ZdfsKlixyF7R+N6ysgm
         w11ApIWQflqXvq8cwvkANRaBP+m8x3oe8ljkZcwyIfu+VAn/5B06iBZlYeg4TTHF3Yka
         0ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xPCv3uXlazWlSRskqsdKaxPZp5dQ/Fe6mwXEmAcpuP8=;
        b=KxLi27pB9JNJNKsPrSmdcSkroYG0EwbbB9Dm0kWI+YPi4u7wAWh3Pqd0epVI3oXQ8q
         47au8isi/MOjvcWGq+cX7VXTb6itFXqruXxmsuLC+pWbrcrszoLMvnlflJqgpw8F/6CW
         77oy8Zft7N/SFcaztbXj0j7Y54N3hMErigeZHSwvAY6ezf1rnOteB9vqE70NWGMvd4fp
         oel1K4DqEa84nbqm7163kp4ve2lcuUvV+XO72J3xyke6JElD0D+lh/S5kEYAX7nX1SIZ
         VJ5gi8q1aaMGn20hsNtEHCbMFIMeC6HeapHHBsCFtVNMkx0i9S6Icx0hjQQatospqcpd
         o/fA==
X-Gm-Message-State: APjAAAXW8Sy5015QXEybQ0YU4XdBPNz5aQGxxZ1B8w/vuUhutgJvp0wP
        y06ibF4lhvzStSCFbewoHCFgOSkeYdpg
X-Google-Smtp-Source: APXvYqx+BBzjvqkkOTkRQKWs+KPSIBz5jwmJqyJwsaFtM9cKE3ONTWQHR9MkRYt9CTyeguTQ/0drBIVepuuK
X-Received: by 2002:a63:4754:: with SMTP id w20mr10340734pgk.134.1569601135246;
 Fri, 27 Sep 2019 09:18:55 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:35 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-8-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 7/9] KVM: selftests: Add parameter to _vm_create for memslot 0
 base paddr
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM creates internal memslots between 3 and 4 GiB paddrs on the first
vCPU creation. If memslot 0 is large enough it collides with these
memslots an causes vCPU creation to fail. Add a paddr parameter for
memslot 0 so that tests which support large VMs can relocate memslot 0
above 4 GiB.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
 tools/testing/selftests/kvm/dirty_log_test.c     | 2 +-
 tools/testing/selftests/kvm/include/kvm_util.h   | 3 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c       | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index fe6c5a4f8b8c2..eb1f7e4b83de3 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -171,7 +171,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
 	pages += (2 * pages) / PTES_PER_PT;
 	pages += ((2 * vcpus * vcpu_wss) >> PAGE_SHIFT_4K) / PTES_PER_PT;
 
-	vm = _vm_create(mode, pages, O_RDWR);
+	vm = vm_create(mode, pages, O_RDWR);
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222a66285..181eac3a12b66 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -252,7 +252,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	struct kvm_vm *vm;
 	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
 
-	vm = _vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 29cccaf96baf6..4f672c00c9e9b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -69,7 +69,8 @@ int kvm_check_cap(long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 
 struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
-struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
+struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t guest_paddr,
+			  uint64_t phy_pages, int perm);
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp, int perm);
 void kvm_vm_release(struct kvm_vm *vmp);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 80a338b5403c3..7ec2bbdaba875 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -132,7 +132,8 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
  * descriptor to control the created VM is created with the permissions
  * given by perm (e.g. O_RDWR).
  */
-struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
+struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t guest_paddr,
+			  uint64_t phy_pages, int perm)
 {
 	struct kvm_vm *vm;
 
@@ -229,14 +230,14 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	vm->vpages_mapped = sparsebit_alloc();
 	if (phy_pages != 0)
 		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-					    0, 0, phy_pages, 0);
+					    guest_paddr, 0, phy_pages, 0);
 
 	return vm;
 }
 
 struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 {
-	return _vm_create(mode, phy_pages, perm);
+	return _vm_create(mode, 0, phy_pages, perm);
 }
 
 /*
-- 
2.23.0.444.g18eeb5a265-goog

