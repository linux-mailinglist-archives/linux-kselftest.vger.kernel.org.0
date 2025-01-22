Return-Path: <linux-kselftest+bounces-24957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5AA198AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B97B16B6BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88671215784;
	Wed, 22 Jan 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fCrl6C6n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDB211490;
	Wed, 22 Jan 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571324; cv=none; b=uPUroe4ppjn2N77qCCidoliAggafQW4c8ovzH6yaiQadCW7BTkRj83ybG2d/QsTZxBRPKyKGA9QZQVJEfEXzxIAeuJsaFtNK/6MDTVcmhk6TJ0opY4TKD/3QdnsRYH/lyL5llcLrpiAtudtOcofMCqobjS+nfOGi78/N+iSgv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571324; c=relaxed/simple;
	bh=xloSejWoT9pGGBI8RQJH2gCS83yXZpEKIyoyEGDjNWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DngQF4ZsH3DRF8fKdxtpFOUmxz9Vhd/vVnBw6NNN2GOkiYeKi39wHpJvAWmANBfa275XcJBFZk8w68deb3Zgx6nd9HZOhi6zhqZGK08X34dnueXpjWjU3orQbW988yrWVql+1vNk34f26+JfDHViYaIs6gSfYpkfC/FGSiwTWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fCrl6C6n; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=xloSejWoT9pGGBI8RQJH2gCS83yXZpEKIyoyEGDjNWo=;
	h=From:Subject:Date:To:Cc:From;
	b=fCrl6C6nofkK+VtvfyVtnfdAzLzrvaMq+41pfKITd5/JVpPqFPgRSRt63vSETnHgi
	 RqG2QcJ/bKfdtZrmtSkIYtCb9/6JAOMJVWj360CF0FIcJ70HvYykJOP9XMXcJhoZCp
	 4sYylxzCLGbSF3liTVZ5DneGQNA7GwjuHCaN6k+M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] selftests/nolibc: test kernel configuration cleanups
Date: Wed, 22 Jan 2025 19:41:43 +0100
Message-Id: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOc7kWcC/x3MQQqAIBBA0avErBN0JMGuEi1KRxsIDYUIpLsnL
 d/i/waVClOFeWhQ6ObKOXWocQB3bCmSYN8NKHGSClGkfPLuhMspcBTeaEvKKHRWQ2+uQoGf/7e
 s7/sBRvcj3l8AAAA=
X-Change-ID: 20250122-nolibc-config-d639e1612c93
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=831;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xloSejWoT9pGGBI8RQJH2gCS83yXZpEKIyoyEGDjNWo=;
 b=gIJ7e5acBvw/l9OGa5vljcTsYWFsL2VSXDByyJV5iCW7674HoFWOgJ/JPYsZRzWtXLLMQ2l67
 J+oObfGLPthBBMXh20vqfVL8T5NqPiphqCnP1Nj8oQLazv8W/SzNSro
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A few cleanups and optimizations for the management of the kernel
configuration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      selftests/nolibc: drop custom EXTRACONFIG functionality
      selftests/nolibc: drop call to prepare target
      selftests/nolibc: drop call to mrproper target
      selftests/nolibc: execute defconfig before other targets
      selftests/nolibc: always keep test kernel configuration up to date

 tools/testing/selftests/nolibc/Makefile     | 17 +++++------------
 tools/testing/selftests/nolibc/run-tests.sh |  5 +----
 2 files changed, 6 insertions(+), 16 deletions(-)
---
base-commit: 60fe18237f72e3a186127658452dbb0992113cf7
change-id: 20250122-nolibc-config-d639e1612c93

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


