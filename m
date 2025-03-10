Return-Path: <linux-kselftest+bounces-28663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862DA59F42
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC239163E89
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BE230BF8;
	Mon, 10 Mar 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="uajN0eka"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C722ACDC;
	Mon, 10 Mar 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628282; cv=none; b=c4XNzNkeIKHl92TEbkaFZ6oQhHoRZ/Cgztni/JNXp7h+j0jaGyEqApjRjUNmBg2cVvGzgyO/xMsKeB8Daia398uaiyxn8WwPJ+Ejk9U2QcacBaIFWn87lfLC9lCoMcJjOMhNwSvtvmeIljB7W6E4V77ko3dLNP1AlN+JZ8WW1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628282; c=relaxed/simple;
	bh=ap3sPasrD3MtqJJ59dpJLS9W6lSJm9jqsQdhmWCCPrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnZ6qDlgOE13DVDurzkf9ScjHbXbMx7z4lQPeiHNmOIbTTE80rocrZcYD8/JNRL9Ij1uQIwT5DtYSmEQDvDlunEZ7qezp/7voucysf7wchzSyOmjzgc4Q1EtHY95o5rvxOFhkqmiMrmx5dvsXF+vjo6XdaFC/NjrYNuWJejl1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=uajN0eka; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741628270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lmtUAfPPLINDeikVCo6wgZcDq+CKBrrfwKQrdC9wco=;
	b=uajN0ekaVNJgGbX6wPMIW8yBvV99/KzRPvEvGZqnvKAKDtTNV7RtahGfzOV2j8pni4l7o/
	hIOXGp9Ki6BZr8uVLlMJvOUIVSB8dccijGng/jger4E+l8cIODcmP3fx2CiQ1oH6Bl2fJl
	4zNl3qdkbQSeSd7FF/9wgOhzq5iW5NA=
To: stable@vger.kernel.org
Cc: rananta@google.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y] KVM: selftests: Fix build error due to assert in dirty_log_test
Date: Mon, 10 Mar 2025 20:37:49 +0300
Message-Id: <20250310173749.11260-2-kalachev@swemel.ru>
In-Reply-To: <20250310173749.11260-1-kalachev@swemel.ru>
References: <20250310173749.11260-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raghavendra Rao Ananta <rananta@google.com>

The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
the dirty ring logging test") backported the fix from v6.8 to stable
v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
exist on v6.1, the following build error is seen:

dirty_log_test.c:775:2: error: call to undeclared function
'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
        TEST_ASSERT_EQ(sem_val, 0);
        ^
1 error generated.

Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.

Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
Cc: <stable@vger.kernel.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index ec40a33c29fd..711b9e4d86aa 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * verification of all iterations.
 	 */
 	sem_getvalue(&sem_vcpu_stop, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 	sem_getvalue(&sem_vcpu_cont, &sem_val);
-	TEST_ASSERT_EQ(sem_val, 0);
+	ASSERT_EQ(sem_val, 0);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
-- 
2.30.2


