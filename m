Return-Path: <linux-kselftest+bounces-36946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F6AFFF78
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CBF6471DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC032D978A;
	Thu, 10 Jul 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E1pH6sDK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EB2D3EE5
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144207; cv=none; b=b7QOHoy44nIgNDNnDKfE1IkmsXxScm/N6xb9kuIxevHsffjC6VdtZgkUBZY8c7H4mYgngZCg2IBXqJ+GqN/mQj1X2TaNNIPZJjnrKWHnZ3PdDSk5t/V0cdBiLYUn6K0F5UtCriCzR91BTb7dMtbOoY5HWTXCbP+vtcSpJXWF6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144207; c=relaxed/simple;
	bh=TQOt0O89XummCoj5K0M0ms4nxBJmb4bojU9P1ax9vZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meUBkhEV1QoLsu0vdFkTs95PifE30I2ebd73rl9z8KzoVahZOJrgq1G7HAQ6s+cFuex0gSqxcmQpf84AkbZymDrVDhe8DuVucCFRBl5Gy882+UEwrOOvWK+FpHzOFe/byjOwg7tZZaM4vDo658DzXQzgCXOh2fVaRtzrMUUnQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E1pH6sDK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+zCbVKGd9vGxG6XD/xgwqzntCTd+THgDvQtaCJdEto8=; t=1752144206; x=1753353806; 
	b=E1pH6sDKN7/up6SGrwQq5zLXPnMVQiQAnjkhTrUQnA+m0tCgbf41RWu3PvACK2wevx1yEwjNjxB
	zBEdUFR74QwIQMi638zm/E/zH8GqU2nYRb0binoNnWjBEQPLjleunZY1eqmScJOUX34kzOFvmXYn5
	xeCQ8Zi6LU6yRQn9le/pZ53fNV4R5zCoshOD6uLgK7+KCrJTLlUbQ3nb1QMWoyC5ES3fUqSmEgvTA
	3I44Bs60Jsy/u4xeM533wN2ZPW+nn3inr5v22caFoS7M6A3BqsuYr0QVoojxtZ6zxUg+y3oTcJVwk
	Y4kA2tCzd5ze9F8zRcfBZ7+78j73Y26buWSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZojz-0000000Eg4e-1gRP;
	Thu, 10 Jul 2025 12:43:02 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 0/4] signal handling support for nolibc
Date: Thu, 10 Jul 2025 12:39:46 +0200
Message-ID: <20250710103950.1272379-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Hi,

This patchset adds signal handling to nolibc. Initially, I would like to
use this for tests. But in the long run, the goal is to use nolibc for
the UML kernel itself. In both cases, signal handling will be needed.

v2 contains some bugfixes and has a better test coverage. Also addressed
are various review comments.

Benjamin

Benjamin Berg (4):
  selftests/nolibc: fix EXPECT_NZ macro
  selftests/nolibc: validate order of constructor calls
  tools/nolibc: add more generic bitmask macros for FD_*
  tools/nolibc: add signal support

 tools/include/nolibc/arch-arm.h               |   7 +
 tools/include/nolibc/arch-arm64.h             |   3 +
 tools/include/nolibc/arch-loongarch.h         |   3 +
 tools/include/nolibc/arch-m68k.h              |  10 ++
 tools/include/nolibc/arch-mips.h              |   3 +
 tools/include/nolibc/arch-powerpc.h           |   8 +
 tools/include/nolibc/arch-riscv.h             |   3 +
 tools/include/nolibc/arch-s390.h              |   8 +-
 tools/include/nolibc/arch-sh.h                |   5 +
 tools/include/nolibc/arch-sparc.h             |  47 ++++++
 tools/include/nolibc/arch-x86.h               |  13 ++
 tools/include/nolibc/signal.h                 | 103 ++++++++++++
 tools/include/nolibc/sys.h                    |   2 +-
 tools/include/nolibc/time.h                   |   3 +-
 tools/include/nolibc/types.h                  |  81 ++++++----
 .../selftests/nolibc/nolibc-test-linkage.c    |  17 +-
 tools/testing/selftests/nolibc/nolibc-test.c  | 150 +++++++++++++++++-
 17 files changed, 422 insertions(+), 44 deletions(-)

-- 
2.50.0


