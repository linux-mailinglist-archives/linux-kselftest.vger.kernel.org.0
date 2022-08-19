Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523DB59A3D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350062AbiHSSBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351283AbiHSSAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E853D25
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z8-20020a17090a014800b001fac4204c7eso2893766pje.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=LIUZkMGvJXcpbhNGmft6GGfIK9I8bm9L0jfGUffk13c=;
        b=pmlvaUHfcF+wVO68CerVhstzSi3CVnWjbp+gMTXQu0l84Wt+2u2oUzVK3BmNftGaGy
         GGpXVCc6+D3MKSACJA2PQVYerbIIezKmekA9B2YvDRShnOKiEElGzMG8v4DxoQHOhABK
         HweEyOo4EvgA7V8ak8DJaDLAmWol6w+mYSfN9HRk14EFe+YFuE2loXeJNPVTk3yWPrTD
         8VHpJBLpndjnsDMVDERfw4XqucQJOyYPEZEzW9F2ZLWcosWIIeOzuSuxCfKLDMLvjgSJ
         IkmOy93ixKWhH8IJU9b7w73iIomz6HzL7w3V64W2f94zV3bIIKWKYIk2A4mUT6KakL6o
         OEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=LIUZkMGvJXcpbhNGmft6GGfIK9I8bm9L0jfGUffk13c=;
        b=rejI2fsUg4dlc3kNUDH9votjaXrC6NmEj+nNJRymIpKGSFuAExPS+U+6eEcWWCmJ7l
         ca165K69VuZ1fKKNOpHvHAeXJJEI+wt7xpz+qIzjY8ua+WWJVc4eofQK01striQLWnu+
         sxUIytgyLQqyLfNi580z95dBXetQWjrdc0/4XE+48TvS36GVYjyiaBNJLpyRavSJ5vS1
         A8+LV4Tevuis9bum11WOaq+gety7p2JmzOYMzjqwO3v9hYGWyV5CvybxPD3q8DHPFI2l
         5SSIIi4gpOdngWbtIeAgwP3hgx7JMKRciTwlqu37s2HCJ71o3GCv6Z8vVNpyRbL5cvJf
         Quwg==
X-Gm-Message-State: ACgBeo1CyB9osW5y1tfao06Sr0ef6tvGdv3cFqz2OKIpjuubMjzAiEDs
        meKoZibPzIPzbA2R+vdenPp7UfOAw+os7l9X
X-Google-Smtp-Source: AA6agR7+aPOAfBVTAgSiy0DQ+nj1se+5Ibd8vZgJ3AwtFXKOvN/xwr/424n5dK411hPKuJHKjJRV/84SpeDaBz07
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:ab41:b0:171:54ae:624c with SMTP
 id ij1-20020a170902ab4100b0017154ae624cmr8313760plb.157.1660931261144; Fri,
 19 Aug 2022 10:47:41 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:55 +0000
In-Reply-To: <20220819174659.2427983-1-vannapurve@google.com>
Message-Id: <20220819174659.2427983-3-vannapurve@google.com>
Mime-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 2/6] selftests: kvm: Add support for private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for registering private memory with kvm using
KVM_SET_USER_MEMORY_REGION ioctl.

Helper function to query extended userspace mem region is introduced to
allow memory conversion.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 12 +++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 40 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index ff2533a32af9..dfe454f228e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -30,7 +30,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
 struct userspace_mem_region {
-	struct kvm_userspace_memory_region region;
+	union {
+		struct kvm_userspace_memory_region region;
+		struct kvm_userspace_memory_region_ext region_ext;
+	};
 	struct sparsebit *unused_phy_pages;
 	struct sparsebit *encrypted_phy_pages;
 	int fd;
@@ -200,7 +203,7 @@ static inline bool kvm_has_cap(long cap)
 
 #define kvm_do_ioctl(fd, cmd, arg)						\
 ({										\
-	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");	\
+	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");	\
 	ioctl(fd, cmd, arg);							\
 })
 
@@ -388,6 +391,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
+
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
@@ -717,6 +721,10 @@ struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 				 uint64_t end);
 
+struct kvm_userspace_memory_region_ext *
+kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end);
+
 #define sync_global_to_guest(vm, g) ({				\
 	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
 	memcpy(_p, &(g), sizeof(g));				\
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 171bc20a097a..f153c71d6988 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 
+#define MFD_INACCESSIBLE  0x0008U
 #define KVM_UTIL_MIN_PFN	2
 
 static int vcpu_mmap_sz(void);
@@ -466,6 +467,35 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	return &region->region;
 }
 
+/*
+ * KVM Userspace Memory Region Ext Find
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   start - Starting VM physical address
+ *   end - Ending VM physical address, inclusive.
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to overlapping ext region, NULL if no such region.
+ *
+ * Public interface to userspace_mem_region_find. Allows tests to look up
+ * the memslot datastructure for a given range of guest physical memory.
+ */
+struct kvm_userspace_memory_region_ext *
+kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end)
+{
+	struct userspace_mem_region *region;
+
+	region = userspace_mem_region_find(vm, start, end);
+	if (!region)
+		return NULL;
+
+	return &region->region_ext;
+}
+
 /*
  * VM VCPU Remove
  *
@@ -764,6 +794,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t alignment;
+	int priv_memfd = -1;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
 		"Number of guest pages is not compatible with the host. "
@@ -869,6 +900,11 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
+	if (flags & KVM_MEM_PRIVATE) {
+		priv_memfd = memfd_create("vm_private_mem_", MFD_INACCESSIBLE);
+		TEST_ASSERT(priv_memfd != -1, "Failed to create private memfd");
+	}
+
 	region->unused_phy_pages = sparsebit_alloc();
 	region->encrypted_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
@@ -878,7 +914,9 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->region.guest_phys_addr = guest_paddr;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	region->region_ext.private_fd = priv_memfd;
+	region->region_ext.private_offset = 0;
+	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region_ext);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
-- 
2.37.1.595.g718a3a8f04-goog

