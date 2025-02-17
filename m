Return-Path: <linux-kselftest+bounces-26779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E90A383DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFF21738EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD421CA0F;
	Mon, 17 Feb 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJHn8klo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwnnKnZk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2721CA0A;
	Mon, 17 Feb 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797475; cv=none; b=X/i/nObZZn0yeslgvFuxgeIFSAs6kWYnUsYAJjwRrNSMMZdxBgcteyH/WqWYOpubb86fKYUfxrvarAR+HAwXgbSmbNF6Ffm0K14iwvCSymSiFsPAqmrEN4tcTotWFACQJf0ovSXcroAxMrwWz0cZVoBNtkBlbceeeEK/oikVNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797475; c=relaxed/simple;
	bh=vg1cv+Kiwa6E29rVsTD5rLNHj4DrAitZQqR55a+S6Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UPRgOKW9hrfanp5L0HOnJUCaVuQCAkg6QjMAdhKlZyOMf0TNly2ctfOKjyhaa1ViTcW2HoQQqiDC+Ftsk+njgGoTV59p+DikVL5GBuqqQa8zaKrASGHbn8GtbH3kAhrQnuWyJbmbZmvW+O37owa8x6Hz7meYpfQZNtPtSTvZzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJHn8klo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwnnKnZk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739797466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UcJTsIwwHujSyRHADnT7Z+ysZ6Ce5VOC/4vpTSLmBLk=;
	b=MJHn8klooH9oHEI1i3VGDnrV37iYpYtUhby9TLjPAoCPDAn49576b7HLQYbKC17FTfaJid
	POXPmEzrsmmcUGHwy3FSIejAjAkUxd+MZvJhiJGHItP7CHWzR74+dpWWgldl4JSeWjf39A
	4SPEdwQKym0v37gUA6eIPKFXrvsA8735SR2t+Kmpv41sYP3+YgTx8rpjms7iewcldpE5oF
	O8l7uV7LkZ6N0XL/QzsmXr2vBN78tYGKZ6UBHqBiRAtwjjO9s6Yzb3/5/GpO4TPvKuK2NE
	CziqGD6f72+5uiePnkGrAN5+Q72J/5jjrWc2NkVPvOwcOQGpFK9xxvqxA4U9gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739797466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UcJTsIwwHujSyRHADnT7Z+ysZ6Ce5VOC/4vpTSLmBLk=;
	b=VwnnKnZkvfuXVQDtAQUXYWXJbdPzYyf3vIaMa81OwmwO/3XnFOOnwvmjj01DcFXKipsrNn
	Sq1uprihBqIuQrCQ==
Date: Mon, 17 Feb 2025 14:04:18 +0100
Subject: [PATCH v2] selftests/vDSO: fix GNU hash table entry size for s390x
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIANIzs2cC/43NSw6CMBSF4a2Qjr2mDwFx5D4Mg1IutAlpTW9pM
 IS9W1mBw+8M/rMzwuiQ2KPaWcTsyAVfIC8VM1b7GcGNxUxyWXMpFBAuU0JKBHmkAKQ6DrNfwWq
 y0EreNK3Qg7nXrCTeESe3nflXX2wdpRA/51sWv/XPcBYgQBtUgzHdjWv1XJxfUwzebdcRWX8cx
 xfRJVUlzAAAAA==
X-Change-ID: 20250213-selftests-vdso-s390-gnu-hash-7206671abc85
To: Shuah Khan <shuah@kernel.org>, Fangrui Song <i@maskray.me>, 
 Xi Ruoyao <xry111@xry111.site>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739797464; l=2763;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vg1cv+Kiwa6E29rVsTD5rLNHj4DrAitZQqR55a+S6Kg=;
 b=/M4zyazARM/pOzV42BK47Sk8SSP5vH1XLa5L2gHyg4w4zk4Dk/k0iahkS5OhFoWcDHbFvoZBO
 shruJ3oAr16CbcWhgkVDHahyoazzVS2oJrhrwa2BkwTaHUvWZZBp9Nf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
changed the type of the ELF hash table entries to 64bit on s390x.
However the *GNU* hash tables entries are always 32bit.
The "bucket" pointer is shared between both hash algorithms.
On s390x the GNU algorithm assigns and dereferences this pointer to a
64bit value as a pointer to a 32bit value, leading to compiler warnings and
runtime crashes.

Introduce a new dedicated "gnu_bucket" pointer which is used by the GNU hash.

Fixes: e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH")
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix wording around the width of pointers vs the pointed-to values
- Link to v1: https://lore.kernel.org/r/20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de
---
 tools/testing/selftests/vDSO/parse_vdso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 2fe5e983cb22f1ed066d0310a54f6aef2ed77ed8..f89d052c730eb43eea28d69ca27b56e897503e16 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -53,7 +53,7 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *gnu_hash;
+	ELF(Word) *gnu_hash, *gnu_bucket;
 	ELF_HASH_ENTRY *bucket, *chain;
 	ELF_HASH_ENTRY nbucket, nchain;
 
@@ -185,8 +185,8 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 		/* The bucket array is located after the header (4 uint32) and the bloom
 		 * filter (size_t array of gnu_hash[2] elements).
 		 */
-		vdso_info.bucket = vdso_info.gnu_hash + 4 +
-				   sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
+		vdso_info.gnu_bucket = vdso_info.gnu_hash + 4 +
+				       sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
 	} else {
 		vdso_info.nbucket = hash[0];
 		vdso_info.nchain = hash[1];
@@ -268,11 +268,11 @@ void *vdso_sym(const char *version, const char *name)
 	if (vdso_info.gnu_hash) {
 		uint32_t h1 = gnu_hash(name), h2, *hashval;
 
-		i = vdso_info.bucket[h1 % vdso_info.nbucket];
+		i = vdso_info.gnu_bucket[h1 % vdso_info.nbucket];
 		if (i == 0)
 			return 0;
 		h1 |= 1;
-		hashval = vdso_info.bucket + vdso_info.nbucket +
+		hashval = vdso_info.gnu_bucket + vdso_info.nbucket +
 			  (i - vdso_info.gnu_hash[1]);
 		for (;; i++) {
 			ELF(Sym) *sym = &vdso_info.symtab[i];

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-selftests-vdso-s390-gnu-hash-7206671abc85

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


