Return-Path: <linux-kselftest+bounces-37637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E8B0B0B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C7F560EA0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E0288CAC;
	Sat, 19 Jul 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XBoYGhP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E72874F5;
	Sat, 19 Jul 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939538; cv=none; b=ACBFpyfB0+cCU7Kw8BiW9BtGmPg/5ciTgIQ6FQweoPo36Pg9Zm/dHsZuAxJ2+3ljVRfgVDUJklq0Vr38W8i6eqG1MQyCSRTef4ZlAbrgslz0WA605bLb/UoI0YI+ahIaLiW+6fxy0fknhQZ1NFga5cZJN1vNQqb7hEob7SX1f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939538; c=relaxed/simple;
	bh=3Pc/7W9jGeJsclFMq26ljxi4YQXtAlShpU7g+dHBhLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qchJKoj1mFGFsu1XCuiGjqUsFsoVZYl9ckrD2G0g8D4fiywirTDu4OOd7x1xKvYX82KRho2K7rhJypApJGVX2OFp0+ZAFYSYVXIoQ5LKvOl8kAUR2zjSaiYYdkwwuvtBYursAON8euZxpTbCrpEQ2iGcJpfPHKDQHT2lO63eNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XBoYGhP6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752939526;
	bh=3Pc/7W9jGeJsclFMq26ljxi4YQXtAlShpU7g+dHBhLE=;
	h=From:Subject:Date:To:Cc:From;
	b=XBoYGhP69JKViaPzYCUcN0nHTTlmE0vFiqYyy5nvDP4DL60hI8rRC3n2ykSODYNvw
	 59j1o/3Gj1mocZvl3/bFjdkfQ/RgHiCCtL5wu2b1SoSi4SHZPNNoCQKT5jEfUklc+O
	 CVq0/J6+Jq2klUQAgQNipoiEJvwA3aZgQfvWSS4U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] selftests/nolibc: enable qemu-system tests with LLVM
 builds
Date: Sat, 19 Jul 2025 17:38:26 +0200
Message-Id: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPK7e2gC/x3MSQqAMAxA0atI1gZsxPEq4sIhaqBWaUQU8e4Wl
 2/x/wPKXlihjh7wfIrK5gJMHMGwdG5mlDEYKKEsKUyFbrPSD2jtuaLeevCKqTFFTn1OJVUQwt3
 zJNc/bdr3/QCwMYgiZAAAAA==
X-Change-ID: 20250719-nolibc-llvm-system-311762b62829
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752939526; l=812;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3Pc/7W9jGeJsclFMq26ljxi4YQXtAlShpU7g+dHBhLE=;
 b=Acps2JrolwO4FngVGlywyhKRnMNhBRsBHXL2RDwwVxX3gKXIEj4Fcra3JW5F0p7LPH77CHGal
 KsXM/M5C21qCxhsx7PxfzuViisLUnkzrF6jP485vOCXcvWPcanZQl3p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently the test setup does not support running nolibc-test built with
LLVM in qemu-system. Enable this.

FYI, sparc32 on LLVM seems to be broken at the moment. To me this looks
like a LLVM regression, emitting invalid object code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: deduplicate invocations of toplevel Makefile
      selftests/nolibc: don't pass CC to toplevel Makefile
      selftests/nolibc: always compile the kernel with GCC

 tools/testing/selftests/nolibc/Makefile.nolibc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
---
base-commit: b9e50363178a40c76bebaf2f00faa2b0b6baf8d1
change-id: 20250719-nolibc-llvm-system-311762b62829

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


