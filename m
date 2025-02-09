Return-Path: <linux-kselftest+bounces-26138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C29A2E073
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 21:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A4E164EAB
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036B1E376E;
	Sun,  9 Feb 2025 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fQSn8YZ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F91E2848;
	Sun,  9 Feb 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739132849; cv=none; b=qLkR1zr/vzBq657++Oj70N29UtmJTUP3KCnXMwPtKIhJ1zSRzrguA3B+LSgm8y2Ook71U0hd7jH5dNA7n8obwuPknqI7BjIjpuFTXqQ6Q629q6dUo9wdtZyIArKUZiSd0/3MMbOhJFBz2ZHJ/A8Wj0AIo8D8RA/LeOH7F+4EEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739132849; c=relaxed/simple;
	bh=nU4hERBPI9ZPO1T6zGv6fWLAX0+bfNykx106LUpFV/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vDsJUhwcWS7+NWOXTpNQc17545bZrXm0B9Qo/9J8rP5XKZ/s3x4gCFuc/qdujt/jy3UQRHp94sJmkF1tIePoxhb+PvBo53jZmi6TwMnw1mFdqcY3TCiPjX9B4hn9CULRTVi38Ny592iV9XnCm7E2l6JzY/yfZ4N56fUFzV6CgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fQSn8YZ9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739132837;
	bh=nU4hERBPI9ZPO1T6zGv6fWLAX0+bfNykx106LUpFV/s=;
	h=From:Subject:Date:To:Cc:From;
	b=fQSn8YZ9XGLVbscnkDj1J1dfRuusrq/mjt2gi8JrD92EMLFtKfXK8mpmzD/wTBCgH
	 c4AvBhRYlRlie4OFnyd8SvDAo1CRSR1/UQWAi28ffyu1bGZvnbvb0q4bzJplUtoSMx
	 FQFTZ9la+xklzn5OBq0lw3ThWPvklxCf/Oxo2dF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] tools/nolibc: add support for [v]sscanf()
Date: Sun, 09 Feb 2025 21:27:11 +0100
Message-Id: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ8PqWcC/1XMQQ6CMBCF4auQWVvTQgPBlfcwLOgwtZOYYjpYN
 YS7W3Hl8n/J+1YQSkwCp2qFRJmF51iiPlSAYYxXUjyVhlrXVltjVZxv7FAJjtErbybX9o2eNLZ
 QLvdEnl87dxlKB5ZlTu9dz+a7/qCuMf9QNkor3xmHaEfnejo/iUUEwyMcIy0wbNv2AYh+zTqtA
 AAA
X-Change-ID: 20240414-nolibc-scanf-f1db6930d0c6
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739132836; l=960;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nU4hERBPI9ZPO1T6zGv6fWLAX0+bfNykx106LUpFV/s=;
 b=HpXNR3NSsUQ1//MhU6mqUx996zYJTM7H7l6ybcLb37/JNoB7blgmO0vi63Q6XSG6f9nbZXPMs
 wZNbSFNT4yGDzqvum/XyJ3PXXClQqwz9fIBnu/JGNXicLZWZvlRI9S/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The implementation is limited and only supports numeric arguments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Return __LINE__ from different testcases to directly point to the
  failed testcase
- Add some comments
- Expand commit message
- Link to v1: https://lore.kernel.org/r/20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net

---
Thomas Weißschuh (2):
      tools/nolibc: add support for [v]sscanf()
      Revert "selftests: kselftest: Fix build failure with NOLIBC"

 tools/include/nolibc/stdio.h                 | 98 ++++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h          |  5 --
 tools/testing/selftests/nolibc/nolibc-test.c | 68 +++++++++++++++++++
 3 files changed, 166 insertions(+), 5 deletions(-)
---
base-commit: 665fa8dea90d9fbc0e7137c7e1315d6f7e15757e
change-id: 20240414-nolibc-scanf-f1db6930d0c6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


