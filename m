Return-Path: <linux-kselftest+bounces-32373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE4AA9725
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FE7A8B37
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4633262FDD;
	Mon,  5 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vmm6TiR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOPagBY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397825DD1E;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458178; cv=none; b=aVHd3FG6lvmItryRpgrI1lrDkQAhjarxniZwCJN0mouV22GOS9jmflZb5GqnAeiyBF5q134HTOidgwevpYuqi3RobFGJ6ctAzEx8zN8TUljTBpPk2GW4Uk66CADizjsiz2DqKtsNsF6bA0awpmjTfNuV7d/jaXYKW53VhirU4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458178; c=relaxed/simple;
	bh=1W401Ak+my+KrsBX7f3Aw19rJHwp1BqRjh0/vnd3peo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pthuINUSOvUnctb+QNYbS8XDg8ABL0PhTkOTBMFhp5uLpWDLlWEr7bcwgZ8i51VExUhV69uD1PCT2I/cy+mE1Kbg9mlRsgXk7iqKMTDq1xRPRNA46ELVofriN3vNMeN06DGQi7HvOaIzhTwHiASRucWSyKBY5T8bmthVvPY5erA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vmm6TiR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOPagBY9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xK0ENF64hgvN5Ncmrhe7VwWzY4Hg4XyaQVQW40BKa7Y=;
	b=4vmm6TiRoJIBU4e7l8jAL+NZMI0oY2NRPgOxw4s3bSLNtYRGOqxJ4rPrlXoEplEk1BERKa
	hVhnT9WH2QKsXQd1NElseUpk+fSSp6a/FUB4A1h8LLOvWSabUL+t6cIRovJXjOxFHkuCcU
	9Mv1YN9Eoif77h1Lx4qTehWn89OoJCFA7CMh1SjJsh9um+2lDLpe9oDjNlKF645Qox3uJz
	VrNrYqf23KOaCEN85J8qcaUk9seyxv/c6YVAYpdhguIYZeC03w+oEElVG11/2GWu8e6zEz
	Sbjp5bjBbtCFe9V2lzwRGKdLhbfwhLeOMwM1bUlTKk384jAOrs0MgGbbGwgIxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xK0ENF64hgvN5Ncmrhe7VwWzY4Hg4XyaQVQW40BKa7Y=;
	b=yOPagBY9nJUyYdIkZcQMDZglOnPkCVTbNMF2uykkaRatDYTd0ZmEiBbdA3XN3QFCcSGerM
	Nb6kuSmOD3iZq4Dg==
Date: Mon, 05 May 2025 17:15:26 +0200
Subject: [PATCH v4 08/14] selftests: harness: Don't set setup_completed for
 fixtureless tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-8-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=912;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1W401Ak+my+KrsBX7f3Aw19rJHwp1BqRjh0/vnd3peo=;
 b=zt07AZE1iAqoB5RVwEkxe7/22hfOoledCRaUcfDAmuUJo1mBj/htfrbdma++4R63qGzsDEaEA
 SM70KprOYDADcpprJZ7DzZCczbaaAJkwW2zXNjU7DJewBGmCSqXrK6s
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This field is unused and has no meaning for tests without fixtures.
Don't set it for them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 1e459619fe8657d7d213a7b16d7bcbc58e76e892..905986debbfb0ce8c9659dbd52b6c67c6759cae7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -178,7 +178,6 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \
 			test_name(_metadata); \
 		__test_check_assert(_metadata); \

-- 
2.49.0


