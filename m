Return-Path: <linux-kselftest+bounces-24212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED30A0916A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FFD162C24
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2920DD59;
	Fri, 10 Jan 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kA+S8SXB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KZkRKHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDD1E32C5;
	Fri, 10 Jan 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514378; cv=none; b=q22X0VGlY8NNY21SqdvEWDVufQIMVVWOimjx7eaKfX6ocXiQpXb/+nLIDLwHDQjWoVvJ2rJ+AIMrMHkXYSoOlPvlmjuP0eqD9lsj5DIQZTjXIkIAW1stvqCMKBtcLn5dQ6HXobvz0JJHyaXLW6bqYYfQ/79BFg5fl7UPc1o1mFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514378; c=relaxed/simple;
	bh=6Y4AYnLMO6bZ4JZYH4ZHiDJ17RsT8q+tecRlw111Dgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYb52F2WOb5xyO+ZsVgr0SB5a9lYTgoOT/IR70rHL1mcYKF0W+YKmtWepmbzAnhlUDmQ1lgxYm8RYovbY+oIko1hIf+TrPtqCT/ugCalxY6JToKcldT7HRgFqYq+1LgZrb9xldEO7xae1iQSguk2kBLMGRuf4OKAe8+Da9jQPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kA+S8SXB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KZkRKHk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736514375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvleoViXEKAiJTVXtrq0/ICXhKzDLpaWFsIO95ioPJE=;
	b=kA+S8SXBPARb8/LLqo0nfKGrPw7rdKWdDmGS2CbReD3UmVTIQQskSvD3RaWBL93kyST6L9
	PsHFEZqYEro6lVdcsTGBAw2OEuWu6/NQixUPXpAxkpeQOj0Gj1sS7Qmps6jUqISOAOPscj
	J4JDbtS7rOZZV9TurTDXICTLNe6BWu5xsr4cmjNppwduyJDK/ief8slr8ViWYefVI5crLN
	8OltyuL8hhe48ezTMJra2ESijyzKBCc14D8GstA+D5PU3hMtbQGu18gh/Hpi6IldVe7ZgK
	XHuDv3nt/6TFjUHpbRZ8PP1Hoqrek4EY71BUqqybuaVVD2/t9vdau5pjUO1mgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736514375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvleoViXEKAiJTVXtrq0/ICXhKzDLpaWFsIO95ioPJE=;
	b=5KZkRKHkwyWQDbmLNGda8RdT9cAqgyA7/oTQynMbpe46hd4sDQU1p09idFSqW8ElHooX/B
	Gw4DHIjstVF/o6CQ==
Date: Fri, 10 Jan 2025 14:05:50 +0100
Subject: [PATCH v2 1/3] selftests/mm: virtual_address_range: mmap() without
 PROT_WRITE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-virtual_address_range-tests-v2-1-262a2bf3c3d0@linutronix.de>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
In-Reply-To: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736514373; l=1736;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6Y4AYnLMO6bZ4JZYH4ZHiDJ17RsT8q+tecRlw111Dgw=;
 b=x/1Tr/J0h4P+MXP4+Hne/MFcUXBC2su4aDXFajOeQYUQnctX6GGFfB8m0I5tB3Rhc4XdY+xHO
 VpnjsHoiQtVDIsaAjowbqM8fe55VK5GfURLdBwupuLvfHlnMEtMxNGB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When mapping a larger chunk than physical memory is available with
PROT_WRITE and overcommit is disabled, the mapping will fail.
This will prevent the test from running on systems with less then ~1GiB
of memory and triggering an inscrutinable test failure.
As the mappings are never written to anyways, the flag can be removed.

Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
I went with dropping PROT_WRITE instead of adding MAP_NORESERVE as this
works even in the face of OVERCOMMIT_NEVER.
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


