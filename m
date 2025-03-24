Return-Path: <linux-kselftest+bounces-29642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190ADA6DC81
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC713ABBAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209125D8F1;
	Mon, 24 Mar 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6lXpAJx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dM2yThrl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A992A1BA;
	Mon, 24 Mar 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825006; cv=none; b=kvLBhjQkTtqqpSbHavn4+GHIR55bsF9v/8aJUuFyeMnAuY9fPnfvjk15LKjpHWczK8r4xZvFJn7nSplE9+CVIqDpsBRfydoeQKXESqhJgAh+LHCSiSIpJ/Bos15thVCCNhzPc/qbagiX/d2mnR4NFRqrSYkyWNqXcCWCQB+92Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825006; c=relaxed/simple;
	bh=c9hPsufhb8A1ilMqUEF23h+pAz+YFjjN0Yxp0Z1ABB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oawWgs3Vn77UPlXfuUKDKu9pnMmbSP3x3AQKOejm0fY98XxLZ6ZX7TffKqQGDqWJ/Rf6ajAgEJsZ+cYZhnosWIRq4Bs1lvaKNPCxLYw13TSEM4CXrrfbnwLIRREfA09cygs2yBwbMOvr6+sjRrRaXCeX/aDjtAac/MsIzyaB50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6lXpAJx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dM2yThrl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742825003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ANzA6VKNaCYui/4ieC9n+ReV1YCAKogpYDH06EPOCGI=;
	b=G6lXpAJxgYLE2wWsvm8LpsdIa9QK0DpmQ9G2GJnktdxb/iyKWFUA5+bLgkjGcr7VaIVKUU
	CFLpV0KWxyCbkKSeTGblBIBCMT1hsFgTzpjueVSGqFK26aU2W3M2isRwamLKGi/K5XN0J2
	RDpYMnK6p/lGwSSXs5yKTQeB+fd41/o+uVjpmL+cdroIOXXWUeyHf+Gns4EsEr84kIqtWO
	AMRmhM21tlf9s0htFYD2ZkWt2Dx0F5EwxNX1V/0ZdA+UPwz47V91VCf7r1sPigPvKQQuC9
	P/EKWf9K1AjQjcA2KgxOnimSIxFzFh888n//En65aoUBLBxidX7AoCdGlt1hZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742825003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ANzA6VKNaCYui/4ieC9n+ReV1YCAKogpYDH06EPOCGI=;
	b=dM2yThrl3CtUI8FxfxorDgQQOH4HYvCqP6X/g6h5DrMX1pz2OtMGcIxvJui0kna4JO1q0a
	fX9Gd0xtYKiuHXAw==
Subject: [PATCH 0/3] selftests: vDSO: chacha: Bugfixes
Date: Mon, 24 Mar 2025 15:03:14 +0100
Message-Id: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJm4WcC/x3MMQqAMAxA0atIZgNpVYpeRRykTTWLSgMqlN7d4
 viG/zMoJ2GFqcmQ+BaV86gwbQN+X4+NUUI1WLIDdbZH7UbCO+iJ++PXC2k0vafovIsGanUljvL
 +x3kp5QOip3iPYQAAAA==
X-Change-ID: 20250324-s390-vdso-hwcap-0914c0f7c7f1
To: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742825002; l=641;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=c9hPsufhb8A1ilMqUEF23h+pAz+YFjjN0Yxp0Z1ABB0=;
 b=72ulxBlQyEToCIz5Xe0YlihTWRn4sUSsF4CObV5xcgMl2XgTw6HQ/Ekr9LM9ZEG2Dtk+JLulB
 5amz01ZUSvDA1BCd2LNMSaWzn3WA8X9J4UTdDiTQ/x4GJw8anpL7dw8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Bugfixes for a few issues I ran into.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests: vDSO: chacha: Include asm/hwcap.h for arm64
      selftests: vDSO: chacha: Provide default definition of HWCAP_S390_VXRS

 tools/testing/selftests/vDSO/vdso_test_chacha.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 586de92313fcab8ed84ac5f78f4d2aae2db92c59
change-id: 20250324-s390-vdso-hwcap-0914c0f7c7f1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


