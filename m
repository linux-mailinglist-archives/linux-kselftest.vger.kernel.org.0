Return-Path: <linux-kselftest+bounces-36833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C23AFEE48
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A6C162A6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20A2E974E;
	Wed,  9 Jul 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sVlW1YX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D12E973D
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076688; cv=none; b=CotWRcxmpfMDE2XaK/vbPKxSXKykExoobxe7DcOU0261LJq+RSOpR6VTvYOB6AlRM+AAobcKgQLU4RsfBKOCUdm6AGlqZblWzXBmzWs+rfdtK9RNFYRaiPMt9hKAwMgNALcd9pMhofRidIvpJeouRgKLuycqDV7P189Bf9kOTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076688; c=relaxed/simple;
	bh=tupon9QhKpGnYWAmzqIMKizbVVXTdFjY9qDS3C0k36k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/tGt9wQXuhrC7EsvGBn/HFND0LfSo2a53dLpu+Zpxncva7XEb6JVov1MekHM6DpM2SM1OgEwhzVEHC6AHkPl+45QcBJj9U731OtJhc11XiWKWpoTPmSuAPUzc4pAGBNV8Y0ke5GzMa9uienwvMcEZLaj8q3mAMJN4Cf65FXAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sVlW1YX4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=D46ILGRaGPizvSaZf0V5hgp95Fy0xyq1zaCqKTXnTQI=; t=1752076686; x=1753286286; 
	b=sVlW1YX4QZeLBzRgHqAeeuB9NZGAb8NBAosqxCKsuuoJ9n9Qw0mAqUXh0AUGIQxUcgyZo1VX+P7
	pfy1qIuWBEc9ZPMHPPQzvKuuL2KQhLklar+fEB0Nq1afkaov7a7guXwyP4od5bMydpAtFZj3OZE0W
	GPYExPlf6NnhC3bzQHUKd+Tkec+HDQk7MNDwPTtoB7EaBq/ckXXuYdhhUnXFmXnrjW7S5M7OsK3rj
	9euM2GA8koHhR7M5iOkvn4ZThCkhIVoYE4z/LM0nJR0NxWrg6nQL3YRlGlhS+pDPDkyuQgUnie9aS
	Go91YpWsbSxZUhMmbUZ80K6GNoFBoHMLDwZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZXBK-0000000DWBm-3iZ7;
	Wed, 09 Jul 2025 17:58:03 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/3] signal handling support for nolibc
Date: Wed,  9 Jul 2025 17:55:09 +0200
Message-ID: <20250709155512.971080-1-benjamin@sipsolutions.net>
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

Benjamin

Benjamin Berg (3):
  tools/nolibc: show failed run if test process crashes
  tools/nolibc: add more generic BITSET_* macros for FD_*
  tools/nolibc: add signal support

 tools/include/nolibc/arch-arm.h               |   7 ++
 tools/include/nolibc/arch-arm64.h             |   3 +
 tools/include/nolibc/arch-loongarch.h         |   3 +
 tools/include/nolibc/arch-m68k.h              |  10 ++
 tools/include/nolibc/arch-mips.h              |   3 +
 tools/include/nolibc/arch-powerpc.h           |   8 ++
 tools/include/nolibc/arch-riscv.h             |   3 +
 tools/include/nolibc/arch-s390.h              |   8 +-
 tools/include/nolibc/arch-sh.h                |   5 +
 tools/include/nolibc/arch-sparc.h             |  47 ++++++++
 tools/include/nolibc/arch-x86.h               |  13 +++
 tools/include/nolibc/signal.h                 | 103 ++++++++++++++++++
 tools/include/nolibc/sys.h                    |   2 +-
 tools/include/nolibc/time.h                   |   3 +-
 tools/include/nolibc/types.h                  |  67 ++++++------
 .../testing/selftests/nolibc/Makefile.nolibc  |   3 +-
 tools/testing/selftests/nolibc/nolibc-test.c  |  67 ++++++++++++
 17 files changed, 319 insertions(+), 36 deletions(-)

-- 
2.50.0


