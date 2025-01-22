Return-Path: <linux-kselftest+bounces-24963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5EDA198B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227D13A3C94
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264621576C;
	Wed, 22 Jan 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MviJPe23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D8215F40;
	Wed, 22 Jan 2025 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571430; cv=none; b=Iu03/onQuqtWh5E1cdr9LZZvfQm4ihpSv19XmI5+7z4HMrvR0bQxPSuxpaklNBDS0flqsnVQXLDCYT8w+9L7zxCgK/R2/ttU4fasE16VCG7zZYeQWg1IGOiP43sLyG0TcnZP4E0221/JRG3HDYj34zslsBPpUYLc3kPAQM+2lNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571430; c=relaxed/simple;
	bh=dObc3RHK11QWaQcHlN8j4xogXBmD9s3/vCWqlX0dXRA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k5reYy6A6DgPyRLOq5dHiME/Gu1pw3um3E/oixi/OMBT9oClWZplGCw5AJ//EP37N7eAsHGQg0m4hzWYrQ0RymRqQ+GgqHNNoHR52QUtQd8dto99nQ0PFgQVvg0pfn+XLkeNsDL02xjLr6G4TV2h5irqAU6PNeOUBWVQmF8n72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MviJPe23; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571427;
	bh=dObc3RHK11QWaQcHlN8j4xogXBmD9s3/vCWqlX0dXRA=;
	h=From:Subject:Date:To:Cc:From;
	b=MviJPe23p/ltyQwNZVtwM2RahmHvzeIm91z/PBnDpq5QfrW49Vt/8zIYgkN1xfkJK
	 AM2M8ji2LG6JiTCMRZs7hmTUZmsPLpiwwuHrp1vQ5DM8c5v93YTvu7GtldMjqZsW9t
	 mGI+od5Wi6TGWQZxuOFXTG15EHtUOvzZI/GgllYg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] tools/nolibc: support for 32-bit s390
Date: Wed, 22 Jan 2025 19:43:44 +0100
Message-Id: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGA8kWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3bz8nMykZN1iY0sD3VRTc0MTQzMLo2QLCyWgjoKi1LTMCrBp0bG
 1tQA5axGrXQAAAA==
X-Change-ID: 20250122-nolibc-s390-e57141682c88
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571427; l=972;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dObc3RHK11QWaQcHlN8j4xogXBmD9s3/vCWqlX0dXRA=;
 b=yABwnlTUicxIg9CJ4eRhROEf8pSFLtGQwgbz9CSmo45DWfAsmbptoK/Gw0h6dKQACzoIBThy2
 4iVo/Yxd5kNDd+h8ZoiNsskd1l9QAwQIKyTk8hbi1Db8P/By2C97R3U
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Support for 32-bit s390 is very easy to implement and useful for
testing. For example I used to test some generic compat_ptr() logic,
which is only testable on 32-bit s390.

The series depends on my other series
"selftests/nolibc: test kernel configuration cleanups".
(It's not a hard dependency, only a minor diff conflict)

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: rename s390 to s390x
      tools/nolibc: add support for 32-bit s390

 tools/include/nolibc/arch-s390.h            |  5 +++++
 tools/include/nolibc/arch.h                 |  2 +-
 tools/testing/selftests/nolibc/Makefile     | 10 ++++++++--
 tools/testing/selftests/nolibc/run-tests.sh |  8 +++++++-
 4 files changed, 21 insertions(+), 4 deletions(-)
---
base-commit: 0597614d84c8593ba906418bf3c0c0de1e02e82a
change-id: 20250122-nolibc-s390-e57141682c88

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


