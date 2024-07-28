Return-Path: <linux-kselftest+bounces-14329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04793E460
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8E81F2153E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2496F25745;
	Sun, 28 Jul 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N66gcAkH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB971B86E7;
	Sun, 28 Jul 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161417; cv=none; b=Ul+dmc1hf31yYC+Qq+RJNMbN9n+vqEhE5NRSFQLWdvetIebOpYYR/DhYsNaku1ITTc+fNZi4zWYrj1bCzYRvz1VVeDiWQmqurQczNmtFbQCpJa716IWVuAfPdKlmkWEsQZgFQne9SMSCJDa5tFC9swO1uSFy5QftSSJYAfbhlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161417; c=relaxed/simple;
	bh=dhMCN7pEEyNix1uoUAGJom0GonyZA1rMiLcJNDosUbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlRAui/lWh8nQhe59frbj5t7I9zXXl4jjGSPZ/YCfB98dI2wz6fpsefKpLtrPiu/kJ3up2vxomBsfN2kBT3KKYe0zkbEthjIwUu1UEC6jejBlfNRn+mpcF6UTbWao7HFQTN73OPpmkbyF0Vz0YN/WLaCxD2UPbwZT9CHkmBYruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N66gcAkH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=dhMCN7pEEyNix1uoUAGJom0GonyZA1rMiLcJNDosUbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N66gcAkHylLosbR/hLBt9ltg5c+YssMjmafowZ1xZkurRA9GZi8spIMJT1XtAGnXY
	 yhRULhAZX8c2jxAjv0SEKkcvlfxbOK0/cgmK8yKFccRawTciNUGvk3KfFwqtI19awX
	 dIRRrYs8X9TVkB1QSMxv9gRuJcFTFWezF3RhrBqY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:09:56 +0200
Subject: [PATCH 02/12] tools/nolibc: limit powerpc stack-protector
 workaround to GCC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-2-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1020;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dhMCN7pEEyNix1uoUAGJom0GonyZA1rMiLcJNDosUbw=;
 b=StFfgnxzsMDpkgz1dF9GKQjwrNadJGR/+HYcD6p5Zf5yZ1cSYYJf+zNkZpsKgn+Zoo8BF3mAH
 QiL4Io8zjydBPJ68Fh93HGhFe1sfw5zqE2EH39wr9VJf9hAh77ORymW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As mentioned in the comment, the workaround for
__attribute__((no_stack_protector)) is only necessary on GCC.
Avoid applying the workaround on clang, as clang does not recognize
__attribute__((__optimize__)) and would fail.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-powerpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index ac212e6185b2..41ebd394b90c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -172,7 +172,7 @@
 	_ret;                                                                \
 })
 
-#ifndef __powerpc64__
+#if !defined(__powerpc64__) && !defined(__clang__)
 /* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
  * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
  * works with __attribute__((__optimize__("-fno-stack-protector")))

-- 
2.45.2


