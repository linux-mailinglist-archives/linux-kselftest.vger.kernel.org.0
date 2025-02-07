Return-Path: <linux-kselftest+bounces-25958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE144A2B9C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A661889D31
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 03:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039A154BE4;
	Fri,  7 Feb 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nbTteDYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EF2417E7;
	Fri,  7 Feb 2025 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899197; cv=none; b=abFnjAZ5kMrYluS+WGzpAYBL6Vm+55sGUCWZXfDwyScGwrTduZBLFTTfOT5T6GWmZI9LBwr/iPnvFIPXKYgTK/wSZ6A53r7RhujL6EHTwqQThoH/i/wxjc5/7DVxa9FB+WqoWwMTPNRu1S7xdLrYntIMOhfmGV9WMQ//7hnF7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899197; c=relaxed/simple;
	bh=h/LL9hB+rFwBBYYdjwkCol08R+/c72GTXL2mQLrYofA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOIg3S6N3Q/wQmSmT+DqqewCfyCIohtuwhu/E92WLYdCFJvlOiDu86D+KhxH1VThutVfTwofOpPtWuRUx1UQ6KPR/F9h+HsFKU7MXIg83kF+0k0XrL+RvIJo5h392q2U8g2MgoqzFW/TNY/E0wJb+TFwPptsuMuwndP+1UNM6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=none smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nbTteDYY; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1738899139;
	bh=HoKWwYr5Flu2cgUgqaZ/TV+1hwihy+b3dUE89jI9Cq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nbTteDYY9qmYG0b0NMvxjTWJmVzoH7Ex0l8POQw30Sh2G1itySvXrUKk1u9+4HlmB
	 eiTNbn5oYtk8TvMm2Aa7tLTIzIFLVcD8oJksb65pYTdMNg3kLtabqZBgNdL1jV6bCL
	 n6ygEm1BiT3nMv+qhV/hmr0jQr/UP//a1t58V3pY=
X-QQ-mid: bizesmtpip2t1738899097t6pcqco
X-QQ-Originating-IP: 9+v8GzvjcRVxj3/wxhEcn8FXY0lqalswqnLtMpkfjW0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Feb 2025 11:31:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10689580007085991278
From: WangYuli <wangyuli@uniontech.com>
To: Jason@zx2c4.com,
	shuah@kernel.org
Cc: wangyuli@uniontech.com,
	horms@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH v2] wireguard: selftests: Cleanup CONFIG_UBSAN_SANITIZE_ALL
Date: Fri,  7 Feb 2025 11:31:31 +0800
Message-ID: <2CCC5056FBF7DD72+20250207033131.20046-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Odky5wNUcHo/uj5SfSwfuY2WuIGafpNqbRh05g7wplfkTkaAT/yGmohs
	/XY1Jj+mYC9K1Wgw5fk5syZLQcuo77ZZjspX7vvwy2TdjEfMdqdGG4yzMhpwNs0yZ7n9ZK+
	ZYZKpiG0EnvRLFYVD7hm7f52YxxxzNsV9IdxKLAkUb/xvSpLz1C9yim7KoHwhjYMqmfgf8H
	i19xlii2zXuSB2ZWm/XjBsmfei5C8Oltr813qAF9hKtT2Mj47uMjseLtyx0wXbqX57XgwPx
	fjxESRxaF9JYqC2e7AoWdbvRgvgc6jlW5JRjwQFayKV0cKBpAGAukJaTYYrJ4ezVsxBRJg2
	js/XMTN8qQ9lcHCPDYc2jALYO4vUMwrxez11jiOEPOpPBbql43pAhnFk/hO9bUuOHqdcycU
	Ng1BWtUoOjT3hfRmr/eSs41RIro52i08abikW0c29970bAmYyu6d0krLybGVRiDQ3zxMlZD
	xkEbWF3lsrvCml016Gw60f7Z7rtpu0L2VO2qai3C6hh+YIAFFcWbtSg+EUSC+O6Oinjn7Ml
	zE8lQDUDy07y8BObPT7A7cSf5LgL/Bml1K7mefEm7MzAOnV2fHsM3zhaI8ojIBfV0VigVt/
	Hml/Nm//Xm/kM2IckMB+K2yixFjpBTivdH0elxazxxl5AtzndCheTueADbvBzb6No6qaqAl
	8gW4lSYgvyUkvwnh4OL6/Hq9FY/qaZ9G8fasZryDI+QZMTJgCPNaVgZjjtElAZ1QjBBUc9K
	0zfTE7glEA6eBFX4PkIzAUJcdcC/az71rpOVojZBZLw9R92oSccVAibZwmazNMWs9dENzx9
	7PihbzWjjcE+nuS0EKMbOv1xkp1ROvDh0H0ymcbzNvSoRxYmq4l7y+MBZ/g1DFBVdIRT40m
	Oi0rb9hMD6sAtajbqYfyX5WIp4Q4+aGjuQzMSPEji2ALiGevmDLWXH1613gzACqRbcJbyfy
	qgakdLo2+9py87dKTgDKomhPiP0SN469He0SEU55wu4LliYRQkVNECJE84uYcxvTDKRv0Xc
	ByilfdpRiF+u1Y1DHx
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Commit 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
removed the CONFIG_UBSAN_SANITIZE_ALL configuration option.
Eliminate invalid configurations to improve code readability.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Add Simon Horman's "Reviewed-by" tag.
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
2.47.2


