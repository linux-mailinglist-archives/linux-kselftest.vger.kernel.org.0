Return-Path: <linux-kselftest+bounces-37184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BBCB02A33
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7263A1C23949
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0E27380F;
	Sat, 12 Jul 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="W5Ren0Y6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4A1FBE8A;
	Sat, 12 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310870; cv=none; b=RFyTV5lIg+kxGAm18fbLwcLCYMvgx0hScbmlp3bF/oSX9Xmo2fhEemR5nsviI+rlkwywnYTYMB9O8skMYIW5MPKy1v2MtszUTYrIcKbhatp4yQMsnQb7z4d2f6NphqZhwNAFgXC9wKzq7PDKXPDohp2QaHe+wfvfv4803c5pENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310870; c=relaxed/simple;
	bh=bZbsZaW1RtEYpjmxAB66vQDOUyyHL1dJMCFt9MrEjhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QO2pD5bnZ6VxBoJI1H2CihXIYlu9uC3tDFQXNVcrOBVplfUD7uJS4N3Jhdq5yXdMqcESBGwhWNdcjWlzXTssBRd+wxS/h8a6dhXZiT9bgM8Wgl+ZNfLlcdHfAxgVIjQHM371TKusHyr2mrdzd0FcxOQhEba7jaBk5/DBZoVOAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=W5Ren0Y6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752310860;
	bh=bZbsZaW1RtEYpjmxAB66vQDOUyyHL1dJMCFt9MrEjhk=;
	h=From:Subject:Date:To:Cc:From;
	b=W5Ren0Y6UB1GhfmyVunh+wEWcgT/Io9qWXZOI07xMP9LLy8+fvk4dUr4jAEwF6pUV
	 VOSZcCZvYMaX/SC3HUc8ddud5gYqgxUt/4bFNuwjnlGnKcn9Aez+/HpjUnJEqkoo7V
	 yhNHRvu6zWxHcO7RradLsEsoT7yjrOVJml+fYxSY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] tools/nolibc: add x32 support
Date: Sat, 12 Jul 2025 11:00:54 +0200
Message-Id: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEYkcmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Mj3bz8nMykZN0KYyNdc0uzRMuURJNky9QUJaCGgqLUtMwKsGHRsbW
 1AM0gv4lcAAAA
X-Change-ID: 20250712-nolibc-x32-796a9da4c9ed
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752310859; l=616;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bZbsZaW1RtEYpjmxAB66vQDOUyyHL1dJMCFt9MrEjhk=;
 b=IXy2zvBRwoDfvGECwa4LiJ9zCfogvE1bze9V3TuBUoWdvTNKNY8D/yCZNKUjbDvX3kAZoorFz
 1Htgxh7meI5AdNzfYffJT5ugdBMwVS5v0s7ceMYHkeN+EJP7bzIo7F7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: define time_t in terms of __kernel_old_time_t
      selftests/nolibc: add x32 test configuration

 tools/include/nolibc/std.h                     |  4 +++-
 tools/testing/selftests/nolibc/Makefile.nolibc | 12 ++++++++++++
 tools/testing/selftests/nolibc/run-tests.sh    |  7 ++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)
---
base-commit: 750aef513c610a37a13732ec64902428b839715e
change-id: 20250712-nolibc-x32-796a9da4c9ed

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


