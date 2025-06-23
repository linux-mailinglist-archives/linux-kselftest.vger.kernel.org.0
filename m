Return-Path: <linux-kselftest+bounces-35645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DBAE4F88
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE3C7AD906
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6BE2222CA;
	Mon, 23 Jun 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jX3d7/df"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFD7482;
	Mon, 23 Jun 2025 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713373; cv=none; b=FDzt0rkeVAByOotls3nXRe3V4rQrzw+MuEJjb+a8X+4MO5bpFCVHhpOqzG4P2yjniu6GkytR/y83fF4vCzRspPMB3ecEc0G1tFNvY6mxDexgnlwysnHGZYqV8HZM2sGsaElqw9CEU0kbRxeMiBRkKwWj3FyVs1953Rc9IxA1X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713373; c=relaxed/simple;
	bh=mReunKrDQiUV3XucmZjbudcrS3Iw4bTLeGQ493YHQFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YGwLqwObACFKJWwufAFDmR3Zm4C2KCb/tv5knGmbd+9oGd4CdV1CxaGvudTm2M/ga7+uE9FixOtX2HGBm70f5cOU3hRRBJX9jHWVZqvhC/JyfM5VPypd2q4Sj4TdzFYYXXRsCKbeRjnvPIirBHHrRn7jIcFrH8Hh1YiTsn5oQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jX3d7/df; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713368;
	bh=mReunKrDQiUV3XucmZjbudcrS3Iw4bTLeGQ493YHQFM=;
	h=From:Subject:Date:To:Cc:From;
	b=jX3d7/df8FemTAtygubH6RArueyel+Q7287+MgF+jUcmAQbQH9xUumJ1YE7gY+v4y
	 oGMTlCF2Dcwejz9Ie1CkbK5NZ7m0fvCTNGavV8kS85i1QIcGeAPKyD9InXjs2w2qfn
	 zcwIMo1lIxAegE1IkEsPGAb1uPBJkZb7w/muLOrU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] tools/nolibc: add support for SuperH
Date: Mon, 23 Jun 2025 23:15:51 +0200
Message-Id: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAfEWWgC/03MQQ6CMBCF4auQWVvTViHginsYFk472ElMazqIG
 sLdrbhx+b+8fAsIZSaBU7VAppmFUyxhdxW4cIlXUuxLg9W21rVtVUw3RqckqBaPdEBsaXQI5X/
 PNPJrs85D6cAypfze6Nl815/S6O5PmY3SqvPOo8GmQaz7J7GIuPAI+0gTDOu6fgBYPH0UpwAAA
 A==
X-Change-ID: 20250528-nolibc-sh-8b4e3bb8efcb
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713367; l=1510;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mReunKrDQiUV3XucmZjbudcrS3Iw4bTLeGQ493YHQFM=;
 b=sF7fULqfhzxtVrensZNZAGrvYD1xeyEhBy6vlt0lzWqZMq+u7ZSwXnhvuKZiqHIECux9QqKsQ
 rg47X/XNYx9C/yT4LH/N7WpsAVMH5sqFK583WXH8HOGfXUf/EG0djCh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for SuperH/"sh" to nolibc.
Only sh4 is tested for now.

This is only tested on QEMU so far.
Additional testing would be very welcome.
Test instructions:
$ cd tools/testings/selftests/nolibc/
$ make -f Makefile.nolibc ARCH=sh CROSS_COMPILE=sh4-linux- nolibc-test
$ file nolibc-test
nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), statically linked, not stripped
$ ./nolibc-test
Running test 'startup'
0 argc = 1                                                        [OK]
...
Total number of errors: 0
Exiting with status 0

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase onto latest nolibc-next
- Pick up Ack from Willy
- Provide some test instructions
- Link to v1: https://lore.kernel.org/r/20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net

---
Thomas Weißschuh (3):
      selftests/nolibc: fix EXTRACONFIG variables ordering
      selftests/nolibc: use file driver for QEMU serial
      tools/nolibc: add support for SuperH

 tools/include/nolibc/arch-sh.h                 | 162 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |  15 ++-
 tools/testing/selftests/nolibc/run-tests.sh    |   3 +-
 4 files changed, 177 insertions(+), 5 deletions(-)
---
base-commit: eb135311083100b6590a7545618cd9760d896a86
change-id: 20250528-nolibc-sh-8b4e3bb8efcb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


