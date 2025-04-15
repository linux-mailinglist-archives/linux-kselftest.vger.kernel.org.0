Return-Path: <linux-kselftest+bounces-30874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00436A89FAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3733BBAED
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B178183098;
	Tue, 15 Apr 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ci7ITpxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2Pq1gg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52B33991;
	Tue, 15 Apr 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724296; cv=none; b=p0dfhUDGqG0NwlCB15J8Ag30N3m4swKIS2TTXxou2dvX9gpAZenhoIYMjLlz/r6B00D0N43LGBabgC0pO+I9jBTK3EPJ2h0PE5xeMcsBmVn1e9zq4ODJu19gamsy0A0qJPpeKScFku50BrwV+00YQMjfnwbTH7NTWmnxWukMpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724296; c=relaxed/simple;
	bh=8h7cnDyT7CpfZiXWBknY7sRG39xemkDQf7k2Dn7ZoZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZUnV2QQZF0AzvfMATMxBu5WFIRaBYgmWrTVn01ElSOE/o8PheNSipirwn+CVmHdX3HUUopMv24PLOE/Hq5aIfH8KpX4PB3rk0bqtekzWPuD9zCu2ZWVKMuP441dnfYOqxb37xOsZNJ/93DVl6nQyJdPoJmpTnmNdhEoKaMNWgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ci7ITpxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2Pq1gg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744724292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7KfnEtdNskwsE/aBmqy/Rv5rhdEV8ASnC/Rm78THDgE=;
	b=ci7ITpxBSSAcMMlFXfAH/tAeMkQot/Y4Bhis9/2rJVZe9JiHOOGIV9jwOQb0GPPhccS9YB
	pkF3okMoD3aiRw0nuoOYu3Z2Z9S+O7X4A0LhPwiglc7lfm3AJTqAIi6gJa2ZHjyKLA9OKw
	y38okekV9Fn4eDx+KDtk9lcM05kJvcoPRMpzQw1hr8nkGcqZdS2+n8Zsf/QyIW/C4k76Y5
	pRFtFTVfok9/sG+wJsH7fi86n5f6AZgxxKBhlGo7osOjLjVU/bjXB6klv7ZrudbtaRjcpH
	q6LgMmhWCMHuIX7Iu3HixHlQSb9rbRF/cHKR9awH6irrUV9eF6R0A39o8YhOFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744724292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7KfnEtdNskwsE/aBmqy/Rv5rhdEV8ASnC/Rm78THDgE=;
	b=f2Pq1gg6rVoC0+urLaWRwnSyOb1yiMvCtI981fK5LkStGMjqP95gG/uIOKMfW9yhcmqBvk
	5gp5b4q1dqYA1GAw==
Subject: [PATCH 0/2] kunit: qemu_configs: Add 64-bit SPARC configuration
Date: Tue, 15 Apr 2025 15:38:04 +0200
Message-Id: <20250415-kunit-qemu-sparc64-v1-0-253906f61102@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADxh/mcC/x3MTQ5AMBBA4avIrE3C+Em5ilhUDSaiaBGJuLvG8
 lu894BnJ+yhjh5wfImX1QakcQRm0nZklD4YKKEioTTH+bRy4M7LiX7TzpQ5cqV7UirrFBOEcHM
 8yP1Pm/Z9P9icxBlkAAAA
X-Change-ID: 20250214-kunit-qemu-sparc64-e9ad2883b8e2
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744724292; l=631;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8h7cnDyT7CpfZiXWBknY7sRG39xemkDQf7k2Dn7ZoZU=;
 b=Wo6N/92Xd9DDMrtulyVjI4tOcBrzhy/lbYMrK764YzGYBkhfUI7lyAoIV4K/k4npACfpVVlHx
 S/psM0SRc/oB9HrCseOzL+NNBr2YOpNXpQy35Q3ljouCKI3jxLa6+ts
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on 64-bit SPARC.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      kunit: qemu_configs: sparc: Explicitly enable CONFIG_SPARC32=y
      kunit: qemu_configs: Add 64-bit SPARC configuration

 tools/testing/kunit/qemu_configs/sparc.py   |  1 +
 tools/testing/kunit/qemu_configs/sparc64.py | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250214-kunit-qemu-sparc64-e9ad2883b8e2

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


