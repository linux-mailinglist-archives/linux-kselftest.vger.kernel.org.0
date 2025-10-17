Return-Path: <linux-kselftest+bounces-43423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615DBEB893
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11595422F71
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6F334C1F;
	Fri, 17 Oct 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P66EMg5Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AA3328FF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731987; cv=none; b=Z3acUAfO7k3xNDCAyynoG0hBmIPhd5ySs+y3EkVg6NLA2U8K3bHZNU6E8EZTHTuEPDJSl/Cgn+b6dG9r58gkQefC2pWx1Of6mAABNO1Shk17/h2dJVQtNo2JKHqd28IJxDEFTCoGFGmhN23LCIE8w73EXazIRPFsgIy7ffgib24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731987; c=relaxed/simple;
	bh=bCJw2vnTIene4U3RIEIWTIRpkJELkcIUCnZ1ynqibN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cbfrg4Pm3jpZMS6Nzl8eLJOwygrBQa5ole9NsG3EMO41jWxhLY5SUd3Lh0A8ZHEkjFCYHYhkKaX9uABlq67RXBSfDJCDkKL8AebELTo9YEGdETQDNOhNzaQiRSAGpYQ79RFG4YuosWkRki1ShaXsAgeVKdwXlyvsXK48e79Kpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P66EMg5Y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so26393635ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731979; x=1761336779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih7eFB1ZnHzojALYCX2+JZp6RL2OYThUFb2eXCv9Q4s=;
        b=P66EMg5YMP/hySGMZO5YKKgHnHvJKJcAKA41pMfslDCcfFgIh7WD3rCr8ecoQ8hqmf
         dtqU5Bw8NDgG53vu8+xTCy7JjXBR67Tie20ylI2pvRvpOLMCbW6CRnCdiVmXy/jV+uKz
         po81z2lKwUDSD1ZaYrovRLYv0PSZlXx9O2RIOXiDQ/XmdqjkpLcWF21Hz9EnCJnrGh9S
         apAVzfaGPFzx4fVaycbJNK+NXNlKABtZxg/PAC/yG9PWeySAolsklj/Gp4spVE3kVOpT
         byHbf6IvqrmA8Czk4a5N4AO6VK/mNBcGsqTBEAf3Igl3xLG2VSbUQyz1kkgD33vvGPma
         Tq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731979; x=1761336779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih7eFB1ZnHzojALYCX2+JZp6RL2OYThUFb2eXCv9Q4s=;
        b=MCSw7afK79wMXt4uSptWIhh3YxkJqbmLWdbUsAPrwdsdJCrRXjSwYz6hV1A2teu9k5
         Qmgdj+WdSRfs9uGv326qF6e0Tw9H+DJZ2nMZVtggXISDcsb/qrZlArNI1BgiVnH3u6Xt
         rYTB4dtSJJd3B9jhl6YCWkhyMg5cUtRw2oRi1dMCGTKenbr3TK8qFYJniXqCJhq45jS2
         QbFPVUisuedQTrTMfDCKaUttUYuAgvjptEzffpFI1VSDaoT8nlMI5wkXBJboE793ymt5
         CpKlP+ToWP5Yct7EKPH4VP4gTyYV/lmqb+rtcSVaN4gxjxrXuwZziUqk4LpJMX+h2/GQ
         NCXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTMZLXzRg0cQ0kd/Yy+UjfAMkrwT/BfEalTVJwt+o6oN1qzhODFm8lhzyc/nH5RhX15Ga93dOhwYU/iq7fhtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAACs256Xlk381UAS8bY08IWfw0i8vgYS+xhHVBNRWQEqcVhG+
	5CqH8WTkpzVEcLer94AvyNq3DQSZV4QsIcNCcRXRrB/4fGIJhx5co8U+gWJiVAFOfUxOBnlLF/X
	eao9A7GOMjwfRFhzFXJQmE++05g==
X-Google-Smtp-Source: AGHT+IFoDqffNyLkbxHKU6loxuUOLo9acaOS7vj4iOn89/rQ3gk/HKCLxFGD5teHbhavZcQDe+xIwKsPyKOuxUa/gA==
X-Received: from pjg7.prod.google.com ([2002:a17:90b:3f47:b0:330:7dd8:2dc2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-290c9c8c7c2mr61213505ad.12.1760731978725;
 Fri, 17 Oct 2025 13:12:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:59 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <bb9227fed5a78a26aa6d6651209479d1295fe77e.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 18/37] KVM: selftests: Add helpers for calling ioctls
 on guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Add helper functions to kvm_util.h to support calling ioctls, specifically
KVM_SET_MEMORY_ATTRIBUTES2, on a guest_memfd file descriptor.

Introduce gmem_ioctl() and __gmem_ioctl() macros, modeled after the
existing vm_ioctl() helpers, to provide a standard way to call ioctls
on a guest_memfd.

Add gmem_set_memory_attributes() and its derivatives (gmem_set_private(),
gmem_set_shared()) to set memory attributes on a guest_memfd region.
Also provide "__" variants that return the ioctl error code instead of
aborting the test. These helpers will be used by upcoming guest_memfd
tests.

To avoid code duplication, factor out the check for supported memory
attributes into a new macro, TEST_ASSERT_SUPPORTED_ATTRIBUTES, and use
it in both the existing vm_set_memory_attributes() and the new
gmem_set_memory_attributes() helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 87 +++++++++++++++++--
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 019ffcec4510f..dd26a41106fae 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -310,6 +310,16 @@ static inline bool kvm_has_cap(long cap)
 	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
 })
 
+#define __gmem_ioctl(gmem_fd, cmd, arg)				\
+	kvm_do_ioctl(gmem_fd, cmd, arg)
+
+#define gmem_ioctl(gmem_fd, cmd, arg)				\
+({								\
+	int ret = __gmem_ioctl(gmem_fd, cmd, arg);		\
+								\
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+})
+
 static __always_inline void static_assert_is_vm(struct kvm_vm *vm) { }
 
 #define __vm_ioctl(vm, cmd, arg)				\
@@ -398,6 +408,14 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_MEMORY_ATTRIBUTES2),		\
 		       "KVM selftests now require KVM_SET_MEMORY_ATTRIBUTES2")
 
+/*
+ * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows need
+ * significant enhancements to support multiple attributes.
+ */
+#define TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes)				\
+	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,	\
+		    "Update me to support multiple attributes!")
+
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
@@ -409,18 +427,11 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	};
 
 	TEST_REQUIRE_SET_MEMORY_ATTRIBUTES2();
-
-	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES2 overwrites _all_ attributes.  These flows
-	 * need significant enhancements to support multiple attributes.
-	 */
-	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
-		    "Update me to support multiple attributes!");
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
 
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
-
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
 {
@@ -433,6 +444,66 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
 	vm_set_memory_attributes(vm, gpa, size, 0);
 }
 
+static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
+					       uint64_t size,
+					       uint64_t attributes,
+					       loff_t *error_offset)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = 0,
+	};
+	int r;
+
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
+
+	r = __gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
+	if (r)
+		*error_offset = attr.error_offset;
+	return r;
+}
+
+static inline int __gmem_set_private(int fd, loff_t offset, uint64_t size,
+				     loff_t *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size,
+					    KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					    error_offset);
+}
+
+static inline int __gmem_set_shared(int fd, loff_t offset, uint64_t size,
+				    loff_t *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size, 0, error_offset);
+}
+
+static inline void gmem_set_memory_attributes(int fd, loff_t offset,
+					      uint64_t size, uint64_t attributes)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = 0,
+	};
+
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
+
+	gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
+}
+
+static inline void gmem_set_private(int fd, loff_t offset, uint64_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size, 0);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 
-- 
2.51.0.858.gf9c4a03a3a-goog


