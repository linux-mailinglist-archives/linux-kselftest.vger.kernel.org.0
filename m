Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978CD773347
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHGXCL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHGXBy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BAE1980
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4df4a2c5dcso2711390276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449302; x=1692054102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IW9+7phTrNcYq8HIMw1g4ao4IX5+hFD7YSOVD/oAl3g=;
        b=lRc64pQIaYZ7xSk3fbOMPBysCdTiUIsS1N8aj5ot6y870kPcrhmGq6EX689PwpvC6c
         r+3FG7+ZLl9sG01Lna2L5/MI0yPhzsFRTa232T1QXVMQdLAmwfNA9KQfLlXgLKwrjV6u
         e9zTi51fogt3TFiPQ/sxpy2p4tOR4la0fHi25UB8g9U4Z1ABmDP13akxcAdgxabPbhiu
         hMHjYjuASVHBuT7I1d901Hwfx66g2ysoNw/6PIxj9juKx4sJe/R6gVJhmQo4oZRR/8Jx
         AcrYHQKHHH1zbx7kjJEvUHSsMfv6NEZHsBV2sGnO68q+TWNWk5PAs2myF6ECdgu5vC+A
         qmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449302; x=1692054102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IW9+7phTrNcYq8HIMw1g4ao4IX5+hFD7YSOVD/oAl3g=;
        b=N1uvZvHjhm6xwpW4Q8cRHiamVkq5+g/N1X90ZpW/kNO2c264xWAG2RuprqkkFW5521
         ZgNB8ED5cQEpJvJzLlwro1xnDEcJmftrVPVEgvZr37Ab1VHPTIcaQrrNPPEO9jZg3YS3
         70Sd1nMMaFQzU9SVG43dIACbRFnaRb1NfVGUN9UchUI5wh4xYZuV/G7aaxuFS8nYmLPf
         QTQ7O9qyBfEKdjKLSK5EkFYMpiA96QL4Lo7CCVUPuNOL0dAp7zQ7/Bo+6Yw4s1dQbsMM
         wMdpxNSo/n9LYNYSDbWAv27fyo11CY0Q4duWaUxMoetosoQ221WtqzegT7BeVmPJBSXQ
         T3eg==
X-Gm-Message-State: AOJu0YxRhzuFioBlp+hSm1HKrotqticaLIujTGOXqZ/tMvhqJO0WKfbj
        6UB//PrsnPVuTCFL5M/CRRkb21BmekFjKNHPXA==
X-Google-Smtp-Source: AGHT+IHnQnl/WBhgSM0BG08Pt+ebLjH0BX6N1+dd7zAhqYIJBwUob2vcylIjpnWOGmImXyE/f8SykoHA98RsioKi+g==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:69c9:0:b0:d51:577e:425d with SMTP
 id e192-20020a2569c9000000b00d51577e425dmr28980ybc.12.1691449302268; Mon, 07
 Aug 2023 16:01:42 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:10 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <b32d715cc8e03b8279c70a1a4d7b738f00b698bc.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 07/11] KVM: x86: Refactor common migration preparation
 code out of sev_vm_move_enc_context_from
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com,
        Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm/sev.c          | 33 ++++----------------------
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/x86.c              | 42 +++++++++++++++++++++++++++++----
 4 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bbefd79b7950..71c1236e4f18 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1711,7 +1711,7 @@ struct kvm_x86_ops {
 	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*mem_enc_unregister_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*vm_copy_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
-	int (*vm_move_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
+	int (*vm_move_enc_context_from)(struct kvm *kvm, struct kvm *source_kvm);
 	void (*guest_memory_reclaimed)(struct kvm *kvm);
 
 	int (*get_msr_feature)(struct kvm_msr_entry *entry);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3c4313417966..e0e206aa3e62 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1718,35 +1718,15 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	return 0;
 }
 
-int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
+int sev_vm_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm)
 {
 	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
 	struct kvm_sev_info *src_sev, *cg_cleanup_sev;
-	struct fd f = fdget(source_fd);
-	struct kvm *source_kvm;
 	bool charged = false;
 	int ret;
 
-	if (!f.file)
-		return -EBADF;
-
-	if (!file_is_kvm(f.file)) {
-		ret = -EBADF;
-		goto out_fput;
-	}
-
-	source_kvm = f.file->private_data;
-	ret = kvm_mark_migration_in_progress(kvm, source_kvm);
-	if (ret)
-		goto out_fput;
-	ret = kvm_lock_two_vms(kvm, source_kvm);
-	if (ret)
-		goto out_mark_migration_done;
-
-	if (sev_guest(kvm) || !sev_guest(source_kvm)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	if (sev_guest(kvm) || !sev_guest(source_kvm))
+		return -EINVAL;
 
 	src_sev = &to_kvm_svm(source_kvm)->sev_info;
 
@@ -1785,12 +1765,7 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		sev_misc_cg_uncharge(cg_cleanup_sev);
 	put_misc_cg(cg_cleanup_sev->misc_cg);
 	cg_cleanup_sev->misc_cg = NULL;
-out_mark_migration_done:
-	kvm_mark_migration_done(kvm, source_kvm);
-out_unlock:
-	kvm_unlock_two_vms(kvm, source_kvm);
-out_fput:
-	fdput(f);
+
 	return ret;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d306e2312b53..4912ac28a3d8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -721,7 +721,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 int sev_mem_enc_unregister_region(struct kvm *kvm,
 				  struct kvm_enc_region *range);
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd);
-int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd);
+int sev_vm_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm);
 void sev_guest_memory_reclaimed(struct kvm *kvm);
 
 void pre_sev_run(struct vcpu_svm *svm, int cpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 494b75ef7197..75d48379d94d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6325,6 +6325,42 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 	return 0;
 }
 
+static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
+{
+	int r;
+	struct kvm *source_kvm;
+	struct fd f = fdget(source_fd);
+
+	r = -EBADF;
+	if (!f.file)
+		return r;
+
+	if (!file_is_kvm(f.file))
+		goto out_fdput;
+
+	r = -EINVAL;
+	source_kvm = f.file->private_data;
+	if (kvm->arch.vm_type != source_kvm->arch.vm_type)
+		goto out_fdput;
+
+	r = kvm_mark_migration_in_progress(kvm, source_kvm);
+	if (r)
+		goto out_fdput;
+
+	r = kvm_lock_two_vms(kvm, source_kvm);
+	if (r)
+		goto out_mark_migration_done;
+
+	r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
+
+	kvm_unlock_two_vms(kvm, source_kvm);
+out_mark_migration_done:
+	kvm_mark_migration_done(kvm, source_kvm);
+out_fdput:
+	fdput(f);
+	return r;
+}
+
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -6463,11 +6499,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = static_call(kvm_x86_vm_copy_enc_context_from)(kvm, cap->args[0]);
 		break;
 	case KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM:
-		r = -EINVAL;
-		if (!kvm_x86_ops.vm_move_enc_context_from)
-			break;
-
-		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, cap->args[0]);
+		r = kvm_vm_move_enc_context_from(kvm, cap->args[0]);
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
 		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
-- 
2.41.0.640.ga95def55d0-goog

