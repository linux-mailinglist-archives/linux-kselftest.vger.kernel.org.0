Return-Path: <linux-kselftest+bounces-25539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2AA2554C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DC47A1C94
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8D1FECD7;
	Mon,  3 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k77wwMju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3tjLF0Z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801A1BEF81;
	Mon,  3 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573523; cv=none; b=ld/GiET477J2lcMmSBKxTQlqLNzZRw+/6nOBVV7wkXZavKi/jZ2po5iSMSWSo1nT6WaQK2vZze5FiNgHq5ZHDgbdNGfCesX/WZ4BzxDO3qgEJECIQqSwKHwIe4gjg7iMv6thmuVK7QQm1L+PQZfkLyW8uq+tMLd95j/ZUsCZbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573523; c=relaxed/simple;
	bh=JMbHB1Br8Acow0wMqe/kiUZgwM90Yb9A1GSnA5w9I4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/d+7rdMNMfILQW8vlYYhwVZhNp51QYEL6/NWFsU/zU4QKozmyoe2C/xylHQfOfx6Eco8kAiXU3C1oUhtz0BNOUr6NtCOfUGFxLN1awyJ5Hpbcs/IhA0ZSwMeYC1f5Q0FsMzOA4qwHtl/Kk/4YvJnfsia0jI/bKYRYmP39EPbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k77wwMju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3tjLF0Z6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J10i+JysPn/nrLdo5+XVJ5ePDiKPIoG49q3quxXjJvY=;
	b=k77wwMjuAYR3dfbz3vFjH0KLOHF7f+LP9plYpwf5GOdYCn+/saWY8VE7p5PPpkwvX48XfY
	Fzb8wzqnz1vxL/5Lkrwi5h6rLnxh8k26/IB5L4kQxQ4vf5JS0MrC2yZdsmY8A4Y2Wjyfjj
	ujABq+fsaGVUaD4JUH7WGzQZG5GHG9uFcBG3IzlOlbwe+XaODD0Ow+7qCaAGf+iCSViOi6
	c27rh0qnBYMmjeAFTlW9ewIo0exWPsgHnNpQxhpzrnLOWlRcLqxZQXmineDBhmBwP1gJPS
	6CgFdnl2rg5c572QjTFxVXsUgirz6gckNEz/VFXiB2vj1gsuHwJUqDzLYtQ3lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J10i+JysPn/nrLdo5+XVJ5ePDiKPIoG49q3quxXjJvY=;
	b=3tjLF0Z6MOe6akUAJnTAJ+YeRh62eDgsNp1wdU/3GuKyz1vj5HyjSdJRmkKMN4CKqwLs06
	l852tUDYjE+Lc5CA==
Date: Mon, 03 Feb 2025 10:05:04 +0100
Subject: [PATCH 03/16] elf, uapi: Add definition for DT_GNU_HASH
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-3-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=950;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JMbHB1Br8Acow0wMqe/kiUZgwM90Yb9A1GSnA5w9I4Y=;
 b=h9BewK+FPT7QjjWxsuCY/mWK5QSeZBXsIegBdR0AGQ21P9tdaeW6ZkiP1NJ25/4kSh6yJZZO8
 u93+1EXhA4bBD8fHAwKWvP/Myb4L+wr2P8ZqrfpF1WlpQe1DynvD327
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the define to the kernels own UAPI headers.

Link: https://refspecs.linuxbase.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/libc-ddefs.html
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 448695c7364042b10682acc8223eb6053ad039dd..c5383cc7bb13c931fea083de5243c4006f795006 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -107,6 +107,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_VALRNGLO	0x6ffffd00
 #define DT_VALRNGHI	0x6ffffdff
 #define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
 #define DT_ADDRRNGHI	0x6ffffeff
 #define DT_VERSYM	0x6ffffff0
 #define DT_RELACOUNT	0x6ffffff9

-- 
2.48.1


