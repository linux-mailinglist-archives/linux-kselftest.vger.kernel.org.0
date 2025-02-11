Return-Path: <linux-kselftest+bounces-26350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA77A30966
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D59164084
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA21F190E;
	Tue, 11 Feb 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QNsbgOlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4B1F1934;
	Tue, 11 Feb 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271855; cv=none; b=XNTvRXwt527naRkD9gf/rJe859vlg6BFf/NI0pWrr0OrElW2G+eZlfL/xF6WCZ+Dl7mwOucT2LL9Cc8+tjo7LMfhSuAwKQEWK2atGTTRDv8xA3LUSRwNNljOBgKLK/jdf2xA75bEbTwbV+xg7YQdG0RaWDi/pN0MlMOcy7E+EGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271855; c=relaxed/simple;
	bh=Uy+ji2q8WemxeYy45m6nVuiaXqPhJ7iphgJdSlQ8iq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AYqCMQ3eRNy93jIOrcT7x/a1YO/nilW3wvFPW+7OCg5uvwG00vjjb/t1GCUNeaTpJvG6lpn8hYHHC7oS/Yl46t1lEx6NSJWc13WUhtrIJ1d7EvWdGUj8P7n/sk/8qJzM0eg+tKpX54/FY4YibkVe8lV0HWIewJJbwuGFOBgjFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QNsbgOlA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739271843;
	bh=Uy+ji2q8WemxeYy45m6nVuiaXqPhJ7iphgJdSlQ8iq0=;
	h=From:Date:Subject:To:Cc:From;
	b=QNsbgOlAhA+b+1RZGXHFkya4UIfTZgA8pFOpFPGXt/shu/1gT3mq9ZHeIp7J2N39N
	 t4z3H7yl3689UPzWqYiYWYFuFJz9bQkA8iI+y22S4hL8PQc9EUaWKUQvzZi/LQhig8
	 qTEV6vS702Iu21KO5n6AMiWEDdvZioUSnj2ucw4g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 11 Feb 2025 12:03:52 +0100
Subject: [PATCH] selftests/nolibc: split up architecture list in
 run-tests.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250211-nolibc-test-archs-v1-1-8e55aa3369cf@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJcuq2cC/x3MMQqAMAxA0atIZgNtoUO9ijjUGDUgrTQigvTuF
 sc3/P+CchFWGLoXCt+iklOD7TugPaaNUZZmcMZ546zFlA+ZCS/WC2OhXTH6EAytFNg7aN1ZeJX
 nf45TrR+VYBcKYwAAAA==
X-Change-ID: 20250211-nolibc-test-archs-a5990cfc9e52
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739271843; l=1232;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Uy+ji2q8WemxeYy45m6nVuiaXqPhJ7iphgJdSlQ8iq0=;
 b=4MO3VIEL95hcYuVJd1z7SFe4Y2o/t1Pnh14ZOEFVYr3eMMXXWQoSrO1YFsMUNHRY/kJukHbSs
 mw0eeu9ALxDDZPqfaT+UJp5xUgc6UQSI8FP4DzyzIeQm+QlpEggmy9J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The list is getting overly long and any modifications introduce a lot of
noise and are prone to conflicts. Split the string into a bash array
and break that into multiple lines.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index bc4e92b4f1b98278a0a72345a5cd67f1a429b6a2..6db01115276888bc89f6ec5532153c37e55c83d3 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,16 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390 loongarch"
+all_archs=(
+	i386 x86_64
+	arm64 arm
+	mips32le mips32be
+	ppc ppc64 ppc64le
+	riscv32 riscv64
+	s390
+	loongarch
+)
+archs="${all_archs[@]}"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 

---
base-commit: 665fa8dea90d9fbc0e7137c7e1315d6f7e15757e
change-id: 20250211-nolibc-test-archs-a5990cfc9e52

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


