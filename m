Return-Path: <linux-kselftest+bounces-27594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F4A45D79
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF16189042D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBD215769;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjdFSRuy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqgJ2Fef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D221884A;
	Wed, 26 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570318; cv=none; b=Wy+ChhYP4ffju/rCjBt25l94Xh3P4PSL4iWtyfaOlDYtdv4YJYFlJ9qEtiwXhHri7sOJYsYL0fsDyQki2JbBEc398chwg4ZR34ruvjmNQWddho7uIeDTvAFDQyToq7+0KzDnlG3GcTFB0eJ6n/bsD3rhv8dxM8e4gImyvfDztXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570318; c=relaxed/simple;
	bh=f0elSrf4G5nhNoS671eA0MwXLIFN+3JjK3K2nUIR4+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nngNxJ/uKWTIuvTQQPBxju3r3QRbllVyYE15Ad4Z9E8CCnhjgeLTKruU8y7mKKIhcfLq/lykAMVGxdRCXpGo3LnfPGtODP9GUwkGjXqqgVSKmZY55QgWz+LzEa2UUO7lEfzOsNYIr9tKgtGdMNHPonR62Wcx7G6WOFdnjrZkkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjdFSRuy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqgJ2Fef; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkCRw2BpQUYAjvfhyaUo+iyDwhLAUESJLqMGOQ+XVwI=;
	b=YjdFSRuyb91zkSTPvJ8cgiS1svich7dObnXdLP24CYPu3D5EQrrVweJJQnvReCGRuxeEdn
	5XC6Grer4PT+zGmGd6bcuCUeAwpG1bX7ALed3vso/6rIEnY1OdfnW21BzlLJQNzTJnRcDK
	V+gfY+69wDAOWdpsPYUa9GK5r9CE8RIAPU44kjN53A1d7DqSKuuBPb6Uxa5YJcevVAhlB3
	o6Bp+HknlhyCZejpdymUi+tbdQ6TvwDg+UbYoFvfthEvK0BtqLFrTALKt2tEKMyqBtn6U7
	R2HcDJIS2PgQDgXU+7guk0pzWRZJGKt0LVC+MqiTCk5oQFhCw4hMxJDalLXqoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkCRw2BpQUYAjvfhyaUo+iyDwhLAUESJLqMGOQ+XVwI=;
	b=NqgJ2FefRdRXfd22mRV3zWNKN+hKj9Uq/0fpZT08jqL33unPCrnhLCKAx/UEbIOAznpOpz
	kSX0oMt34JymlVBQ==
Date: Wed, 26 Feb 2025 12:44:45 +0100
Subject: [PATCH v2 06/16] elf, uapi: Add types ElfXX_Verdef and
 ElfXX_Veraux
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-6-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1560;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=f0elSrf4G5nhNoS671eA0MwXLIFN+3JjK3K2nUIR4+Y=;
 b=XqArEjVM/ETm9hIaH7qXWZUILAITcT9I7PEhlL1NXqPj1HuOR3bmJ792iqIy/A/oOqMP2t3ft
 TQ3c8kUy3wZC2IHOaunkr6mjGBwCzhkfBG0tTSfQNu+CFOefmVG+fa2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the types to the kernels own UAPI headers.

Link: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html#VERDEFEXTS
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 8846fe03ca5b836c96aad1be6d8fb9daf3d4b1d9..49f9f90458d8ca8e7b8f823d32be0a719ff827b3 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -491,4 +491,34 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
 
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+typedef struct {
+  Elf32_Word    vda_name;
+  Elf32_Word    vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word    vda_name;
+  Elf64_Word    vda_next;
+} Elf64_Verdaux;
+
 #endif /* _UAPI_LINUX_ELF_H */

-- 
2.48.1


