Return-Path: <linux-kselftest+bounces-11539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A72901A49
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDD51F210BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E8B665;
	Mon, 10 Jun 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lXwMczfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28EF9CC;
	Mon, 10 Jun 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998059; cv=none; b=Z81Vvq4UXWudLt8Y87lEueGyc5yANiVwngZgmdwGfbaRQGLJycwVTOV8BImAOX6GwOuG0Ox+e57GMhscEyalyZWdonldpTpH1kO8P6IFIZ/OPhlL40HbNfnxaCPbNN2pQDVUtn1w3zx5i35GBOjc1WLUJjlcsUWZBbKkqxwE4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998059; c=relaxed/simple;
	bh=OBG6SfOQ/QmwOegTMeGSbKlX9wcudmDD8vev5Os7k7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bB16Ba00nsmj2QHFRJf9hc7vkAsL9URM1S5nVXrljHrtQ8PApgoh3gctMm9gAyn8KBlc2RliteoGZCtnIo3Ez8vJfhf5iio8bRyWMMN0CEwlBRuqjmoA9AlOBuM4y+eC8YrGEVUSj1+SR3Kloog0O4CEocv2nIGLIqwQMMTuYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lXwMczfM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717998056;
	bh=OBG6SfOQ/QmwOegTMeGSbKlX9wcudmDD8vev5Os7k7g=;
	h=From:To:Cc:Subject:Date:From;
	b=lXwMczfM+rrSOsKMc20YlrHAd+nyvjqUklipHbNh2NOkB+bRue8mxFu4IFW8RUfH6
	 bwFZlCotE/tPlja9dakQ//Ot/bdQBAiygokyDuXqP8b3cjEj1/tAauwo05+CQuhq4X
	 Tb6QozrxOVpoks1O9Qpgq185gE2bYYLMLX+MIfo/ULzATicSN2p0WHlxlFlBGpHBmW
	 1jGZZ5hV7bVWLoiYRUC+gqCe6yUg8WALYxCPuThLzvBcAId8gxCzuPi65AOEcrBnmx
	 sIy9eZYm2QHoi7526jbMpZDxd5t4PRCqRBRmF9xrBhi0jX8ob/nYHJYQZlHShlMnCW
	 LZY5qhRB0MAKw==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1859B3782009;
	Mon, 10 Jun 2024 05:40:53 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH v2 0/4] kselftests: vdso: conform tests to TAP output
Date: Mon, 10 Jun 2024 10:41:25 +0500
Message-Id: <20240610054129.1527389-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform individual tests to TAP output. One patch conform one test. With
this series, all vDSO tests become TAP conformant.

First patch conform the test by using kselftest_harness.h. Other patches
are conforming using default kselftest.h helpers.

All tests have been tested multiple times before and after these
patches. They are working correctly and outputting TAP messaging to find
failures quikly when they happen.
---
Changes since v1:
- Update cover letter
- Update commit message of first patch

Muhammad Usama Anjum (4):
  kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
  kselftests: vdso: vdso_test_correctness: conform test to TAP output
  kselftests: vdso: vdso_test_getcpu: conform test to TAP output
  kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output

 .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
 .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
 .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
 .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
 4 files changed, 126 insertions(+), 127 deletions(-)

-- 
2.39.2


