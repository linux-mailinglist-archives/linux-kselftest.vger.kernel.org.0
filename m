Return-Path: <linux-kselftest+bounces-23721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACABD9FA10F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AADC1671B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B181FCFD8;
	Sat, 21 Dec 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZS7EZHAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAA1F63F3;
	Sat, 21 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792277; cv=none; b=ReYFDJMayrnGr4YjtoHF7JtAbOoq1ZK7JEdzCjiuo46ZYIQO7NK1t35m+WFYi1Zm80Ebe1vIqEn83AZb0leJnw0D6BgyLd3ZkbUeuM+/3cYT869PYuRzMrjIDrB+jThAkMKMWjTu5X/nnJDrWi+IRQp+7quFopnvezpfsE3PRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792277; c=relaxed/simple;
	bh=bg5UlBq3THh05UiKb+gXkEUVzYOv1u5Ao6jXpQiecuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GU8WfMPEp/4rkm7K88Aopbc5LZQdPr2GRntKQhJndQUnylJP+zEw/JAkc2w7oSw+rL/yV1h5skBIZN7gWSRpQagVzldQ/fn68sBAYhslugIRmthMHTGR3+TzQdxIo0WVnZlB9ac+yBEWG0UCsZqS8pkroPowVzsTVb6JWmb0lCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZS7EZHAA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792272;
	bh=bg5UlBq3THh05UiKb+gXkEUVzYOv1u5Ao6jXpQiecuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZS7EZHAA6phWrr5kKUxHD0QIEi+utM+nEXN9V49sJb7AL7HkSQuy925253MyE62Bu
	 SzGsioEPcGROh9PuN0FY16lEKw+LynhgetjhQCetRVY4zlLU8R43poWaR6hzWhi0Yx
	 MdeeGOeJrRT5/84EYKMB3XyWZ8L7dwvZP+x4guUM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:31 +0100
Subject: [PATCH 4/6] selftests/nolibc: skip tests for unimplemented
 syscalls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-4-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=1803;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bg5UlBq3THh05UiKb+gXkEUVzYOv1u5Ao6jXpQiecuk=;
 b=Z4n3QT+/74DaRTLgeQKACFugaghlokDmCaupwH84G5FyZGHX+NZ4Uz+1ctl44mrhDCNV8YixA
 BvDcB8OBSPOBSkOpcX8RvSpqpZNk+Dg4E09ySvywOLmZOSFr/t1kgZI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The riscv32 architecture is missing many of the older syscalls.
Instead of providing wrappers for everything at once, introducing a lot
of complexity, skip the tests for those syscalls for now.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3685c13a9a6b8fd5110715b95ff323cdcb29481a..0e0e3b48a8c3a6802c6989954b6f3a7c7258db43 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -302,7 +302,10 @@ int expect_syszr(int expr, int llen)
 {
 	int ret = 0;
 
-	if (expr) {
+	if (errno == ENOSYS) {
+		llen += printf(" = ENOSYS");
+		result(llen, SKIPPED);
+	} else if (expr) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
 		result(llen, FAIL);
@@ -342,7 +345,10 @@ int expect_sysne(int expr, int llen, int val)
 {
 	int ret = 0;
 
-	if (expr == val) {
+	if (errno == ENOSYS) {
+		llen += printf(" = ENOSYS");
+		result(llen, SKIPPED);
+	} else if (expr == val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
 		result(llen, FAIL);
@@ -367,7 +373,9 @@ int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 	int _errno = errno;
 
 	llen += printf(" = %d %s ", expr, errorname(_errno));
-	if (expr != expret || (_errno != experr1 && _errno != experr2)) {
+	if (errno == ENOSYS) {
+		result(llen, SKIPPED);
+	} else if (expr != expret || (_errno != experr1 && _errno != experr2)) {
 		ret = 1;
 		if (experr2 == 0)
 			llen += printf(" != (%d %s) ", expret, errorname(experr1));

-- 
2.47.1


