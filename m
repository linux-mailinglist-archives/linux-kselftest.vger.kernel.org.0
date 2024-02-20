Return-Path: <linux-kselftest+bounces-4988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C085AFF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 01:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A710283FFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC0179;
	Tue, 20 Feb 2024 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cobi/0Q5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7711ED0;
	Tue, 20 Feb 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387686; cv=none; b=PFK11AVavgulwiA3j7Kmuv2AgZ/8DM3mpRarzvHenT4fAXBP6oyHHeD1sITDvW5iBkNy1QmyLxo9ZCoOucUsEW3yBWDV7ReHF526s1El9kQK+TgC16OgIJyj6LjsmgbpZ7GcIUny+xCukSKYsP/WEiInipQBZeWuiGBMzF/aCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387686; c=relaxed/simple;
	bh=E0AOuvGysAaJobQXzkk4JFvOSeT/8IQZKbw+Y9BzdZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sfnb6ajXjms7l0H7QBaO95UGEJBRbhG5qTECJRPquf6ouiY/qWZeg3O+iOeewnXc6PFAMu+J5JbHt3zYRagbLj913LlhJ/zkvfZxQXvwyXNd4m8Jg6UMMV9ecA3MGMWhPblQ02kcVcc066Km6b1LhOYruEdSeaVSr7ayTHcj7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cobi/0Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E3BC433F1;
	Tue, 20 Feb 2024 00:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708387685;
	bh=E0AOuvGysAaJobQXzkk4JFvOSeT/8IQZKbw+Y9BzdZE=;
	h=From:To:Cc:Subject:Date:From;
	b=cobi/0Q5kpXHokftZyEnkYIX4IkgNm3ysOB+CoWVmucm/djObYaEBqbrtlKybv90h
	 60AaopwN3B3K/7Uoj4SiwBL6CL6W+1dw09i8o/3vsgMKJTB88W4shgppVHZ3ozjXEP
	 6bLnkX3mY9kluR849oEQRR3kZ4/AVBqOZbnXHb0poUeprntUYPLKJrT7tDPMTqCa7B
	 BVbHbPfUZgPL8ATllMsjJlISlDH5UIHxTQbIYoCeyy0vU+EK+EZ4OfEUTdcTeaojuc
	 stU/8L/fnccIDV9/+f3p/NPIjqaEQAD8+3H0zOiK1QR8GigS7QObTCM9XUMPU0Wphc
	 b/lFJ3J4Ombxw==
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
Subject: [PATCH v3] selftests/mqueue: Set timeout to 180 seconds
Date: Mon, 19 Feb 2024 16:08:02 -0800
Message-Id: <20240220000802.162556-1-sj@kernel.org>
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
to 180 seconds.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes from v2
(https://lore.kernel.org/r/20240220000243.162285-1-sj@kernel.org)
- Update commit message about the new timeout limit to 180 seconds
- Remove wrong Link: line

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


