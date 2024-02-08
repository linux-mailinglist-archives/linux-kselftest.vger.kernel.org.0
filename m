Return-Path: <linux-kselftest+bounces-4373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A384EA82
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2D1F22530
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850394F1EB;
	Thu,  8 Feb 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd9bwZz0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582364F5EC;
	Thu,  8 Feb 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427774; cv=none; b=ZxXmvR6s5vZPcagOurlzr6wtqa64a0QxdsEWfg3azyhYvlkEFZLds1vzZBmEFt4RAvmEs/SeCwKtdgHc5Lh+yL20XnZP/cF4+YHDeK8aQnNJlE9EkaHDldMVv49N/8MkpPjUyJJ5nAuji/E7SEOTNu13otLEBBfLa/usOEorxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427774; c=relaxed/simple;
	bh=YXw+TEHL3D7AVQ+U9ym9qWi5wUyYZTB8xY8EFuYW8e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qnK0TRDfvX7qJ/VgFNt52LTbwlSx4O/wRy0yHdUqQhdlw1O9D30qr7KarKWyUxDTfewHgG9dP0+SG7l0lZEpRmpBSYvaXcyuskriRjoc7My29YfrcKRJe7jNMjrguo17McWspKeijFPE6IMey190CT5kRB8Qnm4Tah/YR+KUs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd9bwZz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC71C433F1;
	Thu,  8 Feb 2024 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427774;
	bh=YXw+TEHL3D7AVQ+U9ym9qWi5wUyYZTB8xY8EFuYW8e4=;
	h=From:To:Cc:Subject:Date:From;
	b=Nd9bwZz0Jql8dlhoyYZqB5bSOT4LaLsuWQWnJtcCvsTvSwgTGgP4jWTws5HwiwPCF
	 CoyPD0RSPf1eXsN+ynVL6GrQONA8Hc8P9YcScuLiLMrpjfuo8R/WhR1h3MDATkqkfT
	 eKNYajZgFnwDPoVWSSoMrNVd+5hdl7wU7AiX8NwHPmpf6RP82FImOPwxhxqGu4loQt
	 gf6NTXfN3SrkljNWiZIrcY6kflp3p131xf1PAfJutto6q8+DXOziclIV+E0CJs8Usg
	 qt7UIr5uju1YsKdjGASZ4D5tiaiKvKySgCEedkLWqerMNbmVLIagMWYryAwMc5Kijg
	 hhDQir1sVXReQ==
From: SeongJae Park <sj@kernel.org>
To: shuah@kernel.org
Cc: keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Date: Thu,  8 Feb 2024 13:29:25 -0800
Message-Id: <20240208212925.68286-1-sj@kernel.org>
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

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/mqueue/setting | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/mqueue/setting

diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
new file mode 100644
index 000000000000..54dc12287839
--- /dev/null
+++ b/tools/testing/selftests/mqueue/setting
@@ -0,0 +1 @@
+timeout=100
-- 
2.39.2


