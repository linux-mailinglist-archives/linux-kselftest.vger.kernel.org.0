Return-Path: <linux-kselftest+bounces-19072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA84991214
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF571F242F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A11D8DEB;
	Fri,  4 Oct 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL3MPbct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EA1B4F3C
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079323; cv=none; b=PAZbAOWwTs4P5heoWa/HCzX4TdT2UgghGG+ijqy8zFvX8BeX9TAy16LBbaezaub8KEsHhUbbVmisZuNVeBBSlrhJXtp0NJ/g2Zaiyb9VL+q08oC3o0FKzqnngy2P2uz6xjh2Tw9dn3/lTlLxHK5AF1pDnuGXEvbjkrufjQMBGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079323; c=relaxed/simple;
	bh=hGc2tT+Mkvp9Uct3RiuCNP3syOpeJxVUm2NsIQXbuyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bnUEGaA/8CaiBb+2p3u9jePatjgh4Kn2mUcKEidVRwZkJIHPinxLlpsx8ZFYiIukLdLZt0stFifmnoAHBbOo4FH/zXUOSLVwO4A+u6fHITPZho3WQcav8wcrG+h2dXTlbXzFJfcHJU3FCx9Wo4wRKqbFm6Wr3HlFTCTqOxd5CUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL3MPbct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728079320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=szW3LFz6JagwXYMVlYdGhQ1/qZOpFV//HtNqCZA+SAY=;
	b=AL3MPbctQMCFaXL8mi2+Ktl0HztIDXX2g29HNNw3QWufB6hfxxsgRpaj37tpYj8vQuiPEL
	sLYrkV4bvd6l1zi8f9w+4trilun5MHN2IU/LLe8BkgKotaNAq6njrC8Cr6eaEOxZWWRANc
	KIjPHZLSkpEwYbOcyObzeEWtS/SHj9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-DPCdrPTtNdycPuOu_xu1TQ-1; Fri,
 04 Oct 2024 18:01:57 -0400
X-MC-Unique: DPCdrPTtNdycPuOu_xu1TQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 332D91955F41;
	Fri,  4 Oct 2024 22:01:56 +0000 (UTC)
Received: from starship.lan (unknown [10.22.9.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF4693000198;
	Fri,  4 Oct 2024 22:01:54 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync timeout
Date: Fri,  4 Oct 2024 18:01:53 -0400
Message-Id: <20241004220153.287459-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When memslot_perf_test is run nested, first iteration of test_memslot_rw_loop
testcase, sometimes takes more than 2 seconds due to build of shadow page tables.

Following iterations are fast.

To be on the safe side, bump the timeout to 10 seconds.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 893366982f77b..e9189cbed4bb6 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -415,7 +415,7 @@ static bool _guest_should_exit(void)
  */
 static noinline void host_perform_sync(struct sync_area *sync)
 {
-	alarm(2);
+	alarm(10);
 
 	atomic_store_explicit(&sync->sync_flag, true, memory_order_release);
 	while (atomic_load_explicit(&sync->sync_flag, memory_order_acquire))
-- 
2.26.3


