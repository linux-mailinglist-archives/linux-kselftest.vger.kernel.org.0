Return-Path: <linux-kselftest+bounces-24979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D84A19F1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A4188A0E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2320B814;
	Thu, 23 Jan 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i1kRCOHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C520B20C;
	Thu, 23 Jan 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617926; cv=none; b=ECs+wIA8EA5tPFVJdXbyjEmdOmtNYSGqmPTgSsgZiFO3FJVYztnqr2pKjykTSrWpMVd3fPJQFZZM9dHkWk9JK26g2S7/3TDMvcUsZgb+ATBQk7ghpHcNuVKOWh16B1xaHjMC/71bkXg4F05Ef1eUz8wt/21Rf8knNhY4AWq6qjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617926; c=relaxed/simple;
	bh=9MQKEZ+KYBbKL921eHv4MEZPDGOiiotIz3Y9gDktJ+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6bJJDe2V9z3r0Xefcme0PKhSke/CARrSbwTPiO7D5uC/fOaIrDLaNPkrTCQZlnQiM43AfGjPWehwAbAOzfUu+uXqaDBbQBhsHOha+I5j3nVeh7ic9NvEdAP+qtUGfDynmHA67HB/FbE+6E/k6IqNxssLiuRGrv6u34v7Ir6ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i1kRCOHZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617922;
	bh=9MQKEZ+KYBbKL921eHv4MEZPDGOiiotIz3Y9gDktJ+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i1kRCOHZ3xM8WzO8hLKyxQEclOG7VI/PWk1ALSsOJIZEB+5y4S4lRNfOyL2lx0bKJ
	 yTi1v4RQEwUcFs0W++aJCiE2MrFB2oawpHE3v0dQSTamH1Hl1NWukiFbf1RRqKS1DZ
	 GMZHVo/bA0o8KIQgFR2PSnpomn/0EB7MPPW5yeLs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:37:41 +0100
Subject: [PATCH v2 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-config-v2-5-5701c35995d6@weissschuh.net>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
In-Reply-To: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1394;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9MQKEZ+KYBbKL921eHv4MEZPDGOiiotIz3Y9gDktJ+Y=;
 b=hARrXcoey0594PQiIvLMgPcqgy0PUuC8pd9Znkgk5uSkvG1MMf4RfPaB+eMjyc1cu+OVrBXn0
 4RBvWEHM9niD/rlGSYX5H8lwQ5TpDYQYqzcf72NWj4ukLTnLi8cWRgJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Avoid using a stale test kernel configuration by always synchronizing
it to the current source tree.
kbuild is smart enough to avoid spurious rebuilds.

Shuffle the code around a bit to keep all the commands with side-effects
together.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 9c5160c5388122deeeb59ecfced7633000d69b10..bc4e92b4f1b98278a0a72345a5cd67f1a429b6a2 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -157,10 +157,6 @@ test_arch() {
 	fi
 	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 
-	mkdir -p "$build_dir"
-	if [ "$test_mode" = "system" ] && [ ! -f "${build_dir}/.config" ]; then
-		swallow_output "${MAKE[@]}" defconfig
-	fi
 	case "$test_mode" in
 		'system')
 			test_target=run
@@ -173,6 +169,9 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
+
+	mkdir -p "$build_dir"
+	swallow_output "${MAKE[@]}" defconfig
 	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
 	cp run.out run.out."${arch}"
 	"${MAKE[@]}" report | grep passed

-- 
2.48.1


