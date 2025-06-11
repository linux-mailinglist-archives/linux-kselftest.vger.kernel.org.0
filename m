Return-Path: <linux-kselftest+bounces-34648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A8AD4D20
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1463617C74C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C19238C08;
	Wed, 11 Jun 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7Z91fB1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XrPFzeWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6492356B3;
	Wed, 11 Jun 2025 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627517; cv=none; b=Pvedm6FniaJqNs2UN4/mF0AOmI3iSdsE/8hKYr1mbHjLVgXJoPlbr0kFKt4FhpNMsrstr8rMHD2X1HHfGj87h7tXU9V5vIEtzcbo0PH2AyK/RTdyS1CY6GjFw8wvdzTRNUddSJYvFL6E8TNVbFeuI7C47fgjEnEJlaQTlGOnq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627517; c=relaxed/simple;
	bh=oUkJFiHVSNpRRfiuTGCTp6nUhDJGSME1Xr0CfXdtdoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFcIr4dsumeL+Nb49HuaeXMw/65onRomIz0ehv4I2FjDAozctLR3VkV0OPbNSMwwZI8BcorzWa+91d3maVEB/ZmHFFPRs2CYjyEV03pO3Wf0jq9UTFzTqfy5N7n38018ytesiOj0q17GB56AndgC6xMuTIN7QcAlsYimQf6XQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7Z91fB1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XrPFzeWW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jdu/Go4SV5qRaqiaKhllMqx5OXzM41p0GtpXKOIUrDI=;
	b=e7Z91fB1vallOUjZUNrsO4Z55jFsqYvlY4HHephEEeYBuSk+tmsXoK3j7YhaVypVI8cBtu
	Jjd9sEdlu6b412OKur4cdbuC6ecfGS6VDqVdOYsOcTdI+rZzvssuQHyvtRhW27dLsXmaEa
	mdu+lkVWnBf93I3y4wE0WzHt+T8zZJULXhV1v3o5eE+C+YA8n1zxnrClVYg6vh7skymoSh
	3HYf2sySkwaey4jcShNeu2SgvTfTmO3iv2Pki/zEqmgK750Bcwf96xcFmKsCO7Or1+09Me
	XcGrxLUDnV6uODvgo0MqiaLjbdKDNxKGJDaoZAtbMSnSGiIxMGaHuxRCeSLxhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jdu/Go4SV5qRaqiaKhllMqx5OXzM41p0GtpXKOIUrDI=;
	b=XrPFzeWW/HV/DxmvdsF0KCXIjFmh/fnW2o2Ta8YdF+9ZUSr0durYeotrh2kXgb+WfGbKN8
	0Sii8rbXP2S3KdAw==
Date: Wed, 11 Jun 2025 09:38:12 +0200
Subject: [PATCH v3 06/16] kbuild: doc: add label for userprogs section
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-6-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=800;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oUkJFiHVSNpRRfiuTGCTp6nUhDJGSME1Xr0CfXdtdoU=;
 b=fW2l6DvURy9crOmbdwFZlP/AeJHt4Y3p5726+DixNW0iHRf41O72qIyfYfkfxhgae2OL/CTBt
 UuY8ic+qIqWDEzSQz2o+92JxyDiEnRCX5fGe5AyWfmQeFArjYnkii1k
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming new documentation should link directly to the userprogs section.

Add a label to the section so it can be referenced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/kbuild/makefiles.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 4cc7a1b89f1803857a4723284613111e9ad71d92..2adea36ac6ebf6c292e01a3e04c0b633e3c1b8ad 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -891,6 +891,8 @@ This is possible in two ways:
     This will tell kbuild to build lxdialog even if not referenced in
     any rule.
 
+.. _kbuild_userprogs:
+
 Userspace Program support
 =========================
 

-- 
2.49.0


