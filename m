Return-Path: <linux-kselftest+bounces-38118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B1B176F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B604E696E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E7253F38;
	Thu, 31 Jul 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UwiG5QJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DE20CCE3
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992806; cv=none; b=n+nvS9KTZVT9xow1LhouxqfOTTIgtnZY5xOiPE5/jpIAYwGclsSD4yy7grjuQu5KTadkIoivz/2NzZJyb0USD6QBlNx+DuZ5S4SpFgvdU8bKTAOJ8lz6HEu96ZZ/NRRgoV9Ob8mrQ2hVeO36ZIdL2HpZaK8hCLZqAQZfpwPetH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992806; c=relaxed/simple;
	bh=2KFFi6JqUNm2D6SWRC5E8e8+7absTviPVvmt0p3btHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udkc72IOF/7WCAPO97qreuIrlOm8ZGIMGVYuO48laCurz6mI1TAj28ZTqyqq85Hoc5N2FA0tw36tF4KzN2qmX1VfiAYls/F7p5bXf29bLtysH/vi2A7+Y0cQV1WPwqtW+qKLKzcJtsT8Y9tjppWsxjEB/4DHTFtb3Y/E3MyW+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UwiG5QJc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=q1gE9cNIkb4qFoCeh9nzecQ7R8AzeQiQ45z5VKi9zgY=; t=1753992805; x=1755202405; 
	b=UwiG5QJcbZJ0KAmyEDZCY6apPSD50uNXlZUe0K7KlqQc4FqnlPo/CWs2jiVm0pupAXqPbiqGqtb
	MylQj0mocYM024qSMFyqySZKmMbVBMmNGSBcXsJp35CEaTPWVMPR1OMK7KXG+f2Dsu7fWCpsM56aa
	9FZynDBJjFl1bbC+eOoqs+e+sEfNaNing1v0xbctBQ/rV7iuTfl+M1Ss24aIkM0o7Q3t2IHbhdHHH
	iOGtj6htomBSTbzsX0wX0pY7ZhghQDcSBtnQvT7fnirxyWjbvA/j4KLsDqB9mK7RTA0wnRdSBnkB9
	HVIXSooNLAnNZZ1aJ9ddSxQOUsuzYz30mbCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uhZeT-00000001lJH-3PI6;
	Thu, 31 Jul 2025 22:13:22 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 0/4] signal handling support for nolibc
Date: Thu, 31 Jul 2025 22:12:21 +0200
Message-ID: <20250731201225.323254-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Hi,

This patchset adds signal handling to nolibc. Initially, I would like to
use this for tests. But in the long run, the goal is to use nolibc for
the UML kernel itself. In both cases, signal handling will be needed.

With v3 everything is now included in nolibc instead of trying to use
the messy kernel headers.

Benjamin

Benjamin Berg (4):
  selftests/nolibc: fix EXPECT_NZ macro
  selftests/nolibc: remove outdated comment about construct order
  tools/nolibc: add more generic bitmask macros for FD_*
  tools/nolibc: add signal support

 tools/include/nolibc/Makefile                |   1 +
 tools/include/nolibc/arch-s390.h             |   4 +-
 tools/include/nolibc/asm-signal.h            | 237 +++++++++++++++++++
 tools/include/nolibc/signal.h                | 179 ++++++++++++++
 tools/include/nolibc/sys.h                   |   2 +-
 tools/include/nolibc/sys/wait.h              |   1 +
 tools/include/nolibc/time.h                  |   2 +-
 tools/include/nolibc/types.h                 |  81 ++++---
 tools/testing/selftests/nolibc/nolibc-test.c | 139 ++++++++++-
 9 files changed, 608 insertions(+), 38 deletions(-)
 create mode 100644 tools/include/nolibc/asm-signal.h

-- 
2.50.1


