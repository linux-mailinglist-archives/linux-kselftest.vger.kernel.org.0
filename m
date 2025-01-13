Return-Path: <linux-kselftest+bounces-24362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA7A0B7F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380831607F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5F29406;
	Mon, 13 Jan 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGH5LhPL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wh/rLWoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E217BA3;
	Mon, 13 Jan 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774235; cv=none; b=D1qUQIo+iV58J+6V+RwlWZxLAAfSSuq9+JIOizRAz46fVbnAu2OlhhidDwS7IuZ699ja+VVcUHzS+mmZCtGh1K6tbq0fpZd3BLFggF6kIlkiFqTkDig6X6nlLPlcToUpdy7B51MNQAoFzpuC1H4BZcE2YsIn6mnNTdhzVhumtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774235; c=relaxed/simple;
	bh=cUBEfQwiMoC+IN0PqoM+iEVxivVSJV0lgRrH9DVIFOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/qAaO/0oa1eWwzE2g4nOg1yPIpPZUrl5g5HxHiT/dSkoyztaOK2OOPEvVPlowhZ4KcFZRT4b5LZf2IeJZjozv8PEPTYeAZ0ukHjJaz5jgglmq3i7GqU5zDFMe9nq/uzKbf1uLye+DcnWlBMdWAxaQn9BCEindQmGTSmgIYchBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGH5LhPL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wh/rLWoy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXUVqotOwksrgtObQJbhIdeITzwigDuITzq7I8OaDiY=;
	b=fGH5LhPLbxJ0Iq+16N4pLYnNpVcIgofwYRD98RxBnRtYphMiJYKJuxlo1Hrg5uSOnvUeTM
	9TrylLx4K+iB3rfsM6cE4LDqeiAoBytxVU1DjS0n1z9WvGj9+n/HWJCRj73IssfsyQMV4Q
	x0VHxyDz5DyQoZs5jWQWWylXpeWmvIC4HCPtiJyZWLId4kr0CoIJJszHLddy64W53jnCF8
	ilcGOuSn82g147LQS7zKjULC+bOYyJBm7RpscqMhvE7rM79v3WQ6HPI/G1eiIAsUoLX9kq
	Us3T2QpUeTpkg11IRKLQOQ5k//TTyt6RdD+PoHXq7WmfvEKFCCjqM16A7aKq3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXUVqotOwksrgtObQJbhIdeITzwigDuITzq7I8OaDiY=;
	b=Wh/rLWoySnbsESvYzcaLXyIcCBn9BBgs0DqghRiOoH2KXlfHzzAVZWYpATDDTQBV9Tf4xW
	DONDrWrWceEu0SAg==
Date: Mon, 13 Jan 2025 14:15:35 +0100
Subject: [PATCH v3 1/4] selftests/mm: virtual_address_range: mmap() without
 PROT_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-virtual_address_range-tests-v3-1-f4a8e6b7feed@linutronix.de>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
In-Reply-To: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736774229; l=1698;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cUBEfQwiMoC+IN0PqoM+iEVxivVSJV0lgRrH9DVIFOs=;
 b=XD9wdAETA3CT+EKMf87OQ9yWUi7VjDLtiEEwegZyI5XtmEZYGy8kMRXOBy4T1pXRpbRFmtcRp
 tHC2yAZ4j+XDY3smjIklkGtqgVOg08vf//ARADirDthzh7UIJGJiRx6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When mapping a larger chunk than physical memory is available with
PROT_WRITE and overcommit is disabled, the mapping will fail.
This will prevent the test from running on systems with less then ~1GiB
of memory and triggering an inscrutinable test failure.
As the mappings are never written to anyways, the flag can be removed.

Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
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


