Return-Path: <linux-kselftest+bounces-35818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B68AE95C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549A17AEF3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1DE23B611;
	Thu, 26 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUZc0rpi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TMEgLlBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183622F76C;
	Thu, 26 Jun 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918223; cv=none; b=Wedd3bNRJ4bE+9UZbK1UzVclZIwlf3BoEhvCW6ecOE5N8I0qnxJJ8ktKgr4jk0La4bq5Xebg+440UJQZCkZU8V3dIexUGIepHk4btDpTSOMhT4sf/5XyLiazRMS4He2LdaaLlahtAYm3p4csgKjPA8pw0lxhfT2QIhuu0hSWfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918223; c=relaxed/simple;
	bh=gqCHgGkLSpgEpmt5FdZ/9LIL89QW3SDjmv87W9fOnqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFNJ4hrsm3x0T0wo9bftUypOhDOdS6+jSrcI5uj1CpXnO1WgcfRl+c/3OEdU4o4WTuhfdJpYr7ZFMB337/8tyIBVYfeJwv1zSHMTYLQEtPDLK+ydW7VoRx66bhhSkz6iZtOAq108dWfVIe3d58B4p+WSEUND0Q9X3VtF0qNsy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUZc0rpi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TMEgLlBA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cL5EuxxowNhGrMXgAa2ZH9dASigX1qe/CuVbz0cNCr0=;
	b=DUZc0rpil97hjeJUL37x1IeCBEDyONTLhfV2DKcWv0QrEI5BwzdQHY23vBulpfI4LjVjh6
	JSQ24xId9M2yn+U/3IEhQDTWUDyQuXbQW9gks7iKVR7CZV0KfWe2LZkv0mtERQVwTBNeAk
	wFP7wJ6m+ePgUgn+xNJIW8vL6OnlgQrRrn2g7mWq5jT11JzWmOF5AdYrUP8zdyo81Jl4x1
	OQBCfux1+FYQFhIja30jocCvZP8s2CCMcYru5U9gJzOIKOe+tsQhdUbbk+zeiXo+BfO+4U
	zWrq8lqswDXNZfEwRaDqUEHYVsyErVaKX/n9IcQXalQQnOB/xm18jn/x0bUgvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cL5EuxxowNhGrMXgAa2ZH9dASigX1qe/CuVbz0cNCr0=;
	b=TMEgLlBALqF9uVPWDJip5Gmi+wcDrPKPbsJ7Z+nXUZxN2flh8tbEbaqKKSPpAd0+k3OZpS
	EhPvDS09ZRPHFIBw==
Date: Thu, 26 Jun 2025 08:10:11 +0200
Subject: [PATCH v4 03/15] kbuild: doc: add label for userprogs section
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-3-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=800;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gqCHgGkLSpgEpmt5FdZ/9LIL89QW3SDjmv87W9fOnqM=;
 b=5tWW3HhqVrYWVmORDoZv7+oK5gd6ntpqVJW/nHoywkYSOL+8HJEa9ACeSxB7wqrSCy7nJTAL2
 OguMoSYpHlWCkemYqaiOBewMmJZ6JzGaRXkuzAfQ8OZ12gSVCKVZFVa
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming new documentation should link directly to the userprogs section.

Add a label to the section so it can be referenced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/kbuild/makefiles.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 8aef3650c1f32b6b197e0dc777e26775d371a081..c14c1f632f6069c8751c8388a35bef539e19f9e8 100644
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
2.50.0


