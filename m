Return-Path: <linux-kselftest+bounces-7288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5C899E28
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CFF283D64
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C733F16D32E;
	Fri,  5 Apr 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4kK09E5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D361649A7;
	Fri,  5 Apr 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323095; cv=none; b=BoKSA5+coaCq67+2Dhy9KOeWp32oXcdwS/LTCRxgj/U2T7NBUyca0L9ws9U3eBrFmk9If9pJyplZVUMqkZDRfDWs3u/6sd/GK7fBtwX9M/9TOfYG6s6fbw9txwki2EDk45lYTvicsiCQ+RPZW0eEZxtUZQDPvlYAgixzPzjA/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323095; c=relaxed/simple;
	bh=BK5hFtNFiolnEtNNhwHZpqgolDF4VaR+KUumWAMdM1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2uJmWKXU8HjhPLdKKBl0o2VU70uLpEBOc1DZsFCdM4IyPGynHF1K5LMEbo5ecqv6HkAGCVM4qa2vNhLHrwt3kVJo3bwGH5/70RpSC/xKzXj7+JCPonBNVt8SdpquKsQaZIplYoCUGDoSnz1V+tnmF0TjLwgXlg9uSAH2IBfbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4kK09E5y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712323092;
	bh=BK5hFtNFiolnEtNNhwHZpqgolDF4VaR+KUumWAMdM1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4kK09E5yM/N5Y46oRwtZvG0xaYdNBBoY3Ta/kCD2Dd8fITbqzSB5MwLHdpIW7s4AH
	 JzH0nrhZbvvcMIrGOvKMvQnlWM61Nd5OFA/gzFVjQz3Jnyvtyd19UsH/kpWJksWxM4
	 +sPw0Z0FyE7PMG0VFYXfkpdg1Sw8rEQNABIfAAJ7io5IPY5NmRJJfK2nZq/wxO0l+x
	 lbcrt+IIdt6A5qXttc/8wQVlTDxGijbu/zXutjxLKHYU4aOn1TLPfX5jK6LVD32K7l
	 PzdCEJHiehqOONBXTYyclHJS2hzL4CPES0e+64R/YKbXqGL883xWem24jsls29s614
	 h/cQQDqJcwqUg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDDEA3782131;
	Fri,  5 Apr 2024 13:18:08 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 1/2] selftests: Replace "Bail out" with "Error"
Date: Fri,  5 Apr 2024 18:17:47 +0500
Message-Id: <20240405131748.1582646-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405131748.1582646-1-usama.anjum@collabora.com>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Bail out! " is not descriptive. It rather should be: "Failed: " and
then that added prefix doesn't need to be added everywhere. Usually in
the logs, we are searching for "Failed" or "Error" instead of "Bail
out".

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 2cd93d220f434..9d1d8c5a73ab2 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -362,7 +362,7 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	va_list args;
 
 	va_start(args, msg);
-	printf("Bail out! ");
+	printf("Error: ");
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
-- 
2.39.2


