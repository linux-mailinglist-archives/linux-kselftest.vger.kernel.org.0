Return-Path: <linux-kselftest+bounces-22658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507099DFB78
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118C3281D76
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334B1F9EB6;
	Mon,  2 Dec 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEQM101d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F931F8AEA
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126161; cv=none; b=BpUQvXjDriGeIp953w80EwdsbqHwi/QKHXLtIUWbbpXpNVn0OSHxZfaBkHRG3mKArFhQCYoX7NiNF2PKGC7rw1KaPuge7WdRhR1p23bsHNaqETK+4VPyM1S40MMgHvfvT9plCgap1qAFeEslVCPcc+5TDsodi08RImUcdxBO45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126161; c=relaxed/simple;
	bh=CcwBr1pdX1hbhnO2lIC3mhYlJa/UfgyYzruDoRr12f4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSc+cN/fzVCLltqci3rTvWxvmmfDKiUHTxz+yno6U3sdnhEW+hiZ+d7QklzpXXbH4uClShUIIWBDGB2+PFDWXDyHGv29AD73bO9MEocEupnn82UJigkV1E7UW8uqMwOfDtbuuAZmtwhu89L2RR1+QxeWSDWAofDYbCFbcdRu7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEQM101d; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so19848325ab.0
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126158; x=1733730958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94n4MHfZago95H2Ehby0lfepfNkVyiA7XUKBvPRgGq8=;
        b=kEQM101dV0bvz4Mhj3ghpczFChLIvm8u7YC5oBc1I229FCC0jVf09JWt8i/85x/ktV
         sDMgGO1DK6T5Qa7kohOpiye6+B6C6HNWpchj59cSsrrDw6UiQSDzt/2OR84A69HQAn50
         McYnGcHVaTZ90e6IuzZH6iKRxyk4a9Mgafo9so88PAqNW3KXMHCz4N8ht1FLEUXINPHF
         MLVdhp5G4Rnpco7uSWZ3LKud9GmMuyymP1lmuZS5eJby4K+0rKSrntlp+ld0CB6fxt+X
         f0HIwES0OPx0Zpin/GHc/DcU9trDe+QRXpC6aj+ToBM0oHjKvpJDMRT+PbEvVjkCqxW+
         XaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126158; x=1733730958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94n4MHfZago95H2Ehby0lfepfNkVyiA7XUKBvPRgGq8=;
        b=Y/h1Vvsb7sWyTascB38z86rpKeqW48BKj3S4krhuVSn49Q8ylnbVof5srys7D/1Nge
         5TcElbX43D9X9R81MfSvH3uEHjFfR1OlQLpE07xxF2pz89N1o8951Z37577DU19FVHSO
         s04jwVYDQrk87W6ojSMbv3U9OlwPJvN7gIq1IN+wTV3GTHXrmr2y7xXk24MjKaotDGcZ
         LXXmFYGN6oDqkkxYyWcYnRAI2dCoCfW1ZWF6zilhT2w1R2VED/ClFaxKidnBGbaBODQj
         rghzfnAxB++jEJCri4zN+GG+OcIr7aPG4ofEUWtFi+lyDwk57esIOH/Ew2TANwXTFanl
         x7JA==
X-Forwarded-Encrypted: i=1; AJvYcCVPrQUC4ihIJ5tOxBDz9oQE+LRY9B7RhaGcZyc2U3UviLNzOqNLKEzzBsQINXE69TXVPngmcgaUNnTIsGtaIU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71NDwROQXnZnyhX/6edBdbPmImF+RSPwkJChEm5l7KOgqV5Km
	i5BJsm22Nh6qhILKFgwRAS8cAtQWgEZaytMSoVo95XCRms+X+11ic1tGgUJG9Ko1f06zCfMOE1v
	tzrUyd1MnJQ==
X-Google-Smtp-Source: AGHT+IHuIFBcyPiV7QsjE3NU9vB7h2NpBJQm7Zferw0a07aEtyytICdGZvKQpzCBq7/XmaJK0mzFFVq/BDqupQ==
X-Received: from pgcv26.prod.google.com ([2002:a05:6a02:531a:b0:7fb:d8e8:ded3])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:194b:b0:3a7:9533:c3ac with SMTP id e9e14a558f8ab-3a7c55259cfmr190932205ab.4.1733126158041;
 Sun, 01 Dec 2024 23:55:58 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:38 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-2-davidgow@google.com>
Subject: [PATCH v2 1/6] lib: math: Move kunit tests into tests/ subdir
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Nicolas Pitre <npitre@baylibre.com>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

This patch is a follow-up task from a discussion stemming from point 3
in a recent patch introducing the int_pow kunit test [1] and
documentation regarding kunit test style and nomenclature [2].

Colocate all kunit test suites in lib/math/tests/ and
follow recommended naming convention for files <suite>_kunit.c
and kconfig entries CONFIG_<name>_KUNIT_TEST.

Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Acked-by: Nicolas Pitre <npitre@baylibre.com>
[Rebased on top of v6.13-rc1, removed non-kunit tests]
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug                                    | 2 +-
 lib/math/Makefile                                    | 4 ++--
 lib/math/tests/Makefile                              | 3 ++-
 lib/math/{rational-test.c => tests/rational_kunit.c} | 0
 4 files changed, 5 insertions(+), 4 deletions(-)
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..7b90948666bf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3145,7 +3145,7 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
-config INT_POW_TEST
+config INT_POW_KUNIT_TEST
 	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..d1caba23baa0 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
-obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+
+obj-y += tests/
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..8ce8040e00c5 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
similarity index 100%
rename from lib/math/rational-test.c
rename to lib/math/tests/rational_kunit.c
-- 
2.47.0.338.g60cca15819-goog


