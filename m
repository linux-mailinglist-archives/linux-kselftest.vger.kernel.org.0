Return-Path: <linux-kselftest+bounces-27494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CAA44788
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBF17C799
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD219E98D;
	Tue, 25 Feb 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bVb3egme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084519A298;
	Tue, 25 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503353; cv=none; b=BSBZaGT5JP/tmsS4QGSUQXL1lBj41B1TqqDfizw2JmghT2U+lXpzPuTi0FLb8RkW5HXjeDXyiDfE1z8eUxYdvq0iwuasroGP1PjNKvMXUuigfk93RIsUVKIdXO+yA88T/PRZhYyqjskRJ9OiLNzaoEes9+dRtRAuHYLdUTPbqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503353; c=relaxed/simple;
	bh=Hmo6YD5So+rMxnK79iV6JpsX7+VICcEX2SuwFU9DkAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ENtLClPVf9CzxJO8OI4+GFJtZJ4b32FLYuRckBc0sF5YCFveFe8uSlgPAvbr06kXBM4XOHeF6Q4JNCNxBP+qvge9+Nh1W4mwzn55oMlUTIewGr/HaoCvshJH6Hwq/hcHUD4nI0BI1JsFUUCN787GSzEqrTYfGWL9zBKhwyJ6ktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bVb3egme; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=Hmo6YD5So+rMxnK79iV6JpsX7+VICcEX2SuwFU9DkAo=;
	h=From:Subject:Date:To:Cc:From;
	b=bVb3egmer9EgCrv6r14QEidgWE3Nye4wk1MrfwgbdICw4eaRReBXExvAjEiATKZak
	 Ga7gNkEtn4myawL7i2PkLELWprxDMJxIgNatHmBH3p+6fVl0ExjDbqwWNd2pg6d/Sp
	 IcI1nPhF3oczW5qIJADDMCTekNQyjA8BUpKaGUPs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and N32/N64
 ABIs
Date: Tue, 25 Feb 2025 18:02:34 +0100
Message-Id: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKr3vWcC/2WNQQ6CMBBFr0K6dkxnKgZceQ/DQuhoJ9FCOogaw
 t0tbF2+l/z3Z6OchNWcitkknkSljxloV5guXOOdQXxmQ5Ycoi0h9g9pO3jKoBAdAblDbbH1NVp
 v8mpIfJPPVrw0mYPo2KfvdjDhatdWaQnprzUhIByrmrisPDrC85tFVbvwCvvIo2mWZfkBCD9Vr
 7MAAAA=
X-Change-ID: 20231105-nolibc-mips-n32-234901bd910d
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740503008; l=1063;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Hmo6YD5So+rMxnK79iV6JpsX7+VICcEX2SuwFU9DkAo=;
 b=CUgHOckoF6p8mmdlngvJmfhUJmy8vKRxZm2ykKlwGsnM9w2n2Juu5T8DnjybIaPj4uflMPGlW
 edTfesF8IrNAj6U/JkYegvBJsE0NcB2FLWHM80XnFEbbz3ndHQzL4lX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce support for the N32 and N64 ABIs. As preparation, the
entrypoint is first simplified significantly. Thanks to Maciej for all
the valuable information.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
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

 tools/include/nolibc/arch-mips.h            | 117 +++++++++++++++++++++-------
 tools/testing/selftests/nolibc/Makefile     |  28 ++++++-
 tools/testing/selftests/nolibc/run-tests.sh |   2 +-
 3 files changed, 118 insertions(+), 29 deletions(-)
---
base-commit: 9c812b01f13d37410ea103e00bc47e5e0f6d2bad
change-id: 20231105-nolibc-mips-n32-234901bd910d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


