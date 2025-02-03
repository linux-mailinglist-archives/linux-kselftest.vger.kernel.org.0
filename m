Return-Path: <linux-kselftest+bounces-25542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCEA25554
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5943A4398
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233A1FF7D7;
	Mon,  3 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGfx6yHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="94Z1dN2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B071FF1AF;
	Mon,  3 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573525; cv=none; b=C/QlNINq2n0B3x9cq+7V+s/KG21OCZ2cjP7a7b/i+G5S77N0zKj1+6vgktHuSEkSy613nXl4hd7hEZk3A83BKbKJi3tr2uhyEG1cv5a/MoQe9TLcCdIB21peGJnNnD86aQ50D10tSMybTEFR02QblZv4YUzFXFwHEcczRJE6zJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573525; c=relaxed/simple;
	bh=FHjDFl0GoKn6nit/F9ipB8685b6fIBNR9d7/04YuOok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8YcWWHjZbCv6lfRLDE8vdDwaFoLEH+wk0smj1BWZf+AK28Vd+MEd+SEJrnwf38iPgn1DR2ybhVMV2pjuUJrE3YUekPPvnbcFS8YARQ4gZozIvAr4Q5uw4Ne4ChYEGKJO7FEhappTQwqKT3rKs003VbhbqmBJMaRL+R12UX2EKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGfx6yHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=94Z1dN2Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgSqTSk81su0MmtqYLownOdk49YkaFaYXYtHKJAxgm0=;
	b=xGfx6yHi7iZ3B50wSZNmDCxhoV3oerxbIl2ErFtWav52FPiddPhdhOciwkBMntgQhFximk
	yCTtzX4GgCWDIveJ8PZwLnNjl+aHmyPZkm0NlVbCpBf/zHfydpWcYv0XL5iSmTX9AgagXw
	LrEKVjWPLp/43xACs1aooe450j/1mUODTSBUMhqhA7Zf/a5xga8zhWb2EILAtQZEx/8s38
	tFDUV2IDZ7dnXovL/3Qb/b6mCfnYNuLvG6ZTyMwvwC6NXeett0g/jCSBF3kB7rDL2ohhQl
	wKx6cgKzFN6dIOYFSEFug1EGJ4lt4oq2zS/yHOdm0gqeuht2HOa6Et91Az97Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgSqTSk81su0MmtqYLownOdk49YkaFaYXYtHKJAxgm0=;
	b=94Z1dN2QIVLYeT7X8BukIFB1pvRBZ6naLClEBvXDwYwMHCHp2L4vY5GaF9jAJcIOiwyVCt
	YeoqYPpzVKYwMnCQ==
Date: Mon, 03 Feb 2025 10:05:07 +0100
Subject: [PATCH 06/16] elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-6-9cb6268d77be@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1518;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=FHjDFl0GoKn6nit/F9ipB8685b6fIBNR9d7/04YuOok=;
 b=K34MIkI7ABRtpHTTzHhgAEtIuBVWA3OhksDhhthQLvZ5GSkDTjSWJ4guUs3+fffHpJGidwdBJ
 pKjCcN1XSZwCXzYW1BHvHOTiY17D9qpTzV9/nm9rj5CRqcZetbWcppf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The types are used by tools/testing/selftests/vDSO/parse_vdso.c.
To be able to build the vDSO selftests without a libc dependency,
add the types to the kernels own UAPI headers.

Link: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html#VERDEFEXTS
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


