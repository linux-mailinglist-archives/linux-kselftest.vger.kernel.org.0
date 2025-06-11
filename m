Return-Path: <linux-kselftest+bounces-34690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DCAD53DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C343A4BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68D25BEE6;
	Wed, 11 Jun 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2yGevFN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUamVAkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1A2E6102;
	Wed, 11 Jun 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641320; cv=none; b=pFHL/qJCCSHbb+gYsGMPYrXqY5ES2BgKb8emPPCTZ4YUgAKCrcb4I1c1Ddns3EpIM7ksZgBiYRSx/9XqM+W9KuQC7uptqjJ6U2AeEwCG8QoS6L+WTzA28W4sfNGeRbPlQE6V7blHNkJxq/rThVP5j89slmBi5Qlm7ifK0eUXeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641320; c=relaxed/simple;
	bh=hmVwy4P8GF90kNjTKVxfjbpxUv+vEAeOqExZXUX7TVU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V1geZf32WXyvZFM7tfDrNsbYjPXze5JGKss92Bgb4S+JsKFFA/eV8f3sNgmwuNFKMJ5sme9Q735HUU7cVzlAgUeDh3dDke8AhUm8VEFlJUpcJGt4rqPn6o3t/0V/3fywXU5yg4C01rFkr+iOPDscE9YkuCToSeb4wu9mQY583bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2yGevFN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUamVAkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749641312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GHv2KcbsS1/mwsMjRFZVxsR01KjDyT1642lDqUnbNzY=;
	b=t2yGevFN3lGXYs683ScYQqg3CJIyK8R7my9BX9zdNU+H2h/tRbF+JRktwPJK+69m4e4BUY
	r0R6js+AMI73UaZfsNA+VkwCdAD0C33wXEdyykSfHl1w1BIOfx774fT/d15XXuyHaB2Y/w
	CayKuvZ9tby806WWnaNVfBckXJZEvSfv5ysOD/ZIQtYpFBscD1lJeVXIFKNlAnMJqp2YyP
	LwemV6fOmk2DySW28TzJV9xnpTIh2srW2LApfGNVhTAcykNxCjOVp7x3Uu5Ppx5z1soZko
	B8gzwyzn/zwyxtwutqLmXYPdje6Yd3sbUfGwMqfqWa21AyAIyKx9J2hQEsR5MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749641312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GHv2KcbsS1/mwsMjRFZVxsR01KjDyT1642lDqUnbNzY=;
	b=bUamVAkGAUZ7ikZnYG0W6vlN8ZmvYE1XrRQ5zt7KV4C5jxp4sqh/daD7pqC7U0you6izxh
	9d+VAiItSKGIqzBg==
Subject: [PATCH v4 0/2] kunit: qemu_configs: Add MIPS configurations
Date: Wed, 11 Jun 2025 13:28:25 +0200
Message-Id: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFloSWgC/23OQQrCMBCF4atI1kYyY5JSV95DXNR0qoOalqQNi
 vTupt1YxeUb+H7mJSIFpih2q5cIlDhy6/PQ65Vwl8qfSXKdt0CFGhRoeR089/LOXZSkGwKH1lB
 diAy6QA0/5tjhmPeFY9+G59xOMF2njFEIuMwkkErSSZeurAtrwexv7Ic+tJ4fm5rElEr44fr7i
 4SZa9coIKiwJPuPb5fcfPHtxMmhtnAyVUG/fBzHN9pUtpwmAQAA
X-Change-ID: 20241014-kunit-mips-e4fe1c265ed7
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749641311; l=1561;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hmVwy4P8GF90kNjTKVxfjbpxUv+vEAeOqExZXUX7TVU=;
 b=YymmBFYQwTDoBVoP+rsyB9K+eYamRKVD64oLbtNCAK47iEdUVS4XeZ59yX0zc7Q+DXgzl1Kno
 4LGoeO94vljCGlWy5LOTWiuH+9pMLCKZYWifBHSXsi7VP4q3pU5jNkt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v4:
- Rebase on v6.16-rc1
- Pick up reviews from David
- Clarify that GIC page is linked to vDSO
- Link to v3: https://lore.kernel.org/r/20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de

Changes in v3:
- Also skip VDSO_RANDOMIZE_SIZE adjustment for kthreads
- Link to v2: https://lore.kernel.org/r/20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de

Changes in v2:
- Fix usercopy kunit test by handling ABI-less tasks in stack_top()
- Drop change to mm initialization.
  The broken test is not built by default anymore.
- Link to v1: https://lore.kernel.org/r/20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de

---
Thomas Weißschuh (2):
      MIPS: Don't crash in stack_top() for tasks without ABI or vDSO
      kunit: qemu_configs: Add MIPS configurations

 arch/mips/kernel/process.c                   | 16 +++++++++-------
 tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
 5 files changed, 83 insertions(+), 7 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20241014-kunit-mips-e4fe1c265ed7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


