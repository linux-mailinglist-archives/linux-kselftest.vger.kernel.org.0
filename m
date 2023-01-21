Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE26761FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAUAQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAUAQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:16:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C6AA7C5
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n194-20020a2540cb000000b008038647d9ebso1909995yba.5
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7o4vSmm7ZL1KEassKDMWSbS80FYjDRO3LkEb1B3l7A=;
        b=Ol7HjVscoT8ho/9hbUrrCazQ67jYdiv/WqZ3xCCEBOmLMoRYL3BVBpX9yE4cKVDNaM
         k2Bs1B5PSpElX8QFPMjeAqEYDtW6CtPgpDi+gHVAujrUnMRQfAvsZpqSatGSNrRowTaY
         qWOU0SderZMc9TdF+m65z5N/Gy26LtNslf/DkyoJYelWAo3xwiQtDsGz+8R91hjiD+1B
         l5KYpyddlEv1NtUoggfZL9Kb5LuD9WrfVdLaMcy96u+xYmf8sycyvox4f0JLDUf/+mvX
         dEbJG3xxtHu7lbyab1L26tQFECJWcXKTfIsiqYhE4WfGeXUMwnPZA6OXAjwJsBj9Ko2T
         /7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7o4vSmm7ZL1KEassKDMWSbS80FYjDRO3LkEb1B3l7A=;
        b=1BLK3PilYT35gcoUeTV/bq00smhl4UlO99XHwkmdSHsKvH9OaNjcwM8PVvDEeHbyB8
         RSrV1xEYZAcFhnIssnfNUwk/1p9upYjFadTYhbrsj4iNEHa3N/A7tgy7da6NM5SRtiY+
         xanB8VjcvBYGEi+mjwlaTLdqxtDY4NsVcFtEewMZK3iMPnvwRAQTXQkMDXiu1v5ZMlpI
         Lxxt4y/l5tJ5MVypUQ7LRElZnPWkbCpwt9ggPUz6m1A31vgrWrzbPeWWNr/jj1EhATeg
         NuffuGIo4C3eXSAQvjj2espfa1ubfDpnVRRVwp3EcaJNTxYpiuO8wc8qCECwa6wjEoFj
         XxwQ==
X-Gm-Message-State: AFqh2kqWOFZEk9ustVNCTioCAXKXUVTZxZf8QiGu9ulULQMMz6FOopEo
        L+n83fs9NVNbDLJcTYAdcu21/u4Mp605uzdF24bw5CBH1KRNWN64rVLimOJ4niO2kWAQC9dysOU
        ZKbm9ulek/8NJAJe63U1gkLDlzEevUnITiP/+FdO5buwKReJB7j4HjH0F6jkda37UqT+VITBpcF
        STAKoTijZbf08=
X-Google-Smtp-Source: AMrXdXvb6e+7GbFt53kF2e0bJ3VgqeUIfUKaID4GUf2ASLS61yYJrydHuxqaqc5U/Mq13V5eDDpJ8IqcnwLc8SZnBQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a0d:d5c6:0:b0:4ef:ce3a:a54 with SMTP
 id x189-20020a0dd5c6000000b004efce3a0a54mr2181857ywd.485.1674260179077; Fri,
 20 Jan 2023 16:16:19 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:13 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-3-ackerleytng@google.com>
Subject: [RFC PATCH v3 02/31] KVM: selftests: Add support for creating
 non-default type VMs
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

Currently vm_create function only creates KVM_VM_TYPE_DEFAULT type VMs.
Adding type parameter to ____vm_create to create new VM types.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 6 ++++--
 tools/testing/selftests/kvm/lib/kvm_util.c          | 6 +++---
 tools/testing/selftests/kvm/lib/x86_64/sev.c        | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 0db5cd4b8383a..0fa4dab3d8e52 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -27,6 +27,8 @@
 
 #define NSEC_PER_SEC 1000000000L
 
+#define KVM_VM_TYPE_DEFAULT	0
+
 typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
@@ -686,13 +688,13 @@ uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
  * __vm_create() does NOT create vCPUs, @nr_runnable_vcpus is used purely to
  * calculate the amount of memory needed for per-vCPU data, e.g. stacks.
  */
-struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages);
+struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages, int type);
 struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
-	return ____vm_create(VM_MODE_DEFAULT, 0);
+	return ____vm_create(VM_MODE_DEFAULT, 0, KVM_VM_TYPE_DEFAULT);
 }
 
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 5257bce6f546d..14246f0fd2e78 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -185,7 +185,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
-struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
+struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages, int type)
 {
 	struct kvm_vm *vm;
 
@@ -201,7 +201,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
 	hash_init(vm->regions.slot_hash);
 
 	vm->mode = mode;
-	vm->type = 0;
+	vm->type = type;
 
 	vm->pa_bits = vm_guest_mode_params[mode].pa_bits;
 	vm->va_bits = vm_guest_mode_params[mode].va_bits;
@@ -337,7 +337,7 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
 
-	vm = ____vm_create(mode, nr_pages);
+	vm = ____vm_create(mode, nr_pages, KVM_VM_TYPE_DEFAULT);
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index faed2ebe63ac9..dedfd9f45cfb3 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -221,7 +221,7 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
 	uint64_t nr_pages = vm_nr_pages_required(mode, 1, 0);
 	struct kvm_vm *vm;
 
-	vm = ____vm_create(mode, nr_pages);
+	vm = ____vm_create(mode, nr_pages, KVM_VM_TYPE_DEFAULT);
 
 	kvm_sev_ioctl(vm, KVM_SEV_INIT, NULL);
 
-- 
2.39.0.246.g2a6d74b583-goog

