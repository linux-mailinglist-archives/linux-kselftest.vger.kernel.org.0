Return-Path: <linux-kselftest+bounces-10460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EF8CA69A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 05:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986D9282355
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 03:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6771798F;
	Tue, 21 May 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fX8m3HcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646B1CD29;
	Tue, 21 May 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260548; cv=none; b=W+hLtBUpcOM+E8e0rmKAo6iw/TO1svgRtkFPJn8gMqpqRn17hR9fwD9lepM5wlfW6JrlvzOO8TpGxTiDC7ecI2y3JDsDfe5n4W2BJMxZGLALxQBWLRn8e22jAxIE+B4R56fXtXUofoMbkt9MJMbg0qoyEAaylrFJJENsWQDkZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260548; c=relaxed/simple;
	bh=aBdDyPij/sIp+apfuyJJk1GdgzcvWFUBKtS1yYYBAVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rwf75+30O3M1WXRjaU7+qKIlSt6cQ+KPhewE2x8ou/KChaGuMt8PgnIppeCV4+XyyMbFGjP3+n6ASkGJcHHDyifebfcG2biykU2tJK98sjSJ13LsAOMqMsl0Wkf9uFS+P8TLKutCaeZ/9u+yYKqF/14otjvkaR92ufwkl/UgPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fX8m3HcC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716260545;
	bh=aZ8eL+an0k4EGUGhJYQuS679Qpvr/5jI+zIpE3s7TKM=;
	h=From:To:Cc:Subject:Date:From;
	b=fX8m3HcCBadlJFZVLLv4f/oG6DuCW581DUDftxw/5iZbT/ZzaUnPDTes22hq3B5RF
	 kDdM+FmBEsPArKY05nywjsUhfd3BK5b9i0YU13cFmyyX0NUkJtWFGZFNTod00s1ct5
	 bvBHu+zNrr346znIlfplZq97wjUN/CwpafLsnoSriZtDKoTQXQtUuPVULM8IXbHCG5
	 ZXQFn3eW4uo+tvYyGH0on3q4gJ1mPmkguAWI6ueKfJyEqOJfQnOyNs0gLtk5XeF0LV
	 p3PqmBEF901A/zVNYTK/unMIvL4NBhK4XGUf7jJOPu74AOR6OlQnyBDQd0BIqjQ4Vd
	 CkisghALVDOmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjzkS71Ghz4wc3;
	Tue, 21 May 2024 13:02:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Subject: [PATCH] selftests/mm: Fix build warnings on ppc64
Date: Tue, 21 May 2024 13:02:19 +1000
Message-ID: <20240521030219.57439-1-mpe@ellerman.id.au>
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

  In file included from uffd-unit-tests.c:8:
  uffd-unit-tests.c: In function ‘uffd_poison_handle_fault’:
  uffd-common.h:45:33: warning: format ‘%llu’ expects argument of type
  ‘long long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/mm/gup_test.c    | 1 +
 tools/testing/selftests/mm/uffd-common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index bd335cf9bc0e..bdeaac67ff9a 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -1,3 +1,4 @@
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <errno.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index cc5629c3d2aa..a70ae10b5f62 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -8,6 +8,7 @@
 #define __UFFD_COMMON_H__
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.1


