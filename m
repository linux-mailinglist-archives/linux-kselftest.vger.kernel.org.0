Return-Path: <linux-kselftest+bounces-8863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30438B2605
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301831C214DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5129914C5BA;
	Thu, 25 Apr 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h/osk+LD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DA14A096;
	Thu, 25 Apr 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061399; cv=none; b=NsE8+WpR54yjumjZ4q3I3qFI87nzUDvkTP1gVLX3ASOjltl9izXcrlP8j54IAiDKIjbxzE4MUyb9sUlBwqmBoPBosoFztduMWlq/nQTLLPiK1tOeh1b5ytK3RVWACKHXLQd8eyxy46ydBalVsdpL3hQPNFBmwxkdeL0PEjn10GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061399; c=relaxed/simple;
	bh=P3A5IVFBl7fl7JQmick2+XqDO+Oqoe+qjWNFH3QS/Ns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fxnpw3AjryUUlIZwgobQ/ztFuOvrYtvjnwf94KFthCJtR8RSBj+l39KR62s0Ay2vFBD2xmmnR0bLiaLBpUCIfV1cdiK4iXgRaD45ZXiCZDXpZJTZDaiaG0Xm8batE6TUx0NnvKMBZ5BAcSwXmAEZ357k2eLAplx1D253dFTiozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h/osk+LD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714061393;
	bh=P3A5IVFBl7fl7JQmick2+XqDO+Oqoe+qjWNFH3QS/Ns=;
	h=From:Subject:Date:To:Cc:From;
	b=h/osk+LDfXw+7zw5ap7zY38OGV0fBSRmnOmJVwCza74LVAFbO/XdIUBX/XbZwAV4z
	 q74nNyYTHTdwjQGahgxUKhuoqydzZhNjGj8yq0Lqv2+92rLoK3d/km6LdNkmFFgZuP
	 NlA6+Hcs2CHbCHU+fX7F8zFrEvMcvu1IATL6JG04=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] tools/nolibc: implement strtol() and friends
Date: Thu, 25 Apr 2024 18:09:25 +0200
Message-Id: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADWAKmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0NT3bz8nMykZN3ikqKS/BzdxDRz80TDNKNkczMzJaCegqLUtMwKsHn
 RsbW1ANI4y0hfAAAA
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714061393; l=790;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P3A5IVFBl7fl7JQmick2+XqDO+Oqoe+qjWNFH3QS/Ns=;
 b=DjdCWwO/Rih+/lht+L6LlMwYk72xCMZMA1QRJUJrNQXaLQlwWSGHWA7SWtOx9L+sTDpVLqGdA
 X1HGTJNh7veCFTw6zDkr0oHtYT0l1KqkZdlQz9G5IRdsNdjNjWEI/cL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

I wanted to implement sscanf() for ksft_min_kernel_version() and this is
a prerequisite for it.

It's also useful on its own so it gets its own submission.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: add limits for {u,}intmax_t, ulong and {u,}llong
      tools/nolibc: implement strtol() and friends

 tools/include/nolibc/stdint.h                |  19 +++++
 tools/include/nolibc/stdlib.h                | 109 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  59 +++++++++++++++
 3 files changed, 187 insertions(+)
---
base-commit: f1652790cd374bcf98efc913ec69ed18d20e7747
change-id: 20240415-nolibc-strtol-af77a1f2c766

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


