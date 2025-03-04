Return-Path: <linux-kselftest+bounces-28155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D3A4D45F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1183C3A8F6F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A21F9F75;
	Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RzHzkkXH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1bb5lXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE61F8BAF;
	Tue,  4 Mar 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072276; cv=none; b=DyGalY3InjTcwQLp4xgeDABUTpc11GsdYIevvqmO+AdkYDHEpgpQFOPXsfLKfpkv+2oDxWYt/67MdlMEMz6RzBzKbB2WdIDw/d4Dg7VHA6Y7lVIDSh19GRYWBWupYcAjuoOST5kTNFVcs6F7AfDVuJf8xyCVjhUqUIpWO4JI+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072276; c=relaxed/simple;
	bh=5WjtgJ/PWjfO6GYXDJ5zRMdY1aRHo29DG+4wDLXv7tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bblDTGp+FjjfGOCj02U+NcOsP1gdXvcr5+WT8VBxV4k21jeSgx5xN2VZTNdnqXy9Si+tvrapqUgFSHydngYsGkzYj8L67vev5wD4sxn1kvRqvSjLjQqsidigOcmkl7lnmngE7cZXH86VqngyfbJuydtQ2fg0v5p8PfBF7to7UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RzHzkkXH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1bb5lXl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msz34P0kGVgxpW4v18ORw4au6ARuVBJ7iqcwqv9B1Lc=;
	b=RzHzkkXHa0sxKoFaa9zAnEWh1i/SuUiQdVEe9pGMG7sKJyVSIYlLQ7G2nPZYiUoR9KlsrF
	cvlWWAC6WDBB+5cR+TAsHmlPROKeV1TmCTd4h7cNGCeAhX68/Vc71aer/y8aHw/ozlH+sI
	+qthschvR3DnlCntqyys8CMcY+ktsh1WIQjx5fiI5sjO16Ey2vegHW72rzTD81N402A1/5
	KzPBMrlw+AVWix5u4GsvxcYdC8wmevf/zQ9FTLm7Iq81b50hAUok3SWMnXkOvRlmtGq40c
	jQ++OjZo30qrGDd/IHIR8K6yQPWvSE3n4HWi8Tiu7aCE/ojjvRFzOCgWP1eEoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msz34P0kGVgxpW4v18ORw4au6ARuVBJ7iqcwqv9B1Lc=;
	b=X1bb5lXl0AOcG8zRI+A7KWX4pw4bkDV06I95tBcg0Ftjktgb0eBodELmOqw7Uu91/SRAow
	C4f7/I8Ncb45y0AQ==
Date: Tue, 04 Mar 2025 08:10:39 +0100
Subject: [PATCH 09/32] selftests: harness: Don't set setup_completed for
 fixtureless tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-9-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=862;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5WjtgJ/PWjfO6GYXDJ5zRMdY1aRHo29DG+4wDLXv7tw=;
 b=xuP49fpOhNp6L5QJxlXpSFEkTowrxmqBmWrBASDwvsElRWiXjvIEuWfO9LcxOAiLghlU2Cpt6
 A/r5UQP6rUmA3y5IywTwpEwy88fNcuHN+PqTKCoDM4Acav/dcRxtBd9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This field is unused and has no meaning for tests without fixtures.
Don't set it for them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d265b45c86d03c6f854047138ee8dc19dcc7a4d9..df55b99d8abab2398d2eba5080c4d0c795688bc7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -182,7 +182,6 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
-		_metadata->setup_completed = true; \
 		if (setjmp(_metadata->env) == 0) \
 			test_name(_metadata); \
 		__test_check_assert(_metadata); \

-- 
2.48.1


