Return-Path: <linux-kselftest+bounces-10461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DD8CA69D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 05:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D191C20905
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0989179BD;
	Tue, 21 May 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="m5gUyjqH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CE12E71;
	Tue, 21 May 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260610; cv=none; b=LAoBShA1cVNnM+q9n/W0aEHFOt1DXejFHQ00tLn1Bb8ns8ZZNA0xcuHHRXbdGc7k0RO4SePjtsGUvZRyj4Isevwa63gqB2OOC9B2inyF0qYnGdvYkwrs2awCJtWRHZKpi5UzdC/JCy2Y9CR31ClmAdvYeOJXt9nriaHic5mP8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260610; c=relaxed/simple;
	bh=wDSf+FvrOaDadq0LQ7KBbO3Q2DI+vTMu4WeT4Ed+Eew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qmlSFlHrmDfxoVJYCjeAoMNhLB3QsXxSz8GYzq4ac6XM6X7uakGwZvIoYMQd+42qGFyGWHQUhVWNQlCJrZOiSAWt3MOJ2LsFQ+0Ok46zr3zhP7oBR5FkrmGepPaCPKnfAAht1NLIIzfvYcvfIblP2UJsErWiEFBkaYQALuN09NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=m5gUyjqH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716260607;
	bh=3yH4cgYMMAaGxLPOXrePnEWcnTlrV3DTHRbjwYgEkJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=m5gUyjqH6+Ol/OHrz8w1vc1BN6Bphq+1c3tVchEXLqPOd0FlVslFIuJG0mgT5NGTW
	 0Hvc1yQww5wZU+DebLIfjos8fPtps8W/99f4NZML1F776WX07HDyAbfCm4bcQ3D9Jx
	 kcIhWHrwFrD/R26FJVYowzA6rHjvFGZh5bLRc+qLj8UF6Dcs2TCXdLPrh+cOdSCQq6
	 J+gYp0D4JWIwnxeTbcOhEC3cCeNZAsryaBpM1rmyBkDzSgmUqRFdYAMdDcmjLJzF7H
	 JmWzdlyaxqhr5HPqOAuiEu5eMZzykYi92t6CMinywg3dY4op6NYvNyKRRuJyFtapNC
	 kN3fsS7rZErwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vjzlg0VTKz4wc3;
	Tue, 21 May 2024 13:03:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] selftests/openat2: Fix build warnings on ppc64
Date: Tue, 21 May 2024 13:03:25 +1000
Message-ID: <20240521030325.58095-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix warnings like:

  openat2_test.c: In function ‘test_openat2_flags’:
  openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
  ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/openat2/openat2_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b2..5790ab446527 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.45.1


