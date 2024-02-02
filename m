Return-Path: <linux-kselftest+bounces-3994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B420846865
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E61B212C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB5199BA;
	Fri,  2 Feb 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlIxGjHM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AA1946C
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856221; cv=none; b=M4Ft08HIrAbsHfbC6KWnRokNKpR2Vk/WtbWFPdVU7zQqsYYh8lrNBczZJ1z+VIQw7AcS5Njt/gV8NdVjTVRSbaHX6UOH2hzg+T3S8SjzgAW5CZWhPTrJgC//0x8b/Jt7o7KKqIZCNqrwGDqMqGL75/ZQ9FsuqR+ozel5W3ceGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856221; c=relaxed/simple;
	bh=XLvulHZVJquTrMep5y1cVtcFzDjgJkl/pS+1VTnGBD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9Vswn1M4wmHMnA6g/BWUGt16gpKkelD7bU6Qi88KFoLDt4gKFtl2lWjVN1wuYyOiA4JT95TCod//nsePDAJHCozxMISoq7CmSdcJe38902xbi5pCdB0dGMsA47r5JaMauQDo/LIvNiO0cIdtK7du+hbFSFTV6vLjeQsuohfp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlIxGjHM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706856218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0uFHR1zAX7zGOTNl6chkBN+h5HVp+40si/IAsptCuA8=;
	b=QlIxGjHMKRhTgd0IPzBhQwGOe/1fTQU2fjJy5tfK6T5jLgL9+y/7MwSmFolMqyy0a+ThbO
	jlSxDO4KfURe9rIUDgNJ/DFhdPtZCgbxu5jRTu67m89fE3O4n3NS+sJ5vFTErKyB23o0Xj
	n2Bq9bNdZ3BElx65vg+uF+0/qPqj4BY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-xf7PUJSRNKyGeKSykiMSGw-1; Fri, 02 Feb 2024 01:43:34 -0500
X-MC-Unique: xf7PUJSRNKyGeKSykiMSGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00403827D88;
	Fri,  2 Feb 2024 06:43:34 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEEB63C2E;
	Fri,  2 Feb 2024 06:43:33 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore imbalance
Date: Fri,  2 Feb 2024 01:43:32 -0500
Message-Id: <20240202064332.9403-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

When execute the dirty_log_test on some aarch64 machine, it sometimes
trigger the ASSERT:

==== Test Assertion Failure ====
  dirty_log_test.c:384: dirty_ring_vcpu_ring_full
  pid=14854 tid=14854 errno=22 - Invalid argument
     1  0x00000000004033eb: dirty_ring_collect_dirty_pages at dirty_log_test.c:384
     2  0x0000000000402d27: log_mode_collect_dirty_pages at dirty_log_test.c:505
     3   (inlined by) run_test at dirty_log_test.c:802
     4  0x0000000000403dc7: for_each_guest_mode at guest_modes.c:100
     5  0x0000000000401dff: main at dirty_log_test.c:941 (discriminator 3)
     6  0x0000ffff9be173c7: ?? ??:0
     7  0x0000ffff9be1749f: ?? ??:0
     8  0x000000000040206f: _start at ??:?
  Didn't continue vcpu even without ring full

The dirty_log_test fails when execute the dirty-ring test, this is
because the sem_vcpu_cont and the sem_vcpu_stop is non-zero value when
execute the dirty_ring_collect_dirty_pages() function. When those two
sem_t variables are non-zero, the dirty_ring_wait_vcpu() at the
beginning of the dirty_ring_collect_dirty_pages() will not wait for the
vcpu to stop, but continue to execute the following code. In this case,
before vcpu stop, if the dirty_ring_vcpu_ring_full is true, and the
dirty_ring_collect_dirty_pages() has passed the check for the
dirty_ring_vcpu_ring_full but hasn't execute the check for the
continued_vcpu, the vcpu stop, and set the dirty_ring_vcpu_ring_full to
false. Then dirty_ring_collect_dirty_pages() will trigger the ASSERT.

Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
at the end of each dirty-ring test. It can cause two cases:

1. sem_vcpu_cont be non-zero. When we set the host_quit to be true,
   the vcpu_worker directly see the host_quit to be true, it quit. So
   the log_mode_before_vcpu_join() function will set the sem_vcpu_cont
   to 1, since the vcpu_worker has quit, it won't consume it.
2. sem_vcpu_stop be non-zero. When we set the host_quit to be true,
   the vcpu_worker has entered the guest state, the next time it exit
   from guest state, it will set the sem_vcpu_stop to 1, and then see
   the host_quit, no one will consume the sem_vcpu_stop.

When execute more and more dirty-ring tests, the sem_vcpu_cont and
sem_vcpu_stop can be larger and larger, which makes many code paths
don't wait for the sem_t. Thus finally cause the problem.

To fix this problem, we can wait a while before set the host_quit to
true, which gives the vcpu time to enter the guest state, so it will
exit again. Then we can wait the vcpu to exit, and let it continue
again, then the vcpu will see the host_quit. Thus the sem_vcpu_cont and
sem_vcpu_stop will be both zero when test finished.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
v2->v3:
  - Rebase to v6.8-rc2.
  - Use TEST_ASSERT().

v1->v2:
  - Fix the real logic bug, not just fresh the context.

v1: https://lore.kernel.org/all/20231116093536.22256-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20231117052210.26396-1-shahuang@redhat.com/

 tools/testing/selftests/kvm/dirty_log_test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 6cbecf499767..dd2d8be390a5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -417,7 +417,8 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 
 static void dirty_ring_before_vcpu_join(void)
 {
-	/* Kick another round of vcpu just to make sure it will quit */
+	/* Wait vcpu exit, and let it continue to see the host_quit. */
+	dirty_ring_wait_vcpu();
 	sem_post(&sem_vcpu_cont);
 }
 
@@ -719,6 +720,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 	uint32_t ring_buf_idx = 0;
+	int sem_val;
 
 	if (!log_mode_supported()) {
 		print_skip("Log mode '%s' not supported",
@@ -726,6 +728,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		return;
 	}
 
+	sem_getvalue(&sem_vcpu_stop, &sem_val);
+	assert(sem_val == 0);
+	sem_getvalue(&sem_vcpu_cont, &sem_val);
+	assert(sem_val == 0);
+
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
 	 * will definitely cover the original (1G+) test range.  Here
@@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		sync_global_to_guest(vm, iteration);
 	}
 
+	/*
+	 *
+	 * Before we set the host_quit, let the vcpu has time to run, to make
+	 * sure we consume the sem_vcpu_stop and the vcpu consume the
+	 * sem_vcpu_cont, to keep the semaphore balance.
+	 */
+	usleep(p->interval * 1000);
 	/* Tell the vcpu thread to quit */
 	host_quit = true;
 	log_mode_before_vcpu_join();

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.40.1


