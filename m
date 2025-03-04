Return-Path: <linux-kselftest+bounces-28148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11119A4D450
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E21890C0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673051F7098;
	Tue,  4 Mar 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4Vzrr6P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PK3A6f6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83791F5616;
	Tue,  4 Mar 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072272; cv=none; b=sA14LKhn4ql4g2NE6jsnjX86SbtPWEa1I9Z6Pl/DVy+K4VKNk35BlDeUGLPFJuYSu4+LeFCzOcvEdQDTmDfTMAzYdjhniEo1IMtA7yOhZbD4q/PpU3wpJtiT+1nnFOa8x9iK3aDsdCU8WeYZf77BO6grKVk47sxEeUqKMX3Kkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072272; c=relaxed/simple;
	bh=brts6sI7fO8sdafrxrf0XUif0cGTeVBZWUynqL1HmPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+nM/mkcEGtmFl2owRMHihaQmhsADTU/1hsk0AauDNPWjihbsCE5+HIiVNxe8I9BgeYHZgrmvruLH+6esCK22Q6Jv+Eb1x1q2kvc8AEMCKDe7WsDbgw6K8fIAurrA/kyLQ1Sq/ElLHBnPB56OkXsE8oKw07ML5/iLwXjW1IcJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4Vzrr6P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PK3A6f6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McU1MORmucgC05fci48yCdSfOoJf0NFFfmjXRQ7FgCo=;
	b=o4Vzrr6PaWA+o6ctw70oXatVQdQSxWch/ctS1qoI3vbQyUiXhAreFAMcN4fxhLGXMShta7
	yY975jenuqcFzzFURQgvLfARv/KSXsYjt6h4EawzIwTOCx/Bz99S6bGEC84cfjUDV+YkKk
	zzzFpbUbtVR7ebN/XWfykOIztxttXtr/c4qloH0+uhDqRI3zZgvCKMu7cmlX7HxyJPl7lG
	7MaU189vRckiYP4w0y34cG2PTT7mu7RF8XF/giuFrDlW6GGY0fA4qcR8ZkW1tx0qwS4qCV
	Cb5OAMZVPU4RBC2eNno3FUsEtQifdCCy+jgC9TelJQ8v4PMbbiEMrRmrTUD9zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McU1MORmucgC05fci48yCdSfOoJf0NFFfmjXRQ7FgCo=;
	b=3PK3A6f6IaqoKZYQ14i9NN728OWToywYT77E1n+l3zCeiZBZxmS8fLr/KcQALqnfAo3rmT
	Vf4+78nAn4xQvVDg==
Date: Tue, 04 Mar 2025 08:10:33 +0100
Subject: [PATCH 03/32] selftests: harness: Ignore unused variant argument
 warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-3-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=997;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=brts6sI7fO8sdafrxrf0XUif0cGTeVBZWUynqL1HmPc=;
 b=zQ86J82UY53NxSyoCN1KKP2DlcwGfgi2346pgIKb2wrPLKNThW5Llp0MwRcl4peBL8OiHT+Wq
 P6BWtv6rTreDLWi/ssgX4hm0C3gQ5GglIV1t6d3/o1cnVkmmZl0ZmxW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For tests without fixtures the variant argument is unused.
This is intentional, prevent to compiler from complaining.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index bac4327775ea65dbe977e9b22ee548bedcbd33ff..2b350ed60b2bf1cbede8e3a9b4ac5fe716900144 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -174,7 +174,7 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static inline void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
-		struct __fixture_variant_metadata *variant) \
+		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
 		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \

-- 
2.48.1


