Return-Path: <linux-kselftest+bounces-207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66F7EDDAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF251280FB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9128E08;
	Thu, 16 Nov 2023 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehhQ/B6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23F11B3
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700127344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s14OcYbNsy58OOft6vgyTif8IMy6gRwapu3+F+eWkNg=;
	b=ehhQ/B6FKHWG292AKpMVZMsJgkfdtL4W4wvZaOJetIKS23Zv1ea8cJ2GWKen+EOGkqRDAA
	sw0a/ghggmqmYMoDoduMS7QVr5yPHYXiSTNHVNJFDKJUWGJpTkI0kTajxt/j0dmK34sRDu
	darOguP50PPVrgXe2w74v7jOmQRhvtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-_SrAnAy-M1iDTKAzeIVejQ-1; Thu, 16 Nov 2023 04:35:40 -0500
X-MC-Unique: _SrAnAy-M1iDTKAzeIVejQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EAF7185A780;
	Thu, 16 Nov 2023 09:35:40 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34BF5492BFD;
	Thu, 16 Nov 2023 09:35:40 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] KVM: selftests: Initalize sem_vcpu_[cont|stop] before each test in dirty_log_test
Date: Thu, 16 Nov 2023 04:35:36 -0500
Message-Id: <20231116093536.22256-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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

Fix this problem is easy, simply initialize the sem_t before every test.
Thus whatever the state previous test left, it won't interfere the next
test.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 936f3a8d1b83..23b179534c0b 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -726,6 +726,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		return;
 	}
 
+	sem_init(&sem_vcpu_stop, 0, 0);
+	sem_init(&sem_vcpu_cont, 0, 0);
+
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
 	 * will definitely cover the original (1G+) test range.  Here
@@ -871,9 +874,6 @@ int main(int argc, char *argv[])
 	int opt, i;
 	sigset_t sigset;
 
-	sem_init(&sem_vcpu_stop, 0, 0);
-	sem_init(&sem_vcpu_cont, 0, 0);
-
 	guest_modes_append_default();
 
 	while ((opt = getopt(argc, argv, "c:hi:I:p:m:M:")) != -1) {
-- 
2.40.1


