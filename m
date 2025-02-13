Return-Path: <linux-kselftest+bounces-26510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF03A33B75
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8109A3A8C2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194220E000;
	Thu, 13 Feb 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUT7e9bU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RLpsJLbQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12520E70A;
	Thu, 13 Feb 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439713; cv=none; b=aQhJRzJIvF9V/RLLOW3As2qTzhSb7yh7JzSHhiX64+MPPWdBZ0guZFK7inqPc3ZnRQUw0rqHsewZR2YbcsGRuY9uip3JdlR/bExc+tASPL4ff3BW37Y0ECZaIjMYbsauQ1L+wvzMCujbKLaqZLp0Rr9Zxgi0e4pK9+tNdwHp8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439713; c=relaxed/simple;
	bh=davAbf6rTCE+XvDGJl7h+YhckMtmJciY6jpQeFmgp/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGhLJKhvCuJp8iJt0Dhhmqs4p26U7EG7aIsgfLyAiCGM/WzW4KE9j8LoQz20Xjy+3YXxbqeEwchtJTJt76vVawclJEI1wXVMLIkovDNjlZKm/4XmqF7XHHqeb/Pie7WM8JW4DRdBEVVOC682blZL8/8ZikJuIiRUAiHAdnQTNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUT7e9bU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RLpsJLbQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739439710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X/Pc7Lm5hpZtdxpchXc7KzNgwnIIFT8+i6ED6OooeNk=;
	b=aUT7e9bUEMmYg/ml94p7QTLAQRSrL0CxrlFk7YZW5H8AO4XtS+4s/mP7qtMH77wY5i7PNy
	K69mDDapFoBoxYvHT+bJgkgknFrFoW0Q7aGiEauqGkzOPO2eGerGmqrP2/4+oanI+6l4ki
	qSCY5gNxhUCJQKhx/KZ8vI/gEs4lbwP5j+PEQCV5PWNuV+EJcYOpU7qTjDsffbQlBcFbwo
	9xH2tFFA81FIJBp24qS9ZtLAide1o8br85u7xu/1AbK9k1d44aU+hAh03fn/p/yZSXuoYO
	ohnOlouLMmN+XEAi24dhDPWTzu7PFbwO0iWGqEb6wH0cH2so/V70BxjSphmLlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739439710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X/Pc7Lm5hpZtdxpchXc7KzNgwnIIFT8+i6ED6OooeNk=;
	b=RLpsJLbQmJ2fsbqjaJV73k6jxyuO016rJYlUM9hIAidr3wt74OgXmmMmyI8zXmqpKCZa5a
	+zGD44/o0mEL7yBA==
Date: Thu, 13 Feb 2025 10:41:21 +0100
Subject: [PATCH] selftests/vDSO: fix GNU hash table entry size for s390x
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAEC+rWcC/x3MQQqDMBAF0KvIrB1IImrrVcRFqqMZKFHyVQTx7
 g1dvs27CZJUQF1xU5JToWvMsGVBY/BxEdYpm5xxtXG2Ysh33gU7+JywMqq34SUeHDwCt840TWv
 9Z3zVlIstyazXv++H5/kB0m6RrG4AAAA=
X-Change-ID: 20250213-selftests-vdso-s390-gnu-hash-7206671abc85
To: Shuah Khan <shuah@kernel.org>, Fangrui Song <i@maskray.me>, 
 Xi Ruoyao <xry111@xry111.site>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739439706; l=2491;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=davAbf6rTCE+XvDGJl7h+YhckMtmJciY6jpQeFmgp/w=;
 b=0HC1gx+m3o6x/zWek8/MPE1C5y2ntJcD4kv6toi+n3YF1xQ8vzTcVGmEbiM01e+LYw0Cm1lfW
 /LkaltOmg01ABxQ2QnuOUSw32cpdSisu6CaWa5PdH55Jf+2Q6acHPSV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
changed the type of the ELF hash table entries to 64bit on s390x.
However the *GNU* hash tables entries are always 32bit.
The "bucket" pointer is shared between both hash algorithms.
On s390x the GNU algorithm assigns and dereferences this 64bit pointer as a
32bit pointer, leading to compiler warnings and runtime crashes.

Introduce a new dedicated "gnu_bucket" pointer which is used by the GNU hash.

Fixes: e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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


