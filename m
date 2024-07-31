Return-Path: <linux-kselftest+bounces-14568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA619435AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B221F27470
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642C45C14;
	Wed, 31 Jul 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TWm8mFOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AC39FC1;
	Wed, 31 Jul 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450758; cv=none; b=ASOfKtrdlXw6kbwcRatuOMyHt3gWt5fU8qhK7rYzt7D18rBbmxGlMx9iqMFQEs6AmrmTRJASF0t7sT3FJwjJnHNZQzEjpLV/aHu/vWgtTl5u3EaMuWw9DDMfY+ljRrSeo0hUVjonUUinjJdUIb3RHGDJ8YVb9g0VgSap4dERVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450758; c=relaxed/simple;
	bh=hhma+iAZyJ0RGsjQ1P0DMANEGea+kZjZQTE/CVE9L5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7xuj/N4OfswYjkph7z9umXExqYTHW+ztvl3jEffFmlXbRub5dvhYbyb7nq0CdABJ46eFnZPon9sbqsdMoHumR1tKVGSzlCVNsMDD5CZQbr4XEu9LPIjSYeGeHf4DWwGhBHUFtY8lXv+9r9opa94krsmzauKe7X2J33CfNkJvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TWm8mFOb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722450753;
	bh=hhma+iAZyJ0RGsjQ1P0DMANEGea+kZjZQTE/CVE9L5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TWm8mFObpG0c4uYZgP4QSKRzwyPtZasQS1cVwbPzcYRx++gTyX8DxdZXc0ujEYZM3
	 C0RrNrnZIQ05TYteQLfk+SXlAtJnwuZQgU3TzvZZenSJJfLR30rJ5NfYKdrOLfxP3w
	 mv9wQu2xO9gVcph4DbOp8Xzp9JjAox0sAB+XCRUs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 31 Jul 2024 20:32:08 +0200
Subject: [PATCH 2/2] Revert "selftests: kselftest: Fix build failure with
 NOLIBC"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-nolibc-scanf-v1-2-f71bcc4abb9e@weissschuh.net>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
In-Reply-To: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722450752; l=1271;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hhma+iAZyJ0RGsjQ1P0DMANEGea+kZjZQTE/CVE9L5E=;
 b=v2MyLloAP1yn+Koe9/hLnFmkAkonAkIjcu7OK6IUcxZ/BmDgp7wjgx+9aheaWosKHWY8t/PvO
 XYRUlLt3u6nAmFjjA0CDur3Ti9gMalAt9t8pzU0f8jq+EGbmIUJXkWF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This reverts commit 16767502aa990cca2cb7d1372b31d328c4c85b40.

Nolibc gained support for uname(2) and sscanf(3) which are the
dependencies of ksft_min_kernel_version().

So re-enable support for ksft_min_kernel_version() under nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/kselftest.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8967b6e29d5..f0c4f62e2949 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -426,10 +426,6 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
-#ifdef NOLIBC
-	ksft_print_msg("NOLIBC: Can't check kernel version: Function not implemented\n");
-	return 0;
-#else
 	unsigned int major, minor;
 	struct utsname info;
 
@@ -437,7 +433,6 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
 		ksft_exit_fail_msg("Can't parse kernel version\n");
 
 	return major > min_major || (major == min_major && minor >= min_minor);
-#endif
 }
 
 #endif /* __KSELFTEST_H */

-- 
2.46.0


