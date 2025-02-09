Return-Path: <linux-kselftest+bounces-26130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4200A2DE08
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 14:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822781885FD6
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C051DE2A6;
	Sun,  9 Feb 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GjTHYRVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9B1D7992;
	Sun,  9 Feb 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739107556; cv=none; b=ukpszlcOiURqWCRmFCVHKN9WD7jUi4QGa70DymfSRNKKB4ll82BaCVwsVwY3vtKWz0hsyasdT599oYy7M/zLYl52Os8DJu2no4PMkHRJvoeFv13OKqYw+gOjRK4GNDO/vHJgMi3TZy8V45g4kLpwo67sz5cE8FJqkMHuY6azJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739107556; c=relaxed/simple;
	bh=ASMWx4BDnBrUD8uQnlnxDAh7Hjm/i0pyq5OD3VMr03g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bqMTPuKCP4RUawUyZuhPi0JHD2R+wCZG9HnJxnY78/ORcSg0Ve1W9Y2zoFxNphLh80FqRjRadIWWsSHY4+D/Cwok6Sp56GvlBw1H1Uz6e0t64pS24VPIjtbV2e5NtTFYDl6rlzjBgRaJEKZE2f6nIk6UXh3Zi2qGXvNilIrBVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GjTHYRVy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739107550;
	bh=ASMWx4BDnBrUD8uQnlnxDAh7Hjm/i0pyq5OD3VMr03g=;
	h=From:Subject:Date:To:Cc:From;
	b=GjTHYRVyanDub85BcBHPR+H2v4SI4+vQzdkrHSofBh2b4XlfK/FyVUcumT4LXn+5I
	 TU6yMvZg3x8ujGf3C7GOSRHpJ5+E/yp3Off4h1AGG2U6frsgjiurYvIxdQyZ3lRV8y
	 iPPrahNRNDuKq86g9UQ8xULvGpNitGxs+vDD22rM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] tools/nolibc: add support for directory access
Date: Sun, 09 Feb 2025 14:25:44 +0100
Message-Id: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANisqGcC/23MQQ7CIBCF4as0sxYDGBpx5T1MF0BHmcSAYSpqG
 u4udu3yf8n7VmAshAynYYWClZhy6qF3A4To0g0Fzb1BS22kOkiR8p18EDMVYY8yaNR+HJWDfng
 UvNJ7wy5T70i85PLZ7Kp+61+mKiEFOmuN9KZ79vxCYuYQn3GfcIGptfYF32VZRqkAAAA=
X-Change-ID: 20250130-nolibc-dir-980c2e2b661a
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739107550; l=1064;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ASMWx4BDnBrUD8uQnlnxDAh7Hjm/i0pyq5OD3VMr03g=;
 b=PHLwprStaRrsId0odu6C0O4Dd9FB3005ivWTWxzNRQ5aGnPMFkvaDXK2tCIsmzH8AId/TrD8l
 m2na9HZe+sjBekrd418Cwgmscd0CnyJ8lia46QL2m7nyYURTKbVEzwQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support opendir(), readdir_r(), closedir() and friends.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Move definitions to dirent.h
- Reserve space for the trailing NULL byte of d_name
- Implement readdir_r() instead of readdir()
- Expand commit message
- Link to v1: https://lore.kernel.org/r/20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net

---
Thomas Weißschuh (2):
      tools/nolibc: add support for sys_llseek()
      tools/nolibc: add support for directory access

 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/dirent.h                | 98 ++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/sys.h                   | 29 +++++++-
 tools/testing/selftests/nolibc/nolibc-test.c | 39 +++++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
---
base-commit: c1f4a7a84037249d086a4114c0c4332a260e9091
change-id: 20250130-nolibc-dir-980c2e2b661a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


