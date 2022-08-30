Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A65A70FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiH3Wnp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiH3WnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:24 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D58050A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z8-20020a17090abd8800b001fd5f11fca7so8177604pjr.6
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=72P9i6U+1Dr4e9vSKI1gPWv6Lo3gM5hWP8wyM1fHGL0=;
        b=BmsjrGFWHc6Y2fjLh0Guc+hSkU6LRLDr7ZN+urJtAfJo95/yn8UtEUaA70RAyPcwJM
         eEJbzhv3Xr6tLaVaI+SWn5OUmXgPH67zijb6AQI/RVZXxJhHWJ0vv83NKZbLcGm3A6n2
         JG1d3U32+PPI+dIUPMz2XWqz7Hu8ha7qzMHGuEcjWHizAmgB7MOYAoel5QpUdu/31AAV
         bMl6W1aLYSjEywBO7oap4TzR3PW31n9rJbdFV+Eslv700pf3UfKhHVc/F+t7mUxeXuxU
         ILWWvuw8/K0JiX+VZbAUAnrgUo9ixRflWR9XK1Dj9ERFmYsdHCi5YD8zbUj26WBY07ly
         StgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=72P9i6U+1Dr4e9vSKI1gPWv6Lo3gM5hWP8wyM1fHGL0=;
        b=dbp5O0OWSe9hmEk17hSaqVeI/g3uKw6ZK3SVASdyt2PJ8J4FHg79hjk2WyXtRih9Vf
         p7g4oNjapHjBCQj2473een7kpr7BjsYLVjEJcdK9E6dXOYHUnfXsv/9SmpyRciMlGwDn
         sGilgosetPIKhNaj2hBmUWh6l+gK+YRsVA1GXja3AToE97Y853m9cDqC+TA8pBgK/0Ja
         nnfv4/v6O7xizVzjWUWZqbuWDtv/MNVSYF9BO98fo2FZmmutX2EYZ7PDNYBbcxzrzKRn
         l6anoL4mCf6UFwKSwFRX7PXxRqpuMV60iXhsArExfq5VpDHbvWTtpedTrdRsHQelR3TJ
         WvLg==
X-Gm-Message-State: ACgBeo3N2HVShtVUsXXu22+4/HED0ecKUoX3WIqEbvorkcF9LD28YIBv
        LM28IXxPTD4hANFSuBSRaZ7ZQ3cU1ENfKC+7
X-Google-Smtp-Source: AA6agR694skgUA9ff0wN7YLAz9d1J3Zwv7gfGw4NDsA/Q5y26oGB9uvpFpTcJTINj3D3/2tLzNcd9gkmf5zQAIEi
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:ef50:b0:171:516d:d2ce with SMTP
 id e16-20020a170902ef5000b00171516dd2cemr22222790plx.171.1661899400834; Tue,
 30 Aug 2022 15:43:20 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:54 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-4-vannapurve@google.com>
Subject: [RFC V2 PATCH 3/8] arch: x86: sev: Populate private memory fd during LAUNCH_UPDATE_DATA
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change adds handling of HVA ranges to copy contents
to private memory while doing sev launch update data.

mem_attr array is updated during LAUNCH_UPDATE_DATA to ensure
that encrypted memory is marked as private.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kvm/svm/sev.c   | 99 ++++++++++++++++++++++++++++++++++++----
 include/linux/kvm_host.h |  2 +
 virt/kvm/kvm_main.c      | 39 ++++++++++------
 3 files changed, 116 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 309bcdb2f929..673dca318cd4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -492,23 +492,22 @@ static unsigned long get_num_contig_pages(unsigned long idx,
 	return pages;
 }
 
-static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
+int sev_launch_update_shared_gfn_handler(struct kvm *kvm,
+	struct kvm_gfn_range *range, struct kvm_sev_cmd *argp)
 {
 	unsigned long vaddr, vaddr_end, next_vaddr, npages, pages, size, i;
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	struct kvm_sev_launch_update_data params;
 	struct sev_data_launch_update_data data;
 	struct page **inpages;
 	int ret;
 
-	if (!sev_guest(kvm))
-		return -ENOTTY;
-
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
-		return -EFAULT;
+	vaddr = gfn_to_hva_memslot(range->slot, range->start);
+	if (kvm_is_error_hva(vaddr)) {
+		pr_err("vaddr is erroneous 0x%lx\n", vaddr);
+		return -EINVAL;
+	}
 
-	vaddr = params.uaddr;
-	size = params.len;
+	size = (range->end - range->start) << PAGE_SHIFT;
 	vaddr_end = vaddr + size;
 
 	/* Lock the user memory. */
@@ -560,6 +559,88 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+int sev_launch_update_priv_gfn_handler(struct kvm *kvm,
+	struct kvm_gfn_range *range, struct kvm_sev_cmd *argp)
+{
+	struct sev_data_launch_update_data data;
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	gfn_t gfn;
+	kvm_pfn_t pfn;
+	struct kvm_memory_slot *memslot = range->slot;
+	int ret = 0;
+
+	data.reserved = 0;
+	data.handle = sev->handle;
+
+	for (gfn = range->start; gfn < range->end; gfn++) {
+		int order;
+		void *kvaddr;
+
+		ret = kvm_private_mem_get_pfn(memslot,
+			gfn, &pfn, &order);
+		if (ret)
+			return ret;
+
+		kvaddr = pfn_to_kaddr(pfn);
+		if (!virt_addr_valid(kvaddr)) {
+			pr_err("Invalid kvaddr 0x%lx\n", (uint64_t)kvaddr);
+			ret = -EINVAL;
+			goto e_ret;
+		}
+
+		ret = kvm_read_guest_page(kvm, gfn, kvaddr, 0, PAGE_SIZE);
+		if (ret) {
+			pr_err("guest read failed 0x%lx\n", ret);
+			goto e_ret;
+		}
+
+		if (!this_cpu_has(X86_FEATURE_SME_COHERENT))
+			clflush_cache_range(kvaddr, PAGE_SIZE);
+
+		data.len = PAGE_SIZE;
+		data.address = __sme_set(pfn << PAGE_SHIFT);
+		ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_DATA, &data, &argp->error);
+		if (ret)
+			goto e_ret;
+
+		kvm_private_mem_put_pfn(memslot, pfn);
+	}
+	kvm_vm_set_region_attr(kvm, range->start, range->end,
+		true /* priv_attr */);
+
+	return ret;
+
+e_ret:
+	kvm_private_mem_put_pfn(memslot, pfn);
+	return ret;
+}
+
+int sev_launch_update_gfn_handler(struct kvm *kvm,
+	struct kvm_gfn_range *range, void *data)
+{
+	struct kvm_sev_cmd *argp = (struct kvm_sev_cmd *)data;
+
+	if (kvm_slot_can_be_private(range->slot))
+		return sev_launch_update_priv_gfn_handler(kvm, range, argp);
+
+	return sev_launch_update_shared_gfn_handler(kvm, range, argp);
+}
+
+static int sev_launch_update_data(struct kvm *kvm,
+		struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_launch_update_data params;
+
+	if (!sev_guest(kvm))
+		return -ENOTTY;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	return kvm_vm_do_hva_range_op(kvm, params.uaddr, params.uaddr + params.len,
+		sev_launch_update_gfn_handler, argp);
+}
+
 static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
 	struct sev_es_save_area *save = svm->sev_es.vmsa;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c860e6d6408d..5d0054e957b4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -980,6 +980,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 void kvm_exit(void);
 
 void kvm_get_kvm(struct kvm *kvm);
+int kvm_vm_set_region_attr(struct kvm *kvm, unsigned long gfn_start,
+	unsigned long gfn_end, bool priv_attr);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 16cb9ab59143..9463737c2172 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -981,7 +981,7 @@ static int kvm_vm_populate_private_mem(struct kvm *kvm, unsigned long gfn_start,
 	}
 
 	mutex_lock(&kvm->slots_lock);
-	for (gfn = gfn_start; gfn <= gfn_end; gfn++) {
+	for (gfn = gfn_start; gfn < gfn_end; gfn++) {
 		int order;
 		void *kvaddr;
 
@@ -1012,12 +1012,29 @@ static int kvm_vm_populate_private_mem(struct kvm *kvm, unsigned long gfn_start,
 }
 #endif
 
+int kvm_vm_set_region_attr(struct kvm *kvm, unsigned long gfn_start,
+	unsigned long gfn_end, bool priv_attr)
+{
+	int r;
+	void *entry;
+	unsigned long index;
+
+	entry = priv_attr ? xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
+
+	for (index = gfn_start; index < gfn_end; index++) {
+		r = xa_err(xa_store(&kvm->mem_attr_array, index, entry,
+				GFP_KERNEL_ACCOUNT));
+		if (r)
+			break;
+	}
+
+	return r;
+}
+
 static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
 					     struct kvm_enc_region *region)
 {
 	unsigned long start, end;
-	unsigned long index;
-	void *entry;
 	int r;
 
 	if (region->size == 0 || region->addr + region->size < region->addr)
@@ -1026,22 +1043,14 @@ static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl
 		return -EINVAL;
 
 	start = region->addr >> PAGE_SHIFT;
-	end = (region->addr + region->size - 1) >> PAGE_SHIFT;
-
-	entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
-				xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
-
-	for (index = start; index <= end; index++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, index, entry,
-				GFP_KERNEL_ACCOUNT));
-		if (r)
-			break;
-	}
+	end = (region->addr + region->size) >> PAGE_SHIFT;
+	r = kvm_vm_set_region_attr(kvm, start, end,
+		(ioctl == KVM_MEMORY_ENCRYPT_REG_REGION));
 
 	kvm_zap_gfn_range(kvm, start, end + 1);
 
 #ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
-	if (!kvm->vm_entry_attempted && (ioctl == KVM_MEMORY_ENCRYPT_REG_REGION))
+	if (!r && !kvm->vm_entry_attempted && (ioctl == KVM_MEMORY_ENCRYPT_REG_REGION))
 		r = kvm_vm_populate_private_mem(kvm, start, end);
 #endif
 
-- 
2.37.2.672.g94769d06f0-goog

