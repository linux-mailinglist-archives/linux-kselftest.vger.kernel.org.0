Return-Path: <linux-kselftest+bounces-35647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA94AE5081
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E7344028F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E31F4628;
	Mon, 23 Jun 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i3pI18Ya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DE1E5B71;
	Mon, 23 Jun 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713946; cv=none; b=V7NRZrxuG5JMx9PFOERz8iYMXpNmOtIZRct4MxDvmY6A/4MynWbOhVHEAC7+VxWmzzmuXLNtxc/AoQnlnP/a8EkIKicv+KEDgwx2Y3sr4KggzLn9NS0sQGF4p6CV+Jbbv1TqX5131wNiRF+CTdefU9F7xoXUUSHgaAw2lTpGRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713946; c=relaxed/simple;
	bh=BFWPU9McqFUoA9hbyWmAynF+ubDhPVDV7lapsGctsSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H9k/jlXBKMIUhtmweteCX/5E4rzIAkjvDv6RtzAEpIwjKAHFyCaIskvNo3ClNLgxVL5z0OMcLYnNdSrwdUnz3HprlrVMwJc8uB+EDrvCAJLUj2gBjUER1V1lU4WsrEUl3Byclpa9Mc4sRCbV5monNzVc19fPgSy0WBBxluw7ZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i3pI18Ya; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713942;
	bh=BFWPU9McqFUoA9hbyWmAynF+ubDhPVDV7lapsGctsSw=;
	h=From:Subject:Date:To:Cc:From;
	b=i3pI18YaAez5/7kZLZHHeH7JxXBalJ5Ht/HAngpuk2boJYao7wiwQeUBCRmDNvBIJ
	 jnMDJUTK6qAn51ww291Q+w7zRwE47fY88gDSMDgaEVZtI63cA1aOZfzPnMUuvEhfzU
	 yPf+nNRzFTFsG7rOIpCN7ru9C96Qfl6fohJNLK6M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/4] tools/nolibc: MIPS: entrypoint cleanups and N32/N64
 ABIs
Date: Mon, 23 Jun 2025 23:25:35 +0200
Message-Id: <20250623-nolibc-mips-n32-v3-0-6ae2d89f4259@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE/GWWgC/2XOzQ6CMAzA8VcxO1uzdnx68j2MB2DDNdFBNpwaw
 rs7OJlw/Dfpr51FMJ5NEOfDLLyJHHhwKdTxIDrbuLsB1qkFSVKIMgc3PLjt4MljAKcISGW1xFb
 XKLVIW6M3PX828XpLbTlMg/9uByKu09XKJSHtrIiAUFQ1mbzSqAgvb8MhhM6+7MmZSaxgpD+E9
 g9FAglFkbVZqauyb+QOWZblB5s+KGL4AAAA
X-Change-ID: 20231105-nolibc-mips-n32-234901bd910d
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713941; l=1219;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BFWPU9McqFUoA9hbyWmAynF+ubDhPVDV7lapsGctsSw=;
 b=f1UrF8jSeXhXaBKnfBBBDtn9cXiX7DhkU+D9YmyipKS0dFliA/9mQHL1NNDOpY0I/ff2DGv3b
 CCV1wU1X5MGDoeeYC7+MF7gVYx9zXH7/lwouvLhEyC7hI/E61l5FxPH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce support for the N32 and N64 ABIs. As preparation, the
entrypoint is first simplified significantly. Thanks to Maciej for all
the valuable information.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase onto latest nolibc-next
- Link to v2: https://lore.kernel.org/r/20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net

Changes in v2:
- Clean up entrypoint first
- Annotate #endifs
- Link to v1: https://lore.kernel.org/r/20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net

---
Thomas Weißschuh (4):
      tools/nolibc: MIPS: drop $gp setup
      tools/nolibc: MIPS: drop manual stack pointer alignment
      tools/nolibc: MIPS: drop noreorder option
      tools/nolibc: MIPS: add support for N64 and N32 ABIs

 tools/include/nolibc/arch-mips.h               | 117 +++++++++++++++++++------
 tools/testing/selftests/nolibc/Makefile.nolibc |  26 ++++++
 tools/testing/selftests/nolibc/run-tests.sh    |   2 +-
 3 files changed, 117 insertions(+), 28 deletions(-)
---
base-commit: eb135311083100b6590a7545618cd9760d896a86
change-id: 20231105-nolibc-mips-n32-234901bd910d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


