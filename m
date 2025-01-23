Return-Path: <linux-kselftest+bounces-24975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93CA19DC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 05:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A283ACDAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 04:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1C198E8C;
	Thu, 23 Jan 2025 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IxjnxTNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDD191F77;
	Thu, 23 Jan 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737607848; cv=none; b=ApyTTYvD2vJc0tJCamP1PuRYsn1fISNqZZACSrohN6fTELukyPwSarpcbxR+dpIiEPna/8Ikcap8fdsFvVZFCE/Kh3ObFoWXDx+/1mPzGQ1ICFKb4ch0u9d60NpklkwzSfeDn53YKpDRDAw4CJN6jhhnFM+bdDOVOdWz/BMls9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737607848; c=relaxed/simple;
	bh=im++eR/INdPSpUr45TlAR+IsbPrHVkY67fuTdQe07YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc9jREQzZ4X79VQWDNr6sz+TvV0HPak7CY23+vMh2NvynDPMm37B3yPzaEdy22jUCQrOki0/agL3PTRNkwS0rSSXmetxr3q57WbneQLfrpMwwn347mtFdvIMYy66rs3tFw4WVYaOFSh3zdo80dbHf536aMditSW7di/kHAmftYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IxjnxTNL; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737607783;
	bh=+AGkopHYTgZidv+7oyOdM0KJWm1PxaW2N+T5XJvNq6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IxjnxTNLce4SbtMwh3+4qafArbLCwQkMItXkaKvMLxdXD2FhqcCZF8vCw472snN/z
	 nHn8zY0GeVhx0g4Diox3lnQlH9PHGF61z2PHkYXNSTzhKXChJgHgkX9zFt98ZMdzfh
	 LX4SRhzrQRfs0/1rDELC7hNG54bpq8ANk9jTUbA8=
X-QQ-mid: bizesmtpip4t1737607771txzqs1l
X-QQ-Originating-IP: vAxGYuBn/XVVB1GPf9+8yeHPQp7yVrrcFMOsPqyvF/8=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jan 2025 12:49:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14309089569765569099
From: WangYuli <wangyuli@uniontech.com>
To: Jason@zx2c4.com,
	shuah@kernel.org
Cc: wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	tglx@linutronix.de,
	jstultz@google.com,
	zhanjun@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH] wireguard: selftests: Cleanup CONFIG_UBSAN_SANITIZE_ALL
Date: Thu, 23 Jan 2025 12:49:23 +0800
Message-ID: <F0F29BE7BB89FAAF+20250123044923.161871-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OSjTqsWSa+11nw528X1QVyRbDuq0BN/aLIyWtoNFvEyI7B3nZ8ER6KAO
	W0L5hbBXPbv4hlRfpU0he7NmhCO3eHKWkK+Bmeq+up/Xs8e/4wvt1C0C0mdKD2F7RjUTG87
	8vz0Bujr1TwsKxClNjijdtL9opARa6KxpXGNcoZeFl9RYIqL96EDc0AV994gBlzh8Wd7yw5
	OK4MrjEgqZ6kFmTm1xeCYAB/4Wsfl/bvSj1ws9KpPiWQ2YcgggKvHbuhWLLrwLw6/DwVM0K
	M9KpVdsT/LmxFxaYfA8mPGSQhAkPP17CEhYX+CWTMEkh71stKmfmxsmqpPECOGrpQxqZ73/
	vSipW8nnGiZsd45heqYXyyMMg6dmns4H6nObqapwsbHWsj1plqvIZCPrrvio6RGJH//vOM8
	BDyZCRnCkzKAzry5CCm+9gQM3oMjm26FH7f3eyNpwxtQXzfXlG2RDIJmNQn1vjERhKfjrrf
	ggjSrimU+4oOTD3VWpXw3xRtx7QIG/pzZhbmnWm56N5YO841ObemgNVbnyfz5n4e4yMBz1w
	6GoslWhpjUOl7mxLsU7bOubs3IDENwt6voyRN7LbMuwUhhT0rpzvqhSC5mw6UeJiEz+mY8q
	e1SxYTKhksEo6q5D8/Gh+hx4aZTuCu2V1cYcQrCEtn4CyuvLumNMKScbFG/U2XkUgLKd5kp
	XhM9/Uz4q9hk80+pbJjIn4TQTF2DbaExVVF7In53QdBqimmwLb2eOrZJhkUh/eHexT2+eXC
	bLquowAeWzD4plKaV59BfOqsfCkBkzbThj/QWnhNCPz3uxKMKkBwaeuB8fZqjLiRurYNmZG
	yUrmhiyxUWiTHe3UTCjJQ1RSL4xbcUiNyHxpVsUctK2r0i/H2Loy98MVzgUwiSa/AvZMLxx
	9G0nZTTVmgMwsAHG+eZ3UYbqOukz7ifLsmkLoQs6GpULQzoQGBZdQrrqK4L8MtybVeRIBbH
	cfBfrvWbovuQ2rVyU0PKzCjztblb8urhSoBcS3oiaWWXswwlqwT1p4idW8aHuMotaxus1J7
	7laQJXZ8JVaYWe5C6PYWnriaOl7ng/Kul3F5VHzQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Commit 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
removed the CONFIG_UBSAN_SANITIZE_ALL configuration option.
Eliminate invalid configurations to improve code readability.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 tools/testing/selftests/wireguard/qemu/debug.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 139fd9aa8b12..828f14300d0a 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -22,7 +22,6 @@ CONFIG_HAVE_ARCH_KASAN=y
 CONFIG_KASAN=y
 CONFIG_KASAN_INLINE=y
 CONFIG_UBSAN=y
-CONFIG_UBSAN_SANITIZE_ALL=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_SHIRQ=y
-- 
2.45.2


