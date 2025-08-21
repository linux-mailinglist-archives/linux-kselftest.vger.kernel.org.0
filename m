Return-Path: <linux-kselftest+bounces-39524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FBB2FEEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A037AFBA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405F2D1F6B;
	Thu, 21 Aug 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tfIHsAKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD52D061C;
	Thu, 21 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790838; cv=none; b=jer3oSfJmhf2AvcZ2sMnMQE1+s4O7SJfwi31BoiVnZ/FvR5AQslk0Zs4TX7pYbcFSwBl6W2OwX8iCQ2+xgFNIoELt9PDLZWEPMBZD1rDReaqn23dajq5VreiErROwjvxnwUBZ+00hDNrhMIUKV8wHF9jf6faEdu41V7SepOtBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790838; c=relaxed/simple;
	bh=lJZvG23U87rgiOGKfE/Nw17HdxdXmhpAjW+f05nD3+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkint+MGarerZsvQsdurvvQtdWhthp1zy2N9ynM16rcHk6MqDta9HoQYmQQspJJ2OhKiL/xfJ1YxAydIBNPDXIQvLbv+v+gz4Nm9To99oQcM6sWFb0jU7Iqkb1crVxtpr2kTEa3vFnMNBCbZknf8knEqwlL87LccyaRxc2WS7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tfIHsAKU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=lJZvG23U87rgiOGKfE/Nw17HdxdXmhpAjW+f05nD3+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tfIHsAKUdlhE3JfZMTPsthocNLD6ubw3qrp7dKiy9ruHd5j/oYnP4pYmy8WF6A4wP
	 xAG33BlmM+fzK3F03ZLgSs0ezFCaQhVS6dEyT9V4uHkDeAvuWCksRs/3LezYuGsZGw
	 iUlNkyBi0x7Kuqg8+SeeiwCto/d5AoZqha81cAm8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:34 +0200
Subject: [PATCH 3/7] tools/nolibc: remove __nolibc_enosys() fallback from
 dup2()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-3-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=841;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lJZvG23U87rgiOGKfE/Nw17HdxdXmhpAjW+f05nD3+Q=;
 b=RXUu/QyPF4EAgnDokpRfyPuO6CVAQRbUmb7Ce1r3/E3Oekw6nRTlDhkW19/s8p0vL2PX4H+Xz
 mFK27aYX3z2Cw+QsDicbioNafkpEH6HeEA26wEHrqDr9/wv+1VbXwIz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All architectures have one of the real functions available.
The additional fallback to __nolibc_enosys() is superfluous.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 2b9c3bf697e74e80016606814fe21929512ca007..9c4fa7efc1d606f18a5a92b0a3dd9ad7b9b4521b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -235,10 +235,8 @@ int sys_dup2(int old, int new)
 {
 #if defined(__NR_dup3)
 	return my_syscall3(__NR_dup3, old, new, 0);
-#elif defined(__NR_dup2)
-	return my_syscall2(__NR_dup2, old, new);
 #else
-	return __nolibc_enosys(__func__, old, new);
+	return my_syscall2(__NR_dup2, old, new);
 #endif
 }
 

-- 
2.50.1


