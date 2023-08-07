Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94049773354
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHGXCl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjHGXCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:02:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200341FC9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f04ffa3eso65814187b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449308; x=1692054108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGhoZooqadODHcw0sKitGtx/x1DrGCR27u12EaEc5Bk=;
        b=u3QTOXFm9OBaQwq6T7BIR0Q+bo9nIq4PtS/Gtd/NlHHiWA75p5FU8hLg8GrlR6JTSv
         nrusB4nabH9ryjjrQ7I4j9ROJwbZwrwaKsa8CrPgwuOHhP50Y2KDNbdKPKpX/fHRxy81
         G8RPWfOA4YE/Udx3DhY8BK1fLBC2SonctbBdOi6o84iJ+7a8JiOh30rt/h754ZQc7yWk
         LP4WzrMp9p9au1SC/1Ig3p5XCFuAMSYSvdPpx8/fYaKAOITQKfm/VVAGfP5UzJ/k0fUc
         apGgcpo18O21U9BdUL1r9W5BQRH6jcGHUToKZe3ZTopV/Wh3lIbtQjTKs60PD2anls+p
         7EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449308; x=1692054108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGhoZooqadODHcw0sKitGtx/x1DrGCR27u12EaEc5Bk=;
        b=IR68UY/rMXGc6p4M6LL54SEppP9ycMbwkchJc+PVuiuxis/s3ZAIj9w/7AvTjm8Gco
         80zAueDTsL9A84L0ep/i3BfxvVZv6ORU7LtF6yNvL0CHVKopEMvrgg13f6aEknWo7tWI
         q35GZ6ZkaG3RSfzbe5ArBkujlhHGhuFMOpNo7nZTNqU7Giy4grcrQR8Cw+96s1oSWK0t
         yTkoNbON/ffUOBOmwVfEFG5GL5HQROrXmhUneaZqyERuLpO1jZB2Xk8+E1kkWBZrzgO2
         MiH0Gol+Oq8ksNmAL3ir6Lvv9au+QA8WvPF7x7Dl8Pg+T5basXD/hYPL+thfEu2GVd51
         JyfQ==
X-Gm-Message-State: AOJu0Yz4++2RUz46ZT5pH+AqyC3eIcFc+D9MLmR/4M/nu3hzkR8U3Y8M
        O46KpNuBfA6YsoGF/ZzNLCSOh//mXX2usyXbIQ==
X-Google-Smtp-Source: AGHT+IH9f9RoYdTDwcLqKlgV75d0SH2uiiILMo3c1b9SEmL2dgda9SBOo94a94VqNiHt5g21Tkl3iy4Z5sOB9n5Vpg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:8052:0:b0:d3d:74b6:e085 with SMTP
 id a18-20020a258052000000b00d3d74b6e085mr61692ybn.8.1691449308117; Mon, 07
 Aug 2023 16:01:48 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:13 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <6244c632343298a1ee785a20f3eb6d6b1f3d3e0a.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 10/11] KVM: selftests: Generalize migration functions from sev_migrate_tests.c
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
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
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

These functions will be used in private (guest mem) migration tests.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 13 +++++
 .../selftests/kvm/x86_64/sev_migrate_tests.c  | 48 +++++++------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 868925b26a7b..af6ebead5bc3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -331,6 +331,19 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+static inline int __vm_migrate_from(struct kvm_vm *dst, struct kvm_vm *src)
+{
+	return __vm_enable_cap(dst, KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM, src->fd);
+}
+
+static inline void vm_migrate_from(struct kvm_vm *dst, struct kvm_vm *src)
+{
+	int ret;
+
+	ret = __vm_migrate_from(dst, src);
+	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d\n", ret, errno);
+}
+
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index c7ef97561038..cee8219fe8d2 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -80,20 +80,6 @@ static struct kvm_vm *aux_vm_create(bool with_vcpus)
 	return vm;
 }
 
-static int __sev_migrate_from(struct kvm_vm *dst, struct kvm_vm *src)
-{
-	return __vm_enable_cap(dst, KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM, src->fd);
-}
-
-
-static void sev_migrate_from(struct kvm_vm *dst, struct kvm_vm *src)
-{
-	int ret;
-
-	ret = __sev_migrate_from(dst, src);
-	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d\n", ret, errno);
-}
-
 static void test_sev_migrate_from(bool es)
 {
 	struct kvm_vm *src_vm;
@@ -105,13 +91,13 @@ static void test_sev_migrate_from(bool es)
 		dst_vms[i] = aux_vm_create(true);
 
 	/* Initial migration from the src to the first dst. */
-	sev_migrate_from(dst_vms[0], src_vm);
+	vm_migrate_from(dst_vms[0], src_vm);
 
 	for (i = 1; i < NR_MIGRATE_TEST_VMS; i++)
-		sev_migrate_from(dst_vms[i], dst_vms[i - 1]);
+		vm_migrate_from(dst_vms[i], dst_vms[i - 1]);
 
 	/* Migrate the guest back to the original VM. */
-	ret = __sev_migrate_from(src_vm, dst_vms[NR_MIGRATE_TEST_VMS - 1]);
+	ret = __vm_migrate_from(src_vm, dst_vms[NR_MIGRATE_TEST_VMS - 1]);
 	TEST_ASSERT(ret == -1 && errno == EIO,
 		    "VM that was migrated from should be dead. ret %d, errno: %d\n", ret,
 		    errno);
@@ -133,7 +119,7 @@ static void *locking_test_thread(void *arg)
 
 	for (i = 0; i < NR_LOCK_TESTING_ITERATIONS; ++i) {
 		j = i % NR_LOCK_TESTING_THREADS;
-		__sev_migrate_from(input->vm, input->source_vms[j]);
+		__vm_migrate_from(input->vm, input->source_vms[j]);
 	}
 
 	return NULL;
@@ -170,7 +156,7 @@ static void test_sev_migrate_parameters(void)
 
 	vm_no_vcpu = vm_create_barebones();
 	vm_no_sev = aux_vm_create(true);
-	ret = __sev_migrate_from(vm_no_vcpu, vm_no_sev);
+	ret = __vm_migrate_from(vm_no_vcpu, vm_no_sev);
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "Migrations require SEV enabled. ret %d, errno: %d\n", ret,
 		    errno);
@@ -184,25 +170,25 @@ static void test_sev_migrate_parameters(void)
 	sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
 	__vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
-	ret = __sev_migrate_from(sev_vm, sev_es_vm);
+	ret = __vm_migrate_from(sev_vm, sev_es_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"Should not be able migrate to SEV enabled VM. ret: %d, errno: %d\n",
 		ret, errno);
 
-	ret = __sev_migrate_from(sev_es_vm, sev_vm);
+	ret = __vm_migrate_from(sev_es_vm, sev_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"Should not be able migrate to SEV-ES enabled VM. ret: %d, errno: %d\n",
 		ret, errno);
 
-	ret = __sev_migrate_from(vm_no_vcpu, sev_es_vm);
+	ret = __vm_migrate_from(vm_no_vcpu, sev_es_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"SEV-ES migrations require same number of vCPUS. ret: %d, errno: %d\n",
 		ret, errno);
 
-	ret = __sev_migrate_from(vm_no_vcpu, sev_es_vm_no_vmsa);
+	ret = __vm_migrate_from(vm_no_vcpu, sev_es_vm_no_vmsa);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"SEV-ES migrations require UPDATE_VMSA. ret %d, errno: %d\n",
@@ -355,14 +341,14 @@ static void test_sev_move_copy(void)
 
 	sev_mirror_create(mirror_vm, sev_vm);
 
-	sev_migrate_from(dst_mirror_vm, mirror_vm);
-	sev_migrate_from(dst_vm, sev_vm);
+	vm_migrate_from(dst_mirror_vm, mirror_vm);
+	vm_migrate_from(dst_vm, sev_vm);
 
-	sev_migrate_from(dst2_vm, dst_vm);
-	sev_migrate_from(dst2_mirror_vm, dst_mirror_vm);
+	vm_migrate_from(dst2_vm, dst_vm);
+	vm_migrate_from(dst2_mirror_vm, dst_mirror_vm);
 
-	sev_migrate_from(dst3_mirror_vm, dst2_mirror_vm);
-	sev_migrate_from(dst3_vm, dst2_vm);
+	vm_migrate_from(dst3_mirror_vm, dst2_mirror_vm);
+	vm_migrate_from(dst3_vm, dst2_vm);
 
 	kvm_vm_free(dst_vm);
 	kvm_vm_free(sev_vm);
@@ -384,8 +370,8 @@ static void test_sev_move_copy(void)
 
 	sev_mirror_create(mirror_vm, sev_vm);
 
-	sev_migrate_from(dst_mirror_vm, mirror_vm);
-	sev_migrate_from(dst_vm, sev_vm);
+	vm_migrate_from(dst_mirror_vm, mirror_vm);
+	vm_migrate_from(dst_vm, sev_vm);
 
 	kvm_vm_free(mirror_vm);
 	kvm_vm_free(dst_mirror_vm);
-- 
2.41.0.640.ga95def55d0-goog

