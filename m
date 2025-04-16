Return-Path: <linux-kselftest+bounces-30978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA5A90B7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F837AF54C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA35224893;
	Wed, 16 Apr 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dl8ih4v0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FB224238;
	Wed, 16 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828848; cv=none; b=lt4540fpqiGCG2R/INza02WA5tRCZmhztrgAsJbQ/of5MdY8l2vTEviHjtLRrMMgJ8/ZGFRLO2KYwoEe4geBxo03rTFNtOYe+ovVt7pwGAsUjnsuNpAuIq7yITHqP1L+kdvVffPhTbrmH6I47Qcwk+WKznlEsyoGA9OgN7/8I60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828848; c=relaxed/simple;
	bh=r74PEqmclp8XQ64KO3BZyy9Pvmd2TvaX9zqkaaQrnr0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ftvu3mV2aZJ1lsTQuiCn7ZkQwIbopG+kO6IMPUZmJzgCgc0VJnLVWSCcWU/zJoqAjAqTcU64fJKW0ekENDeXSNu4N3lDmq5XB9DfCT3y0pn8vAjDOlSm5W/04zVCLmHlro6lzDshfVbLPmibeujAa/7uS8tdvbM94hsmcsVMssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dl8ih4v0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828842;
	bh=r74PEqmclp8XQ64KO3BZyy9Pvmd2TvaX9zqkaaQrnr0=;
	h=From:Subject:Date:To:Cc:From;
	b=dl8ih4v05EXYagBRLU3hL7RzPuFE4iiPR8iKhO9bW9Vb+7W02xIgbLITW0u6wn0s3
	 V4158DHDOoctonK9EyReBvntzjKI8ifsb8XbhZO12MOmWPumasSBZpcb5kQ8YHrc/P
	 u01QJCDgzlwo5JrSh3DBrDm6L4LLuCsPHfnrRizk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/6] tools/nolibc: fix some undefined behaviour and enable
 UBSAN
Date: Wed, 16 Apr 2025 20:40:15 +0200
Message-Id: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJD5/2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Mz3bz8nMykZN3SpOLEPF0DIwsTA0MzSwszUxMloJaCotS0zAqwcdG
 xtbUAkqYcN14AAAA=
X-Change-ID: 20250416-nolibc-ubsan-028401698654
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=1096;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=r74PEqmclp8XQ64KO3BZyy9Pvmd2TvaX9zqkaaQrnr0=;
 b=+RNKNlfx45F4oK8aKjqBBV9P7vD/FZXYqRMSfClRhC7KztqjtoDZZQmgm+QqJYgwrKadqBXkt
 Wg6dtyHEqoRCRtATrHRTmKq14ooNmk43kLfeq/SGr5hWT13QqdDI7uu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
avoid regressions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (6):
      tools/nolibc: add __nolibc_has_feature()
      tools/nolibc: disable function sanitizer for _start_c()
      tools/nolibc: properly align dirent buffer
      tools/nolibc: fix integer overflow in i{64,}toa_r() and
      selftests/nolibc: disable ubsan for smash_stack()
      selftests/nolibc: enable UBSAN if available

 tools/include/nolibc/compiler.h              |  6 ++++++
 tools/include/nolibc/crt.h                   |  5 +++++
 tools/include/nolibc/dirent.h                |  1 +
 tools/include/nolibc/stdlib.h                | 24 ++++++++----------------
 tools/testing/selftests/nolibc/Makefile      |  3 ++-
 tools/testing/selftests/nolibc/nolibc-test.c |  1 +
 6 files changed, 23 insertions(+), 17 deletions(-)
---
base-commit: 7c73c10b906778384843b9d3ac6c2224727bbf5c
change-id: 20250416-nolibc-ubsan-028401698654

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


