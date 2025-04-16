Return-Path: <linux-kselftest+bounces-30980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44246A90B81
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE45D3B8DC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D422578C;
	Wed, 16 Apr 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XdpK9U5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8D225390;
	Wed, 16 Apr 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828851; cv=none; b=LfE3LYhqW53P8oTxCMHbvoyaj3x2kV/u/EhHJ60++kCUOF7pho0d6J+UDIsykP+dmQs0jbqGGXPAD4paRIVRnP/NsF5Qgsj8usHN8OjYreYi7QLGd3A3YaqJkln30DJzeFR0O8NZ0Bdd08HwrnIIt6xpQdog1Bvp0MF2macdvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828851; c=relaxed/simple;
	bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rffQKCYIt0y2sKoXPnHSjokIa078ROFEanYbH+/D32pGzYfs6HH/ES1pYYYg6edAjO/MXDaOmxCkWK/IFupnLFXh72ipoXQHHeeKoiqXIXYokpDV5ulkCDxAWbrSYn8d2Cb7hEIpYj+jtEYR7DEgzzP+NEmRL14E+RWRN6KD+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XdpK9U5P; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828843;
	bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XdpK9U5P/DoOz7iaC1i6PtAhGT07PUK4qtI+rnvfxe+RP2Ti1m8EJWm2S6IL4R/rv
	 6CoVMxVbtb+/0qiMTe30YouLExrIJlISdhHc046L6Q/D1B6RJmcvYBQ9UcBE6VRqK/
	 fW0sLBJ1Dnl17EgwsO4IKaMLXajTsTA152/LzGRw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:20 +0200
Subject: [PATCH 5/6] selftests/nolibc: disable ubsan for smash_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-5-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=736;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
 b=reVymp1nD/vf4WDhSrb9jjJ6nwGeZjOTVhrYc5BmNmfdR8Kml/RkBLstMrV73wLStCnTVzYyO
 igXxdOR10+jCotGITqCISVDqJYvtQwCe3li2TJSqXGdpHRz7/yTKxcF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

smash_stack() intentionally crashes.

Prevent UBSAN from tripping over it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7a60b6ac1457e8d862ab1a6a26c9e46abec92111..b176a706609b7641dd1d743c8a02b6b6e7a4c746 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1438,6 +1438,7 @@ static int run_vfprintf(int min, int max)
 	return ret;
 }
 
+__attribute__((no_sanitize("undefined")))
 static int smash_stack(void)
 {
 	char buf[100];

-- 
2.49.0


