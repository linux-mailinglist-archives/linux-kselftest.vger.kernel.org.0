Return-Path: <linux-kselftest+bounces-44306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC630C1C6B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6403D9623D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344E33F36A;
	Wed, 29 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UMpmibOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40876329C52;
	Wed, 29 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753891; cv=none; b=oBUmwA97mCBBCkXUArJ89LdsEhzZRvlYcqYJaR1364FSbqWJSxjCeX9/dIKS9VCjx6fJGZtFulN/W5rriP/wVV1bz+vjWDogZPmIDWMjQr4FW8JebdbzyEvEMHJPF5qX+EyBSNDAgggR+dpaWl0q6YzL4F/yAVlDg7At4jaNrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753891; c=relaxed/simple;
	bh=r6PgePP2Rqu6vrHoXQ9nozFvQmI3l341k8DeqfnpTLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bpOAK4Z0RYK9gqyAOzcbzE79Q+D4QKOyzwMkA92p8bn+Un45Eq3VHGj9iMJkVBQsp5+Oaot62WyeV6LOpA/Jco3qjlEFtzEVIqvn7a0a5TaZ6Y93lRVsZdn2fe+TGHwJsfR5zS6m9Yk6DcYEKHeZuxuh10jaCyLcTWBI1OktjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UMpmibOZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753882;
	bh=r6PgePP2Rqu6vrHoXQ9nozFvQmI3l341k8DeqfnpTLg=;
	h=From:Subject:Date:To:Cc:From;
	b=UMpmibOZEkFmDdLZnqqGIlK8UvouoPyVRsNC0nKZx2Vjz85Xdth/J6n2cCUDBAege
	 uFu3xM6yJL8KiwViFScqqJIIeXDj/BDlX9kEmcdy8imw+FlNeTNStfQ0aEnRvPpec1
	 fBOstu7aI0cxDTjK4H+jnhIjrP/h2PHxXZSLaf+4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/12] tools/nolibc: always use 64-bit ino_t, off_t and
 time-related types
Date: Wed, 29 Oct 2025 17:02:50 +0100
Message-Id: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKo6AmkC/x3MwQpAQBCA4VfRnE3NbEl5FTkwBlNa2y4ieXeb4
 3f4/weSRtMETfFA1NOSbT6DywJk6f2saGM2OHIVEzH6bbVB8OiD4X4HTchCtRuZJpEacheiTnb
 9z7Z73w+fuXscYwAAAA==
X-Change-ID: 20251001-nolibc-uapi-types-1c072d10fcc7
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1657;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=r6PgePP2Rqu6vrHoXQ9nozFvQmI3l341k8DeqfnpTLg=;
 b=MzZJYbAGKK/2BOgxXSfBehEFbHX5xuQAj7qzsdii8rSzxUwPK6Sv+bLkk2XdNJVEVyqcyaRIE
 4wfIFRj0KI+AE/FP/1CvNt1mI+KbNPKaPDhAjaCMYYA+T6bxxidb1pl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc currently uses 32-bit types for various APIs. These are
problematic as their reduced value range can lead to truncated values.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (12):
      tools/nolibc: use 64-bit ino_t
      tools/nolibc: handle 64-bit off_t for llseek
      tools/nolibc: prefer the llseek syscall
      tools/nolibc: use 64-bit off_t
      tools/nolibc: remove now superfluous overflow check in llseek
      tools/nolibc: remove more __nolibc_enosys() fallbacks
      tools/nolibc: prefer explicit 64-bit time-related system calls
      tools/nolibc: gettimeofday(): avoid libgcc 64-bit divisions
      tools/nolibc: use a custom struct timespec
      tools/nolibc: always use 64-bit time types
      selftests/nolibc: test compatibility of timespec and __kernel_timespec
      tools/nolibc: remove time conversions

 tools/include/nolibc/arch-s390.h             |  3 +
 tools/include/nolibc/poll.h                  | 12 ++--
 tools/include/nolibc/std.h                   |  6 +-
 tools/include/nolibc/sys.h                   | 21 +++---
 tools/include/nolibc/sys/time.h              |  2 +-
 tools/include/nolibc/sys/timerfd.h           | 20 +-----
 tools/include/nolibc/time.h                  | 96 ++++++----------------------
 tools/include/nolibc/types.h                 |  9 ++-
 tools/testing/selftests/nolibc/nolibc-test.c | 18 ++++++
 9 files changed, 68 insertions(+), 119 deletions(-)
---
base-commit: 90ee85c0e1e4b5804ceebbd731653e10ef3849a6
change-id: 20251001-nolibc-uapi-types-1c072d10fcc7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


