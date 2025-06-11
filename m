Return-Path: <linux-kselftest+bounces-34681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47075AD5211
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE214189101A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531F274669;
	Wed, 11 Jun 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+H+mxQw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5biRCCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCC25A344;
	Wed, 11 Jun 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638044; cv=none; b=ligU0JWHCrGlykh80DUmztLpDB8n9ZUUbtAtPKlDBUahy+E8rDMz6oTMcx3QMKsRiB9Ugue3u8f2SPquCxKrP4Q29NfuRvyNLvgWatncJYi4xveCnhBr6G1by+uGjdaytCYwZ+HOxmnvWX8nprqowGLnjJam05mpCBG6iULGatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638044; c=relaxed/simple;
	bh=J9hKPnnc2A0cweqLzbgQ20+H2ZBdLzJrRKeSWwaEXh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RN0CEwXjwz+mp1JdNELNRQYUbD11ryzNkojYtle1MP3ygACAaFxA0IX1oZpj+XedyQqk/jk5P7aHDfD+82sK/yY37w7RnE9+NOyCOkZerAv3pZ+TKyhmpjHqtxkdqUQSQqpr63o+piV10POeFfNPen34nH9E/68uazRW0tpAkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+H+mxQw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5biRCCU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749638040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z70zMxE+h3XzbWkN3rpdJuxDTk7yXimHYHKQ9cAetLs=;
	b=c+H+mxQwkXNadV6IADUyk/QHGqP1VnmC6r+TjlBnlZ9SPfYPRQI84mQzbChgxjyAvQdo1j
	b1OdgGnKbJklSKkarKTWYfVcMpuHK93untz9PScVgmcePazZDx5Jom4Cwy0Yjj8VBhDWQV
	gRHMGJoMGUjZzXHMOLTkfu1CRFpko8WJHAdYC/HkADrRit38e+B2Md2i3OU/yP8dk3s0hX
	njI4ipFrktFcS1SBwudLA4i+QyldUkDakYR502LjGxQYDF9Woes7Z2KlpU/cfHF6zNBl0h
	dPfeSBCtXRtCJ0YSXpNulkWUpbzmxMXxdNSbuAOq16eB/3RzJhHid2Vt7pkJlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749638040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z70zMxE+h3XzbWkN3rpdJuxDTk7yXimHYHKQ9cAetLs=;
	b=N5biRCCU2jlQe+YQbXJmdSUJCpQMJBDmOyBAt5y7RsqSTZRM3/wAxvG4ZTHQeACin29Jtr
	pfXaceULBJD0t3AA==
Date: Wed, 11 Jun 2025 12:33:52 +0200
Subject: [PATCH v3 2/9] selftests: vDSO: clock_getres: Drop unused include
 of err.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-selftests-vdso-fixes-v3-2-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
In-Reply-To: <20250611-selftests-vdso-fixes-v3-0-e62e37a6bcf5@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749638036; l=788;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=J9hKPnnc2A0cweqLzbgQ20+H2ZBdLzJrRKeSWwaEXh8=;
 b=y59QH6VOrKYCRbM+cCLHExmUWoZ5H9o2+XZnq1vMJeDgF45OjhmZzACCvSOfHgZAY0JVJ/3PA
 4xoqQk99uI8D8nQPWXHJbp75GbIpn/imBIHOZiEk4u8JlJUAcfUoNNo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nothing from err.h is used.

Drop the include.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cba7a9b4a9b13b5eb17aa207972bd0..b5d5f59f725a703c357dfca91bfe170aaaeb42fa 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -13,7 +13,6 @@
 
 #define _GNU_SOURCE
 #include <elf.h>
-#include <err.h>
 #include <fcntl.h>
 #include <stdint.h>
 #include <stdio.h>

-- 
2.49.0


