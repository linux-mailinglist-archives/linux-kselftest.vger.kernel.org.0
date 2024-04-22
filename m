Return-Path: <linux-kselftest+bounces-8655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E78ADAC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 02:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DD1C213A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250CB1C0DD2;
	Mon, 22 Apr 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxv5pDOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB41C0DCE;
	Mon, 22 Apr 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830335; cv=none; b=n3nK72hsG4swTg4yoA0t4GI/GQkhBu8RsvaWC8EmHuX3LXNtaVgACLFW7NmKcLJlHLnVl+EnpUIQk6rDfbbiQm3wCQLATf7DggaVGKDYYnSdm9ZEU2JXpooX7C6mKZhC/l5AbHVx1Vfg1m1CX1h0WFgO5+9OfPtQb/vavOg0K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830335; c=relaxed/simple;
	bh=WQkBgi+Eaxxbb+FX/HL3Sm6zB6RvXwCNsTnQSDnjwh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9EI77hmcYIqU7dl+6T8au6QO241Kaa+e7dLoXUsURM1mVeXlyHO1miaS8d//U8/Z1bppNeUkdyqrL9UWkGp9Rxjw1StmA4fr5bgVOmIdpqK80c23tG4kDTo4lpG6HFdhD+TKNCRZtaWM7sWEMPdu9u8Cp6qqsIxsiqlfPadJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxv5pDOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CA5C32782;
	Mon, 22 Apr 2024 23:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830334;
	bh=WQkBgi+Eaxxbb+FX/HL3Sm6zB6RvXwCNsTnQSDnjwh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxv5pDOmuuNRXWS0h2WilA+Xzp3xZ4sS6lVOp4B2IaXMJ/tOyRxUpkUcoRPQSKVug
	 kSLcLJM8AiI6C/v9I48T+W+KabrCezdyW6nBRs7ljti0+EywJ+M4z7NL9fgIuGl/pr
	 4S8n3mS97Wi80OD1tTSxg/A9K06akqCzppRYalZz0CszX/zaySX4qDplXkvsigV7AD
	 AbyRTyyBc15ea7Le4UHTM/m5EpNpkEsVS7zUaWQ+FPO2QPXGIpRC4MhlNvGRjhWpZj
	 Jf9JMb6mgalcwc0EaRqWsTDbohY2qGqYUhBSUfWIjzGRrYEYqWZR9wOPrZq97peqEU
	 UzODJfvj/+m9g==
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
Subject: [PATCH AUTOSEL 5.10 9/9] selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior
Date: Mon, 22 Apr 2024 19:19:50 -0400
Message-ID: <20240422231955.1613650-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231955.1613650-1-sashal@kernel.org>
References: <20240422231955.1613650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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


