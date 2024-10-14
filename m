Return-Path: <linux-kselftest+bounces-19646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3B99C919
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D1D293149
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1983C1A01C5;
	Mon, 14 Oct 2024 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4CTyyOx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zg14PZAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F64176AAD;
	Mon, 14 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905821; cv=none; b=NU2Rkstr/PMArzTzRuU5njgefyDZFt/trS1JVNaaXu5hIXMHLEsQgzEUDNEhN7oUMcsgxMv4SZAlhzMABLbiB79XN/7aBt+ad89vUJVf6fVNPmWkRMlTvEH34uKNytcHi82hC322toqQQ3WBZVjHF/HxK/djFP595I6Ge2XpldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905821; c=relaxed/simple;
	bh=iV9iYcnvXEvBIGYtw1XBB2r0gTapDMBeog8rfya7C0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iy477pPA84nb2J3NTPhM+eF8Wlv69HtYVkmQs34UiPtVVNJHSy1BwCr6bVHFjk/GnTUMr8oE3UprHRezDxNk791Ojq7m4ZVdL9yxOkWf1QOH86uipdJeadGqvX4RMNeLOeI/1Iyw+4IEwcyOzRifgMac4FNs4bewpqCr+CZ3gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e4CTyyOx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zg14PZAl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728905816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLsVtAZb2EYpxmn9symEBJzk9S6QfVhcbYEMjgcfIsg=;
	b=e4CTyyOxYILPG30h7pyThAUs8wD14RA0jZPAGrDei0jOty3abXFwa3AbDtsH5+pbP9MN+J
	5Mlnl3UO2PNYTVtvJlfiSJqJgvOPYq7TDEQLDU/K0qsa42msfKyG3w4LVG6arYrZzH/IrG
	KF2QvMOGdyGyz7JKsRju6a2YahsQv5lwwdxXok3wOYdrpq8gtqvn1396EmmlXafUNCw4/g
	ZkqwDpSkFGNXvdylwH6mMjiZiGWEvzoFKO7/vT+rTEZFxiQOWnZTaOjenwy/rOXq92YNM1
	7O7/KRdotpPYTdM/Ssxp8kn4zewI2/x2gL9di4nTsMR54KHhQfGMakVw5hv3qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728905816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLsVtAZb2EYpxmn9symEBJzk9S6QfVhcbYEMjgcfIsg=;
	b=Zg14PZAlJEQcDEen6OHbhXImV/XxL1LGb2tNHCVB9g3JtdLOjgV5KwECbFsjohAmVMyGts
	D4dBHaj5SMX+bDCA==
Date: Mon, 14 Oct 2024 13:36:44 +0200
Subject: [PATCH 3/4] kunit: tool: Allow overriding the shutdown mode from
 qemu config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-kunit-loongarch-v1-3-1699b2ad6099@linutronix.de>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
In-Reply-To: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728905811; l=1298;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iV9iYcnvXEvBIGYtw1XBB2r0gTapDMBeog8rfya7C0o=;
 b=RSxObr6NF8M25HxJfwEBRbSNlGHQZpyR+R6RVKYbEeiHcGbJOEzHt2uPWVZk0Kfd0cNnEvyMH
 DrroxlD65g+AUZOqsRA84e8zEx/BlWQnwvnAYAOT0sybIrB0hExU1Dt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Not all platforms support machine reboot.
If it a proper reboot is not supported the machine will hang.
Allow the QEMU configuration to override the necessary shutdown mode for
the specific system under test.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 61931c4926fd6645f2c62dd13f9842a432ec4167..e76d7894b6c5195ece49f0d8c7ac35130df428a9 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -105,7 +105,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kconfig = qemu_arch_params.kconfig
 		self._qemu_arch = qemu_arch_params.qemu_arch
 		self._kernel_path = qemu_arch_params.kernel_path
-		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
+		self._kernel_command_line = qemu_arch_params.kernel_command_line
+		if 'kunit_shutdown=' not in self._kernel_command_line:
+			self._kernel_command_line += ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 		self._serial = qemu_arch_params.serial
 

-- 
2.47.0


