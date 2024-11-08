Return-Path: <linux-kselftest+bounces-21669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078D9C1BD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 12:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B8DB24DB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A251E2603;
	Fri,  8 Nov 2024 11:05:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C147F69
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063953; cv=none; b=QkTII/F2mIAIuStXMkoogXnJY2qz/ac+WpLYCSO0tepsA7M0yJnhLBXj13zbTUF76bBreQb8Fn/nKeC9U79M5UOePkyE9hi0KPazj6MjRy3bPftzlBtdmpn/REZC6papCGKKAtlUX4xqJx2Fl3HoeE1w6FzCTOz9g9lEdQy07zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063953; c=relaxed/simple;
	bh=Qx00DRNsfFDek32ZbbUTIrAkXYeKR1+6a0Ii8okNKys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A6q737MfdG1yC1/XUaFZfxPQMKhJQ4mh4cD7LheUNLSnNvEUBh6dy8KlLqO2NPrum3TAKkHGl1esBc1LGwWQfZvaR3Dfsyy9Re6dn1XKpHk68TYLx+BRUWS5Ckr02R8JbAxIIihfc8pjH1U2RnJAMwn/hlHYSGHdaI79C3PZ5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F09FC4CECD;
	Fri,  8 Nov 2024 11:05:51 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Subject: [PATCH] selftests/mm: Fix unused function warning for aarch64_write_signal_pkey()
Date: Fri,  8 Nov 2024 11:05:49 +0000
Message-Id: <20241108110549.1185923-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 49f59573e9e0 ("selftests/mm: Enable pkey_sighandler_tests
on arm64"), pkey_sighandler_tests.c (which includes pkey-arm64.h via
pkey-helpers.h) ends up compiled for arm64. Since it doesn't use
aarch64_write_signal_pkey(), the compiler warns:

In file included from pkey-helpers.h:106,
                 from pkey_sighandler_tests.c:31:
pkey-arm64.h:130:13: warning: ‘aarch64_write_signal_pkey’ defined but not used [-Wunused-function]
  130 | static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~

Make the aarch64_write_signal_pkey() a 'static inline void' function to
avoid the compiler warning.

Fixes: f5b5ea51f78f ("selftests: mm: make protection_keys test work on arm64")
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

I'll add this on top of the arm64 for-next/pkey-signal branch together with
Kevin's other patches.

 tools/testing/selftests/mm/pkey-arm64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index d57fbeace38f..d9d2100eafc0 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -127,7 +127,7 @@ static inline u64 get_pkey_bits(u64 reg, int pkey)
 	return 0;
 }
 
-static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
+static inline void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
 {
 	struct _aarch64_ctx *ctx = GET_UC_RESV_HEAD(uctxt);
 	struct poe_context *poe_ctx =

