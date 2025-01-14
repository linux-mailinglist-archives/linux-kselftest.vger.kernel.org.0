Return-Path: <linux-kselftest+bounces-24457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB185A10BC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37557A276B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971C1AA1DC;
	Tue, 14 Jan 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qIV/Sqi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TODIgtjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19918952C;
	Tue, 14 Jan 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870833; cv=none; b=JNiX6MOufzOZi0GQmmqTr1v9U8E1ehW6rO4Ytx+KC0eIrkUy6p1jiJX5RG8rg6EDDF3d7BozZFBk9djj1Nszzz70evrx5LN7QxFQHNYvJ3SyypYSUeUyz22MejktYF9cDkwlVfKGK+2JYMM+b5W+fBBfL+0UL1rByTS/Wcxkmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870833; c=relaxed/simple;
	bh=CZpuloUjytwkHL2aPWwv10o9ubxrDZ5i+6K2DZNoL+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/hQLrEPq4fc2eSJBNk4Rz9mGXlvJZ2HWh88kdNl7NfODvdCVkNDQIJm/K/McQNclESSUP4VGq4C2hOpp9Gr+Is5imhLsmmx0g6ZtKHOOgZ3x7wq/G2uX6ArHO8+rvtIpnjgp6NLfhJmIoooUVLynqansMEAKGgJvPsIxL1NlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qIV/Sqi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TODIgtjD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736870829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMw4Pqpozqcj+M46rlKOQ3x4xAheM6IvB7ridCkcbVk=;
	b=qIV/Sqi/Yoks2I8Nqn0d21+mfb/g+17wevTd7eWnB9iPPJgxpq/hvMWR4Cbcrtv3Ad9LKt
	rpHmgGdMS3mWZSlTBuJIfppw2+TmA0G0hkrFDpuRY0u0rrgAyfhuqS5vNbkM0FfR3Q4Q5k
	2OBXZeTyiCU/hzd++lBA+X2QpAVp2fhYJPjpXzNx3JHRKjjoDhZ9rs29ROVEVKzwtF6k+e
	Yanq0CIZvkDJMrtPKQs0voJpfqzZ3brLHAeaEsr+Wjb/Mef7dzU+WIjQZXrzuS2hR4+HcM
	WF8mgBXS9+7jYWCODWyklQAvZCyt/2ymxndgYqyMG/hUWGRmV1/US3rFsJqwEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736870829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMw4Pqpozqcj+M46rlKOQ3x4xAheM6IvB7ridCkcbVk=;
	b=TODIgtjDbHTyshHRlgReOZN8Eur6i1Ig6fNAmzvJVWuIRBv56dUMgA9GNPCFURWWrKYHmh
	1tnnWGa9evG4r7Cg==
Date: Tue, 14 Jan 2025 17:06:45 +0100
Subject: [PATCH v4 1/4] selftests/mm: virtual_address_range: mmap() without
 PROT_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-virtual_address_range-tests-v4-1-6fd7269934a5@linutronix.de>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
In-Reply-To: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>, 
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736870827; l=1679;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CZpuloUjytwkHL2aPWwv10o9ubxrDZ5i+6K2DZNoL+M=;
 b=GqgQ3xml2Bf4VP4ld+L2fBtKx7TbedcU6otFZT9oJT34c/htO60k0G8UfJ7KMpb3YK+QdSVhb
 7XeerjJ2ST8BpBkEE9OUCb9tJz8Maa+jIEBAF1TCFkRLjAjlZP85Dy1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When mapping a larger chunk than physical memory is available with
PROT_WRITE and overcommit is disabled, the mapping will fail.
This will prevent the test from running on systems with less then ~1GiB
of memory and triggering an inscrutinable test failure.
As the mappings are never written to anyways, the flag can be removed.

Fixes: 4e5ce33ceb32 ("selftests/vm: add a test for virtual address range mapping")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 2a2b69e91950a37999f606847c9c8328d79890c2..ea6ccf49ef4c552f26317c2a40b09bca1a677f8f 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -166,7 +166,7 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
 
 	for (i = 0; i < NR_CHUNKS_LOW; i++) {
-		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
+		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ,
 			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 		if (ptr[i] == MAP_FAILED) {
@@ -186,7 +186,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
 		hint = hint_addr();
-		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
+		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
 			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 		if (hptr[i] == MAP_FAILED)

-- 
2.47.1


