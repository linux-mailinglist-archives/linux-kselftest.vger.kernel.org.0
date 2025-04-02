Return-Path: <linux-kselftest+bounces-30035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25515A797DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF53A17118B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42A1F4CAE;
	Wed,  2 Apr 2025 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ncyrnpif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818F1428E7;
	Wed,  2 Apr 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630403; cv=none; b=Wu8Bja0fM1azNmAdMZ72bDVvHVLcn7mWrmUOquOJDNdbX4y1abckJ5xh9gaPXZcqLgdjmIT0iy9uOTp4AoXg+DCp+S3ixvSZfeSVxG9jLhpH+YofYACRqfB6PJeZZ89rsWLoZj+/vSqxam+qcIjNZkcqOlmMPgNXIpu53kWC0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630403; c=relaxed/simple;
	bh=LuGP6+XkZVCLTpWzPvZ4xw075h0SfZrc7ZPN8LclwU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BW2vnkSWZa+/mGQvHmXj0P8ZjIfvZlHYlqW9Rbge0IPrpJRHM5slcKxjrkSP30sEwm72dveza02MBALiTQFwUOUYqSdI/MGsVj4LMyK4MJNAcJwtwFTwgFo3Z9GiZwPzH71KjFFR4U4eSzl2pbUUFz+0E6ve05dQ34smdFMNi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ncyrnpif; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1743629944;
	bh=LuGP6+XkZVCLTpWzPvZ4xw075h0SfZrc7ZPN8LclwU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ncyrnpifAIzmd+H9MNyHucO6IN6ePiex0Fn+sqnDKxdusMLVs7QvI0AFaBC+csSvy
	 4xMfzeIJql+iem010lBwm8XLpw+OaD4JC/N3HwTaTnr7cSvaKqqfswGQVPFdxDdr94
	 9mkjDWjVKsiI7dlzII+3YoM9zgFaQI2j6F1+kA3o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 02 Apr 2025 23:38:59 +0200
Subject: [PATCH 1/2] selftests/nolibc: drop dependency from sysroot to
 defconfig
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250402-nolibc-nolibc-test-native-v1-1-62f2f8585220@weissschuh.net>
References: <20250402-nolibc-nolibc-test-native-v1-0-62f2f8585220@weissschuh.net>
In-Reply-To: <20250402-nolibc-nolibc-test-native-v1-0-62f2f8585220@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743629943; l=820;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LuGP6+XkZVCLTpWzPvZ4xw075h0SfZrc7ZPN8LclwU4=;
 b=zVZOOHaUv+JNsXm8eUjcbRgX2T0rlo1Ti+J3DMVEk0ioP/13L+61edL7AEN8nPtj/T+jqAz6T
 h8bjPt1t7S4Ag/rWcx14eHYyjjwTPT2DOlcjKYSqTZrOOl3jmMjsni2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The creation of the sysroot does not require a kernel configuration.

Drop the dependency.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 58bcbbd029bc3ad9ccac968191b703ccf5df0717..34d01e473c013a1400bf6023132017a5f663f75c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -232,7 +232,7 @@ all: run
 
 sysroot: sysroot/$(ARCH)/include
 
-sysroot/$(ARCH)/include: | defconfig
+sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
 	$(Q)$(MAKE) -C $(srctree) outputmakefile

-- 
2.49.0


