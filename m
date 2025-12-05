Return-Path: <linux-kselftest+bounces-47118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4ACA8967
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7301530C0C85
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27A348440;
	Fri,  5 Dec 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YTeIx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BC33554D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954749; cv=none; b=J/q4prabhE1f+7yhRJiMfg8kyiyfJ1kfqz+nP6ckES6suvUqfvYjBs226TwXYixQaOUKwlMMsLLb59MTNVlXY7F77VNVEoZyON8rQb712qZRk0QCwuJ04y0WzjffOKb6PJs3POOIIRFIA8yyEG/awVo+pgjQVS73tgaL5D4MPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954749; c=relaxed/simple;
	bh=M2vFDyyUfG7JkznxChmdBB4qNaHZV2aWYVJ2i7s0Hfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLkq1GTseskIsDkt5ETC9s3JTHq2z5fhhpIc3a9x19xjeZk+kDSLWKqktpbM7JvBxo9Lx/PXpVUIG/8dCLvIr3latK7FhpjRJcGFnvvpIOYvH4FlKSMvWk33+Y0SycW2ieEAJtyKaZCDlrRm38dwMHou0cFFsmlmHVIwKDIdPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5YTeIx5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b98a619f020so1771565a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954738; x=1765559538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vBZwIvLvx6D7o9yPmhW2hQH1LVZ8ZbPnLZnaPeYgfI=;
        b=b5YTeIx5tQetKP0xsFxE6Xqgr9WAqiYEYngVQjIgoDX2C4ZRKp7GYZSP7ZtcQZr2er
         R4Cz2RAbfV9iq/ksTAFCv+o4JpURo0vMtLMSORnEHm+OCO3z2z3mfZivv/64YEHqZj9h
         GcVU9Dza2wZwaiRxEGtE2TpZuZpUatV+A1yudGhDm19BYNlaU+TBw1csq/jK6kfqM7UJ
         thgHXCzMba1QflmatWQwucm8GjeeDPYR6Iph7yrZszQJ4GzsybIoLz7qYWMc8iK7p9iE
         8sMPlpWsdq2ZOJO8bh/+cPiK8sv7oeCFB6ktM/IRHzhwsqcY/3IRmpcxHUI5o+eEANZM
         v+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954738; x=1765559538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vBZwIvLvx6D7o9yPmhW2hQH1LVZ8ZbPnLZnaPeYgfI=;
        b=ZoYEtkJ3bKux9/lgGaR876FadJgluO/okx93fk77yOclZ9cUaD5JAiqu5SGcOMVpup
         LsGTaS7HOraJchGFcakkDdNZzpYGMgsDhUaw3XZJo0vQHUtT+5rTWcfBJPmeNCqRnqfH
         Kt4k/C8pjshgQzN2armvPkEurSf3dp9R+J5JNrRFiTDpdgP5POLDhpETG1TY2t5uLE20
         mF0Olxw0+7TzdSjI8cJdXlOTq0HBTg5TRfh4tmGnpS9KIhT5/nbg+KlsZTmfVz6kDu7T
         AgZY6IpqRnVSKRPr1zuUs3enPr7VpKzP45iDmPent+9gU2l/WKZZkIpmpUGCzpoWqlva
         nElg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Osj6W6qKNE1/x5jCDGFfQ0kDSpfTenD6IuwmuPY/sT+khdrno5K9daWrxPuOwvbtSti40K5L4tP5dKBnN8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1B2YCdiIo2ItEo6/+QzoEOIA7yQnPSY/bXrIfHD9F48QnPOL
	Zz+4j11J7ho8EN1DiyxTbEcE2gCN6XDOD9zFGwavCYFYRLIn9CWPq//m
X-Gm-Gg: ASbGncvx8RGC3fdYtPiXkq9aFniMEixRBsoaVS17DQJEz5Hy225zPpr5IgiJWTinrCy
	y08Gwwks0kzCAHr5WRQLQH4xcfG9Uy8GPwLS7EEQoK3HtcDrNFwFBjDynncA4oaUUPpyjygvKfn
	477c0bxfp+UfmMP95VI2UPCrdRPbVPGOYdcPhvKw5SLCGlSKoBt5/r/0Cgs/UP+vwdZjR4hanrE
	zV9J95XSAaujvlrcmgF5fMXZIqneT3pv2LKX8ANFCxODpzT80W47pdKKNX7L6zjYq2LQRGZZaku
	lA/SrVs0Bpdw8xoFbUjqKCgfYLJ0QSKJboBeSUr0UczoUQU8tdO9NLtXu3xqoBMs4kIIOs4TQ33
	Y59EPp6lcBN6G1v+5X0UvoiVCYPUPoEK2yd2TpqY5f0bezzkqzxG0nJHGOgtXP3GWEBKyFw2EeY
	HNJVXTP3wljxdtxto/+zSGEJtD5jp6jifsFA==
X-Google-Smtp-Source: AGHT+IHedJC93D+L43aGh0gHVYz0R+imftKPymAfmBV+49IIc8qNl+K0a9+Ao52i2Vy/p8ADlA4ahA==
X-Received: by 2002:a05:7022:6722:b0:11b:d561:bc10 with SMTP id a92af1059eb24-11df0cae991mr7658546c88.41.1764954737734;
        Fri, 05 Dec 2025 09:12:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm20209499c88.4.2025.12.05.09.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH v2 06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
Date: Fri,  5 Dec 2025 09:10:00 -0800
Message-ID: <20251205171010.515236-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix:

gcc: error: unrecognized command-line option ‘-Wflex-array-member-not-at-end’

by making the compiler option dependent on its support.

Fixes: 1838731f1072c ("selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.")
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Just using cc-option is insufficient since it is not defined,
    and if it is not defined it just disables the option entirely.
    Include Makefile.compiler and declare the function locally
    to solve the problem.

 tools/testing/selftests/net/af_unix/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 3cd677b72072..4c0375e28bbe 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,9 @@
-CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
+top_srcdir := ../../../../..
+include $(top_srcdir)/scripts/Makefile.compiler
+
+cc-option = $(call __cc-option, $(CC),,$(1),$(2))
+
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
 
 TEST_GEN_PROGS := \
 	diag_uid \
-- 
2.45.2


