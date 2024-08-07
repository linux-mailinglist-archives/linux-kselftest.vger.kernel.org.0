Return-Path: <linux-kselftest+bounces-14987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77594B268
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8123A1F22BFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C415920E;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="crgHlVmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CE156231;
	Wed,  7 Aug 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=gW8SC1Z6SyCasotzNU4fhpAS3EAC8O7F351c6tY9eooKavUVe3jMpRtS+5VD/8cJuD1l1YbKfRqD5wQ0DvgfBktMS/toXt+vIk1pO0y9UaGfaYebURewDzHol6RZbkwvi/QHBJJbMLMqH0cMi7GY90q1PVnpBg5XO4S0p6bDREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=dLS4bfcDWOs0R+HPnp4+vgff6vztKn00nqYdkqkwdT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpOar5knuyJv9JOrOqUVM79+ZtfrbRec9FztaxkK8DYDilccSAdEI7ftCOeNBQhkdB+4v1UWIxo9rCY3LJRshEQcAjTaucsN1cwrI9iZkwEJ4wXRl6cPjecTMN9yM4l3ybpo5H3a+6cmIVqp2OYshRc8gQOyNH2Db+oI3Ywdbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=crgHlVmW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=dLS4bfcDWOs0R+HPnp4+vgff6vztKn00nqYdkqkwdT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=crgHlVmWHC/eG7mCT6h8ZQlQszouDUnb/9agPMvgIZZ0JYcgOJjC/IkGm1g3WQAvP
	 RuCHgEp9D5x0cc3zctVHC0GmYbTIL0H/+j5NjU7mgcr7CsEIUEi2ZtUkfSuf342AE5
	 3N5sc+5rJjWw5toeuqBJtQUgmutTYHQdQOObSWGw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:48 +0200
Subject: [PATCH v2 12/15] selftests/nolibc: run-tests.sh: avoid overwriting
 CFLAGS_EXTRA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-12-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1538;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dLS4bfcDWOs0R+HPnp4+vgff6vztKn00nqYdkqkwdT4=;
 b=nw4sb5Q5OsrOLomtyTEshN7ERBLtc7pTpMwseR96ql9bXAcV//0mTezFtCiZpP3lBPqAHhUO4
 KiWWHpZq3HwDXi3CkxJgCTIcj3mnMQVrNGASYk60Ivt+UaqrBR6r8fi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If the user specified their own CFLAGS_EXTRA these should not be
overwritten by `-e`.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/nolibc/run-tests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 0446e6326a40..324509b99e2c 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -15,7 +15,7 @@ download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
 test_mode=system
-CFLAGS_EXTRA="-Werror"
+werror=1
 archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:peh' -n "$0" -- "$@")
@@ -69,7 +69,7 @@ while true; do
 			test_mode="$2"
 			shift 2; continue ;;
 		'-e')
-			CFLAGS_EXTRA=""
+			werror=0
 			shift; continue ;;
 		'-h')
 			print_usage
@@ -140,6 +140,9 @@ test_arch() {
 	ct_abi=$(crosstool_abi "$1")
 	cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
 	build_dir="${build_location}/${arch}"
+	if [ "$werror" -ne 0 ]; then
+		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
+	fi
 	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
 
 	mkdir -p "$build_dir"

-- 
2.46.0


