Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64F773343
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjHGXCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHGXBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3281724
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5868992ddd4so58814227b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449300; x=1692054100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+4P4F8zMt4Dd2qn/DvvFJFWH4ILq58+E3D5i6R7pxU=;
        b=Q0k0MahZIE5dc0IRAXJwKTTZDSg3cZi9yWSlFQHuosf4l1pwmxjRYMo/MoeQmihaZF
         /Y2YJV0eCS16QuqY2J5LouzDTRRKPh36yzofSbiHq1fXkCRSrQHQ60fAySXo3XtnWoEE
         gCtigQEluVr3pUX7NMZgK3pdcWTNlmRFpkspeMWfxJty8wvX3j7UJaM07bfYOvR23gEO
         qadalUmfqPjBKRKKKfUdB/qrNcPo7nYwsM3FclpqeHCX7Li+9n1WiMkWpTTGRnw9J5sl
         sd+kNZfSjZyU2B3lWLOyXRhsh30tsMnrORLG9tJPdD0PiRGac+EO0SELHeX9PQUK8o7z
         Lm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449300; x=1692054100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+4P4F8zMt4Dd2qn/DvvFJFWH4ILq58+E3D5i6R7pxU=;
        b=HQDIG5W113H4JHNKkhcMkseEPCo3oyIPXv+lH9JEIYK7NgeqdFxRzwkCcUHzcpUJdw
         Jo+ApYbcsdYnNjTr0CDcnyXZQriNIL3zT5ELZIv6ChI4ucPZjq9MHOMXYVG/DFcQn37o
         X2UprXOd+Zt9z0Y3o0UMBq1mZW562cSZPvXiDCusq6HpuVrmT+vIf7sTH3uSVHOrXF9c
         TEwW9NWm4a7FSzg1wFQnQkmdPQofb2zF7qr8EbCmHiM9o/9v5NEJ4NxYxRcvvSogUp5L
         F1fausrTd0MXAFZcwUS1T+9p0dgkyBUloWYnprPAQ+dUmLtGeCNqcECKAlJcMPBKRBno
         qjcA==
X-Gm-Message-State: AOJu0YzHVQPk6YicegZkni3qDEtThPbjvu5hcdKK8hjql+h1MBPjVFaH
        qrgcZkbo93Frg37kp+uRxp6LzP/4pBOuUDfe1w==
X-Google-Smtp-Source: AGHT+IHC/bXPExjJXROsLpCwLAALYI0hnMQCZ2IOPhDw3Q9QpEGX9jq+kjJcUdk7vT3m1m3a/pU0JCUarVvYuN8xkw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:ac07:0:b0:583:5471:1717 with SMTP
 id k7-20020a81ac07000000b0058354711717mr89606ywh.10.1691449300448; Mon, 07
 Aug 2023 16:01:40 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:09 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <f5770fbc9ca5a4ddbf8e1f4b10475dc3dc8503c2.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 06/11] KVM: x86: Refactor common code out of sev.c
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split sev_lock_two_vms() into kvm_mark_migration_in_progress() and
kvm_lock_two_vms() and refactor sev.c to use these two new functions.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 59 ++++++++++------------------------------
 arch/x86/kvm/x86.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h     |  6 ++++
 3 files changed, 82 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 725289b523c7..3c4313417966 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1554,47 +1554,6 @@ static bool is_cmd_allowed_from_mirror(u32 cmd_id)
 	return false;
 }
 
-static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
-{
-	int r = -EBUSY;
-
-	if (dst_kvm == src_kvm)
-		return -EINVAL;
-
-	/*
-	 * Bail if these VMs are already involved in a migration to avoid
-	 * deadlock between two VMs trying to migrate to/from each other.
-	 */
-	if (atomic_cmpxchg_acquire(&dst_kvm->migration_in_progress, 0, 1))
-		return -EBUSY;
-
-	if (atomic_cmpxchg_acquire(&src_kvm->migration_in_progress, 0, 1))
-		goto release_dst;
-
-	r = -EINTR;
-	if (mutex_lock_killable(&dst_kvm->lock))
-		goto release_src;
-	if (mutex_lock_killable_nested(&src_kvm->lock, SINGLE_DEPTH_NESTING))
-		goto unlock_dst;
-	return 0;
-
-unlock_dst:
-	mutex_unlock(&dst_kvm->lock);
-release_src:
-	atomic_set_release(&src_kvm->migration_in_progress, 0);
-release_dst:
-	atomic_set_release(&dst_kvm->migration_in_progress, 0);
-	return r;
-}
-
-static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
-{
-	mutex_unlock(&dst_kvm->lock);
-	mutex_unlock(&src_kvm->lock);
-	atomic_set_release(&dst_kvm->migration_in_progress, 0);
-	atomic_set_release(&src_kvm->migration_in_progress, 0);
-}
-
 /* vCPU mutex subclasses.  */
 enum sev_migration_role {
 	SEV_MIGRATION_SOURCE = 0,
@@ -1777,9 +1736,12 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	}
 
 	source_kvm = f.file->private_data;
-	ret = sev_lock_two_vms(kvm, source_kvm);
+	ret = kvm_mark_migration_in_progress(kvm, source_kvm);
 	if (ret)
 		goto out_fput;
+	ret = kvm_lock_two_vms(kvm, source_kvm);
+	if (ret)
+		goto out_mark_migration_done;
 
 	if (sev_guest(kvm) || !sev_guest(source_kvm)) {
 		ret = -EINVAL;
@@ -1823,8 +1785,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		sev_misc_cg_uncharge(cg_cleanup_sev);
 	put_misc_cg(cg_cleanup_sev->misc_cg);
 	cg_cleanup_sev->misc_cg = NULL;
+out_mark_migration_done:
+	kvm_mark_migration_done(kvm, source_kvm);
 out_unlock:
-	sev_unlock_two_vms(kvm, source_kvm);
+	kvm_unlock_two_vms(kvm, source_kvm);
 out_fput:
 	fdput(f);
 	return ret;
@@ -2057,9 +2021,12 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	}
 
 	source_kvm = f.file->private_data;
-	ret = sev_lock_two_vms(kvm, source_kvm);
+	ret = kvm_mark_migration_in_progress(kvm, source_kvm);
 	if (ret)
 		goto e_source_fput;
+	ret = kvm_lock_two_vms(kvm, source_kvm);
+	if (ret)
+		goto e_mark_migration_done;
 
 	/*
 	 * Mirrors of mirrors should work, but let's not get silly.  Also
@@ -2100,7 +2067,9 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 */
 
 e_unlock:
-	sev_unlock_two_vms(kvm, source_kvm);
+	kvm_unlock_two_vms(kvm, source_kvm);
+e_mark_migration_done:
+	kvm_mark_migration_done(kvm, source_kvm);
 e_source_fput:
 	fdput(f);
 	return ret;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index de195ad83ec0..494b75ef7197 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4340,6 +4340,68 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr_common);
 
+int kvm_mark_migration_in_progress(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	int r;
+
+	if (dst_kvm == src_kvm)
+		return -EINVAL;
+
+	/*
+	 * Bail if these VMs are already involved in a migration to avoid
+	 * deadlock between two VMs trying to migrate to/from each other.
+	 */
+	r = -EBUSY;
+	if (atomic_cmpxchg_acquire(&dst_kvm->migration_in_progress, 0, 1))
+		return r;
+
+	if (atomic_cmpxchg_acquire(&src_kvm->migration_in_progress, 0, 1))
+		goto release_dst;
+
+	return 0;
+
+release_dst:
+	atomic_set_release(&dst_kvm->migration_in_progress, 0);
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_mark_migration_in_progress);
+
+void kvm_mark_migration_done(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	atomic_set_release(&dst_kvm->migration_in_progress, 0);
+	atomic_set_release(&src_kvm->migration_in_progress, 0);
+}
+EXPORT_SYMBOL_GPL(kvm_mark_migration_done);
+
+int kvm_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	int r;
+
+	if (dst_kvm == src_kvm)
+		return -EINVAL;
+
+	r = -EINTR;
+	if (mutex_lock_killable(&dst_kvm->lock))
+		return r;
+
+	if (mutex_lock_killable_nested(&src_kvm->lock, SINGLE_DEPTH_NESTING))
+		goto unlock_dst;
+
+	return 0;
+
+unlock_dst:
+	mutex_unlock(&dst_kvm->lock);
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_lock_two_vms);
+
+void kvm_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	mutex_unlock(&dst_kvm->lock);
+	mutex_unlock(&src_kvm->lock);
+}
+EXPORT_SYMBOL_GPL(kvm_unlock_two_vms);
+
 /*
  * Read or write a bunch of msrs. All parameters are kernel addresses.
  *
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 82e3dafc5453..4c6edaf5ac5b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -539,4 +539,10 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
 			 unsigned int port, void *data,  unsigned int count,
 			 int in);
 
+int kvm_mark_migration_in_progress(struct kvm *dst_kvm, struct kvm *src_kvm);
+void kvm_mark_migration_done(struct kvm *dst_kvm, struct kvm *src_kvm);
+
+int kvm_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm);
+void kvm_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm);
+
 #endif
-- 
2.41.0.640.ga95def55d0-goog

