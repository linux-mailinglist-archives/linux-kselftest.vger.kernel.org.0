Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9F77333E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjHGXBz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHGXBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393B1710
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso4295051a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449298; x=1692054098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQQ9HxwXisHRcLOUmLrJOKcqzoMdHrdIoIQ6IecTXIw=;
        b=twH1EXTprHGVwETfKOR51WQSclQGswbqnS6IDXUASDrraJoaBBJYcSIr+OJT2dIZJR
         leBiyKihkh50aLALvTrdxF+IKAJ3jFcttX4/CKOLWxYHPK/Hq89n7DG+SBlYwcID3qdF
         r93db5otOGAqx3LNRu2anFQex0nM0yDk4Ocl4C3YoZtmkh0ZpAu9rG9vF8Ge7lA2vx6I
         txWNeQ43dVlLxzHcjvUKfuL1Y8dBqKNMZLPnHXBO368htDjuIqSLeQJbC51Wv+IDGGQX
         gOucjyOb8r/lQtjAMCpy64pvNfNhbplU+k6NXtECSvjvhj9qtAksadi1TPZipdkllAL2
         VucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449298; x=1692054098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQQ9HxwXisHRcLOUmLrJOKcqzoMdHrdIoIQ6IecTXIw=;
        b=JZgwDLtU78bSzXqIudihoNTAfr7tqjo8XPCrycOQ/unUuCtfe6Njola2qrFyTFOu4q
         iFqGK1V0KAVQuKKn3S1PnTsXu1zlVqYv4drhYdk+JT/sPHxRfkLBB7VmHC2zcV6ygFF/
         p2HgM1Q+0YidMhzOF0/K7HeE5iRIIEXuU5ajMamLuOD9BrRfaT0y5vlGzatIjSaKicVw
         GYjM+De56uOTuYKhzXmCv6jni6KR+woDeLHzh65YZ7g2rSakp6aJvGFpMo2/zGH7yck+
         jQm5FbXQHTuhf0eh8XBFmdQHaiOXw3We9eAO+nHkIfNp3vuHm5QEtWQS0QOpFSSnluEi
         pFyw==
X-Gm-Message-State: AOJu0YyDXlkqt2Yvy/S0ctQf3XS3t00YD4kR0/oRXZGpthMki3HKBU6K
        6VX8OgK+Gapc8jRxLbbMGJQ80zhLABKq0z0bAg==
X-Google-Smtp-Source: AGHT+IFl+V5hav9OEzCEyrerIZ0f25Av5tTYJlIA3LgxqYATB6cN3FKketKmrAM4bjvMcGk+n/Bq9UjqJvwkgCrNng==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:314c:b0:267:f245:85f1 with
 SMTP id ip12-20020a17090b314c00b00267f24585f1mr86267pjb.1.1691449298375; Mon,
 07 Aug 2023 16:01:38 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:08 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <5a869a885bb3a74bd77222f75dedcbace266e4cc.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/11] KVM: x86: Refactor sev's flag migration_in_progress
 to kvm struct
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

The migration_in_progress flag will also be needed for migration of
non-sev VMs.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c   | 17 ++++++-----------
 arch/x86/kvm/svm/svm.h   |  1 -
 include/linux/kvm_host.h |  1 +
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 07756b7348ae..725289b523c7 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1556,8 +1556,6 @@ static bool is_cmd_allowed_from_mirror(u32 cmd_id)
 
 static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 {
-	struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
-	struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
 	int r = -EBUSY;
 
 	if (dst_kvm == src_kvm)
@@ -1567,10 +1565,10 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 	 * Bail if these VMs are already involved in a migration to avoid
 	 * deadlock between two VMs trying to migrate to/from each other.
 	 */
-	if (atomic_cmpxchg_acquire(&dst_sev->migration_in_progress, 0, 1))
+	if (atomic_cmpxchg_acquire(&dst_kvm->migration_in_progress, 0, 1))
 		return -EBUSY;
 
-	if (atomic_cmpxchg_acquire(&src_sev->migration_in_progress, 0, 1))
+	if (atomic_cmpxchg_acquire(&src_kvm->migration_in_progress, 0, 1))
 		goto release_dst;
 
 	r = -EINTR;
@@ -1583,21 +1581,18 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 unlock_dst:
 	mutex_unlock(&dst_kvm->lock);
 release_src:
-	atomic_set_release(&src_sev->migration_in_progress, 0);
+	atomic_set_release(&src_kvm->migration_in_progress, 0);
 release_dst:
-	atomic_set_release(&dst_sev->migration_in_progress, 0);
+	atomic_set_release(&dst_kvm->migration_in_progress, 0);
 	return r;
 }
 
 static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 {
-	struct kvm_sev_info *dst_sev = &to_kvm_svm(dst_kvm)->sev_info;
-	struct kvm_sev_info *src_sev = &to_kvm_svm(src_kvm)->sev_info;
-
 	mutex_unlock(&dst_kvm->lock);
 	mutex_unlock(&src_kvm->lock);
-	atomic_set_release(&dst_sev->migration_in_progress, 0);
-	atomic_set_release(&src_sev->migration_in_progress, 0);
+	atomic_set_release(&dst_kvm->migration_in_progress, 0);
+	atomic_set_release(&src_kvm->migration_in_progress, 0);
 }
 
 /* vCPU mutex subclasses.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 18af7e712a5a..d306e2312b53 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -87,7 +87,6 @@ struct kvm_sev_info {
 	struct list_head mirror_vms; /* List of VMs mirroring */
 	struct list_head mirror_entry; /* Use as a list entry of mirrors */
 	struct misc_cg *misc_cg; /* For misc cgroup accounting */
-	atomic_t migration_in_progress;
 };
 
 struct kvm_svm {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 091bc89ae805..3e03eeca279f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -842,6 +842,7 @@ struct kvm {
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	struct xarray mem_attr_array;
 #endif
+	atomic_t migration_in_progress;
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
 
-- 
2.41.0.640.ga95def55d0-goog

