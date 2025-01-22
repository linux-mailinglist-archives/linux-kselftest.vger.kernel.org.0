Return-Path: <linux-kselftest+bounces-24962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978AA198B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432183A470E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17182165E9;
	Wed, 22 Jan 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AyIfI0C3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C840216387;
	Wed, 22 Jan 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571327; cv=none; b=g+DTcUiUGRr+fHD5rMdoHZCtiiKMW9IyPxx2mT/8d3hVXVYbK1iC29MWMH69PqiPNUor+IjUTlzkKDdCdlJPsqz9DR3h67ksFUbCc8WWPL7oRoqsbL/L4hIYLcNxKKuDUVLbeFYgY43vESIOMpXfVPkGdVq7VSI1AgTM5s4m9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571327; c=relaxed/simple;
	bh=A8K4kEnALbhaK90EA/QltWvvng/sBatsp6gsx3xoPh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzClJHJcPkR2+RTjSHChc0xvxZVQXq6AgoS0SVUI8f85t3ZMQH8Zx/LA7ApijCUWTgvFXibK6MZeqsFdTIKDGT8xZze9M7UFAAONub+oeLzWtoL1HhWu6ZDoBMRgUl/o+3aQ/KDwrCp3VO7ilzx9aMtYEbkiWDgp2F9GoYGyCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AyIfI0C3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=A8K4kEnALbhaK90EA/QltWvvng/sBatsp6gsx3xoPh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyIfI0C34xeeNJHWJsElgrr+J0AnfY+KBDV1oSoA5cg6FsTKrqhZXqZ48HW9tkp9m
	 Rp5euPGHpkvum7SIX3UqcbU9expQXe5R2PfJUcWi3XnvVZ9iEzzRBTycPdInAA/uwq
	 EKAZ/HNiqb+mYYsdKhUoPKOM2TsrCeTv1B5bCQOA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:41:48 +0100
Subject: [PATCH 5/5] selftests/nolibc: always keep test kernel
 configuration up to date
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-config-v1-5-a697db968b49@weissschuh.net>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
In-Reply-To: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=1321;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=A8K4kEnALbhaK90EA/QltWvvng/sBatsp6gsx3xoPh4=;
 b=gihzhLPvfLe4M4KsafiLgYBONMRevk/riZj1XdcMGHvpkPw8mnF4ciB6TmligMzBORWq90IZ1
 dYrK0AVLgNQC1QqE9+nx6j2d7kv6bkvcROjVMUyCmSRJxfSJFdnk25z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Avoid using a stale test kernel configuration by always synchronizing
it to the current source tree.
kbuild is smart enough to avoid spurious rebuilds.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 9c5160c5388122deeeb59ecfced7633000d69b10..664f92e1c5500f726ab33247321b96e8602ce185 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -158,9 +158,6 @@ test_arch() {
 	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 
 	mkdir -p "$build_dir"
-	if [ "$test_mode" = "system" ] && [ ! -f "${build_dir}/.config" ]; then
-		swallow_output "${MAKE[@]}" defconfig
-	fi
 	case "$test_mode" in
 		'system')
 			test_target=run
@@ -173,7 +170,7 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
-	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
+	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" defconfig "$test_target" V=1
 	cp run.out run.out."${arch}"
 	"${MAKE[@]}" report | grep passed
 }

-- 
2.48.1


