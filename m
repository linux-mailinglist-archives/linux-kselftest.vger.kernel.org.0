Return-Path: <linux-kselftest+bounces-37105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395CB01D99
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79D4160DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E82E0415;
	Fri, 11 Jul 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDH1AoQS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ic8npGb8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE12D7801;
	Fri, 11 Jul 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240709; cv=none; b=fD5/g4/JXgqG9tHx1nlR2M62ywPxlqQqAyJHhbhTCaKh956WDRhjwFnsKL+Ud9ntdKL/xLcR/sjtSCxLrJ2pQn28MV/j30TrmQgp1NbW1+yXr2apPaZyoGxN8vVLQCcGWL7i5PbVk4lzGiMwzUdmc/s0h5+7kwSD1rQQ39LzP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240709; c=relaxed/simple;
	bh=akzqxCJYe3g5iXTVNXCFr1ykXAcvEObIo6AJQjyu3Cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M+7Au+ucnQDcU/rri65HK0V2q+w/X9IZKYYaQwjkvYjz3ML/uJJZXG/mF8poOnoleTWVHr8wy28ZufSl+ifk76sVsi7632Z9ffsX69XK8EfkSosbVK8zsYa2TDGlzkydGNxyAtcdoIHCjq6UbU0X3HKdtq/t2uSuiJFnQcAKd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDH1AoQS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ic8npGb8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752240700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H91oCvwVp0AF+0FGCHevDcHAmkx+mnTbFw3DAYRKe3w=;
	b=dDH1AoQSpuY2YLOHUTpImvg0c0Uuplby5+Dc0xEj+53det/+Wg+057ZrcmtpBforB06FxS
	uXUYt2efvYDMidHhVakKfsTp5jtqUR3q0rcSaF64Sp2S+15cPcFwaBf5tZQd8EI4d502jx
	8/qv9FzaOL8PsmuO12w8R/g/TpVplKnvT/Fp4fhivtQuCmGJa08BhJRbBLSf+Ta5cL7x3R
	/k9c5Yb1DiYmFEuXQV/HyF4+c9tQeZH8jWvreJuyVcIkWli8ZXiWLZ7SQlimS1Y7VdFPI9
	dt/hAgdy6HvVAjl9c8Grin1Zp34GCMXcn7fYSncuGtMWunUQm1BQgW8wiajX2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752240700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H91oCvwVp0AF+0FGCHevDcHAmkx+mnTbFw3DAYRKe3w=;
	b=Ic8npGb8VMMWHF4kfz9h73VS9DTvbIHPfAZNnQkw7leybhWe4SsU1alfPGAwXvlI4HuzhO
	DYdWBrkAro1EyiAA==
Subject: [PATCH v2 0/3] module: make structure definitions always visible
Date: Fri, 11 Jul 2025 15:31:35 +0200
Message-Id: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADcScWgC/22NQQrCMBBFryKzdiRJrYgr7yFdlMyMHayJJG2pl
 N7dWHDn8j347y+QOSlnuOwWSDxp1hgKuP0OfNeGO6NSYXDG1eZkLT7GoAOqEAs+I409ZzTCQrZ
 q2dYVlOUrsei8VW9N4U7zENN7O5ns1/567m9vsmhQyHs6OvIi52uvYRxSDDofiKFZ1/UDbPxnK
 boAAAA=
X-Change-ID: 20250611-kunit-ifdef-modules-0fefd13ae153
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752240698; l=1230;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=akzqxCJYe3g5iXTVNXCFr1ykXAcvEObIo6AJQjyu3Cg=;
 b=5S1gyVhOvm/2XHJ74lvdpyP7wyGHiib7XBVsxmWmNrjum+DrvcT8Ul+glgZa0WzT6biJk1pMZ
 Q442ISEajhiBLrSrw2SCKe/ttOQ3ziuy3mv37FtJincYfGXvKf8HFVX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Code using IS_ENABLED(CONFIG_MODULES) as a C expression may need access
to the module structure definitions to compile.
Make sure these structure definitions are always visible.

This will conflict with commit 6bb37af62634 ("module: Move modprobe_path
and modules_disabled ctl_tables into the module subsys") from the sysctl
tree, but the resolution is trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Pick up tags from v1
- Keep MODULE_ARCH_INIT and 'struct module' definitions together
- Link to v1: https://lore.kernel.org/r/20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de

---
Thomas Weißschuh (3):
      module: move 'struct module_use' to internal.h
      module: make structure definitions always visible
      kunit: test: Drop CONFIG_MODULE ifdeffery

 include/linux/module.h   | 29 +++++++++++------------------
 kernel/module/internal.h |  7 +++++++
 lib/kunit/test.c         |  8 --------
 3 files changed, 18 insertions(+), 26 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-kunit-ifdef-modules-0fefd13ae153

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


