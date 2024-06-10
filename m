Return-Path: <linux-kselftest+bounces-11545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D3901CFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E151F217CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB055887;
	Mon, 10 Jun 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NjxkHvBS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650A3BBC5;
	Mon, 10 Jun 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008369; cv=none; b=upUp4WDkeuqor2PgbGjdRUOgLdYIQ6Br99HEXTyWhYHCpfn46gnj9+Gg5VSQw/yUDPc1VCFTbh+FUcMqn5HR+vi7eyAQezHvrurY++x0qsYUoBxYzo6IU4wIoSlL65iJyZRonYr8a3KYgqswBgWNUFLOURxWIAVRSYXuyIAsrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008369; c=relaxed/simple;
	bh=qwlTEAsrFOsgcn64/ZD8Sup2dFP172zw2LGV9PDNcEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pddjFUD88GIZLjC6V+o2vukOtLse7Q6Cdv1Hs6bYOIxs//0dYvl8B/AfL6p1vsx/d9QGpC/xhTssSvLX0hiaB3TPcqjbBJNqDB3kyRPabDtcmxiNibQ+HzHNXQy7+V2pwUR1LoYOLci+YNlgLGOIykB22a/2Lnjj6vC6EwwlCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NjxkHvBS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718008366;
	bh=qwlTEAsrFOsgcn64/ZD8Sup2dFP172zw2LGV9PDNcEU=;
	h=From:To:Cc:Subject:Date:From;
	b=NjxkHvBSnt6ozcEI8ys9Px1t4oDvsuMqcwRDSZYUDqjnEVCaXtZiWI9pvBsaUqSed
	 XrDPuxmeLt/nPS9vhZgEs8AkKbTOaZKiSLbW1g5R4hIGDoWsK/2r0aKMiWn/NAL+FP
	 tm4T7pOsKabjQjqrJtEz8l5D1l7BFZWQDEty7aMXARPIglKv+QCR9ajdtA3m8kP32Q
	 0D9m/9c0c8IFvCOZHBs5DuFZMQ51Y+/NqGi0LJiDw1LXcTcVyFERnqm90ekK6sa89f
	 iyReNIOIqwqc8V789WoCl2JfXBKh9UnBj4t0ZAV+DqHmbPZ/xDREezLgCF2AY8N1Ki
	 V037v+4RBt/xQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7401A3782113;
	Mon, 10 Jun 2024 08:32:44 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Add information about TAP conformance in tests
Date: Mon, 10 Jun 2024 13:32:45 +0500
Message-Id: <20240610083245.1938001-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although "TAP" word is being used already in documentation, but it hasn't
been defined in informative way for developers that how to write TAP
conformant tests and what are the benefits. Write a short brief about it.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 Documentation/dev-tools/kselftest.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index dcf634e411bd9..b579f491f3e97 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -228,6 +228,14 @@ In general, the rules for selftests are
  * Don't cause the top-level "make run_tests" to fail if your feature is
    unconfigured.
 
+ * The output of tests must conform to the TAP standard to ensure high
+   testing quality and to capture failures/errors with specific details.
+   The kselftest.h and kselftest_harness.h headers provide wrappers for
+   outputting test results such as pass, fail, or skip etc. These wrappers
+   should be used instead of reinventing the wheel or using raw printf and
+   exit statements. CI systems can easily parse TAP output messages to
+   detect test failures.
+
 Contributing new tests (details)
 ================================
 
-- 
2.39.2


