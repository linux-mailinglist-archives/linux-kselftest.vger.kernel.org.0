Return-Path: <linux-kselftest+bounces-12141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1390CC1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED5028460C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7515B132;
	Tue, 18 Jun 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGKRw9mL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEA15B122;
	Tue, 18 Jun 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714235; cv=none; b=IWZdTxSNUpFwgulAdgRobhf7ssDBeD0rBIhLF5VzTlD8SSNhLoe9bIUMcHBXb8fDjEqduUzrc/5CzPO+A+S7Z+0WuEp7nlQ+N7gXumJjS5CzVMPvfafSpIXBWdb4gPDnLwIJTkL96sjX/919saeUNwfd80eDzq7PuKp/gz3jf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714235; c=relaxed/simple;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRFzSuUzxLv22C8sLILSNDFMeL8ytPzS/+qcZx4ECg30bilC58dSdIFF+o+f94cxldSh209XAFFHxR4kfukrjtuH1vHqKuFU43VMWGeJOQyAYClR0E73p3XI9QTTBVOPrsWv4hP4urgo4idPxEQjEITf6g6HizZCkrat28q6Onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGKRw9mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB4FC3277B;
	Tue, 18 Jun 2024 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714235;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGKRw9mLrnIUP1LWY7PYMiXelTsdfK1GC3TMaOsO/iod5zcMqsO9M4v/4RYr27Tpc
	 l2BCDPcfSyezVvlTkTouoFOBtKOFI59kBwiGmaeNzQjUdvzR7Hv7zVDUEynx2YAmLB
	 j1PnrPYPf6Mq87Cyb5M6JJQLyuASekWHQzyA3k04pPFcfFw0VX/jW9x4GuEaDZs2au
	 4DSYko5FijUOC0eY4rKlNl89VvJ2e53t+rbMZOinjkq7zhQ97/O3I8YJm1tP17qisw
	 IQGYVNDcjslGX7NqtrJ/28a726jLHzmPl19cEpG8gdPpkvYrJuhD/xBftEPSFhTxDO
	 R1Uxb/O0xxLXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	maciej.wieczor-retman@intel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 26/44] selftests/openat2: Fix build warnings on ppc64
Date: Tue, 18 Jun 2024 08:35:07 -0400
Message-ID: <20240618123611.3301370-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 84b6df4c49a1cc2854a16937acd5fd3e6315d083 ]

Fix warnings like:

  openat2_test.c: In function ‘test_openat2_flags’:
  openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
  ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/openat2/openat2_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b23..5790ab446527f 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.43.0


