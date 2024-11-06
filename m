Return-Path: <linux-kselftest+bounces-21530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1A9BED54
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4C91F24BA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E21F9424;
	Wed,  6 Nov 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VPNk5xvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941F1D619E
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898305; cv=none; b=kaquZluLeFGntSFvXDuLM39c+zVlDVsI4dBD8gETrEIOVFnj+jaJ0jVxaEdNBWPOcahwk1JF05IwjP+oTERCmTSXIgegzaBOy1mjGGOFBfF1LZ+URKTyARzDVjZrKokgGDDEocOK5KjvvxzXiuWannJyzcI0aAi0Wr5weyNe2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898305; c=relaxed/simple;
	bh=r41l+nqKXUx08DDwDjlNtGJ7WvEcJB4eRA3PUeDo1GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKJ6aFcszwBkFBrQ+80TJpLRY/EGWWpGDkxcvX78a6fJ1SUyth0HT6YMmPpyeRzaOZU+ypZQy9nvkq8rEYcVD3DaFhg6WA+3TJCeqkHpuKrpbNP+sK7QecRUXnkkgXd7SCmpEi9KJB5bKKJX0UswTKvdITTsQreItpsp4LIrfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VPNk5xvj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898299;
	bh=B+DpJzUt5pgtyxVRT5MgXeyFDGbQoigs3Py0OrcwOvE=;
	h=From:To:Cc:Subject:Date:From;
	b=VPNk5xvjtYFlyRUdofY/HhRHBp4lQkzaONXCDrFDWh77HhouPj8EcPKpw5dJdp6zL
	 0/kKopZRW5A7LF6sNIgI+WHBfHys8KlGVP08FksOsy2v7/vYVBCb5eyUQ9ptgnBj4V
	 5P1Y5nxfArEPiqWTjyJVrrDuDtwFmnxoRpu2SkziZ5fQR6dKpZQxgbfRwOxwul2mok
	 A/9e2DVkqhWGoD/zWfTWWT6f1+czly3LWjAWeAmA4kh9LrDUU2ittQqACZ+uej+n7C
	 2OaQscQDBpVzaF4GCJpe+eZ/kHTey7pvU9+qJurWuzjaeHMJTSzbwpaaacBLxLyWE1
	 y+ytXvFKYvh9A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55l23S6z4x04;
	Thu,  7 Nov 2024 00:04:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/5] selftests/powerpc: Lower run time of count_stcx_fail test
Date: Thu,  7 Nov 2024 00:04:49 +1100
Message-ID: <20241106130453.1741013-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The count_stcx_fail test runs for close to or just over 2 minutes, which
means it sometimes times out.

That's overkill for a test that just demonstrates some PMU counters
are working. Drop the 64 billion instruction case, to lower the runtime
to ~30s.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/count_stcx_fail.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
index 2070a1e2b3a5..d8dd9a9c6c1b 100644
--- a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
+++ b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
@@ -144,9 +144,6 @@ static int test_body(void)
 	/* Run for 16Bi instructions */
 	FAIL_IF(do_count_loop(events, 16000000000, overhead, true));
 
-	/* Run for 64Bi instructions */
-	FAIL_IF(do_count_loop(events, 64000000000, overhead, true));
-
 	event_close(&events[0]);
 	event_close(&events[1]);
 
-- 
2.47.0


