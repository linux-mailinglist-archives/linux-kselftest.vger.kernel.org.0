Return-Path: <linux-kselftest+bounces-4986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD085AFEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 01:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9601C21C68
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB9812;
	Tue, 20 Feb 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpeb478p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4880367;
	Tue, 20 Feb 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387384; cv=none; b=LB6yqZDmzGfJJb/8gEY5pSiXO99sMQQcKscIEnMi1LBBbP2qriWeqCNW/M/S52KbEqVVYUNbTC4B4wWVpIa6tUDNbr6cFLPTLYcQ19JVsag1yQ7tYef+Qteb43rhopm/xhiYu+gBeuFpbEyJuSVJ5vzXhLZqc10Zfs5Uw5clDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387384; c=relaxed/simple;
	bh=dhsl+4DUfohdUgGLuOiNaC3zP62O+fjZLWuDaWPEMvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/gJxGny5XWvVAqISABAHrvUCA+/hrak5yb6BZhzLpz5Z6/1xAxKfRXd0qfDkx4cB0mUyEKLIem1D7SPCScfoYvUzH6AsMpizewMfZuvMRy6T2AMZvsR9jvG6Lr0lmfp5eTvwl1q5rLwf+heLRCMIOsjxa3tdB9tSW9B5gF3Qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpeb478p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71373C433C7;
	Tue, 20 Feb 2024 00:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708387384;
	bh=dhsl+4DUfohdUgGLuOiNaC3zP62O+fjZLWuDaWPEMvw=;
	h=From:To:Cc:Subject:Date:From;
	b=hpeb478p7gkVzVFGnMeOhVmdP/mfbmEI+l+LD5qm9S5k+wP7qboD32jLrIJGVS3oR
	 NGAXx+OEU3pogFJ96mlDJFyqOIORl9tVl+n58Yo05HPNMQy7sgn5BstDugzQhPtprp
	 MuW+EQ2ktd/uLZrnDDUstj4UA0yLJtCFU6U/+Z1QBbYIQUOH7gbwOWCH0cq1huhy4s
	 HaNPdBOaFeyf+BFKPuytq80yc9VmvLks3T/46C4sT3BKwQMj+5DQ6pbmAs0mEbCf8/
	 qdONh6snixOAKcXoDz+Sbu9Yzu+dTq0cxrrgZqY8ljbjP9nAsIFleVtDbedCleIkD+
	 HuvrjyLi3KCXg==
From: SeongJae Park <sj@kernel.org>
To: shuah@kernel.org
Cc: ryan.roberts@arm.com,
	abuehaze@amazon.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] selftests/mqueue: Set timeout to 180 seconds
Date: Mon, 19 Feb 2024 16:02:43 -0800
Message-Id: <20240220000243.162285-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While mq_perf_tests runs with the default kselftest timeout limit, which
is 45 seconds, the test takes about 60 seconds to complete on i3.metal
AWS instances.  Hence, the test always times out.  Increase the timeout
to 100 seconds.

Link: https://lore.kernel.org/r/20240208212925.68286-1-sj@kernel.org
Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes from v1
(https://lore.kernel.org/r/20240208212925.68286-1-sj@kernel.org)
- Use 180 seconds timeout instead of 100 seconds

 tools/testing/selftests/mqueue/setting | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mqueue/setting

diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
new file mode 100644
index 000000000000..a953c96aa16e
--- /dev/null
+++ b/tools/testing/selftests/mqueue/setting
@@ -0,0 +1 @@
+timeout=180
-- 
2.39.2


