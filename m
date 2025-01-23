Return-Path: <linux-kselftest+bounces-25037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C4A1AAEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123CF3A824B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D21C3BFC;
	Thu, 23 Jan 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rem8wnsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486C18872D;
	Thu, 23 Jan 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663092; cv=none; b=fNLu/gJw1eQArllunMql1vjD/c4T/W2rCmnPlZpeH6fQnzlXsEmiGMB2WfdgEqmv+sNoQrvkUbs72vcjS/Nrz/truK2tCG4gb6Vx6WUxYEVZG1v8+OrU942fMtninsw8pBHdwnO+zUDHy9diZeWHKNTET0hR6kL56ytw8zeGrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663092; c=relaxed/simple;
	bh=UawFkzVQJvc7bHdsTm9eeqL6CWZ0VX5keARnHFPuER4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ntbpQb8i0G7gS9D5h2WS+89wpVw6VBXbo8zIZ08WhzngozB7WZWWHETOE0u30U8w5xe+EfJuPnCIkOtDXPOV8yA2HvHBO9aM3fOqZ/fVDq93So9EfaJogkr4SKfx8/sG619i6SuvWzrX9gLZilv1WnbFUTRkISDvLJ3/M+Xtlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rem8wnsJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737663088;
	bh=UawFkzVQJvc7bHdsTm9eeqL6CWZ0VX5keARnHFPuER4=;
	h=From:Subject:Date:To:Cc:From;
	b=rem8wnsJCTTF6Z6yi/fgT5Lwok8TJexTcHQBBBsMLQ4Rj0PaCVlsrV4U44aClm2d4
	 DMc0OejoenSgYlABmo8XCd6tWD5sdeI/OwMplyDQnztcQBM5tJVRI4PPQ4HvuOSX1H
	 NGI3l5HCpDDNGeKrEOYnruHCKs6rGlqzb4nDPjlE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: compatibility with -Wmissing-prototypes
Date: Thu, 23 Jan 2025 21:10:41 +0100
Message-Id: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEGikmcC/x3MQQqAIBBA0avErBMmK5SuEi3SphoIFY0owrsnL
 d/i/xcSRaYEQ/VCpIsTe1fQ1BXYfXYbCV6KQaLssZGtcP5gY0WI/vTnE0hgp5Qx2FuNGkoWIq1
 8/8txyvkDcxvobWIAAAA=
X-Change-ID: 20250123-nolibc-prototype-0477bb05c808
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737663088; l=964;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UawFkzVQJvc7bHdsTm9eeqL6CWZ0VX5keARnHFPuER4=;
 b=FNkLfO1VVgX95FWRnpiS4skVOmOfMCvy/Yfesezl4aSal6q45nejguPUlsbZWIgnmFZxDtqnL
 ahfL1eXmidKA9AnM2Dy/mMUA04vi42KgaTLI19+vzGElkXXGDSvqRCL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make nolibc compatible with -Wmissing-prototypes

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      tools/nolibc: add prototypes for non-static functions
      selftests/nolibc: ignore -Wmissing-prototypes
      selftests/nolibc: enable -Wmissing-prototypes

 tools/include/nolibc/arch-mips.h             | 1 +
 tools/include/nolibc/crt.h                   | 2 ++
 tools/include/nolibc/signal.h                | 1 +
 tools/include/nolibc/stackprotector.h        | 2 ++
 tools/include/nolibc/stdlib.h                | 1 +
 tools/include/nolibc/string.h                | 4 ++++
 tools/testing/selftests/nolibc/Makefile      | 2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 8 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: d0d106a2bd21499901299160744e5fe9f4c83ddb
change-id: 20250123-nolibc-prototype-0477bb05c808

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


