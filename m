Return-Path: <linux-kselftest+bounces-8656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD58ADAE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 02:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36851F20C3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 00:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58B1C8FB1;
	Mon, 22 Apr 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFnUcEP9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BD158DA1;
	Mon, 22 Apr 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830357; cv=none; b=tgjNKuPrekLJS2mA49tVNUq+dbGa7NyBy2Gr5v6KcqugQPj27xB/HpHSpPhOW6cKAeYny6PljB5SdohkpbuRhP8DwC5YLpXnq4i7N6EY0pTzepyyaQJmxKkZ+I3xKTPsn/hXjSauh8y6UDJrkT+oaIJE4P6OdCHH3/wQygxM0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830357; c=relaxed/simple;
	bh=WQkBgi+Eaxxbb+FX/HL3Sm6zB6RvXwCNsTnQSDnjwh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8KuBjzf/LYtUtR3H+sDr+rRJ8+tOqoNQBcL/uZ0tUbxSdL5f9ZzwrxbfYte+JvLYYPaceq0M/LK5QdzhT9jnUd4WfKfAkwbFUqi+C9go/pwX9czpF3GuX5wdDtzCsz9LAH4paBYPh+pPIaQ9xzLY5S+pykQirFG4O/jacsgZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFnUcEP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EBBC4AF08;
	Mon, 22 Apr 2024 23:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830357;
	bh=WQkBgi+Eaxxbb+FX/HL3Sm6zB6RvXwCNsTnQSDnjwh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFnUcEP9E5lgPEKOM9GYPYukV1h/uixc25cftIt7aW2Y1x6EXnT/N04blY6vx0vvy
	 Xfr3eMW9emN27QOL6cWooAWC+sPKjcQCdLOQxU4aQInzLzUnddcgUHPa9AWEBaicKw
	 owAdBbu4sZPbUaHcsdicn34NXLi7hNtWlHUZShPOxe62ElhHS7Cv8CuUR8JCp/ZT8C
	 6GdXNSYCN5mkUgwvr0OBaNsgTGiIHD5eieEfxEOvUWCN4lQ4nlRymP3Okk8JZjPolR
	 tWowUMFIbwGK3yl4KpkDCv0T9B7Wi6BcKJsc7JoZaQIXQteydU66V2KZJJ3svVElDo
	 FgsvCPQ9tELMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Lee Jones <joneslee@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	nathan@kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 8/9] selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior
Date: Mon, 22 Apr 2024 19:20:13 -0400
Message-ID: <20240422232020.1615476-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: John Stultz <jstultz@google.com>

[ Upstream commit 076361362122a6d8a4c45f172ced5576b2d4a50d ]

The struct adjtimex freq field takes a signed value who's units are in
shifted (<<16) parts-per-million.

Unfortunately for negative adjustments, the straightforward use of:

  freq = ppm << 16 trips undefined behavior warnings with clang:

valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -499<<16,
        ~~~~^
valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -450<<16,
        ~~~~^
..

Fix it by using a multiply by (1 << 16) instead of shifting negative values
in the valid-adjtimex test case. Align the values for better readability.

Reported-by: Lee Jones <joneslee@google.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240409202222.2830476-1-jstultz@google.com
Link: https://lore.kernel.org/lkml/0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/timers/valid-adjtimex.c | 73 +++++++++----------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 48b9a803235a8..d13ebde203221 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -21,9 +21,6 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  */
-
-
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
@@ -62,45 +59,47 @@ int clear_time_state(void)
 #define NUM_FREQ_OUTOFRANGE 4
 #define NUM_FREQ_INVALID 2
 
+#define SHIFTED_PPM (1 << 16)
+
 long valid_freq[NUM_FREQ_VALID] = {
-	-499<<16,
-	-450<<16,
-	-400<<16,
-	-350<<16,
-	-300<<16,
-	-250<<16,
-	-200<<16,
-	-150<<16,
-	-100<<16,
-	-75<<16,
-	-50<<16,
-	-25<<16,
-	-10<<16,
-	-5<<16,
-	-1<<16,
+	 -499 * SHIFTED_PPM,
+	 -450 * SHIFTED_PPM,
+	 -400 * SHIFTED_PPM,
+	 -350 * SHIFTED_PPM,
+	 -300 * SHIFTED_PPM,
+	 -250 * SHIFTED_PPM,
+	 -200 * SHIFTED_PPM,
+	 -150 * SHIFTED_PPM,
+	 -100 * SHIFTED_PPM,
+	  -75 * SHIFTED_PPM,
+	  -50 * SHIFTED_PPM,
+	  -25 * SHIFTED_PPM,
+	  -10 * SHIFTED_PPM,
+	   -5 * SHIFTED_PPM,
+	   -1 * SHIFTED_PPM,
 	-1000,
-	1<<16,
-	5<<16,
-	10<<16,
-	25<<16,
-	50<<16,
-	75<<16,
-	100<<16,
-	150<<16,
-	200<<16,
-	250<<16,
-	300<<16,
-	350<<16,
-	400<<16,
-	450<<16,
-	499<<16,
+	    1 * SHIFTED_PPM,
+	    5 * SHIFTED_PPM,
+	   10 * SHIFTED_PPM,
+	   25 * SHIFTED_PPM,
+	   50 * SHIFTED_PPM,
+	   75 * SHIFTED_PPM,
+	  100 * SHIFTED_PPM,
+	  150 * SHIFTED_PPM,
+	  200 * SHIFTED_PPM,
+	  250 * SHIFTED_PPM,
+	  300 * SHIFTED_PPM,
+	  350 * SHIFTED_PPM,
+	  400 * SHIFTED_PPM,
+	  450 * SHIFTED_PPM,
+	  499 * SHIFTED_PPM,
 };
 
 long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
-	-1000<<16,
-	-550<<16,
-	550<<16,
-	1000<<16,
+	-1000 * SHIFTED_PPM,
+	 -550 * SHIFTED_PPM,
+	  550 * SHIFTED_PPM,
+	 1000 * SHIFTED_PPM,
 };
 
 #define LONG_MAX (~0UL>>1)
-- 
2.43.0


