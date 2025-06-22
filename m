Return-Path: <linux-kselftest+bounces-35569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98131AE2DDF
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 03:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB741896F55
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08721E522;
	Sun, 22 Jun 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="hXjwLuwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB943D6D;
	Sun, 22 Jun 2025 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750556791; cv=none; b=Y0ODZQ9oexBSriCIw0KRUC7HziBSXC3pnvBmHa1ZpLryD1wzhoD294wLMgi4CNBUYAbxx/g+nGeTJ30RqOszCJtqiSEo/G+COaZkjs7h7yTiF9dkKDAfAiDeiQHe4G8nHPco8q4o4nfy35UfGOkpTrHzt/jUgBkw1ioeciNPCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750556791; c=relaxed/simple;
	bh=AN5131Mm1n+8HdUbVxXvNVP6U76CHnRvB/+o4zWGGpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKt5u63BGNJqtJAasBPK5ih46n/ROUbGAWE8AXwbTUn0MoWm3GwxMfPbGJFXFvdZkXxTUlnfA4Fgm7vkFXij/kDvznW7DDKZuzpEYnfokIihAyOhOH/QGLdHnRv6t7XaUPikjWowzptIYAKH5HiKhwSpihxxW7X857M+BKHwiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=hXjwLuwD; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id EE1E97D3B8;
	Sun, 22 Jun 2025 03:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1750556778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W6g0s3Gqz2pdEiwPOReNRUEKqqIiMTjDOmJeywOhnms=;
	b=hXjwLuwDs3jQr59YjbLNBbxIDz8Ud+SLpc2OGctFsm55AkJYcHJelgkrytdgpvuUIgoNq+
	c1+r5I/Lp19vymAHnTVPYd8sO1QjVS5pKXaY4lqCPqtZz2QJ7f7U0t2lx26VnGnrDZc7TX
	U0WWJ1f56JiKjmsAp4bkJzXyYAmJ4hE=
From: Achill Gilgenast <fossdd@pwned.life>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Achill Gilgenast <fossdd@pwned.life>,
	stable@vger.kernel.org
Subject: [RESEND PATCH v2] kallsyms: fix build without execinfo
Date: Sun, 22 Jun 2025 03:45:49 +0200
Message-ID: <20250622014608.448718-1-fossdd@pwned.life>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some libc's like musl libc don't provide execinfo.h since it's not part
of POSIX. In order to fix compilation on musl, only include execinfo.h
if available (HAVE_BACKTRACE_SUPPORT)

This was discovered with c104c16073b7 ("Kunit to check the longest symbol length")
which starts to include linux/kallsyms.h with Alpine Linux' configs.

Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
Cc: stable@vger.kernel.org
---
 tools/include/linux/kallsyms.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index 5a37ccbec54f..f61a01dd7eb7 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
+#ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #include <stdlib.h>
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
@@ -30,5 +31,8 @@ static inline void print_ip_sym(const char *loglvl, unsigned long ip)
 
 	free(name);
 }
+#else
+static inline void print_ip_sym(const char *loglvl, unsigned long ip) {}
+#endif
 
 #endif
-- 
2.50.0


