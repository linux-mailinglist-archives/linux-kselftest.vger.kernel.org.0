Return-Path: <linux-kselftest+bounces-30189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B983CA7D487
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9747116FC30
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CA225765;
	Mon,  7 Apr 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0poAOFu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wQVa/Rj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCC2206B5;
	Mon,  7 Apr 2025 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008783; cv=none; b=NXPzSsKnptP7mRu1KSpxTj1hYNqluK8HMh7GONjQgxppU+A1RY30XqpW3PTWfRUv6iCAI9DnC6P1uJVO5gcL64NYFFd7Z54Ad0CHfDfM/rKZjCOT0xbBJJfjKkkzWBXhwVt4L5KP7CjY5QyxemZsLTChPt2+HSTz2LscdxkMpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008783; c=relaxed/simple;
	bh=uLWlLJaq4ECFs7tKmzm/BB013m1Cb/4uGDVEx9NPT8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKqH1ueB7tjE6w73yEcfNrAViysyCdzv3vpKXOH1kHPMNAI4EXTbEv8sSrGz7D2fP4HQ9KbW9NtHyC3qtdMG4zqLoscWzmwZktZd3mHbvHY55Ls0fnW1G5tu9zUcTqFpbVrJiPGJUV8PqwMdhtP1+FGPyLdaaLEN51I3VceBudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0poAOFu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wQVa/Rj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSfz9/AFbJD22rKh2X5yGK08myEeYljLwAyhzu3/huo=;
	b=m0poAOFuYPvzYUkXl+tcPpuwqDtVvcbx4ONTtc4DqDH193GzdYy6qrZ2hpLvLMy4eb5ygW
	SlQLPJjj+mtYFQsVEuEMsM5/6yi7uw5hoeiKoXYx80ov8IdTYfz9RqJOU+TYF8s2Di9/Ka
	i4HngqSwkSKPxz3u5AZY0nrUz1vpK4ApFtk46krv6FyL9VD4uFYPcbuIYEhCWgRZ1Cp88Y
	aBIgor0tgu9gc+HPn2iWZ7rE21Bwa6qtvgVcVdLpf9xuzyEZK9NdbG5kzYOcD3J6jdCtMG
	FQQ0SMkN3IhePpyB61bNpxco2uWf4l9wX7J+IX7J1nt34a6GKc/Pzm4FjmSESQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSfz9/AFbJD22rKh2X5yGK08myEeYljLwAyhzu3/huo=;
	b=4wQVa/Rjvg6+oV8NnM/bcR0ONBFZmV4uYBs8VrYx5VdJtfJfOSuhefwZEQ6jcd7tVQS0iH
	Y8m0isAg+raf1QDA==
Date: Mon, 07 Apr 2025 08:52:26 +0200
Subject: [PATCH v2 03/32] selftests: harness: Ignore unused variant
 argument warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-3-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=997;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uLWlLJaq4ECFs7tKmzm/BB013m1Cb/4uGDVEx9NPT8E=;
 b=05BQFZlE1fk/l6kWCQ5q8cPJlu8MFAHbLVz28C18IJz6yB9GTYmL1GhQ7P9fDqyvHfvP8Sx+U
 tkmktZACMlUB9P9QCSRyr9Qui6NUkj6eQyRv5vlVoZ2iWr9+s+JWCbN
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
2.49.0


