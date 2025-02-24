Return-Path: <linux-kselftest+bounces-27318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55FBA4146E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 05:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB947A5FBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 04:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5C1A3172;
	Mon, 24 Feb 2025 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c8kZ0Ibr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423621EB3E;
	Mon, 24 Feb 2025 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370478; cv=none; b=PwCG4t1JT6yQxqjZ5KaZAg65l6rGPq96PQlPmlGk3YGwRNIDd7rBTZCUHcD5F4VVGYrxG2YT7UTuvTN99Ii5Mle6SbHEKlGP1fVZ8FdS/PUI4jggiTJ5HSCF4AzsTyF4xdL7HvHIkEmy+J6awpCXrU1/AJSeUFLhrTU44UBvqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370478; c=relaxed/simple;
	bh=Q32jPkfBVfYf3TEwyBJF066Q+2lZ165Aft6mCGepb18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2QOyNyZvbvPWFTxdrnxnFra7OhZNAcNNGxt0fRZD10vlCSwruNkpSwWw06w5N/vBFYKD0pP/KkNVPBSotlt+DRWNyz6FitzVdalKD7L78jvYsXYTGhsFTT4F0k16RwU1pGrrmRu3zWj8M4G58gJja0yUryLn5oPOCSmevkiUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c8kZ0Ibr; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740370417;
	bh=QUnxINV4h0+72Ou0M9jqMPGNZyrytkwHTR/8PMwxqYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=c8kZ0IbrnJln1gGF2ss+9B9o962Jy1/Fts1QmfBmJvqOc52a5LmNXVK5NcvFreDO9
	 1Vsf5Ivqc6Paj2fo86XtC6HEDKyySPgHCI60lLKoaxiJ+eKHZVUV89s8/9733RXC0Z
	 Wqt4/eNAhX1QezmoGXIGrj6KXm+o1PT7SJxg5+Vs=
X-QQ-mid: bizesmtpip4t1740370367th0m8ul
X-QQ-Originating-IP: YACropfZKbFnsY+WYSwIdCcFXQBCfwM3OPJ2699B36A=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Feb 2025 12:12:45 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 210867971091029739
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
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [RESEND PATCH v2] wireguard: selftests: Cleanup CONFIG_UBSAN_SANITIZE_ALL
Date: Mon, 24 Feb 2025 12:12:38 +0800
Message-ID: <6945896DD80A71BD+20250224041238.45039-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MPAlP4yRn0xgUjN0gIBL01n/MBhEZCsEcAKtVOEh6kVYgpA/OKfZoppR
	Gy6EExKtL9VBD3aHP+/Q82Y9EGvQGXbmdW9Dr5czGaJ9imlQUVxv4dKorSyUO2inX3k2Mfl
	fFnOhKhkLoPx+oP/McSyZ+l3VGyZKW1xPzZRxzQSlgA+kJOQ97bRtTfdJjWwKlL0JXNIHIX
	lJuCO/KDy2DDseG20VpucLPWAxrA+0RlGZNa7i0xVJdNx/oTKC0bCxna4bY4wx6sjpG+g1v
	UdmOZJOD4aU4rNteih3M1YsLbdO+BTHId2NDmotndPq0ycWZHyqYLFUfevkkmaRMfY4ABZ1
	1shpjAvb/otOTk3+WRxGeZPSNWm5O+9g2NvAiu7YednSYioZV+7tBLkxbc2ClJ2+3oSsyBg
	WM9hCFuo9wgrHFx18fP6L6U3qIjOTZlXO4bhFqJX4vSLIDeVMGLXxOKVbM9JpLjEtp89sP+
	ISNQU29BpvyLC55XzFeBcWtlzZ6VC0hwhrOw8RV7GOiY5yWo79kcpYGtQPXbE9cOddyaiLf
	L1gXJf4eo1WsCynmtGsdvz8pzxaPcw5kXjJmd9VkS6ndRDD2WjpQpluOvJFxWdaWw55r9aT
	Zk04ixLKjQC0JdM7q/a/OAGsaTWwcYMxy3jVdWCXb1iADItmua6w0ZxRis0OC1IYsIoBnOU
	PLdn8fqOMde0XYJtnI/dpztOfBPH7v8FRGiuH7m3bcgQYmjjhXLOXYLyGkNG3eBfiyXH9vG
	6pETQth2Blt0TqE85r12KEatLXQ+bzsNUAUCGY+3nVArClmJTsIuFba8UuakeYqnLr2x20y
	310j6D1CE1saKKrSccQ1+xlTJ3pkRbBPROOM1SioXYH3pR3m2Bfz7zZm647YK+3crx4XEGx
	d+s7riJflmY3lUteAhitHc0suL1r7yRx8P6iWLClOJaKMN1FR/BgOfXXoPBEUGPXHRPJ+TV
	nJBqRcER7zOpLkDzQ3u8JxgrJlwWOami8Y9JsAquIrW8b02uNToVFxC5advjrl6jVBjUVp1
	PoWxtjAtwjvg3wNEVIClI/Lq1376VgH/wl7e7XXPrlclnjj/SKDJErt/5Iof7uUEqTptrTf
	w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Commit 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
removed the CONFIG_UBSAN_SANITIZE_ALL configuration option.
Eliminate invalid configurations to improve code readability.

Link: https://lore.kernel.org/all/20250123105743.GO395043@kernel.org/
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Add Simon Horman's "Reviewed-by" tag.
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
2.47.2


