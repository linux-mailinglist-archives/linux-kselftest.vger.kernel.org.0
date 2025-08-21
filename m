Return-Path: <linux-kselftest+bounces-39530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC3B2FF46
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AE5AA4C48
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4453570DC;
	Thu, 21 Aug 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ehysW5Ti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CF35335A;
	Thu, 21 Aug 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790842; cv=none; b=R23kI3n3CFO/9SucrqOS/NdND1UzAKNqz81vbM4AVOxP7/2bnxUZyUdWnwhU6E8hfV+iJ43Q7Fq7iwsDsLJ7JGP3Vy+roYpDq1F0VAm/J+GuO57LW1OcVpmR8QsCIjQJBqBm1G33h75riiw03Gy8uxuKNO0SQajhC0dVBVF/xcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790842; c=relaxed/simple;
	bh=Nytg3brGBX94RkJqufZjR2+fI2MqCelukAJyT2C5iuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3SIeTYNk9QH8iZtM8XwMa+6LHqmvMvH7K95mn4OIi4nfefrz0NI32w+YfrhnhWThPixL7L2Pv8DxxJAb1fSny9Rqr5ezCMtw+dGB1lBAxA3VHIA0u6n5v+uBUWBWzZdLMlWZDsJRxYOQB2Y81NaKdNJXWGQLplfILYk/WSoC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ehysW5Ti; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=Nytg3brGBX94RkJqufZjR2+fI2MqCelukAJyT2C5iuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehysW5Ti14GbYFhA26/1gVMOc2+KTHF/h4tN3ojF7izVXO2E6sUcmCrRHdTJhy9U2
	 Q+4khxVCHYmfxyNbWUEceTDgDIemdajFjc4rCJlxPt9LiN232sK9qvTcgxBHXYwIIv
	 aur07jnAWkia87y1UW1975zb7YLEvYv3XXofnsxg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:37 +0200
Subject: [PATCH 6/7] kselftest/arm64: tpidr2: Switch to waitpid() over
 wait4()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-6-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=1157;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Nytg3brGBX94RkJqufZjR2+fI2MqCelukAJyT2C5iuA=;
 b=VqLBwVGYCEIudHHlBaFHOBetWwInVKrleIrbKcGtAm22hGoGNMsD8h8JJQiG88d2h8qI7f1f7
 PR8nnUUDe10CiRbHV66a9YcSv/TqfRjhX2KHuXKXIFqXr0HyQtO8xf5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

wait4() is deprecated, non-standard and about to be removed from nolibc.

Switch to the equivalent waitpid() call.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/arm64/abi/tpidr2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
index f58a9f89b952c42c5393b93a2db4fefe3f335e5a..3b520b7efa49e0058616c04fcdc0222bd8b03d8a 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -182,16 +182,16 @@ static int write_clone_read(void)
 	}
 
 	for (;;) {
-		waiting = wait4(ret, &status, __WCLONE, NULL);
+		waiting = waitpid(ret, &status, __WCLONE);
 
 		if (waiting < 0) {
 			if (errno == EINTR)
 				continue;
-			ksft_print_msg("wait4() failed: %d\n", errno);
+			ksft_print_msg("waitpid() failed: %d\n", errno);
 			return 0;
 		}
 		if (waiting != ret) {
-			ksft_print_msg("wait4() returned wrong PID %d\n",
+			ksft_print_msg("waitpid() returned wrong PID %d\n",
 				       waiting);
 			return 0;
 		}

-- 
2.50.1


