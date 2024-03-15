Return-Path: <linux-kselftest+bounces-6353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E34D87CF0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4462B1F23641
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C62FE28;
	Fri, 15 Mar 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw0cedL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05D381B4
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513320; cv=none; b=ZLI8Lr29wJol+S21jC92B6E6XajabpWkkgBmV1Cc50zw78l9cKtlSTrTBIJZ/As8haXaVbqG5EMqgv+CX2o19Q6DLzHSu/WzyRe3fBmmgLqE04NSn8suQlHUoxh6+8oVIj0SYx8nzdo8GJ5LVE+PUjKrR+OICaHTZLYwD2LHm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513320; c=relaxed/simple;
	bh=Bnp7XWkyPj45TcVE/OTtDC1VSqGlz7YOyH8lcokg3ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMPWOiFu/2lMGTAeA87hTLCkHLH5Sm6B1PUnMqhkZcC6mejhrnj9BHfFqCMnYZ2hOUFlPwSFQXOsrnTHE2khHam9UcoglgHcFCMdl81BzFZYuqXp5H1FD73yZ9RDZLH5V9rXkpTOd11fV18Xp37/AktaU1oe04P193J8eeKN5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw0cedL2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710513317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SrsZ3sRjJ0cd4TSAU6qFDBULeyMZSqfIVaf6DxKRBJs=;
	b=Dw0cedL2m/fTk2P0qegb0N+DrS6yShlbqmOhSZSD/5f0uHR5xpGvPtENRg5ZByYNViGSS9
	esE7mWvbyqFZdmMxIUdvHIaQQ7su5e5NS8wC5S9PEDUHrSwUzVUtIy1HbEFcxDDsu7gaC/
	a0bwMi52fuzfNi4+NDje4d/dC6grci0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-IO3P_mF2M4yxJoySzljqKA-1; Fri, 15 Mar 2024 10:35:13 -0400
X-MC-Unique: IO3P_mF2M4yxJoySzljqKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86C4E8007A3;
	Fri, 15 Mar 2024 14:35:13 +0000 (UTC)
Received: from intellaptop.redhat.com (unknown [10.22.10.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3FB1C04128;
	Fri, 15 Mar 2024 14:35:12 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] KVM: selftests: fix max_guest_memory_test with more that 256 vCPUs
Date: Fri, 15 Mar 2024 10:35:07 -0400
Message-Id: <20240315143507.102629-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

max_guest_memory_test uses ucalls to sync with the host, but
it also resets the guest RIP back to its initial value in between
tests stages.

This makes the guest never reach the code which frees the ucall struct
and since a fixed pool of 512 ucall structs is used, the test starts
to fail when more that 256 vCPUs are used.

Fix that by replacing the manual register reset with a loop in
the guest code.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../testing/selftests/kvm/max_guest_memory_test.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 6628dc4dda89f3c..1a6da7389bf1f5b 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -22,10 +22,11 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
 	uint64_t gpa;
 
-	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
-		*((volatile uint64_t *)gpa) = gpa;
-
-	GUEST_DONE();
+	for (;;) {
+		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+			*((volatile uint64_t *)gpa) = gpa;
+		GUEST_SYNC(0);
+	}
 }
 
 struct vcpu_info {
@@ -55,7 +56,7 @@ static void rendezvous_with_boss(void)
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	vcpu_run(vcpu);
-	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
 }
 
 static void *vcpu_worker(void *data)
@@ -64,17 +65,13 @@ static void *vcpu_worker(void *data)
 	struct kvm_vcpu *vcpu = info->vcpu;
 	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_sregs sregs;
-	struct kvm_regs regs;
 
 	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
-	/* Snapshot regs before the first run. */
-	vcpu_regs_get(vcpu, &regs);
 	rendezvous_with_boss();
 
 	run_vcpu(vcpu);
 	rendezvous_with_boss();
-	vcpu_regs_set(vcpu, &regs);
 	vcpu_sregs_get(vcpu, &sregs);
 #ifdef __x86_64__
 	/* Toggle CR0.WP to trigger a MMU context reset. */
-- 
2.40.1


