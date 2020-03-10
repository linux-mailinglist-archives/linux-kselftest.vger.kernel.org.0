Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B917EEDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 03:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCJCvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 22:51:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47098 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726841AbgCJCvU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 22:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583808679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GPG9hcRKDbFlWDK+JQW0CXbqpOizxn+42CHZXwqXrQg=;
        b=D/C7giJOqu4KQkbNe4Ook4/CpGGsAQTDJhEiLKqRfsKU7691V2TdnDyka2N0CsRo2+siT7
        lhGhd0JCcZL/yPt8J+CXI+3JvEJWvh6VNmKaupgexsRghBfO6Ev6NelP+ZttLhJ/VsgAjC
        SK0uCRBLftHFlq6m5kSvqVEwLS0uk3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-lmAYqZe-PF27PvJCwKyN1g-1; Mon, 09 Mar 2020 22:51:17 -0400
X-MC-Unique: lmAYqZe-PF27PvJCwKyN1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34D95477;
        Tue, 10 Mar 2020 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22C165C1C3;
        Tue, 10 Mar 2020 02:51:11 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
Subject: [PATCH v2 2/2] selftests: kvm: Uses TEST_FAIL in tests/utilities
Date:   Mon,  9 Mar 2020 23:50:59 -0300
Message-Id: <20200310025059.9301-3-wainersm@redhat.com>
In-Reply-To: <20200310025059.9301-1-wainersm@redhat.com>
References: <20200310025059.9301-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changed all tests and utilities to use TEST_FAIL macro
instead of TEST_ASSERT(false,...).

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  |  7 +++----
 .../selftests/kvm/lib/aarch64/processor.c     | 17 +++++++--------
 .../testing/selftests/kvm/lib/aarch64/ucall.c |  2 +-
 tools/testing/selftests/kvm/lib/io.c          | 12 +++++------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++-----------
 .../selftests/kvm/lib/x86_64/processor.c      |  5 ++---
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  4 ++--
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  6 +++---
 .../testing/selftests/kvm/x86_64/state_test.c |  6 +++---
 .../selftests/kvm/x86_64/svm_vmcall_test.c    |  6 ++----
 .../kvm/x86_64/vmx_close_while_nested_test.c  |  4 ++--
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  6 +++---
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  4 ++--
 13 files changed, 46 insertions(+), 54 deletions(-)

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
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 86036a59a668..f98c0444ee4f 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -130,7 +130,7 @@ void _virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + pte_index(vm, vaddr) * 8;
 		break;
 	default:
-		TEST_ASSERT(false, "Page table levels must be 2, 3, or 4");
+		TEST_FAIL("Page table levels must be 2, 3, or 4");
 	}
 
 	*ptep = paddr | 3;
@@ -173,14 +173,13 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 			goto unmapped_gva;
 		break;
 	default:
-		TEST_ASSERT(false, "Page table levels must be 2, 3, or 4");
+		TEST_FAIL("Page table levels must be 2, 3, or 4");
 	}
 
 	return pte_addr(vm, *ptep) + (gva & (vm->page_size - 1));
 
 unmapped_gva:
-	TEST_ASSERT(false, "No mapping for vm virtual address, "
-		    "gva: 0x%lx", gva);
+	TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
 	exit(1);
 }
 
@@ -262,11 +261,11 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
 
 	switch (vm->mode) {
 	case VM_MODE_P52V48_4K:
-		TEST_ASSERT(false, "AArch64 does not support 4K sized pages "
-				   "with 52-bit physical address ranges");
+		TEST_FAIL("AArch64 does not support 4K sized pages "
+			  "with 52-bit physical address ranges");
 	case VM_MODE_PXXV48_4K:
-		TEST_ASSERT(false, "AArch64 does not support 4K sized pages "
-				   "with ANY-bit physical address ranges");
+		TEST_FAIL("AArch64 does not support 4K sized pages "
+			  "with ANY-bit physical address ranges");
 	case VM_MODE_P52V48_64K:
 		tcr_el1 |= 1ul << 14; /* TG0 = 64KB */
 		tcr_el1 |= 6ul << 32; /* IPS = 52 bits */
@@ -288,7 +287,7 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
 		tcr_el1 |= 2ul << 32; /* IPS = 40 bits */
 		break;
 	default:
-		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", vm->mode);
+		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
 	sctlr_el1 |= (1 << 0) | (1 << 2) | (1 << 12) /* M | C | I */;
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index 6cd91970fbad..c8e0ec20d3bf 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -62,7 +62,7 @@ void ucall_init(struct kvm_vm *vm, void *arg)
 		if (ucall_mmio_init(vm, start + offset))
 			return;
 	}
-	TEST_ASSERT(false, "Can't find a ucall mmio address");
+	TEST_FAIL("Can't find a ucall mmio address");
 }
 
 void ucall_uninit(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/io.c b/tools/testing/selftests/kvm/lib/io.c
index eaf351cc7e7f..fedb2a741f0b 100644
--- a/tools/testing/selftests/kvm/lib/io.c
+++ b/tools/testing/selftests/kvm/lib/io.c
@@ -61,9 +61,9 @@ ssize_t test_write(int fd, const void *buf, size_t count)
 			continue;
 
 		case 0:
-			TEST_ASSERT(false, "Unexpected EOF,\n"
-				    "  rc: %zi num_written: %zi num_left: %zu",
-				    rc, num_written, num_left);
+			TEST_FAIL("Unexpected EOF,\n"
+				  "  rc: %zi num_written: %zi num_left: %zu",
+				  rc, num_written, num_left);
 			break;
 
 		default:
@@ -138,9 +138,9 @@ ssize_t test_read(int fd, void *buf, size_t count)
 			break;
 
 		case 0:
-			TEST_ASSERT(false, "Unexpected EOF,\n"
-				    "  rc: %zi num_read: %zi num_left: %zu",
-				    rc, num_read, num_left);
+			TEST_FAIL("Unexpected EOF,\n"
+				  "   rc: %zi num_read: %zi num_left: %zu",
+				  rc, num_read, num_left);
 			break;
 
 		default:
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a6dd0401eb50..b71a1e9b6a18 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -199,12 +199,11 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 		DEBUG("Guest physical address width detected: %d\n",
 		      vm->pa_bits);
 #else
-		TEST_ASSERT(false, "VM_MODE_PXXV48_4K not supported on "
-			    "non-x86 platforms");
+		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
 #endif
 		break;
 	default:
-		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", mode);
+		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
 	}
 
 #ifdef __aarch64__
@@ -600,7 +599,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
 		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
 	if (region != NULL)
-		TEST_ASSERT(false, "overlapping userspace_mem_region already "
+		TEST_FAIL("overlapping userspace_mem_region already "
 			"exists\n"
 			"  requested guest_paddr: 0x%lx npages: 0x%lx "
 			"page_size: 0x%x\n"
@@ -616,7 +615,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 			break;
 	}
 	if (region != NULL)
-		TEST_ASSERT(false, "A mem region with the requested slot "
+		TEST_FAIL("A mem region with the requested slot "
 			"already exists.\n"
 			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
 			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
@@ -720,7 +719,7 @@ memslot2region(struct kvm_vm *vm, uint32_t memslot)
 			"  requested slot: %u\n", memslot);
 		fputs("---- vm dump ----\n", stderr);
 		vm_dump(stderr, vm, 2);
-		TEST_ASSERT(false, "Mem region not found");
+		TEST_FAIL("Mem region not found");
 	}
 
 	return region;
@@ -808,7 +807,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	/* Confirm a vcpu with the specified id doesn't already exist. */
 	vcpu = vcpu_find(vm, vcpuid);
 	if (vcpu != NULL)
-		TEST_ASSERT(false, "vcpu with the specified id "
+		TEST_FAIL("vcpu with the specified id "
 			"already exists,\n"
 			"  requested vcpuid: %u\n"
 			"  existing vcpuid: %u state: %p",
@@ -901,8 +900,7 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	} while (pgidx_start != 0);
 
 no_va_found:
-	TEST_ASSERT(false, "No vaddr of specified pages available, "
-		"pages: 0x%lx", pages);
+	TEST_FAIL("No vaddr of specified pages available, pages: 0x%lx", pages);
 
 	/* NOT REACHED */
 	return -1;
@@ -1037,7 +1035,7 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
 				+ (gpa - region->region.guest_phys_addr));
 	}
 
-	TEST_ASSERT(false, "No vm physical memory at 0x%lx", gpa);
+	TEST_FAIL("No vm physical memory at 0x%lx", gpa);
 	return NULL;
 }
 
@@ -1071,8 +1069,7 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
 				+ (hva - (uintptr_t) region->host_mem));
 	}
 
-	TEST_ASSERT(false, "No mapping to a guest physical address, "
-		"hva: %p", hva);
+	TEST_FAIL("No mapping to a guest physical address, hva: %p", hva);
 	return -1;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 683d3bdb8f6a..66fbc8aee8dc 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -576,8 +576,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	return (pte[index[0]].address * vm->page_size) + (gva & 0xfffu);
 
 unmapped_gva:
-	TEST_ASSERT(false, "No mapping for vm virtual address, "
-		    "gva: 0x%lx", gva);
+	TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
 	exit(EXIT_FAILURE);
 }
 
@@ -634,7 +633,7 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_m
 		break;
 
 	default:
-		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", vm->mode);
+		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
 	sregs.cr3 = vm->pgd;
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
 
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 92915e6408e7..a7dc3da62a65 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -109,15 +109,15 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
-				    __FILE__, uc.args[1]);
+			TEST_FAIL("%s at %s:%d", (const char *)uc.args[0],
+				  __FILE__, uc.args[1]);
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			break;
 		case UCALL_DONE:
 			goto done;
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 
 		/* UCALL_SYNC is handled here.  */
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 3ab5ec3da9f4..810d51733f91 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -152,15 +152,15 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
-				    __FILE__, uc.args[1]);
+			TEST_FAIL("%s at %s:%d", (const char *)uc.args[0],
+				  __FILE__, uc.args[1]);
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			break;
 		case UCALL_DONE:
 			goto done;
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 
 		/* UCALL_SYNC is handled here.  */
diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
index e280f68f6365..3b25dc9fe7cd 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
@@ -61,16 +61,14 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s",
-				    (const char *)uc.args[0]);
+			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			break;
 		case UCALL_DONE:
 			goto done;
 		default:
-			TEST_ASSERT(false,
-				    "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 done:
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
index 5dfb53546a26..965c2a6ed574 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
@@ -78,10 +78,10 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s", (const char *)uc.args[0]);
+			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index a223a6401258..d664282d9047 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -126,8 +126,8 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s at %s:%d", (const char *)uc.args[0],
-				    __FILE__, uc.args[1]);
+			TEST_FAIL("%s at %s:%d", (const char *)uc.args[0],
+				  __FILE__, uc.args[1]);
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			/*
@@ -152,7 +152,7 @@ int main(int argc, char *argv[])
 			done = true;
 			break;
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 69e482a95c47..abaa5cf93186 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -150,7 +150,7 @@ int main(int argc, char *argv[])
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_ABORT:
-			TEST_ASSERT(false, "%s", (const char *)uc.args[0]);
+			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
 		case UCALL_SYNC:
 			report(uc.args[1]);
@@ -158,7 +158,7 @@ int main(int argc, char *argv[])
 		case UCALL_DONE:
 			goto done;
 		default:
-			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
+			TEST_FAIL("Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 
-- 
2.17.2

