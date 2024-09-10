Return-Path: <linux-kselftest+bounces-17694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA59746E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB82854B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC161C242D;
	Tue, 10 Sep 2024 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLAsUS0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF71C2328
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011929; cv=none; b=U3NzSpCiB6afdk4yezi02Ihwx4EtWb3Ac6v3EwRlfiDvmK7UYXbbRvFg5TjNZeXNIoRr9L/CgCvHiKi+HPmxCoI+BROGkTsJrH/ej46TWm6K0/ARALNFcMnTHvZNL7gOOADTF/pkucdqzMI3lENNFQwSKLuM0vvwkP3nf31DOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011929; c=relaxed/simple;
	bh=T0w2KZlhe2rovrIvRN5dcVMPNovGh8zN8pefjySPrWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9Qs7uTmy2fF8sU7NfsKRoeZhOhvYWNn39kb3BMNx4tI2IP20sH05/yfoWbex27FxMVjXAjOwBohuHtFAeo/qNm9Ym7WDva3KMOtpIKny58qfjnOHeFfptJj8lMkEjyqnfyCAAZo8XzR3A6Nrto4upzolgL5QoYjBTu1t8IFq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLAsUS0G; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so2807822276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011927; x=1726616727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwf1PxblOjz5NXZUaTh7zfbmgn6lBhrxKJq/6ZLohcs=;
        b=pLAsUS0GYbfquLsP8tIzmZ9+BPahMdB/i5COrQPy6oX8uknuzzVCHUkB+ygy+RKm5c
         eXJgXJJp3RF1whdQ/l8YBIrOtLaBBu0UjRoVrPVmXoNxUIexsQzs8pRHm2jRuN6LZPMh
         9vO1+3e7+/vYnbRL40NtUwAe5gtCiDM4f4abIY8TmeA3AZ50KRWWrfHNf7KjLkYlamVn
         39gPRS+wkKfxufFupi7WKM8VBfGOxBI/0D/M/7k+tiVcDbTAGxdM6EW1xSJEbusjkSg/
         KrfJ4zklFt1H9hAFZpsFMdqANWBLrggGTaWKg5Lidwu4WqWgntu6z/12oxlA+nEKmN0W
         WMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011927; x=1726616727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwf1PxblOjz5NXZUaTh7zfbmgn6lBhrxKJq/6ZLohcs=;
        b=u8eIFAHjqqOXhzQIDtE8uqamgbkNY1BLuBSxdLCXOni501FFCWkK7/SqMm5WNu0Gb6
         rKyFqhsj6y8yIxM4tnU04HA0ZA3PJMVaMTsd6fhL0VTMClD4KnrHDF90XdsK2jHKqFto
         f6on3eh1c+Bqc26TyOQOG+tyvEAHXqlUUil8toApL0F/fjc71q9w+v/f6mq3tcXeokz5
         4Jk3RLt9N54w1NV3ZwxRMCIp4f5Lt3uuH0kIep4dhmoCuEoPBESXbCx6rFlTg8C6+zcw
         kwqd14NoM60EOrhMJVjcr4LaN360zMHnlm3xfH+395fsoWD9IiSxGpVMSHNu+wrTRdpS
         wehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQCuKklCHq0tQE+w1UvRZbTsFz6EvRynBLleeyqfDufPQJWoo3wv+tXMUoAnSldgs+bosYzY4tn4bb7a7nxdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCt9AWx9/IDgDcBqmvnLcwgUL/JmEVEbAOop8AQwSjVksPwXS
	6ji9pVMurUupmBW1AjHVLXO1ytXgz35l3OkZCUVgZkX/VhUk+rM7BhVi70Tfgfug0Gwobv8AaGf
	/jWyLzoB1wWYIUBeRpBhymg==
X-Google-Smtp-Source: AGHT+IFHLL/JWASNEnEkZcv6PFIj58I/J8+OY1FCIRm5r4Bk9ay3Th/8kINWVB3DiXd8md6IPOJl8xsEmDXgV5bz6w==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:aa43:0:b0:e16:55e7:5138 with SMTP
 id 3f1490d57ef6-e1d8c022ba7mr1649276.0.1726011926642; Tue, 10 Sep 2024
 16:45:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:02 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <6faf6d63a98531539b05ea36728e51ff51bb3cde.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 31/39] KVM: selftests: Allow vm_set_memory_attributes to
 be used without asserting return value of 0
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 tools/testing/selftests/kvm/include/kvm_util.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 63c2aaae51f3..d336cd0c8f19 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -374,8 +374,8 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
-static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
-					    uint64_t size, uint64_t attributes)
+static inline int __vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
+					     uint64_t size, uint64_t attributes)
 {
 	struct kvm_memory_attributes attr = {
 		.attributes = attributes,
@@ -391,7 +391,15 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
 		    "Update me to support multiple attributes!");
 
-	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+	return __vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+}
+
+static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
+					    uint64_t size, uint64_t attributes)
+{
+	int ret = __vm_set_memory_attributes(vm, gpa, size, attributes);
+
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, "KVM_SET_MEMORY_ATTRIBUTES", ret, vm);
 }
 
 
-- 
2.46.0.598.g6f2099f65c-goog


