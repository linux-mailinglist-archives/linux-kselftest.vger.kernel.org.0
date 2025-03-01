Return-Path: <linux-kselftest+bounces-27961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBFA4AA9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5AB3B9B2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832F1DE4E0;
	Sat,  1 Mar 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ViO9aZVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE01A5B97;
	Sat,  1 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828259; cv=none; b=eaZubA81M2XWvqgWAF6vuROdHEtrwrylVWQSi67y+trB3alP1ed14mqZhMa6DTtedjMXqSgW3QcgGNB/4IjBxhD6/zeoyEMzaA6J45lRVvPCW6ME/g589VuN05fOpsOYVT4MfiaiDnRcBRCpGsVEV+NwSOAY+c2947wM53+Uv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828259; c=relaxed/simple;
	bh=gd26XQ8ONI1ozrwUhB1nJA3aNf9fIixlqpS31qTvRY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AD1Kluvup7KTaX2vfgka6dg0UHe8OyK8mNuLeKPivSVFSyWZUbQmpElr5XU8QVEevX05VKGESDFWA8JdIx5F4aqSDH4IkDsQZTAVYe1JEh8VaZfB2cvGv0/PTkJG1e0lYKtE4h+7+NfYH8TsMJJ5WW6MhjnVt/E3N+ZA0/YnG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ViO9aZVZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740828247;
	bh=gd26XQ8ONI1ozrwUhB1nJA3aNf9fIixlqpS31qTvRY4=;
	h=From:Subject:Date:To:Cc:From;
	b=ViO9aZVZN/HBAD9u1u3kyjs8g8my/0+z/lGPFKrQoGNAYiIbFc63g4Ia6FZSFhX7E
	 wCkSBWx4dwFcGfvTA4ey9MI9RYJjToIv9uz4ZT3I+NB/L0vqJHtKWaa1FkiP3pCSAJ
	 7PuBA2lK2bILFPzUAKO+pT6ua03twCu1ynYYcxF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] selftests/nolibc: add armthumb configuration
Date: Sat, 01 Mar 2025 12:23:58 +0100
Message-Id: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE7uwmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3bz8nMykZN3EotySjNLcJF1jcyNLM2NDEwMjM3MloK6CotS0zAq
 widGxtbUApxq+EmEAAAA=
X-Change-ID: 20250228-nolibc-armthumb-372963140267
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740828247; l=628;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gd26XQ8ONI1ozrwUhB1nJA3aNf9fIixlqpS31qTvRY4=;
 b=SPI0X4PDT3YzeTs1/FN/NnexmNmTXks71zRe19VmgnNvRkXhl27kg3cDBdVWyMzELkftyOAnA
 jTL4k4dryCLArmOoNW1t3hujk49CSEfo4ZqtKwg2D6yEi7ImflQtQRI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

While nolibc does support ARM Thumb instructions,
that support was not tested specifically.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: explicitly enable ARM mode
      selftests/nolibc: add armthumb configuration

 tools/testing/selftests/nolibc/Makefile     | 7 +++++++
 tools/testing/selftests/nolibc/run-tests.sh | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 3bd53b2fa57d9472d3af63b3f4d26023ba07b579
change-id: 20250228-nolibc-armthumb-372963140267

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


