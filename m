Return-Path: <linux-kselftest+bounces-47399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0CACB5252
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A173007EE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3162D23A8;
	Thu, 11 Dec 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PUCuS9Ip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF6283121
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442516; cv=none; b=uzxmMPOX6vZugLIp8b3lsqXqRncipif7JXruEzEibdYQOkXVMp8yGGenr/ZgXDNVt1bkFHLSaxORheg6cJYUpwVQTxyKkPCTIOz4OhnfpIZgYWxN2Tk0UHChDkhm5nhtWPe76XUqzYHyGqxZr5sYhSJUvYGG283bUkr6vbX1jwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442516; c=relaxed/simple;
	bh=86jM6/8ayfHPNKCYQQ/v+Gxswje4pbMb7uGQHheHd4c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EqKscd54NNJHcRjJPOvxJYp0YWATGDQDJTInnOccz7a5P4DOcGkztpABUOh/PzqB4IelUvQj9lRC1c3eu1uj+V+STOi1cNnYxy6w5P9Z6E5uBxzjZ8cug0NfEdl3SlEwSV+zFPO5xCg7xph5uJzm6P7leeZDYKqzo6HbMw/DOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PUCuS9Ip; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765442505;
	bh=zDJ4Agqgm0IgPliNwt9ogn6DK+Rs7gCySxS9/AzULK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUCuS9IpkeWkF78IEWANvbkxsu+YMAwAs93B27ybFAd3q060wOZdI4/+z8GgwR43k
	 28RArvAN3wjc+eItAPrq2psNTUmsnkJqKvgqoxtxhQZwc8Mmk6Muzyi7x944U23ALU
	 Kc2LSwKdl9DMaaae0jvnFjUXiJ0JLciFCRTmGLXM=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 98F2F61A; Thu, 11 Dec 2025 16:38:15 +0800
X-QQ-mid: xmsmtpt1765442295tlnjc9yz3
Message-ID: <tencent_348CCFBB269D37E7FD7D11741116B171CB0A@qq.com>
X-QQ-XMAILINFO: NZSml8PQdeKA9C/wv1ou5+KuyIg96s2waQuBjc517SWlxQfXhoeAAavj3syLmY
	 /ZctY03wPWwjT9KZMJPLllDLSTWsnAZGHFX/E4M6DkwFFoqix2PFxVoroqBwtkVBnSi3swY5P5Z8
	 cFfBuAfLwpewDAtrN/7BlCxDGqNTJhu12ORSh859+6ubM6c05Xpo4hk5WoynNtx6HtYwE8WL81OZ
	 Enb7xemSJhwUR5GKmNVXF00H7N49hTc4EZmqUYPk+UY/nPIrs14c7/RzjoT3yHMQPhNiSW0FKDjA
	 tAycSpW7636IfQzOmglfdN1m3ad9UPg4kTDPZgoW9QqpcXUiJzwYm9I8YbKOpdoG+BCVlfCxY2V5
	 ENimuGZM5M289X7NgyyI4UgxnMiBJmlk1BXhsLt8G2gHjfa/WnULBPQVFPirajz3Taiz/longMUx
	 dwO9f8pQs51BNyiCaltv0dJTha0JDc7TvUsGpfCpQIHGDDW871hYh3ELshi1cCrMj5/28njkUftR
	 7nKHlTb3zhdNqA25FOE2CbzhuhcMOljTkg3jzNP9CYBGwUtjJt+J9W+/ARxaBxlWtYc3mG0Jjb6G
	 tUeoyAuqFXQn22aIH8OIfF3MehdXVXaVoSAgSjQEYXKKg0IWSZzsMlME3ghmJoGHXMGMv60NL52J
	 n4mz/s/x3TUwWcz9hzPPCUG9Yqp4yGMLxGKgmcmwkECSkTCIDhVVae5BE2+32jtiJQ/yWQCIqvDp
	 9/eGjEYHEu24kZAWxGy+xJHkr+YsNi/vMjjOXGPoQ8l9W8eO2qGDUvt4r9BcrS6k3EIU62SUf0Y9
	 p1gUYGBDdeKLDwKvV0ep6du+Fm9XlvZIAvy3RH+uSOC2A9WsFUVNiUhRUOy7jXQ3wPmTAap6OxHW
	 btTRhpUe4q+GCihdvjaexrN7jxbqBgxjuTgQxraqn4mJE7c8c+eJEq67EnYaOSE4qTo50u7/OEca
	 1CfZGySC23W6fEK/nosJRegmFHYba6tnY+fHXcEBuDx4thOIw5aIsfAkbXICKaggGeZrwou1Sm4o
	 hmNfXjwdOmVRF2Koje4/pYBnXDnp5vX+QmsJ5MpJ3dU7wlTvRXMdTEbbb3x/t7eCadqLUaY+8A1K
	 EQGjHJW0ms2rKLfZF9W1Bl79J7TLNmPtN3yWu6
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	edliaw@google.com,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH 1/3] selftests/futex: reduce array declarations in the requeue_single
Date: Thu, 11 Dec 2025 16:38:13 +0800
X-OQ-MSGID: <20251211083813.1795854-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
References: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the requeue_single function, the variable "waits" only uses
one element. There is no need to use an array.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 tools/testing/selftests/futex/functional/futex_requeue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 69e2555b60399..1807465de2144 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -33,7 +33,7 @@ TEST(requeue_single)
 {
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
-	pthread_t waiter[10];
+	pthread_t waiter;
 	int res;
 
 	f1 = &_f1;
@@ -41,7 +41,7 @@ TEST(requeue_single)
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
 		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
-- 
2.34.1


