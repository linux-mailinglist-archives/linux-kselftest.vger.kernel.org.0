Return-Path: <linux-kselftest+bounces-7287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB81899E26
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C531C20A1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2216D303;
	Fri,  5 Apr 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AHrq8kSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7111649A7;
	Fri,  5 Apr 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323090; cv=none; b=fiQyd45QtqNyzx9tkA/JNvqL5tDcqOrIP86Dc0jhKpQFUErpGZANykRMeb4+V8ndvzJWJth7CQg3x9yTwh/3cuySRXHMkfOsYeOwbTS5/lZMvEKOpZHp1gju8Xaa+ci7HzVDrmX90baiSIV+2iPb0LMQfMiIz215alCfglfFMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323090; c=relaxed/simple;
	bh=4UbLO7lqaogdR2vuWoUgGqxgSzmMr2ERqnh0qUwJN1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/88B6aqlP+quw6XavBxNQC0AaXHR6GMNgrvrKenhARGcp7xn0+okTj/m4yjZKZ6JbsMDTfpBOHUvcTal38Eqh2zN9rBxddN1a8k5MNd1Jxx4tn+jvMKBh6pot5rhKRepP+6mFWV5VaOKWOvHs9TbnJ1fF9MlU+qd8TjbBuWg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AHrq8kSl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712323086;
	bh=4UbLO7lqaogdR2vuWoUgGqxgSzmMr2ERqnh0qUwJN1c=;
	h=From:To:Cc:Subject:Date:From;
	b=AHrq8kSlq1aG9c3JqXCk/CjohzvMokWqKkE4jTNPZ4c7f0paP5yp9XtqocOF9dV9M
	 8u9PiubybEPiJMu6RrWwidxQbxKUW60U8cEgSkfuVhGZ8UDhKhTvOVFAGyvjYkX1yL
	 w8fAXSQfJS/0F+BU3DL5fPtaUQ6Zyv7VEcPfL3oG4QmtjwpYW3C2XqohykdD/TplV7
	 bMN5FFBc50adYYgMQ9XBUAUGeWc9piPdG5nmWzoAvaRETSXrnz8dYBbnr1ejd0WvGg
	 MPFt0J6u27S7SZbjTfxqLocEV6SytWLeQVuB9WXt+xXxowO+H4rAvQq1RoGwiysJuk
	 nQz7zM7Oh4W1g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25A323782128;
	Fri,  5 Apr 2024 13:18:03 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in ksft_exit_fail_msg()
Date: Fri,  5 Apr 2024 18:17:46 +0500
Message-Id: <20240405131748.1582646-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Bail out! " is not descriptive. It rather should be: "Failed: " and
then this added prefix doesn't need to be added everywhere. Usually in
the logs, we are searching for "Failed" or "Error" instead of "Bail
out" so it must be replace.

Remove Error/Failed prefixes from all usages as well.

Muhammad Usama Anjum (2):
  selftests: Replace "Bail out" with "Error"
  selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages

 tools/testing/selftests/exec/load_address.c   |   8 +-
 .../testing/selftests/exec/recursion-depth.c  |  10 +-
 tools/testing/selftests/kselftest.h           |   2 +-
 .../selftests/mm/map_fixed_noreplace.c        |  24 +--
 tools/testing/selftests/mm/map_populate.c     |   2 +-
 tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
 .../selftests/mm/split_huge_page_test.c       |   2 +-
 8 files changed, 108 insertions(+), 108 deletions(-)

-- 
2.39.2


