Return-Path: <linux-kselftest+bounces-23007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345359E8F47
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A4B1886C7E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36483218594;
	Mon,  9 Dec 2024 09:51:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458FA217F46;
	Mon,  9 Dec 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737863; cv=none; b=qudnaALFuwYA56w2o3DW6B2Cz5UZTuoMMtd5qhbLajgPl/Wlmmt/vb6l08ieXgROIiOt3tgOkF4KNV68Fuz/5vxmebthylfg5gTNJ6FMpoPOeS6n0LE9k8ZlE73OwGG9XXke+zwh2485oRCoNPdTETv5hcl42+MmoArfm4IX1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737863; c=relaxed/simple;
	bh=bZn6G65EmKON9e6w9HDWMydpFYruXRMmd6bcNJ94NNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW3ZwlQnpT6tfSJLaZQpzv0zY/JXCL8Lg4ReWYVJdMhKGiIlC8xayzFHd7kaDT9FOy+zrmzO2DHnEkZ/uwIU+H9iv54ejP3qmqNkNL5RgAivi++7wfRTe6/n4q5pvNy56NJU+T7Cyb+jA782I2++zVKZqzc31RsGIDFksBub1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FA0143D;
	Mon,  9 Dec 2024 01:51:27 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F5E3F720;
	Mon,  9 Dec 2024 01:50:57 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 09/14] selftests/mm: Remove empty pkey helper definition
Date: Mon,  9 Dec 2024 09:50:14 +0000
Message-ID: <20241209095019.1732120-10-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the functions declared in pkey-helpers.h are actually
defined in protections_keys.c, meaning they can only be called from
protections_keys.c. This is less than ideal, but it is hard to avoid
as these helpers are themselves called from inline functions in
pkey-<arch>.h. Let's at least add a comment clarifying that. We can
also remove the empty definition in pkey_sighandler_tests.c:
expected_pkey_fault() is not meant to be called from there.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-helpers.h          | 6 ++++--
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index bc81275a89d9..7604cc66ef0e 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,10 +84,12 @@ extern void abort_hooks(void);
 # define noinline __attribute__((noinline))
 #endif
 
-noinline int read_ptr(int *ptr);
-void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
+
+/* For functions called from protection_keys.c only */
+noinline int read_ptr(int *ptr);
+void expected_pkey_fault(int pkey);
 int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 		unsigned long pkey);
 void record_pkey_malloc(void *ptr, long size, int prot);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index e7b91794f184..d18e38b19792 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -32,8 +32,6 @@
 
 #define STACK_SIZE PTHREAD_STACK_MIN
 
-void expected_pkey_fault(int pkey) {}
-
 pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 siginfo_t siginfo = {0};
-- 
2.47.0


