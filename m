Return-Path: <linux-kselftest+bounces-31206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C03A942F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F05189E898
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB731DD9A6;
	Sat, 19 Apr 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rot+lAyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837721D86C3;
	Sat, 19 Apr 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059595; cv=none; b=ZvaX9gSfoTTkyw89tL32t6AUaqIGN5fEZepenN3LnyH6p287MzIAzmZ3ObNf5pq3NkgNROBO8DMdSnCkr7U9GwhrB7B3c3l1g0AeRyw8jKvDob8rQhTNkbL2C2JZ8F8siG0QC+jqR+N8uiCfaY4eDjN9T/io2MCAuK5QUUUaAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059595; c=relaxed/simple;
	bh=mzpKJohIpWJ0LYXtnz0PZYrkK4CRrKFVrVj+0vemp9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bsj0uvfFTRS5BpFtN/6Ccwroc38VDs98K/HIE7n22N6xXjHfLOS0xWcBf8qoVEAgIDEqCulH6XJlUJmPpmO5brj4EuxduDB+CbeOGptMhORT8byYe5Bi/R4fG5iHCqORZPz8dbX8MgBli1EOAJDRg76MRtMiUb2bBrz3JGtI2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rot+lAyI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059587;
	bh=mzpKJohIpWJ0LYXtnz0PZYrkK4CRrKFVrVj+0vemp9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rot+lAyIJ5Civijd5Lwq6WaRNXnCOIJ1iEB/R9HMWveoGgZSntm96AlWXBZYx5dz6
	 McFNr0ZPtFLeOYNCMIvwOBVanVl4PNc0qDGQgNqKMPh11KOO19yRwwT/nNSBurZsf2
	 RbCmU4RdyzOmlJQlSHG3/2BAUMlW+uFAo8k94/U8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:19 +0200
Subject: [PATCH v2 2/7] tools/nolibc: add __nolibc_aligned() and
 __nolibc_aligned_as()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-2-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=965;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mzpKJohIpWJ0LYXtnz0PZYrkK4CRrKFVrVj+0vemp9Y=;
 b=FoQtquPSOfm1I5LSk3s3uZi8s/EmZNA2cyf3eEwqL1Um5Ctp8jDeAPMJQkoaeiSzeaiqDxbcY
 7bbFozcTM3QDHphUhxX7EbyWGscLpqVReL2tDGTf+QCRA0wR70Sq+ei
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Provide a convenience macro around __attribute__((aligned)).

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Willy, I used the name __nolibc_align*ed* because it matches what the
underlying attribute and the kernel macros are using.
---
 tools/include/nolibc/compiler.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index e6d6dc116e43aa69b37eca02ed1590fc09486bdb..369cfb5a0e78f4ae1e1a2cac4077024b4e8ba225 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -18,6 +18,9 @@
 #  define __nolibc_has_feature(feature) 0
 #endif
 
+#define __nolibc_aligned(alignment) __attribute__((aligned(alignment)))
+#define __nolibc_aligned_as(type) __nolibc_aligned(__alignof__(type))
+
 #if __nolibc_has_attribute(naked)
 #  define __nolibc_entrypoint __attribute__((naked))
 #  define __nolibc_entrypoint_epilogue()

-- 
2.49.0


