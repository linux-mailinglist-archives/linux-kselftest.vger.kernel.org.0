Return-Path: <linux-kselftest+bounces-33221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4FABA3AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690291C03179
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C22283CA7;
	Fri, 16 May 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0LJvHI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E5283152
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423208; cv=none; b=WGJfZPCoVsCnVMxMGg/X10iu0o8i8ndGIc7m6MwJB2zc3/mzWYqDBJgjHbSdUhiNUlOmtqHGw4kpqcN09dDLzZE//5T4sVx7sjNZ7ThG6svkSnpn1otxmUkOknZqH/lnVaKncvsKdzHgU0N4hdKIzmm8FcUMszc52NEdu8RZklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423208; c=relaxed/simple;
	bh=3na7WazeRc+l31ZBLq7zu/XN2+gl6KLApYKpDXRt1DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lZxSbOY7N87GjD5AYBIvyqy2iAyK6sFk2eAEJo+cpNQ+unKqwiAAHRmgnc9ll2p7BYylBBD3r1T/0sxvdfviDjDP/+9xEX4LJfzqt3rCYyxMLWfPb0GopoHEqJbyHEHscJGN7hWqzd6CtOmCV2jkQ0O0aBPLsC/VeM+jcrp3hb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0LJvHI6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so1530578a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423206; x=1748028006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBw7wfCdEYmTTv4xHtm1PEmGnm1jL6beLce2NlL5Vts=;
        b=G0LJvHI6fg2EFuD7Dgnu6JG410A49xGI5HqV7DEQ6mKGc8bzqRrv9uo7lmWF1xPL/L
         H4yfefuKxG7dBWnkbajg5zSgAwp4zLNX8xoW9+TRTPdkFfOmFtcAo/nnKgMnI6oJ4Ybf
         RkAgEg13vy8CMWArUnNn23vAyrdnQq9OPEBigBBvl1d0RIA6pk6YvmZQ0oH33wEQjQcN
         YRe5EX46ifFBs8t6LwKQrNS0ycFd2u10/0L6Y7tm4wTlSXpmS1mo8krcYqA0L639vc4Y
         cNSxwC4PsJdGgUJrKUMcJNqx19L2qEMIfFEYPf2mhOi7pzSHGzbn+2WU3edEvprNr5jN
         6gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423206; x=1748028006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBw7wfCdEYmTTv4xHtm1PEmGnm1jL6beLce2NlL5Vts=;
        b=BXvCL62NwtUbYS+jVUDaR2KaozYHwscbH9T/MfmQJpVriLSf1dO8qhveW1XrSH4dl/
         1vXUeR/8lJ4Y6Iuvx9r7eFhgsnaDnXeuAqkusO+Kth5oQOoGWrfFTbU9SwLkcp+gajje
         ryJlvZb7XgFQVivamLrm0c7KTGJt92R9kZ86UTgOHxLz33Gk5UeAdaMsZNTxtFdcHyz4
         71+1Mu7GTbSIrTzNEhzO4LBXyt00gqifPjogDYP8GyINO9o3+/6q1Q1jGdGHVU8YP7L2
         u3hpoTCDkDxCEKvf/nlW8wg1HpN4leZfvMP/7vaRkq2xEp1vu+NSRP/4+lKhSdmIKKJR
         RX/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9r0Er4XvFIHzGxSOPFVCORrILuNDd0f/W8tZNSBM33C+WcH1DGv5XKYL78Lx25j6tADSbxWXmvvxonhp9X0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzefBf7pRUYGjAfGyVIdUZegyeIvNsibTEvUtDR6bSavmI6NuZ
	Xp1GHzg0KywtWFrC6aeBf3OqW0ezu1uv9QdGoazoyLO+UJoAUt6zIiD6MrUl4VSrwJ34qV7tr0l
	XvwjVle5esg==
X-Google-Smtp-Source: AGHT+IFy+jT+27vVJgz7R2oehTji+RlKiv3+uUc/6owtg1K9ubfV5NHggyHzsM0M3NoRAMEDy2BAnXhRN7jv
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:2fa:1fac:2695])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a83:b0:2ee:8e75:4aeb
 with SMTP id 98e67ed59e1d1-30e8313d1d5mr6376058a91.17.1747423206206; Fri, 16
 May 2025 12:20:06 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:32 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <8a479dcaa271976e784d8b592e75d883a2c7721a.1747368093.git.afranji@google.com>
Subject: [RFC PATCH v2 12/13] KVM: selftests: Generalize migration functions
 from sev_migrate_tests.c
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

These functions will be used in private (guest mem) migration tests.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 13 +++++
 .../selftests/kvm/x86/sev_migrate_tests.c     | 48 +++++++------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 68faa658b69e..80375d6456a5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -378,6 +378,19 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
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
diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0a6dfba3905b..905cdf9b39b1 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -56,20 +56,6 @@ static struct kvm_vm *aux_vm_create(bool with_vcpus)
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
-	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d", ret, errno);
-}
-
 static void test_sev_migrate_from(bool es)
 {
 	struct kvm_vm *src_vm;
@@ -81,13 +67,13 @@ static void test_sev_migrate_from(bool es)
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
 		    "VM that was migrated from should be dead. ret %d, errno: %d", ret,
 		    errno);
@@ -109,7 +95,7 @@ static void *locking_test_thread(void *arg)
 
 	for (i = 0; i < NR_LOCK_TESTING_ITERATIONS; ++i) {
 		j = i % NR_LOCK_TESTING_THREADS;
-		__sev_migrate_from(input->vm, input->source_vms[j]);
+		__vm_migrate_from(input->vm, input->source_vms[j]);
 	}
 
 	return NULL;
@@ -146,7 +132,7 @@ static void test_sev_migrate_parameters(void)
 
 	vm_no_vcpu = vm_create_barebones();
 	vm_no_sev = aux_vm_create(true);
-	ret = __sev_migrate_from(vm_no_vcpu, vm_no_sev);
+	ret = __vm_migrate_from(vm_no_vcpu, vm_no_sev);
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "Migrations require SEV enabled. ret %d, errno: %d", ret,
 		    errno);
@@ -160,25 +146,25 @@ static void test_sev_migrate_parameters(void)
 	sev_es_vm_init(sev_es_vm_no_vmsa);
 	__vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
-	ret = __sev_migrate_from(sev_vm, sev_es_vm);
+	ret = __vm_migrate_from(sev_vm, sev_es_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"Should not be able migrate to SEV enabled VM. ret: %d, errno: %d",
 		ret, errno);
 
-	ret = __sev_migrate_from(sev_es_vm, sev_vm);
+	ret = __vm_migrate_from(sev_es_vm, sev_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"Should not be able migrate to SEV-ES enabled VM. ret: %d, errno: %d",
 		ret, errno);
 
-	ret = __sev_migrate_from(vm_no_vcpu, sev_es_vm);
+	ret = __vm_migrate_from(vm_no_vcpu, sev_es_vm);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"SEV-ES migrations require same number of vCPUS. ret: %d, errno: %d",
 		ret, errno);
 
-	ret = __sev_migrate_from(vm_no_vcpu, sev_es_vm_no_vmsa);
+	ret = __vm_migrate_from(vm_no_vcpu, sev_es_vm_no_vmsa);
 	TEST_ASSERT(
 		ret == -1 && errno == EINVAL,
 		"SEV-ES migrations require UPDATE_VMSA. ret %d, errno: %d",
@@ -331,14 +317,14 @@ static void test_sev_move_copy(void)
 
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
@@ -360,8 +346,8 @@ static void test_sev_move_copy(void)
 
 	sev_mirror_create(mirror_vm, sev_vm);
 
-	sev_migrate_from(dst_mirror_vm, mirror_vm);
-	sev_migrate_from(dst_vm, sev_vm);
+	vm_migrate_from(dst_mirror_vm, mirror_vm);
+	vm_migrate_from(dst_vm, sev_vm);
 
 	kvm_vm_free(mirror_vm);
 	kvm_vm_free(dst_mirror_vm);
-- 
2.49.0.1101.gccaa498523-goog


