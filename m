Return-Path: <linux-kselftest+bounces-23997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F6A043F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0914D18874F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC71F37D0;
	Tue,  7 Jan 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GastSH01";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBHHGAWz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72741F3D28;
	Tue,  7 Jan 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262900; cv=none; b=JgmLJjg9AOB5R/OaIR1XLeqM7bDL6IIbh2OV5WSVIQyt4CtDDFhGDQqcObBPsNQYwqV9jjc+fcAVJpX0KZrL9pS1aK27Tnj8hAlcBu3BVSOh6KmTaVmZ7QYVueyojOyk86qXfBuT3xdwyU5Eg5ltomPG+DlIwY6WwiEN+aZPQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262900; c=relaxed/simple;
	bh=JUGocPrWu2QxeYZ5cRItpEriLyPsPdb256CAX16xnb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QlnMlYmHDmqXStD0R+xP+ITQnfgSiJ5nQ+DCHjeP5tEmR2dRmQNIU9Kn896hWklnJTTQ7f/X+qutqeg9sI2H3DYK917dhEA7X6cBH908TVg8lc2/Nfc7hl4lDDYOjZNTcsISbfwnu0qVmSBU2mtGGMnIALJVPfuAW1Wu60tTDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GastSH01; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBHHGAWz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736262894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sCicWoiJ2PPUbfuW8fJ3dfo9H0yJpSulZ9DMj/yBOJQ=;
	b=GastSH01ogRzkOZD82Fid3xB3jn9NcSoiSee/lgVGEtNFtLLGD1Euo+f1WX6qtch3NRVfI
	Chm1AWhLB4T4RsFezdzZYxaYuYPAnPMAVN/VA7YI0roKbDS93DXxGUNGu5XwV4tfdhuuWH
	fdJuHe0+qp+wKecvOdUR+YuarkJiwJ0tdMg/TPhcsZMQ6csxb566D7nAqCmJnx08kqCcXe
	5EZbJ6hQZaPbG37pHNMglgjpDAOcPGmrKnkKuJSlSPew8DnhZNOoaBqstNTXFtgXk+vlsq
	Km1aZnz0S4wvUe5xEFtyZtApLIPeiHqKGFHtkoj7QHxWLUhgU5L/k/wvrsN0rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736262894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sCicWoiJ2PPUbfuW8fJ3dfo9H0yJpSulZ9DMj/yBOJQ=;
	b=OBHHGAWzrs3hcUocIj8fwNvupeAjJHv3TUlqBLra2Pgff4geXaq70k43BV57RK8yg9cEKx
	17oIcxsIEAipEjCg==
Subject: [PATCH 0/3] selftests/mm: virtual_address_range: Two bugfixes and
 a cleanup
Date: Tue, 07 Jan 2025 16:14:44 +0100
Message-Id: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOREfWcC/x3M3QpAQBBA4VfRXNtav4tXkbbNDqaEZpaUvLvN5
 Ven84AgEwp0yQOMFwntW0SWJjAubptRkY+GXOeVzrRRF3E43Wqd94wilv8ooARRbdWUhanrybU
 G4uFgnOj+7/3wvh/7UwftbQAAAA==
X-Change-ID: 20250107-virtual_address_range-tests-95843766fa97
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736262892; l=842;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JUGocPrWu2QxeYZ5cRItpEriLyPsPdb256CAX16xnb4=;
 b=2gfAGnXQw1hiHxNv7xHvpqQxjBKUovhW4dlr/7eq6B2gJM8zjGHqfpHVHYb2SJyERvxvUbTBn
 OJhSSXjkz+UCfLXeByK5H1tPkrREsCtIArCtQwU325Cx2dtoJU4UuIb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The selftest started failing since commit e93d2521b27f
("x86/vdso: Split virtual clock pages into dedicated mapping")
was merged. While debugging I stumbled upon another bug and potential
cleanup.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      selftests/mm: virtual_address_range: Fix error when CommitLimit < 1GiB
      selftests/mm: virtual_address_range: Avoid reading VVAR mappings
      selftests/mm: virtual_address_range: Dump to /dev/null

 tools/testing/selftests/mm/virtual_address_range.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)
---
base-commit: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
change-id: 20250107-virtual_address_range-tests-95843766fa97

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


