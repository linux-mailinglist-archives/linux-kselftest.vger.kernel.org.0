Return-Path: <linux-kselftest+bounces-47736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB69CD0806
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18A03301CEBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED4A34844C;
	Fri, 19 Dec 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJoWBw4b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001E34A3D8;
	Fri, 19 Dec 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158200; cv=none; b=EzvZn0Ois2qmQl80CgCUgZUGn2Ysd7jhDzQSct6ZumgrPekND5IRs2kEcoXZ+ueG2BWMRO7gMr+qrCDwBOfp5zHkUj4Z1RgAoAhuZE0y+iAWBioO8G2x8+++/yCZo2sK8LY1PIws58rOPfQpgfb+ZAKP2aUiMA0G2E+DZzQ7mUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158200; c=relaxed/simple;
	bh=CkxlXN4DXTzDhcNxrzGsCReBqOAWuvkB7mMRlPoHBDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ek0FSaKvvfUxSQRmlBJ8A03pItikl01zu+iFxsGZQhbjrhcwhHRxWQueZomN9VX04QX9V0KjJUwPovga+KYHffjAXyAFCUMiB5Cf0IqBQWjm1BH+8Z7IccqhJJATzBdABwsQgZW9PKUqPEfMzdHF98eus5ShoRchkzgMOfmr3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJoWBw4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0CFC116C6;
	Fri, 19 Dec 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158199;
	bh=CkxlXN4DXTzDhcNxrzGsCReBqOAWuvkB7mMRlPoHBDc=;
	h=From:Date:Subject:To:Cc:From;
	b=TJoWBw4bMaTID367gbGeuEJ03a+J5jIu8VpiwfgU3GKE+AoTYaYyRQtmxHP3W1Sxy
	 PoP3FrXQc0nD6ieRqMnmfb1FE28/FNjdO9CfuyEHbjQCBlYKKeROeNfxlLGuzlRUg3
	 VN3c8wmsaA5iCsh5hEhmXybZaAb6CsgfwUmqJKgauLrEN0vPw03DMMgSPa6zpNGt1X
	 1NeDn2WJ/W5e7Nvocy7b/J15XKozXcIXLir7fKIVu8To6qrKXdjE95lM2RK69EKD1C
	 Dq84vWHIzo/7i7kdubGowH9NdKofu3pW8WKNyXWDJ3S8acMGJUzJM2pZjChf2l4k98
	 5OdP0XU+qhvbQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 19 Dec 2025 15:29:42 +0000
Subject: [PATCH] kselftest/arm64: Support FORCE_TARGETS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-kselftest-arm64-force-targets-v1-1-cf72d6d27e99@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGVvRWkC/yXMTQrCMBAG0KuUWTtgQtXqVcRFkn6p408rM1GE0
 rsbdfk2byaDCowOzUyKl5hMY4VbNZTOYRzA0leTX/uN827PV8MtF1jhoPdty3nSBC5BBxRjH0O
 XEHu3azuqx0OR5f37j6e/7RkvSOWb0rJ8ACAOg9OBAAAA
X-Change-ID: 20251219-kselftest-arm64-force-targets-2ba8cebd1748
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CkxlXN4DXTzDhcNxrzGsCReBqOAWuvkB7mMRlPoHBDc=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhkzX/NKopvqTPQH281mLNgkXO9nEmM9uzoywvHxk9TrdD
 X8s73l2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT2fCL/b+T+eOw5y77hdfM
 vf7SnSlJ1/Tv8+6aFx86zK+fUMir3Kr1W+6Ah2a9bOSub5McLLnKHtR+P3mWt8rqDfcKX2UVd5+
 qnrfxtYY2f3zKfjRy6Ah8VjSzOpxm2pC0bqoQt/PaBxNmmAloN0kxOfa6/doQIBUY1b0p9l9A9Q
 Wp+9MdEloUinkjol2Knwc0+Ivej1HK+5TNUTLZ9OjzDSEq944+yFGTuJd1S6vXvYTLJqmh8ln10
 4U/D7i+n5Q1s/KI6v9Tvs6Zt/VePOO9eOqRlHnIQ8HigOraJ0sCXN4sEvX3Xp4S2ibhWesolPJ1
 5iF1jumBizhO22itaLgzp8c1/NyKQ8e0isrenj+rO7sIAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The top level kselftest Makefile supports an option FORCE_TARGETS which
causes any failures during the build to be propagated to the exit status
of the top level make, useful during build testing. Currently the recursion
done by the arm64 selftests ignores this option, meaning arm64 failures are
not reported via this mechanism. Add the logic to implement FORCE_TARGETS
so that it works for arm64.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index c4c72ee2ef55..e456f3b62fa1 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -30,13 +30,15 @@ all:
 	@for DIR in $(ARM64_SUBTARGETS); do				\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
 		mkdir -p $$BUILD_TARGET;			\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@		\
+			$(if $(FORCE_TARGETS),|| exit); \
 	done
 
 install: all
 	@for DIR in $(ARM64_SUBTARGETS); do				\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@		\
+			$(if $(FORCE_TARGETS),|| exit); \
 	done
 
 run_tests: all

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251219-kselftest-arm64-force-targets-2ba8cebd1748

Best regards,
--  
Mark Brown <broonie@kernel.org>


