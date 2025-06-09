Return-Path: <linux-kselftest+bounces-34453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A23AD1A8E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C93ABF60
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39558251791;
	Mon,  9 Jun 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OqFidhvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BBD24E4C4;
	Mon,  9 Jun 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461347; cv=none; b=SP8epi7x4k6/q1DnfUBpCanhuThXkO4Tm0iAgQlAuGSs0siQC6h6vn+mFKfkxvpzbUTzh6wDxMYq4C+AH6Chu5MlbfOTPDuOvIztIDCzgcn+aMwUaKiaugMGVSb16Eft/xb+8e/x9zoSV/b0F+BarDWGdJ7eVB5Mf9tJuix/OlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461347; c=relaxed/simple;
	bh=PNvb5YsLR8Rd+gcDaLvgMa7n6sL3VTXL6wP9rmL0n98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNLDy1brUiEmCTqVY1O2Rna9niSRCFZf3th2lrbFqOFIBnL0SfEmBXloncz14B/FQMNJkTtlOp21YNFStTCFA+ieJXczrLhMHM4XWEtbwq9UPLS7u+62+b3gT2ns/bFYAFfcMPKElDI+xbe6n0HA7gZyE/E+TGXimhb/AOMAc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OqFidhvl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749461342;
	bh=PNvb5YsLR8Rd+gcDaLvgMa7n6sL3VTXL6wP9rmL0n98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OqFidhvlycqO5p54pXeXWzSrD+gcc9zdAyK08M5/5vgKqZQhRC+RHib0ZwUYX+BWi
	 c0SuXXa6WTpR3qS/nRpErkFin1wMgVMlNpis/VrWYOgCCwSeIeIFORiM6zKVamgdUb
	 FhEfm9ghle/ZYifVIhXW9K7Gx/XeNGSSOpRtHCz4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 11:28:57 +0200
Subject: [PATCH 1/3] selftests/nolibc: fix EXTRACONFIG variables ordering
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-nolibc-sh-v1-1-9dcdb1b66bb5@weissschuh.net>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
In-Reply-To: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749461342; l=1052;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PNvb5YsLR8Rd+gcDaLvgMa7n6sL3VTXL6wP9rmL0n98=;
 b=qkk6hUmLRjl2QkTgfazEkaXnTF/ClyCIZzSHcFw7//ohl5KeNc/WNRA39NroLpXVUOXyKMFnp
 fr/EQxk24HMDeNeOdJJnK0Nf+NFXDdB3fyqBPrGydY5HKKy/WQVKg9S
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The variable block got disordered at some point.

Use the correct ordering.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 853f3a846d4c0fb187922d3063ec3d1a9a30ae46..22da78a4bfea0274f66abec319d34b3d2a2824ac 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -107,10 +107,10 @@ DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
-EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
-EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
+EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
+EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
 TEST =

-- 
2.49.0


