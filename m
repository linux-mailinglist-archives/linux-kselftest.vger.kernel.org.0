Return-Path: <linux-kselftest+bounces-28149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4597A4D451
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A0A1893ABE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747741F755B;
	Tue,  4 Mar 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L4AvGgFf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99Fg0ogH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D61F5826;
	Tue,  4 Mar 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072272; cv=none; b=dgl4EI6BeSj5FOpuCH/9d1wbQF6+cTTNhEgCC9qUMI0FNp4qqKIJScwzPdEXm1kpC9OnTyl+1cDcF8AZeuKaECGt2SxvBfh7Put+jc5746P3nAXXkxivdWqFqW696i1ZxSsBNSrGUX6C0EdGvqkNEKaq+0WoBd7Ib3rDgFgfSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072272; c=relaxed/simple;
	bh=ngP0ZeYGfsdVmu5UMgRUq6/AZ63uVhxqi5hl+GZp6NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUTSHpDtz9Je+mJmsO2hfWzVovt/ClVVb6lZX3/x92XNM5ZITg4lWZeMM+nttdt12bVhth2yOces37Nv0WGsa/M8vwlLZoA33ODGTBH6RBNpCdI1bGc+KSbc9/XIU+AJ7S3gxg9sLVQyC3gklIDB4E3qjYYLNLe3QWIRopKrCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L4AvGgFf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99Fg0ogH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWgK4Z18uSYuxBlCTX/qs310Gb2s7CNUM9/0ECxlbv4=;
	b=L4AvGgFfnD/SJIg2wLvppaAlJOCOEf3aQWvj8CwjatP9UvHRtx/VnuU5CMvOQbajnFVBs5
	JPi2gqbJz2+jJwrSbe3+qgsDGQfaPcmgdCF4pnoyWvvybEXpvE9x0P3xX3voUEIdsZuyXM
	g0g85bqNAEgOHb8U+KONF7qbwdVio/kdjizYkWu379BihR4BW8tWjeQ5jSujPOro4jaheq
	H18DDYaiC1MbMcKYZT2J4+GzVyRPPfTUx7t8ZLZ20Xc2mkjwUDDequGlM1isRN6iJQhdWP
	M04Ktkv41z+DJNBfkTGshbtPJGvvfC6aQkkX6/aRFfvI/NrApLhdnqQkxHXbug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWgK4Z18uSYuxBlCTX/qs310Gb2s7CNUM9/0ECxlbv4=;
	b=99Fg0ogH1TO/kxv7Jt8W3h5tEq/bq3ry9jdIgBiCLS8Sah502g1Vlz6/1MRqwG+20QlEMu
	26oA8N1GFdaRZLCA==
Date: Tue, 04 Mar 2025 08:10:32 +0100
Subject: [PATCH 02/32] selftests: harness: Use C89 comment style
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-2-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=842;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ngP0ZeYGfsdVmu5UMgRUq6/AZ63uVhxqi5hl+GZp6NM=;
 b=C7f4CdN2AMm2geAe+FWhpbu6Y4K9i6ezDelKM1cJITPneK5jGfhwOoKDD0gV1siGXUOy9Hb1J
 KApQ/Lku3HkBbHMc0Z2v1F3vq7hKYz7Rb392dhAEcskaNeQSjiO5FFn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All comments in this file use C89 comment style.
Except for this one. Change it to get one step closer to C89
compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9d25fe6e248a7f2143c113473fe1..bac4327775ea65dbe977e9b22ee548bedcbd33ff 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -983,7 +983,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	// signal process group
+	/* signal process group */
 	kill(-(t->pid), SIGKILL);
 }
 

-- 
2.48.1


