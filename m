Return-Path: <linux-kselftest+bounces-26462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59257A32630
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 13:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7AD3A451A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109A20B803;
	Wed, 12 Feb 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zt5JZ0sm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHoi6ODK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAF27183F;
	Wed, 12 Feb 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364561; cv=none; b=VqQx2f16Ge6WMvdCgFMqoRQKR93Mb6OZkXpUrtCfZ17WdAkQo8UhOfuTZ3XY0BqMa6NXHFoZK0gBAfu3SCd3/AgyFCB1TqQrAOnaRbvlh2rCc/pMqr/hZNtT3reOnKsNDeiCAMzUVG1BuQPWBIZU/CTKbIZwNB/s0LOUsMlJcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364561; c=relaxed/simple;
	bh=NL58RGQUo5cvDWALIIvtJzK3eZ89+YFSNsS/E+/xOYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=je30RYmSAnJDoqiUeJrw+fgYTaMYnjZ3ycru2eZ1ojW84+ZKlo6qvkkQf1bkVoCPtTOmPwFYIfNNQtuMEO0GNzlAAjv5TmGTZuxoVr1bHKDR73PhvRV1jQTGp555cjF9qSXW/Uvh0LEQbvFn5oV8XOy+z+5YID/ZdeA4JalNviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zt5JZ0sm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SHoi6ODK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739364557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qSE35Z9rhydIaSHAG0noyN8q9MSMVAvkn+jqzXgS5LM=;
	b=Zt5JZ0smQy+kxK5j8Za0NvLqHkdAgq9fUF7i0kyqT4Rv2cRchDrMt4yf5qLSOCIZW8ieRq
	CRebHDkgksGNt56pb54GfoHYKGXeZuZa6QrJAhVC6NMpXB/VSqBVJzBF7Vq58hFZawdmxN
	RZwDMUQlU8ZgQOKV79oBy8/GP5A4DPPcYD/pfXjTBAFWq6WQNirySlBVTJi8hu0mR3k3r1
	kung3dabubcvUP7KXWLPf4f4UH+mrNOggx/eo34NKc0C1gnNisT4nugRaLFGuvnDCV/6xc
	wO80uot+XmN85WWr17n25TeT0S7vhsptaGpzpVc564AHciYPirqQggOi1UEkVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739364557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qSE35Z9rhydIaSHAG0noyN8q9MSMVAvkn+jqzXgS5LM=;
	b=SHoi6ODK2ZAoWeX9WaCSBK4N/zB034ZJLd2+0fheADeJjwSaQlQf1ISynPa/EFkEX6MTp/
	+d0hfQhAHUpYdSDw==
Subject: [PATCH 0/2] kunit: qemu_configs: Add MIPS configurations
Date: Wed, 12 Feb 2025 13:49:11 +0100
Message-Id: <20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMeYrGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3ezSvMwS3dzMgmLdVJO0VMNkIzPT1BRzJaCGgqLUtMwKsGHRsbW
 1AATm1e5cAAAA
X-Change-ID: 20241014-kunit-mips-e4fe1c265ed7
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Paul Burton <paulburton@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739364553; l=1084;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NL58RGQUo5cvDWALIIvtJzK3eZ89+YFSNsS/E+/xOYM=;
 b=4nBWBlSDRkDFl9aNAg9lYya2vuBvns3smhtBT5YJTUfvVRJn4kmC7gvUq6Avu/AhXSk7o61jh
 gv4wkUyQtREA7MCgkkswzkEAq2o1IRaLMREW5MHLcxUIxksebhndKQr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.
Various kunit tests from drivers/firmware/cirrus/ are failing on MIPS.
They are fixed in [0].

[0] https://lore.kernel.org/lkml/20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      MIPS: mm: Avoid blocking DMA zone with memory map memblock allocation
      kunit: qemu_configs: Add MIPS configurations

 arch/mips/mm/init.c                          |  2 ++
 tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
 5 files changed, 76 insertions(+)
---
base-commit: 6e24361511062dba8c5f7e59d51b29cdfa859523
change-id: 20241014-kunit-mips-e4fe1c265ed7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


