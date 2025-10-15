Return-Path: <linux-kselftest+bounces-43258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C082BE04C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41D854648E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBA309DB0;
	Wed, 15 Oct 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOQlqytK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDE306B1C
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554856; cv=none; b=MPzCpZaTrJCro8hX9tOgrf9dB+xiih+yAEyg4Enl8buXjV+9CmtSRqR0LI1PqY4CuHYcsvUcvaas4yn9z+vdBMz/pFYiyu5QIyJoMgiWO9YBykWruZZJc6GVnOegf1RqZq8zs9dKaCv2UD1qKqXu/ShSSsDWWmvUHwJWmSwMl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554856; c=relaxed/simple;
	bh=1H/TAjStyaI6entLwQUNBGgnkdgglmJ5EvafY9K9xl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsnZVVWSVZ0cvTkLK2q41Dov3wdj2cUvVaEWxGv8lld8x4oDtyzTALDxMX1mAEXS1nZlFzVfjt5YLKaO0Uxqe3D5vNSjplYTRKzo92KSwm+OD0TKAeXH9pW9tKAuxiA7mHrNkkCI6VWiWcaNVsOkW09z/I8WC6KMEdLFHQFbRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOQlqytK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so9529656a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554854; x=1761159654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/50hzPJcz2Tgtv5Q95r1Wz9trycmcqvXu8eukDbYxw=;
        b=nOQlqytKfKqDbqgekUBKQYaPTWU8+8mhtxzQsEGATxZ3zCnoGIaMyt+sYGA5mpF6RC
         qCU8KFQAf/7UQG81ghuhznRYNrkudy3BxZa6r9UaqSfUxDQUDdKWyvOaAKxqqWFnksk7
         rDAut6Xc84/nibvyW3MBn6u9rI/yqMf783XMw4/DiCd4Q8cjassSvoTLz2sIzJ3AAPwA
         OPPQ3CIL3qH6W0F3fzpVCwV2LlAVQh4NFACQo49cX092tXHOc0vn7zcArEb7d6QJtMLB
         7MHgNlDvl8NAF33OdjL/n635sxf4bz54ojwl0yZyM0kwJSnvXqxrJxLJ3APbnrGMmvmn
         qTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554854; x=1761159654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/50hzPJcz2Tgtv5Q95r1Wz9trycmcqvXu8eukDbYxw=;
        b=u31dTXqdAqMYQkc8y20iWAygi9MewHDuDxBpUDsR8b1nVIR7Sttnr0/5QQTYx7EdfH
         RnvTlxHplMGdjglxBshqPY1tQu7FJk5Wady1EllmgB9kKdlJyFY0ankAMkRdddedNHiH
         VvKYP3N1/tkSDibqKJJ3VS5Z2qL5gKM/8lv3Xi1ru9YnjNm3NAYOEXkxB2qqR2Zag3cl
         dimAcFD4iUahpDEk76S/7OAnvJraBURWw6TH/D0ALGV8wC0CsHIXhrfHIMZ9QXnk0D02
         5SD5D45EKn2ve6SqP8Uw84axHmtNoMUIlcszAOUAsUGyEj+3Of82Y7To52BMI5m5sE+C
         jj4w==
X-Forwarded-Encrypted: i=1; AJvYcCWA/D8qlQsphWeGT8GWi18ylkTxjnedj3gh/MtecPFL9MmrF8OhgxNVa9gGWtbglQAZhJTW+8P0xJ4iVOYsTZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5XoMEsJlJdx5DFgJ4T/Wzcoi5HswIgoaCxdpBF4uZc9USV1i
	seMmGt1B1SHyy+Q/5xopnocAeKfbDbDbxB6QcMAkdXLjGCSJCbr2kEg6P5VlMnwi6/VKfCVzfU4
	faVYNQA==
X-Google-Smtp-Source: AGHT+IF0aq3dEuFrF7ECI0NlSr0qYUf7fzC5xMEvWlZqMU7mOZwkC2btj1VQ3xgFa8CghlVjLKHevu9vhKE=
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b81:b0:33b:6ef4:c904
 with SMTP id 98e67ed59e1d1-33b6ef4cbbcmr19120239a91.20.1760554853833; Wed, 15
 Oct 2025 12:00:53 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:58:57 +0000
In-Reply-To: <cover.1760551864.git.wyihan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760551864.git.wyihan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <0ec7349858142439ed0a250e6c04edf84cb0f488.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH RESEND 3/3] KVM: selftests: Test guest_memfd behavior with
 respect to stage 2 page tables
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test that
+ memory failure handling results in unmapping of bad memory from stage
  2 page tables, hence requiring faulting on next guest access
+ when the guest tries to fault a poisoned page from guest_memfd, the
  userspace VMM informed with EHWPOISON

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 7bcf8d2d5d4d..dc3398e22edd 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -539,6 +539,70 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void __guest_code_read(uint8_t *mem)
+{
+	READ_ONCE(*mem);
+	GUEST_DONE();
+}
+
+static void guest_read(struct kvm_vcpu *vcpu, uint64_t gpa, int expected_errno)
+{
+	vcpu_arch_set_entry_point(vcpu, __guest_code_read);
+	vcpu_args_set(vcpu, 1, gpa);
+
+	if (expected_errno) {
+		TEST_ASSERT_EQ(_vcpu_run(vcpu), -1);
+		TEST_ASSERT_EQ(errno, expected_errno);
+	} else {
+		vcpu_run(vcpu);
+		TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+	}
+}
+
+static void test_memory_failure_guest(void)
+{
+	const uint64_t gpa = SZ_4G;
+	const int slot = 1;
+
+	unsigned long memory_failure_pfn;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint8_t *mem;
+	size_t size;
+	int fd;
+
+	if (!kvm_has_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
+		return;
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, __guest_code_read);
+
+	size = vm->page_size;
+	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	virt_pg_map(vm, gpa, gpa);
+
+	/* Fault in page to read pfn, then unmap page for testing. */
+	READ_ONCE(*mem);
+	memory_failure_pfn = addr_to_pfn(mem);
+	munmap(mem, size);
+
+	/* Fault page into stage2 page tables. */
+	guest_read(vcpu, gpa, 0);
+
+	mark_memory_failure(memory_failure_pfn, 0);
+
+	guest_read(vcpu, gpa, EHWPOISON);
+	munmap(mem, size);
+
+	close(fd);
+	kvm_vm_free(vm);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -559,4 +623,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_memory_failure_guest();
 }
-- 
2.51.0.788.g6d19910ace-goog


