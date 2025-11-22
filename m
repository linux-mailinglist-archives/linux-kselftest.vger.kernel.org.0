Return-Path: <linux-kselftest+bounces-46314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F2C7CD9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86F01352E0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BB2FD686;
	Sat, 22 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MQgF0KYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE322FD1D7;
	Sat, 22 Nov 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809325; cv=none; b=NBCSCGmI1xQJEOl3+dLn0NjLqgNUjdbC5h3KKFVA8XdgnD7R9rZmDPjTd+zSMoUkg8ft+tcTLtgG1zAIAEUaQDVLBz/DpqAgMYv4jQyjGcpDc8jsKr4e1XKpqToLQakRw+uU4U/IE+OSg0y/ykOUc535hFyQjyHg2hMzM4pqEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809325; c=relaxed/simple;
	bh=eRyETfiY5LMBlFDPWd7Z0sQoYGIhmNfukTtsw1mD9nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuCi0jffZbwqinbFsiWvlz40DCXkxPmTotcnuB4FM3bj3WgCdoDXSG8K70jwRVohAdMMgLvASjLsNdQHAFePp42ho4MCVF0eSYI0cr93D0oGgCJYo9VoXrmD3DNWl9NwMqAH2o4LilGX6sMXkXVrxlYoUtVfqKOy6wEU3BJfwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MQgF0KYS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763809320;
	bh=eRyETfiY5LMBlFDPWd7Z0sQoYGIhmNfukTtsw1mD9nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQgF0KYSgK/40PAqztF6LH/Hh6J+C6T2zTM7lXL38H0Vw6o9rQsZ7O8XfvcZn33bh
	 brTXYAcxOsc3MQS2IBEej9q9TM+MV/7PRBMyrGiYKDWpnOe58D7Qun8OyhPCcxi35V
	 eVMajM83SvZnmiISo5RpNCFaEHw85mo8WlOtWzjI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 12:01:57 +0100
Subject: [PATCH 1/2] selftests/nolibc: use lld to link loongarch binaries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-lld-v1-1-5e181e228c6a@weissschuh.net>
References: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
In-Reply-To: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763809320; l=1213;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eRyETfiY5LMBlFDPWd7Z0sQoYGIhmNfukTtsw1mD9nc=;
 b=UwD5v9+R4DiMlJYDpPF4knahqJETyKRW845PxWVPlRQ+0EF32+FcnFVIlSESsJADIAIo/R8Xz
 YXG6UT/nhwTDTNMpBLnRftdET8x7o4o//pT3ZVUxPT7Jyb00zWw5Hya
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

LLVM 21 switched to -mcmodel=medium for LoongArch64 compilations.
This code model uses R_LARCH_ECALL36 relocations which might not be
supported by GNU ld which to nolibc testsuite uses by default.
ld will not resolve the relocation and all function calls will end up
as busy loops.

Use lld instead.

We can not switch to lld for all LLVM builds, as it does not support all
necessary architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 330e000baeb1..9423f4a959b2 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -230,6 +230,7 @@ CFLAGS_mipsn32le = -EL -mabi=n32 -fPIC -march=mips64r2
 CFLAGS_mipsn32be = -EB -mabi=n32 -march=mips64r6
 CFLAGS_mips64le = -EL -mabi=64 -march=mips64r6
 CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
+CFLAGS_loongarch = $(if $(LLVM),-fuse-ld=lld)
 CFLAGS_sparc32 = $(call cc-option,-m32)
 CFLAGS_sh4 = -ml -m4
 ifeq ($(origin XARCH),command line)

-- 
2.52.0


