Return-Path: <linux-kselftest+bounces-6464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7759885ADD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F31F21BDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B51EB5B;
	Thu, 21 Mar 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxyfMzWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3871EB3B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031547; cv=none; b=Y34BcDasj83g5B+wXLVl1j3AYnapqWVzfRTefS5RJ1Vr2mR6w8z7eovuqYTXpEa1cfRKpJKnBGa3G/rGk6a/ZpJ5lYBxFcqRueoIZNgTRXagYWNIfM6smvlrFyQC/dNr7OfJzKKqh4bUL9+pjYs19zDJZUrbUry05UsenK8B/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031547; c=relaxed/simple;
	bh=rmyBKjRwybGP8ae7JytbCpxOElnrm3Qb3RW3sVx3vAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1V1GUGCSkfV1Fnzq7HB3olo765CrjEocGsq/8G3cqvMfz5Uvp6sLHen08Baw9KL4gYP/Vsgc5QIuo2JfbB6AK93i7bWIfd+bdJMwKByhgU8I2n544WB9x+I97JKYFBqEOIBWtcNmw6P44d2GvufhCj3wB4InfPofW7MfR8HO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxyfMzWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711031545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opktTlYedBuiFJS9SkEYMhhDffMkisjcFzlEk+KgS4A=;
	b=gxyfMzWZdbVsy93e7MbW8d8Dtlbr7kpP9vzs3taQagUJO8FCcbvbrRm04I/AWMbLNznreR
	tAAupk9gMWVPLUFCfFiqUMWItaLOrIR1NbQ6gRWW7FB+5mK7voKR8PZ+Xai6nwQJ0i4fvh
	+7t+Dltx2y74dLDCV3oIeIgSCyJkm8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-YTf9g2OPPWmoeMXjwSMCLA-1; Thu,
 21 Mar 2024 10:32:21 -0400
X-MC-Unique: YTf9g2OPPWmoeMXjwSMCLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4BC43C0E44F;
	Thu, 21 Mar 2024 14:32:20 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.32.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A464B40C6CB5;
	Thu, 21 Mar 2024 14:32:20 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 2D3E912E0F7;
	Thu, 21 Mar 2024 10:32:00 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: brendanhiggins@google.com,
	davidgow@google.com
Cc: rmoar@google.com,
	npache@redhat.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] kunit: bail out early in __kunit_test_suites_init() if there are no suites to test
Date: Thu, 21 Mar 2024 10:32:00 -0400
Message-ID: <20240321143200.1854489-1-smayhew@redhat.com>
In-Reply-To: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
References: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Commit c72a870926c2 added a mutex to prevent kunit tests from running
concurrently.  Unfortunately that mutex gets locked during module load
regardless of whether the module actually has any kunit tests.  This
causes a problem for kunit tests that might need to load other kernel
modules (e.g. gss_krb5_test loading the camellia module).

So check to see if there are actually any tests to run before locking
the kunit_run_lock mutex.

Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using debugfs")
Reported-by: Nico Pache <npache@redhat.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 lib/kunit/test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1d1475578515..b8514dbb337c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 {
 	unsigned int i;
 
+	if (num_suites == 0)
+		return 0;
+
 	if (!kunit_enabled() && num_suites > 0) {
 		pr_info("kunit: disabled\n");
 		return 0;
-- 
2.43.0


