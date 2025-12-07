Return-Path: <linux-kselftest+bounces-47228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1ECAB062
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F3B304EDA3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799BF23958A;
	Sun,  7 Dec 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NleFqwVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F51DF723
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Dec 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765073853; cv=none; b=AbCoAapvl65rwSlWq+8nLRIhla45vaImtpXSeWnHwyd/BVE9Ya/d+v1PG3aEpR0QlJfx3/X6fgqB5HZIl+1W7yfLLE2Px4lVaUn4g00PyYl6DQg9BksrDJGNNEnf1leNd1RylyUz4+qYxm/SEzEhHotE5CjwrQPla3CAECB4GZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765073853; c=relaxed/simple;
	bh=ZeDEoEYw6cZZSaFsBUQAMSYy/zv0dV5vDroxVNh6NkQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MOrSubKcxcJNuEWHMz1g/f+w9QSOlwdz89QA3gXZNYsakOMglZZGM2Co1+XsSMLr8DbOM1ToLPLA3xj9UH8RRLHAFl0cf4lIXQ0VCGhTdAu3mlKuEzDK7iy5cRyrXYX8S4lVVLQQ1l/jN17ctNap96mGbdycg2ig+6WEbnx9E6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NleFqwVU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so23162845e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765073850; x=1765678650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJGTtC/FtcaHp5tPN0jgECUq27SXr5JeYtrVcu1GDOY=;
        b=NleFqwVUzjwyd0t5m+ow9HJI5rINHT2hOUHbyJOQ6hmeErp2UaTYl3Cl7PkHyWowys
         UCm9RA77726lt4j6egHEnAKi9cP32DXAcUQYnr73iE5YS+6io1wF9wp6nJQEB19JrhNq
         smyn5bX5Qup0/0RRnxj02MtpAUXjcVrWTWmeljU/Ml66m1PD75oM9VfJ+G74t1VpXnMX
         gE3crutVEWq37SL2kvZAODh+sONHQSjDAaKsz6WouSzU6Kj1S+pSvMR0NG9afMf8jGHP
         2NHEFvlpgEm2lTn8H9aEDHFvIt6Y4JTkpj2D7YuFSWvu712c5CJK6u6PTpoQkC8Dna0C
         lxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765073850; x=1765678650;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJGTtC/FtcaHp5tPN0jgECUq27SXr5JeYtrVcu1GDOY=;
        b=oyQThUFWboDQk8kJNQIZMYNmmrGPThD9YNS8Qt51hkpEVI9YQm0JpNEaUSaySMpgj+
         q4M4TQtT4OCNAyvfKmZoKZrrC3cf980gBueCKXmvl7i2ACNALfrVOZnnzfscZXyEr+UY
         ReGQBRcCwxFB3ybJCbALzp+yvqMlL3K9AxEOkjgDQn9zeEZWd1yhHVYSMUJhDYzVBZTE
         IuNXuyhP6/Ki8+I1YjxKb6pc+LzhqZpaxsHplzGSu5mMl5wq3+3ZfhWGnbVpgMk/lNIX
         J++QpnASUfSLLMvGYkAXoldX1avZBmlHdqVArl2MyNuYpSk+PAiCzvRaXNe2HU3uss3C
         XNuw==
X-Gm-Message-State: AOJu0YyJYbYeFqkqJpYDNbQYjvtqqlcAbc0AntLoz5RF1N6SYOs3iSbe
	m1sUxLWyFzQWdDSLaAa32yM0wedBgk63G5So/ZmZGZt2rKvktYSpTjuoP0lpZTyFevFOu/ed13M
	x1FqlZAlrTGgsuw==
X-Google-Smtp-Source: AGHT+IEQBDkYxcCvAzo4pRuQ0DhuSmH7DlNXfnOh7T87C07e/Lx1KAkFTaD82wMjH02A6+Z7KFbC+jadl0cCRw==
X-Received: from wmoh18.prod.google.com ([2002:a05:600c:3152:b0:477:5ad9:149a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e09:b0:471:1717:411 with SMTP id 5b1f17b1804b1-47939e378d2mr47889665e9.24.1765073849921;
 Sat, 06 Dec 2025 18:17:29 -0800 (PST)
Date: Sun, 07 Dec 2025 02:17:10 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKbjNGkC/x3MTQ5AMBBA4avIrE3SFvFzFbGoGkzIkBaRiLtrL
 L/Few8E8kwBmuQBTxcH3iRCpwm42cpEyEM0GGUKbVSJyyl84GjP9UDZcLfCDqnuB0dVXqlMQ0x 3TyPf/7bt3vcD5lx8CWYAAAA=
X-Change-Id: 20251207-kunit-fault-no-panic-e9bdce848031
X-Mailer: b4 0.14.2
Message-ID: <20251207-kunit-fault-no-panic-v1-1-2ac932f26864@google.com>
Subject: [PATCH] kunit: make FAULT_TEST default to n when PANIC_ON_OOPS
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

As describe in the help string, the user might want to disable these
tests if they don't like to see stacktraces/BUG etc in their kernel log.

However, if they enable PANIC_ON_OOPS, these tests also crash the
machine, which it's safe to assume _almost_ nobody wants.

One might argue that _absolutely_ nobody ever wants their kernel to
crash so this should just be a hard dependency instead of a default.
However, since this is rather special code that's anyway concerned with
deliberately doing "bad" things, the normal rules don't seem to apply,
hence prefer flexibility and allow users to set up a crashing Kconfig if
they so choose.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 lib/kunit/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 50ecf55d2b9c8a82f2aff7a0b4156bd6179b0a2f..498cc51e493dc9a819e012b8082fb765f25512b9 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -28,7 +28,7 @@ config KUNIT_FAULT_TEST
 	bool "Enable KUnit tests which print BUG stacktraces"
 	depends on KUNIT_TEST
 	depends on !UML
-	default y
+	default !PANIC_ON_OOPS
 	help
 	  Enables fault handling tests for the KUnit framework. These tests may
 	  trigger a kernel BUG(), and the associated stack trace, even when they

---
base-commit: 7bc16e72ddb993d706f698c2f6cee694e485f557
change-id: 20251207-kunit-fault-no-panic-e9bdce848031

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


