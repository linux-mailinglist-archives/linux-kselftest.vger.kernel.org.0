Return-Path: <linux-kselftest+bounces-30875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74F8A89FAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467C83BC0D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48B18787A;
	Tue, 15 Apr 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BCyJHjT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LV5MtKPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57B17A2E6;
	Tue, 15 Apr 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724297; cv=none; b=d8+TVAkTn69m/D5z0WinQeUf1uSPFLBkn7vnm7dto66Pzl+T1MhOe9j/jiS8VKNI9HacZupikz/MsEi4mFvERdVSDqdifd5zWKEyfMqL8DrwV5X0/S+GNy2LCDYyUtBfW38DhaXI0mvnXRAKJAF93Ozzrx7zlMxl81O/arNuFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724297; c=relaxed/simple;
	bh=CRmSE44PtL62RA/OUQ0Ro36Qg+FCiIzngXc88ZUyEas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqCGfdEeR4tlGihkq0/yy6FzZ6vEpcmacmoZq1JhH0D4O5gfpz5m3RZ/WVJc2KXFfKlAS+yfa50OqLNvfnNz4tmeRMZQUR+W34RL/dq12rhv7vbb0UFqZg7/IcxIWeLzZHUV5eMaUuwKH8potxaU+nMgcg1AemuX5cjNSGT1LcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BCyJHjT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LV5MtKPI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744724293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awzhLtQe988u1/wspRET6fjeWqJnT8OCJfAgCbHL5VM=;
	b=2BCyJHjTBJs73rpG2yJ/7oKrIin+CshUIaRRDnGrxD23La/Ib5ma/SjuUOrQHSiBuySGrq
	6im4DAJa3IcP7ZuG+6yAaPtlvfIPRAYMrFmQ2j8st3Td/hajNym8q8gW6OIks0EFBfxUHI
	rXBJnid5GW54IPdUO/MOkVAFJsfS0nSRsSN6QH1LniBCMYCqPzcHzGhoRXtMeULKHPWrRW
	WtCbEH38rH4QhsVtdAfBuSYoVQDSAKbC5HKd6L9fsZKTQmyuJiFOImur9GjJVnLQ5+U1Jz
	aKpq9FGdeWzWf6PUybzOF9XXgiV0zQdKLseqylBxEUpwx80zYzTGrKZf9W35bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744724293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awzhLtQe988u1/wspRET6fjeWqJnT8OCJfAgCbHL5VM=;
	b=LV5MtKPI6wVvNANjBeX7iXVldy+4rZ4x1cz61FsDJ1XEun8OonICJOwnam4ucuXB70yk9O
	bqarrkXWaece0bAQ==
Date: Tue, 15 Apr 2025 15:38:05 +0200
Subject: [PATCH 1/2] kunit: qemu_configs: sparc: Explicitly enable
 CONFIG_SPARC32=y
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-qemu-sparc64-v1-1-253906f61102@linutronix.de>
References: <20250415-kunit-qemu-sparc64-v1-0-253906f61102@linutronix.de>
In-Reply-To: <20250415-kunit-qemu-sparc64-v1-0-253906f61102@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744724292; l=901;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CRmSE44PtL62RA/OUQ0Ro36Qg+FCiIzngXc88ZUyEas=;
 b=mgeQJxMT7Xfp8DxzglQ5dgPJ+IOJh+BzAAggwhmhfG5QBp3n0612aHK5psrXmX14P+64rxkzg
 nAEbLPxzSYUAbAKuSJVTX51GM4ww8Jtw6x/fGRmjBALcvgEjLdCitBq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The configuration generated by kunit ends up with a 32bit configuration.
A new kunit configuration for 64bit is to be added.
To make the difference clearer spell out the variant in the kunit
reference config.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/sparc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index 256d9573b44646533d1a6f768976628adc87921e..3131dd299a6e34f027402e99e34d85ddcaa359b7 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='sparc',
 			   kconfig='''
+CONFIG_SPARC32=y
 CONFIG_SERIAL_SUNZILOG=y
 CONFIG_SERIAL_SUNZILOG_CONSOLE=y
 ''',

-- 
2.49.0


