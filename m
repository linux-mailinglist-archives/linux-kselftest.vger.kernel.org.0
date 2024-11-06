Return-Path: <linux-kselftest+bounces-21534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661959BED58
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C91C24077
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185231F942E;
	Wed,  6 Nov 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iWVeUSPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCD1F893C
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898307; cv=none; b=WJXXJNQ4N79AWhjWjGdmNIIvFRknC2gD2jDMJC/4APU1uv5Z1YYa5X6kjcbyWT4CgPFC2BGLjNQoLO28iQZdp/oL28LH/Pp6dj0nMr1GQZhv1lEkqkzpJjCcJovINLepuS8A4o++dqa1aXMOpcWUeMkv6Yar5Rw6ATvTlcd82GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898307; c=relaxed/simple;
	bh=p9k+QwwFZEJbuk8CSc9GJF9fyiJfctDLnu0ro/S2A/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOxkEIaCeDFtqospxlhfaklq46LPbhs2w1OITcAKtkPkB5dDRsVXS1SJmetKJiK2PBj8RgWf+IC6jWJUiOGa0BTqTEXmv02u2EosAQrN8ywz3kUJxj4ZKlrcR53iDvCvr0dB5YUfbi6d6Fbm/2Z+KtXChsm4pS1H4Kfw88IqASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=iWVeUSPc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898299;
	bh=WfU8i/z+2ZqvHHntsfTG/VnP0MHf+Z8XIKjhNPJ5fWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWVeUSPcHVe9oorAhYOt8dSN9TztcXYRACyYt3LwYLcH+4Pdl0eK9IC9iUWpZnoRV
	 WQlr2umv/GZntTiD91nbsgKzL5/Qzv6Qy4fQDIe6c+O9nEGmyNiHOjV0gF2DNuKlTY
	 eBFC4AQux0Hc04NQWNdxbad0loOnTc8aFpI28rr+yTbathxda62hwVD75SuI1tEMXY
	 1DrrbXxsoCjNMiQXaJ1W9HcadUTq8ZwutrK0dmq+jpKVvRQPJD086OnB78p5V/18E2
	 feqtbrEdVXkzWxHdSidN5SZKtHNFBqUkpftzIhZQWWzd8IaYSws1iqpPw5dF8wqbXV
	 BdZWj3It4zkLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55l5jxnz4xPQ;
	Thu,  7 Nov 2024 00:04:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/5] selftests/powerpc: Give all tests 2 minutes timeout
Date: Thu,  7 Nov 2024 00:04:50 +1100
Message-ID: <20241106130453.1741013-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106130453.1741013-1-mpe@ellerman.id.au>
References: <20241106130453.1741013-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each of the powerpc selftests runs with a timeout of 2 minutes by
default (see tools/testing/selftests/powerpc/harness.c).

But when tests are run with run_kselftest.sh it uses a timeout of 45
seconds, meaning some tests run OK standalone but fail when run with the
test runner.

So tell run_kselftest.sh to give each test 130 seconds, that should
allow the tests to complete, or be killed by the powerpc test harness
after 2 minutes. If for some reason the harness fails, or for the few
tests that don't use the harness, the 130 second timeout should catch
them if they get stuck.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/alignment/settings       | 1 +
 tools/testing/selftests/powerpc/cache_shape/settings     | 1 +
 tools/testing/selftests/powerpc/copyloops/settings       | 1 +
 tools/testing/selftests/powerpc/dexcr/settings           | 1 +
 tools/testing/selftests/powerpc/dscr/settings            | 1 +
 tools/testing/selftests/powerpc/lib/settings             | 1 +
 tools/testing/selftests/powerpc/math/settings            | 1 +
 tools/testing/selftests/powerpc/mce/settings             | 1 +
 tools/testing/selftests/powerpc/mm/settings              | 1 +
 tools/testing/selftests/powerpc/nx-gzip/settings         | 1 +
 tools/testing/selftests/powerpc/papr_attributes/settings | 1 +
 tools/testing/selftests/powerpc/papr_sysparm/settings    | 1 +
 tools/testing/selftests/powerpc/papr_vpd/settings        | 1 +
 tools/testing/selftests/powerpc/pmu/settings             | 1 +
 tools/testing/selftests/powerpc/primitives/settings      | 1 +
 tools/testing/selftests/powerpc/ptrace/settings          | 1 +
 tools/testing/selftests/powerpc/scripts/settings         | 1 +
 tools/testing/selftests/powerpc/security/settings        | 1 +
 tools/testing/selftests/powerpc/stringloops/settings     | 1 +
 tools/testing/selftests/powerpc/switch_endian/settings   | 1 +
 tools/testing/selftests/powerpc/syscalls/settings        | 1 +
 tools/testing/selftests/powerpc/vphn/settings            | 1 +
 22 files changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/alignment/settings
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/settings
 create mode 100644 tools/testing/selftests/powerpc/copyloops/settings
 create mode 100644 tools/testing/selftests/powerpc/dexcr/settings
 create mode 100644 tools/testing/selftests/powerpc/dscr/settings
 create mode 100644 tools/testing/selftests/powerpc/lib/settings
 create mode 100644 tools/testing/selftests/powerpc/math/settings
 create mode 100644 tools/testing/selftests/powerpc/mce/settings
 create mode 100644 tools/testing/selftests/powerpc/mm/settings
 create mode 100644 tools/testing/selftests/powerpc/nx-gzip/settings
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/settings
 create mode 100644 tools/testing/selftests/powerpc/papr_sysparm/settings
 create mode 100644 tools/testing/selftests/powerpc/papr_vpd/settings
 create mode 100644 tools/testing/selftests/powerpc/pmu/settings
 create mode 100644 tools/testing/selftests/powerpc/primitives/settings
 create mode 100644 tools/testing/selftests/powerpc/ptrace/settings
 create mode 100644 tools/testing/selftests/powerpc/scripts/settings
 create mode 100644 tools/testing/selftests/powerpc/security/settings
 create mode 100644 tools/testing/selftests/powerpc/stringloops/settings
 create mode 100644 tools/testing/selftests/powerpc/switch_endian/settings
 create mode 100644 tools/testing/selftests/powerpc/syscalls/settings
 create mode 100644 tools/testing/selftests/powerpc/vphn/settings

diff --git a/tools/testing/selftests/powerpc/alignment/settings b/tools/testing/selftests/powerpc/alignment/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/alignment/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/cache_shape/settings b/tools/testing/selftests/powerpc/cache_shape/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cache_shape/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/copyloops/settings b/tools/testing/selftests/powerpc/copyloops/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/dexcr/settings b/tools/testing/selftests/powerpc/dexcr/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dexcr/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/dscr/settings b/tools/testing/selftests/powerpc/dscr/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/lib/settings b/tools/testing/selftests/powerpc/lib/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/lib/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/math/settings b/tools/testing/selftests/powerpc/math/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/mce/settings b/tools/testing/selftests/powerpc/mce/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mce/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/mm/settings b/tools/testing/selftests/powerpc/mm/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/nx-gzip/settings b/tools/testing/selftests/powerpc/nx-gzip/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/nx-gzip/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/papr_attributes/settings b/tools/testing/selftests/powerpc/papr_attributes/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/papr_sysparm/settings b/tools/testing/selftests/powerpc/papr_sysparm/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_sysparm/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/papr_vpd/settings b/tools/testing/selftests/powerpc/papr_vpd/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_vpd/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/pmu/settings b/tools/testing/selftests/powerpc/pmu/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/primitives/settings b/tools/testing/selftests/powerpc/primitives/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/ptrace/settings b/tools/testing/selftests/powerpc/ptrace/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/scripts/settings b/tools/testing/selftests/powerpc/scripts/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/scripts/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/security/settings b/tools/testing/selftests/powerpc/security/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/security/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/stringloops/settings b/tools/testing/selftests/powerpc/stringloops/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/switch_endian/settings b/tools/testing/selftests/powerpc/switch_endian/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/switch_endian/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/syscalls/settings b/tools/testing/selftests/powerpc/syscalls/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/settings
@@ -0,0 +1 @@
+timeout=130
diff --git a/tools/testing/selftests/powerpc/vphn/settings b/tools/testing/selftests/powerpc/vphn/settings
new file mode 100644
index 000000000000..2e8566183318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vphn/settings
@@ -0,0 +1 @@
+timeout=130
-- 
2.47.0


